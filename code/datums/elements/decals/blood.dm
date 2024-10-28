/datum/element/decal/blood

/datum/element/decal/blood/Attach(datum/target, _icon, _icon_state, _dir, _cleanable=CLEAN_TYPE_BLOOD, _color, _layer=ABOVE_OBJ_LAYER)
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	. = ..()
	RegisterSignal(target, COMSIG_ATOM_GET_EXAMINE_NAME, PROC_REF(get_examine_name), TRUE)
	RegisterSignal(target, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED), PROC_REF(redraw), TRUE)

/datum/element/decal/blood/Detach(atom/source, force)
	UnregisterSignal(source, COMSIG_ATOM_GET_EXAMINE_NAME)
	UnregisterSignal(source, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	return ..()

/datum/element/decal/blood/generate_appearance(_icon, _icon_state, _dir, _layer, _color, _alpha, source)
	if(!_icon || !_icon_state)
		return FALSE
	if(!_color)
		_color = COLOR_BLOOD
	var/icon/blood_splatter_icon = icon(_icon, _icon_state, , 1)		//we only want to apply blood-splatters to the initial icon_state for each object
	blood_splatter_icon.Blend("#fff", ICON_ADD) 			//fills the icon_state with white (except where it's transparent)
	blood_splatter_icon.Blend(icon('icons/effects/blood.dmi', "itemblood"), ICON_MULTIPLY) //adds blood and the remaining white areas become transparant
	pic = mutable_appearance(blood_splatter_icon)
	pic.color = _color
	return TRUE

/datum/element/decal/blood/proc/get_examine_name(datum/source, mob/user, list/override)
	SIGNAL_HANDLER

	var/atom/A = source
	override[EXAMINE_POSITION_ARTICLE] = A.gender == PLURAL? "some" : "a"
	override[EXAMINE_POSITION_BEFORE] = " blood-stained "
	return COMPONENT_EXNAME_CHANGED

///this is probably quite bad, let me know if you have a better solution for this -S
/datum/element/decal/blood/proc/redraw(datum/source, mob/user)
	SIGNAL_HANDLER

	var/atom/bloodsource = source
	Detach(source)
	var/icon_state_adj = bloodsource.icon_state
	if(isbodypart(source))//bettericons :D
		var/obj/item/bodypart/parent_part = source
		icon_state_adj = parent_part.stored_icon_state
	bloodsource.AddElement(/datum/element/decal/blood, bloodsource.icon, icon_state_adj, _color = get_blood_dna_color(bloodsource.return_blood_DNA()))
