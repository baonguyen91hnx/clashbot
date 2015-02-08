Func UpgradeWall()
If $ichkWalls = 1 Then
   While checkWall()
	  Click(1, 1) ; Click Away
	  If _Sleep(500) Then ExitLoop
	  Click($WallX, $WallY)
	  If _Sleep(600) Then ExitLoop
	  Click(432, 597) ; Select Row
	  If _Sleep(600) Then ExitLoop
	  _CaptureRegion()
	  If _ColorCheck(_GetPixelColor(500, 570), Hex(0xFF0000, 6), 20) Then
		 SetLog("Not enough Gold, Upgrading Walls after Attack", $COLOR_RED)
		 ExitLoop
	  EndIf
	  If _ColorCheck(_GetPixelColor(500, 570), Hex(0xFFFFFF, 6), 20) = False Then
		 SetLog("Walls already upgraded", $COLOR_ORANGE)
		 ExitLoop
	  EndIf
	  Click(474, 598) ; Click Upgrade
	  If _Sleep(1000) Then ExitLoop
	  Click(506, 396) ; Click Okay
	  If _Sleep(700) Then ExitLoop
   WEnd
   Click(1, 1) ; Click Away
EndIf
EndFunc