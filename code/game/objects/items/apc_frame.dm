/obj/item/wallframe
	materials = list(MAT_METAL=MINERAL_MATERIAL_AMOUNT*2)
	flags = CONDUCT
	origin_tech = "materials=1;engineering=1"
	item_state = "syringe_kit"
	w_class = 2
	var/result_path
	var/inverse = 0
	// For inverse dir frames like light fixtures.


/obj/item/wallframe/proc/try_build(turf/on_wall)
	if(get_dist(on_wall,usr)>1)
		return
	var/ndir = get_dir(on_wall, usr)
	if(!(ndir in cardinal))
		return
	var/turf/loc = get_turf(usr)
	var/area/A = loc.loc
	if(!istype(loc, /turf/simulated/floor))
		usr << "<span class='warning'>You cannot place [src] on this spot!</span>"
		return
	if(A.requires_power == 0 || istype(A, /area/space))
		usr << "<span class='warning'>You cannot place [src] in this area!</span>"
		return
	if(gotwallitem(loc, ndir, inverse*2))
		usr << "<span class='warning'>There's already an item on this wall!</span>"
		return

	return 1

/obj/item/wallframe/proc/attach(turf/on_wall)
	if(result_path)
		playsound(src.loc, 'sound/machines/click.ogg', 75, 1)
		usr.visible_message("[usr.name] attaches [src] to the wall.",
			"<span class='notice'>You attach [src] to the wall.</span>",
			"<span class='italics'>You hear clicking.</span>")
		var/ndir = get_dir(on_wall,usr)
		if(inverse)
			ndir = turn(ndir, 180)

		var/obj/O = new result_path(get_turf(usr), ndir, 1)
		transfer_fingerprints_to(O)
		. = O
	qdel(src)




/obj/item/wallframe/attackby(obj/item/weapon/W, mob/user, params)
	..()
	if(istype(W, /obj/item/weapon/screwdriver))
		// For camera-building borgs
		var/turf/T = get_step(get_turf(user), user.dir)
		if(istype(T, /turf/simulated/wall))
			T.attackby(src, user, params)


	if(istype(W, /obj/item/weapon/wrench) && (m_amt || g_amt))
		user << "<span class='notice'>You dismantle [src].</span>"
		if(m_amt)
			new /obj/item/stack/sheet/metal(get_turf(src), m_amt/2000)
		if(m_amt)
			new /obj/item/stack/sheet/glass(get_turf(src), g_amt/2000)
		qdel(src)


// APC HULL

/obj/item/wallframe/apc_frame
	name = " APC frame"
	desc = "Used for repairing or building APCs"
	icon = 'icons/obj/apc_repair.dmi'
	icon_state = "apc_frame"
	flags = CONDUCT

/obj/item/wallframe/apc_frame/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	..()
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/stack/sheet/metal( get_turf(src.loc), 2 )
		qdel(src)

/obj/item/wallframe/apc_frame/try_build(turf/on_wall)
	if (get_dist(on_wall,usr)>1)
		return
	var/ndir = get_dir(usr,on_wall)
	if (!(ndir in cardinal))
		return
	var/turf/loc = get_turf(usr)
	var/area/A = loc.loc
	if (!istype(loc, /turf/simulated/floor))
		usr << "<span class='warning'>APC cannot be placed on this spot!</span>"
		return
	if (A.requires_power == 0 || istype(A, /area/space))
		usr << "<span class='warning'>APC cannot be placed in this area!</span>"
		return
	if (A.get_apc())
		usr << "<span class='warning'>This area already has APC!</span>"
		return //only one APC per area
	for(var/obj/machinery/power/terminal/T in loc)
		if (T.master)
			usr << "<span class='warning'>There is another network terminal here!</span>"
			return
		else
			var/obj/item/stack/cable_coil/C = new /obj/item/stack/cable_coil(loc)
			C.amount = 10
			usr << "<span class='notice'>You cut the cables and disassemble the unused power terminal.</span>"
			qdel(T)
	new /obj/machinery/power/apc(loc, ndir, 1)
	qdel(src)
