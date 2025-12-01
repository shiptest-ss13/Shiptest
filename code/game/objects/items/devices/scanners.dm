
/*

CONTAINS:
T-RAY
HEALTH ANALYZER
GAS ANALYZER
NANITE SCANNER
GENE SCANNER

*/

// Describes the two modes of scanning available for health analyzers
#define SCANMODE_HEALTH 0
#define SCANMODE_CHEMICAL 1
#define SCANNER_VERBOSE 2

/obj/item/t_scanner
	name = "\improper T-ray scanner"
	desc = "A terahertz-ray emitter and scanner used to detect underfloor objects such as cables and pipes."
	custom_price = 150
	icon = 'icons/obj/tools.dmi'
	icon_state = "t-ray0"
	var/on = FALSE
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	custom_materials = list(/datum/material/iron=150)

/obj/item/t_scanner/proc/toggle_on()
	on = !on
	icon_state = copytext_char(icon_state, 1, -1) + "[on]"
	if(on)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/t_scanner/attack_self(mob/user)
	toggle_on()

/obj/item/t_scanner/cyborg_unequip(mob/user)
	if(!on)
		return
	toggle_on()

/obj/item/t_scanner/process(seconds_per_tick)
	if(!on)
		STOP_PROCESSING(SSobj, src)
		return null
	scan()

/obj/item/t_scanner/proc/scan()
	t_ray_scan(loc)

/proc/t_ray_scan(mob/viewer, flick_time = 8, distance = 3)
	if(!ismob(viewer) || !viewer.client)
		return
	var/list/t_ray_images = list()
	for(var/obj/O in orange(distance, viewer))

		if(HAS_TRAIT(O, TRAIT_T_RAY_VISIBLE))
			var/image/I = new(loc = get_turf(O))
			var/mutable_appearance/MA = new(O)
			MA.alpha = 128
			MA.dir = O.dir
			I.appearance = MA
			t_ray_images += I
	if(t_ray_images.len)
		flick_overlay_global(t_ray_images, list(viewer.client), flick_time)

/obj/item/healthanalyzer
	name = "health analyzer"
	icon = 'icons/obj/device.dmi'
	icon_state = "analyzer-1"
	item_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	desc = "A chunky brick with a worn leather carry handle. Its thick screen and heavy redundancy makes it tough to break."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)
	var/mode = SCANNER_VERBOSE
	var/scanmode = SCANMODE_HEALTH
	var/advanced = FALSE
	var/healthmode = "analyzer-1"
	var/reagentmode = "reagentanalyzer"
	var/healthmodeinhand = "analyzer"
	var/reagentmodeinhand = "reagentanalyzer-1"
	custom_price = 300

/obj/item/healthanalyzer/attack_self(mob/user)
	playsound(get_turf(user), 'sound/machines/click.ogg', 50, TRUE)
	scanmode = (scanmode + 1) % 2
	switch(scanmode)
		if(SCANMODE_HEALTH)
			to_chat(user, span_notice("You switch the health analyzer to check physical health."))
			icon_state = healthmode
			item_state = healthmodeinhand
		if(SCANMODE_CHEMICAL)
			to_chat(user, span_notice("You switch the health analyzer to scan chemical contents."))
			icon_state = reagentmode
			item_state = reagentmodeinhand

