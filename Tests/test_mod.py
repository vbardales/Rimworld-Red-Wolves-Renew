"""Offline tests of Red Wolves Renew: XML, load conditions, and the real patch files applied to fixtures.

    uv run --with lxml python Tests/test_mod.py

Standard XPath 1.0 through lxml, evaluated from the document node as the game does. Each patch is run
with the target present and absent, on a list or extension that already exists, and (for the A Dog Said
predicate) next to a recipe it must not touch. Every check prints PASS or FAIL; the exit code is the
number of failures.
"""
import copy
import glob
import os
import sys

from lxml import etree

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MOD = os.path.join(ROOT, "Mod")
failures = []


def check(name, ok, detail=""):
    print(("PASS " if ok else "FAIL ") + name + ((" - " + detail) if detail and not ok else ""))
    if not ok:
        failures.append(name)


def apply_op(op, doc):
    cls = op.get("Class")
    xpath = op.findtext("xpath")
    if xpath and not xpath.startswith("/"):
        xpath = "/" + xpath
    if cls == "PatchOperationSequence":
        for o in op.find("operations"):
            apply_op(o, doc)
    elif cls == "PatchOperationConditional":
        branch = op.find("match") if doc.xpath(xpath) else op.find("nomatch")
        if branch is not None:
            apply_op(branch, doc)
    elif cls == "PatchOperationAdd":
        for t in doc.xpath(xpath):
            for v in op.find("value"):
                t.append(copy.deepcopy(v))
    elif cls == "PatchOperationReplace":
        for t in doc.xpath(xpath):
            parent = t.getparent()
            for v in op.find("value"):
                parent.insert(parent.index(t), copy.deepcopy(v))
            parent.remove(t)
    elif cls == "PatchOperationAddModExtension":
        for t in doc.xpath(xpath):
            m = t.find("modExtensions")
            if m is None:
                m = etree.SubElement(t, "modExtensions")
            for v in op.find("value"):
                m.append(copy.deepcopy(v))
    elif cls == "PatchOperationFindMod":
        apply_op(op.find("match"), doc)
    else:
        raise SystemExit("patch operation not implemented in this test: " + cls)


def run_patch(path, xml, mod_present=True):
    doc = etree.ElementTree(etree.fromstring(xml))
    for op in etree.parse(path).getroot().findall("Operation"):
        if op.get("Class") == "PatchOperationFindMod" and not mod_present:
            continue
        apply_op(op, doc)
    return doc


def text(doc, xpath):
    return [e.text for e in doc.xpath(xpath)]


# 1. Every XML file of the mod is well formed.
bad = []
for f in glob.glob(MOD + "/**/*.xml", recursive=True):
    try:
        etree.parse(f)
    except etree.XMLSyntaxError as e:
        bad.append(f + ": " + str(e))
check("every XML file is well formed", not bad, "; ".join(bad))

# 2. The race and the kind carry the values the original shipped.
races = etree.parse(MOD + "/Defs/Races_Animal_RedWolf.xml")
check("Wolf_Red ThingDef: baseBodySize 0.68, maxPreyBodySize 1.8",
      text(races, "/Defs/ThingDef[defName='Wolf_Red']/race/baseBodySize") == ["0.68"]
      and text(races, "/Defs/ThingDef[defName='Wolf_Red']/race/maxPreyBodySize") == ["1.8"])
check("Wolf_Red ThingDef: ComfyTemperatureMin -25, FilthRate 1.6",
      text(races, "/Defs/ThingDef[defName='Wolf_Red']/statBases/ComfyTemperatureMin") == ["-25"]
      and text(races, "/Defs/ThingDef[defName='Wolf_Red']/statBases/FilthRate") == ["1.6"])
check("Wolf_Red ThingDef: wild in five biomes",
      sorted(e.tag for e in races.xpath("/Defs/ThingDef[defName='Wolf_Red']/race/wildBiomes/*"))
      == ["AridShrubland", "BorealForest", "ColdBog", "TemperateForest", "TemperateSwamp"])
check("Wolf_Red PawnKindDef: three alternate coats at 0.8",
      len(races.xpath("/Defs/PawnKindDef[defName='Wolf_Red']/alternateGraphics/li")) == 3
      and text(races, "/Defs/PawnKindDef[defName='Wolf_Red']/alternateGraphicChance") == ["0.8"])
check("Wolf_Red PawnKindDef: race is Wolf_Red",
      text(races, "/Defs/PawnKindDef[defName='Wolf_Red']/race") == ["Wolf_Red"])

