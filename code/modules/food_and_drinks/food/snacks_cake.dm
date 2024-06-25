/obj/item/reagent_containers/food/snacks/store/cake
	icon = 'icons/obj/food/piecake.dmi'
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/plain
	slices_num = 5
	bitesize = 3
	volume = 80
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice
	icon = 'icons/obj/food/piecake.dmi'
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1)
	customfoodfilling = 0 //to avoid infinite cake-ception
	tastes = list("cake" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/plain
	name = "plain cake"
	desc = "A plain, sweet cake."
	icon_state = "plaincake"
	custom_food_type = /obj/item/reagent_containers/food/snacks/customizable/cake
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("sweetness" = 2,"cake" = 5)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/plain
	name = "plain cake slice"
	desc = "A slice of plain cake."
	icon_state = "plaincake_slice"
	filling_color = "#FFD700"
	customfoodfilling = 1
	tastes = list("sweetness" = 2,"cake" = 5)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/carrot
	name = "carrot cake"
	desc = "A frosted cake with carrots mixed into the batter before baking. The carrot brings a certain sweetness and texture... and have been modified over generations to actually benefit your eyes."
	icon_state = "carrotcake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/carrot
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/medicine/oculine = 5, /datum/reagent/consumable/nutriment/vitamin = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/medicine/oculine = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/carrot
	name = "carrot cake slice"
	desc = "A slice of carrot cake."
	icon_state = "carrotcake_slice"
	filling_color = "#FFA500"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/oculine = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/brain
	name = "brain cake"
	desc = "A cake with a brain mixed into the batter before baking. Oddly mushy and offputting to most before someone went through the effort of decorating it to look the part."
	icon_state = "braincake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/brain
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/medicine/mannitol = 10, /datum/reagent/consumable/nutriment/vitamin = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/medicine/mannitol = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)
	foodtype = GRAIN | DAIRY | MEAT | GROSS | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/brain
	name = "brain cake slice"
	desc = "A slice of brain cake. Unpleasantly moist."
	icon_state = "braincakeslice"
	filling_color = "#FF69B4"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/mannitol = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)
	foodtype = GRAIN | DAIRY | MEAT | GROSS | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/cheese
	name = "cheesecake"
	desc = "A cake made from sweetened cheese, usually with a crumb base. Technically a <i>torte</i> and not a cake, but don't let that stop you."
	icon_state = "cheesecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/cheese
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 4, "sweet cream cheese" = 3)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice/cheese
	name = "cheesecake slice"
	desc = "Slice of cheesecake."
	icon_state = "cheesecake_slice"
	filling_color = "#FFFACD"
	tastes = list("cake" = 4, "cream cheese" = 3)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/orange
	name = "orange cake"
	desc = "A cake prepared with orange zest. Citrusy and sweet."
	icon_state = "orangecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/orange
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/orange
	name = "orange cake slice"
	desc = "A slice of orange cake."
	icon_state = "orangecake_slice"
	filling_color = "#FFA500"
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/lime
	name = "lime cake"
	desc = "A cake prepared with lime zest. Citrusy and very sour."
	icon_state = "limecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/lime
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/lime
	name = "lime cake slice"
	desc = "A slice of lime cake."
	icon_state = "limecake_slice"
	filling_color = "#00FF00"
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/lemon
	name = "lemon cake"
	desc = "A cake prepared with lemon zest. Citrusy, sour, and sweet."
	icon_state = "lemoncake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/lemon
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/lemon
	name = "lemon cake slice"
	desc = "A slice of lemon cake."
	icon_state = "lemoncake_slice"
	filling_color = "#FFEE00"
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/chocolate
	name = "chocolate cake"
	desc = "A chocolate-flavored and frosted cake. A classic variant from the traditional vanilla cake."
	icon_state = "chocolatecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/chocolate
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/chocolate
	name = "chocolate cake slice"
	desc = "A slice of chocolate cake."
	icon_state = "chocolatecake_slice"
	filling_color = "#A0522D"
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/birthday
	name = "birthday cake"
	desc = "A cake typically made from an old Solarian tradition to celebrate someone's birthday with. Garnished with sprinkles and candles according to their new age."
	icon_state = "birthdaycake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/birthday
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/sprinkles = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/sprinkles = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 1)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/birthday/microwave_act(obj/machinery/microwave/M) //super sekrit club
	new /obj/item/clothing/head/hardhat/cakehat(get_turf(src))
	qdel(src)

