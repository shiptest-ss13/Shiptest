/obj/structure/ship_module
	name = "Broken Ship Module"
	/// The ship we are located on
	var/obj/structure/overmap/ship/simulated/parent = null
	/// The instance of the module managing us
	var/datum/ship_module/module_instance

/obj/structure/ship_module/Initialize(datum/ship_module/module_instance, obj/structure/overmap/ship/simulated/parent, mob/user)
	. = ..()
	src.module_instance = module_instance
	src.parent = parent

/obj/structure/ship_module/Destroy()
	. = ..()
	parent = null
	module_instance.uninstall(parent)
	module_instance = null
