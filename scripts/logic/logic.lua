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

function AccessBlackCastle()
  return AccessLongBeach()
end

function AccessBlancLand()
  return AccessDeepDive()
end

-- Not currently used due to fiddly out-of-logic FireCage red energy skip stuff
function AccessBonus()
  return AccessFireCageInner()
end

function AccessBottom()
  return AccessFarFallLowerLeft() and Has("ceilingstick", 2)
end

function AccessCloudRun()
  return AccessBottom()
end

function AccessColdKeep()
  return AccessDeepTower()
end

function AccessTheCurtain()
  return AccessHighLands() and Has("ceilingstick", 2) and Has("yellowenergy")
end

function AccessDarkGrotto()
  return AccessHighLands() and Has("divebomb")
end

function AccessDeepDive()
  return AccessGrottoUpper() and Has("divebomb")
end

function AccessDeepTower()
  return JumpHeightMin(4)
end

function AccessFarFall()
  return AccessSkyTown()
end

function AccessFireCage()
  return AccessGrottoUpper() and Has("divebomb")
end

function AccessGrotto()
  return JumpHeightMin(4)
end

function AccessHighLands()
  return AccessGrottoUpper() and Has("redenergy") and Has("iceshot")
end

function AccessIceCastle()
  return AccessTheCurtainUpper()
end

function AccessLibrary()
  return AccessTheCurtainUpper()
end

function AccessLongBeach()
  return AccessDeepDiveRight() or AccessDarkGrotto() or AccessTheCurtainUpper()
end

function AccessMountSide()
  return AccessGrottoUpper() and Has("redenergy")
end

function AccessNightClimb()
  return AccessColdKeep() and JumpHeightMin(5) and Has("fireshot")
end

function AccessNightWalk()
  return true
end

function AccessRainbowDive()
  return AccessTheCurtainUpper()
end

function AccessSkyLands()
  return AccessTheCurtainUpper()
end

function AccessSkySand()
  return AccessNightClimb()
end

function AccessSkyTown()
  return AccessColdKeep()
end

function AccessStaircase()
  return AccessNightWalkUpper()
end

function AccessStoneCastle()
  return AccessFarFall()
end

function AccessStrangeCastle()
  -- Need to test if doublejumps are needed.
  return AccessFarFallLowerLeft()
end

function AccessUnderTomb()
  return AccessLongBeach() and Has("divebomb")
end

-- Extras to help with subzones

function AccessBlackCastleInner()
  return AccessBlackCastle() and Has("goldorb", 7) and Has("doublejump", 3) and Has("ceilingstick", 2) and Has("redenergy") and Has("divebomb")
end

function AccessBlancLandLowerLeft()
  return AccessBlancLand() and (Has("redenergy") or Has("iceshot"))
end

function AccessCloudRunMiddle()
  return AccessCloudRun() and JumpHeightMin(8) and Has("fireshot")
end

function AccessCloudRunRight()
  return AccessCloudRunMiddle() and Has("iceshot")
end

-- Lighting the torches can be done with divebomb, but it's precise to do without taking damage.
function AccessDarkGrottoPostBoss()
  return AccessDarkGrotto() and Has("iceshot")
end

function AccessDeepDiveRight()
  return AccessDeepDive() and JumpHeightMin(7)
end

function AccessFarFallLower()
  return AccessFarFall() and Has("divebomb")
end

function AccessFarFallLowerLeft()
  return AccessFarFallLower() and Has("hatch") and Has("redenergy")
end

function AccessFarFallLowerRight()
  -- The boss and StrangeCastle may need a doublejump.
  return AccessFarFallLower() and Has("redenergy")
end

function AccessFireCageInner()
  -- Red energy isn't _strictly_ required to get past the first heart door room...
  -- ...but you need a maxed doublejump to pull it off.
  return AccessFireCage() and -- Get in the area, then...
    ((Has("ceilingstick") and Has("redenergy")) or -- Normal
    (Has("ceilingstick") and Has("doublejump", 3))) -- Red energy skip
end

-- This gets to be its own function because it's fucky!
function AccessFireCageInnerOutOfLogic()
    -- Ceiling stick skip (requires taking damage)
    return AccessFireCage() and Has("redenergy") and Has("jump", 2) and Has("doublejump", 3)
end

-- Further FireCage out of logic notes:
--  - It turns out you can get to FireCage Middle without ceiling stick, too! What a fun turn of events! /s
--  - You need to make a precise jump from spikes onto the floating enemy, then hit the red energy. It might require a maxed jump and doublejump.
--  - This gets you access to FireCage Middle (not heart door, obviously), and everything in the boss area. Hell, if you have yellow energy you can clear all of it!
--  - Except the item above the save, because by definition you don't have slide for it. Oh well.
--  - It's hyper-cursed and I will do logic for it later... but it is possible.


function AccessGrottoUpper()
  return Has("hatch") and -- For getting past the tollgate...
      ((Has("duck") and Has("redenergy") and JumpHeightMin(6)) or -- Vanilla...
      JumpHeightMin(8)) -- ...or "No. Jump good."
end

function AccessIceCastleBoss()
  return AccessIceCastle() and Has("divebomb")
end

function AccessNightWalkUpper()
  return AccessTheCurtainUpper()
end

function AccessSkyLandsRight()
  return AccessIceCastleBoss()
end

function AccessSkySandInner()
  return AccessSkySand() and Has("iceshot")
end

function AccessSkySandMiddle()
  return AccessSkySandInner() and Has("ceilingstick", 2) and Has("redenergy") and Has("jump", 2) and Has("doublejump", 2)
end

function AccessStoneCastleUpper()
  -- I think this might be doable with 7.
  return AccessStoneCastle() and Has("redenergy") and Has("yellowenergy") and JumpHeightMin(7)
end

-- Interestingly, you can knock back Curtain ghosts with ice shot, so you don't actually need fire here.
function AccessTheCurtainUpper()
  return AccessTheCurtain() and JumpHeightMin(8)
end
