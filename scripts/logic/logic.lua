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
    return AccessFireCage() and Has("redenergy") and Has("jump", 2) and Has("doublejump", 3) -- Ceiling stick skip (requires taking damage)
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

function AccessNightWalkUpper()
  return AccessTheCurtainUpper()
end

function AccessSkySandInner()
  return AccessSkySand() and Has("iceshot")
end

function AccessSkySandMiddle()
  return AccessSkySandInner() and Has("ceilingstick", 2) and Has("redenergy")
end

function AccessSkySandUpper()
  return AccessSkySandMiddle() and Has("jump", 1)
end

function AccessStoneCastleUpper()
  -- I think this might be doable with 7.
  return AccessStoneCastle() and Has("redenergy") and Has("yellowenergy") and JumpHeightMin(7)
end

function AccessTheCurtainUpper()
  return AccessTheCurtain() and JumpHeightMin(8)
end
