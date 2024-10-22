//Erika here. I did this because guncase.dm was annoying me. It needs better organization at some point.

/* Hunter's Pride */

/obj/item/storage/guncase/pistol/firebrand
	gun_type = /obj/item/gun/ballistic/revolver/firebrand

/obj/item/storage/guncase/pistol/derringer
	gun_type = /obj/item/gun/ballistic/derringer

/obj/item/storage/guncase/pistol/montagne
	gun_type = /obj/item/gun/ballistic/revolver/montagne
	mag_type = /obj/item/ammo_box/a44roum_speedloader

/obj/item/storage/guncase/pistol/candor
	gun_type = /obj/item/gun/ballistic/automatic/pistol/candor
	mag_type = /obj/item/ammo_box/magazine/m45

/obj/item/storage/guncase/pistol/detective
	gun_type = /obj/item/gun/ballistic/revolver/detective
	mag_type = /obj/item/ammo_box/c38

/obj/item/storage/guncase/pistol/shadow
	gun_type = /obj/item/gun/ballistic/revolver/shadow

/obj/item/storage/guncase/hellfire
	gun_type = /obj/item/gun/ballistic/shotgun/hellfire

/obj/item/storage/guncase/doublebarrel
	gun_type = /obj/item/gun/ballistic/shotgun/doublebarrel

/obj/item/storage/guncase/brimstone
	gun_type = /obj/item/gun/ballistic/shotgun/brimstone

/obj/item/storage/guncase/illestren
	gun_type = /obj/item/gun/ballistic/rifle/illestren
	mag_type = /obj/item/ammo_box/magazine/illestren_a850r

/obj/item/storage/guncase/beacon
	gun_type = /obj/item/gun/ballistic/shotgun/doublebarrel/beacon

/obj/item/storage/guncase/scout
	gun_type = /obj/item/gun/ballistic/rifle/scout
	mag_type = /obj/item/ammo_box/a300

/obj/item/storage/guncase/winchester
	gun_type = /obj/item/gun/ballistic/shotgun/flamingarrow

/obj/item/storage/guncase/conflagration
	gun_type = /obj/item/gun/ballistic/shotgun/flamingarrow/conflagration

/obj/item/storage/guncase/absolution
	gun_type = /obj/item/gun/ballistic/shotgun/flamingarrow/absolution

/* Scarbourough */

/obj/item/storage/guncase/pistol/a357
	gun_type = /obj/item/gun/ballistic/revolver/viper
	mag_type = /obj/item/ammo_box/a357/empty

/obj/item/storage/guncase/pistol/viper
	gun_type = /obj/item/gun/ballistic/revolver/viper/indie

/obj/item/storage/guncase/pistol/ringneck
	gun_type = /obj/item/gun/ballistic/automatic/pistol/ringneck/indie
	mag_type = /obj/item/ammo_box/magazine/m10mm_ringneck

/obj/item/storage/guncase/cobra
	gun_type = /obj/item/gun/ballistic/automatic/smg/cobra/indie
	mag_type = /obj/item/ammo_box/magazine/m45_cobra

/obj/item/storage/guncase/boomslang
	gun_type = /obj/item/gun/ballistic/automatic/marksman/boomslang/indie
	mag_type = /obj/item/ammo_box/magazine/boomslang/short

/* Etherbor */

/obj/item/storage/guncase/pistol/kalixpistol
	gun_type = /obj/item/gun/energy/kalix/pistol
	mag_type = /obj/item/stock_parts/cell/gun/kalix

/obj/item/storage/guncase/energy/kalixrifle
	gun_type = /obj/item/gun/energy/kalix
	mag_type = /obj/item/stock_parts/cell/gun/kalix

/* Serene Outdoors Guns */

/obj/item/storage/guncase/pistol/m17
	gun_type = /obj/item/gun/ballistic/automatic/pistol/m17
	mag_type = /obj/item/ammo_box/magazine/m17

/obj/item/storage/guncase/m12
	gun_type = /obj/item/gun/ballistic/automatic/m12_sporter
	mag_type = /obj/item/ammo_box/magazine/m12_sporter

/obj/item/storage/guncase/m13
	gun_type = /obj/item/gun/ballistic/automatic/m12_sporter/mod
	mag_type = /obj/item/ammo_box/magazine/m12_sporter
	mag_count = 3

/obj/item/storage/guncase/m15
	gun_type = /obj/item/gun/ballistic/automatic/m15
	mag_type = /obj/item/ammo_box/magazine/m15

/obj/item/storage/guncase/buckmaster
	gun_type = /obj/item/gun/ballistic/shotgun/automatic/m11

/* Solar Armories */

/obj/item/storage/guncase/pistol/modelh
	gun_type = /obj/item/gun/ballistic/automatic/powered/gauss/modelh
	mag_type = /obj/item/ammo_box/magazine/modelh

/* VI */

/obj/item/storage/guncase/pistol/commander
	gun_type = /obj/item/gun/ballistic/automatic/pistol/commander
	mag_type = /obj/item/ammo_box/magazine/co9mm

/* Sharplite */

/obj/item/storage/guncase/pistol/miniegun
	gun_type = /obj/item/gun/energy/e_gun/mini
	mag_type = /obj/item/stock_parts/cell/gun/mini

/obj/item/storage/guncase/energy
	mag_type = /obj/item/stock_parts/cell/gun

/obj/item/storage/guncase/energy/laser
	gun_type = /obj/item/gun/energy/laser

/obj/item/storage/guncase/energy/egun
	gun_type = /obj/item/gun/energy/e_gun

/obj/item/storage/guncase/energy/iongun
	gun_type = /obj/item/gun/energy/ionrifle

/* Old NT */
/obj/item/storage/guncase/wt550
	gun_type = /obj/item/gun/ballistic/automatic/smg/wt550
	mag_type = /obj/item/ammo_box/magazine/wt550m9

/* Minutemen */

/obj/item/storage/guncase/pistol/cm23
	gun_type = /obj/item/gun/ballistic/automatic/pistol/cm23
	mag_type = /obj/item/ammo_box/magazine/cm23

/* idk */

/obj/item/storage/guncase/pistol/disposable
/obj/item/storage/guncase/pistol/disposable/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/disposable(src)
	new /obj/item/gun/ballistic/automatic/pistol/disposable(src)

/obj/item/storage/guncase/p16
	gun_type = /obj/item/gun/ballistic/automatic/assault/p16
	mag_type = /obj/item/ammo_box/magazine/p16


/obj/item/storage/guncase/skm
	gun_type = /obj/item/gun/ballistic/automatic/assault/skm
	mag_type = /obj/item/ammo_box/magazine/skm_762_40
