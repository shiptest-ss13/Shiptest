//////////////
//Jumpsuits//
/////////////

/obj/item/clothing/under/frontiersmen
	name = "\improper frontiersmen uniform"
	desc = "Fatigues worn by members of the Frontiersmen pirate fleet. Its poor-quality linen is very uncomfortable to move around in."
	icon_state = "frontier"
	item_state = "frontier"
	can_adjust = FALSE
	icon = 'icons/obj/clothing/faction/frontiersmen/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/uniforms.dmi'
	supports_variations = VOX_VARIATION

/obj/item/clothing/under/frontiersmen/deckhand
	name = "\improper deckhand jumpsuit"
	desc = "A cheap olive-green jumpsuit used by the Frontiersmen on their vessels. It has an old smell permeating it."
	icon_state = "frontier_deckhand"
	item_state = "frontier_deckhand"

/obj/item/clothing/under/frontiersmen/fireproof
	name = "\improper fireproof frontiersmen fatigues"
	desc = "An all-black set of fatigues worn by the flamethrower units of the Frontiersmen. It feels oddly itchy when worn..."
	icon_state = "frontier_fireproof"
	item_state = "frontier_fireproof"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/under/frontiersmen/officer
	name = "\improper Frontiersmen officer's uniform"
	desc = "Worn by officers of the Frontiersmen pirate fleet. It's less comfortable than it looks."
	icon_state = "frontier_officer"

/obj/item/clothing/under/frontiersmen/admiral
	name = "\improper frontiersmen admiral uniform"
	desc = "Worn by admirals of the Frontiersmen pirate fleet, adorned with a tasteful amount of gold and completed with a very-stylish all-white aesthetic. Quite snobby for a bunch of pirates."
	icon_state = "frontier_admiral"
	item_state = "frontier_admiral"

////////////////////
//Unarmored suits//
///////////////////

/obj/item/clothing/suit/frontiersmen //Ideally, the basic suit model here should be turned into a placeholder model, and this item have "smock" or "apron" added on the end.
	name = "frontiersmen smock"
	desc = "A basic white surgical apron worn by the Frontiersmen. It seems it could stain very easily..."
	icon_state = "frontier_surgery"
	icon = 'icons/obj/clothing/faction/frontiersmen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/suits.dmi'
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS

//////////////////
//Armored suits//
/////////////////

/obj/item/clothing/suit/armor/vest/bulletproof/frontier
	name = "\improper Frontiersmen bulletproof armor"
	desc = "A scrap piece of armor made of disused protective plates. This one was used to protect the squishy bits of a Frontiersman, once."
	icon_state = "frontier_armor"
	icon = 'icons/obj/clothing/faction/frontiersmen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/suits.dmi'
	blood_overlay_type = "armor"
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/armor/vest/marine/frontier
	name = "light tactical armor vest"
	desc = "A bulky set of stamped plasteel armor plates, coated with the intimidating grey of the Frontiersmen. If you have the time to inspect this vest, either you are about to die, or you have killed the one who wore it originally."
	icon_state = "marine_frontier"
	item_state = "armor"
	icon = 'icons/obj/clothing/faction/frontiersmen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/suits.dmi'

/obj/item/clothing/suit/armor/frontier
	name = "reinforced fur coat"
	desc = "A stiff olive-green coat, meant for frigid conditions. Commonly worn by Frontiersmen command."
	icon_state = "frontier_coat"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	icon_state = "frontier_coat"
	item_state = "frontier_coat"
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	icon = 'icons/obj/clothing/faction/frontiersmen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/suits.dmi'

/obj/item/clothing/suit/armor/frontier/fireproof
	name = "frontiersmen fireproof coat"
	desc = "A stiff olive-green coat, used particularly by Frontiersmen flame troopers. It seems to be lined with asbestos, to provide maximum heat and fire deterrence... At the cost of comfort. And mesothelioma."
	icon_state = "frontier_fireproof_suit"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.5
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/tank/internals/plasmaman, /obj/item/extinguisher, /obj/item/crowbar)

///////////////
//Spacesuits//
//////////////

/obj/item/clothing/head/helmet/space/hardsuit/security/independent/frontier
	name = "\improper Frontiersmen hardsuit helmet"
	desc = "An old hardsuit helmet based on a even older hardsuit helmet. Used prolifically by the Frontiersmen pirate fleet."
	icon_state = "hardsuit0-frontier"
	icon = 'icons/obj/clothing/faction/frontiersmen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/head.dmi'
	hardsuit_type = "frontier"

/obj/item/clothing/suit/space/hardsuit/security/independent/frontier
	name = "\improper Frontiersmen hardsuit"
	desc = "An old hardsuit based on a even older hardsuit. Used prolifically by the Frontiersmen pirate fleet."
	icon_state = "hardsuit_frontier"
	hardsuit_type = "hardsuit_frontier"
	icon = 'icons/obj/clothing/faction/frontiersmen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/suits.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/independent/frontier

/////////
//Hats//
////////

