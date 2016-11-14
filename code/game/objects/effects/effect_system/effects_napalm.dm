//NAPALM EFFECTS

/obj/effect/effect/napalm
	name = "napalm"
	icon = 'icons/effects/effects.dmi'
	icon_state = "BMF"
	var/life = 15.0
	mouse_opacity = 0


/obj/effect/effect/napalm/New()
	..()
	spawn( 70 )
		qdel(src)

/obj/effect/effect/napalm/Move(turf/newloc)
	if (--src.life < 1)
		qdel(src)
		return 0
	if(newloc.density)
		return 0
	.=..()

/obj/effect/effect/napalm/Bump(atom/A)
	if(reagents)
		reagents.reaction(A)
	return ..()

//	adjust_fire_stacks
