/obj/structure/salvageable/airbase
	name = "starport ruin structure"
	icon = 'icons/mecha/mecha_equipment.dmi'
	density = 0

/obj/structure/salvageable/airbase/missile_launcher
	name = "\improper starfighter missile rack"
	desc = "A devastating strike weapon used by daring Gorlex pilots during the ICW. The firing mechanisms, while sturdy, seem to be ruined by the passage of time."
	icon_state = "mecha_missilerack"
	salvageable_parts = list(
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scraptitanium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,
		/obj/item/stack/sheet/metal/five = 10,
		/obj/item/stack/sheet/plasteel/five = 30,
		/obj/item/gun/ballistic/rocketlauncher = 10
	)

/obj/structure/salvageable/airbase/cannon
	name = "\improper starfighter cannon assembly"
	desc = "A high powered rotary cannon used by daring Gorlex pilots during the ICW. The mechanisms seem to be ruined by the passage of time."
	icon_state = "mecha_scatter"
	salvageable_parts = list(
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scraptitanium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,
		/obj/item/stack/sheet/metal/five = 10,
		/obj/item/stack/sheet/plasteel/five = 30,
	)
