/datum/mood_event/hug
	description = span_nicegreen("Hugs are nice.")
	mood_change = 1
	timeout = 2

/datum/mood_event/bear_hug
	description = span_nicegreen("I got squeezed very tightly, but it was quite nice.")
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/betterhug
	description = span_nicegreen("Someone was very nice to me.")
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/betterhug/add_effects(mob/friend)
	description = span_nicegreen("[friend.name] was very nice to me.")

/datum/mood_event/besthug
	description = span_nicegreen("Someone is great to be around, they make me feel so happy!")
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/besthug/add_effects(mob/friend)
	description = span_nicegreen("[friend.name] is great to be around, [friend.p_they()] makes me feel so happy!")

/datum/mood_event/best_boop
	description = span_nicegreen("Someone booped my nose, they are silly!")
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/best_boop/add_effects(mob/friend)
	description = span_nicegreen("[friend.name] booped my nose, [friend.p_they()] [friend.p_are()] silly!")

/datum/mood_event/warmhug
	description = span_nicegreen("Warm cozy hugs are the best!")
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/arcade
	description = span_nicegreen("I beat the arcade game!")
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/blessing
	description = span_nicegreen("I've been blessed.")
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/book_nerd
	description = span_nicegreen("I have recently read a book.")
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/exercise
	description = span_nicegreen("Working out releases those endorphins!")
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal
	description = span_nicegreen("Animals are adorable! I can't stop petting them!")
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal/add_effects(mob/animal)
	description = span_nicegreen("\The [animal.name] is adorable! I can't stop petting [animal.p_them()]!")

/datum/mood_event/honk
	description = span_nicegreen("I've been honked!")
	mood_change = 2
	timeout = 4 MINUTES
	special_screen_obj = "honked_nose"
	special_screen_replace = FALSE

/datum/mood_event/perform_cpr
	description = span_nicegreen("It feels good to save a life.")
	mood_change = 6
	timeout = 8 MINUTES

/datum/mood_event/oblivious
	description = span_nicegreen("What a lovely day.")
	mood_change = 3

/datum/mood_event/jolly
	description = span_nicegreen("I feel happy for no particular reason.")
	mood_change = 6
	timeout = 2 MINUTES

/datum/mood_event/focused
	description = span_nicegreen("I have a goal, and I will reach it, whatever it takes!") //Used for syndies, nukeops etc so they can focus on their goals
	mood_change = 4
	hidden = TRUE

/datum/mood_event/badass_antag
	description = span_greentext("I'm a fucking badass and everyone around me knows it. Just look at them; they're all fucking shaking at the mere thought of having me around.")
	mood_change = 7
	hidden = TRUE
	special_screen_obj = "badass_sun"
	special_screen_replace = FALSE

/datum/mood_event/creeping
	description = span_greentext("The voices have released their hooks on my mind! I feel free again!") //creeps get it when they are around their obsession
	mood_change = 18
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/revolution
	description = span_nicegreen("VIVA LA REVOLUTION!")
	mood_change = 3
	hidden = TRUE

/datum/mood_event/family_heirloom
	description = span_nicegreen("My family heirloom is safe with me.")
	mood_change = 1

/datum/mood_event/rilena_fan
	description = span_nicegreen("I love my RILENA merch!")
	mood_change = 1

/datum/mood_event/rilena_super_fan
	description = span_nicegreen("I love my RILENA hoodie!")
	mood_change = 1

/datum/mood_event/goodmusic
	description = span_nicegreen("There is something soothing about this music.")
	mood_change = 3
	timeout = 60 SECONDS

/datum/mood_event/chemical_euphoria
	description = span_nicegreen("Heh...hehehe...hehe...")
	mood_change = 4

/datum/mood_event/chemical_laughter
	description = span_nicegreen("Laughter really is the best medicine! Or is it?")
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/chemical_superlaughter
	description = span_nicegreen("*WHEEZE*")
	mood_change = 12
	timeout = 3 MINUTES

/datum/mood_event/religiously_comforted
	description = span_nicegreen("You are comforted by the presence of a holy person.")
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/clownshoes
	description = span_nicegreen("The shoes are a clown's legacy, I never want to take them off!")
	mood_change = 5

/datum/mood_event/sacrifice_good
	description =span_nicegreen("The gods are pleased with this offering!")
	mood_change = 5
	timeout = 3 MINUTES

/datum/mood_event/artok
	description = span_nicegreen("It's nice to see people are making art around here.")
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/artgood
	description = span_nicegreen("What a thought-provoking piece of art. I'll remember that for a while.")
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/artgreat
	description = span_nicegreen("That work of art was so great it made me believe in the goodness of humanity. Says a lot in a place like this.")
	mood_change = 6
	timeout = 5 MINUTES

/datum/mood_event/pet_borg
	description = span_nicegreen("I just love my robotic friends!")
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/bottle_flip
	description = span_nicegreen("The bottle landing like that was satisfying.")
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/hope_lavaland
	description = span_nicegreen("What a peculiar emblem.  It makes me feel hopeful for my future.")
	mood_change = 5

/datum/mood_event/nanite_happiness
	description = span_nicegreen_robot("+++++++HAPPINESS ENHANCEMENT+++++++")
	mood_change = 7

/datum/mood_event/nanite_happiness/add_effects(message)
	description = span_nicegreen_robot("+++++++[message]+++++++")

/datum/mood_event/area
	description = "" //Fill this out in the area
	mood_change = 0

/datum/mood_event/area/add_effects(_mood_change, _description)
	mood_change = _mood_change
	description = _description

/datum/mood_event/confident_mane
	description = span_nicegreen("I'm feeling confident with a head full of hair.")
	mood_change = 2

/datum/mood_event/dkickflip
	description = span_nicegreen("I just witnessed the most RAD thing ever.")
	mood_change = 5
	timeout = 2 MINUTES

/datum/mood_event/high_five
	description = span_nicegreen("I love getting high fives!")
	mood_change = 2
	timeout = 45 SECONDS

/datum/mood_event/high_ten
	description = span_nicegreen("AMAZING! A HIGH-TEN!")
	mood_change = 3
	timeout = 45 SECONDS

/datum/mood_event/down_low
	description = span_nicegreen("HA! What a rube, they never stood a chance...")
	mood_change = 4
	timeout = 1.5 MINUTES

/datum/mood_event/kiss
	description = span_nicegreen("Someone blew a kiss at me, I must be a real catch!")
	mood_change = 1.5
	timeout = 2 MINUTES

/datum/mood_event/kiss/add_effects(mob/beau, direct)
	if(!beau)
		return
	if(direct)
		description = span_nicegreen("[beau.name] gave me a kiss, ahh!!")
	else
		description = span_nicegreen("[beau.name] blew a kiss at me, I must be a real catch!")

/datum/mood_event/fishing
	description = span_nicegreen("Fishing is relaxing")
	mood_change = 5
	timeout = 3 MINUTES

/datum/mood_event/joywire
	description = span_boldnicegreen("I feel so joyous! Oh, so joyous!")
	mood_change = 8
	timeout = 10 SECONDS

/datum/mood_event/root
	description = span_nicegreen("I rooted recently, it feels good to charge naturally.")
	mood_change = 5
	timeout = 5 MINUTES
