# What only this mod asserts: the red wolf's own values, packageId and loadBefore, the Pawnmorpher folder guard, and the four real
# patches (A Dog Said 2, Dogs mate, Better Crossbreeding, Combat Extended) applied to fixtures with the target present and absent.
# The generic checks (XML well formed, texPath resolves, About.xml shape, translation coverage) are the shared scripts', run by Test-Mod.ps1.
# Takes -ModRoot (repository root) and -SharedDir (where lib/PatchEngine.ps1 is read); prints findings, exits 1 on any.
param([string]$ModRoot = (Join-Path $PSScriptRoot '..'), [string]$SharedDir)
$ErrorActionPreference = 'Stop'
$ModRoot = (Resolve-Path -LiteralPath $ModRoot).Path
$mod = Join-Path $ModRoot 'Mod'
$script:findings = New-Object System.Collections.Generic.List[string]
function Assert-True($Condition, [string]$Message) { if (-not $Condition) { $script:findings.Add("FAIL: $Message") } }

$engine = @((Join-Path $SharedDir 'lib/PatchEngine.ps1'), (Join-Path $ModRoot 'Tests/lib/PatchEngine.ps1')) | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
if (-not $engine) { Write-Host 'FAIL: PatchEngine.ps1 not found (scripts/lib of the protocols checkout, or Tests/lib)'; exit 1 }
. $engine

function New-Doc([string]$Xml) { $d = New-Object System.Xml.XmlDocument; $d.LoadXml($Xml); return $d }
function Get-Texts($Doc, [string]$XPath) { return @($Doc.SelectNodes($XPath) | ForEach-Object { $_.InnerText }) }
function Test-List($Doc, [string]$XPath, [string[]]$Expected) {
    $got = @(Get-Texts $Doc $XPath)
    return ($got.Count -eq $Expected.Count) -and (-not (Compare-Object $got $Expected -CaseSensitive))
}
function Invoke-Patch([string]$File, $Doc, [string[]]$ActiveMods = @()) { Invoke-PatchFile (Join-Path $mod "Patches/$File") $Doc -ActiveMods $ActiveMods }

# 1. The race and the kind carry the values the original shipped.
$races = New-Object System.Xml.XmlDocument
$races.Load((Join-Path $mod 'Defs/Races_Animal_RedWolf.xml'))
$t = "/Defs/ThingDef[defName='Wolf_Red']"
$k = "/Defs/PawnKindDef[defName='Wolf_Red']"
Assert-True ((Test-List $races "$t/race/baseBodySize" @('0.68')) -and (Test-List $races "$t/race/maxPreyBodySize" @('1.8'))) 'Wolf_Red ThingDef: baseBodySize 0.68, maxPreyBodySize 1.8'
Assert-True ((Test-List $races "$t/statBases/ComfyTemperatureMin" @('-25')) -and (Test-List $races "$t/statBases/FilthRate" @('1.6'))) 'Wolf_Red ThingDef: ComfyTemperatureMin -25, FilthRate 1.6'
$biomes = @($races.SelectNodes("$t/race/wildBiomes/*") | ForEach-Object { $_.Name } | Sort-Object)
Assert-True ((($biomes -join ',') -ceq 'AridShrubland,BorealForest,ColdBog,TemperateForest,TemperateSwamp')) 'Wolf_Red ThingDef: wild in five biomes'
Assert-True ((@($races.SelectNodes("$k/alternateGraphics/li")).Count -eq 3) -and (Test-List $races "$k/alternateGraphicChance" @('0.8'))) 'Wolf_Red PawnKindDef: three alternate coats at 0.8'
Assert-True (Test-List $races "$k/race" @('Wolf_Red')) 'Wolf_Red PawnKindDef: race is Wolf_Red'

# 2. About.xml and LoadFolders.xml.
$about = New-Object System.Xml.XmlDocument
$about.Load((Join-Path $mod 'About/About.xml'))
Assert-True (Test-List $about '/ModMetaData/packageId' @('nelim.redwolves')) 'About.xml: packageId nelim.redwolves'
Assert-True (@($about.SelectNodes('/ModMetaData/modDependencies/*')).Count -eq 0) 'About.xml: no hard dependency'
Assert-True (Test-List $about '/ModMetaData/loadBefore/li' @('SamBucher.ADogSaidAnimalProsthetics2')) 'About.xml: loadBefore A Dog Said 2'
$lf = New-Object System.Xml.XmlDocument
$lf.Load((Join-Path $mod 'LoadFolders.xml'))
$pm = $lf.SelectSingleNode("/loadFolders/v1.6/li[.='ModIntegrations/Pawnmorpher']")
Assert-True ($pm -and ($pm.GetAttribute('IfModActive') -ceq 'tachyonite.pawnmorpherpublic')) 'LoadFolders: Pawnmorpher folder guarded by tachyonite.pawnmorpherpublic only'
foreach ($li in $lf.SelectNodes('/loadFolders/v1.6/li')) {
    if ($li.InnerText -ne '/') { Assert-True (Test-Path -LiteralPath (Join-Path $mod $li.InnerText) -PathType Container) "LoadFolders: folder $($li.InnerText) exists" }
}

