/obj/item/implant/razorwing
    name = "razorwing implant"
    desc = "Don't let your wings be dreams."
    icon = 'icons/obj/surgery.dmi'
    icon_state = "severedwings"
    var/cooldown = FALSE


/obj/item/implant/razorwing/activate()
    if(cooldown)
        to_chat(imp_in, "<span class='warning'>You can't do that yet!</span>")
        return
    if(imp_in.incapacitated())
        to_chat(imp_in, "<span class='warning'>You're in no state to do that!</span>")
        return

    imp_in.visible_message("<span class='danger'>\The [imp_in] flourishes their wings rapidly!</span>", "<span class='danger'>You flourish your wings!</span>")
    imp_in.emote("spin")
    imp_in.emote("flip")
    playsound(loc, 'sound/weapons/slashmiss.ogg', 50, TRUE)
    for(var/mob/living/L in get_hearers_in_view(1, imp_in))
        if(L == imp_in)
            continue
        L.adjustBruteLoss(20)
    cooldown = TRUE
    addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 10 SECONDS)

/obj/item/implant/razorwing/get_data()
    var/dat = {"
<b>Implant Specifications:</b><BR>
<b>Name:</b> Razorwing Biomodification<BR>
<b>Life:</b> indefinite uses<BR>
<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
<HR>
<b>Implant Details:</b> <BR>
<b>Function:</b> Modifies a mothperson's wings to become razor-sharp.<BR>
<HR>
No Implant Specifics"}
    return dat

/obj/item/implant/razorwing/can_be_implanted_in(mob/living/target)
	return ismoth(target)

/obj/item/implant/razorwing/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
    . = ..()
    if(.)
        to_chat(target, "<span class='notice'>You feel the tips of your wings grow sharper and more nimble...</span>")

/obj/item/implant/razorwing/removed(mob/living/source, silent = FALSE, special = 0)
    . = ..()
    if(.)
        to_chat(source, "<span class='warning'>You feel your wings revert to their normal shape and feel less nimble...</span>")

/obj/item/implanter/razorwing
	name = "implanter (razorwing)"
	imp_type = /obj/item/implant/razorwing
