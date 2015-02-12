;Clickes the collector locations

Func Collect()
Local $collx, $colly
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
	For $i = 0 To 25
		If _Sleep(150) Or $RunState = False Then ExitLoop
	    _CaptureRegion(0,0,800,613)
	    If _ImageSearch(@ScriptDir & "\images\collect.bmp", 1, $collx, $colly, 30) Then
			Click($collx, $colly) ;Click collector
	    Else
			ExitLoop
		EndIf
		Click(1, 1) ;Click Away
	Next
EndFunc   ;==>Collect