/obj/item/reagent_containers/food/snacks/cakeslice/birthday
	name = "birthday cake slice"
	desc = "A slice of birthday cake."
	icon_state = "birthdaycakeslice"
	filling_color = "#DC143C"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sprinkles = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("cake" = 5, "sweetness" = 1)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/birthday/energy
	name = "energy cake"
	desc = "A cake prepared with a hardlight sword used by tactical boarding parties to quickly slice through body armor and fortifications. Wait, what?"
	icon_state = "energycake"
	force = 5
	hitsound = 'sound/weapons/blade1.ogg'
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/birthday/energy
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/sprinkles = 10, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/pacfuel = 10, /datum/reagent/consumable/liquidelectricity = 10)
	tastes = list("cake" = 3, "the sensation of your mouth being sliced open" = 1)

/obj/item/reagent_containers/food/snacks/store/cake/birthday/energy/proc/energy_bite(mob/living/user)
	to_chat(user, "<font color='red' size='5'>As you eat the cake, you accidentally hurt yourself on the embedded energy sword!</font>")
	user.apply_damage(30,BRUTE,BODY_ZONE_HEAD)
	playsound(user, 'sound/weapons/blade1.ogg', 5, TRUE)

/obj/item/reagent_containers/food/snacks/store/cake/birthday/energy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && M != user) //Prevents pacifists from attacking others directly
		return
	energy_bite(M, user)

/obj/item/reagent_containers/food/snacks/store/cake/birthday/energy/microwave_act(obj/machinery/microwave/M) //super sekriter club
	new /obj/item/clothing/head/hardhat/cakehat/energycake(get_turf(src))
	qdel(src)

/obj/item/reagent_containers/food/snacks/cakeslice/birthday/energy
	name = "energy cake slice"
	desc = "A slice of sword-bearing cake. You could, technically, cut the rest of the slices with this."
	icon_state = "energycakeslice"
	force = 2
	hitsound = 'sound/weapons/blade1.ogg'
	filling_color = "#00FF00"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sprinkles = 2, /datum/reagent/consumable/nutriment/vitamin = 1,  /datum/reagent/consumable/pacfuel = 2, /datum/reagent/consumable/liquidelectricity = 2)
	tastes = list("cake" = 3, "a Vlad's Salad" = 1)

/obj/item/reagent_containers/food/snacks/cakeslice/birthday/energy/proc/energy_bite(mob/living/user)
	to_chat(user, "<font color='red' size='5'>As you eat the cake slice, you accidentally hurt yourself on the embedded energy dagger!</font>")
	user.apply_damage(18,BRUTE,BODY_ZONE_HEAD)
	playsound(user, 'sound/weapons/blade1.ogg', 5, TRUE)

/obj/item/reagent_containers/food/snacks/cakeslice/birthday/energy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && M != user) //Prevents pacifists from attacking others directly
		return
	energy_bite(M, user)

