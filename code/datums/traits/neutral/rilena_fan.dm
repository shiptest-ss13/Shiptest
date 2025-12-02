/datum/quirk/fan_rilena
	name = "RILENA Super Fan"
	desc = "You are a major fan of the popular webseries RILENA: LMR. You get a mood boost from plushies of your favorite characters, and wearing your Xader pin."
	value = 0
	mob_traits = list(TRAIT_FAN_RILENA)
	gain_text = span_notice("You are a huge fan of a certain combination webcomic and bullet hell game.")
	lose_text = span_danger("Suddenly, bullet hell games and webcomics don't seem all that interesting anymore...")
	detectable = FALSE

/datum/quirk/fan_rilena/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/accessory/rilena_pin/B = new(get_turf(H))
	var/list/slots = list (
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS,
	)
	H.equip_in_one_of_slots(B, slots , qdel_on_fail = TRUE)
	var/datum/atom_hud/fan = GLOB.huds[DATA_HUD_FAN]
	fan.add_hud_to(H)
