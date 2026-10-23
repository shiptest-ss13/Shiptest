///////////////Base mob////////////
/mob/living/basic/human/ramzi

	name = "Ramzi Clique Initiate"
	desc = "A deserter from the Gorlex Marauders turned pirate. Unfortunately for them, this one is unarmed."
	icon_state = "syndicate"
	icon_living = "syndicate"
	stat_attack = HARD_CRIT
	habitable_atmos = IMMUNE_ATMOS_REQS
	maximum_survivable_temperature = 400
	faction = list(FACTION_RAMZI)
	check_friendly_fire = TRUE
	dodging = TRUE
	rapid_melee = 2
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi
	callout_set = /datum/ai_callout_set/human/ramzi
	flashlight_chance = 50
	throw_back_chance = 10
	armor_base = /obj/item/clothing/suit/armor/vest/syndie
	aim_spread = 3

/mob/living/basic/human/ramzi/space
	in_hardsuit = TRUE
	name = "Ramzi Clique Initiate"
	desc = "A deserter from the Gorlex Marauders turned pirate. Despite their armored hardsuit, this one is unarmed."
	icon_state = "syndicate_space"
	icon_living = "syndicate_space"
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000

	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space

	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi

/mob/living/basic/human/ramzi/space/soft
	name = "Ramzi Clique Initiate"
	desc = "A deserter from the Gorlex Marauders turned pirate wearing an armored softsuit. This one is unarmed."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi

/mob/living/basic/human/ramzi/space/stormtrooper
	morale_breaks = FALSE // hardened killers, who'd sooner die than run
	name = "Ramzi Clique Battlemaster"
	desc = "A silhouette of obsidian glass stalks into view, empty hands clutching into armored fists. They are unarmed, and this is nearly a fair fight."
	icon_state = "syndicate_stormtrooper"
	icon_living = "syndicate_stormtrooper"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper

///////////////Melee////////////

/mob/living/basic/human/ramzi/melee //dude with a knife and no shields
	name = "Ramzi Clique Close Combatant"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a clean and razor-sharp knife with obvious training."
	icon_state = "syndicate_knife"
	icon_living = "syndicate_knife"
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'

	l_hand =/obj/item/melee/knife/combat
	sharpness = SHARP_POINTY

	melee_damage_lower = 20
	melee_damage_upper = 20

/mob/living/basic/human/ramzi/melee/runt
	name = "Ramzi Clique Runt"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a razor-sharp knife shakily, moving with less precision than their colleagues."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/runt
	callout_set = /datum/ai_callout_set/human/ramzi/runt

/mob/living/basic/human/ramzi/melee/runt/chef
	name = "Ramzi Clique Ration Cook"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a clean, razor-sharp knife with both precision and disdain, against the backdrop of a simple jacket."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/runt/noarmour
	armor_base = /obj/item/clothing/suit/ramzi
	l_hand = /obj/item/melee/knife/kitchen
	melee_damage_lower = 18
	melee_damage_upper = 18

/mob/living/basic/human/ramzi/melee/machete
	name = "Ramzi Clique Pioneer"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a long blade, flicking it in their wrist as a challenge to the world."
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"

	l_hand = /obj/item/melee/sword/mass
	sharpness = SHARP_EDGED

	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/basic/human/ramzi/melee/hatchet
	name = "Ramzi Clique Axeman"
	desc = "A deserter from the Gorlex Marauders turned pirate. They wield a hatchet, preparing to swing right at you."
	attack_verb_continuous = "chops"
	attack_verb_simple = "chop"

	l_hand = /obj/item/hatchet/wooden
	sharpness = SHARP_EDGED
	rapid_melee = 2 //compensating for the weak weapon (and making the unarmoured engis more of a threat)

	melee_damage_lower = 16
	melee_damage_upper = 16 //theyre just good at swinging okay (weaker than regular knife guy but not irrelevant)

	weapon_drop_chance = 35 //loot value of a hatchet is limited

/mob/living/basic/human/ramzi/melee/hatchet/engi
	name = "Ramzi Clique Defoliator"
	desc = "A deserter from the Gorlex Marauders turned pirate. They clutch a hatchet in dirty old gloves, ready to take a firm swing."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/engi
	armor_base = /obj/item/clothing/suit/ramzi //they're an engi not a combatant

