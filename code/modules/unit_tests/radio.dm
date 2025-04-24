/datum/unit_test/radio
	var/heard_count
	var/last_message

/datum/unit_test/radio/Run()
	var/obj/item/radio/first_radio = EASY_ALLOCATE()
	var/mob/living/carbon/human/first_human = EASY_ALLOCATE()
	first_human.put_in_hands(first_radio, forced = TRUE)

	var/obj/item/radio/second_radio = EASY_ALLOCATE()
	var/mob/living/carbon/human/second_human = EASY_ALLOCATE()
	second_human.put_in_hands(second_radio, forced = TRUE)

	RegisterSignal(second_human, COMSIG_MOVABLE_HEAR, PROC_REF(message_heard))

	first_human.say("Test")
	TEST_ASSERT_EQUAL(heard_count, 1, "The second human should have only heard 1 message as the radio is not on yet")
	heard_count = 0

	first_human.say(".l Test")
	TEST_ASSERT_EQUAL(heard_count, 1, "The second human should have only heard 1 message as the radio is not on yet")
	heard_count = 0

	first_radio.broadcasting = TRUE
	second_radio.broadcasting = TRUE

	first_human.say("Test")
	TEST_ASSERT_EQUAL(heard_count, 1, "Mismatch in expected amount of times heard.")
	heard_count = 0

	first_human.say(".l Test")
	TEST_ASSERT_EQUAL(heard_count, 2, "Mismatch in expected amount of times heard.")
	heard_count = 0

	first_radio.listening = TRUE

	first_human.say("Test")
	TEST_ASSERT_EQUAL(heard_count, 2, "Mismatch in expected amount of times heard.")
	heard_count = 0

	first_human.say(".l Test")
	TEST_ASSERT_EQUAL(heard_count, 2, "Mismatch in expected amount of times heard.")
	heard_count = 0

/datum/unit_test/radio/proc/message_heard(mob/living/carbon/human/hearer, message)
	heard_count++
	last_message = message
