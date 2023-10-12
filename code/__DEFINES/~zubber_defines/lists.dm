//DO NOT CHANGE THOSE LISTS UNLESS YOU KNOW WHAT YOURE DOING (will mess savefiles)

GLOBAL_LIST_INIT(breasts_size_translation, list("0" = "Flatchested",
												"1" = "A",
												"2" = "B",
												"3" = "C",
												"4" = "D",
												"5" = "E",
												"6" = "F",
												"7" = "G",
												"8" = "H",
												"9" = "I",
												"10" = "J",
												"11" = "K",
												"12" = "L",
												"13" = "M",
												"14" = "N",
												"15" = "O",
												"16" = "P",
												))

GLOBAL_LIST_INIT(balls_size_translation, list("0" = "Small",
												"1" = "Average",
												"2" = "Big",
												"3" = "Enormous"
												))

GLOBAL_LIST_INIT(marking_zone_to_bitflag, list(BODY_ZONE_HEAD = HEAD,
										BODY_ZONE_CHEST = CHEST,
										BODY_ZONE_L_LEG = LEG_LEFT,
										BODY_ZONE_R_LEG = LEG_RIGHT,
										BODY_ZONE_L_ARM = ARM_LEFT,
										BODY_ZONE_R_ARM = ARM_RIGHT,
										BODY_ZONE_PRECISE_L_HAND = HAND_LEFT,
										BODY_ZONE_PRECISE_R_HAND = HAND_RIGHT
										))

GLOBAL_LIST_INIT(marking_zones, list(BODY_ZONE_HEAD,BODY_ZONE_CHEST,BODY_ZONE_L_LEG,BODY_ZONE_R_LEG,BODY_ZONE_L_ARM,BODY_ZONE_R_ARM,BODY_ZONE_PRECISE_L_HAND,BODY_ZONE_PRECISE_R_HAND))

///Those are the values available from prefs
GLOBAL_LIST_INIT(preference_breast_sizes, list("Flatchested","A","B","C","D","E","F","G","H","I","J"))

GLOBAL_LIST_INIT(preference_balls_sizes, list("Small","Average","Big","Enormous"))

GLOBAL_LIST_INIT(robotic_styles_list, list("None" = "None",
										"Surplus" = 'icons/mob/augmentation/surplus_augments.dmi',
										"Cyborg" = 'icons/mob/augmentation/augments.dmi',
										"Engineering" = 'icons/mob/augmentation/augments_engineer.dmi',
										"Mining" = 'icons/mob/augmentation/augments_mining.dmi',
										"Security" = 'icons/mob/augmentation/augments_security.dmi',
										"Morpheus Cyberkinetics" = 'modular_zubbers/modules/customization/icons/augmentation/mcgipc.dmi',
										"Bishop Cyberkinetics" = 'modular_zubbers/modules/customization/icons/augmentation/bshipc.dmi',
										"Bishop Cyberkinetics 2.0" = 'modular_zubbers/modules/customization/icons/augmentation/bs2ipc.dmi',
										"Hephaestus Industries" = 'modular_zubbers/modules/customization/icons/augmentation/hsiipc.dmi',
										"Hephaestus Industries 2.0" = 'modular_zubbers/modules/customization/icons/augmentation/hi2ipc.dmi',
										"Shellguard Munitions Standard Series" = 'modular_zubbers/modules/customization/icons/augmentation/sgmipc.dmi',
										"Ward-Takahashi Manufacturing" = 'modular_zubbers/modules/customization/icons/augmentation/wtmipc.dmi',
										"Xion Manufacturing Group" = 'modular_zubbers/modules/customization/icons/augmentation/xmgipc.dmi',
										"Xion Manufacturing Group 2.0" = 'modular_zubbers/modules/customization/icons/augmentation/xm2ipc.dmi',
										"Zeng-Hu Pharmaceuticals" = 'modular_zubbers/modules/customization/icons/augmentation/zhpipc.dmi'
										))

GLOBAL_LIST_EMPTY(sprite_accessories)
GLOBAL_LIST_EMPTY(generic_accessories)

GLOBAL_LIST_EMPTY(body_markings)
GLOBAL_LIST_EMPTY_TYPED(body_markings_per_limb, /list)
GLOBAL_LIST_EMPTY(body_marking_sets)

GLOBAL_LIST_EMPTY(loadout_items)
GLOBAL_LIST_EMPTY(loadout_category_to_subcategory_to_items)

GLOBAL_LIST_EMPTY(augment_items)
GLOBAL_LIST_EMPTY(augment_categories_to_slots)
GLOBAL_LIST_EMPTY(augment_slot_to_items)


