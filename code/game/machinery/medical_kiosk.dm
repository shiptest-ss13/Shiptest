//The Medical Kiosk is designed to act as a low access alernative to  a medical analyzer, and doesn't require breaking into medical. Self Diagnose at your heart's content!
//For a fee that is. Comes in 4 flavors of medical scan.

/// Shows if the machine is being used for a general scan.
#define KIOSK_SCANNING_GENERAL (1<<0)
/// Shows if the machine is being used for a disease scan.
#define KIOSK_SCANNING_SYMPTOMS (1<<1)
/// Shows if the machine is being used for a radiation/brain trauma scan.
#define KIOSK_SCANNING_NEURORAD (1<<2)
/// Shows if the machine is being used for a reagent scan.
#define KIOSK_SCANNING_REAGENTS (1<<3)

/obj/machinery/medical_kiosk
	name = "medical kiosk"
	desc = "A freestanding medical kiosk, which can provide a wide range of medical analysis for diagnosis."
	icon = 'icons/obj/machines/medical_kiosk.dmi'
	icon_state = "kiosk"
	base_icon_state = "kiosk"
	layer = ABOVE_MOB_LAYER
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_LOW
	circuit = /obj/item/circuitboard/machine/medical_kiosk
	var/obj/item/scanner_wand
	/// Emag mode
	var/pandemonium = FALSE

	/// Shows whether the kiosk is being used to scan someone and what it's being used for.
	var/scan_active = NONE

	/// The patient that the kiosk is currently scanning.
	var/mob/living/carbon/human/altPatient

/obj/machinery/medical_kiosk/Initialize() //loaded subtype for mapping use
	. = ..()
	scanner_wand = new/obj/item/scanner_wand(src)

/obj/machinery/medical_kiosk/proc/clearScans() //Called it enough times to be it's own proc
	scan_active = NONE
	update_appearance()
	return

/obj/machinery/medical_kiosk/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
		return ..()
	if(!is_operational)
		icon_state = "[base_icon_state]_off"
		return ..()
	icon_state = "[base_icon_state][scan_active ? "active" : null]"
	return ..()

/obj/machinery/medical_kiosk/wrench_act(mob/living/user, obj/item/I) //Allows for wrenching/unwrenching the machine.
	..()
	default_unfasten_wrench(user, I, time = 10)
	return TRUE

/obj/machinery/medical_kiosk/attackby(obj/item/O, mob/user, params)
	if(default_deconstruction_screwdriver(user, "[base_icon_state]_open", "[base_icon_state]_off", O))
		return
	else if(default_deconstruction_crowbar(O))
		return

	if(istype(O, /obj/item/scanner_wand))
		var/obj/item/scanner_wand/W = O
		if(scanner_wand)
			to_chat(user, span_warning("There's already a scanner wand in [src]!"))
			return
		if(HAS_TRAIT(O, TRAIT_NODROP) || !user.transferItemToLoc(O, src))
			to_chat(user, span_warning("[O] is stuck to your hand!"))
			return
		user.visible_message(span_notice("[user] snaps [O] onto [src]!"), \
		span_notice("You press [O] into the side of [src], clicking into place."))
		//This will be the scanner returning scanner_wand's selected_target variable and assigning it to the altPatient var
		if(W.selected_target)
			if(!(altPatient == W.return_patient()))
				clearScans()
			altPatient = W.return_patient()
			user.visible_message(span_notice("[W.return_patient()] has been set as the current patient."))
			W.selected_target = null
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		scanner_wand = O
		return
	return ..()

