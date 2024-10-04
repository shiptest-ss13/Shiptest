//Jumpsuits
/obj/item/clothing/under/gezena
	name = "PGFN fatigues"
	desc = "Rough inside and out, these fatigues are the standard issue fatigues of the PGFN."
	icon = 'icons/obj/clothing/faction/gezena/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/uniforms.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navy"
	item_state = "bluejump"
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepoi_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

/obj/item/clothing/under/gezena/utility
	name = "\improper PGFN utlity jumpsuit"
	desc = "A light blue utility jumpsuit, often used by navy technicians and specialists."
	icon_state = "navy_utility"
	item_state = "bluejump"

/obj/item/clothing/under/gezena/captain
	name = "PGFN captain fatigues"
	desc = "A refined variation of the basic navy fatigues, exclempifying authority."
	icon_state = "captain"
	item_state = "bluejump"

/obj/item/clothing/under/gezena/marine
	name = "\improper PGFMC fatigues"
	desc = "Rough inside and out, these fatigues are the standard issue fatigues of the PGFMC."
	icon_state = "marine"
	item_state = "marinejump"

/obj/item/clothing/under/gezena/marine_formal
	name = "\improper formal PGFMC outfit"
	desc = "The ceremonal uniform of the PGFMC, which so happens to be the historical uniform of the PGFA dating back 700 years."
	icon_state = "marine_formal"
	item_state = "marinejump"
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | KEPORI_VARIATION //no vox sprite

//Unarmored suit

/obj/item/clothing/suit/gezena
	name = "light navy jacket"
	desc = "Refined and sturdy, emblazoned on the shoulders with the seal of the PGF."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navycoat"
	item_state = "bluecloth"
	blood_overlay_type = "coat"
	togglename = "zipper"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/gezena/engi
	name = "light engineer jacket"
	desc = "Refined and sturdy, markings indicating the wearer as a mechanic."
	icon_state = "engicoat"
	item_state = "bluecloth"

//Armored suit

/obj/item/clothing/suit/armor/gezena
	name = "formal navywear coat"
	desc = "Formal navywear, emblazoned across the back with the Gezenan sigil."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "formal_navy"
	item_state = "bluecloth"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)

/obj/item/clothing/suit/armor/gezena/marine_parade
	name = "formal army coat"
	desc = "The ceremonal coat of the PGFMC, which so happens to be the historical uniform of the PGFA dating back 700 years. Line infantry may be long, long gone, but the spirit of the Gezenan fighting against Zohil's tyranny lives on."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "formal_marine"
	item_state = "bluecloth"

/obj/item/clothing/suit/armor/gezena/captain
	name = "PGFN captain's coat"
	desc = "A luxurious coat with a soft internal lining, exemplifying authority to all of your subordinates."
	icon_state = "captaincoat"
	item_state = "captaincoat"

/obj/item/clothing/suit/armor/gezena/marine
	name = "\improper R-44 armor vest"
	desc = "The standard issue armor vest of the PGF, being covered with a laser protective coating in exchange for minor ballistic protection. Was produced by Raksha Technologies before a hostile takeover by Etherbor Industries."
	icon_state = "pgfvest"
	item_state = "pgfvest"
	armor = list("melee" = 35, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50) //the laser gun country should probably have laser armor

/obj/item/clothing/suit/armor/gezena/marine/navy
	desc = "The standard issue armor vest of the PGF, being covered with a laser protective coating in exchange for minor ballistic protection. This one is in navy colors."
	icon_state = "pgfvest_navy"
	item_state = "pgfvest_navy"

//Spacesuits

/obj/item/clothing/suit/space/gezena
	name = "\improper PGFN normal suit"
	desc = "A normal suit used by the PGFN. While it's not particularly great nor high quality, these traits make it possible to fit an entire vessel's crew with at least one, with a few to spare."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navy_normalsuit"
	item_state = "spacesuit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

/obj/item/clothing/head/helmet/space/gezena
	name = "\improper PGFN normal suit helmet"
	desc = "A normal suit's helmet used by the PGFN. While it's not particularly great nor high quality, these traits make it possible to fit an entire vessel's crew with at least one, with a few to spare."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navy_normalsuithelm"
	item_state = "spacehelm"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = SNOUTED_VARIATION

