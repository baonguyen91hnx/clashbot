;Donates troops

Func DonateCC()
	Global $Donate = True
	Local $y = 119
	Local $MatchFound = 0
	SetLog("Donating Troops", $COLOR_BLUE)
	While $Donate
	    $MatchFound = 0
		Click(1, 1) ;Click Away
		If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then
			Click(19, 349) ;Clicks chat thing
		 EndIf
	     If _Sleep(500) = True Then Return
		  Click(189, 24) ; clicking clan tab
		If _Sleep(2000) = True Then Return
		Local $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
		Global $DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		If IsArray($DonatePixel) Then
			If $ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1 Then
				_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
				Local $String = getString($DonatePixel[1] - 17)
				SetLog("Chat Text: " & $String, $COLOR_GREEN)
				If $ichkDonateBarbarians = 1 Then
					Local $Barbs = StringSplit($itxtDonateBarbarians, @CRLF)
					For $i = 0 to UBound($Barbs) - 1
						If $String = $Barbs[$i] Then
						    $MatchFound = 1
							DonateBarbs()
							ExitLoop
						EndIf
					Next
				EndIf

				If $ichkDonateArchers = 1 Then
					Local $Archers = StringSplit($itxtDonateArchers, @CRLF)
					For $i = 0 to UBound($Archers) - 1
						If $String = $Archers[$i] Then
						    $MatchFound = 1
							DonateArchers()
							ExitLoop
						EndIf
					Next
				EndIf

				If $ichkDonateGiants = 1 Then
					Local $Giants = StringSplit($itxtDonateGiants, @CRLF)
					For $i = 0 to UBound($Giants) - 1
						If $String = $Giants[$i] Then
						    $MatchFound = 1
							DonateGiants()
							ExitLoop
						EndIf
					Next
				EndIf

			   If $MatchFound = 0 Then
				  SetLog("No matches Found, switching to manual donate for this request", $COLOR_BLUE)
				  ManualDonate()
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
			$Donate = False
		EndIf
	WEnd

	If _Sleep(1000) = True Then Return
	SetLog("Finished Donating", $COLOR_BLUE)
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
	EndIf
 EndFunc   ;==>DonateCC

Func ManualDonate()
    Select
                Case $ichkDonateAllBarbarians = 1
                        DonateBarbs()
                Case $ichkDonateAllArchers = 1
                        DonateArchers()
                Case $ichkDonateAllGiants = 1
                        DonateGiants()
   EndSelect
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
			SetLog(_GetPixelColor(237, $DonatePixel[1] - 5))
			DonateArchers()
			Return
		EndIf
		If _Sleep(500) = True Then Return
		Click(1, 1, 1, 2000)
	Else
		DonateArchers()
		Return
	EndIf
EndFunc

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
EndFunc

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
			$Donate = False
		EndIf
		If _Sleep(500) = True Then Return
		Click(1, 1, 1, 2000)
	Else
		SetLog("No troops available for donation, donating later...", $COLOR_ORANGE)
		Click(1, 1, 1, 2000)
		$Donate = False
	EndIf
EndFunc