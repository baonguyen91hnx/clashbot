; check Wall function | safar46

Global $Wall[7]
$Wall[0] = @ScriptDir & "\images\Walls\4.bmp"
$Wall[1] = @ScriptDir & "\images\Walls\5.bmp"
$Wall[2] = @ScriptDir & "\images\Walls\6.bmp"
$Wall[3] = @ScriptDir & "\images\Walls\7.bmp"
$Wall[4] = @ScriptDir & "\images\Walls\8.bmp"
$Wall[5] = @ScriptDir & "\images\Walls\9.bmp"
$Wall[6] = @ScriptDir & "\images\Walls\10.bmp"

Global $WallX = 0, $WallY = 0, $WallLoc = 0
Global $Tolerance2 = 50

Func checkWall()
    If _Sleep(500) Then Return
	_CaptureRegion()
	$WallLoc = _ImageSearch($Wall[$icmbWalls], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
	If $WallLoc = 1 Then
	   SetLog("Found Walls level " & $icmbWalls+4 & ", Upgrading...", $COLOR_GREEN)
	   Return True
    EndIf
	SetLog("Cannot find Walls level " & $icmbWalls+4 & ", Skip upgrade...", $COLOR_RED)
	Return False
EndFunc