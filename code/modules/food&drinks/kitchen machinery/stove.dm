/obj/machinery/stove
	name = "stove"
	desc = "An old ways to grill your meat."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "stove_closed"
	layer = 2.9
	density = 1
	anchored = 1
	use_power = 0
	idle_power_usage = 0
	var/ignition = FALSE
	var/opened = FALSE
	var/fuel = 0
	var/ash = 0
	var/max_capasity = 15000
	var/brightness = 0
	var/ignition_chance = 0
	var/cooking = 0
	var/cooking_space = 3
	var/mob/hiden_body
	var/list/grill = null

/obj/machinery/stove/New()
	..()
	grill = list()

/obj/machinery/stove/proc/updateicon()
	src.overlays.Cut()
	if(opened)
		if(fuel <= 0)
			icon_state = "stove_empty"
		else if (ignition)
			icon_state = "stove_ingited"
		else
			icon_state = "stove_full"
	else
		icon_state = "stove_closed"

	if(ignition)
		overlays += "stove_smoke+o"

	if(cooking > 0)
		if(ignition)
			overlays += "stove_pan_cooking+o"
		else
			overlays += "stove_pan+o"

/obj/machinery/stove/proc/fuel_capasity()
	if (hiden_body)
		return max(0, max_capasity - ash - 7500)
	else
		return max(0, max_capasity - ash)

/obj/machinery/stove/proc/fuel_fill_stage(stage)
	if(stage == 0)
		return 0
	else if (stage == 1)
		return fuel_capasity() / 30
	else if (stage == 2)
		return fuel_capasity() / 10
	else if (stage == 3)
		return fuel_capasity() / 2
	else if (stage == 4)
		return (fuel_capasity() / 5) * 4
	else if (stage == 5)
		return (fuel_capasity() / 10) * 9
	else if (stage == 6)
		return (fuel_capasity() / 30) * 29
	else if (stage == 7)
		return fuel_capasity()
	else
		return -1

/obj/machinery/stove/proc/get_burnspeed()
	if(fuel < fuel_fill_stage(1))
		return 1
	else if(fuel < fuel_fill_stage(2))
		return 7
	else if(fuel < fuel_fill_stage(3))
		return 8
	else if(fuel < fuel_fill_stage(4))
		return 12
	else if(fuel < fuel_fill_stage(5))
		return 16
	else if(fuel < fuel_fill_stage(6))
		return 20
	else
		return 2

/obj/machinery/stove/proc/get_brightness()
	if(!ignition)
		return 0
	if(fuel < fuel_fill_stage(1))
		return 1
	else if(fuel < fuel_fill_stage(4))
		return 6
	else if(fuel < fuel_fill_stage(6))
		return 8
	else
		return 2

/obj/machinery/stove/proc/get_smokechanse()
	if(ash < max_capasity / 30)
		if(fuel < fuel_fill_stage(1))
			return 0
		else if(fuel < fuel_fill_stage(6))
			return 10
		else
			return 25
	else if(ash < max_capasity / 10)
		if(fuel < fuel_fill_stage(1))
			return 0
		else if(fuel < fuel_fill_stage(5))
			return 10
		else if(fuel < fuel_fill_stage(6))
			return 15
		else
			return 40
	else if(ash < max_capasity / 2)
		if(fuel < fuel_fill_stage(1))
			return 0
		else if(fuel < fuel_fill_stage(4))
			return 10
		else if(fuel < fuel_fill_stage(6))
			return 15
		else
			return 60
	else if(ash < (max_capasity / 4) * 3)
		if(fuel < fuel_fill_stage(1))
			return 5
		else if(fuel < fuel_fill_stage(4))
			return 15
		else if(fuel < fuel_fill_stage(6))
			return 25
		else
			return 60
	else if (ash < (max_capasity / 10) * 9)
		if(fuel < fuel_fill_stage(1))
			return 10
		else if(fuel < fuel_fill_stage(4))
			return 20
		else if(fuel < fuel_fill_stage(6))
			return 50
		else
			return 100

