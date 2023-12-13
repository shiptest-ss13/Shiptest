
//Academy Areas

/area/awaymission/academy
	name = "Academy Asteroids"
	icon_state = "away"

/area/awaymission/academy/headmaster
	name = "Academy Fore Block"
	icon_state = "away1"

/area/awaymission/academy/classrooms
	name = "Academy Classroom Block"
	icon_state = "away2"

/area/awaymission/academy/academyaft
	name = "Academy Ship Aft Block"
	icon_state = "away3"

/area/awaymission/academy/academygate
	name = "Academy Gateway"
	icon_state = "away4"

/area/awaymission/academy/academycellar
	name = "Academy Cellar"
	icon_state = "away4"

/area/awaymission/academy/academyengine
	name = "Academy Engine"
	icon_state = "away4"

//Academy Items

/obj/item/paper/fluff/awaymissions/academy/console_maint
	name = "Console Maintenance"
	default_raw_text = "We're upgrading to the latest mainframes for our consoles, the shipment should be in before spring break is over!"

/obj/item/paper/fluff/awaymissions/academy/class/automotive
	name = "Automotive Repair 101"

/obj/item/paper/fluff/awaymissions/academy/class/pyromancy
	name = "Pyromancy 250"

/obj/item/paper/fluff/awaymissions/academy/class/biology
	name = "Biology Lab"

/obj/item/paper/fluff/awaymissions/academy/grade/aplus
	name = "Summoning Midterm Exam"
	default_raw_text = "Grade: A+ Educator's Notes: Excellent form."

/obj/item/paper/fluff/awaymissions/academy/grade/bminus
	name = "Summoning Midterm Exam"
	default_raw_text = "Grade: B- Educator's Notes: Keep applying yourself, you're showing improvement."

/obj/item/paper/fluff/awaymissions/academy/grade/dminus
	name = "Summoning Midterm Exam"
	default_raw_text = "Grade: D- Educator's Notes: SEE ME AFTER CLASS."

/obj/item/paper/fluff/awaymissions/academy/grade/failure
	name = "Pyromancy Evaluation"
	default_raw_text = "Current Grade: F. Educator's Notes: No improvement shown despite multiple private lessons.  Suggest additional tutelage."


/obj/singularity/academy
	dissipate = 0
	move_self = 0
	grav_pull = 1

/obj/singularity/academy/admin_investigate_setup()
	return

/obj/singularity/academy/process()
	eat()
	if(prob(1))
		mezzer()


/obj/item/clothing/glasses/meson/truesight
	name = "The Lens of Truesight"
	desc = "I can see forever!"
	icon_state = "monocle"
	item_state = "headset"


/obj/structure/academy_wizard_spawner
	name = "Academy Defensive System"
	desc = "Made by Abjuration, Inc."
	icon = 'icons/obj/cult.dmi'
	icon_state = "forge"
	anchored = TRUE
	max_integrity = 200
	var/mob/living/current_wizard = null
	var/next_check = 0
	var/cooldown = 600
	var/faction = ROLE_WIZARD
	var/braindead_check = 0

/obj/structure/academy_wizard_spawner/New()
	START_PROCESSING(SSobj, src)

/obj/structure/academy_wizard_spawner/Destroy()
	if(!broken)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/academy_wizard_spawner/process()
	if(next_check < world.time)
		if(!current_wizard)
			for(var/mob/living/L in GLOB.player_list)
				if(L.virtual_z() == src.virtual_z() && L.stat != DEAD && !(faction in L.faction))
					summon_wizard()
					break
		else
			if(current_wizard.stat == DEAD)
				current_wizard = null
				summon_wizard()
			if(!current_wizard.client)
				if(!braindead_check)
					braindead_check = 1
				else
					braindead_check = 0
					give_control()
		next_check = world.time + cooldown

/obj/structure/academy_wizard_spawner/proc/give_control()
	set waitfor = FALSE

	if(!current_wizard)
		return
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as Wizard Academy Defender?", ROLE_WIZARD, null, ROLE_WIZARD, 50, current_wizard, POLL_IGNORE_ACADEMY_WIZARD)

	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		message_admins("[ADMIN_LOOKUPFLW(C)] was spawned as Wizard Academy Defender")
		current_wizard.ghostize() // on the off chance braindead defender gets back in
		current_wizard.key = C.key

/obj/structure/academy_wizard_spawner/proc/summon_wizard()
	var/turf/T = src.loc
	var/mob/living/carbon/human/wizbody = new(T)
	wizbody.fully_replace_character_name(wizbody.real_name, "Academy Teacher")
	wizbody.mind_initialize()
	var/datum/mind/wizmind = wizbody.mind
	wizmind.special_role = "Academy Defender"
	wizmind.add_antag_datum(/datum/antagonist/wizard/academy)
	current_wizard = wizbody

	give_control()

/obj/structure/academy_wizard_spawner/deconstruct(disassembled = TRUE)
	if(!broken)
		broken = 1
		visible_message("<span class='warning'>[src] breaks down!</span>")
		icon_state = "forge_off"
		STOP_PROCESSING(SSobj, src)

/datum/outfit/wizard/academy
	name = "Academy Wizard"
	r_pocket = null
	r_hand = null
	suit = /obj/item/clothing/suit/wizrobe/red
	head = /obj/item/clothing/head/wizard/red
	backpack_contents = list(/obj/item/storage/box/survival = 1)

/obj/structure/ladder/unbreakable/rune
	name = "\improper Teleportation Rune"
	desc = "Could lead anywhere."
	icon = 'icons/obj/rune.dmi'
	icon_state = "1"
	color = rgb(0,0,255)

/obj/structure/ladder/unbreakable/rune/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/structure/ladder/unbreakable/rune/show_fluff_message(up,mob/user)
	user.visible_message("<span class='notice'>[user] activates \the [src].</span>", "<span class='notice'>You activate \the [src].</span>")

/obj/structure/ladder/unbreakable/rune/use(mob/user, is_ghost=FALSE)
	if(is_ghost || !(user.mind in SSticker.mode.wizards))
		..()