/obj/item/healthanalyzer/attack(mob/living/M, mob/living/carbon/human/user)
	flick("[icon_state]-anim", src) //makes it so that it plays the scan animation upon scanning, including clumsy scanning
	playsound(src, 'sound/effects/fastbeep.ogg', 10)

	// Clumsiness/brain damage check
	if ((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(50))
		user.visible_message(
			span_warning("[user] analyzes the floor's vitals!"),
			span_notice("You stupidly try to analyze the floor's vitals!"),
		)

		to_chat(user, "[span_info("Analyzing results for The floor:\n\tOverall status: <b>Healthy</b>")]\
					\n[span_info("Key: <font color='blue'>Suffocation</font>/<font color='green'>Toxin</font>/<font color='#FF8000'>Burn</font>/<font color='red'>Brute</font>")]\
					\n[span_info("\tDamage specifics: <font color='blue'>0</font>-<font color='green'>0</font>-<font color='#FF8000'>0</font>-<font color='red'>0</font>")]\
					\n[span_info("Body temperature: ???")]")
		return

	user.visible_message(span_notice("[user] analyzes [M]'s vitals."), \
						span_notice("You analyze [M]'s vitals."))

	if(scanmode == SCANMODE_HEALTH)
		healthscan(user, M, mode, advanced)
	else if(scanmode == SCANMODE_CHEMICAL)
		chemscan(user, M)

	add_fingerprint(user)

// Used by the PDA medical scanner too
/proc/healthscan(mob/user, mob/living/M, mode = SCANNER_VERBOSE, advanced = FALSE, see_all_quirks = FALSE)
	if(isliving(user) && (user.incapacitated()))
		return

	// the final list of strings to render
	var/render_list = list()

	// Damage specifics
	var/oxy_loss = M.getOxyLoss()
	var/tox_loss = M.getToxLoss()
	var/fire_loss = M.getFireLoss()
	var/brute_loss = M.getBruteLoss()
	var/mob_status = (M.stat == DEAD ? span_alert("<b>Deceased</b>") : "<b>[round(M.health/M.maxHealth,0.01)*100]% healthy</b>")

	if(HAS_TRAIT(M, TRAIT_FAKEDEATH) && !advanced)
		mob_status = span_alert("<b>Deceased</b>")
		oxy_loss = max(rand(1, 40), oxy_loss, (300 - (tox_loss + fire_loss + brute_loss))) // Random oxygen loss

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.undergoing_cardiac_arrest() && H.stat != DEAD)
			render_list += "[span_alert("Subject suffering from heart attack: Apply defibrillation or other electric shock immediately!")]\n"

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(C.has_brain_worms() && (!C.has_reagent(/datum/reagent/medicine/spaceacillin) || advanced))
			render_list += "[span_danger("Foreign organism detected in subject's cranium. Recommended treatment: Dosage of sucrose solution and removal of object via surgery.")]\n"

	render_list += "[span_info("Analyzing results for [M]:")]\n<span class='info ml-1'>Overall status: [mob_status]</span>\n"

	// Damage descriptions
	if(brute_loss > 10)
		render_list += "<span class='alert ml-1'>[brute_loss > 50 ? "Severe" : "Minor"] tissue damage detected.</span>\n"

	if(fire_loss > 10)
		render_list += "<span class='alert ml-1'>[fire_loss > 50 ? "Severe" : "Minor"] burn damage detected.</span>\n"

	if(oxy_loss > 10)
		render_list += "<span class='info ml-1'>[span_alert("[oxy_loss > 50 ? "Severe" : "Minor"] oxygen deprivation detected.")]\n"

	if(tox_loss > 10)
		render_list += "<span class='alert ml-1'>[tox_loss > 50 ? "Severe" : "Minor"] amount of toxin damage detected.</span>\n"

	if(M.getStaminaLoss())
		render_list += "<span class='alert ml-1'>Subject appears to be suffering from fatigue.</span>\n"
		if(advanced)
			render_list += "<span class='info ml-1'>Fatigue Level: [M.getStaminaLoss()]%.</span>\n"

	if(M.getCloneLoss())
		render_list += "<span class='alert ml-1'>Subject appears to have [M.getCloneLoss() > 30 ? "Severe" : "Minor"] cellular damage.</span>\n"
		if(advanced)
			render_list += "<span class='info ml-1'>Cellular Damage Level: [M.getCloneLoss()].</span>\n"

	if(!M.getorganslot(ORGAN_SLOT_BRAIN)) // brain not added to carbon/human check because it's funny to get to bully simple mobs
		render_list += "<span class='alert ml-1'>Subject lacks a brain.</span>\n"

	if(ishuman(M))
		var/mob/living/carbon/human/the_dude = M
		var/datum/species/the_dudes_species = the_dude.dna.species
		if(!(NOBLOOD in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_HEART))
			render_list += "<span class='alert ml-1'>Subject lacks a heart.</span>\n"
		if(!(TRAIT_NOBREATH in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_LUNGS))
			render_list += "<span class='alert ml-1'>Subject lacks lungs.</span>\n"
		if(!(TRAIT_NOMETABOLISM in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_LIVER))
			render_list += "<span class='alert ml-1'>Subject lacks a liver.</span>\n"
		if(!(NOSTOMACH in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_STOMACH))
			render_list += "<span class='alert ml-1'>Subject lacks a stomach.</span>\n"

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(LAZYLEN(C.get_traumas()))
			var/list/trauma_text = list()
			for(var/datum/brain_trauma/B in C.get_traumas())
				var/trauma_desc = ""
				switch(B.resilience)
					if(TRAUMA_RESILIENCE_SURGERY)
						trauma_desc += "severe "
					if(TRAUMA_RESILIENCE_LOBOTOMY)
						trauma_desc += "deep-rooted "
					if(TRAUMA_RESILIENCE_WOUND)
						trauma_desc += "fracture-derived "
					if(TRAUMA_RESILIENCE_MAGIC, TRAUMA_RESILIENCE_ABSOLUTE)
						trauma_desc += "permanent "
				trauma_desc += B.scan_desc
				trauma_text += trauma_desc
			render_list += "<span class='alert ml-1'>Cerebral traumas detected: subject appears to be suffering from [english_list(trauma_text)].</span>\n"
		if(C.roundstart_quirks.len)
			render_list += "<span class='info ml-1'>Subject has the following physiological traits: [C.get_trait_string(see_all=see_all_quirks)].</span>\n"

	if(advanced)
		render_list += "<span class='info ml-1'>Brain Activity Level: [(200 - M.getOrganLoss(ORGAN_SLOT_BRAIN))/2]%.</span>\n"

	if(M.radiation)
		render_list += "<span class='alert ml-1'>Subject is "
		switch(M.radiation)
			if(0 to RAD_MOB_SAFE)
				render_list += "lightly irradiated.</span>\n"
			if(RAD_MOB_SAFE to RAD_MOB_VOMIT)
				render_list += "irradiated.</span>\n"
			if(RAD_MOB_VOMIT to INFINITY)
				render_list += "severely irradiated.</span>\n"

		if(advanced)
			render_list += "<span class='info ml-1'>Radiation Level: [M.radiation]%.</span>\n"

	if(advanced && M.hallucinating())
		render_list += "<span class='info ml-1'>Subject is hallucinating.</span>\n"

	// Body part damage report
	if(iscarbon(M) && mode == SCANNER_VERBOSE)
		var/mob/living/carbon/C = M
		var/list/damaged = C.get_damaged_bodyparts(1,1)
		if(length(damaged)>0 || oxy_loss>0 || tox_loss>0 || fire_loss>0)
			var/dmgreport = "<span class='info ml-1'>General status:</span>\
							<table class='ml-2'><tr><font face='Verdana'>\
							<td style='width:7em;'><font color='#0d5cee'>Damage:</font></td>\
							<td style='width:5em;'><font color='red'><b>Brute</b></font></td>\
							<td style='width:4em;'><font color='orange'><b>Burn</b></font></td>\
							<td style='width:4em;'><font color='green'><b>Toxin</b></font></td>\
							<td style='width:8em;'><font color='purple'><b>Suffocation</b></font></td></tr>\
							<tr><td><font color='#1d63e6'>Overall:</font></td>\
							<td><font color='red'>[CEILING(brute_loss,1)]</font></td>\
							<td><font color='orange'>[CEILING(fire_loss,1)]</font></td>\
							<td><font color='green'>[CEILING(tox_loss,1)]</font></td>\
							<td><font color='#1d63e6'>[CEILING(oxy_loss,1)]</font></td></tr>"

			for(var/o in damaged)
				var/obj/item/bodypart/org = o //head, left arm, right arm, etc.
				dmgreport += "<tr><td><font color='#1d63e6'>[capitalize(parse_zone(org.body_zone))]:</font></td>\
								<td><font color='red'>[(org.brute_dam > 0) ? "[CEILING(org.brute_dam,1)]" : "0"]</font></td>\
								<td><font color='orange'>[(org.burn_dam > 0) ? "[CEILING(org.burn_dam,1)]" : "0"]</font></td></tr>"
			dmgreport += "</font></table>"
			render_list += dmgreport // tables do not need extra linebreak

	//Eyes and ears
	if(advanced && iscarbon(M))
		var/mob/living/carbon/C = M

		// Ear status
		var/obj/item/organ/ears/ears = C.getorganslot(ORGAN_SLOT_EARS)
		var/message = "\n<span class='alert ml-2'>Subject does not have ears.</span>"
		if(istype(ears))
			message = ""
			if(HAS_TRAIT_FROM(C, TRAIT_DEAF, GENETIC_MUTATION))
				message = "\n<span class='alert ml-2'>Subject is genetically deaf.</span>"
			else if(HAS_TRAIT(C, TRAIT_DEAF))
				message = "\n<span class='alert ml-2'>Subject is deaf.</span>"
			else
				if(ears.damage)
					message += "\n<span class='alert ml-2'>Subject has [ears.damage > ears.maxHealth ? "permanent ": "temporary "]hearing damage.</span>"
				if(ears.deaf)
					message += "\n<span class='alert ml-2'>Subject is [ears.damage > ears.maxHealth ? "permanently ": "temporarily "] deaf.</span>"
		render_list += "<span class='info ml-1'>Ear status:</span>[message == "" ? "\n<span class='info ml-2'>Healthy.</span>" : message]\n"

		// Eye status
		var/obj/item/organ/eyes/eyes = C.getorganslot(ORGAN_SLOT_EYES)
		message = "\n<span class='alert ml-2'>Subject does not have eyes.</span>"
		if(istype(eyes))
			message = ""
			if(C.is_blind())
				message += "\n<span class='alert ml-2'>Subject is blind.</span>"
			if(HAS_TRAIT(C, TRAIT_NEARSIGHT))
				message += "\n<span class='alert ml-2'>Subject is nearsighted.</span>"
			if(eyes.damage > 30)
				message += "\n<span class='alert ml-2'>Subject has severe eye damage.</span>"
			else if(eyes.damage > 20)
				message += "\n<span class='alert ml-2'>Subject has significant eye damage.</span>"
			else if(eyes.damage)
				message += "\n<span class='alert ml-2'>Subject has minor eye damage.</span>"
		render_list += "<span class='info ml-1'>Eye status:</span>[message == "" ? "\n<span class='info ml-2'>Healthy.</span>" : message]\n"

	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		// Organ damage
		if (H.internal_organs && H.internal_organs.len)
			var/render = FALSE
			var/toReport = "<span class='info ml-1'>Organs:</span>\
				<table class='ml-2'><tr>\
				<td style='width:6em;'><font color='#1d63e6'><b>Organ</b></font></td>\
				[advanced ? "<td style='width:3em;'><font color='#1d63e6'><b>Dmg</b></font></td>" : ""]\
				<td style='width:12em;'><font color='#1d63e6'><b>Status</b></font></td>"

			for(var/obj/item/organ/organ in H.internal_organs)
				var/status = ""
				if (organ.organ_flags & ORGAN_FAILING) status = "<font color='#E42426'>Non-Functional</font>"
				else if (organ.damage > organ.high_threshold) status = "<font color='#EC6224'>Severely Damaged</font>"
				else if (organ.damage > organ.low_threshold) status = "<font color='#F28F1F'>Mildly Damaged</font>"
				if (status != "")
					render = TRUE
					toReport += "<tr><td><font color='#1d63e6'>[organ.name]</font></td>\
						[advanced ? "<td><font color='#1d63e6'>[CEILING(organ.damage,1)]</font></td>" : ""]\
						<td>[status]</td></tr>"

			if (render)
				render_list += toReport + "</table>" // tables do not need extra linebreak

		//Genetic damage
		if(advanced && H.has_dna())
			render_list += "<span class='info ml-1'>Genetic Stability: [H.dna.stability]%.</span>\n"

		// Species and body temperature
		var/datum/species/S = H.dna.species
		var/mutant = H.dna.check_mutation(HULK) \
			|| S.mutantlungs != initial(S.mutantlungs) \
			|| S.mutantbrain != initial(S.mutantbrain) \
			|| S.mutantheart != initial(S.mutantheart) \
			|| S.mutanteyes != initial(S.mutanteyes) \
			|| S.mutantears != initial(S.mutantears) \
			|| S.mutanthands != initial(S.mutanthands) \
			|| S.mutanttongue != initial(S.mutanttongue) \
			|| S.mutantliver != initial(S.mutantliver) \
			|| S.mutantstomach != initial(S.mutantstomach) \
			|| S.mutantappendix != initial(S.mutantappendix) \
			|| S.flying_species != initial(S.flying_species)

		render_list += "<span class='info ml-1'>Species: [S.name][mutant ? "-derived mutant" : ""]</span>\n"
	render_list += "<span class='info ml-1'>Body temperature: [round(M.bodytemperature-T0C,0.1)] &deg;C ([round(M.bodytemperature*1.8-459.67,0.1)] &deg;F)</span>\n"

	// Time of death
	if(M.tod && (M.stat == DEAD || ((HAS_TRAIT(M, TRAIT_FAKEDEATH)) && !advanced)))
		render_list += "<span class='info ml-1'>Time of Death: [M.tod]</span>\n"
		var/tdelta = round(world.time - M.timeofdeath)
		render_list += "<span class='alert ml-1'><b>Subject died [DisplayTimeText(tdelta)] ago.</b></span>\n"

