/obj/item/mod/module/storage
	name = "MOD storage module"
	desc = "What amounts to a series of integrated storage compartments and specialized pockets installed across \
		the surface of the suit, useful for storing various bits, and or bobs."
	icon_state = "storage"
	complexity = 3
	incompatible_modules = list(/obj/item/mod/module/storage)
	var/datum/component/storage/concrete/storage
	var/max_w_class = MAX_WEIGHT_CLASS_M_CONTAINER
	var/max_vol = STORAGE_VOLUME_SATCHEL

/obj/item/mod/module/storage/Initialize(mapload)
	. = ..()
	storage = AddComponent(/datum/component/storage/concrete)
	storage.storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT
	storage.max_volume = max_vol
	storage.max_w_class = max_w_class
	storage.allow_big_nesting = TRUE
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)

/obj/item/mod/module/storage/on_install()
	var/datum/component/storage/modstorage = mod.AddComponent(/datum/component/storage, storage)
	modstorage.storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT
	modstorage.max_w_class = max_w_class
	modstorage.max_volume = max_vol
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)

/obj/item/mod/module/storage/on_uninstall(deleting = FALSE)
	var/datum/component/storage/modstorage = mod.GetComponent(/datum/component/storage)
	storage.slaves -= modstorage
	qdel(modstorage)
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)

/obj/item/mod/module/storage/large_capacity
	name = "MOD expanded storage module"
	desc = "An advancement in the storage field, this system of hidden compartments \
		is entirely within the suit, distributing items and weight evenly to ensure a comfortable experience for the user; \
		whether smuggling, or simply hauling."
	icon_state = "storage_large"
	max_vol = STORAGE_VOLUME_BACKPACK

/obj/item/mod/module/storage/syndicate
	name = "MOD syndicate storage module"
	desc = "A storage system using nanotechnology developed by Cybersun Industries, these compartments use \
		esoteric technology to compress the physical matter of items put inside of them, \
		essentially shrinking items for much easier and more portable storage."
	icon_state = "storage_syndi"
	max_vol = STORAGE_VOLUME_DUFFLEBAG

/obj/item/mod/module/storage/bluespace
	name = "MOD bluespace storage module"
	desc = "A storage system developed by Nanotrasen, these compartments employ \
		miniaturized bluespace pockets for the ultimate in storage technology; regardless of the weight of objects put inside."
	icon_state = "storage_large"
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_vol = STORAGE_VOLUME_BAG_OF_HOLDING

