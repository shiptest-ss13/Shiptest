/datum/research_web
	var/list/datum/theory_holder/points

	var/list/datum/research_node/a_nodes_researched
	var/list/datum/research_node/a_nodes_not_researched
	var/list/datum/research_node/a_nodes_can_research
	var/list/datum/research_node/a_nodes_hidden
	var/list/datum/research_node/a_nodes_can_not_research
	var/list/datum/research_node/a_nodes_bepis

	// these are here to prevent machinery from having to iterate through the internal node lists
	var/static/list/all_nodes
	var/static/list/all_designs
	var/static/list/all_mutations // so this is apparentally just a fucking list of types, why on god

	var/list/datum/surgery/unlocked_designs
	var/list/datum/mutation/unlocked_mutations
	var/list/slime_already_researched
	var/list/plant_already_researched

	var/largest_bomb_value
	var/old_tech_largest_bomb_value

	var/list/consoles_accessing

	var/ruin = FALSE
	var/admin = FALSE
	var/obj/machinery/parent

/datum/research_web/integrated
	ruin = TRUE

/datum/research_web/integrated/New(obj/machinery/parent, buildtypes)
	. = ..(parent)
	if(!buildtypes)
		return
	if(!islist(buildtypes))
		buildtypes = list(buildtypes)
	for(var/datum/design/design as anything in all_designs)
		design = all_designs[design]
		if(!(design.build_type in buildtypes))
			continue
		unlocked_designs[design.id] = design

/datum/research_web/admin
	admin = TRUE

/datum/research_web/New(obj/machinery/parent)
	if(!all_designs)
		all_designs = list()
		all_mutations = list()
		all_nodes = list()
		for(var/datum/design/dtype as anything in subtypesof(/datum/design))
			if(initial(dtype.id) == DESIGN_ID_IGNORE)
				continue
			all_designs[initial(dtype.id)] = new dtype
		for(var/mutation in subtypesof(/datum/mutation))
			all_mutations += mutation
		for(var/datum/research_node/ntype as anything in subtypesof(/datum/research_node))
			if(initial(ntype.abstract) == ntype)
				continue
			all_nodes[initial(ntype.node_id)] = new ntype
		calculate_node_unlocks()
	src.parent = parent
	slime_already_researched = new
	plant_already_researched = new
	points = new
	ruin = ruin || (("is_ruin" in parent.vars) ? parent:is_ruin : FALSE) // unsafe var access, but we check for the var existing first
	a_nodes_researched = new
	a_nodes_not_researched = new
	a_nodes_can_research = new
	a_nodes_can_not_research = new
	a_nodes_hidden = new
	a_nodes_bepis = new
	unlocked_designs = new
	unlocked_mutations = new
	consoles_accessing = new
	init_node_lists()
	if(ruin)
		do_ruin_unlocks()

/datum/research_web/Destroy(force, ...)
	a_nodes_hidden.Cut()
	a_nodes_researched.Cut()
	a_nodes_not_researched.Cut()
	a_nodes_can_research.Cut()
	a_nodes_can_not_research.Cut()
	a_nodes_bepis.Cut()
	unlocked_designs.Cut()
	slime_already_researched.Cut()
	plant_already_researched.Cut()
	consoles_accessing.Cut()
	QDEL_LIST(points)
	parent = null
	return ..()

/datum/research_web/proc/init_node_lists()
	a_nodes_researched.Cut()
	a_nodes_not_researched.Cut()
	a_nodes_can_research.Cut()
	a_nodes_can_not_research.Cut()
	a_nodes_bepis.Cut()

	for(var/datum/research_node/node as anything in all_nodes)
		node = all_nodes[node]
		if(admin || node.starting_node)
			a_nodes_researched[node.node_id] = node
			continue
		a_nodes_not_researched[node.node_id] = node

	calculate_node_requisites()
	recalculate_unlocked_designs()

/// This does not check for circular dependencies; because I don't know a way to do that without being recursively recursive
/datum/research_web/proc/calculate_node_unlocks()
	for(var/datum/research_node/node as anything in all_nodes)
		node = all_nodes[node]
		node.unlock_nodes = node.unlock_nodes || new /list
		node.unlock_nodes.Cut()

	for(var/datum/research_node/node as anything in all_nodes)
		node = all_nodes[node]
		for(var/datum/research_node/req_node as anything in node.requisite_nodes)
			req_node = node_by_id(req_node)
			req_node.unlock_nodes |= node.node_id