/obj/item/clothing/suit/space/gezena/flightsuit
	name = "\improper PGFN flight suit"
	desc = "A standard flightsuit, in navy colors. Often used by pilots for protection against vaccum and to prevent g-forces on the pilot."
	icon_state = "navy_flightsuit"
	item_state = "spacesuit"
	slowdown = 0.5
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70)
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | FAST_EMBARK
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large

/obj/item/clothing/suit/space/gezena/flightsuit/marine
	name = "\improper PGFMC flight suit"
	desc = "A standard flightsuit, in marine colors. Often used by pilots for protection against vaccum and to prevent g-forces on the pilot."
	icon_state = "marine_flightsuit"
	item_state = "spacehelm"

#define HANDLE_HELMTOGGLE_VISOR 1
#define HANDLE_HELMTOGGLE_MASK 2

/obj/item/clothing/head/helmet/space/gezena/flightsuit
	name = "\improper PGFN pilot helmet"
	desc = "A standard pilot helmet, in navy colors. Often used by pilots for protection against vaccum and to prevent g-forces on the pilot. The visor and mask is togglable, if extra comfort is needed."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navy_flighthelm"
	item_state = "spacehelm"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70)
	actions_types = list(/datum/action/item_action/toggle_visor, /datum/action/item_action/toggle_flight_mask)
	var/visor = FALSE
	var/breathmask = FALSE

	visor_flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR|HIDEMASK
	visor_flags = STOPSPRESSUREDAMAGE

/datum/action/item_action/toggle_visor
	name = "Toggle Visor"
	icon_icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	button_icon_state = "visor_action"

/datum/action/item_action/toggle_visor/UpdateButtonIcon(status_only = FALSE, force)
	. = ..()
	var/obj/item/clothing/head/helmet/space/gezena/flightsuit/current_helm = target
	if(!current_helm)
		return
	if(current_helm.visor)
		button.icon_state = "template_active"

/datum/action/item_action/toggle_flight_mask
	name = "Toggle Mask"
	icon_icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	button_icon_state = "mask_action"

/datum/action/item_action/toggle_flight_mask/UpdateButtonIcon(status_only = FALSE, force)
	. = ..()
	var/obj/item/clothing/head/helmet/space/gezena/flightsuit/current_helm = target
	if(!current_helm)
		return
	if(current_helm.breathmask)
		button.icon_state = "template_active"

/obj/item/clothing/head/helmet/space/gezena/flightsuit/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/toggle_visor))
		handle_toggle(HANDLE_HELMTOGGLE_VISOR)
	if(istype(actiontype, /datum/action/item_action/toggle_flight_mask))
		handle_toggle(HANDLE_HELMTOGGLE_MASK)
	else
		..()

/obj/item/clothing/head/helmet/space/gezena/flightsuit/Initialize()
	. = ..()
	handle_toggle()

/obj/item/clothing/head/helmet/space/gezena/flightsuit/proc/handle_toggle(part_toggled)
	var/mob/living/carbon/human/current_human = loc
	switch(part_toggled)
		if(HANDLE_HELMTOGGLE_VISOR)
			visor = !visor
			to_chat(usr, span_notice("You flip [visor ? "down" : "up"] the visor on the [src]."))
			playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
		if(HANDLE_HELMTOGGLE_MASK)
			breathmask = !breathmask
			to_chat(usr, span_notice("You [breathmask ? "put on" : "take off"] the breath mask on the [src]."))
			playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)

	if(visor && breathmask)
		gas_transfer_coefficient = src::gas_transfer_coefficient
		permeability_coefficient = src::permeability_coefficient
		clothing_flags |= visor_flags
		flags_cover |= HEADCOVERSEYES | HEADCOVERSMOUTH
		flags_inv |= visor_flags_inv
		cold_protection |= HEAD
	else
		gas_transfer_coefficient = null
		permeability_coefficient = null
		clothing_flags &= ~visor_flags
		flags_cover &= ~(HEADCOVERSEYES | HEADCOVERSMOUTH)
		flags_inv &= ~visor_flags_inv
		cold_protection &= ~HEAD
	if(breathmask)
		clothing_flags |= ALLOWINTERNALS
	else
		clothing_flags &= ~ALLOWINTERNALS

	update_appearance()
	if(istype(current_human))
		current_human.update_hair()

