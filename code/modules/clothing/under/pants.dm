/obj/item/clothing/under/pants
	gender = PLURAL
	body_parts_covered = GROIN|LEGS
	custom_price = 60
	icon = 'icons/obj/clothing/under/shorts_pants.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/shorts_pants.dmi'
	greyscale_colors = list(list(14, 10), list(16, 10), list(16, 9))
	greyscale_icon_state = "pants"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/under/pants/blackjeans
	name = "black jeans"
	desc = "Only for those who can pull it off."
	icon_state = "jeansblack"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/pants/cargo
	name = "cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargogrey"
	unique_reskin = list("grey cargo pants" = "cargogrey",
						"black cargo pants" = "cargoblack",
						"khaki cargo pants" = "cargokhaki",
						"jean cargo pants" = "cargojeans",
						"olive cargo pants" = "cargoolive",
						"brown cargo pants" = "cargobrown",
						"navy cargo pants" = "cargonavy",
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/pants/cargo/grey
	name = "grey cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargogrey"
	current_skin = "grey cargo pants"

/obj/item/clothing/under/pants/cargo/black
	name = "black cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargoblack"
	current_skin = "black cargo pants"

/obj/item/clothing/under/pants/cargo/khaki
	name = "khaki cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargokhaki"
	current_skin = "khaki cargo pants"

/obj/item/clothing/under/pants/cargo/navy
	name = "navy cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargonavy"
	current_skin = "navy cargo pants"

/obj/item/clothing/under/pants/cargo/jeans
	name = "jean cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargojeans"
	current_skin = "jean cargo pants"

/obj/item/clothing/under/pants/cargo/brown
	name = "brown cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargobrown"
	current_skin = "brown cargo pants"

/obj/item/clothing/under/pants/cargo/olive
	name = "olive cargo pants"
	desc = "A pocket for every need."
	icon_state = "cargoolive"
	current_skin = "olive cargo pants"

/obj/item/clothing/under/pants/white
	name = "white pants"
	desc = "Plain white pants. Boring."
	icon_state = "whitepants"

/obj/item/clothing/under/pants/red
	name = "red pants"
	desc = "Bright red pants. Overflowing with personality."
	icon_state = "redpants"

/obj/item/clothing/under/pants/black
	name = "black pants"
	desc = "These pants are dark, like your soul."
	icon_state = "blackpants"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/pants/tan
	name = "tan pants"
	desc = "Some tan pants. You look like a white collar worker with these on."
	icon_state = "khaki"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/pants/track
	name = "track pants"
	desc = "A pair of track pants, for the athletic."
	icon_state = "trackpants"

/obj/item/clothing/under/pants/jeans
	name = "jeans"
	desc = "A nondescript pair of tough blue jeans."
	icon_state = "jeans"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/pants/khaki
	name = "khaki pants"
	desc = "A pair of dust beige khaki pants."
	icon_state = "khaki"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/pants/camo
	name = "camo pants"
	desc = "A pair of woodland camouflage pants. Probably not the best choice for deep space."
	icon_state = "camopants"

/obj/item/clothing/under/pants/pajamared
	name = "red pajama pants"
	desc = "A comfy pair of pajamas. Probably not the best for work attire."
	icon_state = "pajamared"

/obj/item/clothing/under/pants/pajamablue
	name = "blue pajama pants"
	desc = "A comfy pair of pajamas. Probably not the best for work attire."
	icon_state = "pajamablue"

/obj/item/clothing/under/pants/pajamagreen
	name = "green pajama pants"
	desc = "A comfy pair of pajamas. Probably not the best for work attire."
	icon_state = "pajamagreen"

//baggy pants
/obj/item/clothing/under/pants/baggy
	name = "baggy pants"
	desc = "An oversized pair of pants. Perfect for hiding a weapon."
	icon_state = "baggygrey"
	unique_reskin = list("standard baggy pants" = "baggygrey",
						"covert baggy pants" = "baggyblack",
						"industrial baggy pants" = "baggybeige",
						"jean baggy pants" = "baggyjean",
						"woodland baggy pants" = "baggygreen",
						"surplus baggy pants" = "baggycamo",
						"surplus olive drab baggy pants" = "baggyfrontie",
						"surplus gorlex baggy pants" = "baggyramzi",
						"surplus green baggy pants" = "baggypgfmc",
						"surplus navy pants" = "baggypgfn",
						"surplus blue baggy pants" = "baggyclip"
						)
	supports_variations = DIGITIGRADE_VARIATION
	alternate_worn_layer = SHOES_LAYER

/obj/item/clothing/under/pants/baggy/grey
	name = "standard baggy pants"
	desc = "An oversized pair of pants. Perfect for hiding a weapon."
	icon_state = "baggygrey"
	current_skin = "standard baggy pants"

/obj/item/clothing/under/pants/baggy/black
	name = "covert baggy pants"
	desc = "An oversized pair of pants. Perfect for sneaking around."
	icon_state = "baggyblack"
	current_skin = "covert baggy pants"

/obj/item/clothing/under/pants/baggy/beige
	name = "industrial baggy pants"
	desc = "An oversized pair of pants. Makes you feel unionized."
	icon_state = "baggybeige"
	current_skin = "industrial baggy pants"

/obj/item/clothing/under/pants/baggy/jean
	name = "baggy jeans"
	desc = "An oversized pair of jeans. Timelessly fashionable."
	icon_state = "baggyjean"
	current_skin = "jean baggy pants"

/obj/item/clothing/under/pants/baggy/grey
	name = "woodland baggy pants"
	desc = "An oversized pair of pants. Keep the ticks off."
	icon_state = "baggygreen"
	current_skin = "woodland baggy pants"

	/obj/item/clothing/under/pants/baggy/camo
	name = "surplus baggy pants"
	desc = "An oversized pair of camo pants. Nobody died in these."
	icon_state = "baggycamo"
	current_skin = "surplus baggy pants"

	/obj/item/clothing/under/pants/baggy/frontie
	name = "surplus olive drab baggy pants"
	desc = "An oversized pair of pants. Wonder why these were on sale?"
	icon_state = "baggyfrontie"
	current_skin = "olive drab baggy pants"

	/obj/item/clothing/under/pants/baggy/ramzi
	name = "surplus gorlex baggy pants"
	desc = "An oversized pair of pants. Certified pre-worn by a miner on Old Gorlex."
	icon_state = "baggyramzi"
	current_skin = "gorlex baggy pants"

/obj/item/clothing/under/pants/baggy/pgfmc
	name = "surpluse marine baggy pants"
	desc = "An oversized pair of old PGFMC pants. Patriotic."
	icon_state = "baggypgfmc"
	current_skin = "surplus marine baggy pants"

/obj/item/clothing/under/pants/baggy/pgfn
	name = "surplus navy baggy pants"
	desc = "An oversized pair of old PGNF pants. Patriotic."
	icon_state = "baggygrey"
	current_skin = "standard baggy pants"

	/obj/item/clothing/under/pants/baggy/clip
	name = "surplus blue baggy pants"
	desc = "An oversized pair of pants in Luna-Town blue."
	icon_state = "baggyclip"
	current_skin = "surplus blue baggy pants"