// Wounds
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		var/list/wounded_parts = C.get_wounded_bodyparts()
		for(var/obj/item/bodypart/wounded_part as anything in wounded_parts)
			render_list += "<span class='alert ml-1'><b>Warning: Physical trauma[LAZYLEN(wounded_part.wounds) > 1? "s" : ""] detected in [wounded_part.name]</b>"
			for(var/datum/wound/W as anything in wounded_part.wounds)
				render_list += "<div class='ml-2'>Type: [W.name]\nSeverity: [W.severity_text()]\nRecommended Treatment: [W.treat_text]</div>\n"
			render_list += "</span>"

	for(var/thing in M.diseases)
		var/datum/disease/D = thing
		if(!(D.visibility_flags & HIDDEN_SCANNER))
			render_list += "<span class='alert ml-1'><b>Warning: [D.form] detected</b>\n\
			<div class='ml-2'>Name: [D.name].\nType: [D.spread_text].\nStage: [D.stage]/[D.max_stages].\nPossible Cure: [D.cure_text]</div>\
			</span>" // divs do not need extra linebreak

	// Lungs
	var/obj/item/organ/lungs/lungs = M.getorganslot(ORGAN_SLOT_LUNGS)
	if (lungs)
		var/initial_pressure_mult = lungs::received_pressure_mult
		if (abs(lungs.received_pressure_mult - initial_pressure_mult) > 0.01)
			var/tooltip
			var/dilation_text
			var/beginning_text = "Lung Dilation: "
			if (lungs.received_pressure_mult > initial_pressure_mult) // higher than usual
				beginning_text = span_blue("<b>[beginning_text]</b>")
				dilation_text = span_blue("[(lungs.received_pressure_mult * 100) - 100]%")
				tooltip = "Subject's lungs are dilated and breathing more air than usual. Increases the effects of inhaled gases."
			else
				beginning_text = span_danger("<b>Lung Constriction: </b>")
				if (lungs.received_pressure_mult <= 0) // lethal
					dilation_text = span_bolddanger("[100 - (lungs.received_pressure_mult * 100)]%")
					tooltip = "Subject's lungs are completely shut. Subject is unable to breathe and requires emergency surgery. If asthmatic, perform asthmatic bypass surgery and adminster salbutamol inhalant. Otherwise, replace lungs."
				else
					dilation_text = span_danger("[100 - (lungs.received_pressure_mult * 100)]%")
					tooltip = "Subject's lungs are partially shut. If unable to breathe, administer a high-pressure internals tank or replace lungs. If asthmatic, inhaled salbutamol or bypass surgery will likely help."

			var/lung_message = beginning_text + conditional_tooltip(dilation_text, tooltip, TRUE)
			render_list += lung_message

	// Blood Level
	if(M.has_dna())
		var/mob/living/carbon/C = M
		var/blood_id = C.get_blood_id()
		if(blood_id)
			if(ishuman(C))
				var/mob/living/carbon/human/H = C
				if(H.is_bleeding())
					render_list += "<span class='alert ml-1'><b>Subject is bleeding!</b></span>\n"
			var/blood_percent =  round((C.blood_volume / BLOOD_VOLUME_NORMAL)*100)
			var/blood_type = C.dna.blood_type.name
			if(blood_id != /datum/reagent/blood) // special blood substance
				var/datum/reagent/R = GLOB.chemical_reagents_list[blood_id]
				blood_type = R ? R.name : blood_id
			if(C.blood_volume <= BLOOD_VOLUME_SAFE && C.blood_volume > BLOOD_VOLUME_OKAY)
				render_list += "<span class='alert ml-1'>Blood level: LOW [blood_percent] %, [C.blood_volume] cl,</span> [span_info("type: [blood_type]")]\n"
			else if(C.blood_volume <= BLOOD_VOLUME_OKAY)
				render_list += "<span class='alert ml-1'>Blood level: <b>CRITICAL [blood_percent] %</b>, [C.blood_volume] cl,</span> [span_info("type: [blood_type]")]\n"
			else
				render_list += "<span class='info ml-1'>Blood level: [blood_percent] %, [C.blood_volume] cl, type: [blood_type]</span>\n"

		var/cyberimp_detect
		for(var/obj/item/organ/cyberimp/CI in C.internal_organs)
			if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
				cyberimp_detect += "[!cyberimp_detect ? "[CI.get_examine_string(user)]" : ", [CI.get_examine_string(user)]"]"
		if(cyberimp_detect)
			render_list += "<span class='notice ml-1'>Detected cybernetic modifications:</span>\n"
			render_list += "<span class='notice ml-2'>[cyberimp_detect]</span>\n"

	SEND_SIGNAL(M, COMSIG_NANITE_SCAN, user, FALSE)

	// we handled the last <br> so we don't need handholding
	to_chat(user, boxed_message(jointext(render_list, "")), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)

