Scriptname AB_SleepQuestScript extends Quest

;*********************************************************
;Properties
;*********************************************************

Perk Property AB_BedPerk Auto Mandatory 
imagespacemodifier Property HoldAtBlackImod Auto Mandatory 
imagespacemodifier Property FadefromBlackImod Auto Mandatory
GlobalVariable Property AB_LayingDown Auto Mandatory 
GlobalVariable Property AB_Pipboymod Auto Mandatory 
GlobalVariable Property AB_Undress Auto Mandatory 
GlobalVariable Property AB_PlayerUndress Auto Mandatory
GlobalVariable Property AB_SoundFXglobal Auto Mandatory
Holotape Property AB_SettingsTape Auto Mandatory 
ReferenceAlias Property AB_SettingsTapeREF Auto Mandatory 
Keyword Property WeaponTypeJunkJet Auto Mandatory 
Keyword Property WeaponTypeSyringer Auto Mandatory 
Keyword Property ArmorTypePower Auto Mandatory
Armor Property AB_Ring Auto Mandatory 
Armor Property Pipboy Auto Mandatory 
sound Property AB_Fyawn Auto Mandatory 
sound Property AB_Myawn Auto Mandatory 
sound Property AB_SexFX Auto Mandatory
sound Property AB_SexFXM Auto Mandatory
SoundCategory Property AudioCategoryVOCGeneral Auto Mandatory
ReferenceAlias Property Companion Auto Const
RefCollectionAlias Property ActiveCompanions const auto
ReferenceAlias Property SleepCompanion Auto Const

;*********************************************************
;Variables
;*********************************************************

Actor PlayerRef 
Bool bRemovedPipboy
Bool SleepingWithLover
Actor SleepCompanionActor
ObjectReference BedRef

;*********************************************************
;Events
;*********************************************************

Event OnQuestInit()
	PlayerRef = Game.GetPlayer()
    self.RegisterForRemoteEvent(AB_BedPerk, "OnEntryRun")
    if !PlayerREF.HasPerk(AB_BedPerk)
    	PlayerREF.addperk(AB_BedPerk)
    EndIf    
  	Maintenance()
  	Debug.Notification("Sleep Quest Running")
EndEvent

Event Perk.OnEntryRun(Perk AB_BedPerk, int Fragment_Entry_00, ObjectReference akTarget, Actor akOwner)	
	If !PlayerREF.WornHasKeyword(ArmorTypePower) && !aktarget.IsFurnitureMarkerInUse(0) || !aktarget.IsFurnitureMarkerInUse(1) ;aktarget.HasKeyword(AB_Doublebed) && PlayerREF.GetEquippedWeapon().HasKeyword(WeaponTypeJunkJet) || PlayerREF.GetEquippedWeapon().HasKeyword(WeaponTypeSyringer)
	BedRef = akTarget
	RegisterForPlayerSleep()
	Debug.trace("Registered for Sleep event with " + aktarget, 0)
	EndIf
EndEvent	
	
Event OnPlayerSleepStart(float afSleepStartTime, float afDesiredSleepEndTime, ObjectReference akBed)
	HoldAtBlackImod.Apply()
	debug.trace("sleep started in bed " + akbed, 0)
	Game.SetCharGenHUDMode(3)
;----------------companion un-equip items-----------------------------
			if AB_Undress.getvalue() == 1 &&!PlayerREF.WornHasKeyword(ArmorTypePower)
				UndressNearbyCompanion()
				;CompanionUnequip()	---- function no longer used																											
			EndIf
EndEvent

Event OnPlayerSleepStop(bool abInterrupted, ObjectReference akBed)
		utility.wait(0.1)
		if abInterrupted == False
			If !PlayerREF.WornHasKeyword(ArmorTypePower) && !BedREF.IsFurnitureMarkerInUse(0) || !BedREF.IsFurnitureMarkerInUse(1) 
				PlayerREF.MoveTo(akbed)
				Game.ForceThirdPerson()
				AB_LayingDown.SetValue(1.0)
				RegisterForRemoteEvent(Bedref, "OnExitfurniture")
				Debug.trace("Moved to " + akBed, 0)
			EndIf
		Else
