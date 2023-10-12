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
