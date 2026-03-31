/obj/item/tape/random/preset/tesla_lab/one/Initialize()
	. = ..()
	storedinfo = list(
		"\[00:00\] Recording started.",
		"\[00:02\] scared human woman whispers \"My n-name is Alyssa Salata- Ident 4070591. CLIP Minutemen-\"",
		"\[00:08\] scared human woman whispers \"T-The base I was assigned to has come under attack from the Frontiersmen.\"",
		"\[00:12\] scared human woman whispers \"From- what I heard on the radio before it turned to screaming-.\"",
		"\[00:15\] scared human woman whispers \"They landed by pretending to be one of our supply shuttles - and when the bays were open...\"",
		"\[00:20\] scared human woman whispers \"It was just a hail of gunfire and flames-\"",
		"\[00:24\] scared human woman whispers \"I ran- I'm- sorry but I couldn't fight |that|-\"",
		"\[00:28\] scared human woman whispers \"I'm in the - panic hole in the armory now.\"",
		"\[00:33\] scared human woman whispers \"I have a CM-23 and some pills that the doc had. But. There's not enough food back here.\"",
		"\[00:37\] scared human woman whispers \"...I don't want to die but I think this is it for me...\"",
		"\[00:43\] scared human woman whispers \"There was way too many of them and there's - not going to be help coming fast enough.\"",
		"\[00:50\] scared human woman gulps something down, a stressed sigh coming from her as she does.",
		"\[00:55\] scared human woman whimpers \"I'll- see if they leave- I- I'll make it-.\"",
	)
	timestamp = list(
	0,
	2,
	8,
	12,
	15,
	20,
	24,
	28,
	33,
	37,
	43,
	50,
	55
	)

/obj/item/tape/random/preset/tesla_lab/two/Initialize()
	. = ..()
	storedinfo = list(
		"\[00:00\] Recording started.",
		"\[00:03\] scared human woman whispers \"My n-name is Alyssa Salata- Ident 4070591. CLIP Minutemen-\"",
		"\[00:06\] scared human woman whispers \"Its been - 4 hours since my last log entry-.\"",
		"\[00:10\] scared human woman whispers \"The radio has been dead for 3. At least.\"",
		"\[00:15\] scared human woman whispers \"The last thing I heard was someone else holing up in - Lab one-\"",
		"\[00:20\] scared human woman whispers \"...That's on the other side of the corridor. I don't think I'd- make it-\"",
		"\[00:23\] scared human woman whispers \"The voices I keep hearing aren't |right| either. It's. They're. Barely human-\"",
		"\[00:27\] scared human woman whispers \"...I know they're outside...\"",
		"\[00:30\] scared human woman chokes \"I- miss my mom-.\"",
		"\[00:33\] scared human woman chokes out another whisper \"-I want to go home.....\"",
	)

	timestamp = list(
		0,
		3,
		6,
		10,
		15,
		20,
		23,
		27,
		30,
		33
	)

#define CHLORINATED_ATMOS "o2=22;n2=82;cl2=24;TEMP=293.15"

/turf/open/floor/plasteel/dark/tesla_lab
	initial_gas_mix = CHLORINATED_ATMOS

/obj/item/desynchronizer/tvstatic
	name = "\improper static synchronizer"
	desc = "An experimental device built around the hissing core of an anomaly. It radiates fear. There is a button on the front that says 'ENGAGE', surrounded by scrawled warnings."
	desync_effect = /obj/effect/temp_visual/phase_out
	resync_effect = /obj/effect/temp_visual/phase_in
	max_duration = 150
	duration = 60

/obj/item/desynchronizer/tvstatic/resync()
	. = ..()
	var/braim_bamage = (world.time - last_use) * 0.25
	playsound(src, 'sound/effects/glassbr1.ogg', 75)
	for(var/mob/living/carbon/human/looking in range(1, src.loc))
		if(HAS_TRAIT(looking, TRAIT_MINDSHIELD) || looking.stat == DEAD || looking.research_scanner)
			continue
		looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, braim_bamage, 200)

/obj/effect/temp_visual/phase_in
	name = "anomalous field"
	icon_state = "phasein"
	layer = 4
	duration = 5

/obj/effect/temp_visual/phase_out
	name = "anomalous field"
	icon_state = "phaseout"
	layer = 4
	duration = 5
