/obj/item/modular_computer/internal  //For use in internal devices, such as an integrated NTOS device inside a gun, not to be confused with integrated cyborg tablet
	name = "integrated mobile computer"
	icon = 'icons/obj/modular_tablet.dmi'
	icon_state = "tablet-red"
	icon_state_unpowered = "tablet"
	icon_state_powered = "tablet"
	icon_state_menu = "menu"
	hardware_flag = PROGRAM_TABLET
	max_hardware_size = 1
	enabled = 1
	screen_on = 1
	//It is critical that objects using this computer define the 'physical' var to ittself, otherwise the player won't be able to see the NTOS screen.

/obj/item/modular_computer/internal/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/recharger/cyborg)
	install_component(new /obj/item/computer_hardware/hard_drive/small)
	install_component(new /obj/item/computer_hardware/network_card)
