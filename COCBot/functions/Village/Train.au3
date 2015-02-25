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

Func TrainIt($troopKind, $howMuch = 1, $iSleep = 100)
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
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 8 Then
		checkArmyCamp()
	EndIf

	If $barrackPos[0] = "" Then
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf

	SetLog("Training Troops...", $COLOR_BLUE)

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If _Sleep(100) Then Return

	Click($barrackPos[0], $barrackPos[1]) ;Click Barrack

	If _Sleep(700) Then Return

	Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x603818, 6), 5) ;Finds Train Troops button

	If IsArray($TrainPos) = False Then
		SetLog("Your Barrack is not available", $COLOR_RED)
		If _Sleep(500) Then Return
	Else
		Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
		If _Sleep(1000) Then Return
		if not $fullArmy then CheckFullArmy()  ;if armycamp not full, check full by barrack
	Endif
	if not $fullArmy and $iTimeTroops <> 0 then ; if armycamp and barrack return not full, force FULL and Raid if enough time wait
		if _DateDiff('s', _NowCalc(), $iTimeTroops) < 0 then
			$fullArmy = true
			SetLog("End Time, raid now ... ", $COLOR_RED)
		endif
	endif

	SetLog("Army Camp Full : " & $fullArmy, $COLOR_RED)


	If $fullArmy Then ; reset all for cook again
	  $ArmyComp = 0
	 $CurGiant = 0
	 $CurWB = 0
	 $CurArch = 0
	 $CurBarb = 0
	 $CurGoblin = 0

	Endif

	If $ArmyComp = 0 Then
		$CurGiant += GUICtrlRead($txtNumGiants)
		$CurWB += GUICtrlRead($txtNumWallbreakers)
		$CurArch += ($TotalCamp-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtArchers)/100
		$CurArch = Round($CurArch) + 4; ===> make sure always cook full
		$CurBarb += ($TotalCamp-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtBarbarians)/100
		$CurBarb = Round($CurBarb)
		$CurGoblin += ($TotalCamp-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtGoblins)/100
		$CurGoblin = Round($CurGoblin)
	EndIf

	Local $GiantEBarrack ,$WallEBarrack ,$ArchEBarrack ,$BarbEBarrack ,$GoblinEBarrack
	$GiantEBarrack = Floor($CurGiant/4)
	$WallEBarrack = Floor($CurWB/4)
	$ArchEBarrack = Floor($CurArch/4)
	$BarbEBarrack = Floor($CurBarb/4)
	$GoblinEBarrack = Floor($CurGoblin/4)

	If $ArmyComp = 0 Then
		If $fullArmy Then
			Local $TimeETroops = $GiantEBarrack * $iTimeGiant + $WallEBarrack * $iTimeWall + $ArchEBarrack * $iTimeArch + $BarbEBarrack * $iTimeBarba + $GoblinEBarrack*$iTimeGoblin + 60
			$iTimeTroops = _DateAdd( 's',$TimeETroops,  _NowCalc())
		Endif
		If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then
			$iTimeTroops = 0
		endif
	EndIf
	Local $hTimer = TimerInit()
	Local $troopFirstGiant,$troopSecondGiant,$troopFirstWall,$troopSecondWall,$troopFirstGoblin,$troopSecondGoblin,$troopFirstBarba,$troopSecondBarba,$troopFirstArch,$troopSecondArch
	$troopFirstGiant = 0
	$troopSecondGiant = 0
	$troopFirstWall = 0
	$troopSecondWall = 0
	$troopFirstGoblin = 0
	$troopSecondGoblin = 0
	$troopFirstBarba = 0
	$troopSecondBarba = 0
	$troopFirstArch = 0
	$troopSecondArch = 0

	If _Sleep(1000) Then return
	Local $NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)
    Local $PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)

	Local $iBarrHere
	$iBarrHere = 0
	while isBarrack()
		If IsArray($NextPos) Then Click($NextPos[0], $NextPos[1]) ;click next button
		$iBarrHere += 1
		If _Sleep(1000) Then ExitLoop
		if($iBarrHere = 4) then ExitLoop
	wend

	$brrNum = 0
	If _Sleep(300) Then return
	If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button
	If _Sleep(1000) Then return
	_CaptureRegion()
	If _Sleep(10) Then return
	if _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 then
		while isBarrack()
			$brrNum += 1
			Switch $barrackTroop[$brrNum-1]
				Case 0
						Click(220, 320, 15)
				Case 1
						Click(331, 320, 15)
				Case 2
						Click(432, 320, 15)
				Case 3
						Click(546, 320, 15)
				Case 4
						Click(647, 320, 15)
			EndSwitch

			 Click($PrevPos[0], $PrevPos[1]) ;click prev button
			 If $brrNum >= 4 Then ExitLoop ; make sure no more infiniti loop
			 If _Sleep(1500) Then ExitLoop
			;endif
		wend
	elseif ($CurGiant*5 + $CurWB*2 + $CurArch + $CurBarb + $CurGoblin) > 0 then
		while isBarrack()
			$brrNum += 1
			SetLog("====== Barrack " & $brrNum & " : ======", $COLOR_BLUE)

			_CaptureRegion()
			;while _ColorCheck(_GetPixelColor(496, 200), Hex(0x880000, 6), 20) Then
			if $fullArmy or $FirstStart then
				 Click(496, 197, 80,5)
			endif
			;wend

		   If _Sleep(500) Then ExitLoop
		   _CaptureRegion()
		   If GUICtrlRead($txtNumGiants) <> "0" Then
			  $troopFirstGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			  if $troopFirstGiant = 0 then
				  $troopFirstGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			  endif
		   Endif
		   if GUICtrlRead($txtNumWallbreakers) <> "0" then
			  $troopFirstWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			  if $troopFirstWall = 0 then
				  $troopFirstWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			  endif
		   EndIf
		   if GUICtrlRead($txtGoblins) <> "0" then
			  $troopFirstGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			  if $troopFirstGoblin = 0 then
				  $troopFirstGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			  endif
		   EndIf
		   If GUICtrlRead($txtBarbarians) <> "0" then
			  $troopFirstBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			  if $troopFirstBarba = 0 then
				  $troopFirstBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			  endif
		   EndIf
		   If GUICtrlRead($txtArchers) <> "0" Then
			  $troopFirstArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  if $troopFirstArch = 0 then
				  $troopFirstArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  endif
		   Endif

		   If GUICtrlRead($txtArchers) <> "0" And $CurArch > 0 Then
			   ;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
			   If $CurArch > 0  Then
					if $ArchEBarrack = 0 then
					    TrainIt($eArcher, 1)
					elseif $ArchEBarrack >= $CurArch then
					    TrainIt($eArcher, $CurArch)
				    else
					    TrainIt($eArcher, $ArchEBarrack)
				    endif
			   EndIf
		   EndIf

		   If GUICtrlRead($txtNumGiants) <> "0" And $CurGiant > 0 Then
			   ;If _ColorCheck(_GetPixelColor(475, 366), Hex(0x3DD8E0, 6), 20) And $CurGiant > 0 Then
			   If $CurGiant > 0 Then
				   if $GiantEBarrack = 0 then
					    TrainIt($eGiant, 1)
					elseif $GiantEBarrack >= $CurGiant or $GiantEBarrack = 0  then
					   TrainIt($eGiant, $CurGiant)
				   else
					   TrainIt($eGiant, $GiantEBarrack)
				   endif
			   endif
		   EndIf


		   If GUICtrlRead($txtNumWallbreakers) <> "0" And $CurWB > 0 Then
			   ;If _ColorCheck(_GetPixelColor(688, 366), Hex(0x3AD8E0, 6), 20) And $CurWB > 0  Then
			   If $CurWB > 0  Then
				   if $WallEBarrack = 0 then
					    TrainIt($eWallbreaker, 1)
					elseif $WallEBarrack >= $CurWB or $WallEBarrack = 0  then
					   TrainIt($eWallbreaker, $CurWB)
				   else
					   TrainIt($eWallbreaker, $WallEBarrack)
				   endif
			   EndIf
		   EndIf


		   If GUICtrlRead($txtBarbarians) <> "0" And $CurBarb > 0 Then
			   ;If _ColorCheck(_GetPixelColor(369, 366), Hex(0x39D8E0, 6), 20) And $CurBarb > 0 Then
			   If $CurBarb > 0  Then
				   if $BarbEBarrack = 0 then
					    TrainIt($eBarbarian, 1)
					elseif $BarbEBarrack >= $CurBarb or $BarbEBarrack = 0  then
					   TrainIt($eBarbarian, $CurBarb)
				   else
					   TrainIt($eBarbarian, $BarbEBarrack)
				   endif
			   EndIf
		   EndIf



		   If GUICtrlRead($txtGoblins) <> "0" And $CurGoblin > 0 Then
			   ;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurGoblin > 0 Then
			   If $CurGoblin > 0  Then
				   if $GoblinEBarrack = 0 then
					    TrainIt($eGoblin, 1)
					elseif $GoblinEBarrack >= $CurGoblin or $GoblinEBarrack = 0  then
					   TrainIt($eGoblin, $CurGoblin)
				   else
					   TrainIt($eGoblin, $GoblinEBarrack)
				   endif
			   EndIf
		   EndIf


		   If _Sleep(900) Then ExitLoop
		   _CaptureRegion()
		   If GUICtrlRead($txtNumGiants) <> "0" Then
			  $troopSecondGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			  if $troopSecondGiant = 0 then
				  $troopSecondGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			   endif
			EndIf
		   if GUICtrlRead($txtNumWallbreakers) <> "0" then
			  $troopSecondWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			  if $troopSecondWall = 0 then
				  $troopSecondWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			   endif
			EndIf
		   if GUICtrlRead($txtGoblins) <> "0" then
			  $troopSecondGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			  if $troopSecondGoblin = 0 then
				  $troopSecondGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			   endif
			EndIf
		   If GUICtrlRead($txtBarbarians) <> "0" then
			  $troopSecondBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			  if $troopSecondBarba = 0 then
				  $troopSecondBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			   endif
		   EndIf
		   If GUICtrlRead($txtArchers) <> "0" Then
			  $troopSecondArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  if $troopSecondArch = 0 then
				  $troopSecondArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  endif
		   EndIf

		   if $troopSecondGiant > $troopFirstGiant and GUICtrlRead($txtNumGiants) <> "0" then
			   $ArmyComp += ($troopSecondGiant - $troopFirstGiant)*5
			   $CurGiant -= ($troopSecondGiant - $troopFirstGiant)
			   SetLog("Barrack " & ($brrNum) & " Training Giant : " & ($troopSecondGiant - $troopFirstGiant) , $COLOR_GREEN)
			   SetLog("Giant Remaining : " & $CurGiant , $COLOR_BLUE)
		   endif


		   if $troopSecondWall > $troopFirstWall and GUICtrlRead($txtNumWallbreakers) <> "0" then
			   $ArmyComp += ($troopSecondWall - $troopFirstWall)*2
			   $CurWB -= ($troopSecondWall - $troopFirstWall)
			   SetLog("Barrack " & ($brrNum) & " Training WallBreaker : " & ($troopSecondWall - $troopFirstWall) , $COLOR_GREEN)
			   SetLog("WallBreaker Remaining : " & $CurWB , $COLOR_BLUE)
		   endif

		   if $troopSecondGoblin > $troopFirstGoblin and GUICtrlRead($txtGoblins) <> "0" then
			   $ArmyComp += ($troopSecondGoblin - $troopFirstGoblin)
			   $CurGoblin -= ($troopSecondGoblin - $troopFirstGoblin)
			   SetLog("Barrack " & ($brrNum) & " Training Goblin : " & ($troopSecondGoblin - $troopFirstGoblin) , $COLOR_GREEN)
			   SetLog("Goblin Remaining : " & $CurGoblin , $COLOR_BLUE)
		   endif

		   if $troopSecondBarba > $troopFirstBarba and GUICtrlRead($txtBarbarians) <> "0" then
			   $ArmyComp += ($troopSecondBarba - $troopFirstBarba)
			   $CurBarb -= ($troopSecondBarba - $troopFirstBarba)
			   SetLog("Barrack " & ($brrNum) & " Training Barbarian : " & ($troopSecondBarba - $troopFirstBarba) , $COLOR_GREEN)
			   SetLog("Barbarian Remaining : " & $CurBarb , $COLOR_BLUE)
		   endif

		   if $troopSecondArch > $troopFirstArch and GUICtrlRead($txtArchers) <> "0" then
			   $ArmyComp += ($troopSecondArch - $troopFirstArch)
			   $CurArch -= ($troopSecondArch - $troopFirstArch)
			   SetLog("Barrack " & ($brrNum) & " Training Archer : " & ($troopSecondArch - $troopFirstArch) , $COLOR_GREEN)
			   SetLog("Archer Remaining : " & $CurArch , $COLOR_BLUE)
		   endif
		   SetLog("Total Troops building : " & $ArmyComp , $COLOR_RED)


		   Click($PrevPos[0], $PrevPos[1]) ;click prev button
		   If $brrNum >= 4 Then ExitLoop ; make sure no more infiniti loop
		   If _Sleep(1500) Then ExitLoop
		wend
	EndIf

	If _Sleep(200) Then Return
	Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay

	$FirstStart = false

	SetLog("Training Troops Complete...", $COLOR_BLUE)


	if $iTimeTroops <> 0 then
		Local $TimeWaiting = _DateDiff('s', _NowCalc(),$iTimeTroops) - Round(TimerDiff($hTimer) / 1000, 2)
		SetLog("Next raid latest after " & Floor(Floor($TimeWaiting / 60) / 60) & " hours " & Floor(Mod(Floor($TimeWaiting / 60), 60)) & " minutes " & Floor(Mod($TimeWaiting, 60)) & " seconds", $COLOR_RED)
		SetLog("...", $COLOR_RED)
    Endif
 EndFunc   ;==>Train

