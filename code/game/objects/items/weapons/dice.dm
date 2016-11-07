/obj/item/weapon/dice
	name = "d6"
	desc = "A die with six sides. Basic and servicable."
	icon = 'icons/obj/dice.dmi'
	icon_state = "d6"
	w_class = 1
	var/sides = 6
	var/result = null

/obj/item/weapon/dice/examine(mob/user)
	..()
	user << "The [src] has landed on [src.result]."


/obj/item/weapon/dice/New()
	result = rand(1, sides)
	update_icon()

/obj/item/weapon/dice/d2
	name = "d2"
	desc = "A die with two sides. Coins are undignified!"
	icon_state = "d2"
	sides = 2

/obj/item/weapon/dice/d4
	name = "d4"
	desc = "A die with four sides. The nerd's caltrop."
	icon_state = "d4"
	sides = 4

/obj/item/weapon/dice/d8
	name = "d8"
	desc = "A die with eight sides. It feels... lucky."
	icon_state = "d8"
	sides = 8

/obj/item/weapon/dice/d10
	name = "d10"
	desc = "A die with ten sides. Useful for percentages."
	icon_state = "d10"
	sides = 10

/obj/item/weapon/dice/d00
	name = "d00"
	desc = "A die with ten sides. Works better for d100 rolls than a golfball."
	icon_state = "d00"
	sides = 10

/obj/item/weapon/dice/d12
	name = "d12"
	desc = "A die with twelve sides. There's an air of neglect about it."
	icon_state = "d12"
	sides = 12

/obj/item/weapon/dice/d20
	name = "d20"
	desc = "A die with twenty sides. The prefered die to throw at the GM."
	icon_state = "d20"
	sides = 20

/obj/item/weapon/dice/attack_self(mob/user as mob)
	diceroll(user)

/obj/item/weapon/dice/throw_at(atom/target, range, speed, mob/user as mob)
	if(!..())
		return
	diceroll(user)

/obj/item/weapon/dice/proc/diceroll(mob/user as mob)
	result = rand(1, sides)
	var/comment = ""
	if(sides == 20 && result == 20)
		comment = "Nat 20!"
	else if(sides == 20 && result == 1)
		comment = "Ouch, bad luck."
	update_icon()
	if(initial(icon_state) == "d00")
		result = (result - 1)*10
	if(user != null) //Dice was rolled in someone's hand
		user.visible_message("[user] has thrown [src]. It lands on [result]. [comment]", \
							 "<span class='notice'>You throw [src]. It lands on [result]. [comment]</span>", \
							 "<span class='italics'>You hear [src] rolling.</span>")
	else if(src.throwing == 0) //Dice was thrown and is coming to rest
		visible_message("<span class='notice'>[src] rolls to a stop, landing on [result]. [comment]</span>")

/obj/item/weapon/dice/d4/Crossed(var/mob/living/carbon/human/H)
	if(istype(H) && !H.shoes)
		if(HARDFEET in H.dna.species.specflags)
			return 0
		H << "<span class='userdanger'>You step on the D4!</span>"
		H.apply_damage(4,BRUTE,(pick("l_leg", "r_leg")))
		H.Weaken(3)

/obj/item/weapon/dice/update_icon()
	overlays.Cut()
	overlays += "[src.icon_state][src.result]"

/obj/item/weapon/storage/bag/dicecup
	name = "dicecup"
	desc = "handmade cup designed for throwing dices"
	icon = 'icons/obj/dice.dmi'
	icon_state = "dicecup"
	item_state = "contsolid"
	storage_slots = 7
	display_contents_with_number = 0  //it does look good inside, but somewhy doesn't reset number after throw
	slot_flags = 0
	can_hold = list(/obj/item/weapon/dice)
	w_class = 2
	var/list/last_throw = list()
	var/last_sum

/obj/item/weapon/storage/bag/dicecup/afterattack(atom/target, mob/user , proximity)
	if(isemptylist(contents))
		..()
		return
	if(!proximity)
		return
	if(istype(target,/obj/structure/table))
		last_throw.Cut()
		last_sum = 0
		for(var/obj/item/weapon/dice/D in src.contents)
			D.loc = target.loc
			D.diceroll()
			last_throw += D.result
			last_sum += D.result
			D.pixel_x = rand(-6, 6)
			D.pixel_y = rand(-6, 6)
//		sortList(last_throw, /proc/cmp_numeric_asc)
		user.visible_message("[user] has thrown dices. They got [english_list(last_throw)] as result with [last_sum] as sum.", \
							 "<span class='notice'>You throw dices. They got [english_list(last_throw)] as result with [last_sum] as sum.</span>")
		return