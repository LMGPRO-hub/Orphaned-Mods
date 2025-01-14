;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_AB_DebugSettingsTerm_0100E434 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
HoldAtBlackImod.remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
AB_LayingDown.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
Game.SetInsideMemoryHUDMode(False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
Game.getplayer().RemoveItem(AB_SettingsTape, 1, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
int itemCount = Game.getplayer().GetItemCount(AB_SettingsTape)
if (itemCount == 0)
AB_SettingsTapeRef.ForceRefTo(Game.getplayer().PlaceAtMe(AB_SettingsTape))     ;this creates a holotape in the game world and assigns it to an empty alias
game.getplayer().AddItem(AB_SettingsTapeREF.GetRef(),1,False)		
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
AB_SleepQuest.Reset()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property HoldAtBlackImod Auto Const

GlobalVariable Property AB_LayingDown Auto Const

Holotape Property AB_SettingsTape Auto Const

ReferenceAlias Property AB_SettingsTapeREF Auto Const

Quest Property AB_SleepQuest Auto Const