/obj/item/clothing/head/soft/frontiersmen
	name = "frontiersman cap"
	desc = "An olive-green and grey baseball hat, worn by cargo technicians working under the Frontiersmen. Even they have the rights for a cool cap!"
	icon_state = "frontiersoft"
	soft_type = "frontier"
	icon = 'icons/obj/clothing/faction/frontiersmen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/head.dmi'

/obj/item/clothing/head/beret/sec/frontier
	name = "\improper Frontiersmen beret"
	desc = "A scratchy olive green beret, worn by Frontiersmen who want to look good while intimidating freighter crew."
	icon_state = "frontier_beret"
	icon = 'icons/obj/clothing/faction/frontiersmen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/head.dmi'

/obj/item/clothing/head/beret/sec/frontier/officer
	name = "\improper Frontiersmen officer beret"
	desc = "A scratchy olive green beret emblazoned with the Frontiersmen insignia, worn by Frontiersmen who want to look good while intimidating freighter captains."
	icon_state = "frontier_officer_beret"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/frontier
	name = "frontier surgical cap"
	desc = "A white surgical cap used by the quite uncommon doctors part of the Frontiersmen."
	icon_state = "frontier_surgery"
	icon = 'icons/obj/clothing/faction/frontiersmen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/head.dmi'

/obj/item/clothing/head/hardhat/frontier
	name = "faded white hard hat"
	desc = "A grimy white hardhat used by the mechanics and engineers of the Frontiersmen fleet. Smells old."
	icon_state = "frontier_hardhat"
	icon = 'icons/obj/clothing/faction/frontiersmen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/head.dmi'

/obj/item/clothing/head/frontier/peaked
	name = "\improper frontiersmen commander's cap"
	desc = "An imposing peaked cap, meant for a commander of the Frontiersmen."
	icon_state = "frontier_cap"
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/frontier/admiral
	name = "\improper frontiersmen admiral's cap"
	desc = "An imposing peaked cap meant for only the highest of officers of the Frontiersmen pirate fleet."
	icon_state = "frontier_admiral_cap"
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/bulletproof/x11/frontier
	name = "\improper frontiersmen X-11 helmet"
	desc = "A heavily modified X-11 pattern helmet used by the Frontiersmen pirate fleet."
	icon_state = "x11helm_frontier"
	unique_reskin = null
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/bulletproof/x11/frontier/fireproof
	name = "\improper fireproof frontiersmen X-11 helmet"
	desc = "A subtly but helpful modifcation of the Frontiersmen X11 to make it fireproof."
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)

/obj/item/clothing/head/helmet/marine/frontier
	name = "frontiersmen reinforced helmet"
	desc = "A reinforced Frontiersmen X-11. The front plate has a small window to let the user see."
	icon_state = "marine_frontier"
	icon = 'icons/obj/clothing/faction/frontiersmen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/head.dmi'

////////////
//Glasses//
///////////

//////////
//Masks//
/////////

/obj/item/clothing/mask/gas/frontiersmen
	name = "sack gas mask"
	desc = "A gas mask that can be connected to an air supply. It's made out of sack, but still works just as good for protecting you."
	icon_state = "gasmask_frontier"
	icon = 'icons/obj/clothing/faction/frontiersmen/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/mask.dmi'
	resistance_flags = FIRE_PROOF

//////////
//Neck//
/////////

//////////
//Belts//
/////////

/obj/item/storage/belt/security/military/frontiersmen
	name = "leather bandolier"
	desc = "A rudimentary leather bandolier, utilized by both independents and frontiersmen alike. Usually slung diagonally, from the shoulder to the waist."
	icon_state = "frontierwebbing"
	item_state = "frontierwebbing"
	icon = 'icons/obj/clothing/faction/frontiersmen/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/belt.dmi'

	unique_reskin = null

/obj/item/storage/belt/security/military/frontiersmen/illestren/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/illestren_a850r(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/security/military/frontiersmen/skm_ammo/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/skm_762_40(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/security/military/frontiersmen/mauler_mp_ammo/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m9mm_mauler(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/security/military/frontiersmen/spitter_ammo/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/spitter_9mm(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/security/military/frontiersmen/flamer/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/glass/beaker/large/napalm(src)
	new /obj/item/grenade/frag(src)


/obj/item/storage/belt/medical/webbing/frontiersmen
	name = "leather medical bandolier"
	desc = "A rudimentary leather bandolier, utilized by both independents and frontiersmen alike. This one is painted white, usually to be worn by a medic."
	icon_state = "frontiermedicalwebbing"
	item_state = "frontiermedicalwebbing"
	icon = 'icons/obj/clothing/faction/frontiersmen/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/frontiersmen/belt.dmi'

/obj/item/storage/belt/medical/webbing/frontiersmen/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/retractor(src)
	new /obj/item/cautery(src)
	new /obj/item/hemostat(src)
	new /obj/item/hypospray/mkii(src)
	update_appearance()

/obj/item/storage/belt/medical/webbing/frontiersmen/combat/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)
	new /obj/item/reagent_containers/medigel/silver_sulf(src)
	new /obj/item/reagent_containers/medigel/styptic(src)
	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/stack/medical/splint(src)
