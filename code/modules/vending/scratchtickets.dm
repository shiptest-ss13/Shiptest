/obj/machinery/vending/lottery
	name = "\improper Kiyatirawkitchi Lottery"
	desc = "A vending machine selling lottery tickets. A printed message on the side reads \"Remember: play responsibly, and have fun!\""
	products = list(
		/obj/item/scratch_ticket/small = 100,
		/obj/item/scratch_ticket/med = 100,
		/obj/item/scratch_ticket/large = 100,
		/obj/item/scratch_ticket/xl = 100)
	refill_canister = /obj/item/vending_refill/lottery
	product_ads = "You can't win if you don't play!;Over three hundred winners last week!;Feeling lucky?;Fun for everyone!"
	default_price = 50
	light_mask = "generic-light-mask"

/obj/item/vending_refill/lottery
	machine_name = "Lottery"
	icon_state = "refill_sec"
