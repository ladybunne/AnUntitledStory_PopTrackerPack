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
  return AccessLongBeach() and Has("goldorb", 7)
end

function AccessBlancLand()
  return AccessDeepDive()
end

function AccessBonus()
  return AccessFireCage()
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
  return AccessHighLands() and Has("smash")
end

function AccessDeepDive()
  return AccessGrottoUpper() and Has("smash")
end

function AccessDeepTower()
  return JumpHeightMin(4)
end

function AccessFarFall()
  return AccessSkyTown()
end

function AccessFireCage()
  return AccessGrottoUpper() and Has("smash") and Has ("ceilingstick")
end

function AccessGrotto()
  return JumpHeightMin(4)
end

function AccessHighLands()
  return AccessGrottoUpper() and Has("iceshot")
end

function AccessIceCastle()
  return AccessTheCurtainUpper()
end

function AccessLibrary()
  return AccessTheCurtainUpper()
end

function AccessLongBeach()
  return AccessTheCurtain() or AccessDarkGrotto() or AccessDeepDive()
end

function AccessMountSide()
  return AccessHighLands()
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
  return AccessTheCurtain()
end

function AccessSkySand()
  return AccessNightClimb
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
  return AccessFarFallLowerLeft()
end

function AccessUnderTomb()
  return AccessLongBeach() and Has("divebomb")
end

-- Extras to help with subzones

function AccessGrottoUpper()
  return Has("hatch") and -- For getting past the tollgate...
      (Has("duck") and Has("redenergy") and JumpHeightMin(6)) or -- Vanilla...
      JumpHeightMin(8) -- ...or "No. Jump good."
end

function AccessFarFallLower()
  return AccessFarFall() and Has("divebomb")
end

function AccessFarFallLowerLeft()
  return AccessFarFallLower() and Has("hatch") and Has("redenergy")
end

function AccessFarFallLowerRight()
  return AccessFarFallLower() and Has("redenergy")
end

function AccessSkySandInner()
  return AccessSkySand() and Has("iceshot")
end

function AccessSkySandUpper()
  return AccessSkySandInner() and Has("ceilingslide", 2)
end

function AccessTheCurtainUpper()
  return AccessTheCurtain and JumpHeightMin(8)
end

function AccessNightWalkUpper()
  return AccessTheCurtainUpper()
end

-- debugging

function TestFunctionForRabbits()
  print(string.format("hello %s",JumpHeightMin(5)))
  return true
end