/mob/living/basic/human/ramzi/melee/sawbones
	name = "Ramzi Clique Field Medic"
	desc = "A deserter from the Gorlex Marauders turned pirate. They clutch a bonesaw, its blade whirring away amidst the backdrop of their maroon smock."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/doctor
	armor_base = /obj/item/clothing/suit/ramzi/smock //i am a surgeon

	l_hand = /obj/item/circular_saw //WHIRR
	sharpness = SHARP_EDGED
	attack_verb_continuous = "saws"
	attack_verb_simple = "sawed"

	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_sound = 'sound/weapons/circsawhit.ogg'

/mob/living/basic/human/ramzi/melee/angle_grinder //i'm evil like that
	name = "Ramzi Clique Cutter"
	desc = "A deserter from the Gorlex Marauders turned pirate. They wrestle a bulky angle grinder, training it in your direction."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/engi/grinder
	l_hand = /obj/item/fake_anglegrinder //mandatory jank do NOT let it drop
	weapon_drop_chance = 0 //the backpack drops with their corpse. this will always drop a grinder.
	sharpness = SHARP_EDGED
	attack_verb_continuous = "saws"
	attack_verb_simple = "sawed"
	melee_damage_lower = 30 //as much straight damage as the hammer, but they don't knock you about
	melee_damage_upper = 30
	attack_sound = 'sound/weapons/anglegrinder.ogg'

/obj/item/fake_anglegrinder
	name = "angle grinder"
	desc = "I DEMAND that you adminhelp this thing's existence IMMEDIATELY!!! it is an affront to GOD used by coders to make the ramzi clique pretend to have angle grinders!!!! it also does LITERALLY NOTHING so you should throw it into a crusher or something!!!! also if someone mapped this, lol, lmao even, dingus"
	icon = 'icons/obj/item/gear_packs.dmi'
	icon_state = "anglegrinder-wield"
	item_state = "anglegrinder-wield"
	lefthand_file = 'icons/mob/inhands/equipment/gear_handle_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/gear_handle_righthand.dmi'

/mob/living/basic/human/ramzi/melee/sledge
	melee_knockback = 2
	name = "Ramzi Clique Breaker"
	desc = "A deserter from the Gorlex Marauders turned pirate. Their palms are twisted around the shaft of a crimson-black sledgehammer."

	icon_state = "syndicate_sword"
	icon_living = "syndicate_sword"

	l_hand = /obj/item/melee/sledgehammer/gorlex
	sharpness = SHARP_NONE
	armour_penetration = 40
	melee_damage_lower = 30
	melee_damage_upper = 30

	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'

/mob/living/basic/human/ramzi/melee/sledge/engi
	name = "Ramzi Clique Demolitionist"
	desc = "A deserter from the Gorlex Marauders turned pirate. Tattered yellow gloves cover palms that curl around the shaft of a crimson-black sledgehammer."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/engi
	armor_base = /obj/item/clothing/suit/ramzi

/* Space Melee */

/mob/living/basic/human/ramzi/melee/space
	in_hardsuit = TRUE
	name = "Ramzi Clique Infiltrator"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rusted hardsuit gauntlets hold a shard of polished steel in a veteran's guard."
	icon_state = "syndicate_space_knife"
	icon_living = "syndicate_space_knife"
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000

	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi

	l_hand =/obj/item/melee/knife/combat
	sharpness = SHARP_POINTY

	melee_damage_lower = 20
	melee_damage_upper = 20

/mob/living/basic/human/ramzi/melee/space/machete
	name = "Ramzi Clique Bladesman"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rust silhouttes a well-maintained machete, swinging around their hip."
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	l_hand =/obj/item/melee/sword/mass
	sharpness = SHARP_EDGED
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/basic/human/ramzi/melee/space/soft
	name = "Ramzi Clique Infiltrator"
	desc = "A deserter from the Gorlex Marauders turned pirate. A softsuit's gauntlets hold a shard of polished steel in a veteran's guard."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi

