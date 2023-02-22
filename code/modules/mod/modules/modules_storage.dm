///Storage - Adds a storage component to the suit.
/obj/item/mod/module/storage
	name = "модуль хранилища"
	desc = "Модуль состоит из серии интегрированных отсеков и специализированных карманов по бокам костюма, для хранения ваших вещей."
	icon_state = "storage"
	complexity = 3
	incompatible_modules = list(/obj/item/mod/module/storage, /obj/item/mod/module/plate_compression)
	/// Max weight class of items in the storage.
	var/max_w_class = WEIGHT_CLASS_NORMAL
	/// Max combined weight of all items in the storage.
	var/max_combined_w_class = 15
	/// Max amount of items in the storage.
	var/max_items = 7

/obj/item/mod/module/storage/Initialize(mapload)
	. = ..()
	create_storage(max_specific_storage = max_w_class, max_total_storage = max_combined_w_class, max_slots = max_items)
	atom_storage.allow_big_nesting = TRUE
	atom_storage.locked = TRUE

/obj/item/mod/module/storage/on_install()
	var/datum/storage/modstorage = mod.create_storage(max_specific_storage = max_w_class, max_total_storage = max_combined_w_class, max_slots = max_items)
	modstorage.set_real_location(src)
	atom_storage.locked = FALSE
	RegisterSignal(mod.chestplate, COMSIG_ITEM_PRE_UNEQUIP, .proc/on_chestplate_unequip)

/obj/item/mod/module/storage/on_uninstall(deleting = FALSE)
	var/datum/storage/modstorage = mod.atom_storage
	atom_storage.locked = TRUE
	qdel(modstorage)
	if(!deleting)
		atom_storage.remove_all(get_turf(src))
	UnregisterSignal(mod.chestplate, COMSIG_ITEM_PRE_UNEQUIP)

/obj/item/mod/module/storage/proc/on_chestplate_unequip(obj/item/source, force, atom/newloc, no_move, invdrop, silent)
	if(QDELETED(source) || !mod.wearer || newloc == mod.wearer || !mod.wearer.s_store)
		return
	to_chat(mod.wearer, span_notice("[src] пытается положить [mod.wearer.s_store] внутрь себя."))
	if(atom_storage?.attempt_insert(mod.wearer.s_store, mod.wearer, override = TRUE))
		mod.wearer.temporarilyRemoveItemFromInventory(mod.wearer.s_store)

/obj/item/mod/module/storage/normal_capacity
	name = "модуль хранилища"
	desc = "Модуль состоит из серии интегрированных отсеков и специализированных карманов по бокам костюма, для хранения ваших вещей."
	icon_state = "storage"

/obj/item/mod/module/storage/large_capacity
	name = "продвинутый модуль хранилища"
	desc = "Передовая разработка от Накамура Инженеринг - усовершенствованный контейнер для складирования предметов."
	icon_state = "storage_large"
	max_combined_w_class = 21
	max_items = 14

/obj/item/mod/module/storage/syndicate
	name = "модуль хранилища Синдиката"
	desc = "Система хранения с использованием нанотехнологий используемых контрабандистами. Разработка Киберсан Индастри."
	icon_state = "storage_syndi"
	max_combined_w_class = 30
	max_items = 21

/obj/item/mod/module/storage/bluespace
	name = "модуль блюспейс хранилища"
	desc = "Экспериментальная система хранения использующая технологию блюспейс. Разработка НаноТрейзен."
	icon_state = "storage_large"
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = 60
	max_items = 21
