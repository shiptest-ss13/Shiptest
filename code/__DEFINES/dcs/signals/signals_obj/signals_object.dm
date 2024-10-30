// Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// /obj signals

///from base of obj/deconstruct(): (disassembled)
#define COMSIG_OBJ_DECONSTRUCT "obj_deconstruct"
///from base of code/game/machinery
#define COMSIG_OBJ_DEFAULT_UNFASTEN_WRENCH "obj_default_unfasten_wrench"
///from base of /turf/proc/levelupdate(). (intact) true to hide and false to unhide
#define COMSIG_OBJ_HIDE "obj_hide"
/// from base of [/atom/proc/obj_destruction]: (damage_flag)
#define COMSIG_OBJ_DESTRUCTION "obj_destruction"

/// Sent from /obj/item/update_weight_class(). (old_w_class, new_w_class)
#define COMSIG_ITEM_WEIGHT_CLASS_CHANGED "item_weight_class_changed"
/// Sent from /obj/item/update_weight_class(), to its loc. (obj/item/changed_item, old_w_class, new_w_class)
#define COMSIG_ATOM_CONTENTS_WEIGHT_CLASS_CHANGED "atom_contents_weight_class_changed"
