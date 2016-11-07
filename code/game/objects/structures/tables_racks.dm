/* Tables and Racks
 * Contains:
 *		Tables
 *		Glass Tables
 *		Wooden Tables
 *		Reinforced Tables
 *		Racks
 *		Rack Parts
 */

/*
 * Tables
 */

/obj/structure/table
	name = "table"
	desc = "A square piece of metal standing on four metal legs. It can not move."
	icon = 'icons/obj/structures.dmi'
	icon_state = "table"
	density = 1
	anchored = 1.0
	layer = 2.8
	throwpass = 1	//You can throw objects over this, despite it's density.")
	var/parts = /obj/item/weapon/table_parts
	var/busy = 0
	var/buildstackamount = 1
	var/framestackamount = 2
	var/mob/tableclimber
	var/flipped = 0
	var/dented = 0
	var/health = 100


/obj/structure/table/New()
	..()
	for(var/obj/structure/table/T in src.loc)
		if(T != src)
			qdel(T)
	update_icon()
	for(var/direction in list(1,2,4,8,5,6,9,10))
		if(locate(/obj/structure/table,get_step(src,direction)))
			var/obj/structure/table/T = locate(/obj/structure/table,get_step(src,direction))
			T.update_icon()

/obj/structure/table/Destroy()
	for(var/direction in list(1,2,4,8,5,6,9,10))
		if(locate(/obj/structure/table,get_step(src,direction)))
			var/obj/structure/table/T = locate(/obj/structure/table,get_step(src,direction))
			T.update_icon()
	..()

