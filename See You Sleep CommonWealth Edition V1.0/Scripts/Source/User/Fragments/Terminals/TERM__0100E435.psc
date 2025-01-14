;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM__0100E435 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
If AB_SleepToggle.getvalue() == 1
AB_Sleeptoggle.setvalue(0)
Debug.notification("Animations De-activated")

game.getplayer().removeperk(AB_BedPerk)
game.getplayer().Addperk(AB_SavePerk)

else
AB_Sleeptoggle.setvalue(1)
Debug.notification("Animations Activated")

game.getplayer().removeperk(AB_SavePerk)
game.getplayer().Addperk(AB_BedPerk)
Endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
If AB_Undress.getvalue() == 1
 AB_Undress.setvalue(0)
Debug.notification("Undress function De-activated")
else
AB_Undress.setvalue(1)
Debug.notification("Undress function Activated")
Endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
If AB_PlayerUndress.getvalue() == 1
 AB_PlayerUndress.setvalue(0)
Debug.notification("Player Undress function De-activated")
else
AB_PlayerUndress.setvalue(1)
Debug.notification("Player Undress function Activated")
Endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
If AB_Pipboymod.getvalue() == 0 
AB_Pipboymod.setvalue(1)
Debug.notification("You are now using modded pipboy settings")
Else
AB_Pipboymod.setvalue(0)
Debug.notification("You are now usingVanilla pipboy settings")
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
If AB_SoundFXglobal.getvalue() == 1
AB_SoundFXGlobal.setvalue(0)
Debug.notification("sound effects De-activated")
else
AB_SoundFXGlobal.setvalue(1)
Debug.notification("sound effects Activated")
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property AB_SleepToggle Auto Const

GlobalVariable Property AB_Undress Auto Const

GlobalVariable Property AB_PipboyMod Auto Const

GlobalVariable Property AB_PlayerUndress Auto Const

Perk Property AB_SavePerk Auto Const

Perk Property AB_Bedperk Auto Const

GlobalVariable Property AB_SoundFXGlobal Auto Const