/proc/chemscan(mob/living/user, mob/living/target)
	if(user.incapacitated())
		return

	if(istype(target) && target.reagents)
		var/list/render_list = list() //The master list of readouts, including reagents in the blood/stomach, addictions, quirks, etc.
		var/list/render_block = list() //A second block of readout strings. If this ends up empty after checking stomach/blood contents, we give the "empty" header.

		// Blood reagents
		if(target.reagents.reagent_list.len)
			for(var/r in target.reagents.reagent_list)
				var/datum/reagent/reagent = r
				render_block += "<span class='notice ml-2'>[round(reagent.volume, 0.001)] units of [reagent.name][reagent.overdosed ? "</span> - [span_bolddanger("OVERDOSING")]" : ".</span>"]<br>"

		if(!length(render_block)) //If no VISIBLY DISPLAYED reagents are present, we report as if there is nothing.
			render_list += "<span class='notice ml-1'>Subject contains no reagents in their blood.</span><br>"
		else
			render_list += "<span class='notice ml-1'>Subject contains the following reagents in their blood:</span><br>"
			render_list += render_block //Otherwise, we add the header, reagent readouts, and clear the readout block for use on the stomach.
			render_block.Cut()

		// Stomach reagents
		var/obj/item/organ/stomach/belly = target.getorganslot(ORGAN_SLOT_STOMACH)
		if(belly)
			if(belly.reagents.reagent_list.len)
				for(var/bile in belly.reagents.reagent_list)
					var/datum/reagent/bit = bile
					if(!belly.food_reagents[bit.type])
						render_block += "<span class='notice ml-2'>[round(bit.volume, 0.001)] units of [bit.name][bit.overdosed ? "</span> - [span_bolddanger("OVERDOSING")]" : ".</span>"]<br>"
					else
						var/bit_vol = bit.volume - belly.food_reagents[bit.type]
						if(bit_vol > 0)
							render_block += "<span class='notice ml-2'>[round(bit_vol, 0.001)] units of [bit.name][bit.overdosed ? "</span> - [span_bolddanger("OVERDOSING")]" : ".</span>"]<br>"

			if(!length(render_block))
				render_list += "<span class='notice ml-1'>Subject contains no reagents in their stomach.</span><br>"
			else
				render_list += "<span class='notice ml-1'>Subject contains the following reagents in their stomach:</span><br>"
				render_list += render_block

		// Addictions
		if(LAZYLEN(target.reagents.addiction_list.len))
			render_list += "<span class='boldannounce ml-1'>Subject is addicted to the following types of drug:</span><br>"
			for(var/datum/reagent/R in target.reagents.addiction_list)
				render_list += "<span class='alert ml-2'>[R.name]</span>\n"

		// we handled the last <br> so we don't need handholding
		to_chat(user, boxed_message(jointext(render_list, "")), type = MESSAGE_TYPE_INFO)