;--------------Play tired soundeffect if sleep is interupted---------------------------------
			ActorBase PlayerBase = PlayerREF.GetBaseObject() as ActorBase
			If PlayerBase.GetSex() == 0															
				AB_Myawn.Play(PlayerREF)
			ElseIf PlayerBase.GetSex() == 1
				AB_Fyawn.Play(PlayerREF)
			EndIf
		EndIf
;-----------------make sure we restore HUD and unregister for sleep event--------------------
			Game.SetCharGenHUDMode(0)
			UnregisterForPlayerSleep()																
;---------------Player undress---------------------------------------------------------------
			if AB_PlayerUndress.GetValue() == 1	&& !PlayerREF.WornHasKeyword(ArmorTypePower)		
				PlayerREF.UnequipAll()															
				bRemovedPipboy = 1
			EndIf

;--------------Play sound effects if companion is lover--------------------------------------
			if AB_SoundFXglobal.getvalue() == 1 && SleepingWithLover == true && !PlayerREF.WornHasKeyword(ArmorTypePower)
				PlaySounds()
			Else
;----------Just remove Imod instead----------------------------------------------------------
				HoldAtBlackImod.PopTo(FadefromBlackImod, 1.0)
				Utility.Wait(1.0)
				HoldAtBlackImod.remove()
				FadefromBlackImod.Remove()
				utility.wait(1.0)
;---------------create save...unless Bethesda breaks this again...---------------------------
				Game.RequestSave()														
			EndIf

			If bRemovedPipboy == 1 || !PlayerRef.IsEquipped(Pipboy)
				ReEquipPipboy()
			EndIf 
EndEvent

;*******************************************************************************************************
;                         BROKEN BY BETHESDA!!! GRRRRRRRR
;*******************************************************************************************************

;Event ObjectReference.OnExitFurniture(ObjectReference akSender, ObjectReference akActionRef)
;	utility.wait(0.5)
;	if akActionRef == PlayerREF
;	debug.trace("Player Exiting furniture", 0) 
;	AB_LayingDown.SetValue(0.0)
		;if Game.GetDifficulty() == 6
;			Game.RequestAutoSave()
;			Debug.Notification("Exiting Furniture")
		;	Game.RequestAutoSave()
		;EndIf
;--------------SafeGuard in case imod or hud haven't been restored---------------
				;HoldAtBlackImod.remove()
				;FadefromBlackImod.Remove()														
				;Game.SetCharGenHUDMode(0)
				;UnregisterForPlayerSleep()
;				UnregisterForRemoteEvent(Bedref, "OnExitfurniture")													
	;EndIf	
;EndEvent

;*********************************************************
;Functions
;*********************************************************

actor Function GetNearbyInfatuatedRomanticCompanion()
	Actor NearbyInfatuatedActor
	CompanionActorScript CompanionActor = Companion.GetActorReference() as CompanionActorScript
;-----------------------if your current companion is infatuated, then use that-------------------------------
	if CompanionActor && CompanionActor.IsInfatuated() && CompanionActor.IsRomantic() && CompanionActor.IsPlayerNearby()
		NearbyInfatuatedActor = CompanionActor
	else
;-------------------loop through active companions seeing who is nearby and infatuated, use the closest------
		int i = 0
		while (i < ActiveCompanions.GetCount())
			CompanionActor = (ActiveCompanions.GetAt(i) as Actor) as CompanionActorScript

			if CompanionActor && CompanionActor.IsInfatuated() && CompanionActor.IsRomantic() && CompanionActor.IsPlayerNearby()
				if NearbyInfatuatedActor == false
					NearbyInfatuatedActor = CompanionActor
				else
					if NearbyInfatuatedActor.GetDistance(PlayerRef) > CompanionActor.GetDistance(PlayerRef)
						NearbyInfatuatedActor = CompanionActor
					endif
				endif
			endif
			i += 1
		endwhile
	endif
	Debug.Trace("nearby notified actor" + NearbyInfatuatedActor, 0)
	return NearbyInfatuatedActor
EndFunction 

Function UndressNearbyCompanion()
	SleepingWithLover = 1
	SleepCompanionActor = GetNearbyInfatuatedRomanticCompanion()

	if SleepCompanionActor && !SleepCompanionActor.WornHasKeyword(ArmorTypePower)
		SleepCompanionActor.EquipItem(AB_Ring, True, True)
   		Utility.Wait(0.01)
  		SleepCompanionActor.UnequipItem(AB_Ring, False, True)	
   		Utility.Wait(0.01)
  		SleepCompanionActor.RemoveItem(AB_Ring, -1, True, None)
   		SleepCompanionActor.UnequipAll()
   	EndIf
