Scriptname AB_PlayerREFLoadScript extends ReferenceAlias

AB_SleepQuestScript Property QuestScript Auto
GlobalVariable Property AB_LoadTape Auto

Event OnPlayerLoadGame()
	If AB_LoadTape.getvalue() == 0
	QuestScript.Maintenance()
EndIf
EndEvent