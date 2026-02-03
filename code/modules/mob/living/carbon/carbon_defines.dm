/mob/living/carbon
	bad_type = /mob/living/carbon
	blood_volume = BLOOD_VOLUME_NORMAL
	gender = MALE
	pressure_resistance = 15
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	hud_possible = list(HEALTH_HUD,STATUS_HUD,ANTAG_HUD,GLAND_HUD,NANITE_HUD,DIAG_NANITE_FULL_HUD)
	has_limbs = 1
	held_items = list(null, null)
	num_legs = 0 //Populated on init through list/bodyparts
	usable_legs = 0 //Populated on init through list/bodyparts
	num_hands = 0 //Populated on init through list/bodyparts
	usable_hands = 0 //Populated on init through list/bodyparts

	rotate_on_lying = TRUE

	var/list/internal_organs		= list()	///List of [/obj/item/organ] in the mob. They don't go in the contents for some reason I don't want to know.
	var/list/internal_organs_slot= list() ///Same as [above][/mob/living/carbon/var/internal_organs], but stores "slot ID" - "organ" pairs for easy access.
	var/silent = 0 		///Can't talk. Value goes down every life proc. NOTE TO FUTURE CODERS: DO NOT INITIALIZE NUMERICAL VARS AS NULL OR I WILL MURDER YOU.
	var/dreaming = 0 ///How many dream images we have left to send

	var/obj/item/handcuffed = null ///Whether or not the mob is handcuffed
	var/obj/item/legcuffed = null  ///Same as handcuffs but for legs. Bear traps use this.

	var/disgust = 0

	//inventory slots
	var/obj/item/back = null
	var/obj/item/clothing/mask/wear_mask = null
	var/obj/item/clothing/neck/wear_neck = null
	var/obj/item/tank/internal = null
	/// "External" air tank. Never set this manually. Not required to stay directly equipped on the mob (i.e. could be a machine or MOD suit module).
	var/obj/item/tank/external = null
	var/obj/item/clothing/head = null

	var/obj/item/wear_id = null //only used by humans
	var/obj/item/clothing/gloves = null ///only used by humans
	var/obj/item/clothing/shoes/shoes = null ///only used by humans.
	var/obj/item/clothing/glasses/glasses = null ///only used by humans.
	var/obj/item/clothing/ears = null ///only used by humans.

	var/datum/dna/dna = null /// Carbon
	var/datum/mind/last_mind = null ///last mind to control this mob, for blood-based cloning

	var/failed_last_breath = 0 ///This is used to determine if the mob failed a breath. If they did fail a brath, they will attempt to breathe each tick, otherwise just once per 4 ticks.

	var/co2overloadtime = null
	var/temperature_resistance = T0C+75
	var/obj/item/food/meat/slab/type_of_meat = /obj/item/food/meat/slab

	var/gib_type = /obj/effect/decal/cleanable/blood/gibs

	var/tinttotal = 0	/// Total level of visualy impairing items

	var/list/icon_render_keys = list()
	var/list/bodyparts = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest,
		BODY_ZONE_HEAD = /obj/item/bodypart/head,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left
	)

	var/list/hand_bodyparts = list() ///a collection of arms (or actually whatever the fug /bodyparts you monsters use to wreck my systems)

	var/static/list/limb_icon_cache = list()

	var/layered_hands //Does the mob have "layered hands" and require using HANDS_UNDER_BODY_LAYER?

	//halucination vars
	var/image/halimage
	var/image/halbody
	var/obj/halitem
	var/hal_screwyhud = SCREWYHUD_NONE
	var/next_hallucination = 0
	/// CPR cooldown.
	var/cpr_time = 1
	var/damageoverlaytemp = 0

	var/stam_regen_start_time = 0 ///used to halt stamina regen temporarily

	/// Protection (insulation) from the heat, Value 0-1 corresponding to the percentage of protection
	var/heat_protection = 0 // No heat protection
	/// Protection (insulation) from the cold, Value 0-1 corresponding to the percentage of protection
	var/cold_protection = 0 // No cold protection

	/// Timer id of any transformation
	var/transformation_timer

	/// All of the wounds a carbon has afflicted throughout their limbs
	var/list/all_wounds

	/// Assoc list of BODY_ZONE -> wounding_type. Set when a limb is dismembered, unset when one is attached. Used for determining what scar to add when it comes time to generate them.
	var/list/body_zone_dismembered_by

	/// Levels of moth dust
	var/mothdust

	/// List of quirk cooldowns to track
	var/list/quirk_cooldown = list()
	/// Timer to remove the dream_sequence timer when the mob is deleted
	var/dream_timer

	/// Can other carbons be shoved into this one to make it fall?
	var/can_be_shoved_into = FALSE

	COOLDOWN_DECLARE(bleeding_message_cd)
