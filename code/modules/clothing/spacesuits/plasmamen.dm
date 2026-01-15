//Suits for the pink and grey skeletons! //EVA version no longer used in favor of the Jumpsuit version


/obj/item/clothing/suit/space/eva/plasmaman
	name = "EVA plasma envirosuit"
	desc = "A special plasma containment suit designed to be space-worthy, as well as worn over other clothing. Like its smaller counterpart, it can automatically extinguish the wearer in a crisis, and holds twice as many charges."
	allowed = list(/obj/item/gun, /obj/item/ammo_casing, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword, /obj/item/restraints/handcuffs, /obj/item/tank)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF
	icon_state = "plasmaman_suit"
	item_state = "plasmaman_suit"
	var/next_extinguish = 0
	var/extinguish_cooldown = 100
	var/extinguishes_left = 10


/obj/item/clothing/suit/space/eva/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("There [extinguishes_left == 1 ? "is" : "are"] [extinguishes_left] extinguisher charge\s left in this suit.")


/obj/item/clothing/suit/space/eva/plasmaman/proc/Extinguish(mob/living/carbon/human/H)
	if(!istype(H))
		return

	if(H.fire_stacks > 0)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			H.visible_message(span_warning("[H]'s suit automatically extinguishes [H.p_them()]!"),span_warning("Your suit automatically extinguishes you."))
			H.extinguish_mob()
			new /obj/effect/particle_effect/water(get_turf(H))


//I just want the light feature of the hardsuit helmet
/obj/item/clothing/head/helmet/space/plasmaman
	name = "plasma envirosuit helmet"
	desc = "A special containment helmet that allows plasma-based lifeforms to exist safely in an oxygenated environment. It is space-worthy, and may be worn in tandem with other EVA gear."
	icon_state = "plasmaman-helm"
	item_state = "plasmaman-helm"
	strip_delay = 80
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 2
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 4
	light_on = FALSE
	light_color = "#FFCC66"
	light_power = 0.8
	var/helmet_on = FALSE
	var/smile = FALSE
	var/smile_color = "#FF0000"
	var/visor_icon = "envisor"
	var/smile_state = "envirohelm_smile"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF | SEALS_EYES
	visor_flags_inv = HIDEEYES|HIDEFACE

	//remove when phorids suck less
	equip_delay_self = null

// WS Begin - plasmeme command helmets buff - used for RD bomb scanner
/obj/item/clothing/head/helmet/space/plasmaman/proc/display_visor_message(msg)
	var/mob/wearer = loc
	if(msg && ishuman(wearer))
		wearer.show_message("[icon2html(src, wearer)]<b>[span_robot("[msg]")]</b>", MSG_VISUAL)
//WS END

/obj/item/clothing/head/helmet/space/plasmaman/Initialize()
	. = ..()
	visor_toggling()
	update_appearance()

/obj/item/clothing/head/helmet/space/plasmaman/AltClick(mob/user)
	if(user.canUseTopic(src, BE_CLOSE))
		toggle_welding_screen(user)

/obj/item/clothing/head/helmet/space/plasmaman/proc/toggle_welding_screen(mob/living/user)
	if(weldingvisortoggle(user))
		if(helmet_on)
			to_chat(user, span_notice("Your helmet's torch can't pass through your welding visor!"))
			helmet_on = FALSE
			playsound(src, 'sound/mecha/mechmove03.ogg', 50, TRUE) //Visors don't just come from nothing
			update_appearance()
		else
			playsound(src, 'sound/mecha/mechmove03.ogg', 50, TRUE) //Visors don't just come from nothing
			update_appearance()

/obj/item/clothing/head/helmet/space/plasmaman/update_overlays()
	. = ..()
	. += visor_icon

/obj/item/clothing/head/helmet/space/plasmaman/attackby(obj/item/C, mob/living/user)
	. = ..()
	if(istype(C, /obj/item/toy/crayon))
		if(smile == FALSE)
			var/obj/item/toy/crayon/CR = C
			to_chat(user, span_notice("You start drawing a smiley face on the helmet's visor.."))
			if(do_after(user, 25, target = src))
				smile = TRUE
				smile_color = CR.paint_color
				to_chat(user, "You draw a smiley on the helmet visor.")
				update_appearance()
		else
			to_chat(user, span_warning("Seems like someone already drew something on this helmet's visor!"))

/obj/item/clothing/head/helmet/space/plasmaman/worn_overlays(isinhands)
	. = ..()
	if(!isinhands && smile)
		var/mutable_appearance/M = mutable_appearance('icons/mob/clothing/head.dmi', smile_state)
		M.color = smile_color
		. += M
	if(!isinhands && !up)
		. += mutable_appearance('icons/mob/clothing/head.dmi', visor_icon)
	else
		cut_overlays()