/mob/living/basic/human/ramzi/melee/space/soft/machete
	name = "Ramzi Clique Bladesman"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rust silhouttes a well-maintained machete, swinging around their hip."
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	l_hand = /obj/item/melee/sword/mass
	sharpness = SHARP_EDGED
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/basic/human/ramzi/melee/space/sledge
	melee_knockback = 2
	name = "Ramzi Clique Hullsmasher"
	desc = "A deserter from the Gorlex Marauders turned pirate. Their decayed hardsuit still obeys as they raise their sledgehammer in challenge."
	icon_state = "syndicate_space_sword"
	icon_living = "syndicate_space_sword"
	armour_penetration = 40
	melee_damage_lower = 30
	melee_damage_upper = 30
	sharpness = SHARP_NONE

	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'

	l_hand =/obj/item/melee/sledgehammer/gorlex

/* stormtroopers */

/mob/living/basic/human/ramzi/melee/space/stormtrooper
	morale_breaks = FALSE // hardened killers, who'd sooner die than run
	name = "Ramzi Clique Assassin"
	desc = "Wicked knifepoint tracks your every impulse. Clean, black-red armor plate glides across itself, bereft of all sound or resistance."
	icon_state = "syndicate_stormtrooper_knife"
	icon_living = "syndicate_stormtrooper_knife"
	maxHealth = 200
	health = 200
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper

/mob/living/basic/human/ramzi/melee/space/stormtrooper/commander
	is_commander = TRUE
	on_aggro_say = list("SIC 'EM!!")
	aggro_say_chance = 100
	summons_backup = TRUE

/mob/living/basic/human/ramzi/melee/space/stormtrooper/sledge
	name = "Ramzi Clique Supercollider"
	callout_set = /datum/ai_callout_set/human/ramzi/supercollider
	desc = "Rapid, practiced motions permeate the body underneath the crimson suit of this radiantly hateful being. Each one ripples to the surface, the eyes of a suit tracking you as it brings a sledgehammer to bear."
	icon_state = "syndicate_stormtrooper_sword"
	icon_living = "syndicate_stormtrooper_sword"
	l_hand = /obj/item/melee/sledgehammer/gorlex
	sharpness = SHARP_NONE
	armour_penetration = 40
	melee_damage_lower = 30
	melee_damage_upper = 30
	melee_knockback = 3
	knockdowns_slow_instead = TRUE // too juiced up to go down, it just staggers
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'

///////////////Guns////////////

/mob/living/basic/human/ramzi/ranged
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate. They warily glance around, a compact sidearm held at the ready."
	retreat_distance = 5
	engage_distance = 5
	icon_state = "syndicate_pistol"
	icon_living = "syndicate_pistol"
	casing_type = /obj/item/ammo_casing/c10mm
	projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	rapid_melee = 1
	l_hand =/obj/item/gun/ballistic/automatic/pistol/ringneck

/mob/living/basic/human/ramzi/ranged/himehabu
	name = "Ramzi Clique Runt"
	desc = "A terrified deserter from the Gorlex Marauders turned pirate, with nothing but fear in their eyes. They cradle a pitiful .22 pistol, shivering and hoping it might just buy them another second."
	armor_base = /obj/item/clothing/suit/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/runt/noarmour
	casing_type = /obj/item/ammo_casing/c22lr
	projectile_sound = 'sound/weapons/gun/pistol/himehabu.ogg'
	l_hand = /obj/item/gun/ballistic/automatic/pistol/himehabu

/mob/living/basic/human/ramzi/ranged/runt
	name = "Ramzi Clique Initiate"
	desc = "A deserter from the Gorlex Marauders turned pirate. They clutch a compact sidearm, seeming to shiver a bit at every slight movement."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/runt
	retreat_distance = 3 //they don't run as much because they suck at aiming

/mob/living/basic/human/ramzi/ranged/runt/flapcap
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/runt/flapcap //i was considering making it random but i dont think itd end well

/mob/living/basic/human/ramzi/ranged/cottonmouth
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate. They warily glance around, a modified machinepistol held at the ready."
	burst_shots = 2
	projectile_sound = 'sound/weapons/gun/pistol/asp.ogg'
	l_hand = /obj/item/gun/ballistic/automatic/pistol/rattlesnake/cottonmouth

/mob/living/basic/human/ramzi/ranged/cottonmouth/scout
	burst_shots = 1
	vision_range = 10
	engage_distance = 10
	wander = FALSE
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/ramzi/ranged/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their submachinegun held at eye level, sweeping every corner."
	burst_shots = 3
	icon_state = "syndicate_smg"
	icon_living = "syndicate_smg"
	projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	l_hand =/obj/item/gun/ballistic/automatic/smg/cobra

