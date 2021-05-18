/* Toys!
 * Contains
 *		Mahjong Tiles
 */

/*
|| A Deck of Mahjong tiles for playing exactly one game of chance ||
*/

//Abstract to hold generic values for mahjong-related items
/obj/item/toy/mahjong
	name = "abstract mahjong"
	desc = "please do not spawn me"
	max_integrity = 50
	var/parentdeck = null
	var/card_hitsound = "whitesands/sound/items/mahjongclack.ogg"
	var/card_force = 0
	var/card_throwforce = 5
	var/list/card_attack_verb = list("clacked")

/obj/item/toy/mahjong/proc/apply_card_vars(obj/item/toy/mahjong/newobj, obj/item/toy/mahjong/sourceobj) // Applies variables for supporting multiple types of card deck
	if(!istype(sourceobj))
		return

/obj/item/toy/mahjong/wall
	name = "mahjong wall"
	desc = "A set of self-shuffling mahjong tiles."
	icon = 'whitesands/icons/obj/toy.dmi'
	icon_state = "mahjong_wall"
	w_class = WEIGHT_CLASS_NORMAL
	var/cooldown = 0
	var/obj/machinery/computer/holodeck/holo = null // Holodeck mahjong should not be infinite
	var/list/tiles = list()

/obj/item/toy/mahjong/wall/Initialize()
	. = ..()
	populate_wall()

///Generates all the tiles within the wall.
/obj/item/toy/mahjong/wall/proc/populate_wall()
	for(var/suit in list("pin", "man", "sou"))
		tiles += "red 5-[suit]"
		for(var/i in 1 to 9)
			for(var/c = 0;c<3;c++)
				tiles += "[i]-[suit]"
			if(i != 5)
				tiles += "[i]-[suit]"
	for(var/honor in list("ton","nan","sha","pei","haku","hatsu","chun"))
		for(var/c = 0;c<4;c++)
			tiles += honor

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/toy/mahjong/wall/attack_hand(mob/living/user)
	draw_card(user)

/obj/item/toy/mahjong/wall/proc/draw_card(mob/living/user)
	var/mob/living/L = user
	if(!(L.mobility_flags & MOBILITY_PICKUP))
		return
	var/choice = null
	if(tiles.len == 0)
		to_chat(user, "<span class='warning'>There are no more tiles to draw!</span>")
		return
	var/obj/item/toy/mahjong/singletile/H = new/obj/item/toy/mahjong/singletile(user.loc)
	if(holo)
		holo.spawned += H // track them leaving the holodeck
	choice = tiles[1]
	H.cardname = choice
	H.parentdeck = src
	var/O = src
	H.apply_card_vars(H,O)
	src.tiles.Cut(1,2)
	H.pickup(user)
	user.put_in_hands(H)
	user.visible_message("<span class='notice'>[user] draws a tile from the wall.</span>", "<span class='notice'>You draw a tile from the wall.</span>")
	update_icon()
	return H

/obj/item/toy/mahjong/wall/attack_self(mob/user)
	if(cooldown < world.time - 50)
		tiles = shuffle(tiles)
		playsound(src, 'whitesands/sound/items/mahjongshuffle.ogg', 50, TRUE)
		user.visible_message("<span class='notice'>[user] shuffles the wall.</span>", "<span class='notice'>You shuffle the wall.</span>")
		cooldown = world.time

/obj/item/toy/mahjong/wall/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/mahjong/singletile))
		var/obj/item/toy/mahjong/singletile/SC = I
		if(SC.parentdeck == src)
			if(!user.temporarilyRemoveItemFromInventory(SC))
				to_chat(user, "<span class='warning'>The tile is stuck to your hand, you can't add them to the deck!</span>")
				return
			tiles += SC.cardname
			user.visible_message("<span class='notice'>[user] adds a tile to the end of the wall.</span>","<span class='notice'>You add the tile to the end of the wall.</span>")
			qdel(SC)
		else
			to_chat(user, "<span class='warning'>You can't mix tiles from other walls!</span>")
		update_icon()
	else if(istype(I, /obj/item/toy/mahjong/tilegroup))
		var/obj/item/toy/mahjong/tilegroup/CH = I
		if(CH.parentdeck == src)
			if(!user.temporarilyRemoveItemFromInventory(CH))
				to_chat(user, "<span class='warning'>The tiles are stuck to your hand, you can't add it to the deck!</span>")
				return
			tiles += CH.currentgroup
			user.visible_message("<span class='notice'>[user] puts [user.p_their()] group of tiles in the wall.</span>", "<span class='notice'>You put the group of tiles in the wall.</span>")
			qdel(CH)
		else
			to_chat(user, "<span class='warning'>You can't mix tiles from other walls!</span>")
		update_icon()
	else
		return ..()

