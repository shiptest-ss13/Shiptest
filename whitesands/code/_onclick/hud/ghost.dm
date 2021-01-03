/atom/movable/screen/ghost/spawner_menu
	name = "Spawner Menu"
	icon = 'whitesands/icons/mob/screen_ghost.dmi'
	icon_state = "spawner_menu"

/atom/movable/screen/ghost/spawner_menu/Click()
	var/mob/dead/observer/G = usr
	G.open_spawners_menu()


/datum/hud/ghost/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/ghost/spawner_menu()
	using.screen_loc = ui_ghost_spawner_menu
	static_inventory += using