/mob/living/basic/human/ramzi/ranged/smg/grenadier
	name = "Ramzi Clique Grenadier"
	desc = "A deserter from the Gorlex Marauders turned pirate. A few frag grenades hang off their belt, their thumb never far from a pin."
	grenade_type = /obj/item/grenade/frag
	grenade_count = 2

/mob/living/basic/human/ramzi/ranged/smg/sidewinder
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their PDW held at eye level, sweeping every corner."
	l_hand = /obj/item/gun/ballistic/automatic/smg/sidewinder
	burst_interval = 0.15 SECONDS
	casing_type = /obj/item/ammo_casing/c57x39mm
	projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'

/mob/living/basic/human/ramzi/ranged/smg/sidewinder/ballistic
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a PDW level to their yellow visor, sweeping the room with disdain and precision."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/trooper
	armor_base = /obj/item/clothing/suit/armor/ramzi/bulletproof

/mob/living/basic/human/ramzi/ranged/hydra
	name = "Ramzi Clique Trooper"
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their assault rifle held at eye level, sweeping every corner."
	burst_shots = 3
	icon_state = "syndicate_hydra"
	casing_type = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra
	projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'

/mob/living/basic/human/ramzi/ranged/hydra/gunsmith
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/trooper
	armor_base = /obj/item/clothing/suit/armor/ramzi/bulletproof

/mob/living/basic/human/ramzi/ranged/hydra/dmr
	name = "Ramzi Clique Tracker"
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their assault rifle held at eye level, sweeping every corner."
	burst_shots = 2
	icon_state = "syndicate_hydra"
	casing_type = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra/dmr
	projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi
	armor_base = /obj/item/clothing/suit/armor/ramzi

	engage_distance = 7
	vision_range = 12

/mob/living/basic/human/ramzi/ranged/hydra/dmr/sentry
	vision_range = 14
	engage_distance = 14
	wander = FALSE
	holds_post = TRUE
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/ramzi/ranged/hydra/dmr/sentry/ballistic
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/trooper
	armor_base = /obj/item/clothing/suit/armor/ramzi/bulletproof

/mob/living/basic/human/ramzi/ranged/officer

	name = "Ramzi Clique Quartermaster"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold themselves high, clad in well-taken care of officer garbs. They clutch a blackened revolver in their hands."
	icon_state = "syndicate_officer"
	casing_type = /obj/item/ammo_casing/a357
	l_hand = /obj/item/gun/ballistic/revolver/viper
	projectile_sound = 'sound/weapons/gun/revolver/viper.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/officer
	callout_set =  /datum/ai_callout_set/human/ramzi/officer
	is_commander = TRUE // gives orders, hangs back


/mob/living/basic/human/ramzi/ranged/officer/asp
	name = "Ramzi Clique Ensign"
	desc = "A deserter from the Gorlex Marauders turned pirate. They glance around warily, clad in well-maintained officer garbs. They clutch a rather hefty pistol in their hands."
	casing_type = /obj/item/ammo_casing/c57x39mm
	l_hand = /obj/item/gun/ballistic/automatic/pistol/asp
	projectile_sound = 'sound/weapons/gun/pistol/asp.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/ensign

/mob/living/basic/human/ramzi/ranged/officer/smg
	name = "Ramzi Clique Commander"
	desc = "A deserter from the Gorlex Marauders turned pirate, clad in well-maintained officer garbs. They cradle a lightweight submachinegun in their hands, sweeping it side-to-side."
	burst_shots = 3
	casing_type = /obj/item/ammo_casing/c10mm
	projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	l_hand =/obj/item/gun/ballistic/automatic/smg/cobra

	armor_base = /obj/item/clothing/suit/armor/ramzi/officer

/mob/living/basic/human/ramzi/ranged/officer/beach
	name = "Ramzi Clique Quartermaster"
	desc = "A deserter from the Gorlex Marauders turned pirate. She holds herself high, clad in well-taken care of officer garbs. She clutches a blackened revolver in her hands."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/officer/beach
	casing_type = /obj/item/ammo_casing/a357/match
	mob_species = /datum/species/human