# 3. The textures the defs name exist (three rotations are shipped for the body; paths are Mod-relative).
tex_missing = []
for e in races.xpath("//texPath"):
    base = os.path.join(MOD, "Textures", e.text.replace("/", os.sep))
    if not (glob.glob(base + ".png") or glob.glob(base + "_*.png")):
        # vanilla paths (the dessicated timber wolf) are not ours
        if "Wolf_Timber" in e.text:
            continue
        tex_missing.append(e.text)
check("every texPath of the mod resolves to a shipped texture", not tex_missing, ", ".join(tex_missing))

# 4. About.xml and LoadFolders.xml.
about = etree.parse(MOD + "/About/About.xml")
check("About.xml: packageId nelim.redwolves", text(about, "/ModMetaData/packageId") == ["nelim.redwolves"])
check("About.xml: no hard dependency", not about.xpath("/ModMetaData/modDependencies"))
check("About.xml: loadBefore A Dog Said 2",
      text(about, "/ModMetaData/loadBefore/li") == ["SamBucher.ADogSaidAnimalProsthetics2"])
check("About.xml: description names no RimWorld version",
      not any(v in (about.getroot().findtext("description") or "") for v in ("1.6", "1.7")))
lf = etree.parse(MOD + "/LoadFolders.xml")
guards = {e.text: e.get("IfModActive") for e in lf.xpath("/loadFolders/v1.6/li")}
check("LoadFolders: Pawnmorpher folder guarded by tachyonite.pawnmorpherpublic only",
      guards.get("ModIntegrations/Pawnmorpher") == "tachyonite.pawnmorpherpublic")
check("LoadFolders: every named folder exists",
      all(os.path.isdir(os.path.join(MOD, n)) for n in guards if n != "/"))

# 5. A Dog Said 2: the red wolf joins all three lists, touches no other recipe, and nothing without the mod.
ads = MOD + "/Patches/Addon_ADogSaid.xml"
ads_doc = b"""<Defs>
<RecipeDef Name="ADS_Cat1" Abstract="True"><recipeUsers><li>Wolf_Timber</li></recipeUsers></RecipeDef>
<RecipeDef Name="ADS_Cat2" Abstract="True"><recipeUsers><li>Wolf_Timber</li></recipeUsers></RecipeDef>
<RecipeDef Name="ADS_Cat3" Abstract="True"><recipeUsers><li>Wolf_Timber</li></recipeUsers></RecipeDef>
<RecipeDef Name="Other" Abstract="True"><recipeUsers><li>Husky</li></recipeUsers></RecipeDef>
</Defs>"""
d = run_patch(ads, ads_doc)
check("ADS 2: Wolf_Red added to ADS_Cat1, Cat2 and Cat3",
      all(text(d, f"/Defs/RecipeDef[@Name='{n}']/recipeUsers/li") == ["Wolf_Timber", "Wolf_Red"]
          for n in ("ADS_Cat1", "ADS_Cat2", "ADS_Cat3")))
check("ADS 2: an unrelated recipe is not touched", text(d, "/Defs/RecipeDef[@Name='Other']/recipeUsers/li") == ["Husky"])
absent = b"<Defs><RecipeDef Name='Other'><recipeUsers><li>Husky</li></recipeUsers></RecipeDef></Defs>"
check("ADS 2 absent: the document is unchanged",
      etree.tostring(run_patch(ads, absent).getroot()) == etree.tostring(etree.fromstring(absent)))

# 5b. The test can fail: the trap form of the predicate (a string literal after `or` is always true) selects
#     every recipe, so the unrelated one would receive the wolf. Proves check 5 is not vacuous.
trap = etree.fromstring(b"""<Operation Class="PatchOperationAdd"><xpath>/Defs/RecipeDef[@Name="ADS_Cat3" or "ADS_Cat2"]/recipeUsers</xpath>
<value><li>Wolf_Red</li></value></Operation>""")
trap_doc = etree.ElementTree(etree.fromstring(ads_doc))
apply_op(trap, trap_doc)
check("ADS 2: the trap predicate would reach the unrelated recipe (the check above can fail)",
      text(trap_doc, "/Defs/RecipeDef[@Name='Other']/recipeUsers/li") == ["Husky", "Wolf_Red"])