Func checkArmyCamp()
	SetLog("Checking Army Camp...", $COLOR_BLUE)

   If _Sleep(100) Then Return

   ClickP($TopLeftClient) ;Click Away

	If $ArmyPos[0] = "" Then
		LocateBarrack(True)
		SaveConfig()
    else
	   If _Sleep(100) Then Return
	   Click($ArmyPos[0], $ArmyPos[1]) ;Click Army Camp
    endif
	_CaptureRegion()
   If _Sleep(500) Then Return
   Local $BArmyPos = _PixelSearch(309, 581, 433, 583, Hex(0x4084B8, 6), 5) ;Finds Info button
   If IsArray($BArmyPos) = False Then
	   SetLog("Your Army Camp is not available", $COLOR_RED)
	   if $TotalCamp = "" and $TotalCamp = 0 then
		   $TotalCamp = InputBox("Question", "Enter Your Total Troop Capacity", "200", "", _
				 - 1, -1, 0, 0)
			$TotalCamp = int($TotalCamp)
		 Endif
	   If _Sleep(500) Then Return
   Else
	   Click($BArmyPos[0], $BArmyPos[1]) ;Click Info button
	   If _Sleep(1000) Then Return
	   $CurCamp = Number(getOther(586, 193, "Camp"))
	   if $TotalCamp = "" or $TotalCamp = 0 then
		$TotalCamp = Number(getOther(586, 193, "Camp", True))
	   endif
	   SetLog("Total Troop Capacity: " & $CurCamp & "/" & $TotalCamp, $COLOR_GREEN)
	   If $CurCamp=$TotalCamp Then
		   $fullArmy = True
	   Else
		  _CaptureRegion()
		  For $i = 0 To 6
			  Local $TroopKind = _GetPixelColor(230 + 71 * $i, 359)
			  Local $TroopName = 0
			  Local $TroopQ = getOther(229 + 71 * $i, 413, "Camp")
			  If _ColorCheck($TroopKind, Hex(0xF85CCB, 6), 20) Then
				 if ($CurArch=0 and $FirstStart) then $CurArch -= $TroopQ
				 $TroopName = "Archers"
			  ElseIf _ColorCheck($TroopKind, Hex(0xF8E439, 6), 20) Then
				 if ($CurBarb=0 and $FirstStart) then $CurBarb -= $TroopQ
				 $TroopName = "Barbarians"
			  ElseIf _ColorCheck($TroopKind, Hex(0xF8D198, 6), 20) Then
				 if ($CurGiant=0 and $FirstStart) then $CurGiant -= $TroopQ
				 $TroopName = "Giants"
			  ElseIf _ColorCheck($TroopKind, Hex(0x93EC60, 6), 20) Then
				 if ($CurGoblin=0 and $FirstStart) then $CurGoblin -= $TroopQ
				 $TroopName = "Goblins"
			  ElseIf _ColorCheck($TroopKind, Hex(0x48A8E8, 6), 20) Then
				 if ($CurWB=0 and $FirstStart) then $CurWB -= $TroopQ
				 $TroopName = "Wallbreakers"
			  EndIf
			  If $TroopQ <> 0 Then SetLog("- " & $TroopName & " " & $TroopQ, $COLOR_GREEN)
		   Next
		EndIf
	   ClickP($TopLeftClient) ;Click Away
	   $FirstCampView = True
	 EndIf

Endfunc