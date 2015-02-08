#RequireAdmin
#AutoIt3Wrapper_UseX64=n
#pragma compile(Icon, "Icons\cocbot.ico")
#pragma compile(FileDescription, Clash of Clans Bot - A Free/Open Sourced Clash of Clans bot - https://the.bytecode.club)
#pragma compile(ProductName, Clash of Clans Bot)
#pragma compile(ProductVersion, 5.5.1.1)
#pragma compile(FileVersion, 5.5.1.1)
#pragma compile(LegalCopyright, © The Bytecode Club)

$sBotVersion = "5.5.1.1"
$sBotTitle = "COC Bot v" & $sBotVersion

If _Singleton($sBotTitle, 1) = 0 Then
	MsgBox(0, "", "Bot is already running.")
	Exit
 EndIf

If @AutoItX64 = 1 Then
	MsgBox(0, "", "Don't Run/Compile Script (x64)! try to Run/Compile Script (x86) to getting this bot work." & @CRLF & _
				  "If this message still appear, try to re-install your AutoIt with newer version.")
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
		SaveConfig()
		readConfig()
		applyConfig()
		$Restart = False
		$fullArmy = False
		$CommandStop = -1
		If _Sleep(1000) Then Return
		checkMainScreen()
		If _Sleep(1000) Then Return
		ZoomOut()
		If _Sleep(1000) Then Return
		If BotCommand() Then btnStop()
		If _Sleep(1000) Then Return
		ReArm()
		If _Sleep(1000) Then Return
		If $CommandStop <> 0 Then
			Train()
			If _Sleep(1000) Then ExitLoop
		EndIf
		BoostBarracks()
		If _Sleep(1000) Then ExitLoop
		RequestCC()
		If _Sleep(1000) Then Return
		DonateCC()
		If _Sleep(1000) Then Return
		Collect()
		If _Sleep(1000) Then Return
		UpgradeWall()
		If _Sleep(1000) Then Return
		Idle()
		If _Sleep(1000) Then Return
		If $CommandStop <> 0 And $CommandStop <> 3 Then
			AttackMain()
			If _Sleep(1000) Then Return
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds
		While $fullArmy = False
			If $CommandStop = -1 Then SetLog("~~~Waiting for full army~~~", $COLOR_PURPLE)
			Local $hTimer = TimerInit()
			If _Sleep(30000) Then ExitLoop
			checkMainScreen()
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
				SetLog("Army Camp and Barracks is full, stop Training...", $COLOR_ORANGE)
				$CommandStop = 3
				$fullArmy = False
			EndIf
			If $CommandStop = -1 Then
				If $fullArmy Then ExitLoop
				DropTrophy()
				If _Sleep(1000) Then ExitLoop
			EndIf
			DonateCC()
			$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
			SetLog("Time Idle: " & Floor(Floor($TimeIdle / 60) / 60) & " hours " & Floor(Mod(Floor($TimeIdle / 60), 60)) & " minutes " & Floor(Mod($TimeIdle, 60)) & " seconds", $COLOR_ORANGE)
		WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions
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