/obj/item/clothing/head/helmet/space/plasmaman/wash(clean_types)
	. = ..()
	if(smile && (clean_types & CLEAN_TYPE_PAINT))
		smile = FALSE
		update_appearance()
		return TRUE

/obj/item/clothing/head/helmet/space/plasmaman/attack_self(mob/user)
	helmet_on = !helmet_on
	icon_state = "[initial(icon_state)][helmet_on ? "-light":""]"
	item_state = icon_state
	user.update_inv_head() //So the mob overlay updates

	if(helmet_on)
		if(!up)
			to_chat(user, span_notice("Your helmet's torch can't pass through your welding visor!"))
			set_light_on(FALSE)
		else
			set_light_on(TRUE)
	else
		set_light_on(FALSE)

	for(var/X in actions)
		var/datum/action/A=X
		A.UpdateButtonIcon()

/obj/item/clothing/head/helmet/space/plasmaman/security
	name = "security plasma envirosuit helmet"
	desc = "A plasmaman containment helmet designed for security officers, protecting them from being flashed and burning alive, alongside other undesirables."
	icon_state = "security_envirohelm"
	item_state = "security_envirohelm"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 0, "fire" = 100, "acid" = 75, "wound" = 10) // WS Edit - plasmeme command helmets buff- made it match sec helmet

/obj/item/clothing/head/helmet/space/plasmaman/security/warden
	name = "warden's plasma envirosuit helmet"
	desc = "A plasmaman containment helmet designed for the warden, a pair of white stripes being added to differeciate them from other members of security."
	icon_state = "warden_envirohelm"
	item_state = "warden_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/prisoner
	name = "prisoner's plasma envirosuit helmet"
	desc = "A plasmaman containment helmet for prisoners."
	icon_state = "prisoner_envirohelm"
	item_state = "prisoner_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/medical
	name = "medical doctor's plasma envirosuit helmet"
	desc = "An envirohelmet designed for plasmaman medical doctors, having two stripes down its length to denote as much."
	icon_state = "doctor_envirohelm"
	item_state = "doctor_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/paramedic
	name = "paramedic plasma envirosuit helmet"
	desc = "An envirohelmet designed for plasmaman paramedics, with darker blue stripes compared to the medical model."
	icon_state = "paramedic_envirohelm"
	item_state = "paramedic_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/genetics
	name = "geneticist's plasma envirosuit helmet"
	desc = "A plasmaman envirohelmet designed for geneticists."
	icon_state = "geneticist_envirohelm"
	item_state = "geneticist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/viro
	name = "virology plasma envirosuit helmet"
	desc = "The helmet worn by the safest people in virology, those who are completely immune to the monstrosities they create."
	icon_state = "virologist_envirohelm"
	item_state = "virologist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/chemist
	name = "chemistry plasma envirosuit helmet"
	desc = "A plasmaman envirosuit designed for chemists, two orange stripes going down it's face."
	icon_state = "chemist_envirohelm"
	item_state = "chemist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/science
	name = "science plasma envirosuit helmet"
	desc = "A plasmaman envirohelmet designed for scientists."
	icon_state = "scientist_envirohelm"
	item_state = "scientist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/robotics
	name = "robotics plasma envirosuit helmet"
	desc = "A plasmaman envirohelmet designed for roboticists."
	icon_state = "roboticist_envirohelm"
	item_state = "roboticist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/engineering
	name = "engineering plasma envirosuit helmet"
	desc = "A space-worthy helmet specially designed for engineer plasmamen, the usual purple stripes being replaced by engineering's orange."
	icon_state = "engineer_envirohelm"
	item_state = "engineer_envirohelm"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 10, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF // WS Edit - plasmeme command helmets buff-matches hardsuit helmet fireproof

/obj/item/clothing/head/helmet/space/plasmaman/atmospherics
	name = "atmospherics plasma envirosuit helmet"
	desc = "A space-worthy helmet specially designed for atmos technician plasmamen, the usual purple stripes being replaced by engineering's blue."
	icon_state = "atmos_envirohelm"
	item_state = "atmos_envirohelm"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT // WS Edit - plasmeme command helmets buff-made heatproof

/obj/item/clothing/head/helmet/space/plasmaman/cargo
	name = "cargo plasma envirosuit helmet"
	desc = "An plasmaman envirohelmet designed for cargo techs and quartermasters."
	icon_state = "cargo_envirohelm"
	item_state = "cargo_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/mining
	name = "mining plasma envirosuit helmet"
	desc = "A khaki helmet given to plasmamen miners operating on lavaland."
	icon_state = "explorer_envirohelm"
	item_state = "explorer_envirohelm"
	visor_icon = "explorer_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/chaplain
	name = "chaplain's plasma envirosuit helmet"
	desc = "An envirohelmet specially designed for only the most pious of plasmamen."
	icon_state = "chap_envirohelm"
	item_state = "chap_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/white
	name = "white plasma envirosuit helmet"
	desc = "A generic white envirohelm."
	icon_state = "white_envirohelm"
	item_state = "white_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/curator
	name = "curator's plasma envirosuit helmet"
	desc = "A slight modification on a tradiational voidsuit helmet, this helmet was Nano-Trasen's first solution to the *logistical problems* that come with employing plasmamen. Despite their limitations, these helmets still see use by historian and old-styled plasmamen alike."
	icon_state = "prototype_envirohelm"
	item_state = "prototype_envirohelm"
	actions_types = list(/datum/action/item_action/toggle_welding_screen/plasmaman)
	smile_state = "prototype_smile"
	visor_icon = "prototype_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/botany
	name = "botany plasma envirosuit helmet"
	desc = "A green and blue envirohelmet designating it's wearer as a botanist. While not specially designed for it, it would protect against minor planet-related injuries."
	icon_state = "botany_envirohelm"
	item_state = "botany_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/janitor
	name = "janitor's plasma envirosuit helmet"
	desc = "A grey helmet bearing a pair of purple stripes, designating the wearer as a janitor."
	icon_state = "janitor_envirohelm"
	item_state = "janitor_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/command
	name = "captains envirosuit helmet"
	desc = "An envirosuit helmet made for the most important plasmaman of them all."
	icon_state = "command_envirohelm"
	item_state = "command_envirohelm"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 50, "energy" = 60, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 75, "wound" = 10)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT //this needed to be added a long fucking time ago

/obj/item/clothing/head/helmet/space/plasmaman/engineering/ce
	name = "chief engineers envirohelmet"
	desc = "An envirosuit helmet made for the tutored plasmaman."
	icon_state = "ce_envirohelm"
	item_state = "ce_envirohelm"
	armor = list("melee" = 40, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 75, "wound" = 10)
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT

/obj/item/clothing/head/helmet/space/plasmaman/cmo
	name = "chief medical officers envirohelmet"
	desc = "An envirosuit helmet made for the taxed plasmaman."
	icon_state = "cmo_envirohelm"
	item_state = "cmo_envirohelm"
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 75, "wound" = 10)

/obj/item/clothing/head/helmet/space/plasmaman/security/hos
	name = "head of securitys helmet"
	desc = "An envirosuit helmet made for the right and honorable plasmaman."
	icon_state = "hos_envirohelm"
	item_state = "hos_envirohelm"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 75, "wound" = 10)

/obj/item/clothing/head/helmet/space/plasmaman/rd
	name = "research directors envirosuit helmet"
	desc = "An envirosuit helmet made for the erudite plasmaman."
	icon_state = "rd_envirohelm"
	item_state = "rd_envirohelm"
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 100, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 75, "wound" = 10)
	var/explosion_detection_dist = 21
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SCAN_REAGENTS | SNUG_FIT | BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS //WS Port - Cit Internals
	actions_types = list(/datum/action/item_action/toggle_helmet_light, /datum/action/item_action/toggle_research_scanner)

//bomb scanner for RD helmet
/obj/item/clothing/head/helmet/space/plasmaman/rd/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_EXPLOSION, PROC_REF(sense_explosion))

/obj/item/clothing/head/helmet/space/plasmaman/rd/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
		DHUD.add_hud_to(user)
/obj/item/clothing/head/helmet/space/plasmaman/rd/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
		DHUD.remove_hud_from(user)

/obj/item/clothing/head/helmet/space/plasmaman/rd/proc/sense_explosion(datum/source, turf/epicenter, devastation_range, heavy_impact_range,
		light_impact_range, took, orig_dev_range, orig_heavy_range, orig_light_range)
	var/turf/T = get_turf(src)
	if(T.z != epicenter.z)
		return
	if(get_dist(epicenter, T) > explosion_detection_dist)
		return
	display_visor_message("Explosion detected! Epicenter: [devastation_range], Outer: [heavy_impact_range], Shock: [light_impact_range]")
//WS END

/obj/item/clothing/head/helmet/space/plasmaman/hop
	name = "head of personnels envirosuit helmet"
	desc = "An envirosuit helmet made for the complacent plasmaman."
	icon_state = "hop_envirohelm"
	item_state = "hop_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/security/secmed
	name = "brig physician envirosuit helmet"
	desc = "An envirosuit helmet made for the sanctioned plasmaman."
	icon_state = "secmed_envirohelm"
	item_state = "secmed_envirohelm"