/// Try not to call this, its incredibly costly
/datum/research_web/proc/calculate_node_requisites()
	if(ruin || admin)
		return

	a_nodes_can_research.Cut()
	a_nodes_can_not_research.Cut()
	a_nodes_hidden.Cut()
	a_nodes_bepis.Cut()

	for(var/datum/research_node/researched as anything in a_nodes_researched)
		a_nodes_can_not_research[researched] = a_nodes_researched[researched]

	for(var/datum/research_node/not_researched as anything in a_nodes_not_researched)
		not_researched = a_nodes_not_researched[not_researched]
		var/skip = FALSE
		if(not_researched.node_hidden)
			a_nodes_hidden[not_researched.node_id] = not_researched
			skip = TRUE
		if(not_researched.node_experimental)
			a_nodes_bepis[not_researched.node_id] = not_researched
			skip = TRUE
		if(skip)
			continue

		var/req = not_researched.requisite_nodes.Copy()
		for(var/req_id in not_researched.requisite_nodes)
			if(a_nodes_researched[req_id])
				req -= req_id
		if(length(req))
			a_nodes_can_not_research[not_researched.node_id] = not_researched
			continue

		var/exclusive = FALSE
		for(var/excl in not_researched.exclusive_nodes)
			if(a_nodes_researched[excl])
				exclusive = TRUE
				a_nodes_can_not_research[not_researched.node_id] = not_researched
				break
		if(exclusive)
			continue

		a_nodes_can_research[not_researched.node_id] = not_researched

/datum/research_web/proc/node_by_id(id)
	return all_nodes[id] || stack_trace("Attempted to get a non-existant node")

/datum/research_web/proc/add_points_from_note(obj/item/research_notes/note, mob/user)
	var/redeemed = add_points(note.point_type, note.value)
	if(redeemed < note.value)
		if(user)
			to_chat(user, "<span class='notice'>You scan some of the contents of [note] into the database, but not all of it could be uploaded!</span>")
		note.value -= redeemed
		return

	if(user)
		to_chat(user, "<span class='notice'>You scan [note] into the database.</span>")
	qdel(note)

/datum/research_web/proc/create_point_information_header()
	var/list/dat = list("<div id='rnd-points'>")
	for(var/datum/theory_holder/pnt_holder as anything in points)
		dat += "<p>[pnt_holder]: "
		pnt_holder = points[pnt_holder]
		dat += "[pnt_holder.points](/[pnt_holder.points_max])"
	dat += "</div>"
	return dat.Join()

/datum/research_web/proc/use_points(_type, amount, allow_partial=FALSE)
	if(ruin)
		return

	if(admin)
		return amount

	if(!(_type in points))
		return FALSE
	var/datum/theory_holder/holder = points[_type]
	return holder.use_points(amount, allow_partial)

/datum/research_web/proc/add_points(_type, amount, force=FALSE)
	if(ruin || admin)
		return

	if(!(_type in points))
		points[_type] = new /datum/theory_holder(_type)
	var/datum/theory_holder/holder = points[_type]
	return holder.add_points(amount, force)

/datum/research_web/proc/recalculate_unlocked_designs()
	unlocked_designs.Cut()
	for(var/datum/research_node/node as anything in a_nodes_researched)
		node = node_by_id(node)
		for(var/design in node.designs)
			unlocked_designs[design] = all_designs[design]

/datum/research_web/proc/handle_node_research_completion(datum/research_node/researched)
	a_nodes_researched[researched.node_id] = researched
	a_nodes_not_researched -= researched.node_id

	for(var/design in researched.designs)
		unlocked_designs[design] = all_designs[design]

	if(ruin)
		return

	for(var/datum/research_node/other as anything in all_nodes)
		other = node_by_id(other)
		if(other == researched)
			continue
		other.handle_other_completion(researched, src)

	calculate_node_requisites()

	for(var/obj/machinery/console as anything in consoles_accessing)
		console.say("Research Complete: [researched.name]")
		console.updateDialog()

/datum/research_web/proc/__filter_hidden(list/nodes)
	. = nodes.Copy()
	for(var/datum/research_node/node as anything in nodes)
		if(node.node_hidden)
			. -= node

/datum/research_web/proc/__filter_dept(list/nodes, dept)
	. = list()
	for(var/datum/research_node/node as anything in nodes)
		if(node.category == dept)
			. += node

/datum/research_web/proc/get_designs(category)
	. = list()
	for(var/datum/design/design as anything in unlocked_designs)
		if(category in design.category)
			. += design

/datum/research_web/proc/do_ruin_unlocks()
	if(!ruin || !("ruin_node_list" in src.parent.vars))
		return

	var/list/prob_hit = new
	var/obj/machinery/research_server/parent = src.parent // the var we want exists, pretend its a research server even though we dont know for certain
	for(var/node_entry in parent.ruin_node_list)
		var/entry_prob = parent.ruin_node_list[node_entry]
		if(prob(entry_prob))
			prob_hit[node_entry] = entry_prob

	var/prob_spawned = 0
	while(length(prob_hit) && prob_spawned < parent.ruin_node_max)
		var/lowest_key
		var/lowest_prob
		for(var/entry in prob_hit)
			if(prob_hit[entry] < lowest_prob)
				lowest_prob = prob_hit[entry]
				lowest_key = entry
		prob_hit -= lowest_key

		var/found = FALSE
		for(var/datum/research_node/node as anything in a_nodes_not_researched)
			node = node_by_id(node)
			if(node.node_id == lowest_key)
				found = node
				break
		if(found)
			handle_node_research_completion(found)
			prob_spawned += 1
		else
			message_admins("attempted to force complete node for a ruin, but the given ID doesnt exist! --> '[lowest_key]'")
