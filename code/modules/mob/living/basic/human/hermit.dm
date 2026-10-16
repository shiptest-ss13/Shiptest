/mob/living/basic/human/hermit
	name = "Whitesands Inhabitant"
	desc = "If you can read this, yell at a coder!"
	icon_state = "survivor_base"
	icon_living = "survivor_base"
	habitable_atmos = list("min_oxy" = 1, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 999, "min_n2" = 0, "max_n2" = 0)
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	armor_base = /obj/item/clothing/suit/hooded/survivor
	faction = list(FACTION_ANTAG_HERMITS)
	callout_set = /datum/ai_callout_set/human/hermit
	// the same mix of species as the hermit corpses they leave, see /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	species_weights = list(
		/datum/species/human = 50,
		/datum/species/lizard = 20,
		/datum/species/elzuose = 10,
		/datum/species/moth = 10,
		/datum/species/spider = 10,
	)

	speak_chance = 20
	speak_emote = list("breathes heavily", "growls", "sharply inhales")
	emote_hear = list("murmers.","grumbles.","whimpers.")

/mob/living/basic/human/hermit/survivor
	name = "Hermit Wanderer"
	desc = "A wild-eyed figure, wearing tattered mining equipment and boasting a malformed body, twisted by the heavy metals and high background radiation of the sandworlds."
	r_hand = /obj/item/melee/knife/survival
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	melee_damage_lower = 15
	melee_damage_upper = 15

/mob/living/basic/human/hermit/survivor/passive
	name = "Hermit Villager"
	desc = "A panicked, wild figure, wearing tattered mining equipment and frozen in fear. They regard you with caution, shrinking away as to not be seen."
	r_hand = null
	melee_damage_lower = 5
	melee_damage_upper = 5
	faction = list(FACTION_ANTAG_HERMITS, FACTION_NEUTRAL)

/mob/living/basic/human/hermit/survivor/lunatic
	name = "Hermit Lunatic"
	desc = "A wild-eyed figure clad in tattered mining equipment wielding a plastic chair. They move erratically, eyes darting about frantically."
	r_hand = /obj/item/chair/plastic
	attack_verb_continuous = "bashes"
	attack_verb_simple = "bashed"
	attack_sound = 'sound/items/trayhit1.ogg'
	melee_damage_lower = 5
	melee_damage_upper = 5
	on_aggro_say = list("HAAAAHAAAHAAAAA!!")
	aggro_say_chance = 100
	alert_range = 15 // their cackling brings everyone running
	summons_backup = TRUE

/mob/living/basic/human/hermit/survivor/brawler
	name = "Hermit Brawler"
	desc = "A stanced figure sheltered behind a shoddy, makeshift wooden buckler. A jagged machete is held within their clutch."
	r_hand = /obj/item/melee/sword/mass
	l_hand = /obj/item/shield/buckler
	projectile_deflect_chance = 25

/mob/living/basic/human/hermit/survivor/engineer
	name = "The Engineer"
	desc = "A scrawny Makosso-Warra assistant-engineer. Unarmed and utterly defenseless on their own, they seem oddly out of place."
	icon_state = "warra"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/engineer
	r_hand = null
	noncombatant = TRUE
	callout_set = /datum/ai_callout_set/noncombatant // they shout for help, and plead when cornered
	on_aggro_say = list("DON'T HURT ME!!!")
	aggro_say_chance = 100
	engage_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	speak_emote = list("cowers", "trembles")
	emote_hear = list("hyperventilates.")

/mob/living/basic/human/hermit/ranged
	icon_state = "survivor_hunter"
	icon_living = "survivor_hunter"
	casing_type = /obj/item/ammo_casing/a762_40
	projectile_sound = 'sound/weapons/gun/rifle/shot.ogg'
	burst_interval = 0.6 SECONDS
	retreat_distance = 5
	engage_distance = 5

/mob/living/basic/human/hermit/ranged/hunter
	name = "Hermit Hunter"
	desc ="A wild-eyed figure. Watch out- he has a rifle, and he remembers just enough of his old life to use it!"
	r_hand = /obj/item/gun/ballistic/rifle/polymer

/mob/living/basic/human/hermit/ranged/hunter/sentry
	name = "Hermit Sentry"
	vision_range = 10
	engage_distance = 10
	retreat_distance = 0
	wander = FALSE
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/hermit/ranged/shotgun
	name = "Hermit Pursuer"
	desc = "A wild-eyed figure wielding a makeshift shotgun. The expression through their cloudy visor is fierce, and they're poised to sprint."
	r_hand = /obj/item/gun/ballistic/shotgun/doublebarrel/improvised
	casing_type = /obj/item/ammo_casing/shotgun/improvised
	projectile_sound = 'sound/weapons/gun/shotgun/shot.ogg'
	retreat_distance = 3
	engage_distance = 3

/mob/living/basic/human/hermit/ranged/gunslinger
	name = "Hermit Soldier"
	desc = "The miner's rebellion, though mostly underground, recieved a few good weapon shipments from an off-sector source. You should probably start running."
	icon_state = "survivor_gunslinger"
	icon_living = "survivor_gunslinger"
	projectile_sound = 'sound/weapons/gun/smg/shot.ogg'
	burst_shots = 3
	burst_interval = 0.3 SECONDS
	casing_type = /obj/item/ammo_casing/c46x30mm/recycled
	r_hand = /obj/item/gun/ballistic/automatic/smg/skm_carbine