/obj/item/toy/mahjong/wall/MouseDrop(atom/over_object)
	. = ..()
	var/mob/living/M = usr
	if(!istype(M) || !(M.mobility_flags & MOBILITY_PICKUP))
		return
	if(Adjacent(usr))
		if(over_object == M && loc != M)
			M.put_in_hands(src)
			to_chat(usr, "<span class='notice'>You pick up the wall.</span>")

		else if(istype(over_object, /obj/screen/inventory/hand))
			var/obj/screen/inventory/hand/H = over_object
			if(M.putItemFromInventoryInHandIfPossible(src, H.held_index))
				to_chat(usr, "<span class='notice'>You pick up the wall.</span>")

	else
		to_chat(usr, "<span class='warning'>You can't reach it from here!</span>")



/obj/item/toy/mahjong/tilegroup
	name = "tile group"
	desc = "A number of mahjong tiles."
	icon = 'whitesands/icons/obj/toy.dmi'
	icon_state = "none"
	w_class = WEIGHT_CLASS_TINY
	var/list/currentgroup = list()
	var/choice = null

/obj/item/toy/mahjong/tilegroup/attack_self(mob/user)
	user.set_machine(src)
	interact(user)


/obj/item/toy/mahjong/tilegroup/ui_interact(mob/user)
	. = ..()
	var/dat = "You have:<BR>"
	for(var/t in currentgroup)
		dat += "<A href='?src=[REF(src)];pick=[t]'>A [t].</A><BR>"
	dat += "Which tile will you remove?"
	var/datum/browser/popup = new(user, "tilegroup", "Group of tiles", 400, 240)
	popup.set_content(dat)
	popup.open()

/obj/item/toy/mahjong/tilegroup/Topic(href, href_list)
	if(..())
		return
	if(usr.stat || !ishuman(usr))
		return
	var/mob/living/carbon/human/cardUser = usr
	if(!(cardUser.mobility_flags & MOBILITY_USE))
		return
	var/O = src
	if(href_list["pick"])
		if (cardUser.is_holding(src))
			var/choice = href_list["pick"]
			var/obj/item/toy/mahjong/singletile/C = new/obj/item/toy/mahjong/singletile(cardUser.loc)
			src.currentgroup -= choice
			C.parentdeck = src.parentdeck
			C.cardname = choice
			C.apply_card_vars(C,O)
			C.pickup(cardUser)
			cardUser.put_in_hands(C)
			cardUser.visible_message("<span class='notice'>[cardUser] draws a tile from [cardUser.p_their()] group.</span>", "<span class='notice'>You take the [C.cardname] from your group.</span>")

			interact(cardUser)
			update_sprite()
			if(src.currentgroup.len == 1)
				var/obj/item/toy/mahjong/singletile/N = new/obj/item/toy/mahjong/singletile(src.loc)
				N.parentdeck = src.parentdeck
				N.cardname = src.currentgroup[1]
				N.apply_card_vars(N,O)
				qdel(src)
				N.pickup(cardUser)
				cardUser.put_in_hands(N)
				to_chat(cardUser, "<span class='notice'>You also take [currentgroup[1]] and hold it.</span>")
				cardUser << browse(null, "window=tilegroup")
		return

/obj/item/toy/mahjong/tilegroup/attackby(obj/item/toy/mahjong/singletile/C, mob/living/user, params)
	if(istype(C))
		if(C.parentdeck == src.parentdeck)
			src.currentgroup += C.cardname
			playsound(src, src.card_hitsound, 50, TRUE)
			user.visible_message("<span class='notice'>[user] adds a tile to [user.p_their()] group.</span>", "<span class='notice'>You add the [C.cardname] to your group.</span>")
			qdel(C)
			interact(user)
			update_sprite(src)
		else
			to_chat(user, "<span class='warning'>You can't mix tiles from other walls!</span>")
	else
		return ..()