/obj/structure/table/update_icon()
	spawn(2) //So it properly updates when deleting
		if(flipped)
			var/type = 0
			var/tabledirs = 0
			for(var/direction in list(turn(dir,90), turn(dir,-90)) )
				var/obj/structure/table/T = locate(/obj/structure/table,get_step(src,direction))
				if (T && T.flipped && T.dir == src.dir)
					type++
					tabledirs |= direction
			var/base = "table"
			if (istype(src, /obj/structure/table/wood))
				base = "wood"
			if (istype(src, /obj/structure/table/reinforced))
				base = "rtable"

			icon_state = "[base]flip[type]"
			if (type==1)
				if (tabledirs & turn(dir,90))
					icon_state = icon_state+"-"
				if (tabledirs & turn(dir,-90))
					icon_state = icon_state+"+"
			return 1



		var/dir_sum = 0
		for(var/direction in list(1,2,4,8,5,6,9,10))
			var/skip_sum = 0
			for(var/obj/structure/window/W in src.loc)
				if(W.dir == direction) //So smooth tables don't go smooth through windows
					skip_sum = 1
					continue
			var/inv_direction //inverse direction
			switch(direction)
				if(1)
					inv_direction = 2
				if(2)
					inv_direction = 1
				if(4)
					inv_direction = 8
				if(8)
					inv_direction = 4
				if(5)
					inv_direction = 10
				if(6)
					inv_direction = 9
				if(9)
					inv_direction = 6
				if(10)
					inv_direction = 5
			for(var/obj/structure/window/W in get_step(src,direction))
				if(W.dir == inv_direction) //So smooth tables don't go smooth through windows when the window is on the other table's tile
					skip_sum = 1
					continue
			if(!skip_sum) //means there is a window between the two tiles in this direction
				if(locate(/obj/structure/table,get_step(src,direction)))
					if(direction <5)
						dir_sum += direction
					else
						if(direction == 5)	//This permits the use of all table directions. (Set up so clockwise around the central table is a higher value, from north)
							dir_sum += 16
						if(direction == 6)
							dir_sum += 32
						if(direction == 8)	//Aherp and Aderp.  Jezes I am stupid.  -- SkyMarshal
							dir_sum += 8
						if(direction == 10)
							dir_sum += 64
						if(direction == 9)
							dir_sum += 128

		var/table_type = 0 //stand_alone table
		if(dir_sum%16 in cardinal)
			table_type = 1 //endtable
			dir_sum %= 16
		if(dir_sum%16 in list(3,12))
			table_type = 2 //1 tile thick, streight table
			if(dir_sum%16 == 3) //3 doesn't exist as a dir
				dir_sum = 2
			if(dir_sum%16 == 12) //12 doesn't exist as a dir.
				dir_sum = 4
		if(dir_sum%16 in list(5,6,9,10))
			if(locate(/obj/structure/table,get_step(src.loc,dir_sum%16)))
				table_type = 3 //full table (not the 1 tile thick one, but one of the 'tabledir' tables)
			else
				table_type = 2 //1 tile thick, corner table (treated the same as streight tables in code later on)
			dir_sum %= 16
		if(dir_sum%16 in list(13,14,7,11)) //Three-way intersection
			table_type = 5 //full table as three-way intersections are not sprited, would require 64 sprites to handle all combinations.  TOO BAD -- SkyMarshal
			switch(dir_sum%16)	//Begin computation of the special type tables.  --SkyMarshal
				if(7)
					if(dir_sum == 23)
						table_type = 6
						dir_sum = 8
					else if(dir_sum == 39)
						dir_sum = 4
						table_type = 6
					else if(dir_sum == 55 || dir_sum == 119 || dir_sum == 247 || dir_sum == 183)
						dir_sum = 4
						table_type = 3
					else
						dir_sum = 4
				if(11)
					if(dir_sum == 75)
						dir_sum = 5
						table_type = 6
					else if(dir_sum == 139)
						dir_sum = 9
						table_type = 6
					else if(dir_sum == 203 || dir_sum == 219 || dir_sum == 251 || dir_sum == 235)
						dir_sum = 8
						table_type = 3
					else
						dir_sum = 8
				if(13)
					if(dir_sum == 29)
						dir_sum = 10
						table_type = 6
					else if(dir_sum == 141)
						dir_sum = 6
						table_type = 6
					else if(dir_sum == 189 || dir_sum == 221 || dir_sum == 253 || dir_sum == 157)
						dir_sum = 1
						table_type = 3
					else
						dir_sum = 1
				if(14)
					if(dir_sum == 46)
						dir_sum = 1
						table_type = 6
					else if(dir_sum == 78)
						dir_sum = 2
						table_type = 6
					else if(dir_sum == 110 || dir_sum == 254 || dir_sum == 238 || dir_sum == 126)
						dir_sum = 2
						table_type = 3
					else
						dir_sum = 2 //These translate the dir_sum to the correct dirs from the 'tabledir' icon_state.
		if(dir_sum%16 == 15)
			table_type = 4 //4-way intersection, the 'middle' table sprites will be used.
		switch(table_type)
			if(0)
				icon_state = "[initial(icon_state)]"
			if(1)
				icon_state = "[initial(icon_state)]_1tileendtable"
			if(2)
				icon_state = "[initial(icon_state)]_1tilethick"
			if(3)
				icon_state = "[initial(icon_state)]_dir"
			if(4)
				icon_state = "[initial(icon_state)]_middle"
			if(5)
				icon_state = "[initial(icon_state)]_dir2"
			if(6)
				icon_state = "[initial(icon_state)]_dir3"
		if (dir_sum in list(1,2,4,8,5,6,9,10))
			dir = dir_sum
		else
			dir = 2

/obj/structure/table/ex_act(severity, target)
	..()
	if(severity == 3)
		if(prob(25))
			if(istype(src, /obj/structure/table/reinforced))
				new /obj/item/weapon/table_parts/reinforced(loc)
			else if(istype(src, /obj/structure/table/wood))
				new/obj/item/weapon/table_parts/wood(loc)
			else if(istype(src, /obj/structure/table/glass))
				new/obj/item/weapon/shard(loc)
				new/obj/item/weapon/shard(loc)
				new/obj/item/stack/rods(loc)
			else
				new /obj/item/weapon/table_parts(loc)
			qdel(src)
			return

/obj/structure/table/blob_act()
	if(prob(75))
		if(istype(src, /obj/structure/table/reinforced))
			new /obj/item/weapon/table_parts/reinforced(loc)
		else if(istype(src, /obj/structure/table/wood))
			new/obj/item/weapon/table_parts/wood(loc)
		else if(istype(src, /obj/structure/table/glass))
			new/obj/item/weapon/shard(loc)
			new/obj/item/weapon/shard(loc)
			new/obj/item/stack/rods(loc)
		else
			new /obj/item/weapon/table_parts(loc)
		qdel(src)
		return

/obj/structure/table/attack_alien(mob/living/user)
	user.do_attack_animation(src)
	playsound(src.loc, 'sound/weapons/bladeslice.ogg', 50, 1)
	visible_message("<span class='danger'>[user] slices [src] apart!</span>")
	table_destroy(1, user)

