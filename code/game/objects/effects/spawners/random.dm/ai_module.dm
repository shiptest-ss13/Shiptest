/obj/effect/spawner/random/aimodule
	name = "AI module spawner"
	desc = "State laws human."
	icon_state = "circuit"
	spawn_loot_double = FALSE
	spawn_loot_count = 3
	spawn_loot_split = TRUE

/obj/effect/spawner/random/aimodule_harmless // These shouldn't allow the AI to start butchering people
	name = "harmless AI module spawner"
	loot = list(
		/obj/item/aiModule/core/full/asimov,
		/obj/item/aiModule/core/full/asimovpp,
		/obj/item/aiModule/core/full/hippocratic,
		/obj/item/aiModule/core/full/paladin_devotion,
		/obj/item/aiModule/core/full/paladin
	)

/obj/effect/spawner/random/aimodule_neutral // These shouldn't allow the AI to start butchering people without reason
	name = "neutral AI module spawner"
	loot = list(
		/obj/item/aiModule/core/full/corp,
		/obj/item/aiModule/core/full/maintain,
		/obj/item/aiModule/core/full/drone,
		/obj/item/aiModule/core/full/peacekeeper,
		/obj/item/aiModule/core/full/reporter,
		/obj/item/aiModule/core/full/robocop,
		/obj/item/aiModule/core/full/liveandletlive,
		/obj/item/aiModule/core/full/hulkamania
	)

/obj/effect/spawner/random/aimodule_harmful // These will get the shuttle called
	name = "harmful AI module spawner"
	loot = list(
		/obj/item/aiModule/core/full/antimov,
		/obj/item/aiModule/core/full/balance,
		/obj/item/aiModule/core/full/tyrant,
		/obj/item/aiModule/core/full/thermurderdynamic,
		/obj/item/aiModule/core/full/damaged,
		/obj/item/aiModule/reset/purge
	)
