/obj/machinery/vending/lottery
	name = "\improper Kiyatirawkitchi Lottery"
	desc = "A vending machine selling lottery tickets. A printed message on the side reads \"Remember: Play Responsibly, And Have Fun!\" "
	icon_state = "lotto"
	products = list(
		/obj/item/scratch_ticket/small = 1000,
		/obj/item/scratch_ticket/large = 1000)
	refill_canister = /obj/item/vending_refill/lottery
	speak_in = /datum/language/vox_pidgin
	product_ads = "You can't win if you don't play!;Over three hundred winners last week!;Feeling lucky?;Play! Win! Test your luck today!"
	default_price = 50
	restock_hourly = TRUE
	light_mask = "lotto-light-mask"

/obj/machinery/vending/lottery/examine(mob/examiner)
	. = ..()
	if(examiner.has_language(/datum/language/vox_pidgin, UNDERSTOOD_LANGUAGE))
		. += span_notice("Printed on the machine in Vox-Pidgin is a lengthy list of terms and conditions. Of note is the sentence \"DO NOT TAMPER WITH THE MACHINE! WE WILL KNOW!\" printed in large block lettering.")
	else
		. += span_notice("Most of the wording on the machine is unrecognizable to you...")

/obj/item/vending_refill/lottery
	machine_name = "Lottery"
	icon_state = "refill_games"
