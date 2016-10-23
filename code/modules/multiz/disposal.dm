///// Z-Level stuff
/obj/structure/disposalpipe/crossZ/up
	icon_state = "pipe-u"

	New()
		..()
		dpdir = dir
		update()
		return

	nextdir(var/fromdir)
		var/nextdir
		if(fromdir == 11)
			nextdir = dir
		else
			nextdir = 12
		return nextdir

	transfer(var/obj/structure/disposalholder/H)
		var/nextdir = nextdir(H.dir)
		H.dir = nextdir

		var/turf/T
		var/obj/structure/disposalpipe/P

		if(nextdir == 12)
			var/turf/controllerlocation = locate(1, 1, src.z)
			for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
				if(controller.up)
					T = locate(src.x, src.y, controller.up_target)
			if(!T)
				H.loc = src.loc
				return
			else
				for(var/obj/structure/disposalpipe/crossZ/down/F in T)
					P = F

		else
			T = get_step(src.loc, H.dir)
			P = H.findpipe(T)

		if(P)
			// find other holder in next loc, if inactive merge it with current
			var/obj/structure/disposalholder/H2 = locate() in P
			if(H2 && !H2.active)
				H.merge(H2)

			H.loc = P
		else			// if wasn't a pipe, then set loc to turf
			H.loc = T
			return null

		return P

/obj/structure/disposalpipe/crossZ/down
	icon_state = "pipe-d"

	New()
		..()
		dpdir = dir
		update()
		return

	nextdir(var/fromdir)
		var/nextdir
		if(fromdir == 12)
			nextdir = dir
		else
			nextdir = 11
		return nextdir

	transfer(var/obj/structure/disposalholder/H)
		var/nextdir = nextdir(H.dir)
		H.dir = nextdir

		var/turf/T
		var/obj/structure/disposalpipe/P

		if(nextdir == 11)
			var/turf/controllerlocation = locate(1, 1, src.z)
			for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
				if(controller.down)
					T = locate(src.x, src.y, controller.down_target)
			if(!T)
				H.loc = src.loc
				return
			else
				for(var/obj/structure/disposalpipe/crossZ/up/F in T)
					P = F

		else
			T = get_step(src.loc, H.dir)
			P = H.findpipe(T)

		if(P)
			// find other holder in next loc, if inactive merge it with current
			var/obj/structure/disposalholder/H2 = locate() in P
			if(H2 && !H2.active)
				H.merge(H2)

			H.loc = P
		else			// if wasn't a pipe, then set loc to turf
			H.loc = T
			return null

		return P
///// Z-Level stuff