/turf/simulated/floor/open
	name = "open space"
	intact = 0
	density = 0
	icon_state = "osblack"
	var/icon/darkoverlays = null
	var/turf/floorbelow
	var/list/overlay_references

	New()
		..()
		getbelow()
		return

	Enter(var/atom/movable/AM)
		if (..()) //TODO make this check if gravity is active (future use) - Sukasa
			spawn(1)
				// only fall down in defined areas (read: areas with artificial gravitiy)
				if(!floorbelow) //make sure that there is actually something below
					if(!getbelow())
						return
				if(AM)
					if (istype(AM, /obj/structure/lattice))
						return

					var/area/areacheck = get_area(src)
					var/blocked = 0
					for(var/atom/A in floorbelow.contents)
						if(A.density)
							blocked = 1
							break
						if(istype(A, /obj/machinery/atmospherics/pipe/zpipe/up) && istype(AM,/obj/item/pipe))
							blocked = 1
							break
						if(istype(A, /obj/structure/disposalpipe/crossZ/up) && istype(AM,/obj/item/pipe))
							blocked = 1
							break

					var/obj/structure/lattice/catwalk/W = locate(/obj/structure/lattice/catwalk, src)
					if (W)
						blocked = 1

							//dont break here, since we still need to be sure that it isnt blocked

					if (!blocked && !(areacheck.name == "Space"))
						AM.Move(floorbelow)
						if(locate(AM) in floorbelow)
							if ( istype(AM, /mob/living/carbon/human))
								if(AM:back && istype(AM:back, /obj/item/weapon/tank/jetpack))
									return
								else
									var/mob/living/carbon/human/H = AM
									var/damage = 10
//									H.apply_damage(rand(0,damage), BRUTE, "groin") // Õ¿ Õ¿’”… œŒ √–Œ»Õ”
									H.apply_damage(rand(0,damage), BRUTE, "l_leg")
									H.apply_damage(rand(0,damage), BRUTE, "r_leg")
									H.apply_damage(rand(2,damage), BRUTE, "l_foot")
									H.apply_damage(rand(2,damage), BRUTE, "r_foot")
									H:weakened = max(H:weakened,3)
									H:updatehealth()
		return ..()

/turf/simulated/floor/open/proc/getbelow()
	var/turf/controllerlocation = locate(1, 1, z)
	for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
		// check if there is something to draw below
		if(!controller.down)
			src.ChangeTurf(/turf/space)
			return 0
		else
			floorbelow = locate(src.x, src.y, controller.down_target)
			return 1
	return 1

// override to make sure nothing is hidden
/turf/simulated/floor/open/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(0)

//overwrite the attackby of space to transform it to openspace if necessary
/turf/space/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/stack/cable_coil))
		var/turf/simulated/floor/open/W = src.ChangeTurf(/turf/simulated/floor/open)
		W.attackby(C, user)
		return
	..()

/turf/simulated/floor/open/ex_act(severity)
	// cant destroy empty space with an ordinary bomb
	return

// Straight copy from space.
/turf/simulated/floor/open/attackby(obj/item/C as obj, mob/user as mob)
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		var/obj/structure/lattice/catwalk/W = locate(/obj/structure/lattice/catwalk, src)
		if(W)
			user << "<span class='warning'>There is already a catwalk here!</span>"
			return
		if(L)
			if(R.use(1))
				user << "<span class='notice'>You begin constructing catwalk...</span>"
				playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
				qdel(L)
				ReplaceWithCatwalk()
			else
				user << "<span class='warning'>You need two rods to build a catwalk!</span>"
			return
		if(R.use(1))
			user << "<span class='notice'>Constructing support lattice...</span>"
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			ReplaceWithLattice()
		else
			user << "<span class='warning'>You need one rod to build a lattice.</span>"
		return
	if(istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
				user << "<span class='notice'>You build a floor.</span>"
				ChangeTurf(/turf/simulated/floor/plating/airless)
			else
				user << "<span class='warning'>You need one floor tile to build a floor!</span>"
		else
			user << "<span class='warning'>The plating is going to need some support! Place metal rods first.</span>"
	if(istype(C, /obj/item/weapon/wirecutters))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			L.attackby(C, user)

	if(istype(C, /obj/item/weapon/weldingtool))
		var/obj/structure/lattice/catwalk/W = locate(/obj/structure/lattice/catwalk, src)
		if(W)
			W.attackby(C, user)