/obj/item/toy/mahjong/tilegroup/apply_card_vars(obj/item/toy/mahjong/newobj,obj/item/toy/mahjong/sourceobj)
	..()
	update_sprite()
	newobj.card_hitsound = sourceobj.card_hitsound
	newobj.card_force = sourceobj.card_force
	newobj.card_throwforce = sourceobj.card_throwforce
	newobj.card_attack_verb = sourceobj.card_attack_verb
	newobj.resistance_flags = sourceobj.resistance_flags

/**
  * This proc updates the sprite for when you create a hand of tiles
  */
/obj/item/toy/mahjong/tilegroup/proc/update_sprite()
	cut_overlays()
	var/overlay_mahjong = currentgroup.len
	//establish k, which is the remainder of i and 6, pix_x, which is k * 5 and one to the right, and pix_y, which is 7 down for every 6 in i
	//then add an overlay for the tile at pix_x and pix_y
	for(var/i = 1; i <= overlay_mahjong; i++)
		var/x = i
		var/k = (i-1)%6
		var/pix_x = 1+(k*5)
		var/pix_y = 0
		while(x > 6)
			x -= 6
			pix_y -= 7
		var/tile_overlay = image(icon=src.icon,icon_state="mini [currentgroup[i]]",pixel_x=pix_x,pixel_y=pix_y)
		add_overlay(tile_overlay)

/obj/item/toy/mahjong/singletile
	name = "mahjong tile"
	desc = "A tile used to play mahjong. Made of hard plastic."
	icon = 'whitesands/icons/obj/toy.dmi'
	icon_state = "haku"
	w_class = WEIGHT_CLASS_TINY
	var/cardname = "haku"
	pixel_x = -5

/obj/item/toy/mahjong/singletile/Initialize()
	. = ..()
	icon_state = "[cardname]"

/obj/item/toy/mahjong/singletile/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/cardUser = user
		if(cardUser.is_holding(src))
			cardUser.visible_message("<span class='notice'>[cardUser] checks [cardUser.p_their()] card.</span>", "<span class='notice'>The card reads: [cardname].</span>")
		else
			. += "<span class='warning'>You need to have the card in your hand to check it!</span>"

/obj/item/toy/mahjong/singletile/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/mahjong/singletile/))
		var/obj/item/toy/mahjong/singletile/C = I
		if(C.parentdeck == src.parentdeck)
			playsound(src, src.card_hitsound, 50, TRUE)
			var/obj/item/toy/mahjong/tilegroup/H = new/obj/item/toy/mahjong/tilegroup(user.loc)
			H.currentgroup += C.cardname
			H.currentgroup += src.cardname
			H.parentdeck = C.parentdeck
			H.apply_card_vars(H,C)
			to_chat(user, "<span class='notice'>You combine the [C.cardname] and the [src.cardname] into a hand.</span>")
			qdel(C)
			qdel(src)
			H.pickup(user)
			user.put_in_active_hand(H)
		else
			to_chat(user, "<span class='warning'>You can't mix tiles from other walls!</span>")

	if(istype(I, /obj/item/toy/mahjong/tilegroup/))
		var/obj/item/toy/mahjong/tilegroup/H = I
		if(H.parentdeck == parentdeck)
			playsound(src, src.card_hitsound, 50, TRUE)
			H.currentgroup += cardname
			user.visible_message("<span class='notice'>[user] adds a tile to [user.p_their()] group.</span>", "<span class='notice'>You add the [cardname] to your group.</span>")
			qdel(src)
			H.interact(user)
			H.update_sprite()
		else
			to_chat(user, "<span class='warning'>You can't mix tiles from other walls!</span>")
	else
		return ..()

/obj/item/toy/mahjong/singletile/apply_card_vars(obj/item/toy/mahjong/singletile/newobj,obj/item/toy/mahjong/sourceobj)
	..()
	newobj.icon_state = newobj.cardname
	newobj.card_hitsound = sourceobj.card_hitsound
	newobj.hitsound = newobj.card_hitsound
	newobj.card_force = sourceobj.card_force
	newobj.force = newobj.card_force
	newobj.card_throwforce = sourceobj.card_throwforce
	newobj.throwforce = newobj.card_throwforce
	newobj.card_attack_verb = sourceobj.card_attack_verb
	newobj.attack_verb = newobj.card_attack_verb
