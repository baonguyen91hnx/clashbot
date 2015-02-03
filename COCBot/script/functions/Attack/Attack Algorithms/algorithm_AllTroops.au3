; Improved attack algorithm, using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available

; Old mecanism, not used anymore
Func OldDropTroop($troup, $position, $nbperspot)
  SelectDropTroupe($troup) ;Select Troop
  If _Sleep(100) Then Return
  For $i = 0 To 4
	 Click($position[$i][0], $position[$i][1], $nbperspot, 1)
	 If _Sleep(50) Then Return
  Next
EndFunc


; improved function, that avoids to only drop on 5 discret drop points :
Func DropOnEdge($troop, $edge, $number, $slotsPerEdge = 0)
   if $number = 0 Then Return
   SelectDropTroupe($troop) ;Select Troop
   If _Sleep(100) Then Return
   If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
   If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a single point per edge => on the middle
	  Click($edge[2][0], $edge[2][1], $number)
	  If _Sleep(50) Then Return
	  ElseIf $slotsPerEdge = 2 Then ; Drop on 2 points per edge
		 Local $half = Ceiling($number/2)
		 Click($edge[1][0], $edge[1][1], $half)
		 If _Sleep(50) Then Return
		 Click($edge[3][0], $edge[3][1], $number  - $half)
		 If _Sleep(50) Then Return
   Else
	    Local $minX = $edge[0][0]
		Local $maxX = $edge[4][0]
		Local $minY = $edge[0][1]
		Local $maxY = $edge[4][1]
		Local $nbTroopsLeft = $number
  	    For $i = 0 To $slotsPerEdge - 1
			Local $nbtroopPerSlot = Round($nbTroopsLeft/($slotsPerEdge - $i)) ; progressively adapt the number of drops to fill at the best
	  		Local $posX = $minX + (($maxX - $minX) * $i) / ($slotsPerEdge - 1)
			Local $posY = $minY + (($maxY - $minY) * $i) / ($slotsPerEdge - 1)
			Click($posX, $posY, $nbtroopPerSlot)
			If _Sleep(50) Then Return
			$nbTroopsLeft -= $nbtroopPerSlot
		 Next
	  EndIf
EndFunc

Func DropOnEdges($troop, $nbSides, $number, $slotsPerEdge=0)
    If $nbSides = 0 Or $number = 1 Then
	   OldDropTroop($troop, $Edges[0], $number);
	   Return
	   EndIf
	If $nbSides < 1 Then Return
    Local $nbTroopsLeft = $number
  	For $i = 0 to $nbSides-1
	   Local $nbTroopsPerEdge = Round($nbTroopsLeft/($nbSides-$i))
	   DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge);
	   $nbTroopsLeft -= $nbTroopsPerEdge
    Next
EndFunc

Func LauchTroop($troopKind, $nbSides, $waveNb, $maxWaveNb, $slotsPerEdge=0)
   Local $troop = -1
   Local $troopNb = 0
   Local $name = ""
   For $i = 0 To 8 ; identify the position of this kind of troop
	  If $atkTroops[$i][0] = $troopKind Then
		 $troop = $i
		 $troopNb = Ceiling($atkTroops[$i][1]/$maxWaveNb)
		 Local $plural = 0
		 if $troopNb > 1 Then $plural = 1
		 $name = NameOfTroop($troopKind, $plural)
	  EndIf
   Next

   if ($troop = -1) Or ($troopNb = 0) Then
	  ;if $waveNb > 0 Then SetLog("Skipping wave of " & $name & " (" & $troopKind & ") : nothing to drop" )
	  Return False; nothing to do => skip this wave
   EndIf

   Local $waveName = "first"
   if $waveNb = 2 Then $waveName = "second"
   if $waveNb = 3 Then $waveName = "third"
   if $maxWaveNb = 1 Then $waveName = "only"
   if $waveNb = 0 Then $waveName = "last"
   SetLog("Dropping " & $waveName & " wave of " & $troopNb & " " & $name, $COLOR_BLUE)
   DropOnEdges($troop, $nbSides, $troopNb, $slotsPerEdge)
   Return True
EndFunc