/mob/living/basic/human/ramzi/ranged/officer/ngr
	name = "New Gorlex Embezzler"
	desc = "A sleazy official of the New Gorlex Republic, wearing a heavy officer coat. She looks around cautiously, a heavy pistol within her hands."
	callout_set = /datum/ai_callout_set/human/ramzi/ngr_officer
	casing_type = /obj/item/ammo_casing/c57x39mm
	l_hand = /obj/item/gun/ballistic/automatic/pistol/asp
	projectile_sound = 'sound/weapons/gun/pistol/asp.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/officer/ngr
	mob_species = /datum/species/human

	armor_base = /obj/item/clothing/suit/armor/ngr/lieutenant
	is_commander = FALSE

/mob/living/basic/human/ramzi/ranged/officer/lieutenant
	name = "Ramzi Clique Lieutenant"
	desc = "A commanding deserter from the Gorlex Marauders turned pirate. They cradle a revolver as black as a starless sky, covered in a thick, dirty-green coat. They turn their gaze in your direction; intent on ensuring they are the last thing you see."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/lieutenant

/mob/living/basic/human/ramzi/ranged/officer/captain
	name = "Ramzi Clique Captain"
	desc = "A commanding deserter from the Gorlex Marauders turned pirate. They hold themselves high, clad in an imposing, well-maintained greatcoat; calmly wielding a pitch-black revolver."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/officer/captain
	armor_base = /obj/item/clothing/suit/armor/ramzi/captain
	burst_shots = 2 //they are well-trained and can thus fire a viper quicker
	burst_interval = 0.4 SECONDS

/mob/living/basic/human/ramzi/ranged/shotgun
	name = "Ramzi Clique Breacher"
	desc = "A deserter from the Gorlex Marauders turned pirate. They move low and quickly, heavy combat shotgun at the ready."
	burst_shots = 2
	burst_interval = 0.6 SECONDS
	retreat_distance = 4
	engage_distance = 3
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	casing_type = /obj/item/ammo_casing/shotgun/buckshot //buckshot fired in a two-round burst. This will two-tap unarmored players.
	projectile_sound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	l_hand =/obj/item/gun/ballistic/shotgun/automatic/bulldog/bockadam

/mob/living/basic/human/ramzi/ranged/shotgun/ballistic
	desc = "A deserter from the Gorlex Marauders turned pirate. Their yellow goggles hide an expression of malice, a heavy combat shotgun already trained in your direction."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/trooper
	armor_base = /obj/item/clothing/suit/armor/ramzi/bulletproof

/mob/living/basic/human/ramzi/ranged/shotgun/gaboon
	name = "Ramzi Clique Doorkicker"
	desc = "A deserter from the Gorlex Marauders turned pirate. They rush at you to close any distance - wielding a thin, jet-black shotgun."
	l_hand = /obj/item/gun/ballistic/shotgun/gaboon
	projectile_sound = 'sound/weapons/gun/shotgun/brimstone.ogg'
	burst_shots = 1 //not exactly a bockadam is it now

/mob/living/basic/human/ramzi/ranged/shotgun/gaboon/ballistic
	desc = "A deserter from the Gorlex Marauders turned pirate. They cradle a thin, jet-black shotgun, their yellow goggles hiding an expression of malice as they charge towards you."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/trooper
	armor_base = /obj/item/clothing/suit/armor/ramzi/bulletproof

/mob/living/basic/human/ramzi/ranged/shotgun/incendiary
	name = "Ramzi Clique Firestarter"
	desc = "A deserter from the Gorlex Marauders turned pirate. Their finger twitches around the trigger of their combat shotgun."
	casing_type = /obj/item/ammo_casing/shotgun/incendiary
	l_hand =/obj/item/gun/ballistic/shotgun/automatic/bulldog
	burst_shots = 1

/mob/living/basic/human/ramzi/ranged/sniper
	name = "Ramzi Clique Overwatch"
	desc = "A deserter from the Gorlex Marauders turned pirate. They turn their eyes to the horizon, always ready to pull the trigger."
	engage_distance = 7
	vision_range = 12
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	casing_type = /obj/item/ammo_casing/a65clip
	projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	l_hand = /obj/item/gun/ballistic/automatic/marksman/boomslang

/mob/living/basic/human/ramzi/ranged/sniper/sentry
	vision_range = 14
	engage_distance = 14
	wander = FALSE
	holds_post = TRUE
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/* Irregular Ranged (non-standard weapons for whatever reason) */

