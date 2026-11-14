/obj/structure/closet/faction/medicalsrm
	name = "hunter doctor closet"
	desc = "Everything the Hunter Doctor needs to heal the hurting masses."
	icon_state = "med"
	req_access = list(ACCESS_MEDICAL)

/obj/structure/closet/faction/shadow
	name = "shadow's locker"
	desc = "The closet of equipment and attire for the aspiring shadow."
	icon_state = "cabinet"
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'

/obj/structure/closet/faction/flamebearer
	name = "flamebearer's locker"
	desc = "The closet of equipment an ascetic Flamebearer would require."
	icon_state = "cabinet"
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'

/obj/structure/closet/faction/hunter
	name = "hunter's locker"
	desc = "Everything a hunter will need, held in one secure closet."
	icon_state = "cabinet"
	req_access = list(ACCESS_SECURITY)
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'

/obj/structure/closet/faction/machinist
	name = "machinist's Locker"
	desc = "The personal closet with tools of a Machinist."
	req_access = list(ACCESS_ENGINE)
	icon_state = "eng_secure"

/obj/structure/closet/faction/collignes
	name = "\proper hunter colligne's locker"
	desc = "The posessions of the Hunter Colligne aboard the vessel."
	req_access = list(ACCESS_HOP)
	icon_state = "hop"

/obj/structure/closet/faction/montagnes
	name = "\proper hunter montagne's locker"
	desc = "The posessions of the owning Hunter Montagnes."
	req_access = list(ACCESS_HOS)
	icon_state = "hos"