/obj/item/clothing/head/helmet/space/gezena/flightsuit/worn_overlays(isinhands)
	. = ..()
	var/mob/living/carbon/human/current_human = loc
	var/sprite_path = icon_state
	if(!current_human)
		return
	if(isinhands)
		return
	var/obj/item/bodypart/head_bodypart = current_human.get_bodypart(BODY_ZONE_HEAD)
	if(head_bodypart.bodytype & BODYTYPE_SNOUT)
		sprite_path += "_snouted"


	var/mutable_appearance/visor_overlay = mutable_appearance(mob_overlay_icon, "[sprite_path]_visor[visor ? "" : "_up"]")
	var/mutable_appearance/mask_overlay = mutable_appearance(mob_overlay_icon, "[sprite_path]_mask")

	message_admins(visor_overlay.icon_state)
	. += visor_overlay
	if(breathmask)
		. += mask_overlay


/obj/item/clothing/head/helmet/space/gezena/flightsuit/update_overlays()
	cut_overlays()
	. = ..()
	var/sprite_path = icon_state

	var/mutable_appearance/visor_overlay = mutable_appearance(icon, "[sprite_path]_visor[visor ? "" : "_up"]")
	var/mutable_appearance/mask_overlay = mutable_appearance(icon, "[sprite_path]_mask")

	add_overlay(visor_overlay)
	if(breathmask)
		add_overlay(mask_overlay)

/obj/item/clothing/head/helmet/space/gezena/flightsuit/marine
	name = "\improper PGFMC pilot helmet"
	desc = "A standard pilot helmet, in marine colors. Often used by pilots for protection against vaccum and to prevent g-forces on the pilot. The visor and mask is togglable, if extra comfort is needed."
	icon_state = "marine_flighthelm"
	item_state = "spacehelm"



/obj/item/clothing/suit/space/hardsuit/gezena
	name = "PGFMC R-82 heavy hardsuit"
	desc = "A tried and true design, the R-82 hardsuit is designed for space combat operations, providing as much protection as an armor vest while still being spaceworthy. Despite the invention of power armor, the R-82 still remains widespread due to it's lower cost per unit."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "marine_hardsuit"
	item_state = "marine_hardsuit"
	hardsuit_type = "marine_hardsuit"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 90)
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/gezena
	jetpack = /obj/item/tank/jetpack/suit
	supports_variations = DIGITIGRADE_VARIATION
	slowdown = 1

/obj/item/clothing/suit/space/hardsuit/gezena/navy
	name = "PGFN R-82 heavy hardsuit"
	desc = "A tried and true design, the R-82 hardsuit is designed for space combat operations, providing as much protection as an armor vest while still being spaceworthy. This one is in Navy colors, for use in defence of the vessel against boarders or simply heavy-work."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navy_hardsuit"
	item_state = "navy_hardsuit"
	hardsuit_type = "navy_hardsuit"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/gezena/navy


/obj/item/clothing/head/helmet/space/hardsuit/gezena
	name = "PGFMC R-82 heavy hardsuit helmet"
	desc = "A tried and true design, the R-82 hardsuit is designed for space combat operations, providing as much protection as an armor vest while still being spaceworthy. Despite the invention of power armor, the R-82 still remains widespread due to it's lower cost per unit."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "hardsuit0-pgf_hardsuit"
	item_state = "marine_hardsuit"
	hardsuit_type = "pgf_hardsuit"

	supports_variations = SNOUTED_VARIATION

	armor = list("melee" = 40, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 90)

/obj/item/clothing/head/helmet/space/hardsuit/gezena/navy
	name = "PGFN R-82 heavy hardsuit helmet"
	desc = "A tried and true design, the R-82 hardsuit is designed for space combat operations, providing as much protection as an armor vest while still being spaceworthy. Despite the invention of power armor, the R-82 still remains widespread due to it's lower cost per unit."
	icon_state = "hardsuit0-pgf_hardsuit_navy"
	item_state = "marine_hardsuit"
	hardsuit_type = "pgf_hardsuit_navy"

	armor = list("melee" = 40, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 90)

