/datum/quirk/signer
	name = "Signer"
	desc = "You possess excellent communication skills in sign language."
	value = 0

/datum/quirk/signer/add()
	quirk_holder.AddComponent(/datum/component/sign_language)

/datum/quirk/signer/remove()
	qdel(quirk_holder.GetComponent(/datum/component/sign_language))