EndFunction
 
Function ReEquipPipboy()		
		If AB_Pipboymod.getvalue() == 0 
			Utility.Wait(0.01)
			PlayerREF.EquipItem(Pipboy, False, True)
			bRemovedPipboy = 0
		Else
;------------------Should we force-equip the Pipboy? - All Steve40 right here--------------------
			If (Game.IsPluginInstalled("AutoUnequipPipboy.esp") || Game.IsPluginInstalled("PipboyRemover.esp") || Game.IsPluginInstalled("PipBoyCustomisationFramework.esm")) && !PlayerREF.IsEquipped(Game.GetForm(0x00021b3b))
				debug.trace("Unequip pipboy mod present")
			ElseIf Game.IsPluginInstalled("PipBoyCustomisationFramework.esm") && PlayerREF.IsEquipped(Game.GetFormFromFile(0x00000C01, "PipBoyCustomisationFramework.esm") as Armor)
					Armor PipBoyMod = Game.GetFormFromFile(0x00000C01, "PipBoyCustomisationFramework.esm") as Armor
						If !PlayerREF.IsEquipped(PipBoyMod)
							PlayerREF.EquipItem(PipBoyMod, False, True)
						EndIf
			Else
				PlayerREF.EquipItem(Pipboy, False, True)
			EndIf
		EndIf
EndFunction

Function PlaySounds()
		AudioCategoryVOCGeneral.mute()
		InputEnableLayer myLayer = InputEnableLayer.Create()
		myLayer.DisablePlayerControls(True, True, True, True, True, True, True, True, True, True, True)
;------------Male female check---------------------------------------		
		If SleepCompanionActor && SleepCompanionActor.GetactorBase().GetSex() == 1
			AB_SexFX.PlayAndWait(PlayerREF)
		Elseif SleepCompanionActor && SleepCompanionActor.GetactorBase().GetSex() == 0
			AB_SexFXM.PlayAndWait(PlayerREF)
		EndIf
;-----------Fade game back in after sound FX-------------------------
		HoldAtBlackImod.PopTo(FadefromBlackImod, 1.0)
		Utility.Wait(1.0)
		HoldAtBlackImod.remove()									
		FadefromBlackImod.Remove()
		mylayer.Delete()
		myLayer = None
		SleepingWithLover = False
		AudioCategoryVOCGeneral.unmute()
		Utility.Wait(1.0)
;---------------create save...unless Bethesda breaks this again...---------
		Game.RequestSave()	
EndFunction

Function Maintenance()
 int itemCount = PlayerREF.GetItemCount(AB_SettingsTape)
	If (itemCount == 0)
;-----------------------Creates a holotape in the game world and assigns it to an empty alias------------------------------
		AB_SettingsTapeRef.ForceRefTo(PlayerREF.PlaceAtMe(AB_SettingsTape))     							
		PlayerREF.AddItem(AB_SettingsTapeREF.GetRef(),1,False)		
	EndIf
EndFunction

;------Beta undress code------------

;**************no longer used much better way to handle this*************

;Function CompanionUnequip()	
;   Actor[] PlayerFollowers = Game.GetPlayerFollowers()
;   int CurrentFollowerIndex = 0
;      	while (CurrentFollowerIndex < PlayerFollowers.Length)
;        	CompanionActorScript Companion = PlayerFollowers[CurrentFollowerIndex] as CompanionActorScript
;         		if Companion.isInfatuated() && Companion.IsRomantic() && !Companion.WornHasKeyword(ArmorTypePower)
;            		PlayerFollowers[CurrentFollowerIndex].EquipItem(AB_Ring, True, True)
;            		Utility.Wait(0.01)
;            		PlayerFollowers[CurrentFollowerIndex].UnequipItem(AB_Ring, False, True)	
;            		Utility.Wait(0.01)
;            		PlayerFollowers[CurrentFollowerIndex].RemoveItem(AB_Ring, -1, True, None)
;            		PlayerFollowers[CurrentFollowerIndex].UnequipAll()
;            		SleepingWithLover = 1
;         		EndIf
;      			CurrentFollowerIndex += 1
;      EndWhile
;EndFunction

