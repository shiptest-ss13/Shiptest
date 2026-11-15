// Where AI-controlled basic mobs aim their shots, as weights by body zone. Shots hitting a carbon can still stray to a random part with range

///The default bodypart body_weights where an AI aims at
#define AI_AIM_ZONES_DEFAULT list(BODY_ZONE_HEAD = 18, BODY_ZONE_CHEST = 70, BODY_ZONE_L_ARM = 3, BODY_ZONE_R_ARM = 3, BODY_ZONE_L_LEG = 3, BODY_ZONE_R_LEG = 3)
///A marksman going for the head, once it's settled its aim on someone
#define AI_AIM_ZONES_MARKSMAN list(BODY_ZONE_HEAD = 70, BODY_ZONE_CHEST = 22, BODY_ZONE_L_ARM = 2, BODY_ZONE_R_ARM = 2, BODY_ZONE_L_LEG = 2, BODY_ZONE_R_LEG = 2)
///How quickly a marksman's shots stray from where they're aimed with range, a quarter of anyone else's, so they still land where aimed about 2/3 of the time at 8 tiles
#define AI_MARKSMAN_AIM_ACCURACY_MOD 0.25