/obj/structure/table/attack_animal(mob/living/simple_animal/user)
	if(user.environment_smash)
		user.do_attack_animation(src)
		playsound(src.loc, 'sound/weapons/Genhit.ogg', 50, 1)
		visible_message("<span class='danger'>[user] smashes [src] apart!</span>")
		table_destroy(1, user)

/obj/structure/table/attack_paw(mob/user)
	attack_hand(user)

/obj/structure/table/attack_hulk(mob/living/carbon/human/user)
	..(user, 1)
	visible_message("<span class='danger'>[user] smashes [src] apart!</span>")
	playsound(src.loc, 'sound/effects/bang.ogg', 50, 1)
	user.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ))
	table_destroy(1, user)
	return 1

/obj/structure/table/attack_hand(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	if(tableclimber && tableclimber != user)
		tableclimber.Weaken(2)
		tableclimber.visible_message("<span class='warning'>[tableclimber.name] has been knocked off the table", "You're knocked off the table!", "You see [tableclimber.name] get knocked off the table</span>")


/obj/structure/table/attack_tk() // no telehulk sorry
	return

/obj/structure/table/CanPass(atom/movable/mover, turf/target, height=0)
	if(height==0) return 1

	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	else
		return 0

/obj/structure/table/MouseDrop_T(atom/movable/O, mob/user)
	if(ismob(O) && user == O && ishuman(user))
		if(user.canmove)
			climb_table(user)
			return
	if ((!( istype(O, /obj/item/weapon) ) || user.get_active_hand() != O))
		return
	if(isrobot(user))
		return
	if(!user.drop_item())
		return
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/structure/table/proc/tablepush(obj/item/I, mob/user)
	if(get_dist(src, user) < 2)
		var/obj/item/weapon/grab/G = I
		if(G.affecting.buckled)
			user << "<span class='warning'>[G.affecting] is buckled to [G.affecting.buckled]!</span>"
			return 0
		if(G.state < GRAB_AGGRESSIVE)
			user << "<span class='warning'>You need a better grip to do that!</span>"
			return 0
		if(!G.confirm())
			return 0
		G.affecting.loc = src.loc
		G.affecting.Weaken(5)
		G.affecting.visible_message("<span class='danger'>[G.assailant] pushes [G.affecting] onto [src].</span>", \
									"<span class='userdanger'>[G.assailant] pushes [G.affecting] onto [src].</span>")
		add_logs(G.assailant, G.affecting, "pushed")
		qdel(I)
		return 1
	qdel(I)

/obj/structure/table/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/weapon/grab))
		tablepush(I, user)
		return

	if (istype(I, /obj/item/weapon/wrench))
		table_destroy(2, user)
		return


	if (istype(I, /obj/item/weapon/storage/bag/tray))
		var/obj/item/weapon/storage/bag/tray/T = I
		if(T.contents.len > 0) // If the tray isn't empty
			var/list/obj/item/oldContents = T.contents.Copy()
			T.quick_empty()

			for(var/obj/item/C in oldContents)
				C.loc = src.loc

			user.visible_message("[user] empties [I] on [src].")
			return
		// If the tray IS empty, continue on (tray will be placed on the table like other items)

	if (istype(I, /obj/item/weapon/storage/bag/dicecup))
		if(I.contents.len > 0)
			return
		// If the dicebug IS empty, continue on  dicethrowing hapends in dicecup proc.


	if(isrobot(user))
		return

	if(!(I.flags & ABSTRACT)) //rip more parems rip in peace ;_;
		if(user.drop_item())
			I.Move(loc)
			var/list/click_params = params2list(params)
			//Center the icon where the user clicked.
			if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
				return
			//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
			I.pixel_x = Clamp(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
			I.pixel_y = Clamp(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)


/*
 * TABLE DESTRUCTION/DECONSTRUCTION
 */


/obj/structure/table/proc/table_destroy(var/destroy_type, var/mob/user)
	if(destroy_type == 1)
		user.visible_message("<span class='notice'>The table was sliced apart by [user]!</span>")
		new parts( src.loc )
		qdel(src)
		return

	if(destroy_type == 2)
		if(istype(src, /obj/structure/table/reinforced))
			var/obj/structure/table/reinforced/RT = src
			if(RT.status == 1)
				user << "<span class='notice'>Now disassembling the reinforced table</span>"
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				if (do_after(user, 50))
					new parts( src.loc )
					playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
					qdel(src)
				return
		else
			user << "<span class='notice'>Now disassembling table</span>"
			playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
			if (do_after(user, 50))
				new parts( src.loc )
				playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
				qdel(src)
			return

/*
 * TABLE CLIMBING
 */


/obj/structure/table/proc/climb_table(mob/user)
	src.add_fingerprint(user)
	user.visible_message("<span class='warning'>[user] is trying to climb on [src].</span>", \
								"<span class='notice'>You are trying to climb on [src].</span>")
	var/climb_time = 20
	if(user.restrained()) //Table climbing takes twice as long when restrained.
		climb_time *= 2
	tableclimber = user
	if(do_mob(user, user, climb_time))
		if(src.loc) //Checking if table has been destroyed
			user.pass_flags += PASSTABLE
			step(user,get_dir(user,src.loc))
			user.pass_flags -= PASSTABLE
			add_logs(user, src, "climbed onto")
			tableclimber = null
			return 1
	tableclimber = null
	return 0


/*
 * Glass tables
 */
/obj/structure/table/glass
	name = "glass table"
	desc = "What did I say about leaning on the glass tables? Now you need surgery."
	icon_state = "glass_table"
	parts = /obj/item/weapon/table_parts/glass
	burn_state = 0
	burntime = 20

/obj/structure/table/glass/tablepush(obj/item/I, mob/user)
	if(..())
		visible_message("<span class='warning'>[src] breaks!</span>")
		playsound(src.loc, "shatter", 50, 1)
		new/obj/item/weapon/shard(loc)
		new/obj/item/weapon/shard(loc)
		new/obj/item/stack/rods(loc)
		qdel(src)


/obj/structure/table/glass/climb_table(mob/user)
	if(..())
		visible_message("<span class='warning'>[src] breaks!</span>")
		playsound(src.loc, "shatter", 50, 1)
		new/obj/item/weapon/shard(loc)
		new/obj/item/weapon/shard(loc)
		new/obj/item/stack/rods(loc)
		qdel(src)
		user.Weaken(5)

/*
 * Wooden tables
 */

/obj/structure/table/wood
	name = "wooden table"
	desc = "Do not apply fire to this. Rumour says it burns easily."
	icon_state = "woodtable"
	parts = /obj/item/weapon/table_parts/wood
	burn_state = 0
	burntime = 30

/obj/structure/table/wood/poker //No specialties, Just a mapping object.
	name = "gambling table"
	desc = "A seedy table for seedy dealings in seedy places."
	icon_state = "pokertable"
	parts = /obj/item/weapon/table_parts/wood/poker

/*
 * Reinforced tables
 */
/obj/structure/table/reinforced
	name = "reinforced table"
	desc = "A reinforced version of the four legged table, much harder to simply deconstruct."
	icon_state = "reinftable"
	var/status = 2
	parts = /obj/item/weapon/table_parts/reinforced


/obj/structure/table/reinforced/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(0, user))
			if(src.status == 2)
				user << "<span class='info'>Now weakening the reinforced table</span>"
				playsound(src.loc, 'sound/items/Welder.ogg', 50, 1)
				if (do_after(user, 50))
					if(!src || !WT.isOn()) return
					user << "<span class='info'>Table weakened</span>"
					src.status = 1
			else
				user << "<span class='info'>Now strengthening the reinforced table</span>"
				playsound(src.loc, 'sound/items/Welder.ogg', 50, 1)
				if (do_after(user, 50))
					if(!src || !WT.isOn()) return
					user << "<span class='info'>Table strengthened</span>"
					src.status = 2
			return
	..()