/obj/item/healthanalyzer/verb/toggle_mode()
	set name = "Switch Verbosity"
	set category = "Object"

	if(usr.incapacitated())
		return

	mode = !mode
	to_chat(usr, mode == SCANNER_VERBOSE ? "The scanner now shows specific limb damage." : "The scanner no longer shows limb damage.")

/obj/item/healthanalyzer/advanced
	name = "advanced health analyzer"
	icon_state = "health_adv"
	icon_state = "advanalyzer"
	item_state = "advanalyzer"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject with high accuracy."
	advanced = TRUE
	healthmode = "advanalyzer"
	reagentmode = "advreagentanalyzer"
	healthmodeinhand = "advanalyzer"
	reagentmodeinhand = "advreagentanalyzer"

/obj/item/analyzer
	desc = "A hand-held environmental scanner which reports current gas levels. Alt-Click to use the built in barometer function."
	name = "analyzer"
	custom_price = 100
	icon = 'icons/obj/tools.dmi'
	icon_state = "analyzer"
	item_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	tool_behaviour = TOOL_ANALYZER
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=20)
	grind_results = list(/datum/reagent/mercury = 5, /datum/reagent/iron = 5, /datum/reagent/silicon = 5)
	var/cooldown = FALSE
	var/cooldown_time = 250
	var/accuracy // 0 is the best accuracy.

