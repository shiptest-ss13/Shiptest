#define OXY_CANDLE_RELEASE_TEMP (T20C + 20) // 40 celsius, it's hot. Will be even hotter with hotspot expose

/obj/item/oxygen_candle
	name = "oxygen candle"
	desc = "A steel tube with the words \"OXYGEN - PULL CORD TO IGNITE\" stamped on the side."
	icon = 'icons/obj/item/oxygen_candle.dmi'
	icon_state = "oxycandle"
	w_class = WEIGHT_CLASS_SMALL
	light_color = LIGHT_COLOR_LAVA // Very warm chemical burn
	///sets TRUE when candle is activated, prevents re-use
	var/pulled = FALSE
	///is the candle actively making oxygen? needed for Destroy()
	var/processing = FALSE
	///seconds of burn time
	var/fuel = 50
	grind_results = list(/datum/reagent/oxygen = 10, /datum/reagent/consumable/sodiumchloride = 10) //in case the on_grind doesn't proc for some reason

/obj/item/oxygen_candle/examine_more(mob/user)
	. = ..()
	. += "A small label reads: "+ span_warning("\"WARNING: NOT FOR LIGHTING USE. WILL IGNITE FLAMMABLE GASSES\"")

/obj/item/oxygen_candle/attack_self(mob/user)
	if(!pulled)
		playsound(src, 'sound/effects/fuse.ogg', 75, 1)
		user.visible_message(
			span_notice("[user] pulls a cord on \the [src], and it starts to burn."),
			span_notice("You pull the cord on \the [src], and it starts to burn.")
			)
		icon_state = "oxycandle_burning"
		pulled = TRUE
		processing = TRUE
		START_PROCESSING(SSobj, src)
		set_light(2)

/obj/item/oxygen_candle/process(seconds_per_tick)
	var/turf/pos = get_turf(src)
	if(!pos)
		return
	pos.hotspot_expose(500, 100 * seconds_per_tick)
	pos.atmos_spawn_air("o2=[seconds_per_tick * 10];TEMP=[OXY_CANDLE_RELEASE_TEMP]")
	fuel = max(fuel -= seconds_per_tick, 0)
	if(fuel <= 0)
		set_light(0)
		STOP_PROCESSING(SSobj, src)
		processing = FALSE
		name = "burnt oxygen candle"
		icon_state = "oxycandle_burnt"
		desc += span_notice("\nThis tube has exhausted its chemicals.")

/obj/item/oxygen_candle/burnt
	name = "burnt oxygen candle"
	icon_state = "oxycandle_burnt"
	desc = "A steel tube with the words \"OXYGEN - PULL CORD TO IGNITE\" stamped on the side." + span_notice("\nThis tube has exhausted its chemicals.")
	pulled = TRUE
	fuel = 0

/obj/item/oxygen_candle/Destroy()
	if(processing)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/oxygen_candle/on_grind()
	grind_results = list(/datum/reagent/oxygen/ = (fuel / 5), /datum/reagent/consumable/sodiumchloride = (10 / max(fuel, 1)))

#undef OXY_CANDLE_RELEASE_TEMP