# 3. A Dog Said 2: the red wolf joins all three lists, touches no other recipe, and nothing without the mod.
$adsXml = @'
<Defs>
<RecipeDef Name="ADS_Cat1" Abstract="True"><recipeUsers><li>Wolf_Timber</li></recipeUsers></RecipeDef>
<RecipeDef Name="ADS_Cat2" Abstract="True"><recipeUsers><li>Wolf_Timber</li></recipeUsers></RecipeDef>
<RecipeDef Name="ADS_Cat3" Abstract="True"><recipeUsers><li>Wolf_Timber</li></recipeUsers></RecipeDef>
<RecipeDef Name="Other" Abstract="True"><recipeUsers><li>Husky</li></recipeUsers></RecipeDef>
</Defs>
'@
$d = New-Doc $adsXml
Invoke-Patch 'Addon_ADogSaid.xml' $d
foreach ($n in 'ADS_Cat1', 'ADS_Cat2', 'ADS_Cat3') {
    Assert-True (Test-List $d "/Defs/RecipeDef[@Name='$n']/recipeUsers/li" @('Wolf_Timber', 'Wolf_Red')) "ADS 2: Wolf_Red added to $n"
}
Assert-True (Test-List $d "/Defs/RecipeDef[@Name='Other']/recipeUsers/li" @('Husky')) 'ADS 2: an unrelated recipe is not touched'
$absentXml = "<Defs><RecipeDef Name='Other'><recipeUsers><li>Husky</li></recipeUsers></RecipeDef></Defs>"
$d = New-Doc $absentXml
Invoke-Patch 'Addon_ADogSaid.xml' $d
Assert-True ($d.OuterXml -ceq (New-Doc $absentXml).OuterXml) 'ADS 2 absent: the document is unchanged'

# 3b. The test can fail: the trap form of the predicate (a string literal after `or` is always true) selects every recipe,
#     so the unrelated one would receive the wolf. Proves check 3 is not vacuous.
$trap = New-Doc $adsXml
foreach ($n in $trap.SelectNodes('/Defs/RecipeDef[@Name="ADS_Cat3" or "ADS_Cat2"]/recipeUsers')) {
    $li = $trap.CreateElement('li'); $li.InnerText = 'Wolf_Red'; [void]$n.AppendChild($li)
}
Assert-True (Test-List $trap "/Defs/RecipeDef[@Name='Other']/recipeUsers/li" @('Husky', 'Wolf_Red')) 'ADS 2: the trap predicate would reach the unrelated recipe (check 3 can fail)'

# 4. Dogs mate: Wolf_Red joins the Wolf group only.
$dmXml = @'
<Defs>
<Revolus.DogsMate.AnimalGroupDef><defName>Wolf</defName><pawnKinds><li>Wolf_Timber</li></pawnKinds></Revolus.DogsMate.AnimalGroupDef>
<Revolus.DogsMate.AnimalGroupDef><defName>Dog</defName><pawnKinds><li>Husky</li></pawnKinds></Revolus.DogsMate.AnimalGroupDef>
</Defs>
'@
$d = New-Doc $dmXml
Invoke-Patch 'Compat_DogsMate.xml' $d
Assert-True (Test-List $d "/Defs/Revolus.DogsMate.AnimalGroupDef[defName='Wolf']/pawnKinds/li" @('Wolf_Timber', 'Wolf_Red')) 'Dogs mate: Wolf_Red in the Wolf group, after Wolf_Timber'
Assert-True (Test-List $d "/Defs/Revolus.DogsMate.AnimalGroupDef[defName='Dog']/pawnKinds/li" @('Husky')) 'Dogs mate: the Dog group is not touched'
$d = New-Doc $absentXml
Invoke-Patch 'Compat_DogsMate.xml' $d
Assert-True ($d.OuterXml -ceq (New-Doc $absentXml).OuterXml) 'Dogs mate absent: the document is unchanged'