/obj/item/analyzer/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click [src] to activate the barometer function.")



/obj/item/analyzer/attack_self(mob/user)
	add_fingerprint(user)

	if (user.stat)
		return

	var/turf/location = user.loc
	if(!istype(location))
		return

	var/render_list = list()
	var/datum/gas_mixture/environment = location.return_air()
	var/pressure = environment.return_pressure()
	var/total_moles = environment.total_moles()

	render_list += "[span_info("<B>Results:</B>")]\
		\n<span class='[abs(pressure - ONE_ATMOSPHERE) < 10 ? "info" : "alert"]'>Pressure: [round(pressure, 0.01)] kPa</span>\n"
	if(total_moles)
		var/o2_concentration = environment.get_moles(GAS_O2)/total_moles
		var/n2_concentration = environment.get_moles(GAS_N2)/total_moles
		var/co2_concentration = environment.get_moles(GAS_CO2)/total_moles
		var/plasma_concentration = environment.get_moles(GAS_PLASMA)/total_moles

		//WS Start -- Atmos Analyzer Reformat (Issue #419)
		to_chat(user, span_boldnotice("Results of analysis."))
		to_chat(user, span_info("Pressure: [round(pressure,0.01)] kPa"))
		to_chat(user, span_info("Temperature: [round(environment.return_temperature()-T0C, 0.01)] &deg;C ([round(environment.return_temperature(), 0.01)] K)"))
		//WS End

		if(abs(n2_concentration - N2STANDARD) < 20)
			to_chat(user, span_info("Nitrogen: [round(n2_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_N2), 0.01)] mol)"))
		else
			to_chat(user, span_alert("Nitrogen: [round(n2_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_N2), 0.01)] mol)"))

		if(abs(o2_concentration - O2STANDARD) < 2)
			to_chat(user, span_info("Oxygen: [round(o2_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_O2), 0.01)] mol)"))
		else
			to_chat(user, span_alert("Oxygen: [round(o2_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_O2), 0.01)] mol)"))

		if(co2_concentration > 0.01)
			to_chat(user, span_alert("CO2: [round(co2_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_CO2), 0.01)] mol)"))
		else
			to_chat(user, span_info("CO2: [round(co2_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_CO2), 0.01)] mol)"))

		if(plasma_concentration > 0.005)
			to_chat(user, span_alert("Plasma: [round(plasma_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_PLASMA), 0.01)] mol)"))
		else
			to_chat(user, span_info("Plasma: [round(plasma_concentration*100, 0.01)] % ([round(environment.get_moles(GAS_PLASMA), 0.01)] mol)"))

		for(var/id in environment.get_gases())
			if(id in GLOB.hardcoded_gases)
				continue
			var/gas_concentration = environment.get_moles(id)/total_moles
			to_chat(user, span_alert("[GLOB.gas_data.names[id]]: [round(gas_concentration*100, 0.01)] % ([round(environment.get_moles(id), 0.01)] mol)"))

/obj/item/analyzer/AltClick(mob/user) //Barometer output for measuring when the next storm happens
	..()

	if(user.canUseTopic(src, BE_CLOSE))
		if(cooldown)
			to_chat(user, span_warning("[src]'s barometer function is preparing itself."))
			return

		var/turf/T = get_turf(user)
		if(!T)
			return

		var/datum/weather_controller/weather_controller = SSmapping.get_map_zone_weather_controller(T)
		playsound(src, 'sound/effects/pop.ogg', 100)
		var/area/user_area = T.loc
		var/datum/weather/ongoing_weather = null

		if(!user_area.outdoors && !user_area.allow_weather)
			to_chat(user, "<span class='warning'>[src]'s barometer function won't work indoors!</span>")
			return

		if(weather_controller.current_weathers)
			for(var/datum/weather/W as anything in weather_controller.current_weathers)
				if(W.barometer_predictable && W.my_controller.mapzone.is_in_bounds(T) && W.area_type == user_area.type && !(W.stage == END_STAGE))
					ongoing_weather = W
					break

		if(ongoing_weather)
			if((ongoing_weather.stage == MAIN_STAGE) || (ongoing_weather.stage == WIND_DOWN_STAGE))
				to_chat(user, span_warning("[src]'s barometer function can't trace anything while the storm is [ongoing_weather.stage == MAIN_STAGE ? "already here!" : "winding down."]"))
				return

			if(ongoing_weather.aesthetic)
				to_chat(user, span_warning("[src]'s barometer function says that the next storm will breeze on by."))
		else
			var/next_hit = weather_controller.next_weather
			var/fixed = next_hit - world.time
			if(fixed <= 0)
				to_chat(user, span_warning("[src]'s barometer function was unable to trace any weather patterns."))
			else
				to_chat(user, span_warning("[src]'s barometer function says a storm will land in approximately [butchertime(fixed)]."))
		cooldown = TRUE
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/analyzer, ping)), cooldown_time)

