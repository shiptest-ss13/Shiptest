
/obj/item/reagent_containers/food/snacks/pie
	icon = 'icons/obj/food/piecake.dmi'
	trash = /obj/item/trash/plate
	bitesize = 3
	w_class = WEIGHT_CLASS_NORMAL
	volume = 80
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("pie" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/pie/plain
	name = "plain pie"
	desc = "A baked pie crust with no fillings. Edible as is, but..."
	icon_state = "pie"
	custom_food_type = /obj/item/reagent_containers/food/snacks/customizable/pie
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("piecrust" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/pie/cream
	name = "banana cream pie"
	desc = "A custard and baked banana pie, topped with whipped cream. Ever popular in human cuisine, a brief extranet fad of using it as a throwing projectile made it a favorite of pranksters."
	icon_state = "pie"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("pie" = 1, "bananas and cream" = 1)
	foodtype = GRAIN | DAIRY | SUGAR
	var/stunning = TRUE

/obj/item/reagent_containers/food/snacks/pie/cream/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/reagent_containers/food/snacks/pie/cream/proc/splat(atom/movable/hit_atom)
	if(isliving(loc)) //someone caught us!
		return
	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/food/pie_smudge(T)
	if(reagents && reagents.total_volume)
		reagents.expose(hit_atom, TOUCH)
	if(isliving(hit_atom))
		var/mob/living/L = hit_atom
		if(stunning)
			L.Paralyze(20) //splat!
		L.adjust_blurriness(1)
		L.visible_message("<span class='warning'>[L] is creamed by [src]!</span>", "<span class='userdanger'>You've been creamed by [src]!</span>")
		playsound(L, "desceration", 50, TRUE)
	if(is_type_in_typecache(hit_atom, GLOB.creamable))
		hit_atom.AddComponent(/datum/component/creamed, src)
	qdel(src)

/obj/item/reagent_containers/food/snacks/pie/cream/nostun
	stunning = FALSE

/obj/item/reagent_containers/food/snacks/pie/berryclafoutis
	name = "berry clafoutis"
	desc = "A tart consisting of berries smothered in a thick batter before being baked and coated with powdered sugar. A pleasant treat from the outer cantons."
	icon_state = "berryclafoutis"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/berryjuice = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("pie" = 1, "blackberries" = 1)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/pie/bearypie
	name = "beary pie"
	desc = "A particularly heavy meat pie. The name stems from a rumor of a sort of spaceborne ursine that stalks asteroids and hunts unfortunate asteroid miners, known for their starry pelts."
	icon_state = "bearypie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pie" = 1, "meat" = 1, "salmon" = 1)
	foodtype = GRAIN | SUGAR | MEAT | FRUIT

/obj/item/reagent_containers/food/snacks/pie/meatpie
	name = "meat pie"
	icon_state = "meatpie"
	desc = "A pie crust, filled with meat and other savory ingredients. A source of culinary debate between which culture on Terra and Kalixcis invented it first still goes on today, with both early species having used ancient recipes to use pie dough to allow cooked meat to be held and eaten thousands of years ago."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("pie" = 1, "meat" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/pie/tofupie
	name = "tofu pie"
	icon_state = "meatpie"
	desc = "A vegetarian variant of the meat pie, usually of firm tofu that's been seasoned thoroughly beforehand and paired with a sauce."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("pie" = 1, "tofu" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/pie/amanita_pie
	name = "amanita pie"
	desc = "A culinary experiment, the amanita pie, or fly agaric pie, is still notoriously poisonous and hallucinogenic in spite of the culinary preparation."
	icon_state = "amanita_pie"
	bitesize = 4
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/toxin/amatoxin = 3, /datum/reagent/drug/mushroomhallucinogen = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pie" = 1, "mushroom" = 1)
	foodtype = GRAIN | VEGETABLES | TOXIC | GROSS

/obj/item/reagent_containers/food/snacks/pie/plump_pie
	name = "plump pie"
	desc = "A common method of preparing the savory mushroom from Syeben'Altch, the plump pie is full of baked, softened mushrooms."
	icon_state = "plump_pie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pie" = 1, "mushroom" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/pie/plump_pie/Initialize()
	. = ..()
	var/fey = prob(10)
	if(fey)
		name = "exceptional plump pie"
		desc = "A common method of preparing the savory mushroom from Syeben'Altch, the plump pie is full of baked, softened mushrooms. Rarely, the plump helmet can secrete a medicinal substance."
		bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/medicine/omnizine = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	if(fey)
		reagents.add_reagent(/datum/reagent/medicine/omnizine, 5)

/obj/item/reagent_containers/food/snacks/pie/xemeatpie
	name = "xeno-pie"
	icon_state = "xenomeatpie"
	desc = "A meat pie prepared from the dangerous xenomorph's prepared flesh. The crust is actively melting and smoking from the acid."
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("pie" = 1, "meat" = 1, "acid" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/pie/applepie
	name = "apple pie"
	desc = "A pie consisting of sweetened, baked apples and cinnamon. A hallmark of Solar dessert cuisine."
	icon_state = "applepie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pie" = 1, "apple" = 1)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/pie/cherrypie
	name = "cherry pie"
	desc = "A pie filled with sour cherries mixed with sugar and baked. Considered a sibling to the other fruit-filled pies of Solar make."
	icon_state = "cherrypie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("pie" = 7, "sweet, tart cherries" = 2)
	foodtype = GRAIN | FRUIT | SUGAR


/obj/item/reagent_containers/food/snacks/pie/pumpkinpie
	name = "pumpkin pie"
	desc = "A pie filled with a pumpkin-based custard, spiced heavily. Despite catching on as a flavoring, the actual pumpkin gourd is relatively plain."
	icon_state = "pumpkinpie"
	slice_path = /obj/item/reagent_containers/food/snacks/pumpkinpieslice
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("pie" = 1, "pumpkin" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/pumpkinpieslice
	name = "pumpkin pie slice"
	desc = "A slice of pumpkin pie."
	icon = 'icons/obj/food/piecake.dmi'
	icon_state = "pumpkinpieslice"
	trash = /obj/item/trash/plate
	filling_color = "#FFA500"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("pie" = 1, "pumpkin" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/pie/appletart
	name = "golden apple streusel tart"
	desc = "Baked, cinnamon-coated apples mixed with streusel. Particularly crumbly."
	icon_state = "gappletart"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/gold = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pie" = 1, "apple" = 1, "expensive metal" = 1)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/pie/grapetart
	name = "grape tart"
	desc = "A thin tart, filled with sweetened grapes."
	icon_state = "grapetart"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pie" = 1, "grape" = 1)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/pie/mimetart
	name = "mime tart"
	desc = "A thin tart mixed with... seemingly nothing."
	icon_state = "mimetart"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/nothing = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("nothing" = 3)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/pie/berrytart
	name = "berry tart"
	desc = "A thin tart, filled with various berries."
	icon_state = "berrytart"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("pie" = 1, "berries" = 2)
	foodtype = GRAIN | FRUIT

/obj/item/reagent_containers/food/snacks/pie/cocolavatart
	name = "chocolate lava tart"
	desc = "A smaller version of the lava cake, this is essentially a miniature cake filled with molten chocolate."
	icon_state = "cocolavatart"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pie" = 1, "dark chocolate" = 3)
	foodtype = GRAIN | SUGAR

/obj/item/reagent_containers/food/snacks/pie/blumpkinpie
	name = "blumpkin pie"
	desc = "A pie filled with a botanical experiment-based custard, which stings the eyes and nose heavily. The smell of chlorine is almost unbearable."
	icon_state = "blumpkinpie"
	slice_path = /obj/item/reagent_containers/food/snacks/blumpkinpieslice
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("pie" = 1, "a mouthful of pool water" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/blumpkinpieslice
	name = "blumpkin pie slice"
	desc = "A slice of blumpkin pie."
	icon = 'icons/obj/food/piecake.dmi'
	icon_state = "blumpkinpieslice"
	trash = /obj/item/trash/plate
	filling_color = "#1E90FF"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("pie" = 1, "a mouthful of pool water" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/pie/dulcedebatata
	name = "dulce de batata"
	desc = "A jelly derived from sweet potatoes, often found canned or mixed with chocolate."
	icon_state = "dulcedebatata"
	slice_path = /obj/item/reagent_containers/food/snacks/dulcedebatataslice
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 8)
	tastes = list("jelly" = 1, "sweet potato" = 1)
	foodtype = GRAIN | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/dulcedebatataslice
	name = "dulce de batata slice"
	desc = "A slice of dulce de batata."
	icon = 'icons/obj/food/piecake.dmi'
	icon_state = "dulcedebatataslice"
	trash = /obj/item/trash/plate
	filling_color = "#8B4513"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("jelly" = 1, "sweet potato" = 1)
	foodtype = GRAIN | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/pie/frostypie
	name = "frosty pie"
	desc = "An extremely minty pie, served cold. It's difficult to eat from the sheer strength of its contents..."
	icon_state = "frostypie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("mint" = 1, "pie" = 1)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/pie/baklava
	name = "baklava"
	desc = "A pastry made up of layers of filo, chopped nuts, and brushed with honey."
	icon_state = "baklava"
	slice_path = /obj/item/reagent_containers/food/snacks/baklavaslice
	slices_num = 6
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("nuts" = 1, "pie" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/baklavaslice
	name = "baklava dish"
	desc = "A portion of a many-layered baklava."
	icon = 'icons/obj/food/piecake.dmi'
	icon_state = "baklavaslice"
	trash = /obj/item/trash/plate
	filling_color = "#1E90FF"
	tastes = list("nuts" = 1, "pie" = 1)
	foodtype = GRAIN
