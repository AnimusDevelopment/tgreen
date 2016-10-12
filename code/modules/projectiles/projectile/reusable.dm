/obj/item/projectile/bullet/reusable
	name = "reusable bullet"
	desc = "How do you even reuse a bullet?"
	var/obj/item/ammo_casing/caseless/ammo_type = /obj/item/ammo_casing/caseless/

/obj/item/projectile/bullet/reusable/on_hit(atom/target, blocked = 0)
	. = ..()
	if (src.contents.len)
		var/obj/content
		for(content in src.contents)
			content.loc = src.loc
	else
		new ammo_type(src.loc)

/obj/item/projectile/bullet/reusable/on_range()
	if (src.contents.len)
		var/obj/content
		for(content in src.contents)
			content.loc = src.loc
	else
		new ammo_type(src.loc)
	..()

/obj/item/projectile/bullet/reusable/magspear
	name = "magnetic spear"
	desc = "WHITE WHALE, HOLY GRAIL"
	damage = 30 //takes 3 spears to kill a mega carp, one to kill a normal carp
	icon_state = "magspear"
	ammo_type = /obj/item/ammo_casing/caseless/magspear

/obj/item/projectile/bullet/reusable/foam_dart
	name = "foam dart"
	desc = "I hope you're wearing eye protection."
	damage = 0 // It's a damn toy.
	damage_type = OXY
	nodamage = 1
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foamdart"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	range = 10

/obj/item/projectile/bullet/reusable/foam_dart/on_hit(atom/target, blocked = 0)
	var/obj/item/ammo_casing/caseless/foam_dart/ammo = new ammo_type()
	if(damage_type==BRUTE)
		ammo.BB.damage_type=BRUTE
		ammo.modified=1
		ammo.icon_state = "foamdart_empty"
		ammo.BB.icon_state = "foamdart_empty"
		ammo.desc = "Its nerf or nothing! ...Although, this one doesn't look too safe."
	if(src.contents.len)
		ammo.BB.nodamage=0
		ammo.BB.damage=5
		var/obj/content
		for(content in src.contents)
			content.Move(ammo.BB)
	ammo.Move(src)
	..()


/obj/item/projectile/bullet/reusable/on_range()
	var/obj/item/ammo_casing/caseless/foam_dart/ammo = new ammo_type()
	if(damage_type==BRUTE)
		ammo.BB.damage_type=BRUTE
		ammo.modified=1
		ammo.icon_state = "foamdart_empty"
		ammo.desc = "Its nerf or nothing! ...Although, this one doesn't look too safe."
	if(src.contents.len)
		ammo.BB.nodamage=0
		ammo.BB.damage=5
		var/obj/content
		for(content in src.contents)
			content.Move(ammo.BB)
	ammo.Move(src)
	..()

/obj/item/projectile/bullet/reusable/pulse_beam
	name = "foam pulse beam"
	desc = "Just like real one!"
	damage = 0
	damage_type = OXY
	nodamage = 1
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "u_laser"
	ammo_type = /obj/item/ammo_casing/caseless/foam_pulse


/obj/item/projectile/bullet/reusable/foam_dart/riot
	name = "riot foam dart"
	icon_state = "foamdart_riot"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	stamina = 25

/obj/item/projectile/bullet/reusable/implanter
	name = "implanter"
	icon_state = "cbbolt"
	ammo_type = /obj/item/weapon/implanter
	damage = 5

/obj/item/projectile/bullet/reusable/implanter/on_hit(var/atom/target, var/blocked = 0)
	var/obj/item/weapon/implanter/I = locate(/obj/item/weapon/implanter) in src
	if(I.imp && iscarbon(target))
		if(I.imp.implant(target, firer))
			I.imp = null
		I.update_icon()

	. = ..()