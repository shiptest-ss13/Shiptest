/obj/screen/ghost/spawner_menu
	name = "Spawner Menu"
	icon = 'waspstation/icons/mob/screen_ghost.dmi'
	icon_state = "spawner_menu"

/obj/screen/ghost/spawner_menu/Click()
	var/mob/dead/observer/G = usr
	G.open_spawners_menu()


/datum/hud/ghost/New(mob/owner)
	..()
	var/obj/screen/using
	
	using = new /obj/screen/ghost/spawner_menu()
	using.screen_loc = ui_ghost_spawner_menu
	static_inventory += using
