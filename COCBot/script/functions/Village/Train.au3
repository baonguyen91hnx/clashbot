;Uses the location of manually set Barracks to train specified troops

; Train the troops (Fill the barracks)

Func GetTrainPos($troopKind)
   Switch $troopKind
   Case $eBarbarian ; 261, 366: 0x39D8E0
	  Return $TrainBarbarian
   Case $eArcher ; 369, 366: 0x39D8E0
	  Return $TrainArcher
   Case $eGiant ; 475, 366: 0x3DD8E0
	  Return $TrainGiant
   Case $eGoblin ; 581, 366: 0x39D8E0
	  Return $TrainGoblin
   Case $eWallbreaker ; 688, 366, 0x3AD8E0
	  Return $TrainWallbreaker
   Case Else
	  SetLog("Don't know how to train the troop " & $troopKind & " yet")
	  Return 0
   EndSwitch
EndFunc

Func TrainIt($troopKind, $howMuch=1)
   _CaptureRegion()
   Local $pos = GetTrainPos($troopKind)
   If IsArray($pos) Then
	  If CheckPixel($pos) Then
		 ClickP($pos, $howMuch)
		 if _Sleep(500) Then Return False
		 Return True
	  EndIf
   EndIf
EndFunc

Func Train()
	If $barrackPos[0][0] = "" Then
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf
	SetLog("Training Troops...", $COLOR_BLUE)

	 For $i = 0 To 3
		 If _Sleep(500) Then ExitLoop

		 ClickP($TopLeftClient) ;Click Away

		 If _Sleep(500) Then ExitLoop

		 Click($barrackPos[$i][0], $barrackPos[$i][1]) ;Click Barrack

		 If _Sleep(500) Then ExitLoop

		 Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x603818, 6), 5) ;Finds Train Troops button
		 If IsArray($TrainPos) = False Then
			 SetLog("Barrack " & $i + 1 & " is not available", $COLOR_RED)
			 If _Sleep(500) Then ExitLoop
		 Else
			 Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
			 If _Sleep(500) Then ExitLoop

			 CheckFullArmy()
			 While TrainIt($barrackTroop[$i], 5)
				If _Sleep(50) Then ExitLoop(2)
			 Wend
		 EndIf
		 If _Sleep(500) Then ExitLoop
		 Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
	 Next

	 SetLog("Training Troops Complete", $COLOR_BLUE)
 EndFunc   ;==>Train
