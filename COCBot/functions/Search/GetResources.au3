;Uses the getGold,getElixir... functions and uses CompareResources until it meets conditions.
;Will wait ten seconds until getGold returns a value other than "", if longer than 10 seconds - calls checkNextButton
;-clicks next if checkNextButton returns true, otherwise will restart the bot.

Func GetResources() ;Reads resources
	While 1
		Local $i = 0
	    _CaptureRegion()
	   Local $pixel1[3] = [3, 4, 0xEEF2F6], $pixel2[3] = [855, 5, 0xFEFFFF], $pixel3[3] = [3, 671, 0xEFF4F6]
	   While boolPixelSearch($pixel1, $pixel2, $pixel3)
		  If _Sleep(1000) Then ExitLoop (2)
		  _CaptureRegion()
	   WEnd
		While getGold(51, 66) = "" ; Loops until gold is readable
			If _Sleep(1000) Then ExitLoop (2)
			$i += 1
			If $i >= 20 Then ; If gold cannot be read by 10 seconds
				If checkNextButton() Then
					Click(750, 500) ;Click Next
				Else
					SetLog("Cannot locate Next button, Restarting Bot", $COLOR_RED)
					checkMainScreen()
					$Restart = True
					ExitLoop (2)
				EndIf
				$i = 0
			EndIf
		WEnd
		If _Sleep(300) Then ExitLoop (2)

		$searchTH = checkTownhall()
		$searchGold = getGold(51, 66)
		$searchElixir = getElixir(51, 66 + 29)
		$searchTrophy = getTrophy(51, 66 + 90)

		If $searchTrophy <> "" Then
			$searchDark = getDarkElixir(51, 66 + 57)
		Else
			$searchDark = 0
			$searchTrophy = getTrophy(51, 66 + 60)
		EndIf

		If $THx > 227 And $THx < 627 And $THy > 151 And $THy < 419 And $searchTH <> "-" Then
			$THLoc = "Inside"
		Elseif $searchTH <> "-" Then
			$THLoc = "Outside"
		Else
			$THLoc = $searchTH
			$THx = 0
			$THy = 0
		EndIf

		$SearchCount += 1 ; Counter for number of searches
		SetLog("(" & $SearchCount & ") [G]: " & $searchGold & Tab($searchGold, 7) & "[E]: " & $searchElixir & Tab($searchElixir, 7) & "[D]: " & $searchDark & Tab($searchDark, 7) & "[T]: " & $searchTrophy & Tab($searchTrophy, 5) & "[TH]: " & $searchTH & ", " & $THLoc, $COLOR_BLUE)
		ExitLoop
	WEnd
EndFunc   ;==>GetResources