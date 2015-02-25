Func VillageReport()
    ClickP($TopLeftClient) ;Click Away
    If _Sleep(500) Then Return

   SetLog("Village Report", $COLOR_GREEN)

    $FreeBuilder = GetOther(324,23, "Builder")
    Setlog("Num. of Free Builders: " & $FreeBuilder, $COLOR_GREEN)
	$TrophyCount = getOther(50, 74, "Trophy")

    SetLog("Opening Builder page to read Resources..", $COLOR_BLUE)
    Click(388,30) ; Click Builder Button
    _CaptureRegion()
	Local $i = 0
	While _ColorCheck(_GetPixelColor(819, 39), Hex(0xF8FCFF, 6), 20) = False
	   $i += 1
	   If _Sleep(500) Then Return
	   _CaptureRegion()
	   If $i >= 20 Then ExitLoop
	WEnd
   If _ColorCheck(_GetPixelColor(318, 637), Hex(0xD854D0, 6), 20) Then
    $GoldCount   = GetOther(356,625, "Resource")
    $ElixirCount = GetOther(195,625, "Resource")
    $GemCount    = GetOther(543,625, "Gems")
    SetLog("Resources: [G]: " & $GoldCount & " [E]: " & $ElixirCount & " [GEM]: " & $GemCount, $COLOR_GREEN)
   Else
    $GoldCount   = GetOther(440,625, "Resource")
    $ElixirCount = GetOther(282,625, "Resource")
    $DarkCount   = GetOther(125,625, "Resource")
    $GemCount    = GetOther(606,625, "Gems")
    SetLog("Resources: [G]: " & $GoldCount & " [E]: " & $ElixirCount & " [D]: " & $DarkCount & " [GEM]: " & $GemCount, $COLOR_GREEN)
   EndIf
	Click (820,40) ; Close Builder/Shop
	If $FirstAttack = 0 Then
	   GUICtrlSetData($lblresultgoldtstart, $GoldCount)
	   GUICtrlSetData($lblresultelixirstart, $ElixirCount)
	   GUICtrlSetData($lblresultdestart, $DarkCount)
	   GUICtrlSetData($lblresulttrophystart, $TrophyCount)
	EndIf
	GUICtrlSetData($lblresultgoldnow, $GoldCount)
	GUICtrlSetData($lblresultelixirnow, $ElixirCount)
	GUICtrlSetData($lblresultdenow, $DarkCount)
	GUICtrlSetData($lblresulttrophynow, $TrophyCount)
	$FirstAttack = 1
EndFunc