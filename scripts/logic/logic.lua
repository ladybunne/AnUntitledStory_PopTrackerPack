function Has(item, amount)
  local count = Tracker:ProviderCountForCode(item)
  amount = tonumber(amount)
  if not amount then
    return count > 0
  else
    return count >= amount
  end
end

function JumpHeight()
  local jump = Tracker:ProviderCountForCode("jump")
  local doublejump = Tracker:ProviderCountForCode("doublejump")

  if jump == 3 and doublejump == 1 then
    return 6.5
  else
    return jump + doublejump + 2
  end
end

function JumpHeightMin(amount)
  return JumpHeight() >= tonumber(amount)
end

function CanLightTorches()
  return Has("fireshot") or Has("divebomb")
end

-- A brief note on shops: 
-- The way I'm doing logic for them is twofold:
--   1. If it costs less than 100 crystals it's always considered in logic, since farming
--      that many crystals is pretty trivial.
--   2. If it costs 100 crystals or more, it requires enough crystals to buy out the entire shop.
--      This is so that people can't screw themselves logically by buying the "wrong" item or whatever.
-- 
-- I may revise either or both of these at any time.

function CrystalCount()
  local crystal_count = 0

  -- It's ugly, but it works.
  crystal_count = crystal_count + 10 * Tracker:ProviderCountForCode("10crystals")
  crystal_count = crystal_count + 25 * Tracker:ProviderCountForCode("25crystals")
  crystal_count = crystal_count + 35 * Tracker:ProviderCountForCode("35crystals")
  crystal_count = crystal_count + 50 * Tracker:ProviderCountForCode("50crystals")
  crystal_count = crystal_count + 65 * Tracker:ProviderCountForCode("65crystals")
  crystal_count = crystal_count + 75 * Tracker:ProviderCountForCode("75crystals")
  crystal_count = crystal_count + 100 * Tracker:ProviderCountForCode("100crystals")
  crystal_count = crystal_count + 110 * Tracker:ProviderCountForCode("110crystals")
  crystal_count = crystal_count + 125 * Tracker:ProviderCountForCode("125crystals")
  crystal_count = crystal_count + 150 * Tracker:ProviderCountForCode("150crystals")
  crystal_count = crystal_count + 180 * Tracker:ProviderCountForCode("180crystals")
  crystal_count = crystal_count + 200 * Tracker:ProviderCountForCode("200crystals")
  crystal_count = crystal_count + 235 * Tracker:ProviderCountForCode("235crystals")
  crystal_count = crystal_count + 245 * Tracker:ProviderCountForCode("245crystals")
  crystal_count = crystal_count + 270 * Tracker:ProviderCountForCode("270crystals")
  crystal_count = crystal_count + 300 * Tracker:ProviderCountForCode("300crystals")
  crystal_count = crystal_count + 400 * Tracker:ProviderCountForCode("400crystals")

  return crystal_count
end

function CanBuyEverythingInShop()
  return CrystalCount() > 1167
end

-- Zone access rules

function BlackCastle()
  return LongBeach()
end

function BlackCastleOOL()
  return LongBeachOOL()
end

function BlancLand()
  return DeepDive()
end

function BlancLandOOL()
  return DeepDiveOOL()
end

-- Not currently used due to fiddly out-of-logic FireCage red energy skip stuff
function Bonus()
  return FireCageInner()
end

function BonusOOL()
  return FireCageInnerOOL()
end

function Bottom()
  return FarFallLowerLeft() and Has("ceilingstick", 2)
end

function CloudRun()
  return Bottom()
end

function ColdKeep()
  return DeepTower()
end

function TheCurtain()
  return HighLands() and Has("ceilingstick", 2) and Has("yellowenergy")
end

function TheCurtainOOL()
  return HighLandsOOL() and Has("ceilingstick", 2) and Has("yellowenergy")
end

function DarkGrotto()
  return HighLands() and Has("divebomb")
end

function DarkGrottoOOL()
  return HighLandsOOL() and Has("divebomb")
end

function DeepDive()
  return GrottoUpper() and Has("divebomb")
end

function DeepDiveOOL()
  return GrottoUpperOOL() and Has("divebomb")
end

function DeepTower()
  return JumpHeightMin(4)
end

function FarFall()
  return SkyTown()
end

function FireCage()
  return GrottoUpper() and Has("divebomb")
end

function FireCageOOL()
  return GrottoUpperOOL() and Has("divebomb")
end

function Grotto()
  return JumpHeightMin(4)
end

function HighLands()
  return GrottoUpper() and Has("redenergy") and Has("iceshot")
end

function HighLandsOOL()
  return GrottoUpperOOL() and Has("redenergy") and Has("iceshot")
end

function IceCastle()
  return TheCurtainUpper()
end

function IceCastleOOL()
  return TheCurtainUpperOOL()
end

function Library()
  return TheCurtainUpper()
end

function LibraryOOL()
  return TheCurtainUpperOOL()
end

function LongBeach()
  return DeepDiveRight() or DarkGrotto() or TheCurtainUpper()
end

function LongBeachOOL()
  return DeepDiveRightOOL() or DarkGrottoOOL() or TheCurtainUpperOOL()
end

function MountSide()
  return GrottoUpper() and Has("redenergy")
end

function MountSideOOL()
  return GrottoUpperOOL() and Has("redenergy")
end

function NightClimb()
  return ColdKeep() and JumpHeightMin(5) and Has("fireshot")
end

function NightWalk()
  return true