/mob/living/basic/human/hermit/ranged/tesla_rifle
	name = "Hermit Guardsman"
	desc = "Out in the wilderness of the frontier, desperation can easily become innovation. This hermit is wielding the product of such ventures. Electrical crackles and a rifle ready to roar."
	icon_state = "survivor_gunslinger"
	icon_living = "survivor_gunslinger"
	projectile_sound = 'sound/weapons/zapbang.ogg'
	burst_shots = 2
	burst_interval = 0.2 SECONDS
	casing_type = /obj/item/ammo_casing/c46x30mm/tesla
	r_hand = /obj/item/gun/ballistic/automatic/smg/skm_carbine

/mob/living/basic/human/hermit/ranged/energy
	name = "Hermit Trooper"
	desc = "Quality weapons are hard to get by in the sandworlds, which forces many survivors to improvise with that they have. This one is hoping that an E-11 of all things will save their life."
	icon_state = "survivor_e11"
	icon_living = "survivor_e11"
	projectile_sound = 'sound/weapons/gun/laser/e-fire.ogg'
	burst_interval = 0.1 SECONDS
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/eoehoma/hermit
	r_hand = /obj/item/gun/energy/e_gun/e11

/mob/living/basic/human/hermit/ranged/energy/volt
	name = "Hermit Militaman"
	desc = "In spite of the harsh conditions, this hermit wields a shiny, well-maintained Sharplite carbine. They keep a tight grip on it, as if it was a prized possession."
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'
	burst_shots = 2
	burst_interval = 0.5 SECONDS
	projectile_type = /obj/projectile/beam/laser/sharplite
	r_hand = /obj/item/gun/energy/sharplite/volt
	retreat_distance = 2
	engage_distance = 2

/mob/living/basic/human/hermit/ranged/energy/rush
	name = "Hermit Broker"
	desc = "This hermit hefts a shiny, well-maintained Sharplite submachine gun. The confidence in their motion both a warning and a boast, they know how to use it!"
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'
	burst_shots = 5
	burst_interval = 0.2 SECONDS
	projectile_type = /obj/projectile/beam/weak/sharplite
	r_hand = /obj/item/gun/energy/sharplite/rush

/mob/living/basic/human/hermit/ranged/energy/sarissa
	name = "Hermit Sharpshooter"
	desc = "With discipline impressive for the normally disorganized hermits, this one hefts a shiny, chrome, Sharplite rifle - almost as long as they are tall - and they've been training for this moment!"
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'
	projectile_type = /obj/projectile/beam/laser/sharplite/sniper
	r_hand = /obj/item/gun/energy/sharplite/sarissa
	vision_range = 14
	engage_distance = 14
	retreat_distance = 0
	wander = FALSE
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/hermit/ranged/energy/bodyguard
	name = "The Bouncer"
	desc = "A giant of a man clad in a reinforced survival suit, he seems ready to blast any tresspasser to bits at a moment's notice."
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'
	burst_shots = 5
	burst_interval = 0.4 SECONDS
	retreat_distance = 4
	engage_distance = 7
	projectile_type = /obj/projectile/beam/laser/assault/sharplite
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/bodyguard
	r_hand = /obj/item/gun/energy/sharplite/hades
	armor_base = /obj/item/clothing/suit/space/hardsuit/security
	armored_all_over = TRUE // armoured like a hardsuit all over, as they always have been, though their outfit's only a survival suit
	maxHealth = 150
	health = 150
	morale_breaks = FALSE
	on_aggro_say = list("GET BEHIND ME!!!")
	aggro_say_chance = 100
	speak_emote = list("exhales", "rolls their shoulders")
	emote_hear = list("grunts.","cracks their knuckles.")

/mob/living/basic/human/hermit/mayor
	name = "The Mayor"
	desc = "A blood-red silhouette leveling a wicked battle rifle in your direction. Their suit is worn and damaged, yet still armored. Their stance is trained and alert, unlike many of the wanderers nearby."
	icon_state = "syndicate_hydra"
	burst_shots = 4
	burst_interval = 0.3 SECONDS
	retreat_distance = 4
	engage_distance = 7
	casing_type = /obj/item/ammo_casing/a308
	l_hand = /obj/item/gun/ballistic/automatic/assault/invictus/old
	projectile_sound = 'sound/weapons/gun/hmg/hmg.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/mayor
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/old
	weapon_drop_chance = 100
	maxHealth = 150
	health = 150
	morale_breaks = FALSE
	on_aggro_say = list("TO ME!!")
	aggro_say_chance = 100
	alert_range = 15 // calls the whole settlement to arms
	summons_backup = TRUE

/mob/living/basic/human/hermit/swampboss
	name = "Hermit Warlord"
	desc = "A figure covered in dirty Roumainist plate, slinging around a pristine HP Pyre. They carry the weapon with finesse, though they are still clearly high off their mind."
	burst_shots = 3
	burst_interval = 0.5 SECONDS
	retreat_distance = 3
	engage_distance = 5
	casing_type = /obj/item/ammo_casing/a4570
	l_hand = /obj/item/gun/ballistic/shotgun/flamingarrow/pyre/factory
	projectile_sound = 'sound/weapons/gun/revolver/shot_hunting.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/swampboss
	armor_base = /obj/item/clothing/suit/armor/roumain/plate/medium
	weapon_drop_chance = 100
	maxHealth = 150
	health = 150
	morale_breaks = FALSE
