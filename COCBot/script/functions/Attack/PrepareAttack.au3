;Checks the troops when in battle, checks for type, slot, and quantity.
;Saved in $atkTroops[SLOT][TYPE/QUANTITY] variable

Func PrepareAttack($remainding = false) ;Assigns troops
  If $remainding Then
	  SetLog("Checking remainding unlaunched troops")
   Else
	  SetLog("Preparing to attack")
   EndIf
  _CaptureRegion()
  For $i = 0 To 6
	  Local $troopKind = IdentifyTroopKind($i)
	  If ($troopKind == -1) Then
		 $atkTroops[$i][1] = 0
	  ElseIf ($troopKind = $eKing) Or ($troopKind = $eQueen) Or ($troopKind = $eCastle) Then
		 $atkTroops[$i][1] = 1
	  Else
		 $atkTroops[$i][1] = ReadTroopQuantity($i)
	  EndIf
	  $atkTroops[$i][0] = $troopKind
	  If $troopKind <> -1 Then SetLog("-" & NameOfTroop($atkTroops[$i][0]) & " " & $atkTroops[$i][1])
  Next
EndFunc   ;==>PrepareAttack