/obj/machinery/stove/Deconstruct()
	if(!loc) //if already qdel'd somehow, we do nothing
		return
	var/obj/item/stack/sheet/metal/stored = new/obj/item/stack/sheet/metal(loc)
	stored.amount = 10
	..()

/obj/machinery/stove/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/stove/attack_ai(mob/user as mob)
	return 0

/obj/machinery/stove/attack_hand(mob/user as mob)
	if (opened)
		user.visible_message( \
			"[user] has closed [src].", \
			"<span class='notice'>You close [src].</span>")
		opened = FALSE
		src.updateicon()
		return
	else
		user.visible_message( \
			"[user] has opened [src].", \
			"<span class='notice'>You open [src].</span>")
		opened = TRUE
		src.updateicon()
		return

/obj/machinery/stove/attackby(obj/item/I, mob/user)
	if(opened)
		//ignite stove
		if(is_hot(I) > 0 || (ignition_chance >= 40 && istype(I, /obj/item/device/assembly/igniter)))
			if(fuel > 0)
				if(ignition )
					user << "<span class='notice'>[src] is already lit.</span>"
				else if(!anchored)
					user << "<span class='notice'>You can not lit [src] while it`s unfastened.</span>"
				else
					user << "<span class='notice'>You start liting [src].</span>"
					if(do_after(user, 50))
						if(prob(Clamp(50 + ignition_chance, 5, 100)))
							ignition_chance = 0
							ignition = TRUE
							src.updateicon()
							user.visible_message( \
								"[user] lights up [src].", \
								"<span class='notice'>You lights up [src].</span>")
						else
							user << "<span class='notice'>You fail to light up [src].</span>"
			else
				user << "<span class='notice'>[src] has no fuel in it.</span>"
		//ignite item
		if(ignition)
			I.fire_act()
		//stuff people
		if(istype(I, /obj/item/weapon/grab))
			body_hide(I, user)
			return
		//add fuel
		if(istype(I, /obj/item/stack/sheet/mineral/wood))
			var/obj/item/stack/St = I
			if (fuel + 1000 < fuel_capasity())
				if (St.use(1))  //sanyty check
					fuel = fuel + 1000
					src.updateicon()
					user.visible_message( \
						"[user] add [St] to the [src].", \
						"<span class='notice'>You add [St] to the [src].</span>")
			else
				user << "<span class='notice'>There not enogh spase for [St] in the [src].</span>"
			return
		if(istype(I, /obj/item/stack/sheet/cardboard))
			var/obj/item/stack/St = I
			if (fuel + 75 < fuel_capasity())
				if (St.use(1))  //sanyty check
					fuel = fuel + 75
					ignition_chance += 3
					src.updateicon()
					user.visible_message( \
						"[user] add [St] to the [src].", \
						"<span class='notice'>You add [St] to the [src].</span>")
			else
				user << "<span class='notice'>There not enogh spase for [St] in the [src].</span>"
			return
		if(istype(I, /obj/item/stack/sheet/cloth))
			var/obj/item/stack/St = I
			if (fuel + 300 < fuel_capasity())
				if (St.use(1))  //sanyty check
					fuel = fuel + 300
					ignition_chance += 10
					src.updateicon()
					user.visible_message( \
						"[user] add [St] to the [src].", \
						"<span class='notice'>You add [St] to the [src].</span>")
			else
				user << "<span class='notice'>There not enogh spase for [St] in the [src].</span>"
			return
		if(istype(I, /obj/item/stack/tile/wood))
			var/obj/item/stack/St = I
			if (fuel + 250 < fuel_capasity())
				if (St.use(1))  //sanyty check
					fuel = fuel + 250
					src.updateicon()
					user.visible_message( \
						"[user] add [St] to the [src].", \
						"<span class='notice'>You add [St] to the [src].</span>")
			else
				user << "<span class='notice'>There not enogh spase for [St] in the [src].</span>"
			return
		if(istype(I, /obj/item/stack/tile/carpet))
			var/obj/item/stack/St = I
			if (fuel + 100 < fuel_capasity())
				if (St.use(1))  //sanyty check
					fuel = fuel + 100
					src.updateicon()
					user.visible_message( \
						"[user] add [St] to the [src].", \
						"<span class='notice'>You add [St] to the [src].</span>")
			else
				user << "<span class='notice'>There not enogh spase for [St] in the [src].</span>"
			return
		if(istype(I, /obj/item/stack/tile/grass))
			var/obj/item/stack/St = I
			if (fuel + 50 < fuel_capasity())
				if (St.use(1))  //sanyty check
					fuel = fuel + 50
					ignition_chance -= 2
					src.updateicon()
					user.visible_message( \
						"[user] add [St] to the [src].", \
						"<span class='notice'>You add [St] to the [src].</span>")
			else
				user << "<span class='notice'>There not enogh spase for [St] in the [src].</span>"
			return
		else if(istype(I, /obj/item/weapon/grown/log))
			var/obj/item/weapon/grown/L = I
			if (fuel + 1000 + L.potency * 40 < fuel_capasity())
				fuel = fuel + 1000 + L.potency * 40
				ignition_chance -= 1
				src.updateicon()
				user.visible_message( \
					"[user] add [L] to the [src].", \
					"<span class='notice'>You add [L] to the [src].</span>")
				user.drop_item()
				qdel(L)
			else
				user << "<span class='notice'>There not enogh spase for [L] in the [src].</span>"
			return
		else if(istype(I, /obj/item/weapon/reagent_containers/food/snacks/grown/carpet))
			var/obj/item/weapon/reagent_containers/food/snacks/grown/L = I
			if (fuel + 100 + L.potency * 2 < fuel_capasity())
				fuel = fuel + 100 + L.potency * 2
				if(!L.dry)
					ignition_chance -= 3
				src.updateicon()
				user.visible_message( \
					"[user] add [L] to the [src].", \
					"<span class='notice'>You add [L] to the [src].</span>")
				user.drop_item()
				qdel(L)
			else
				user << "<span class='notice'>There not enogh spase for [L] in the [src].</span>"
			return
		else if(istype(I, /obj/item/weapon/reagent_containers/food/snacks/grown/grass))
			var/obj/item/weapon/reagent_containers/food/snacks/grown/L = I
			if (fuel + 50 + L.potency < fuel_capasity())
				fuel = fuel + 50 + L.potency
				if(!L.dry)
					ignition_chance -= 10
				else
					ignition_chance += 5
				src.updateicon()
				user.visible_message( \
					"[user] add [L] to the [src].", \
					"<span class='notice'>You add [L] to the [src].</span>")
				user.drop_item()
				qdel(L)
			else
				user << "<span class='notice'>There not enogh spase for [L] in the [src].</span>"
			return
		else if(istype(I, /obj/item/weapon/paper))
			if (fuel + 50 < fuel_capasity())
				fuel = fuel + 50
				ignition_chance += 15
				src.updateicon()
				user.visible_message( \
					"[user] add [I] to the [src].", \
					"<span class='notice'>You add [I] to the [src].</span>")
				user.drop_item()
				qdel(I)
			else
				user << "<span class='notice'>There not enogh spase for [I] in the [src].</span>"
			return
		else if(istype(I, /obj/item/weapon/book))
			if (fuel + 250 < fuel_capasity())
				fuel = fuel + 250
				ignition_chance += 15
				src.updateicon()
				user.visible_message( \
					"[user] add [I] to the [src].", \
					"<span class='notice'>You add [I] to the [src].</span>")
				user.drop_item()
				qdel(I)
			else
				user << "<span class='notice'>There not enogh spase for [I] in the [src].</span>"
			return
		else if(istype(I, /obj/item/weapon/contraband/poster))
			if (fuel + 75 < fuel_capasity())
				fuel = fuel + 75
				ignition_chance += 5
				src.updateicon()
				user.visible_message( \
					"[user] add [I] to the [src].", \
					"<span class='notice'>You add [I] to the [src].</span>")
				user.drop_item()
				qdel(I)
			else
				user << "<span class='notice'>There not enogh spase for [I] in the [src].</span>"
			return
		else if(istype(I, /obj/item/weapon/coin/plasma))
			if (fuel + 1000 < fuel_capasity())
				if (fuel + 5000 > fuel_capasity() | fuel + 3000 > fuel_fill_stage(6) )
					var/coin_use = alert(user, "You feel this may be waste of [I].", "Put [I] in [src]?", "Put it in", "Hold it")
					if(coin_use == "Hold it" || !in_range(src, user) || !src || !I || user.incapacitated())
						return
				fuel = min(fuel_fill_stage(6), fuel + 15000)
				ignition_chance += 9001
				src.updateicon()
				user.visible_message( \
					"[user] add [I] to the [src].", \
					"<span class='notice'>You add [I] to the [src].</span>")
				user.drop_item()
				qdel(I)
			else
				user << "<span class='notice'>There sure not enogh spase for [I] in the [src].</span>"
			return
		//maininstance
		else if(istype(I, /obj/item/weapon/crowbar) || istype(I, /obj/item/weapon/kitchen/fork) || istype(I, /obj/item/weapon/reagent_containers/glass/rag))
			if(hiden_body)
				user << "<span class='notice'>There is something inside. You try to remove it from [src]</span>"
				if (do_after(user, 100) && hiden_body)
					user << "<span class='notice'>You free [hiden_body].</span>"
					hiden_body.loc = get_turf(src)
					hiden_body = null

			if(ash <= 0)
				user << "<span class='notice'>[src] is already clean.</span>"
			else
				user.visible_message( \
					"[user] start cleaning [src].", \
					"<span class='notice'>You start cleaning [src].</span>")
				while (ash > 0)
					if (do_after(user, 10))
						if (ash > 500)
							if(prob(50))
								new	/obj/effect/decal/cleanable/ash(loc)
						ash = max(0, ash - 500)
					else
						break
				if(ash <= 1)
					user.visible_message( \
						"[user] finish cleaning [src].", \
						"<span class='notice'>You finish cleaning [src].</span>")
			return
		else if((istype(I, /obj/item/weapon/wrench)) && (istype(loc, /turf/simulated) || anchored))
			if(ignition)
				user << "<span class='notice'>You can not unfasten [src] while it`s ignited.</span>"
			else
				playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
				anchored = !anchored
				user.visible_message("<span class='notice'>[user] [anchored ? "fastens" : "unfastens"] [src].</span>", \
									 "<span class='notice'>You [anchored ? "fasten [src] to" : "unfasten [src] from"] the floor.</span>")
			return
		else if(istype(I, /obj/item/weapon/screwdriver))
			if(fuel > 0 || ash > 0)
				user << "<span class='notice'>[src] must be empty to disasemble.</span>"
				return
			playsound(loc, 'sound/items/Screwdriver.ogg', 100, 1)
			if (do_after(user, 50))
				Deconstruct()
			return
	else
		//grill some meat
		if(cooking >= cooking_space)
			user << "<span class='notice'>There no more spase on [src] for grilling.</span>"
			return
		if(istype(I, /obj/item/weapon/grab)||istype(I, /obj/item/tk_grab))
			user << "<span class='warning'>That isn't going to fit.</span>"
			return
		if(!ignition)
			user << "<span class='warning'>Start a flame first.</span>"
			return
		if(istype(I, /obj/item/weapon/reagent_containers/food/snacks/donkpocket) && !istype(I, /obj/item/weapon/reagent_containers/food/snacks/donkpocket/warm))
			user << "<span class='notice'>You put [I] onto [src].</span>"
			cooking += 1
			user.drop_item()
			I.loc = src
			src.grill.Add(I)
			cook_sleep(10)
			new /obj/item/weapon/reagent_containers/food/snacks/donkpocket/warm(get_turf(src))
			cooking -= 1
			src.grill.Remove(I)
			qdel(I)
			return


		user << "<span class='notice'>You put [I] onto [src].</span>"
		cooking += 1
		updateicon()
		user.drop_item()
		I.loc = src
		src.grill.Add(I)

		var/image/img = new(I.icon, I.icon_state)
		img.pixel_y = 5
		cook_sleep(40)
		img.color = "#C28566"
		cook_sleep(40)
		img.color = "#A34719"
		cook_sleep(10)

		cooking -= 1
		updateicon()

		if(istype(I, /obj/item/weapon/reagent_containers/))
			var/obj/item/weapon/reagent_containers/food = I
			food.reagents.add_reagent("nutriment", 10)
			food.reagents.trans_to(I, food.reagents.total_volume)
		I.loc = get_turf(src)
		I.color = "#A34719"
		var/tempname = I.name
		I.name = "grilled [tempname]"
		src.grill.Remove(I)