# 5. Better Crossbreeding: both halves, both ways, existing content kept, nothing without the mod.
$bcXml = @'
<Defs>
<ThingDef><defName>Wolf_Red</defName><race/></ThingDef>
<ThingDef><defName>Wolf_Timber</defName><race><canCrossBreedWith><li>Dog_X</li></canCrossBreedWith></race></ThingDef>
<PawnKindDef><defName>Wolf_Red</defName></PawnKindDef>
<PawnKindDef><defName>Wolf_Timber</defName><modExtensions><li Class="DZY.CrossBreeding.Extension"><outcomes><Dog_X><Random/></Dog_X></outcomes></li></modExtensions></PawnKindDef>
</Defs>
'@
$d = New-Doc $bcXml
Invoke-Patch 'Compat_BetterCrossbreeding.xml' $d @('Better Crossbreeding')
Assert-True (Test-List $d "/Defs/ThingDef[defName='Wolf_Red']/race/canCrossBreedWith/li" @('Wolf_Timber')) 'Better Crossbreeding: list created on Wolf_Red'
Assert-True ((Test-List $d "/Defs/ThingDef[defName='Wolf_Timber']/race/canCrossBreedWith/li" @('Dog_X', 'Wolf_Red')) -and (@($d.SelectNodes("/Defs/ThingDef[defName='Wolf_Timber']/race/canCrossBreedWith")).Count -eq 1)) "Better Crossbreeding: Wolf_Timber's list appended, not replaced"
$ext = "/Defs/PawnKindDef[defName='{0}']/modExtensions/li[@Class='DZY.CrossBreeding.Extension']/outcomes/{1}/Random"
Assert-True ((@($d.SelectNodes(($ext -f 'Wolf_Red', 'Wolf_Timber'))).Count -eq 1) -and (@($d.SelectNodes(($ext -f 'Wolf_Timber', 'Wolf_Red'))).Count -eq 1)) 'Better Crossbreeding: Random outcome Wolf_Red x Wolf_Timber, both ways'
Assert-True (@($d.SelectNodes(($ext -f 'Wolf_Timber', 'Dog_X'))).Count -eq 1) 'Better Crossbreeding: Wolf_Timber keeps its existing outcome'
foreach ($n in 'Wolf_Red', 'Wolf_Timber') {
    Assert-True (@($d.SelectNodes("/Defs/PawnKindDef[defName='$n']/modExtensions/li[@Class='DZY.CrossBreeding.Extension']")).Count -eq 1) "Better Crossbreeding: one extension on $n"
}
$bcPatch = New-Doc (Get-Content (Join-Path $mod 'Patches/Compat_BetterCrossbreeding.xml') -Raw)
$bcClasses = @($bcPatch.SelectNodes("//@Class[starts-with(., 'DZY.')]") | ForEach-Object { $_.Value } | Sort-Object -Unique)
Assert-True (($bcClasses -join ',') -ceq 'DZY.CrossBreeding.Extension') "Better Crossbreeding: the class is spelled DZY.CrossBreeding.Extension (capital B), got: $($bcClasses -join ',')"
$d = New-Doc $absentXml
Invoke-Patch 'Compat_BetterCrossbreeding.xml' $d
Assert-True ($d.OuterXml -ceq (New-Doc $absentXml).OuterXml) 'Better Crossbreeding absent: the document is unchanged'

# 6. Combat Extended: the statBases patch applies; the dead tools Replace of the original was removed.
$d = New-Doc '<Defs><ThingDef><defName>Wolf_Red</defName><statBases/></ThingDef></Defs>'
Invoke-Patch 'Addon_CombatExtended.xml' $d @('Combat Extended')
Assert-True (@($d.SelectNodes("/Defs/ThingDef[defName='Wolf_Red']/statBases/MeleeDodgeChance")).Count -eq 1) 'Combat Extended: melee chances added to Wolf_Red statBases'
Assert-True ((-not (Select-String -LiteralPath (Join-Path $mod 'Patches/Addon_CombatExtended.xml') -Pattern 'PatchOperationReplace' -Quiet)) -and (@($races.SelectNodes("$t/tools")).Count -eq 0)) 'Combat Extended: the patch no longer replaces tools (the race declares none of its own)'
$d = New-Doc '<Defs><ThingDef><defName>Wolf_Red</defName><statBases/></ThingDef></Defs>'
Invoke-Patch 'Addon_CombatExtended.xml' $d
Assert-True (@($d.SelectNodes("/Defs/ThingDef[defName='Wolf_Red']/statBases/*")).Count -eq 0) 'Combat Extended absent: statBases unchanged'

if ($script:findings.Count) { $script:findings | ForEach-Object { Write-Host $_ }; exit 1 }
Write-Host 'Rule-OwnValues: all checks passed'