/obj/structure/table/reinforced/attack_paw(mob/user)
	attack_hand(user)

/obj/structure/table/reinforced/attack_hulk(mob/living/carbon/human/user)
	..(user, 1)
	if(prob(75))
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
		user << text("<span class='notice'>You kick [src] into pieces.</span>")
		user.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ))
		table_destroy(1, user)
	else
		playsound(src, 'sound/effects/bang.ogg', 50, 1)
		user << text("<span class='notice'>You kick [src].</span>")
	return 1

/obj/structure/table/CtrlClick(var/mob/user)
	if(in_range(src,user))
		if(flipped)
			src.do_put()
		else
			src.do_flip()

/obj/structure/table/verb/do_flip()
	set name = "Flip table"
	set desc = "Flips a non-reinforced table"
	set category = "Object"
	set src in oview(1)
	if(ismouse(usr))
		return
	if (!can_touch(usr))
		return
	if(usr.weakened || usr.paralysis || usr.stat)
		return
	if(istype(src,/obj/structure/table/reinforced))
		usr << "<span class='notice'>It won't budge.</span>"
		return
	if(!flip(get_cardinal_dir(usr,src)))
		usr << "<span class='notice'>It wont't budge.</span>"
	else
		usr.visible_message("<span class='warning'>[usr] flips \a [src]!</span>")
		return

