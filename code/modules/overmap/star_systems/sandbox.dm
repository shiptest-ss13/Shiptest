/datum/overmap_star_system/admin_sandbox
	name = "Admin Sandbox"
	size = 20
	can_jump_to = FALSE
	generator_type = OVERMAP_GENERATOR_NONE

/datum/overmap_star_system/admin_sandbox/create_map()
	new /datum/overmap/sandbox_instructions(list("x" = round(size / 2 + 1), "y" = round(size / 2 + 1)), src)

/datum/overmap/sandbox_instructions
	name = "Admin Sandbox"
	token_icon_state = "sandbox"

/datum/overmap/sandbox_instructions/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	. = ..()
	alter_token_appearance()

/datum/overmap/sandbox_instructions/alter_token_appearance()
	desc = {"
	[span_boldnotice("Welcome to the admin sandbox!")]
	This will ONLY appear for the duration of the testmerge so admins can play with their new tools without torturing players. Too much.
	No, players can't visit here. Unless you throw them here, mwahahahaa.\n
	The buildmode (F7) tools are:
	The [span_notice("(//) --> OVERMAP")] tool is to move overmap objects.
	The [span_notice("MODIF. OVERMAP")] tool is similar in usuage to BUILD ADV but to manipulate the overmap only.
	"}
	return ..()