//Hats

/obj/item/clothing/head/gezena
	name = "\improper PGFN Kepi"
	desc = "The standard service kepi of the PGFN."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navy_kepi"
	item_state = "bluecloth"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/gezena/marine
	name = "\improper PGFMC Kepi"
	desc = "The standard service kepi of the PGFMC."
	icon_state = "marine_kepi"
	item_state = "marinecloth"

/obj/item/clothing/head/gezena/marine_parade
	name = "\improper formal PGFMC Kepi"
	desc = "The ceremonal kepi of the PGFMC, which so happens to be the historical uniform of the PGFA dating back 700 years. Zale peasants may have once looked at it in terror, but now it stands as a symbol of the Gezenan's fight against Zohillian tyranny."
	icon_state = "formal_army_kepi"
	item_state = "marinecloth"

/obj/item/clothing/head/gezena/marine/lead
	name = "\improper PGFMC Commander Kepi"
	desc = "The standard service kepi of the PGFMC. The silver badge shows the wearer is a commander."
	icon_state = "squad_kepi"
	item_state = "marinecloth"

/obj/item/clothing/head/gezena/medic
	name = "\improper PGF medic cap"
	desc = "The standard cap of the PGF military. The coloring indicates the wearer as a medical officer."
	icon_state = "medic_kepi"
	item_state = "whitecloth"

/obj/item/clothing/head/gezena/flap
	name = "\improper PGFN flap cap"
	desc = "A flap cap intended to be used by navy personnel for disembarking in arid environments. In practice, navymen usually wear this for style as leaving the vessel in uniform is quite uncommon."
	icon_state = "navalflap"
	item_state = "bluecloth"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/gezena/flap/marine
	name = "\improper PGFMC flap cap"
	desc = "A flap cap used by the PGFMC in hot, arid environments. It's also quite fashionable, replicas being popular with civillians in the PGF."
	icon_state = "marine_flap"
	item_state = "marinecloth"

/obj/item/clothing/head/gezena/flap/marine/lead
	name = "\improper PGFMC commander flap Cap"
	desc = "A flap cap used by the PGFMC in hot, arid environments. The silver badge shows the wearer is a commander."
	icon_state = "squadflap"
	item_state = "marinecloth"

/obj/item/clothing/head/gezena/flap/medic
	name = "\improper PGFMC medic flap cap"
	desc = "A flap cap used by the PGFMC in hot, arid environments. The green badge shows the wearer is a medic."
	icon_state = "medicflap"
	item_state = "whitecloth"

/obj/item/clothing/head/gezena/campaign_marinelead
	name = "\improper PGFMC commander campaign hat"
	desc = "A campaign hat used by PGFMC commanders. For yelling at clueless marines in style."
	icon_state = "squad_drill"
	item_state = "marinecloth"

/obj/item/clothing/head/gezena/campaign_captain
	name = "\improper PGFN captain's campaign hat"
	desc = "A campaign hat used by PGFN captains and commanders. For yelling at clueless deckhands in style."
	icon_state = "captain_drill"
	item_state = "bluecloth"

/obj/item/clothing/head/helmet/gezena
	name = "\improper Type R-11 Helmet"
	desc = "A next-generation helmet for the PGFMC, being a welcome replacement to the aging X11. The mateiral allows for a a laser protective coating while sacrficing very little ballistic protection. Produced by Raksha Technologies before a hostile takeover by Etherbor Industries."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	armor = list("melee" = 35, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50) //the laser gun country should probably have laser armor
	icon_state = "pgf_x11"
	item_state = "marinehelm"

/obj/item/clothing/head/helmet/gezena/navy
	name = "\improper Type R-11 Helmet"
	desc = "A next-generation helmet for the PGFMC, being a welcome replacement to the aging X11. The mateiral allows for a a laser protective coating while sacrficing very little ballistic protection. This one is in Navy colors."

	icon_state = "navy_x11"
	item_state = "marinehelm"