/mob/living/basic/human/ramzi/ranged/sniper/illestren
	name = "Ramzi Clique Hunter"
	desc = "A deserter from the Gorlex Marauders turned pirate. A dirty wood-furnished rifle is cradled in their tattered gloves - ironsights turned to the horizon."
	projectile_sound = 'sound/weapons/gun/rifle/mosin.ogg'
	casing_type = /obj/item/ammo_casing/a8_50r
	l_hand = /obj/item/gun/ballistic/rifle/illestren

/mob/living/basic/human/ramzi/ranged/sniper/illestren/sentry
	vision_range = 9 //should still be better than standard but theyre using ironsights
	engage_distance = 9
	wander = FALSE
	holds_post = TRUE
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/ramzi/ranged/officer/lieutenant/indie_boomslang
	name = "Ramzi Clique Overseer"
	desc = "An imposing deserter from the Gorlex Marauders turned pirate, clad in a dirty-green overcoat and staring down the scope of a bulky, beige-tinted rifle."
	l_hand = /obj/item/gun/ballistic/automatic/marksman/boomslang/indie
	casing_type = /obj/item/ammo_casing/a65clip
	projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'

/mob/living/basic/human/ramzi/ranged/officer/lieutenant/indie_boomslang/sentry
	engage_distance = 11
	vision_range = 11 //worse scope but more of a threat than the illestren
	wander = FALSE
	holds_post = TRUE
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/ramzi/ranged/smg/indiegun
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan their surroundings with a dirty beige submachinegun - finger on the trigger."
	l_hand = /obj/item/gun/ballistic/automatic/smg/cobra/indie
	burst_shots = 4 //true to the gun

/mob/living/basic/human/ramzi/ranged/engineer
	name = "Ramzi Clique Combat Engineer"
	desc = "A deserter from the Gorlex Marauders turned pirate. They cradle a dirty-beige sidearm in tattered gloves, sweeping from side to side."
	l_hand = /obj/item/gun/ballistic/automatic/pistol/ringneck/indie
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/engi
	armor_base = /obj/item/clothing/suit/ramzi

/* Space Ranged */

/mob/living/basic/human/ramzi/ranged/space
	in_hardsuit = TRUE
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rusty gauntlets clutches a modified machinepistol, scanning for threats."
	icon_state = "syndicate_space_pistol"
	icon_living = "syndicate_space_pistol"
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	burst_shots = 2
	projectile_sound = 'sound/weapons/gun/pistol/asp.ogg'
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space
	l_hand = /obj/item/gun/ballistic/automatic/pistol/rattlesnake/cottonmouth

/mob/living/basic/human/ramzi/ranged/space/hydra
	name = "Ramzi Clique Trooper"
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their assault rifle held with rusty gauntlets, sweeping every corner."
	burst_shots = 3
	icon_state = "syndicate_hydra"
	casing_type = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra
	projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space

/mob/living/basic/human/ramzi/ranged/space/hydra/dmr
	name = "Ramzi Clique Tracker"
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their assault rifle held at eye level, sweeping every corner."
	burst_shots = 2
	icon_state = "syndicate_hydra"
	casing_type = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra/dmr
	projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space

	engage_distance = 7
	vision_range = 12

/mob/living/basic/human/ramzi/ranged/space/soft
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate, wearing an armored softsuit. They clutch a pocket pistol, the added bulk of their wrappings giving it a rather undersized appearance."
	icon_state = "syndicate_space_pistol"
	icon_living = "syndicate_space_pistol"
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	burst_shots = 1
	l_hand = /obj/item/gun/ballistic/automatic/pistol/ringneck
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft

/mob/living/basic/human/ramzi/ranged/space/soft/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. A painted skull grimaces on their helmet as they sweep their submachinegun across the room, scanning for threats."
	icon_state = "syndicate_space_smg"
	icon_living = "syndicate_space_smg"
	l_hand = /obj/item/gun/ballistic/automatic/smg/cobra
	projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	burst_shots = 3
	casing_type = /obj/item/ammo_casing/c10mm

/mob/living/basic/human/ramzi/ranged/space/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. Green hardsuit optics glint as they sweep their submachinegun across the room, scanning for threats."
	icon_state = "syndicate_space_smg"
	icon_living = "syndicate_space_smg"
	l_hand = /obj/item/gun/ballistic/automatic/smg/cobra
	projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	burst_shots = 3
	casing_type = /obj/item/ammo_casing/c10mm