/obj/machinery/medical_kiosk/AltClick(mob/living/carbon/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(!scanner_wand)
		to_chat(user, span_warning("The scanner wand is currently removed from the machine."))
		return
	if(!user.put_in_hands(scanner_wand))
		to_chat(user, span_warning("The scanner wand falls to the floor."))
		scanner_wand = null
		return
	user.visible_message(span_notice("[user] unhooks the [scanner_wand] from [src]."), \
	span_notice("You detach the [scanner_wand] from [src]."))
	playsound(src, 'sound/machines/click.ogg', 60, TRUE)
	scanner_wand = null

/obj/machinery/medical_kiosk/Destroy()
	QDEL_NULL(scanner_wand)
	return ..()

/obj/machinery/medical_kiosk/emag_act(mob/user)
	..()
	if(obj_flags & EMAGGED)
		return
	if(user)
		user.visible_message(span_warning("[user] waves a suspicious card by the [src]'s biometric scanner!"),
	span_notice("You overload the sensory electronics, the diagnostic readouts start jittering across the screen.."))
	obj_flags |= EMAGGED
	var/obj/item/circuitboard/computer/cargo/board = circuit
	board.obj_flags |= EMAGGED //Mirrors emag status onto the board as well.
	pandemonium = TRUE

/obj/machinery/medical_kiosk/examine(mob/user)
	. = ..()
	if(scanner_wand == null)
		. += span_notice("\The [src] is missing its scanner.")
	else
		. += span_notice("\The [src] has its scanner clipped to the side. Alt-Click to remove.")

/obj/machinery/medical_kiosk/ui_interact(mob/user, datum/tgui/ui)
	var/patient_distance = 0
	if(!ishuman(user))
		to_chat(user, span_warning("[src] is unable to interface with non-humanoids!"))
		if (ui)
			ui.close()
		return
	patient_distance = get_dist(src.loc,altPatient)
	if(altPatient == null)
		say("Scanner reset.")
		altPatient = user
	else if(patient_distance>5)
		altPatient = null
		say("Patient out of range. Resetting biometrics.")
		clearScans()
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MedicalKiosk", name)
		ui.open()
		icon_state = "[base_icon_state]_active"
		RefreshParts()

/obj/machinery/medical_kiosk/ui_data(mob/living/carbon/human/user)
	var/list/data = list()
	var/patient_name = altPatient.name
	var/patient_status = "Alive."
	var/max_health = altPatient.maxHealth
	var/total_health = altPatient.health
	var/brute_loss = altPatient.getBruteLoss()
	var/fire_loss = altPatient.getFireLoss()
	var/tox_loss = altPatient.getToxLoss()
	var/oxy_loss = altPatient.getOxyLoss()
	var/chaos_modifier = 0

	var/sickness = "Patient does not show signs of disease."
	var/sickness_data = "Not Applicable."

	var/bleed_status = "Patient is not currently bleeding."
	var/blood_status = " Patient either has no blood, or does not require it to function."
	var/blood_percent =  round((altPatient.blood_volume / BLOOD_VOLUME_NORMAL)*100)
	var/blood_type = altPatient.dna.blood_type.name
	var/blood_warning = " "

	for(var/thing in altPatient.diseases) //Disease Information
		var/datum/disease/D = thing
		if(!(D.visibility_flags & HIDDEN_SCANNER))
			sickness = "Warning: Patient is harboring some form of viral disease. Seek further medical attention."
			sickness_data = "\nName: [D.name].\nType: [D.spread_text].\nStage: [D.stage]/[D.max_stages].\nPossible Cure: [D.cure_text]"

	if(altPatient.has_dna()) //Blood levels Information
		if(altPatient.is_bleeding())
			bleed_status = "Patient is currently bleeding!"
		if(blood_percent <= 80)
			blood_warning = " Patient has low blood levels. Seek a large meal, or iron supplements."
		if(blood_percent <= 60)
			blood_warning = " Patient has DANGEROUSLY low blood levels. Seek a blood transfusion, iron supplements, or saline glucose immedietly. Ignoring treatment may lead to death!"
		blood_status = "Patient blood levels are currently reading [blood_percent]%. Patient has [ blood_type] type blood. [blood_warning]"

	var/rad_sickness_value = altPatient.radiation
	var/rad_sickness_status = "Target within normal-low radiation levels."
	var/rad_contamination_value = get_rad_contamination(altPatient)
	var/rad_contamination_status = "Target clothes and person not radioactive"

	var/trauma_status = "Patient is free of unique brain trauma."
	var/clone_loss = altPatient.getCloneLoss()
	var/brain_loss = altPatient.getOrganLoss(ORGAN_SLOT_BRAIN)
	var/brain_status = "Brain patterns normal."
	if(LAZYLEN(user.get_traumas()))
		var/list/trauma_text = list()
		for(var/datum/brain_trauma/B in altPatient.get_traumas())
			var/trauma_desc = ""
			switch(B.resilience)
				if(TRAUMA_RESILIENCE_SURGERY)
					trauma_desc += "severe "
				if(TRAUMA_RESILIENCE_LOBOTOMY)
					trauma_desc += "deep-rooted "
				if(TRAUMA_RESILIENCE_MAGIC, TRAUMA_RESILIENCE_ABSOLUTE)
					trauma_desc += "permanent "
			trauma_desc += B.scan_desc
			trauma_text += trauma_desc
		trauma_status = "Cerebral traumas detected: patient appears to be suffering from [english_list(trauma_text)]."

	var/chemical_list = list()
	var/overdose_list = list()
	var/addict_list = list()
	var/hallucination_status = "Patient is not hallucinating."

	if(altPatient.reagents.reagent_list.len)	//Chemical Analysis details.
		for(var/datum/reagent/R in altPatient.reagents.reagent_list)
			chemical_list += list(list("name" = R.name, "volume" = round(R.volume, 0.01)))
			if(R.overdosed)
				overdose_list += list(list("name" = R.name))
	var/obj/item/organ/stomach/belly = altPatient.getorganslot(ORGAN_SLOT_STOMACH)
	if(belly?.reagents.reagent_list.len) //include the stomach contents if it exists
		for(var/bile in belly.reagents.reagent_list)
			var/datum/reagent/bit = bile
			if(!belly.food_reagents[bit.type])
				chemical_list += list(list("name" = bit.name, "volume" = round(bit.volume, 0.01)))
			else
				var/bit_vol = bit.volume - belly.food_reagents[bit.type]
				if(bit_vol > 0)
					chemical_list += list(list("name" = bit.name, "volume" = round(bit_vol, 0.01)))

	if(altPatient.reagents.addiction_list.len)
		for(var/datum/reagent/R in altPatient.reagents.addiction_list)
			addict_list += list(list("name" = R.name))
	if (altPatient.hallucinating())
		hallucination_status = "Subject appears to be hallucinating. Suggested treatments: bedrest, mannitol or psicodine."

	if(altPatient.stat == DEAD || HAS_TRAIT(altPatient, TRAIT_FAKEDEATH) || ((brute_loss+fire_loss+tox_loss+oxy_loss+clone_loss) >= 200))  //Patient status checks.
		patient_status = "Dead."
	if((brute_loss+fire_loss+tox_loss+oxy_loss+clone_loss) >= 80)
		patient_status = "Gravely Injured"
	else if((brute_loss+fire_loss+tox_loss+oxy_loss+clone_loss) >= 40)
		patient_status = "Injured"
	else if((brute_loss+fire_loss+tox_loss+oxy_loss+clone_loss) >= 20)
		patient_status = "Lightly Injured"
	if(pandemonium || user.hallucinating())
		patient_status = pick("The only kiosk is kiosk, but is the only patient, patient?", "Breathing manually.","Constact NTOS site admin.","97% carbon, 3% natural flavoring","The ebb and flow wears us all in time.","It's Lupus. You have Lupus.","Undergoing monkey disease.")

	if((brain_loss) >= 100)   //Brain status checks.
		brain_status = "Grave brain damage detected."
	else if((brain_loss) >= 50)
		brain_status = "Severe brain damage detected."
	else if((brain_loss) >= 20)
		brain_status = "Brain damage detected."
	else if((brain_loss) >= 1)
		brain_status = "Mild brain damage detected."  //You may have a miiiild case of severe brain damage.

	if(rad_sickness_value >= 1000)  //
		rad_sickness_status = "Patient is suffering from extreme radiation poisoning, high toxen damage expected. Suggested treatment: Repeated dosages of Pentetic Acid or high amounts of Cold Seiver and anti-toxen"
	else if(rad_sickness_value >= 300)
		rad_sickness_status = "Patient is suffering from alarming radiation poisoning. Suggested treatment: Take Cold Seiver or Potassium Iodine, watch the toxen levels."
	else if(rad_sickness_value >= 100)
		rad_sickness_status = "Patient has moderate radioactive signatures. Symptoms will subside in a few minutes"

	if(rad_contamination_value >= 400)  //
		rad_contamination_status = "Patient is wearing extremely radioactive clothing.  Suggested treatment: Isolation of patient and shower, remove all clothing and objects immediatly and place in a washing machine"
	else if(rad_contamination_value >= 150)
		rad_contamination_status = "Patient is wearing alarming radioactive clothing. Suggested treatment: Scan for contaminated objects and wash them with soap and water"
	else if(rad_contamination_value >= 50)
		rad_contamination_status = "Patient has moderate radioactive clothing.  Maintain a social distance for a few minutes"


	if(pandemonium == TRUE)
		chaos_modifier = 1
	else if (user.hallucinating())
		chaos_modifier = 0.3

	data["patient_name"] = patient_name
	data["patient_health"] = round(((total_health - (chaos_modifier * (rand(1,50)))) / max_health) * 100, 0.001)
	data["brute_health"] = round(brute_loss+(chaos_modifier * (rand(1,30))),0.001)		//To break this down for easy reading, all health values are rounded to the .001 place
	data["burn_health"] = round(fire_loss+(chaos_modifier * (rand(1,30))),0.001)		//then a random number is added, which is multiplied by chaos modifier.
	data["toxin_health"] = round(tox_loss+(chaos_modifier * (rand(1,30))),0.001)		//That allows for a weaker version of the affect to be applied while hallucinating as opposed to emagged.
	data["suffocation_health"] = round(oxy_loss+(chaos_modifier * (rand(1,30))),0.001)	//It's not the cleanest but it does make for a colorful window.
	data["clone_health"] = round(clone_loss+(chaos_modifier * (rand(1,30))),0.001)
	data["brain_health"] = brain_status
	data["brain_damage"] = brain_loss+(chaos_modifier * (rand(1,30)))
	data["patient_status"] = patient_status
	data["rad_sickness_value"] = rad_sickness_value+(chaos_modifier * (rand(1,500)))
	data["rad_sickness_status"] = rad_sickness_status
	data["rad_contamination_value"] = rad_contamination_value+(chaos_modifier * (rand(1,500)))
	data["rad_contamination_status"] = rad_contamination_status
	data["trauma_status"] = trauma_status
	data["patient_illness"] = sickness
	data["illness_info"] = sickness_data
	data["bleed_status"] = bleed_status
	data["blood_levels"] = blood_percent - (chaos_modifier * (rand(1,35)))
	data["blood_status"] = blood_status
	data["chemical_list"] = chemical_list
	data["overdose_list"] = overdose_list
	data["addict_list"] = addict_list
	data["hallucinating_status"] = hallucination_status

	data["active_status_1"] = scan_active & KIOSK_SCANNING_GENERAL // General Scan Check
	data["active_status_2"] = scan_active & KIOSK_SCANNING_SYMPTOMS // Symptom Scan Check
	data["active_status_3"] = scan_active & KIOSK_SCANNING_NEURORAD // Radio-Neuro Scan Check
	data["active_status_4"] = scan_active & KIOSK_SCANNING_REAGENTS // Reagents/hallucination Scan Check
	return data

/obj/machinery/medical_kiosk/ui_act(action,active)
	. = ..()
	if(.)
		return

	switch(action)
		if("beginScan_1")
			scan_active |= KIOSK_SCANNING_GENERAL
		if("beginScan_2")
			scan_active |= KIOSK_SCANNING_SYMPTOMS
		if("beginScan_3")
			scan_active |= KIOSK_SCANNING_NEURORAD
		if("beginScan_4")
			scan_active |= KIOSK_SCANNING_REAGENTS
		if("clearTarget")
			altPatient = null
			clearScans()
			. = TRUE
