;Checks if the gold/elixir changes values within 60 seconds, Returns True if changed
;If gold/elixir = "" it will return False, meaning battle is over.

Func GoldElixirChange() ;Checks 60 seconds if gold changes
	Local $Gold1, $Gold2
	While 1
		$Gold1 = getGold(51, 66)
		$Elixir1 = getElixir(51, 66 + 29)
		Local $iBegin = TimerInit()
		While TimerDiff($iBegin) < 60000
			If _Sleep(2000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(433, 549), Hex(0xFFFFFF, 6), 20) Then Return False
		WEnd
		$Gold2 = getGold(51, 66)
		$Elixir2 = getElixir(51, 66 + 29)
		If ($Gold1 = $Gold2 And $Elixir1 = $Elixir2) Or ($Gold2 = "" And $Elixir2 = "") Then
			Return False
		Else
			SetLog("Gold & Elixir change detected, waiting...", $COLOR_GREEN)
			Return True
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>GoldElixirChange