/datum/disease/transformation/legionvirus
	name = "Soulus Saturation"
	max_stages = 5
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	cure_text = "System Cleaner"
	cures = list(/datum/reagent/medicine/system_cleaner)
	agent = "Soulus Dust"
	viable_mobtypes = list(/mob/living/carbon/human)
	visibility_flags = 0
	stage_prob = 5
	cure_chance = 20
	desc = "If left untreated, this disease will cause the infected to transform into a legion."
	severity = DISEASE_SEVERITY_HARMFUL
	disease_flags = CURABLE
	bypasses_immunity = TRUE

	stage1 = list("Your joints itch.")
	stage2 = list("Your head begins to ache.")
	stage3 = list("Ash begins to flake off your skin.")
	stage4 = list("<span class='warning'>You feel like your head is splitting in two!</span>")
	stage5 = list("<span class='warning'>You feel something growing inside your chest!</span>")
	new_form = /mob/living/simple_animal/hostile/asteroid/hivelord/legion

/datum/disease/transformation/legionvirus/do_disease_transformation(mob/living/H)
	H.visible_message("<span class='warning'>[H] transforms into a legion!</span>")
	var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/L
	if(HAS_TRAIT(H, TRAIT_DWARF)) //dwarf legions aren't just fluff!
		L = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf(H.loc)
	else
		L = new(H.loc)
	H.death()
	H.adjustBruteLoss(1000)
	L.stored_mob = H
	H.forceMove(L)
	qdel(src)
