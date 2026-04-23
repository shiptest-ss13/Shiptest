//underclothes

/obj/item/clothing/under/cybersun
	name = "cybersun jumpsuit"
	desc = "The standard jumpsuit used by the agents employed by Cybersun, in its distinctive full-white aesthetic."
	icon_state = "cybersun_agent"
	roll_sleeves = FALSE
	roll_down = TRUE

	icon = 'icons/obj/clothing/faction/cybersun/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/uniforms.dmi'

/obj/item/clothing/under/cybersun/coverall
	name = "Cybersun coveralls"
	desc = "Nomex coveralls worn by workers and research personnel employed by Cybersun industries."
	icon_state = "cybersun"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 100)
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/cybersun/medic
	name = "Cybersun medical jumpsuit"
	desc = "Sterile coveralls worn by Cybersun Industries field medics for protection against biological hazards."
	icon_state = "cybersun_med"
	permeability_coefficient = 0.5
	roll_down = TRUE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/under/cybersun/medic/skirt
	name = "Cybersun medical jumpskirt"
	desc = "A sterile jumpskirt worn by Cybersun Industries field medics for protection against biological hazards."
	icon_state = "cybersun_med_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/cybersun/doctor
	name = "Medical Director suit"
	desc = "Pleasant maroon with teal highlights. The standardized workwear of a high-standing Biodynamics doctor."
	icon_state = "cybersun_md"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 20, "rad" = 0, "fire" = 0, "acid" = 0)
	roll_sleeves = FALSE
	roll_down = FALSE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/cybersun/overalls
	name = "Cybersun overalls"
	desc = "Durable black-on-red overalls built for Cybersun's field workers."
	icon_state = "cybersun_overalls"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 100)
	roll_sleeves = FALSE
	roll_down = FALSE
	//supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/cybersun/sneak
	name = "Cybersun sneaksuit"
	desc = "A tight form-fitting uniform made from a silky metamaterial. It clings to flesh like shadow clings to light. Near frictionless but extremely comfortable."
	icon_state = "cybersun_sneaksuit"
	roll_sleeves = TRUE
	roll_down = FALSE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/cybersun/suit
	name = "cybersun suit"
	desc = "White shirt and suit pants, worn by the many office inhabitants working for Cybersun."
	icon_state = "cybersun_suit"
	roll_sleeves = FALSE
	roll_down = FALSE
	//supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/cybersun/officer
	name = "cybersun officer's suit"
	desc = "A crimson-red suit used by the officers employed by Cybersun."
	icon_state = "cybersun_officer"
	roll_sleeves = FALSE
	roll_down = FALSE
	supports_variations = DIGITIGRADE_VARIATION

//suit

/obj/item/clothing/suit/cybersun
	name = "cybersun suit"
	desc = "A plain white suit commonly used by Cybersun's officers."
	icon_state = "cybersun_suit"
	item_state = "cybersun_suit"

	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC

	equip_sound = 'sound/items/equip/cloth_equip.ogg'
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5

	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/suit/armor/cybersun
	name = "Cybersun captain's haori"
	desc = "An extraordinarily fashionable haori, utilized by Cybersun captains. Weaved with armored fabric to protect the user from gunshots."
	icon_state = "carapace_cybersun"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90, "wound" = 20)

	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/suit/cybersun/smock
	name = "cybersun smock"
	desc = "A maroon-red smock beloved for its ability to hide bloodstains."
	icon_state = "cybersun_smock"
	item_state = "redcloth"
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS

//armor suits

/obj/item/clothing/suit/armor/vest/cybersun
	name = "cybersun armor vest"
	icon_state = "cybersun_vest"
	desc = "Red hued plasteel with a white insert over the sternum. The insert has been described as a target by cynics."

	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'


/obj/item/clothing/suit/armor/vest/cybersun/trauma
	name = "Trauma Team vest"
	icon_state = "trauma_vest"
	desc = "Hypervisible white-and-teal injection-molded plasteel. The visage of Cybersun's \"Trauma Team\". "
	unique_reskin = list(
		"None" = "trauma_vest",
		"Trauma Teal" = "trauma_teal_vest"
	)