/mob/living/basic/human/ramzi/ranged/space/smg/sidewinder
	desc = "A deserter from the Gorlex Marauders turned pirate. Green hardsuit optics glint as they sweep their PDW across the room, scanning for threats."
	l_hand = /obj/item/gun/ballistic/automatic/smg/sidewinder
	burst_shots = 3
	burst_interval = 0.15 SECONDS
	casing_type = /obj/item/ammo_casing/c57x39mm
	projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'

/mob/living/basic/human/ramzi/ranged/space/shotgun
	name = "Ramzi Clique Breacher"
	desc = "A deserter from the Gorlex Marauders turned pirate. The unmistakeable bulk of a Bockadam shotgun graces the wrapped, patched hands of their aging hardsuit."
	icon_state = "syndicate_space_shotgun"
	icon_living = "syndicate_space_shotgun"
	casing_type = /obj/item/ammo_casing/shotgun/buckshot
	l_hand = /obj/item/gun/ballistic/shotgun/automatic/bulldog/bockadam
	projectile_sound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	burst_shots = 2
	burst_interval = 0.6 SECONDS
	retreat_distance = 2
	engage_distance = 2

/mob/living/basic/human/ramzi/ranged/space/sniper
	name = "Ramzi Clique Deadeye"
	desc = "A deserter from the Gorlex Marauders turned pirate. The cold expressionless helmet betrays nothing but contempt as they await their next target."
	engage_distance = 7
	vision_range = 12
	burst_shots = 1
	icon_state = "syndicate_space_shotgun"
	icon_living = "syndicate_space_shotgun"
	casing_type = /obj/item/ammo_casing/a65clip
	l_hand = /obj/item/gun/ballistic/automatic/marksman/boomslang
	projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	armor_base = /obj/item/clothing/suit/space/hardsuit/stealth/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/sniper

/mob/living/basic/human/ramzi/ranged/space/sniper/sentry
	vision_range = 14
	engage_distance = 14
	wander = FALSE
	holds_post = TRUE
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/ramzi/ranged/space/shotgun/incendiary
	name = "Ramzi Clique Boiler"
	desc = "A deserter from the Gorlex Marauders turned pirate. The hateful eyes of a hardsuit stare down the sight of a Bulldog shotgun, elegance in its movements."
	burst_shots = 1
	casing_type = /obj/item/ammo_casing/shotgun/incendiary

/* ranged stormtroopers */