obj/machinery/stove/proc/cook_sleep(var/periods)  // 1 period is from 100 tiks in lowest burnspeed to 5 in hiest
	while(periods > 0)
		sleep(round(100/get_burnspeed()))
		periods -= 1

obj/machinery/stove/process()
	if(fuel <= 0)
		ignition = FALSE
		src.updateicon()
	if(ignition)
		//smoke slouds
		if(prob(2))
			if(prob(src.get_smokechanse()))
				new /obj/effect/effect/chem_smoke(loc)
		//products of combustion generation
		if(prob(33))
			ash = min(max_capasity, ash + src.get_burnspeed())
		//fuel burn
		fuel = max(0, fuel - src.get_burnspeed())
		//light
		if(src.get_brightness() != src.brightness)
			src.brightness = src.get_brightness()
			SetLuminosity(src.brightness)
		// gas heating. taken fron spase_heater
		var/turf/simulated/L = loc
		if(istype(L))
			var/datum/gas_mixture/env = L.return_air()
			var/burnpower = src.get_burnspeed()
			if(env.temperature < (293.15 + burnpower)) //293.15 = 20C in kelvin

				var/transfer_moles = 0.25 * env.total_moles()

				var/datum/gas_mixture/removed = env.remove(transfer_moles)

				if(removed)

					var/heat_capacity = removed.heat_capacity()
					if(heat_capacity == 0 || heat_capacity == null) // Added check to avoid divide by zero (oshi-) runtime errors
						heat_capacity = 1
					removed.temperature = min((removed.temperature*heat_capacity + (burnpower * burnpower * 100))/heat_capacity, 1000) // Added min() check to try and avoid wacky superheating issues in low gas scenarios

				env.merge(removed)
				air_update_turf()
		//hiding in burnng stove isn`t a good idea, is it?
		if(hiden_body)
			if(isliving(hiden_body))
				var/mob/living/H = hiden_body
				H.take_overall_damage(0, 1)
	return

