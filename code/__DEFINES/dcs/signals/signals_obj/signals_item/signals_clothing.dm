// Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// /obj/item/clothing signals

//from base of obj/item/clothing/shoes/proc/step_action(): ()
#define COMSIG_SHOES_STEP_ACTION "shoes_step_action"
//from base of /obj/item/clothing/suit/space/proc/toggle_spacesuit(): (obj/item/clothing/suit/space/suit)
#define COMSIG_SUIT_SPACE_TOGGLE "suit_space_toggle"