/mob/living/basic/human/ramzi/ranged/space/stormtrooper
	morale_breaks = FALSE // hardened killers, who'd sooner die than run
	name = "Ramzi Clique Pistolmaster" //I can't think of something better, sue me
	desc = "Obsidian armor cradles a machinepistol with sculptural grace. Its snub muzzle follows you before you even think to move."
	icon_state = "syndicate_stormtrooper_pistol"
	icon_living = "syndicate_stormtrooper_pistol"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	l_hand = /obj/item/gun/ballistic/automatic/pistol/rattlesnake/cottonmouth
	projectile_sound = 'sound/weapons/gun/pistol/asp.ogg'
	burst_shots = 2

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/hydra
	name = "Ramzi Clique Sweeper"
	desc = "An imposing deserter from the Gorlex Marauders turned pirate. They scan the room with their assault rifle held with rusty, blackened gauntlets, sweeping every corner." //i dont got anything flowery to put srry
	burst_shots = 4
	icon_state = "syndicate_stormtrooper_smg"
	casing_type = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra
	projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/hydra/dmr
	name = "Ramzi Clique Stalker"
	desc = "An imposing deserter from the Gorlex Marauders turned pirate. They scan the room with their DMR held with rusty, blackened gauntlets, sweeping every corner." //ditto
	burst_shots = 2
	icon_state = "syndicate_stormtrooper_shotgun"
	casing_type = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra/dmr
	projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite

	engage_distance = 7
	vision_range = 12

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/hydra/dmr/sentry
	vision_range = 14
	engage_distance = 14
	wander = FALSE
	holds_post = TRUE
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/smg
	name = "Ramzi Clique Shock Trooper"
	desc = "Night-black armor traces the silhouette of a soldier equaled by precious few. Their Sidewinder tracks you perfectly, a staccato bark of 5.7 already in its throat."
	icon_state = "syndicate_stormtrooper_smg"
	icon_living = "syndicate_stormtrooper_smg"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	l_hand = /obj/item/gun/ballistic/automatic/smg/sidewinder
	burst_shots = 4
	burst_interval = 0.15 SECONDS
	casing_type = /obj/item/ammo_casing/c57x39mm
	projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/shotgun
	name = "Ramzi Clique Executioner"
	knockdowns_slow_instead = TRUE // too heavily armoured to be put down, it just staggers
	desc = "Ink and black glass poured into the shape of an armored commando, dripping menace with every step. Their combat shotgun follows you with lethal intent, promising a blizzard of buckshot in less than a blink."
	icon_state = "syndicate_stormtrooper_shotgun"
	icon_living = "syndicate_stormtrooper_shotgun"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	l_hand = /obj/item/gun/ballistic/shotgun/automatic/bulldog/bockadam
	casing_type = /obj/item/ammo_casing/shotgun/buckshot
	projectile_sound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	burst_shots = 3
	burst_interval = 0.5 SECONDS
	retreat_distance = 2
	engage_distance = 2

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/shotgun/incendiary
	name = "Ramzi Clique Incinerator"
	desc = "Crimson and darkness fill the mold of an armored commando, eyes rapidly switching targets as it strides. Its combat shotgun is raised, ready to let loose a roar that shall not be forgotten."
	casing_type = /obj/item/ammo_casing/shotgun/dragonsbreath
	burst_shots = 2
	burst_interval = 0.7 SECONDS

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/sniper
	name = "Ramzi Clique Cleaner"
	desc = "Black and red, black and red, and you're dead all over. They've already seen you, and are training their next shot with practiced distaste."
	engage_distance = 7
	vision_range = 20
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	burst_shots = 2
	burst_interval = 1 SECONDS
	casing_type = /obj/item/ammo_casing/a65clip
	l_hand = /obj/item/gun/ballistic/automatic/marksman/boomslang
	projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'

/mob/living/basic/human/ramzi/ranged/space/stormtrooper/sniper/taipan
	burst_shots = 1
	casing_type = /obj/item/ammo_casing/p50
	l_hand = /obj/item/gun/ballistic/automatic/marksman/taipan
	projectile_sound = 'sound/weapons/gun/sniper/shot.ogg'

///////////////Misc////////////

/mob/living/basic/human/ramzi/civilian
	summons_backup = TRUE
	name = "Ramzi Clique Technician"
	desc = "A deserter from the Gorlex Marauders turned pirate. A tattered respirator and hard-hat conceals their identity as they cower."
	engage_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/engi
	armor_base = /obj/item/clothing/suit/ramzi //nope
	noncombatant = TRUE
	callout_set = /datum/ai_callout_set/noncombatant
	on_aggro_say = list("GUARDS!!!","INTRUDER!!","HELP!!")
	aggro_say_chance = 100

/mob/living/basic/human/ramzi/civilian/space
	name = "Ramzi Clique Technician"
	desc = "A deserter from the Gorlex Marauders turned pirate, wearing a flimsy softsuit. This one is not only unarmed, but a coward as well."
	engage_distance = 10
	retreat_distance = 10
	obj_damage = 0
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft/surplus
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/ramzi/civilian/towel
	name = "Ramzi Clique Soapmaster"
	desc = "A deserter from the Gorlex Marauders turned pirate. This one is not only unarmed, but also just got out the shower."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/towel
	armor_base = null
	on_aggro_say = list("HELP!!!","SOMEBODY, HELP!!!","INTRUDER!! HELP!!!","GO AWAY!!","LEAVE ME ALONE!!","GUARDS!!!")

/mob/living/basic/human/ramzi/civilian/runt
	name = "Ramzi Clique Runt"
	desc = "A deserter from the Gorlex Marauders turned pirate. This one is not only unarmed, but a coward as well."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/runt/noarmour
	on_aggro_say = list("I DON'T WANT TO DIE!! HELP!!!","HELP ME!!!","GUARDS!!!","HELP!!!","GET ME OUT OF HERE!!")

/mob/living/basic/human/ramzi/civilian/runt/flapcap
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/runt/noarmour/flapcap
