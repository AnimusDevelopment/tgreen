/obj/machinery/atmospherics/binary/valve
	icon = 'icons/obj/atmospherics/binary_devices.dmi'
	icon_state = "mvalve_map"
	name = "manual valve"
	desc = "A pipe valve"
	can_unwrench = 1
	var/open = 0
	var/frequency = 0
	var/id = null

/obj/machinery/atmospherics/binary/valve/open
	open = 1

//Separate this because we don't need to update pipe icons if we just are going to crank the handle
/obj/machinery/atmospherics/binary/valve/update_icon_nopipes(animation = 0)
	normalize_dir()
	icon_state = "mvalve_off"
	overlays.Cut()
	if(animation)
		overlays += getpipeimage('icons/obj/atmospherics/binary_devices.dmi', "mvalve_[open][!open]")
	else if(open)
		overlays += getpipeimage('icons/obj/atmospherics/binary_devices.dmi', "mvalve_on")

/obj/machinery/atmospherics/binary/valve/update_icon()
	update_icon_nopipes()
	var/connected = 0
	underlays.Cut()
	//Add non-broken pieces
	if(node1)
		connected = icon_addintact(node1, connected)
	if(node2)
		connected = icon_addintact(node2, connected)
	//Add broken pieces
	icon_addbroken(connected)

/obj/machinery/atmospherics/binary/valve/proc/open()
	open = 1
	update_icon_nopipes()
	parent1.update = 0
	parent2.update = 0
	parent1.reconcile_air()
	investigate_log("was opened by [usr ? key_name(usr) : "a remote signal"]", "atmos")
	return

/obj/machinery/atmospherics/binary/valve/proc/close()
	open = 0
	update_icon_nopipes()
	investigate_log("was closed by [usr ? key_name(usr) : "a remote signal"]", "atmos")
	return

/obj/machinery/atmospherics/binary/valve/proc/normalize_dir()
	if(dir==2)
		dir = 1
	else if(dir==8)
		dir = 4

/obj/machinery/atmospherics/binary/valve/attack_ai(mob/user)
	return

/obj/machinery/atmospherics/binary/valve/attack_hand(mob/user)
	add_fingerprint(usr)
	update_icon_nopipes(1)
	sleep(10)
	if(open)
		close()
	else
		open()


/obj/machinery/atmospherics/binary/valve/digital		// can be controlled by AI
	name = "digital valve"
	desc = "A digitally controlled valve."
	icon_state = "dvalve_map"
	var/obj/item/device/assembly/attached_device
	var/mob/attacher = null

/obj/machinery/atmospherics/binary/valve/digital/attack_ai(mob/user)
	return src.attack_hand(user)

/obj/machinery/atmospherics/binary/valve/digital/attack_hand(mob/user)
	if(attached_device)
		attached_device.interact(user)
	else
		..()

/obj/machinery/atmospherics/binary/valve/digital/examine(mob/user)
	..()
	if(attached_device)
		user<<"It has [attached_device] attached."

/obj/machinery/atmospherics/binary/valve/digital/attackby(obj/item/item, mob/user, params)
	if(isassembly(item))
		var/obj/item/device/assembly/A = item
		if(A.secured)
			user << "<span class='notice'>The device is secured.</span>"
			return
		if(attached_device)
			user << "<span class='warning'>There is already a device attached to the valve, remove it first!</span>"
			return
		user.remove_from_mob(item)
		attached_device = A
		A.loc = src
		user << "<span class='notice'>You attach the [item] to the valve controls and secure it.</span>"
		A.holder = src
		A.toggle_secure()

		message_admins("[key_name_admin(user)] attached a [item] to a digital valve.")
		log_game("[user.name]([user.ckey]) attached \a [item] to a digital valve.")
		attacher = user
	else if(istype(item, /obj/item/weapon/screwdriver))
		if(attached_device)
			attached_device.loc=src.loc
			attached_device.holder=null
			attached_device=null
			user<<"<span class='notice'>You detach the [attached_device] from the valve controls.</span>"
		else
			user<<"<span class='warning'>Nothing to detach!</span>"
	else
		..()



