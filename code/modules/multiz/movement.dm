var/vessel_type = "station"

/client/proc/AIMoveZ(direct, var/mob/living/silicon/ai/user)

	var/initial = initial(user.sprint)
	var/turf/controllerlocation = locate(1, 1, user.eyeobj.z)
	if(user.cooldown && user.cooldown < world.timeofday) // 3 seconds
		user.sprint = initial
	for(var/i = 0; i < max(user.sprint, initial); i += 20)
		switch(direct)
			if (UP)
				for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
					if (controller.up)
						var/turf/T = locate(user.eyeobj.x, user.eyeobj.y, controller.up_target)
						user.eyeobj.setLoc(T)
			if (DOWN)
				for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
					if (controller.down)
						var/turf/T = locate(user.eyeobj.x, user.eyeobj.y, controller.down_target)
						user.eyeobj.setLoc(T)


	user.cooldown = world.timeofday + 5

	user.cameraFollow = null

/obj/item/weapon/tank/jetpack/proc/move_z(cardinal, mob/user as mob)
	if(allow_thrust(0.01, user))
		var/turf/controllerlocation = locate(1, 1, usr.z)
		switch(cardinal)
			if (UP) // Going up!
				for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
					if (controller.up)
						var/turf/T = locate(usr.x, usr.y, controller.up_target)
						// You can only jetpack up if there's space above, and you're sitting on either hull (on the exterior), or space
						//if(T && istype(T, /turf/space) && (istype(user.loc, /turf/space) || istype(user.loc, /turf/space/*/hull*/)))
						//check through turf contents to make sure there's nothing blocking the way
						if(T && (istype(T, /turf/space) || istype(T, /turf/simulated/floor/open)))
							var/blocked = 0
							for(var/atom/A in T.contents)
								if(T.density)
									blocked = 1
									user << "\red You bump into [T.name]."
									break
							if(!blocked)
								user.Move(T)
						else
							user << "\red You bump into the [vessel_type]'s plating."
					else
						user << "\red The [vessel_type]'s gravity well keeps you in orbit!"

			if (DOWN) // Going down!
				for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
					if (controller.down == 1)
						var/turf/T = locate(usr.x, usr.y, controller.down_target)
					// You can only jetpack down if you're sitting on space and there's space down below, or hull
						if(T && (!T.density) && (istype(user.loc, /turf/space) || istype(user.loc, /turf/simulated/floor/open)))
							var/blocked = 0
							for(var/atom/A in T.contents)
								if(T.density)
									blocked = 1
									user << "\red You bump into [T.name]."
									break
							if(!blocked)
								user.Move(T)
						else
							user << "\red You bump into the [vessel_type]'s plating."
					else
						user << "\red The [vessel_type]'s gravity well keeps you in orbit!"

/obj/item/weapon/extinguisher/proc/move_z(cardinal, mob/user as mob)
	if(src.reagents.total_volume >= 1)
		playsound(src.loc, 'sound/effects/extinguish.ogg', 75, 1, -3)
		var/obj/effect/effect/water/W = PoolOrNew( /obj/effect/effect/water, get_turf(src) )
		var/datum/reagents/R = new/datum/reagents(5)
		if(!W) return
		W.reagents = R
		R.my_atom = W
		src.reagents.trans_to(W,1)
		var/turf/controllerlocation = locate(1, 1, usr.z)
		switch(cardinal)
			if (UP) // Going up!
				for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
					if (controller.up)
						var/turf/T = locate(usr.x, usr.y, controller.up_target)
						// You can only jetpack up if there's space above, and you're sitting on either hull (on the exterior), or space
						//if(T && istype(T, /turf/space) && (istype(user.loc, /turf/space) || istype(user.loc, /turf/space/*/hull*/)))
						//check through turf contents to make sure there's nothing blocking the way
						if(T && (istype(T, /turf/space) || istype(T, /turf/simulated/floor/open)))
							var/blocked = 0
							for(var/atom/A in T.contents)
								if(T.density)
									blocked = 1
									user << "\red You bump into [T.name]."
									break
							if(!blocked)
								user.Move(T)
						else
							user << "\red You bump into the [vessel_type]'s plating."
					else
						user << "\red The [vessel_type]'s gravity well keeps you in orbit!"

			if (DOWN) // Going down!
				for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
					if (controller.down == 1)
						var/turf/T = locate(usr.x, usr.y, controller.down_target)
					// You can only jetpack down if you're sitting on space and there's space down below, or hull
						if(T && (!T.density) && (istype(user.loc, /turf/space) || istype(user.loc, /turf/simulated/floor/open)))
							var/blocked = 0
							for(var/atom/A in T.contents)
								if(T.density)
									blocked = 1
									user << "\red You bump into [T.name]."
									break
							if(!blocked)
								user.Move(T)
						else
							user << "\red You bump into the [vessel_type]'s plating."
					else
						user << "\red The [vessel_type]'s gravity well keeps you in orbit!"