Func algorithm_AllTroops() ;Attack Algorithm for all existing troops
		Global $King = -1, $Queen = -1, $CC = -1, $Barb = -1, $Arch = -1
	    For $i = 0 To 8
			If $atkTroops[$i][0] = $eBarbarian Then
				$Barb = $i
			ElseIf $atkTroops[$i][0] = $eArcher Then
				$Arch = $i
			ElseIf $atkTroops[$i][0] = $eCastle Then
				$CC = $i
			ElseIf $atkTroops[$i][0] = $eKing Then
				$King = $i
			ElseIf $atkTroops[$i][0] = $eQueen Then
				$Queen = $i
			EndIf
		 Next

		If _Sleep(2000) Then Return
	    Local $nbSides = 0
		Switch $deploySettings
			Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in a single side...")
				$nbSides = 1
			Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in two sides...")
				$nbSides = 2
			Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in three sides...")
				$nbSides = 3
			Case 3 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in all sides...")
				$nbSides = 4
		 EndSwitch
		 if ($nbSides = 0) Then Return
		 If _Sleep(1000) Then Return

		 ; ================================================================================
		 ; ========= Here is coded the main attack strategy ===============================
		 ; ========= Feel free to experiment something else ===============================
		 ; ================================================================================
		If GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
			Global $LeftTHx = 40, $RightTHx = 30, $BottomTHy = 30, $TopTHy = 30
			Global $AtkTroopTH
			Global $GetTHLoc = 0
			If $THLocation = 0 Then
				SetLog("Can't get Townhall location")
 			ElseIf $THx > 287 And $THx < 584 And $THy > 465 And GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
 				SetLog("Townhall location (" & $THx & ", " & $THy &")")
 				SetLog("Townhall is in Bottom of Base. Ignore Attacking Townhall")
 				$THLocation = 0
 			ElseIf $THx > 227 And $THx < 627 And $THy > 151 And $THy < 419 And GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
 				SetLog("Townhall location (" & $THx & ", " & $THy &")")
 				SetLog("Townhall is in Center of Base. Ignore Attacking Townhall")
 				$THLocation = 0
			Else
				SetLog("Townhall location (" & $THx & ", " & $THy &")")
			EndIf
			If _Sleep(100) Then Return
			atkAlgorithmTH()
			If $THLocation <> 0 Then
			   PrepareAttack(True) ;Check remaining quantities
			EndIf
		EndIf

		 if LauchTroop($eGiant, $nbSides, 1, 1, 1) Then
			If _Sleep(1000) Then Return
			   EndIf
		 if LauchTroop($eBarbarian, $nbSides, 1, 2) Then
			If _Sleep(1000) Then Return
			   EndIf
		 if LauchTroop($eArcher, $nbSides, 1, 2) Then
			If _Sleep(1000) Then Return
			   EndIf
		 If _Sleep(2000) Then Return
		 If LauchTroop($eBarbarian, $nbSides, 2, 2) Then
			If _Sleep(1000) Then Return
			EndIf
		 if LauchTroop($eWallbreaker, $nbSides, 1, 1, 1) Then
			If _Sleep(500) Then Return
			   EndIf
		 If LauchTroop($eGoblin, $nbSides, 1, 2) Then
			If _Sleep(500) Then Return
			   EndIf
		 If LauchTroop($eArcher, $nbSides, 2, 2) Then
			If _Sleep(500) Then Return
			   EndIf
		 If LauchTroop($eGoblin, $nbSides, 2, 2) Then
			If _Sleep(500) Then Return
			   EndIf
		 ; ================================================================================


		 dropHeroes($BottomRight[3][0], $BottomRight[3][1], $King, $Queen)

		 If _Sleep(1000) Then Return

		 dropCC($BottomRight[3][0], $BottomRight[3][1], $CC)

		If _Sleep(100) Then Return
		SetLog("Dropping left over troops", $COLOR_BLUE)
		PrepareAttack(True) ;Check remaining quantities
		For $i = $eBarbarian To $eWallbreaker ; lauch all remaining troops
		   LauchTroop($i, $nbSides, 0, 2, 2)
		   If _Sleep(100) Then Return
	    Next

	    PrepareAttack(True) ;Check remaining quantities
		For $i = $eBarbarian To $eWallbreaker ; lauch all remaining troops
		   LauchTroop($i, $nbSides, 0, 2, 2)
		   If _Sleep(50) Then Return
	    Next

		;Activate KQ's power
		If $checkKPower Or $checkQPower Then
			SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating King/Queen", $COLOR_ORANGE)
			_Sleep($delayActivateKQ)
			If $checkKPower Then
				SetLog("Activate King's power", $COLOR_BLUE)
				SelectDropTroupe($King)
			EndIf
			If $checkQPower Then
				SetLog("Activate Queen's power", $COLOR_BLUE)
				SelectDropTroupe($Queen)
			EndIf
		EndIf

		SetLog("~Finished Attacking, waiting to finish")
 EndFunc   ;==>algorithm_AllTroops