/obj/machinery/atmospherics/binary/valve/digital/HasProximity(atom/movable/AM as mob|obj)
	if(!attached_device)	return
	attached_device.HasProximity(AM)
	return

/obj/machinery/atmospherics/binary/valve/digital/Deconstruct()
	if(attached_device)
		attached_device.loc=src.loc
		attached_device.holder=null
		attached_device=null
	..()

/obj/machinery/atmospherics/binary/valve/digital/Destroy()
	if(attached_device)
		attached_device.loc=src.loc
		attached_device.holder=null
		attached_device=null
	..()

/obj/machinery/atmospherics/binary/valve/digital/proc/process_activation(var/obj/item/device/D, var/normal = 1, var/special = 1, var/source = "*No Source*", var/usr_name = "*No mob*")
	if(open)
		close()
	else
		open()
		notify_admins(source,usr_name)

/obj/machinery/atmospherics/binary/valve/digital/proc/notify_admins(var/source = "*No Source*", var/usr_name = "*No mob*")
	var/turf/bombturf = get_turf(src)
	var/area/A = get_area(bombturf)

	var/attachment = "no device"
	var/attachment_log = "no device"
	var/attacher_log = ""
	if(attached_device)
		if(istype(attached_device, /obj/item/device/assembly/signaler))
			attachment = "<A HREF='?_src_=holder;secretsadmin=list_signalers'>[attached_device]</A>"
		else
			attachment = attached_device
		attachment_log = attached_device

		var/attacher_name = ""
		if(!attacher)
			attacher_name = "*Unknown*"
		else
			attacher_name = "[attacher.name]([attacher.ckey])"

		attacher_log = ". Attacher: [attacher_name]"

	var/log_str1 = "Digital valve opened in "
	var/log_str2 = "with [attachment][attacher_log]"
	var/log_str2_1 = "with [attachment_log][attacher_log]"

	var/log_attacher = ""
	if(attacher)
		log_attacher = "(<A HREF='?_src_=holder;adminmoreinfo=\ref[attacher]'>?</A>)"

	var/mob/mob = get_mob_by_key(src.fingerprintslast)
	var/last_touch_info = ""
	if(mob)
		last_touch_info = "(<A HREF='?_src_=holder;adminmoreinfo=\ref[mob]'>?</A>)"

	var/log_str3 = ". Last touched by: [src.fingerprintslast]."

	var/log_str4 = ""
	if (usr_name && usr_name != "*No mob*")
		if(attached_device)
			if (istype(attached_device, /obj/item/device/assembly/signaler))
				log_str4 = ". Signal was sent by [usr_name]"
			else
				log_str4 = ". Activated by [usr_name]"
	if (source && source != "*No Source*")
		log_str4 += "(Source: [source])"

	var/bomb_message = "[log_str1] <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[bombturf.x];Y=[bombturf.y];Z=[bombturf.z]'>[A.name]</a>  [log_str2][log_attacher] [log_str3][last_touch_info]"

	bombers += bomb_message

	message_admins(bomb_message, 0, 1)
	log_game("[log_str1][A.name]([A.x],[A.y],[A.z]) [log_str2_1][log_str3][log_str4]")

/obj/machinery/atmospherics/binary/valve/digital/update_icon_nopipes(animation)
	normalize_dir()
	if(stat & NOPOWER)
		icon_state = "dvalve_nopower"
		overlays.Cut()
		return
	icon_state = "dvalve_off"
	overlays.Cut()
	if(animation)
		overlays += getpipeimage('icons/obj/atmospherics/binary_devices.dmi', "dvalve_[open][!open]")
	else if(open)
		overlays += getpipeimage('icons/obj/atmospherics/binary_devices.dmi', "dvalve_on")
