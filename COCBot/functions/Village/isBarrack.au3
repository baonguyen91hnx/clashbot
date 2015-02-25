;Checks is your Barrack or no

Func isBarrack()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(218, 294), Hex(0xBBBBBB, 6), 10) Or _ColorCheck(_GetPixelColor(217, 297), Hex(0xF8AD20, 6), 10) Then
		return True
	EndIf
	Return False
EndFunc   ;==>isBarrack