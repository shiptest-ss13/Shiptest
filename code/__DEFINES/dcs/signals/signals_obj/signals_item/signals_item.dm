// Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// /obj/item signals
///from base of obj/item/equipped(): (/mob/equipper, slot)
#define COMSIG_ITEM_EQUIPPED "item_equip"
///from base of obj/item/dropped(): (mob/user)
#define COMSIG_ITEM_DROPPED "item_drop"
///from base of obj/item/pickup(): (/mob/taker)
#define COMSIG_ITEM_PICKUP "item_pickup"

///from base of obj/item/on_grind(): ())
#define COMSIG_ITEM_ON_GRIND "on_grind"
///from base of obj/item/on_juice(): ()
#define COMSIG_ITEM_ON_JUICE "on_juice"
///from /obj/machinery/hydroponics/attackby(obj/item/O, mob/user, params) when an object is used as compost: (mob/user)
#define COMSIG_ITEM_ON_COMPOSTED "on_composted"
///Called when an item is dried by a drying rack:
#define COMSIG_ITEM_DRIED "item_dried"

///from base of mob/living/carbon/attacked_by(): (mob/living/carbon/target, mob/living/user, hit_zone)
#define COMSIG_ITEM_ATTACK_ZONE "item_attack_zone"
///from base of obj/item/hit_reaction(): (list/args)
#define COMSIG_ITEM_HIT_REACT "item_hit_react" //from base of obj/item/hit_reaction(): (list/args)
	#define COMPONENT_HIT_REACTION_BLOCK (1<<0)

#define COMSIG_ITEM_ATTACK "item_attack" //from base of obj/item/attack(): (/mob/living/target, /mob/living/user)
#define COMSIG_ITEM_ATTACK_SELF "item_attack_self" //from base of obj/item/attack_self(): (/mob)
	#define COMPONENT_NO_INTERACT 1
#define COMSIG_ITEM_ATTACK_OBJ "item_attack_obj" //from base of obj/item/attack_obj(): (/obj, /mob)
	#define COMPONENT_NO_ATTACK_OBJ 1
#define COMSIG_ITEM_PRE_ATTACK "item_pre_attack" //from base of obj/item/pre_attack(): (atom/target, mob/user, params)
	#define COMPONENT_NO_ATTACK 1
//from base of obj/item/attack_self_secondary(): (/mob)
#define COMSIG_ITEM_ATTACK_SELF_SECONDARY "item_attack_self_secondary"
#define COMSIG_ITEM_AFTERATTACK "item_afterattack" //from base of obj/item/afterattack(): (atom/target, mob/user, params)
#define COMSIG_ITEM_ATTACK_QDELETED "item_attack_qdeleted" //from base of obj/item/attack_qdeleted(): (atom/target, mob/user, params)
#define COMSIG_ITEM_IMBUE_SOUL "item_imbue_soul" //return a truthy value to prevent ensouling, checked in /obj/effect/proc_holder/spell/targeted/lichdom/cast(): (mob/user)
#define COMSIG_ITEM_MARK_RETRIEVAL "item_mark_retrieval" //called before marking an object for retrieval, checked in /obj/effect/proc_holder/spell/targeted/summonitem/cast() : (mob/user)
	#define COMPONENT_BLOCK_MARK_RETRIEVAL 1
#define COMSIG_ITEM_WEARERCROSSED "wearer_crossed" //called on item when crossed by something (): (/atom/movable, mob/living/crossed)

#define COMSIG_ITEM_UNIQUE_ACTION "item_unique_action" //from base of obj/item/unique_action(): (mob/living/user)

///from base of item/sharpener/attackby(): (amount, max)
#define COMSIG_ITEM_SHARPEN_ACT "sharpen_act"
	#define COMPONENT_BLOCK_SHARPEN_APPLIED 1
	#define COMPONENT_BLOCK_SHARPEN_BLOCKED 2
	#define COMPONENT_BLOCK_SHARPEN_ALREADY 4
	#define COMPONENT_BLOCK_SHARPEN_MAXED 8

#define COMSIG_ITEM_USE_CELL "item_use_cell"

#define COMSIG_TOOL_IN_USE "tool_in_use" ///from base of [/obj/item/proc/tool_check_callback]: (mob/living/user)
#define COMSIG_TOOL_START_USE "tool_start_use" ///from base of [/obj/item/proc/tool_start_check]: (mob/living/user)
#define COMSIG_ITEM_DISABLE_EMBED "item_disable_embed" ///from [/obj/item/proc/disableEmbedding]:
#define COMSIG_MINE_TRIGGERED "minegoboom" ///from [/obj/item/mine/proc/trigger_mine]:
///from [/obj/structure/closet/supplypod/proc/endlaunch]:
#define COMSIG_SUPPLYPOD_LANDED "supplypodgoboom"

// Item mouse siganls
#define COMSIG_ITEM_MOUSE_EXIT "item_mouse_exit"				//from base of obj/item/MouseExited(): (location, control, params)
#define COMSIG_ITEM_MOUSE_ENTER "item_mouse_enter"				//from base of obj/item/MouseEntered(): (location, control, params)

///Called when an item is being offered, from [/obj/item/proc/on_offered(mob/living/carbon/offerer)]
#define COMSIG_ITEM_OFFERING "item_offering"
	///Interrupts the offer proc
	#define COMPONENT_OFFER_INTERRUPT (1<<0)
///Called when an someone tries accepting an offered item, from [/obj/item/proc/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)]
#define COMSIG_ITEM_OFFER_TAKEN "item_offer_taken"
	///Interrupts the offer acceptance
	#define COMPONENT_OFFER_TAKE_INTERRUPT (1<<0)
/// sent from obj/effect/attackby(): (/obj/effect/hit_effect, /mob/living/attacker, params)
#define COMSIG_ITEM_ATTACK_EFFECT "item_effect_attacked"

// /obj/item signals for economy
#define COMSIG_ITEM_SOLD "item_sold" //called when an item is sold by the exports subsystem
#define COMSIG_STRUCTURE_UNWRAPPED "structure_unwrapped" //called when a wrapped up structure is opened by hand
#define COMSIG_ITEM_UNWRAPPED "item_unwrapped" //called when a wrapped up item is opened by hand
	#define COMSIG_ITEM_SPLIT_VALUE 1
#define COMSIG_ITEM_SPLIT_PROFIT "item_split_profits" //Called when getting the item's exact ratio for cargo's profit.
#define COMSIG_ITEM_SPLIT_PROFIT_DRY "item_split_profits_dry" //Called when getting the item's exact ratio for cargo's profit, without selling the item.

// /datum/component/two_handed signals
#define COMSIG_TWOHANDED_WIELD "twohanded_wield" //from base of datum/component/two_handed/proc/wield(mob/living/carbon/user): (/mob/user)
	#define COMPONENT_TWOHANDED_BLOCK_WIELD 1
#define COMSIG_TWOHANDED_UNWIELD "twohanded_unwield" //from base of datum/component/two_handed/proc/unwield(mob/living/carbon/user): (/mob/user)
