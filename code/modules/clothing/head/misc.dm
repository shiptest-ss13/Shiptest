
/obj/item/clothing/head/centhat
	name = "\improper CentCom hat"
	icon_state = "centcom"
	desc = "It's good to be emperor."
	item_state = "that"
	flags_inv = 0
	armor = list("melee" = 30, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 80

/obj/item/clothing/head/centcom_cap
	name = "\improper CentCom commander cap"
	icon_state = "centcom_cap"
	desc = "Worn by the finest of CentCom commanders. Inside the lining of the cap, lies two faint initials."
	item_state = "that"
	flags_inv = 0
	armor = list("melee" = 30, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = (8 SECONDS)

/obj/item/clothing/head/that
	name = "top-hat"
	desc = "It's an amish looking hat."
	icon_state = "tophat"
	item_state = "that"
	dog_fashion = /datum/dog_fashion/head
	throwforce = 1

/obj/item/clothing/head/nursehat
	name = "nurse's hat"
	desc = "It allows quick identification of trained medical personnel."
	icon_state = "nursehat"

	dog_fashion = /datum/dog_fashion/head/nurse

	equip_sound = 'sound/items/equip/armor_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_HELMET
	equip_delay_other = EQUIP_DELAY_HELMET * 1.5
	strip_delay = EQUIP_DELAY_HELMET * 1.5

/obj/item/clothing/head/snowman
	name = "Snowman Head"
	desc = "A ball of white styrofoam. So festive."
	icon_state = "snowman_h"
	item_state = "snowman_h"
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/pirate
	name = "pirate hat"
	desc = "Yarr."
	icon = 'icons/obj/clothing/head/spacesuits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/spacesuits.dmi'
	icon_state = "pirate"
	item_state = "pirate"
	dog_fashion = /datum/dog_fashion/head/pirate

/obj/item/clothing/head/pirate/captain
	name = "pirate captain hat"
	icon_state = "hgpiratecap"
	item_state = "hgpiratecap"

/obj/item/clothing/head/bandana
	name = "pirate bandana"
	desc = "Yarr."
	icon = 'icons/obj/clothing/head/spacesuits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/spacesuits.dmi'
	icon_state = "bandana"
	item_state = "bandana"

/obj/item/clothing/head/bearpelt
	name = "bear pelt hat"
	desc = "Fuzzy."
	icon_state = "bearpelt"
	item_state = "bearpelt"

/obj/item/clothing/head/fedora
	name = "fedora"
	icon_state = "fedora"
	item_state = "fedora"
	desc = "A really cool hat if you're a mobster. A really lame hat if you're not."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/fedora

/obj/item/clothing/head/fedora/white
	name = "white fedora"
	icon_state = "fedora_white"
	item_state = "fedora_white"

/obj/item/clothing/head/fedora/beige
	name = "beige fedora"
	icon_state = "fedora_beige"
	item_state = "fedora_beige"

/obj/item/clothing/head/flatcap
	name = "flat cap"
	desc = "A working man's hat."
	icon_state = "flat_cap"
	item_state = "detective"

/obj/item/clothing/head/hunter
	name = "bounty hunting hat"
	desc = "Ain't nobody gonna cheat the hangman in my town."
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/cone
	desc = "This cone is trying to warn you of something!"
	name = "warning cone"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cone"
	item_state = "cone"
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("warned", "cautioned", "smashed")
	resistance_flags = NONE

/obj/item/clothing/head/santa
	name = "santa hat"
	desc = "On the first day of christmas my employer gave to me!"
	icon_state = "santahatnorm"
	item_state = "that"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head/santa

/obj/item/clothing/head/papersack
	name = "paper sack hat"
	desc = "A paper sack with crude holes cut out for eyes. Useful for hiding one's identity or ugliness."
	icon_state = "papersack"
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/head/papersack/smiley
	name = "paper sack hat"
	desc = "A paper sack with crude holes cut out for eyes and a sketchy smile drawn on the front. Not creepy at all."
	icon_state = "papersack_smile"
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/head/crown
	name = "crown"
	desc = "A crown fit for a king, a petty king maybe."
	icon_state = "crown"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/intern
	name = "\improper CentCom Head Intern beancap"
	desc = "A horrifying mix of beanie and softcap in CentCom green. You'd have to be pretty desperate for power over your peers to agree to wear this."
	icon_state = "intern_hat"
	item_state = "intern_hat"

/obj/item/clothing/head/maidheadband
	name = "maid headband"
	desc = "Just like from one of those chinese cartoons!"
	icon_state = "maid_headband"
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/cowboy
	name = "cowboy hat"
	desc = "A classic stetson hat, made from real imitation leather! Wearing it gives you a strong urge to yeehaw."
	icon_state = "cowboy"

	dog_fashion = /datum/dog_fashion/head/cowboy

/obj/item/clothing/head/cowboy/black
	name = "black cowboy hat"
	desc = "A dark leather hat, you get a bad feeling from it."
	icon_state = "cowboyblack"

/obj/item/clothing/head/franks_hat
	name = "Frank's hat"
	desc = "You feel ashamed about what you had to do to get this hat."
	icon_state = "cowboy"
	item_state = "cowboy"

/obj/item/clothing/head/sunhat
	name = "sun hat"
	desc = "A fashionable straw hat designed for providing shade to your head. An essential of tropical touristry and backbreaking labor alike!"
	icon_state = "sunhat"
	item_state = "sunhat"

/obj/item/clothing/head/motorcycle
	name = "motorcycle helmet"
	desc = "A helmet designed to protect your head in case of impacts in motor vehicle accidents. Also quite fashionable."
	icon = 'icons/obj/clothing/head/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/color.dmi'
	icon_state = "motohelm"
	item_state = "motohelm"
	unique_reskin = list("black motorcycle helmet" = "motohelm",
						"white motorcycle helmet" = "motohelmwhite",
						"blue motorcycle helmet" = "motohelmblue",
						"red motorcycle helmet" = "motohelmred",
						"purple motorcycle helmet" = "motohelmpurple",
						"pink motorcycle helmet" = "motohelmpink",
						"green motorcycle helmet" = "motohelmgreen",
						"brown motorcycle helmet" = "motohelmbrown"
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE
	armor = list("melee" = 15, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 20, "bio" = 10, "rad" = 20, "fire" = 100, "acid" = 50, "wound" = 20)
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEHAIR | HIDEFACIALHAIR | HIDEFACE | HIDEEYES | HIDEMASK | HIDEEARS
	equip_sound = 'sound/items/equip/armor_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_HELMET
	equip_delay_other = EQUIP_DELAY_HELMET * 1.5
	strip_delay = EQUIP_DELAY_HELMET * 1.5

/obj/item/clothing/head/motorcycle/black
	name = "black motorcycle helmet"
	icon_state = "motohelm"
	current_skin = "black motorcycle helmet"

/obj/item/clothing/head/motorcycle/white
	name = "white motorcycle helmet"
	icon_state = "motohelmwhite"
	current_skin = "white motorcycle helmet"

/obj/item/clothing/head/motorcycle/blue
	name = "blue motorcycle helmet"
	icon_state = "motohelmblue"
	current_skin = "blue motorcycle helmet"

/obj/item/clothing/head/motorcycle/red
	name = "red motorcycle helmet"
	icon_state = "motohelmred"
	current_skin = "red motorcycle helmet"

/obj/item/clothing/head/motorcycle/purple
	name = "purple motorcycle helmet"
	icon_state = "motohelmpurple"
	current_skin = "purple motorcycle helmet"

/obj/item/clothing/head/motorcycle/pink
	name = "pink motorcycle helmet"
	icon_state = "motohelmpink"
	current_skin = "pink motorcycle helmet"

/obj/item/clothing/head/motorcycle/green
	name = "green motorcycle helmet"
	icon_state = "motohelmgreen"
	current_skin = "green motorcycle helmet"

/obj/item/clothing/head/motorcycle/brown
	name = "brown motorcycle helmet"
	icon_state = "motohelmbrown"
	current_skin = "brown motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat
	name = "cat motorcycle helmet"
	desc = "A helmet designed to protect your head in case of impacts in motor vehicle accidents. This one has cute cat ears."
	icon_state = "motocat"
	item_state = "motocat"
	unique_reskin = list("black cat motorcycle helmet" = "motocat",
						"white cat motorcycle helmet" = "motocatwhite",
						"blue cat motorcycle helmet" = "motocatblue",
						"red cat motorcycle helmet" = "motocatred",
						"purple cat motorcycle helmet" = "motocatpurple",
						"pink cat motorcycle helmet" = "motocatpink",
						"green cat motorcycle helmet" = "motocatgreen",
						"brown cat motorcycle helmet" = "motocatbrown"
						)

/obj/item/clothing/head/motorcycle/cat/black
	name = "black cat motorcycle helmet"
	icon_state = "motocat"
	current_skin = "black cat motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat/white
	name = "white cat motorcycle helmet"
	icon_state = "motocatwhite"
	current_skin = "white cat motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat/blue
	name = "blue cat motorcycle helmet"
	icon_state = "motocatblue"
	current_skin = "blue cat motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat/red
	name = "red cat motorcycle helmet"
	icon_state = "motocatred"
	current_skin = "red cat motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat/purple
	name = "purple cat motorcycle helmet"
	icon_state = "motocatpurple"
	current_skin = "purple cat motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat/pink
	name = "pink cat motorcycle helmet"
	icon_state = "motocatpink"
	current_skin = "pink cat motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat/green
	name = "green cat motorcycle helmet"
	icon_state = "motocatgreen"
	current_skin = "green cat motorcycle helmet"

/obj/item/clothing/head/motorcycle/cat/brown
	name = "brown cat motorcycle helmet"
	icon_state = "motocatbrown"
	current_skin = "brown cat motorcycle helmet"
