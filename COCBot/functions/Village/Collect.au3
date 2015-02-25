;Clickes the collector locations

Func Collect()
Local $collx, $colly, $i = 0
#CS
 	If $collectorPos[0][0] = "" Then
		LocateCollectors()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf
#CE
	SetLog("Collecting Resources", $COLOR_BLUE)
	_Sleep(250)
	Click(1, 1) ;Click Away
	While 1
		If _Sleep(300) Or $RunState = False Then ExitLoop
	    _CaptureRegion(0,0,780)
	    If _ImageSearch(@ScriptDir & "\images\collect.png", 1, $collx, $colly, 20) Then
			Click($collx, $colly) ;Click collector
	    Elseif $i >= 20 Then
			ExitLoop
		EndIf
	    $i += 1
		Click(1, 1) ;Click Away
	WEnd
EndFunc   ;==>Collect