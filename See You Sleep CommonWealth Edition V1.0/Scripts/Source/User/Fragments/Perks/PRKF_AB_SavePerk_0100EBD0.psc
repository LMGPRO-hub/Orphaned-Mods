;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Perks:PRKF_AB_SavePerk_0100EBD0 Extends Perk Hidden Const

;BEGIN FRAGMENT Fragment_Entry_00
Function Fragment_Entry_00(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
Game.requestsave()
debug.notification("AutoSaving...")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