//Mask

/obj/item/clothing/mask/gas/gezena
	name = "R-17 gas mask"
	desc = "A close-fitting, tactical gas mask that can be connected to an air supply. Standard equipment for PGF military personnel."

	icon = 'icons/obj/clothing/faction/gezena/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/mask.dmi'

	icon_state = "pgf_gasmask"
	strip_delay = 60

	flags_inv = HIDEEARS|HIDEFACE|HIDEFACIALHAIR

	supports_variations = SNOUTED_VARIATION
	var/easter_egg = FALSE

/obj/item/clothing/mask/gas/gezena/Initialize()
	. = ..()
	if(prob(5))
		easter_egg = TRUE

/obj/item/clothing/mask/gas/gezena/examine(mob/user)
	. = ..()
	if(easter_egg)
		. += span_notice("Your butt feels slightly heavy wearing this.")

//Gloves

/obj/item/clothing/gloves/gezena
	name = "\improper PGF Gloves"
	desc = "Standard gloves issued to PGF personnel virtually everywhere."
	icon = 'icons/obj/clothing/faction/gezena/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/hands.dmi'
	icon_state = "pgf_gloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

//Boots

/obj/item/clothing/shoes/combat/gezena
	name = "\improper PGF jackboots"
	desc = "Standard issue boots to PGF personnel virtually everywhere."
	icon = 'icons/obj/clothing/faction/gezena/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/feet.dmi'
	icon_state = "pgfboots"
	item_state = "jackboots"
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

//Belt

/obj/item/storage/belt/military/gezena
	name = "\improper PGF chest rig"
	desc = "A lightweight harness covered in pouches issued to PGF personnel. This variant is designed for carrying ammunition."
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "pouches"
	item_state = "bluecloth"
	unique_reskin = null

/obj/item/storage/belt/medical/gezena
	name = "\improper PGF medical chest rig"
	desc = "A lightweight harness covered in pouches issued to PGF personnel. This variant is designed for carrying medical supplies."
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "medpouches"
	item_state = "whitecloth"

//Cloaks

/obj/item/clothing/neck/cloak/gezena
	name = "\improper aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents ranks 1-3, the lowest ranks."
	icon = 'icons/obj/clothing/faction/gezena/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/neck.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "cape"
	item_state = "blackcloth"

/obj/item/clothing/neck/cloak/gezena/lead
	name = "\improper sergeant's aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents ranks 4-6, the ranks accociated with commanders."
	icon_state = "squadcape"
	item_state = "blackcloth"

/obj/item/clothing/neck/cloak/gezena/engi
	name = "\improper engineer's aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents ranks 4-6, the ranks accociated with commanders, but the wearer has an engineering specialization rather than commanding."
	icon_state = "engicape"
	item_state = "blackcloth"

/obj/item/clothing/neck/cloak/gezena/med
	name = "\improper medic's aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents ranks 4-6, the ranks accociated with commanders, but the wearer has a medical specialization rather than commanding."
	icon_state = "medcape"
	item_state = "whitecloth"

/obj/item/clothing/neck/cloak/gezena/lead
	name = "\improper commander's aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents ranks 7-9, the highest ranks for a non-commissioned officer."
	icon_state = "leadcape"

/obj/item/clothing/neck/cloak/gezena/command
	name = "\improper officer's aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents officer ranks 1-5, the lowest ranks for a commissioned officer."
	icon_state = "commandcape"
	item_state = "whitecloth"

/obj/item/clothing/neck/cloak/gezena/xo
	name = "\improper commander's aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents officer ranks 6-8, the ranks accociated with officers on vessels."
	icon_state = "executivecape"
	item_state = "whitecloth"

/obj/item/clothing/neck/cloak/gezena/captain
	name = "\improper captain's aziulhauz rank cape"
	desc = "The aziulhauz is a rank cape used in the PGF military, in place of rank badges other nations use; required as apart of the PGF military dress code. This one represents officer ranks 9-12, the highest ranks a commissioned officer can reach."
	icon_state = "captaincape"
	item_state = "whitecloth"
