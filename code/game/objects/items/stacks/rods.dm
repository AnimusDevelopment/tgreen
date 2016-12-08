/obj/item/stack/rods
	name = "metal rod"
	desc = "Some rods. Can be used for building, or something."
	singular_name = "metal rod"
	icon_state = "rods"
	item_state = "rods"
	flags = CONDUCT
	w_class = 3.0
	force = 9.0
	throwforce = 10.0
	throw_speed = 3
	throw_range = 7
	materials = list(MAT_METAL=1000)
	m_amt = 1000
	max_amount = 60
	attack_verb = list("hit", "bludgeoned", "whacked")
	hitsound = 'sound/weapons/grenadelaunch.ogg'

/obj/item/stack/rods/New(var/loc, var/amount=null)
	..()

	update_icon()

/obj/item/stack/rods/update_icon()
	var/amount = get_amount()
	if((amount <= 5) && (amount > 0))
		icon_state = "rods-[amount]"
	else
		icon_state = "rods"

/obj/item/stack/rods/attackby(obj/item/W as obj, mob/user as mob, params)
	if (istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W

		if(get_amount() < 2)
			user << "<span class='warning'>You need at least two rods to do this!</span>"
			return

		if(WT.remove_fuel(0,user))
			var/obj/item/stack/sheet/metal/new_item = new(usr.loc)
			new_item.add_to_stacks(usr)
			user.visible_message("[user.name] shaped [src] into metal with the welding tool.", \
						 "<span class='notice'>You shape [src] into metal with the welding tool.</span>", \
						 "<span class='italics'>You hear welding.</span>")
			var/obj/item/stack/rods/R = src
			src = null
			var/replace = (user.get_inactive_hand()==R)
			R.use(2)
			if (!R && replace)
				user.put_in_hands(new_item)
		return

	if(istype(W,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/food/snacks/S = W
		if(amount != 1)
			user << "<span class='warning'>You must use a single rod!</span>"
		else if(S.w_class > 2)
			user << "<span class='warning'>The ingredient is too big for [src]!</span>"
		else
			var/obj/item/weapon/reagent_containers/food/snacks/customizable/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/kebab(get_turf(src))
			A.initialize_custom_food(src, S, user)
		return
	..()

/obj/item/stack/rods/cyborg/
	m_amt = 0
	is_cyborg = 1
	cost = 250

/obj/item/stack/rods/cyborg/update_icon()
	return


/obj/item/stack/rods/attack_self(mob/user as mob)
	src.add_fingerprint(user)

	if(!istype(user.loc,/turf)) return 0

	if (locate(/obj/structure/grille, usr.loc))
		for(var/obj/structure/grille/G in usr.loc)
			if (G.destroyed)
				G.health = 10
				G.density = 1
				G.destroyed = 0
				G.icon_state = "grille"
				use(1)
			else
				return 1
	else
		if(get_amount() < 2)
			user << "<span class='info'>You need at least two rods to do this.</span>"
			return

		usr << "<span class='info'>Assembling grille...</span>"
		if (!do_after(usr, 10))
			return
		var/obj/structure/grille/F = new /obj/structure/grille/ ( usr.loc )
		usr << "<span class='info'>You assemble a grille</span>"
		F.add_fingerprint(usr)
		use(2)
	return