end

function RainbowDive()
  return TheCurtainUpper()
end

function RainbowDiveOOL()
  return TheCurtainUpperOOL()
end

function SkyLands()
  return TheCurtainUpper()
end

function SkyLandsOOL()
  return TheCurtainUpperOOL()
end

function SkySand()
  return NightClimb()
end

function SkyTown()
  return ColdKeep()
end

function Staircase()
  return NightWalkUpper()
end

function StaircaseOOL()
  return NightWalkUpperOOL()
end

function StoneCastle()
  return FarFall()
end

function StrangeCastle()
  -- Need to test if doublejumps are needed.
  return FarFallLowerLeft()
end

function UnderTomb()
  return LongBeach() and Has("divebomb")
end

function UnderTombOOL()
  return LongBeachOOL() and Has("divebomb")
end

-- Extras to help with subzones

function BlackCastleInner()
  return BlackCastle() and Has("goldorb", 7) and JumpHeightMin(7) and Has("redenergy") and Has("divebomb") and Has("ceilingstick", 2)
end

function BlackCastleInnerOOL()
  return BlackCastleOOL() and Has("goldorb", 7) and JumpHeightMin(7) and Has("redenergy") and Has("divebomb") and Has("ceilingstick", 2)
end

function BlancLandLowerLeft()
  return BlancLand() and (Has("redenergy") or Has("iceshot"))
end

function BlancLandLowerLeftOOL()
  return BlancLandOOL() and (Has("redenergy") or Has("iceshot"))
end

function CloudRunMiddle()
  return CloudRun() and JumpHeightMin(7) and Has("fireshot")
end

function CloudRunRight()
  return CloudRunMiddle() and Has("iceshot")
end

-- Lighting the torches can be done with divebomb, but it's precise to do without taking damage.
function DarkGrottoPostBoss()
  return DarkGrotto() and Has("iceshot")
end

function DarkGrottoPostBossOOL()
  return DarkGrottoOOL() and Has("iceshot")
end

function DeepDiveRight()
  return DeepDive() and JumpHeightMin(7)
end

function DeepDiveRightOOL()
  return DeepDiveOOL() and JumpHeightMin(7)
end

function FarFallLower()
  return FarFall() and Has("divebomb")
end

function FarFallLowerLeft()
  return FarFallLower() and Has("hatch") and Has("redenergy")
end

function FarFallLowerRight()
  -- The boss and StrangeCastle may need a doublejump.
  return FarFallLower() and Has("redenergy")
end

-- I think this actually needs jump:2.
-- Never mind. Just longjump, don't try and cling.
function FireCageInner()
  -- Red energy isn't _strictly_ required to get past the first heart door room...
  -- ...but you need a maxed doublejump to pull it off.
  return FireCage() and -- Get in the area, then...
    ((Has("ceilingstick") and Has("redenergy")) or -- Normal
    (Has("ceilingstick") and Has("doublejump", 3))) -- Red energy skip
end

-- This gets to be its own function because it's fucky!
function FireCageInnerOOL()
  -- Either get here OOL in the first place, or...
  return FireCageOOL() or
        -- Ceiling stick skip (requires taking damage)
        (FireCage() and Has("redenergy") and Has("jump", 2) and Has("doublejump", 3))
end

-- Further FireCage out of logic notes:
--  - It turns out you can get to FireCage Middle without ceiling stick, too! What a fun turn of events! /s
--  - You need to make a precise jump from spikes onto the floating enemy, then hit the red energy. It might require a maxed jump and doublejump.
--  - This gets you  to FireCage Middle (not heart door, obviously), and everything in the boss area. Hell, if you have yellow energy you can clear all of it!
--  - Except the item above the save, because by definition you don't have slide for it. Oh well.
--  - It's hyper-cursed and I will do logic for it later... but it is possible.

function GrottoUpper()
  return Has("hatch") and -- For getting past the tollgate...
      ((Has("duck") and Has("redenergy") and JumpHeightMin(6)) or -- Vanilla...
      JumpHeightMin(8)) -- ...or "No. Jump good."
end

-- Apparently you don't need Hatch. Shit's wild.
function GrottoUpperOOL()
  return JumpHeightMin(8)
end

function IceCastleBoss()
  return IceCastle() and Has("divebomb")
end

function IceCastleBossOOL()
  return IceCastleOOL() and Has("divebomb")
end

function NightWalkUpper()
  return TheCurtainUpper()
end

function NightWalkUpperOOL()
  return TheCurtainUpperOOL()
end

function SkyLandsRight()
  return IceCastleBoss()
end

function SkyLandsRightOOL()
  return IceCastleBossOOL()
end

function SkySandInner()
  return SkySand() and Has("iceshot")
end

function SkySandMiddle()
  return SkySandInner() and Has("ceilingstick", 2) and Has("redenergy") and Has("jump", 2) and Has("doublejump", 2)
end

function StoneCastleUpper()
  -- The yellow energy room with the walker needs either max jump or a ceiling stick and 7.
  return StoneCastle() and Has("redenergy") and Has("yellowenergy") and 
    ((JumpHeightMin(7) and Has("ceilingstick")) or
    JumpHeightMin(8))
end

-- Interestingly, you can knock back Curtain ghosts with ice shot, so you don't actually need fire here.
function TheCurtainUpper()
  return TheCurtain() and JumpHeightMin(8)
end

function TheCurtainUpperOOL()
  return TheCurtainOOL() and JumpHeightMin(8)
end