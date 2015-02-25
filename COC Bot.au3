#RequireAdmin
#AutoIt3Wrapper_UseX64=n
#pragma compile(Icon, "Icons\cocbot.ico")
#pragma compile(FileDescription, Clash of Clans Bot - A Free Clash of Clans bot - https://the.bytecode.club/)
#pragma compile(ProductName, TBC Clashbot)
#pragma compile(ProductVersion, 1.0)
#pragma compile(FileVersion, 1.0)
#pragma compile(LegalCopyright, © https://the.bytecode.club/)

$sBotVersion = "5.6.2"
$sBotTitle = "TBC Clashbot " & $sBotVersion

If _Singleton($sBotTitle, 1) = 0 Then
	MsgBox(0, "", "Bot is already running.")
	Exit
 EndIf

Local $sDestination = (@ScriptDir & "\Icons\logo.jpg")

SplashImageOn("                        Free Clash of CLans Bot Brought To You By https://the.bytecode.club", $sDestination, 500, 80)
Sleep(3000)
SplashOff()

If @AutoItX64 = 1 Then
	MsgBox(0, "", "Don't Run/Compile the Script as (x64)! try to Run/Compile the Script as (x86) to get the bot to work." & @CRLF & _
				  "If this message still appears, try to re-install AutoIt.")
	Exit
EndIf

If Not FileExists(@ScriptDir & "\License.txt") Then
	$license = InetGet("http://www.gnu.org/licenses/gpl-3.0.txt", @ScriptDir & "\License.txt")
	InetClose($license)
EndIf

#include "COCBot\Global Variables.au3"
#include "COCBot\GUI Design.au3"
#include "COCBot\GUI Control.au3"
#include "COCBot\Functions.au3"
#include-once

DirCreate($dirLogs)
DirCreate($dirLoots)
DirCreate($dirAllTowns)

While 1
	Switch TrayGetMsg()
        Case $tiAbout
			MsgBox(64 + $MB_APPLMODAL + $MB_TOPMOST, $sBotTitle, "Clash of Clans Bot" & @CRLF & @CRLF & _
					"Version: " & $sBotVersion & @CRLF & _
					"Released under the GNU GPLv3 license.", 0, $frmBot)
		Case $tiExit
			ExitLoop
	EndSwitch
WEnd

Func runBot() ;Bot that runs everything in order
	While 1
		$Restart = False
		$fullArmy = False
		$CommandStop = -1
		If _Sleep(1000) Then Return
		checkMainScreen()
		If _Sleep(1000) Then Return
		ZoomOut()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		If $Restart = True Then ContinueLoop
		If BotCommand() Then btnStop()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		If $Restart = True Then ContinueLoop
		ReArm()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		If $Restart = True Then ContinueLoop
		DonateCC()
		If _Sleep(1000) Then Return
		If $CommandStop <> 0 Then
			Train()
			If _Sleep(1000) Then Return
		EndIf
		checkMainScreen(False)
		If $Restart = True Then ContinueLoop
		BoostBarracks()
		If _Sleep(1000) Then Return
		RequestCC()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
	    If $Restart = True Then ContinueLoop
		checkMainScreen(False)
		If $Restart = True Then ContinueLoop
		Collect()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		If $Restart = True Then ContinueLoop
		UpgradeWall()

		If _Sleep(1000) Then Return
		Idle()
		If _Sleep(1000) Then Return
	    If $Restart = True Then ContinueLoop
		If $CommandStop <> 0 And $CommandStop <> 3 Then
			AttackMain()
			If _Sleep(1000) Then Return
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds
		While $fullArmy = False
			If $CommandStop = -1 Then SetLog("====== Waiting for full army ======", $COLOR_RED)
			Local $hTimer = TimerInit()
			Local $iReHere = 0
			while $iReHere < 28
				$iReHere += 1
				checkMainScreen(False)
				If _Sleep(1000) Then ExitLoop
			    If $Restart = True Then ExitLoop
			wend
			If _Sleep(1000) Then ExitLoop
			ZoomOut()
			If _Sleep(1000) Then ExitLoop
			If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
				Collect()
				If _Sleep(1000) Or $RunState = False Then ExitLoop
				$iCollectCounter = 0
			EndIf
			$iCollectCounter = $iCollectCounter + 1
			If $CommandStop <> 3 Then
				Train()
				If _Sleep(1000) Then ExitLoop
			EndIf
			If $CommandStop = 0 And $fullArmy Then
				SetLog("Army Camp and Barracks are full, stop Training...", $COLOR_ORANGE)
				$CommandStop = 3
				$fullArmy = False
			EndIf
			If $CommandStop = -1 Then
				DropTrophy()
				If $fullArmy Then ExitLoop
				If _Sleep(1000) Then ExitLoop
			EndIf
			DonateCC()
			$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
			SetLog("Time Idle: " & Floor(Floor($TimeIdle / 60) / 60) & " hours " & Floor(Mod(Floor($TimeIdle / 60), 60)) & " minutes " & Floor(Mod($TimeIdle, 60)) & " seconds", $COLOR_ORANGE)
		WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions
		SaveConfig()
		readConfig()
		applyConfig()
		PrepareSearch()
	 If _Sleep(1000) Then Return
		VillageSearch($TakeAllTownSnapShot)
	 If _Sleep(1000) Or $Restart = True Then Return
		PrepareAttack()
	 If _Sleep(1000) Then Return
		Attack()
	 If _Sleep(1000) Then Return
		ReturnHome($TakeLootSnapShot)
	 If _Sleep(1000) Then Return
EndFunc   ;==>AttackMain

Func Attack() ;Selects which algorithm
		SetLog("======Beginning Attack======")
;~ 		Switch $icmbAlgorithm
;~ 			Case 0 ;Barbarians + Archers
		  algorithm_AllTroops()
;~ 			Case 1 ;Use All Troops
;~ 				SetLog("Not Available yet, using Barch instead...", $COLOR_RED)
;~ 		  If _Sleep(2000) Then Return
;~ 		  AdvancedAttack()
;~ 		EndSwitch
EndFunc   ;==>Attack