/obj/structure/table/proc/unflipping_check(var/direction)
	for(var/mob/M in oview(src,0))
		return 0

	var/list/L = list()
	if(direction)
		L.Add(direction)
	else
		L.Add(turn(src.dir,-90))
		L.Add(turn(src.dir,90))
	for(var/new_dir in L)
		var/obj/structure/table/T = locate() in get_step(src.loc,new_dir)
		if(T)
			if(T.flipped && T.dir == src.dir && !T.unflipping_check(new_dir))
				return 0
	return 1

/obj/structure/table/proc/do_put()
	set name = "Put table back"
	set desc = "Puts flipped table back"
	set category = "Object"
	set src in oview(1)

	if (!can_touch(usr))
		return

	if (!unflipping_check())
		usr << "<span class='notice'>It won't budge.</span>"
		return
	unflip()

/obj/structure/table/proc/flip(var/direction)
	if(src.type==/obj/structure/table/glass ||src.type==/obj/structure/table/holotable ||src.type==/obj/structure/table/wood/poker || src.type == /obj/structure/table/abductor )
		return 0

	if( !straight_table_check(turn(direction,90)) || !straight_table_check(turn(direction,-90)) )
		return 0

	verbs -=/obj/structure/table/verb/do_flip
	verbs +=/obj/structure/table/proc/do_put

	var/list/targets = list(get_step(src,dir),get_step(src,turn(dir, 45)),get_step(src,turn(dir, -45)))
	for (var/atom/movable/A in get_turf(src))
		if (!A.anchored)
			spawn(0)
				A.throw_at(pick(targets),1,1)

	dir = direction
	if(dir != NORTH)
		layer = 5
	flipped = 1
	flags |= ON_BORDER
	for(var/D in list(turn(direction, 90), turn(direction, -90)))
		var/obj/structure/table/T = locate() in get_step(src,D)
		if(T && !T.flipped)
			T.flip(direction)
	update_icon()
	update_adjacent()

	return 1

/obj/structure/table/proc/unflip()
	verbs -=/obj/structure/table/proc/do_put
	verbs +=/obj/structure/table/verb/do_flip

	layer = initial(layer)
	flipped = 0
	flags &= ~ON_BORDER
	for(var/D in list(turn(dir, 90), turn(dir, -90)))
		var/obj/structure/table/T = locate() in get_step(src.loc,D)
		if(T && T.flipped && T.dir == src.dir)
			T.unflip()
	update_icon()
	update_adjacent()

	return 1

/obj/structure/table/proc/update_adjacent()
	for(var/direction in list(1,2,4,8,5,6,9,10))
		if(locate(/obj/structure/table,get_step(src,direction)))
			var/obj/structure/table/T = locate(/obj/structure/table,get_step(src,direction))
			T.update_icon()

/obj/structure/table/proc/straight_table_check(var/direction)
	var/obj/structure/table/T
	for(var/angle in list(-90,90))
		T = locate() in get_step(src.loc,turn(direction,angle))
		if(T && !T.flipped)
			return 0
	T = locate() in get_step(src.loc,direction)
	if (!T || T.flipped)
		return 1
	if (istype(T,/obj/structure/table/reinforced/))
		var/obj/structure/table/reinforced/R = T
		if (R.status == 2)
			return 0
	return T.straight_table_check(direction)

/obj/structure/table/verb/can_touch(var/mob/user)
	if (!user)
		return 0
	if (user.stat)	//zombie goasts go away
		return 0
	if (issilicon(user))
		user << "<span class='notice'>You need hands for this.</span>"
		return 0
	return 1

