;Checks if red pixel located in the popup baracks window is available

Func CheckFullArmy()
	_CaptureRegion()
	$Pixel = _ColorCheck(_GetPixelColor(327, 520), Hex(0xD03838, 6), 20)
	If $Pixel Then
		$fullArmy = True
	ElseIf _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then
		$fullArmy = False
	EndIf
EndFunc   ;==>CheckFullArmy