/obj/item/analyzer/proc/ping()
	if(isliving(loc))
		var/mob/living/L = loc
		to_chat(L, span_notice("[src]'s barometer function is ready!"))
	playsound(src, 'sound/machines/click.ogg', 100)
	cooldown = FALSE

/obj/item/analyzer/proc/butchertime(amount)
	if(!amount)
		return
	if(accuracy)
		var/inaccurate = round(accuracy*(1/3))
		if(prob(50))
			amount -= inaccurate
		if(prob(50))
			amount += inaccurate
	return DisplayTimeText(max(1,amount))

/proc/atmosanalyzer_scan(mob/user, atom/target, silent=FALSE)
	var/mixture = target.return_analyzable_air()
	if(!mixture)
		return FALSE

	var/icon = target
	var/render_list = list()
	if(!silent && isliving(user))
		user.visible_message(span_notice("[user] uses the analyzer on [icon2html(icon, viewers(user))] [target]."), span_notice("You use the analyzer on [icon2html(icon, user)] [target]."))
	render_list += span_boldnotice("Results of analysis of [icon2html(icon, user)] [target].")

	var/list/airs = islist(mixture) ? mixture : list(mixture)
	for(var/g in airs)
		if(airs.len > 1) //not a unary gas mixture
			render_list += span_boldnotice("Node [airs.Find(g)]")
		var/datum/gas_mixture/air_contents = g

		var/total_moles = air_contents.total_moles()
		var/pressure = air_contents.return_pressure()
		var/mass = air_contents.return_mass()
		var/volume = air_contents.return_volume() //could just do mixture.volume... but safety, I guess?
		var/temperature = air_contents.return_temperature()
		var/cached_scan_results = air_contents.analyzer_results

		if(total_moles > 0)
			//WS Start -- Atmos Analyzer Reformat (Issue #419)
			render_list += "[span_notice("Moles: [round(total_moles, 0.01)] mol")]\
							\n[span_notice("Volume: [volume] L")]\
							\n[span_notice("Pressure: [round(pressure,0.01)] kPa")]\
							\n[span_notice("Temperature: [round(temperature - T0C,0.01)] &deg;C ([round(temperature, 0.01)] K)")]\
							\n[span_notice("Mass: [round(mass, 0.01)] g")]\
							\n[span_notice("Density: [round(mass / volume, 0.01)] g/L")]"
			//WS End

			for(var/id in air_contents.get_gases())
				var/gas_concentration = air_contents.get_moles(id)/total_moles
				render_list += span_notice("[GLOB.gas_data.names[id]]: [round(gas_concentration*100, 0.01)] % ([round(air_contents.get_moles(id), 0.01)] mol)")  //WS Edit -- Atmos Analyzer Reformat (Issue #419)

		else
			render_list += airs.len > 1 ? span_notice("This node is empty!") : span_notice("[target] is empty!")

		if(cached_scan_results && cached_scan_results["fusion"]) //notify the user if a fusion reaction was detected
			render_list += "[span_boldnotice("Large amounts of free neutrons detected in the air indicate that a fusion reaction took place.")]\
						\n[span_notice("Instability of the last fusion reaction: [round(cached_scan_results["fusion"], 0.01)].")]"

	// we let the join apply newlines so we do need handholding
	to_chat(user, boxed_message(jointext(render_list, "\n")), type = MESSAGE_TYPE_INFO)
	return TRUE

/obj/item/nanite_scanner
	name = "nanite scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "nanite_scanner"
	item_state = "nanite_remote"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	desc = "A hand-held body scanner able to detect nanites and their programming."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)

/obj/item/nanite_scanner/attack(mob/living/M, mob/living/carbon/human/user)
	user.visible_message(span_notice("[user] analyzes [M]'s nanites."), \
						span_notice("You analyze [M]'s nanites."))

	add_fingerprint(user)

	var/response = SEND_SIGNAL(M, COMSIG_NANITE_SCAN, user, TRUE)
	if(!response)
		to_chat(user, span_info("No nanites detected in the subject."))

/obj/item/sequence_scanner
	name = "genetic sequence scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "gene"
	item_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	desc = "A hand-held scanner for analyzing someones gene sequence on the fly. Hold near a DNA console to update the internal database."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)
	var/list/discovered = list() //hit a dna console to update the scanners database
	var/list/buffer
	var/ready = TRUE
	var/cooldown = 200

/obj/item/sequence_scanner/attack(mob/living/M, mob/living/carbon/human/user)
	add_fingerprint(user)
	if (!HAS_TRAIT(M, TRAIT_GENELESS) && !HAS_TRAIT(M, TRAIT_BADDNA)) //no scanning if its a husk or DNA-less Species
		user.visible_message(span_notice("[user] analyzes [M]'s genetic sequence."), \
							span_notice("You analyze [M]'s genetic sequence."))
		gene_scan(M, user)
		playsound(src, 'sound/effects/fastbeep.ogg', 20)

	else
		user.visible_message(span_notice("[user] fails to analyze [M]'s genetic sequence."), span_warning("[M] has no readable genetic sequence!"))