obj/machinery/stove/examine(mob/user)
	var/msg = src.desc
	msg += "\n"
	if (ash > 0)
		if(ash < max_capasity / 15)
			msg += "It's kinda dirty.\n"
		else if(ash < max_capasity / 2)
			msg += "It may be a good idea to clean [src] up.\n"
		else if(ash < (max_capasity / 5) * 4)
			msg += "There are quite a lot of the products of combustion.\n"
		else if(ash < max_capasity)
			msg += "[src] is almost filled with ash.\n"
		else
			msg += "[src] is filled whith ash up to its limit.\n"
	if (fuel > 0)
		if(fuel < fuel_fill_stage(1))
			msg += "[src] has very few fuel fuel.\n"
		else if(fuel < fuel_fill_stage(3))
			msg += "[src] has enogh fuel to burn.\n"
		else if(fuel < fuel_fill_stage(6))
			msg += "[src] has quite a lot of fuel.\n"
		else if(fuel <= fuel_fill_stage(7))
			msg += "[src] is is almost filled with fuel.\n"
		else
			msg += "[src] somehow seems bigger then it shoud be.\n"

	if (cooking > 0)
		var/i = 0
		for(var/obj/item/F in grill)
			msg += "[F] is[i ? " also " : " "]layng on the dripping pan.\n"
			i += 1

	if (src.hiden_body && prob(20))
		msg += "It looks like there [src.hiden_body] in [src].\n"
	user << msg