/obj/structure/table/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(locate(/obj/structure/table) in mover.loc)
		return 1
	if(air_group || (height==0)) return 1
	if(istype(mover,/obj/item/projectile))
		return (check_cover(mover,target))
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	if (flipped)
		if (get_dir(loc, target) == dir)
			return !density
		else
			return 1
	return 0

//checks if projectile 'P' from turf 'from' can hit whatever is behind the table. Returns 1 if it can, 0 if bullet stops.
/obj/structure/table/proc/check_cover(obj/item/projectile/P, turf/from)
	var/turf/cover = flipped ? get_turf(src) : get_step(loc, get_dir(from, loc))
	if (get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
		return 1
	if (get_turf(P.original) == cover)
		var/chance = 20
		if (ismob(P.original))
			var/mob/M = P.original
			if (M.lying)
				chance += 20				//Lying down lets you catch less bullets
		if(flipped)
			if(get_dir(loc, from) == dir)	//Flipped tables catch mroe bullets
				chance += 20
			else
				return 1					//But only from one side
		if(prob(chance))
			health -= P.damage/2
			if (health > 0)
				visible_message("<span class='warning'>[P] hits \the [src]!</span>")
				return 0
			else
				visible_message("<span class='warning'>[src] breaks down!</span>")
				Destroy()
				return 1
	return 1

/obj/structure/table/Destroy()
	update_adjacent()
	..()

/obj/structure/table/CheckExit(atom/movable/O as mob|obj, target as turf)
	if(istype(O) && O.checkpass(PASSTABLE))
		return 1
	if (flipped)
		if (get_dir(loc, target) == dir)
			return !density
		else
			return 1
	return 1


/*
 * Racks
 */
/obj/structure/rack
	name = "rack"
	desc = "Different from the Middle Ages version."
	icon = 'icons/obj/objects.dmi'
	icon_state = "rack"
	density = 1
	anchored = 1.0
	throwpass = 1	//You can throw objects over this, despite it's density.

/obj/structure/rack/ex_act(severity, target)
	switch(severity)
		if(1.0)
			qdel(src)
		if(2.0)
			if(prob(50))
				rack_destroy()
			else
				qdel(src)
		if(3.0)
			if(prob(25))
				rack_destroy()

/obj/structure/rack/blob_act()
	if(prob(75))
		qdel(src)
		return
	else if(prob(50))
		rack_destroy()
		return

/obj/structure/rack/CanPass(atom/movable/mover, turf/target, height=0)
	if(height==0) return 1
	if(src.density == 0) //Because broken racks -Agouri |TODO: SPRITE!|
		return 1
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	else
		return 0

/obj/structure/rack/MouseDrop_T(obj/O as obj, mob/user as mob)
	if ((!( istype(O, /obj/item/weapon) ) || user.get_active_hand() != O))
		return
	if(isrobot(user))
		return
	if(!user.drop_item())
		user << "<span class='warning'>\The [O] is stuck to your hand, you cannot put it in the rack!</span>"
		return
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/structure/rack/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	if (istype(W, /obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		rack_destroy()
		return

	if(isrobot(user))
		return
	if(!user.drop_item())
		user << "<span class='warning'>\The [W] is stuck to your hand, you cannot put it in the rack!</span>"
		return
	W.Move(loc)
	return 1


/obj/structure/rack/attack_paw(mob/living/user)
	attack_hand(user)

/obj/structure/rack/attack_hulk(mob/living/carbon/human/user)
	..(user, 1)
	rack_destroy()
	return 1


/obj/structure/rack/attack_alien(mob/living/user)
	user.do_attack_animation(src)
	visible_message("<span class='warning'>[user] slices [src] apart.</span>")
	rack_destroy()


/obj/structure/rack/attack_animal(mob/living/simple_animal/user)
	if(user.environment_smash)
		user.do_attack_animation(src)
		visible_message("<span class='warning'>[user] smashes [src] apart.</span>")
		rack_destroy()

/obj/structure/rack/attack_tk() // no telehulk sorry
	return


/*
 * Rack destruction
 */

/obj/structure/rack/proc/rack_destroy()
	density = 0
	var/obj/item/weapon/rack_parts/newparts = new(loc)
	transfer_fingerprints_to(newparts)
	qdel(src)