# 6. Dogs mate: Wolf_Red joins the Wolf group only.
dm = MOD + "/Patches/Compat_DogsMate.xml"
dm_doc = b"""<Defs>
<Revolus.DogsMate.AnimalGroupDef><defName>Wolf</defName><pawnKinds><li>Wolf_Timber</li></pawnKinds></Revolus.DogsMate.AnimalGroupDef>
<Revolus.DogsMate.AnimalGroupDef><defName>Dog</defName><pawnKinds><li>Husky</li></pawnKinds></Revolus.DogsMate.AnimalGroupDef>
</Defs>"""
d = run_patch(dm, dm_doc)
check("Dogs mate: Wolf_Red in the Wolf group, after Wolf_Timber",
      text(d, "/Defs/Revolus.DogsMate.AnimalGroupDef[defName='Wolf']/pawnKinds/li") == ["Wolf_Timber", "Wolf_Red"])
check("Dogs mate: the Dog group is not touched",
      text(d, "/Defs/Revolus.DogsMate.AnimalGroupDef[defName='Dog']/pawnKinds/li") == ["Husky"])
check("Dogs mate absent: the document is unchanged",
      etree.tostring(run_patch(dm, absent).getroot()) == etree.tostring(etree.fromstring(absent)))

# 7. Better Crossbreeding: both halves, both ways, existing content kept, nothing without the mod.
bc = MOD + "/Patches/Compat_BetterCrossbreeding.xml"
bc_doc = b"""<Defs>
<ThingDef><defName>Wolf_Red</defName><race/></ThingDef>
<ThingDef><defName>Wolf_Timber</defName><race><canCrossBreedWith><li>Dog_X</li></canCrossBreedWith></race></ThingDef>
<PawnKindDef><defName>Wolf_Red</defName></PawnKindDef>
<PawnKindDef><defName>Wolf_Timber</defName><modExtensions><li Class="DZY.CrossBreeding.Extension"><outcomes><Dog_X><Random/></Dog_X></outcomes></li></modExtensions></PawnKindDef>
</Defs>"""
d = run_patch(bc, bc_doc)
check("Better Crossbreeding: list created on Wolf_Red", text(d, "/Defs/ThingDef[defName='Wolf_Red']/race/canCrossBreedWith/li") == ["Wolf_Timber"])
check("Better Crossbreeding: Wolf_Timber's list appended, not replaced",
      text(d, "/Defs/ThingDef[defName='Wolf_Timber']/race/canCrossBreedWith/li") == ["Dog_X", "Wolf_Red"]
      and len(d.xpath("/Defs/ThingDef[defName='Wolf_Timber']/race/canCrossBreedWith")) == 1)
ext = "/Defs/PawnKindDef[defName='%s']/modExtensions/li[@Class='DZY.CrossBreeding.Extension']/outcomes/%s/Random"
check("Better Crossbreeding: Random outcome Wolf_Red x Wolf_Timber, both ways",
      len(d.xpath(ext % ("Wolf_Red", "Wolf_Timber"))) == 1 and len(d.xpath(ext % ("Wolf_Timber", "Wolf_Red"))) == 1)
check("Better Crossbreeding: Wolf_Timber keeps its existing outcome", len(d.xpath(ext % ("Wolf_Timber", "Dog_X"))) == 1)
check("Better Crossbreeding: one extension per kind",
      all(len(d.xpath("/Defs/PawnKindDef[defName='%s']/modExtensions/li[@Class='DZY.CrossBreeding.Extension']" % n)) == 1
          for n in ("Wolf_Red", "Wolf_Timber")))
bc_classes = set(etree.parse(bc).xpath("//@Class[starts-with(., 'DZY.')]"))
check("Better Crossbreeding: the class is spelled DZY.CrossBreeding.Extension (capital B)",
      bc_classes == {"DZY.CrossBreeding.Extension"}, str(bc_classes))
check("Better Crossbreeding absent: the document is unchanged",
      etree.tostring(run_patch(bc, absent, mod_present=False).getroot()) == etree.tostring(etree.fromstring(absent)))

# 8. Combat Extended: the statBases patch applies; the dead tools Replace of the original was removed.
ce = MOD + "/Patches/Addon_CombatExtended.xml"
ce_doc = b"<Defs><ThingDef><defName>Wolf_Red</defName><statBases/></ThingDef></Defs>"
d = run_patch(ce, ce_doc)
check("Combat Extended: melee chances added to Wolf_Red statBases", len(d.xpath("/Defs/ThingDef[defName='Wolf_Red']/statBases/MeleeDodgeChance")) == 1)
check("Combat Extended: the patch no longer replaces tools (the race declares none of its own)",
      "PatchOperationReplace" not in open(ce, encoding="utf-8").read()
      and not races.xpath("/Defs/ThingDef[defName='Wolf_Red']/tools"))

print()
print(("%d check(s) failed" % len(failures)) if failures else "all checks passed")
sys.exit(len(failures))