/obj/item/reagent_containers/food/snacks/store/cake/apple
	name = "apple cake"
	desc = "A cake prepared with chunks of sweet apples."
	icon_state = "applecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/apple
	slices_num = 5
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/apple
	name = "apple cake slice"
	desc = "A slice of apple cake."
	icon_state = "applecakeslice"
	filling_color = "#FF4500"
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/custom
	name = "cake slice"
	icon_state = "plaincake_slice"
	filling_color = "#FFFFFF"
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/slimecake
	name = "Slime cake"
	desc = "A cake made out of a commonly domesticated and harvested xenofauna for industrial uses. Aren't they caustic to other living beings?"
	icon_state = "slimecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/slimecake
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/slimecake
	name = "slime cake slice"
	desc = "A slice of slime cake. It quivers slightly."
	icon_state = "slimecake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice
	name = "pumpkin spice cake"
	desc = "A cake made with pumpkin spice, which... technically doesn't usually contain real pumpkins. Not to be confused with the pumpkin pie."
	icon_state = "pumpkinspicecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/pumpkinspice
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/pumpkinspice
	name = "pumpkin spice cake slice"
	desc = "A slice of spiced pumpkin cake."
	icon_state = "pumpkinspicecakeslice"
	filling_color = "#FFD700"
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/bsvc // blackberry strawberries vanilla cake
	name = "blackberry and strawberry vanilla cake"
	desc = "A vanilla-frosted cake, decorated with sliced blackberries and strawberries."
	icon_state = "blackbarry_strawberries_cake_vanilla_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/bsvc
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 14, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("blackberry" = 2, "strawberries" = 2, "vanilla" = 2, "sweetness" = 2, "cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/bsvc
	name = "blackberry and strawberry vanilla cake slice"
	desc = "A slice of vanilla cake, topped with blackberries and strawberries."
	icon_state = "blackbarry_strawberries_cake_vanilla_slice"
	filling_color = "#FFD700"
	tastes = list("blackberry" = 2, "strawberries" = 2, "vanilla" = 2, "sweetness" = 2,"cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/bscc // blackbarry strawberries chocolate cake
	name = "blackberry and strawberry chocolate cake"
	desc = "A chocolate-frosted cake, decorated with sliced blackberries and strawberries."
	icon_state = "blackbarry_strawberries_cake_coco_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/bscc
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 14, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/coco = 5)
	tastes = list("blackberry" = 2, "strawberries" = 2, "chocolate" = 2, "sweetness" = 2,"cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/bscc
	name = "blackberry and strawberry chocolate cake slice"
	desc = "A slice of chocolate cake, topped with blackberries and strawberries."
	icon_state = "blackbarry_strawberries_cake_coco_slice"
	filling_color = "#FFD700"
	tastes = list("blackberry" = 2, "strawberries" = 2, "chocolate" = 2, "sweetness" = 2,"cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/holy_cake
	name = "angel food cake"
	desc = "A very light sponge cake, usually topped with fruit. It is not particularly religious in that regard."
	icon_state = "holy_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/holy_cake_slice
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/water/holywater = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/holy_cake_slice
	name = "angel food cake slice"
	desc = "A slice of angel food cake."
	icon_state = "holy_cake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/pound_cake
	name = "pound cake"
	desc = "A simple, sweet cake. Usually coated with icing or a glaze. It is very filling."
	icon_state = "pound_cake"
	slices_num = 7 //Its ment to feed the party
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/pound_cake_slice
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 60)
	tastes = list("cake" = 5, "sweetness" = 1, "batter" = 1)
	foodtype = GRAIN | DAIRY | SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/cakeslice/pound_cake_slice
	name = "pound cake slice"
	desc = "A slice of pound cake."
	icon_state = "pound_cake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 5, "sweetness" = 5, "batter" = 1)
	foodtype = GRAIN | DAIRY | SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/store/cake/hardware_cake
	name = "hardware cake"
	desc = "A cake made out of PCB and sulfuric acid. An oddity, considering you can't feed IPCs this."
	icon_state = "hardware_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/hardware_cake_slice
	bonus_reagents = list(/datum/reagent/toxin/acid = 15, /datum/reagent/fuel/oil = 15)
	tastes = list("acid" = 3, "metal" = 4, "glass" = 5)
	foodtype = GRAIN | GROSS

/obj/item/reagent_containers/food/snacks/cakeslice/hardware_cake_slice
	name = "hardware cake slice"
	desc = "A slice of hardware cake. You still can't feed an IPC this."
	icon_state = "hardware_cake_slice"
	filling_color = "#00FFFF"
	tastes = list("acid" = 3, "metal" = 4, "glass" = 5)
	foodtype = GRAIN | GROSS

/obj/item/reagent_containers/food/snacks/store/cake/vanilla_cake
	name = "vanilla cake"
	desc = "A vanilla frosted cake."
	icon_state = "vanillacake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/vanilla_slice
	bonus_reagents = list(/datum/reagent/consumable/sugar = 15, /datum/reagent/consumable/vanilla = 15)
	tastes = list("cake" = 1, "sugar" = 1, "vanilla" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice/vanilla_slice
	name = "vanilla cake slice"
	desc = "A slice of vanilla frosted cake."
	icon_state = "vanillacake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 1, "sugar" = 1, "vanilla" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/clown_cake
	name = "clown cake"
	desc = "A cake decorated in the shape of a clown. You don't find it all that funny."
	icon_state = "clowncake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/clown_slice
	bonus_reagents = list(/datum/reagent/consumable/sugar = 15)
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice/clown_slice
	name = "clown cake slice"
	desc = "A slice of clown cake. It's still not that funny."
	icon_state = "clowncake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/trumpet
	name = "spaceman's cake"
	desc = "A cake made out of a mutated flower, often found growing out on space installations. Uniquely purple and sweet."
	icon_state = "trumpetcake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/trumpet
	bonus_reagents = list(/datum/reagent/medicine/polypyr = 15, /datum/reagent/consumable/cream = 5, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/berryjuice = 5)
	filling_color = "#7A3D80"
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/trumpet
	name = "spaceman's cake"
	desc = "A slice of spaceman's trumpet cake."
	icon_state = "trumpetcakeslice"
	filling_color = "#7A3D80"
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR
