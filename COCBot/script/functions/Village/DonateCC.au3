;Donates troops

Func DonateCC()
	Global $Donate = $ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1 Or $ichkDonateAllBarbarians = 1 Or $ichkDonateAllArchers = 1 Or $ichkDonateAllGiants = 1
	If $Donate = False Then Return
	Local $y = 119
	SetLog("Donating Troops", $COLOR_BLUE)
		Click(1, 1) ;Click Away
		If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then Click(19, 349) ;Clicks chat thing
		If _Sleep(200) Then Return
		Click(189, 24) ; clicking clan tab
		If _Sleep(200) Then Return

	While $Donate
		While 1
			Local $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
			Global $DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
			If IsArray($DonatePixel) Then
				If ($ichkDonateAllBarbarians = 0 And $ichkDonateAllArchers = 0 And $ichkDonateAllGiants = 0) And ($ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1) Then
					_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
					Local $String = getString($DonatePixel[1] - 17)

					SetLog("Chat Text: " & $String, $COLOR_GREEN)

					If $ichkDonateBarbarians = 1 Then
						Local $Barbs = StringSplit($itxtDonateBarbarians, @CRLF)
						For $i = 0 To UBound($Barbs) - 1
							If CheckDonate($Barbs[$i], $String) Then
								DonateBarbs()
								ExitLoop
							EndIf
						Next
					EndIf

					If $ichkDonateArchers = 1 Then
						Local $Archers = StringSplit($itxtDonateArchers, @CRLF)
						For $i = 0 To UBound($Archers) - 1
							If CheckDonate($Archers[$i], $String) Then
								DonateArchers()
								ExitLoop
							EndIf
						Next
					EndIf

					If $ichkDonateGiants = 1 Then
						Local $Giants = StringSplit($itxtDonateGiants, @CRLF)
						For $i = 0 To UBound($Giants) - 1
							If CheckDonate($Giants[$i], $String) Then
								DonateGiants()
								ExitLoop
							EndIf
						Next
					EndIf
				Else
					Select
						Case $ichkDonateAllBarbarians = 1
							DonateBarbs()
						Case $ichkDonateAllArchers = 1
							DonateArchers()
						Case $ichkDonateAllGiants = 1
							DonateGiants()
					EndSelect
				EndIf
				$y = $DonatePixel[1] + 10
			Else
				Local $Scroll = _PixelSearch(285, 650, 287, 700, Hex(0x97E405, 6), 20)
				If IsArray($Scroll) Then
					Click($Scroll[0], $Scroll[1])
					$y = 119
					If _Sleep(700) Then Return
				Else
					$Donate = False
					ExitLoop
				EndIf
			EndIf
		WEnd
	WEnd

	If _Sleep(1000) = True Then Return
	SetLog("Finished Donating", $COLOR_BLUE)
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
	EndIf
EndFunc   ;==>DonateCC

Func CheckDonate($string, $clanString) ;Checks if it exact
	$Contains = StringMid($string, 1, 1) & StringMid($string, StringLen($string), 1)
	If $Contains = "[]" Then
		If $clanString = StringMid($string, 2, StringLen($string) - 2) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If StringInStr($clanString, $string, 2) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc

Func DonateBarbs()
	If $ichkDonateBarbarians = 1 Or $ichkDonateAllBarbarians = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) = True Then Return
		_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(237, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Barbarians", $COLOR_BLUE)
			If _Sleep(500) = True Then Return
			Click(237, $DonatePixel[1] - 5, 5, 50)
		Else
			DonateArchers()
			Return
		EndIf
		If _Sleep(500) = True Then Return
		Click(1, 1, 1, 2000)
	Else
		DonateArchers()
		Return
	EndIf
EndFunc   ;==>DonateBarbs

Func DonateArchers()
	If $ichkDonateArchers = 1 Or $ichkDonateAllArchers = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) = True Then Return
		_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(315, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Archers", $COLOR_BLUE)
			If _Sleep(500) = True Then Return
			Click(315, $DonatePixel[1] - 5, 5, 50)
		Else
			DonateGiants()
			Return
		EndIf
		If _Sleep(500) = True Then Return
		Click(1, 1, 1, 2000)
	Else
		DonateGiants()
		Return
	EndIf
EndFunc   ;==>DonateArchers

Func DonateGiants()
	If $ichkDonateGiants = 1 Or $ichkDonateAllGiants = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) = True Then Return
		_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(480, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Giants", $COLOR_BLUE)
			If _Sleep(500) = True Then Return
			Click(480, $DonatePixel[1] - 5, 5, 50)
		Else
			SetLog("No troops available for donation, donating later...", $COLOR_ORANGE)
		EndIf
		If _Sleep(500) = True Then Return
		Click(1, 1, 1, 2000)
	Else
		SetLog("No troops available for donation, donating later...", $COLOR_ORANGE)
		Click(1, 1, 1, 2000)
	EndIf
EndFunc   ;==>DonateGiants