/obj/item/sequence_scanner/attack_self(mob/user)
	display_sequence(user)

/obj/item/sequence_scanner/attack_self_tk(mob/user)
	return

/obj/item/sequence_scanner/afterattack(obj/O, mob/user, proximity)
	. = ..()
	if(!istype(O) || !proximity)
		return

	if(istype(O, /obj/machinery/computer/scan_consolenew))
		var/obj/machinery/computer/scan_consolenew/C = O
		if(C.stored_research)
			to_chat(user, span_notice("[name] linked to central research database."))
			discovered = C.stored_research.discovered_mutations
		else
			to_chat(user,span_warning("No database to update from."))

/obj/item/sequence_scanner/proc/gene_scan(mob/living/carbon/C, mob/living/user)
	if(!iscarbon(C) || !C.has_dna())
		return
	buffer = C.dna.mutation_index
	to_chat(user, span_notice("Subject [C.name]'s DNA sequence has been saved to buffer."))
	if(LAZYLEN(buffer))
		for(var/A in buffer)
			to_chat(user, span_notice("[get_display_name(A)]"))


/obj/item/sequence_scanner/proc/display_sequence(mob/living/user)
	if(!LAZYLEN(buffer) || !ready)
		return
	var/list/options = list()
	for(var/A in buffer)
		options += get_display_name(A)

	var/answer = input(user, "Analyze Potential", "Sequence Analyzer")  as null|anything in sortList(options)
	if(answer && ready && user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		var/sequence
		for(var/A in buffer) //this physically hurts but i dont know what anything else short of an assoc list
			if(get_display_name(A) == answer)
				sequence = buffer[A]
				break

		if(sequence)
			var/display
			for(var/i in 0 to length_char(sequence) / DNA_MUTATION_BLOCKS-1)
				if(i)
					display += "-"
				display += copytext_char(sequence, 1 + i*DNA_MUTATION_BLOCKS, DNA_MUTATION_BLOCKS*(1+i) + 1)

			to_chat(user, "[span_boldnotice("[display]")]<br>")

		ready = FALSE
		icon_state = "[icon_state]_recharging"
		addtimer(CALLBACK(src, PROC_REF(recharge)), cooldown, TIMER_UNIQUE)

/obj/item/sequence_scanner/proc/recharge()
	icon_state = initial(icon_state)
	ready = TRUE

/obj/item/sequence_scanner/proc/get_display_name(mutation)
	var/datum/mutation/human/HM = GET_INITIALIZED_MUTATION(mutation)
	if(!HM)
		return "ERROR"
	if(mutation in discovered)
		return  "[HM.name] ([HM.alias])"
	else
		return HM.alias

/obj/item/scanner_wand
	name = "kiosk scanner wand"
	icon = 'icons/obj/device.dmi'
	icon_state = "scanner_wand"
	item_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "An wand for scanning someone else for a medical analysis. Insert into a kiosk is make the scanned patient the target of a health scan."
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	var/selected_target = null

/obj/item/scanner_wand/attack(mob/living/M, mob/living/carbon/human/user)
	flick("[icon_state]_active", src)	//nice little visual flash when scanning someone else.

	if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(25))
		user.visible_message(span_warning("[user] targets himself for scanning."), \
		to_chat(user, span_info("You try scanning [M], before realizing you're holding the scanner backwards. Whoops.")))
		selected_target = user
		return

	if(!ishuman(M))
		to_chat(user, span_info("You can only scan human-like, non-robotic beings."))
		selected_target = null
		return

	user.visible_message(span_notice("[user] targets [M] for scanning."), \
						span_notice("You target [M] vitals."))
	selected_target = M
	return

/obj/item/scanner_wand/attack_self(mob/user)
	to_chat(user, span_info("You clear the scanner's target."))
	selected_target = null

/obj/item/scanner_wand/proc/return_patient()
	var/returned_target = selected_target
	return returned_target

/obj/item/reagent_scanner //essentially just the code from the PDA reagent scanner, but shoved into this object, and specifies amount
	name = "reagent scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "reagentanalyzer"
	item_state = "reagentanalyzer-1"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	desc = "A hand-held item capable of analyzing the reagents in a container, including complex, meat-based containers such as humans."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)

/obj/item/reagent_scanner/afterattack(atom/A as mob|obj|turf|area, mob/user, proximity)
	. = ..()
	flick("[icon_state]-anim", src)
	if(!proximity)
		return
	playsound(src, 'sound/effects/fastbeep.ogg', 10)
	if(!isnull(A.reagents))
		if(A.reagents.reagent_list.len > 0)
			var/reagents_length = A.reagents.reagent_list.len
			var/reagents_temp =	A.reagents.chem_temp
			to_chat(user, span_notice("[reagents_length] chemical agent[reagents_length > 1 ? "s" : ""] found at [reagents_temp]°K."))
			for (var/re in A.reagents.reagent_list)
				var/datum/reagent/R = re
				var/amount = R.volume
				to_chat(user, span_notice("\t [amount] units of [re]."))
		else
			to_chat(user, span_notice("No active chemical agents found in [A]."))
	else
		to_chat(user, span_notice("No significant chemical agents found in [A]."))

#undef SCANMODE_HEALTH
#undef SCANMODE_CHEMICAL
#undef SCANNER_VERBOSE
