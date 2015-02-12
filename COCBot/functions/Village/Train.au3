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

Func TrainIt($troopKind, $howMuch = 1, $iSleep = 900)
   _CaptureRegion()
   Local $pos = GetTrainPos($troopKind)
   If IsArray($pos) Then
	  If CheckPixel($pos) Then
		 ClickP($pos, $howMuch, 20)
		 if _Sleep($iSleep) Then Return False
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
			If _Sleep(800) Then ExitLoop

			CheckFullArmy()
			If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then
				Switch $barrackTroop[$i]
					Case 0
						While _ColorCheck(_GetPixelColor(329, 297), Hex(0xDC3F70, 6), 20)
							Click(220, 320, 5) ;Barbarian
							If _Sleep(10) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 1
						While _ColorCheck(_GetPixelColor(217, 297), Hex(0xF8AD20, 6), 20)
							Click(331, 320, 5) ;Archer
							If _Sleep(10) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 2
						While _ColorCheck(_GetPixelColor(217, 297), Hex(0xF8AD20, 6), 20)
							Click(432, 320, 5) ;Giant
							If _Sleep(10) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 3
						While _ColorCheck(_GetPixelColor(217, 297), Hex(0xF8AD20, 6), 20)
							Click(546, 320, 5) ;Goblin
							If _Sleep(10) Then ExitLoop
							_CaptureRegion()
						WEnd
					Case 4
						While _ColorCheck(_GetPixelColor(217, 297), Hex(0xF8AD20, 6), 20)
							Click(647, 320, 5) ;Wall breaker
							If _Sleep(10) Then ExitLoop
							_CaptureRegion()
						WEnd
				EndSwitch
			Else
				; More Troops Settings
				If $fullArmy Then
					If _Sleep(1000) Then ExitLoop
					_CaptureRegion()
					While _ColorCheck(_GetPixelColor(496, 197), Hex(0xD00000, 6), 20)
						Click(496, 197, 20)
						If _Sleep(1000) Then ExitLoop
						_CaptureRegion()
					WEnd
					If $ArmyComp >= $icmbTroopCap Then
						$ArmyComp = 0
					EndIf
				EndIf
				If $ArmyComp = 0 Then
					$CurGiant = GUICtrlRead($txtNumGiants)
					$CurWB = GUICtrlRead($txtNumWallbreakers)
					$CurArch = ($icmbTroopCap-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtArchers)/100
					$CurArch = Round($CurArch)+1
					$CurBarb = ($icmbTroopCap-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtBarbarians)/100
					$CurBarb = Round($CurBarb)+1
					$CurGoblin = ($icmbTroopCap-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtGoblins)/100
					$CurGoblin = Round($CurGoblin)+1
				EndIf
				If GUICtrlRead($txtNumGiants) <> "0" And $CurGiant > 0 Then
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(475, 366), Hex(0x3DD8E0, 6), 20) And $CurGiant > 0 Then TrainIt($eGiant, $CurGiant)
					$CurGiant -= Number(getOther(171 + 107 * 2, 278, "Trophy"))
					$ArmyComp += Number(getOther(171 + 107 * 2, 278, "Trophy"))*5
				EndIf
				If GUICtrlRead($txtNumWallbreakers) <> "0" And $CurWB > 0 Then
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(688, 366), Hex(0x3AD8E0, 6), 20) And $CurWB > 0  Then TrainIt($eWallbreaker, $CurWB)
					$CurWB -= Number(getOther(171 + 107 * 4, 278, "Trophy"))
					$ArmyComp += Number(getOther(171 + 107 * 4, 278, "Trophy"))*2
				EndIf
				 If GUICtrlRead($txtGoblins) <> "0" And $CurGoblin > 0 Then
					For $x = 0 To 1
						_CaptureRegion()
						If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurGoblin > 0 Then
							TrainIt($eGoblin, Round($CurGoblin/2))
							_CaptureRegion()
						Else
							ExitLoop
						EndIf
					Next
					$CurGoblin -= Number(getOther(171 + 107 * 3, 278, "Trophy"))
					$ArmyComp += Number(getOther(171 + 107 * 3, 278, "Trophy"))
				EndIf
				If GUICtrlRead($txtBarbarians) <> "0" And $CurBarb > 0 Then
					For $x = 0 To 1
						_CaptureRegion()
						If _ColorCheck(_GetPixelColor(369, 366), Hex(0x39D8E0, 6), 20) And $CurBarb > 0 Then
							TrainIt($eBarbarian, Round($CurBarb/2))
							_CaptureRegion()
						Else
							ExitLoop
						EndIf
					Next
					$CurBarb -= Number(getOther(171 + 107 * 0, 278, "Trophy"))
					$ArmyComp += Number(getOther(171 + 107 * 0, 278, "Trophy"))
				EndIf
				If GUICtrlRead($txtArchers) <> "0" And $CurArch > 0 Then
					For $x = 0 To 1
						_CaptureRegion()
						If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
							TrainIt($eArcher, Round($CurArch/2))
							_CaptureRegion()
						Else
							ExitLoop
						EndIf
					Next
					$CurArch -= Number(getOther(171 + 107 * 1, 278, "Trophy"))
					$ArmyComp += Number(getOther(171 + 107 * 1, 278, "Trophy"))
				EndIf
			EndIf
		EndIf
		If _Sleep(500) Then ExitLoop
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
	 Next
	SetLog("Training Troops Complete", $COLOR_BLUE)
 EndFunc   ;==>Train