Func atkAlgorithmTH() ;Attack Algorithm TH
	While 1
	  Local $i = 0
	  If $Barb <> -1 And $THLocation <> 0 Then
			  $atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
			  Local $numBarbPerSpot = Ceiling($atkTroops[$Barb][1] / 3)
			  If $atkTroops[$Barb][1] <> 0 Then
				  Click(68 + (72 * $Barb), 595) ;Select Troop
				  If _Sleep(100) Then ExitLoop (2)
				  If GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
					  If $GetTHLoc = 0 Then
						 $i = 0
					  $atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
					  While $atkTroops[$Barb][1] <> 0
						  Click(($THx-$LeftTHx), ($THy+$LeftTHx-30), 1, 1) ; BottomLeft
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
						  SetLog("Getting Attack Townhall location...")
						  $LeftTHx += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					   $i = 0
					 $atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
					  While $atkTroops[$Barb][1] <> 0
						  Click(($THx+$RightTHx), ($THy+$RightTHx-10), 1, 1) ; BottomRight
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
						  SetLog("Getting Attack Townhall location...")
						  $RightTHx += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					   $i = 0
					 $atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
					  While $atkTroops[$Barb][1] <> 0
  						  Click(($THx+$TopTHy-10), ($THy-$TopTHy), 1, 1) ; TopRight
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
						  SetLog("Getting Attack Townhall location...")
						  $TopTHy += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					   $i = 0
					 $atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
					  While $atkTroops[$Barb][1] <> 0
  						  Click(($THx-($BottomTHy+10)), ($THy-$BottomTHy), 1, 1) ; TopLeft
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
						  SetLog("Getting Attack Townhall location...")
						  $BottomTHy += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					 EndIf
					  SetLog("Attacking Townhall with first wave Barbarians")
					  If $GetTHLoc = 2 Then $numBarbPerSpot = Ceiling($numBarbPerSpot / 2)
					  If $GetTHLoc = 3 Then $numBarbPerSpot = Ceiling($numBarbPerSpot / 3)
					  If $GetTHLoc = 4 Then $numBarbPerSpot = Ceiling($numBarbPerSpot / 4)
					  Click(($THx-$LeftTHx), ($THy+$LeftTHx-30), $numBarbPerSpot, 1) ; BottomLeft
					  Click(($THx+$RightTHx), ($THy+$RightTHx-10), $numBarbPerSpot, 1) ; BottomRight
					  Click(($THx+$TopTHy-10), ($THy-$TopTHy), $numBarbPerSpot, 1) ; TopRight
					  Click(($THx-($BottomTHy+10)), ($THy-$BottomTHy), $numBarbPerSpot, 1) ; TopLeft
				  EndIf
			  EndIf
	  If _Sleep(1000) Then ExitLoop
	  EndIf
	  If $Arch <> -1 And $THLocation <> 0 Then
			  $atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
			  Local $numArchPerSpot = Ceiling($atkTroops[$Arch][1] / 3)
			  If $atkTroops[$Arch][1] <> 0 Then
				  Click(68 + (72 * $Arch), 595) ;Select Troop
				  If _Sleep(100) Then ExitLoop (2)
				  If GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
					  If $GetTHLoc = 0 Then
						 $i = 0
					  $atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
					  While $atkTroops[$Arch][1] <> 0
						  Click(($THx-$LeftTHx), ($THy+$LeftTHx-30), 1, 1) ; BottomLeft
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
						  SetLog("Getting Attack Townhall location...")
						  $LeftTHx += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					   $i = 0
					 $atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
					  While $atkTroops[$Arch][1] <> 0
						  Click(($THx+$RightTHx), ($THy+$RightTHx-10), 1, 1) ; BottomRight
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
						  SetLog("Getting Attack Townhall location...")
						  $RightTHx += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					   $i = 0
					 $atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
					  While $atkTroops[$Arch][1] <> 0
  						  Click(($THx+$TopTHy-10), ($THy-$TopTHy), 1, 1) ; TopRight
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
						  SetLog("Getting Attack Townhall location...")
						  $TopTHy += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					   $i = 0
					 $atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
					  While $atkTroops[$Arch][1] <> 0
  						  Click(($THx-($BottomTHy+10)), ($THy-$BottomTHy), 1, 1) ; TopLeft
						  $AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
						  SetLog("Getting Attack Townhall location...")
						  $BottomTHy += 10
						  $i += 1
						  If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 5 Then
							  $GetTHLoc += 1
							  ExitLoop
						  EndIf
					   WEnd
					 EndIf
					  SetLog("Attacking Townhall with first wave of Archers")
					  $LeftTHx += 10
					  $RightTHx += 10
					  $BottomTHy += 10
					  $TopTHy += 10
					  If $GetTHLoc = 2 Then $numArchPerSpot = Ceiling($numArchPerSpot / 2)
					  If $GetTHLoc = 3 Then $numArchPerSpot = Ceiling($numArchPerSpot / 3)
					  If $GetTHLoc = 4 Then $numArchPerSpot = Ceiling($numArchPerSpot / 4)
					  Click(($THx-$LeftTHx), ($THy+$LeftTHx-30), $numArchPerSpot, 1) ; BottomLeft
					  Click(($THx+$RightTHx), ($THy+$RightTHx-10), $numArchPerSpot, 1) ; BottomRight
					  Click(($THx+$TopTHy-10), ($THy-$TopTHy), $numArchPerSpot, 1) ; TopRight
					  Click(($THx-($BottomTHy+10)), ($THy-$BottomTHy), $numArchPerSpot, 1) ; TopLeft
				  EndIf
			  EndIf
	  EndIf
	  ExitLoop
	WEnd
 EndFunc   ;==>atkAlgorithmTH