obj/machinery/stove/proc/body_hide(obj/item/I, mob/user)
	if(get_dist(src, user) < 2)
		var/obj/item/weapon/grab/G = I
		if(G.affecting.buckled)
			user << "<span class='warning'>[G.affecting] is buckled to [G.affecting.buckled]!</span>"
			return 0
		if(G.state < GRAB_AGGRESSIVE)
			user << "<span class='warning'>You need a better grip to do that!</span>"
			return 0
		if(fuel_capasity() - fuel < 7500)
			user << "<span class='warning'>There not enogh space in [src] to do that!</span>"
			return 0
		if(src.hiden_body)
			user << "<span class='warning'>There already [src.hiden_body] in [src].</span>"
			return 0
		if(!G.confirm())
			return 0
		user << "<span class='notice'>You start stuufing [G.affecting] into [src].</span>"
		if (do_after(user, 50))

			G.affecting.loc = src
			src.hiden_body = G.affecting
			G.affecting.visible_message("<span class='danger'>[G.assailant] stuffed [G.affecting] into [src].</span>", \
										"<span class='userdanger'>[G.assailant] stuffed [G.affecting] into [src].</span>")
			add_logs(G.assailant, G.affecting, "stuffed")
			qdel(I)
			return 1
	qdel(I)

obj/machinery/stove/container_resist()
	var/mob/living/user = usr
	var/breakout_time = 1

	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	if(src.opened)
		breakout_time = 0.05
		user << "<span class='notice'>You try to escape from [src].</span>"
		for(var/mob/O in viewers(src))
			O << "<span class='warning'>Somefing in [src] starts moving.</span>"
		if(do_after(user,(breakout_time*60*10))) //minutes * 60seconds * 10deciseconds
			if(!user || user.stat != CONSCIOUS || user.loc != src)
				return
			//we check after a while whether there is a point of resisting anymore and whether the user is capable of resisting

			if(src.opened) //they don't closed the door
				user.visible_message("<span class='danger'>[user] fall out of [src]!</span>", "<span class='notice'>You fall out of [src]!</span>")
				user.loc = get_turf(src.loc)
				src.hiden_body = null
			else
				user << "<span class='warning'>[src] is closed now. It will be harder to escape.</span>"
		else
			user << "<span class='warning'>You fail to get out of [src]!</span>"
	else
		user << "<span class='notice'>You lean on the back of [src] and start pushing the door open. (this will take about [breakout_time] minutes.)</span>"
		for(var/mob/O in viewers(src))
			O << "<span class='warning'>Somefing in [src] starts moving.</span>"

		if(do_after(user,(breakout_time*60*10))) //minutes * 60seconds * 10deciseconds
			if(!user || user.stat != CONSCIOUS || user.loc != src)
				return
			//we check after a while whether there is a point of resisting anymore and whether the user is capable of resisting

			src.opened = 1 //door is opened now
			user.visible_message("<span class='danger'>[user] successfully break out of [src]!</span>", "<span class='notice'>You successfully break out of [src]!</span>")
			user.loc = get_turf(src.loc)
			src.hiden_body = null

		else
			user << "<span class='warning'>You fail to break out of [src]!</span>"