/obj/item/clothing/suit/armor/vest/bulletproof/cybersun
	name = "\improper Cybersun BP armor"
	desc = "Cybersun-branded LVIII ballistic plates. Made to catch bullets and shrapnel. The distinct red frequently hides the consequences of a penetration."
	icon_state = "cybersun_bulletproof"

	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/suit/armor/vest/bulletproof/cybersun/trauma
	name = "\improper Trauma Team BP armor"
	desc = "A bulletproof vest marked in \"Trauma Team\"'s bright white and teal."
	icon_state = "trauma_bulletproof"
	unique_reskin = list(
		"None" = "trauma_bulletproof",
		"Trauma Teal" = "trauma_teal_bulletproof"
	)

/obj/item/clothing/suit/armor/vest/marine/cybersun
	name = "Troubleshooter Vest"
	desc = "A set of molded plasteel plates painted in the colors of Cybersun's \"Troubleshooters\". Excellent all-around protection."
	icon_state = "marine_light_cybersun"
	supports_variations = null
	unique_reskin = null

	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/suit/armor/vest/marine/cybersun/trauma
	name = "Trauma Team Combat Vest"
	desc = "High durability impact resistant plates, used by Trauma Team's first responders."
	icon_state = "trauma_light_cybersun"
	unique_reskin = list(
		"None" = "trauma_light_cybersun",
		"Trauma Teal" = "trauma_teal_light_cybersun"
	)

/obj/item/clothing/suit/armor/vest/marine/medium/cybersun
	name = "Heavy Troubleshooter Suit"
	desc = "Plasteel alloy molded into a crystalline structure for improved durability. Leg and arm pieces included for maximum survivability."
	icon_state = "marine_medium_cybersun"
	supports_variations = null
	unique_reskin = null

	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/suit/armor/vest/marine/medium/cybersun/trauma
	name = "Trauma Team Point Suit"
	desc = "Teal-tinted crystalline plasteel manufactured for Cybersun's \"Trauma Team\". This suit is worn by the \"Pointman\" of a team."
	icon_state = "trauma_medium_cybersun"
	unique_reskin = list(
		"None" = "trauma_medium_cybersun",
		"Trauma Teal" = "trauma_teal_medium_cybersun"
	)

/obj/item/clothing/suit/armor/vest/marine/heavy/cybersun
	name = "\"Solution\" Combat Armor"
	desc = "Woven plastitanium plating with crystalline plasteel filler made to cover the flesh of Cybersun's finest. \"The solution to your hostile corporate problems!\""
	icon_state = "marine_heavy_cybersun"
	supports_variations = null
	unique_reskin = null

	//improved acid armor & radiation
	armor = list("melee" = 60, "bullet" = 60, "laser" = 55, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 40, "fire" = 40, "acid" = 75, "wound" = 40)

	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/suit/armor/vest/marine/heavy/cybersun/trauma
	name = "\"Recovery\" Combat Armor"
	desc = "N2BC-verified plastitanium with crystalline plasteel filler. Through atomic flame, chemical wash, void and the brush, if Cybersun is sending one of these for you, you will be found."
	icon_state = "trauma_heavy_cybersun"
	unique_reskin = list(
		"None" = "trauma_heavy_cybersun",
		"Trauma Teal" = "trauma_teal_heavy_cybersun"
	)

//HEADWEAR

/obj/item/clothing/head/soft/cybersun
	name = "cybersun agent cap"
	desc = "A black baseball hat emblazoned with a reflective Cybersun patch."
	icon_state = "agentsoft"
	unique_reskin = null
	dog_fashion = null

	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

/obj/item/clothing/head/soft/cybersun/medical
	name = "cybersun medic cap"
	desc = "A turquoise baseball hat emblazoned with a reflective cross. Typical of Biodynamics field agents."
	icon_state = "cybersunsoft"
	unique_reskin = null
	dog_fashion = null

/obj/item/clothing/head/cybersun/medical
	name = "surgical cap"
	desc = "A surgical cap made for Cybersun usage. Soft, liquid repellent metamaterials."
	icon_state = "surgical_white"
	unique_reskin = list(
		"White" = "surgical_white",
		"Maroon" = "surgical_maroon"
	)

/obj/item/clothing/head/cybersun
	name = "cybersun hat"
	desc = "A crimson-red hat fit for a high ranking cybersun officer."
	icon_state = "cybersunhat"
	item_state = "cybersunhat"

	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

/obj/item/clothing/head/cybersun/cmo
	name = "\improper Biodynamics director beret"
	desc = "A burgundy-red beret with a silver cross. It smells very sterile."
	icon_state = "meddirectorberet"

//armor headwear

/obj/item/clothing/head/helmet/m10/cybersun
	name = "\improper M10 \"Troubleshooter\""
	desc = "A robust combat helmet commonly employed by Cybersun. Painted in a distinct maroon."
	icon_state = "cybersun_m10helm"
	item_state = "traumahelm"
	can_flashlight = TRUE
	unique_reskin = null

	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

/obj/item/clothing/head/helmet/m10/cybersun/trauma
	name = "M10 \"Trauma Team\""
	desc = "A branded M10 combat helmet painted in Trauma Team colors."
	icon_state = "trauma_m10helm"
	unique_reskin = list(
		"None" = "trauma_m10helm",
		"Trauma Teal" = "trauma_teal_m10helm"
	)

/obj/item/clothing/head/helmet/m10/cybersun/trauma/teal
	current_skin = "Trauma Teal"

/obj/item/clothing/head/helmet/bulletproof/x11/cybersun
	name = "\improper X11 \"Troubleshooter\""
	desc = "A bulletproof combat helmet purchased and modified by Cybersun. Painted in a distinct maroon."
	icon_state = "cybersun_x11helm"

	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'
	unique_reskin = null


/obj/item/clothing/head/helmet/bulletproof/x11/cybersun/trauma
	name = "\improper X11 \"Trauma Team\""
	desc = "A bulletproof combat helmet purchased and modified by Cybersun. Painted in Trauma Team colors."
	icon_state = "trauma_x11helm"
	unique_reskin = list(
		"None" = "trauma_x11helm",
		"Trauma Teal" = "trauma_teal_x11helm"
	)

/obj/item/clothing/head/helmet/riot/cybersun
	name = "\improper Riot \"Solution\" Helmet"
	desc = "A heavy helmet made to pair with Cybersun's \"Solution\" combat armor. Effective against most weapons."
	base_icon_state = "riot_cybersun"
	icon_state = "riot_cybersun"
	unique_reskin = null

	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

/obj/item/clothing/head/helmet/riot/cybersun/trauma
	name = "\improper Riot \"Recovery\" Helmet"
	desc = "A heavy helmet made to pair with Cybersun's Trauma Team \"Recovery\" combat armor. Effective against most weapons."
	base_icon_state = "riot_trauma"
	icon_state = "riot_trauma"
	unique_reskin = list(
		"None" = "riot_trauma",
		"Trauma Teal" = "riot_trauma_teal"
	)
//Cybersun Collapsar hardsuit
/obj/item/clothing/suit/space/hardsuit/collapsar
	name = "\improper Collapsar assault hardsuit"
	desc = "Thick plates of flexible plastitanium-kevlar weave with a titanium laminate applied to seal the top make this armor maneuverable and durable. Typically only issued when a fight is expected."
	icon_state = "hardsuit-collapsar"
	hardsuit_type = "collapsar"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 40, "bomb" = 50, "bio" = 100, "rad" = 65, "fire" = 75, "acid" = 40, "wound" = 30)
	slowdown = 0.5
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/collapsar
	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/collapsar
	name = "\improper Collapsar assault hardsuit helmet"
	desc = "Impact resistant plasmaglass is inset with plastitanium to make a durable helmet with clean unassisted field-of-view."
	icon_state = "hardsuit0-collapsar"
	hardsuit_type = "collapsar"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 40, "energy" = 40, "bomb" = 50, "bio" = 100, "rad" = 65, "fire" = 75, "acid" = 40, "wound" = 30)
	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

/obj/item/clothing/suit/space/hardsuit/collapsar/paramed
	name = "\improper Collapsar retrieval hardsuit"
	desc = "A Collapsar assault hardsuit coated in teal-tinted titanium coverings. Emblematic of the Trauma Team. "
	icon_state = "hardsuit-collapsmed"
	hardsuit_type = "collapsmed"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/collapsar/paramed
	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/collapsar/paramed
	name = "\improper Collapsar retrieval hardsuit helmet"
	icon_state = "hardsuit0-collapsmed"
	hardsuit_type = "collapsmed"
	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

//Cybersun Hardsuit
/obj/item/clothing/suit/space/hardsuit/syndi/cybersun
	name = "neutron-star combat hardsuit"
	desc = "Designed with fighting Makosso-Warra weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "Designed with fighting Makosso-Warra weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in travel mode. Produced by Cybersun Industries."
	icon_state = "hardsuit1-cybersun"
	hardsuit_type = "cybersun"
	armor = list("melee" = 30, "bullet" = 35, "laser" = 60, "energy" = 60, "bomb" = 25, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 60, "wound" = 30)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun
	name = "neutron-star combat hardsuit helmet"
	desc = "Designed with fighting Makosso-Warra weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "Designed with fighting Makosso-Warra weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in travel mode. Produced by Cybersun Industries."
	icon_state = "hardsuit1-cybersun"
	hardsuit_type = "cybersun"
	armor = list("melee" = 30, "bullet" = 35, "laser" = 60, "energy" = 60, "bomb" = 25, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 60, "wound" = 30)
	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

//Cybersun Medical Techinician Hardsuit
/obj/item/clothing/suit/space/hardsuit/syndi/cybersun/paramed
	name = "cybersun medical technician hardsuit"
	desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in travel mode. Produced by Cybersun Industries."
	icon_state = "hardsuit1-cyberparamed"
	hardsuit_type = "cyberparamed"
	armor = list("melee" = 25, "bullet" = 35, "laser" = 40, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 65, "fire" = 75, "acid" = 40, "wound" = 20)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun/paramed
	jetpack = null
	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun/paramed
	name = "cybersun medical technician hardsuit helmet"
	desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in travel mode. Produced by Cybersun Industries"
	icon_state = "hardsuit1-cyberparamed"
	hardsuit_type = "cyberparamed"
	armor = list("melee" = 25, "bullet" = 35, "laser" = 40, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 65, "fire" = 75, "acid" = 40, "wound" = 20)
	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'

//Cybersun infiltrator hardsuit
/obj/item/clothing/suit/space/hardsuit/stealth/cybersun
	name = "\improper Magnetar recon hardsuit"
	desc = "Injection-formed crystalline titanium forms the plates of this lightweight hardsuit, the joints protected by a thin weave of pressure-resistant self-repairing kevlars. A rarity on the field, as Cybersun does not sell them to the open market, instead keeping it for their own service."
	icon = 'icons/obj/clothing/faction/cybersun/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/suits.dmi'
	icon_state = "hardsuit-cyberstealth"
	hardsuit_type = "cyberstealth"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/stealth/cybersun

/obj/item/clothing/head/helmet/space/hardsuit/stealth/cybersun
	name = "\improper Magnetar hardsuit helmet"
	desc = "Thin, slick plates let off a light reflection. Sensors aboard function as a nightvision unit."
	icon = 'icons/obj/clothing/faction/cybersun/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/head.dmi'
	icon_state = "hardsuit0-cyberstealth"
	hardsuit_type = "cyberstealth"
	supports_variations = SNOUTED_VARIATION

//mask

/obj/item/clothing/mask/gas/cybersun
	name = "Cybersun gas mask"
	desc = "A protective gas mask manufactured by Cybersun Biodynamics. This model holds in a single reinforced filter built into the front of the mask, minimizing weight and allowing for easier head movement."
	icon = 'icons/obj/clothing/faction/cybersun/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/mask.dmi'
	icon_state = "cybersun_gas"
	item_state = "cybersun_gas"
	resistance_flags = FIRE_PROOF | ACID_PROOF

/* BELTS */

/obj/item/storage/belt/military/cybersun
	name = "\improper Cybersun webbing"
	desc = "Tactical webbing woven from a metafabric lattice. Lightweight and durable. Perfect for Cybersun's operators."

	icon = 'icons/obj/clothing/faction/cybersun/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/cybersun/belt.dmi'

	icon_state = "cybersun_webbing"
	item_state = "cybersun_webbing"

	unique_reskin = list(
		"Troubleshooter" = "cybersun_webbing",
		"Trauma Team" = "cybersun_med_webbing",
		"Troubleshooter Alt" = "cybersun_webalt",
		"Trauma Alt" = "cybersun_med_webalt"
	)

/obj/item/storage/belt/military/cybersun/sidewinder/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m57_39_sidewinder(src)

/obj/item/storage/belt/military/cybersun/hydra/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m556_42_hydra(src)

/obj/item/storage/belt/military/cybersun/boomslang/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/boomslang(src)

/obj/item/storage/belt/military/cybersun/bulldog/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m12g_bulldog(src)
