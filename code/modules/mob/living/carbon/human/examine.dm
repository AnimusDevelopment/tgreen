/mob/living/carbon/human/examine(mob/user)

	var/list/obscured = check_obscured_slots()
	var/skipface = 0
	if(wear_mask)
		skipface |= wear_mask.flags_inv & HIDEFACE

	var/he  = "��"
	var/him = "��"
	var/has = "����"
	var/his = "���"
	var/end = ""

	if(gender == FEMALE)
		he  = "���"
		him = "���"
		has = "��"
		his = "�"
		end = "�"

	var/msg = "<span class='info'>*---------*\n* ��� �� "

	if(icon)
		msg += "\icon[src] " //note, should we ever go back to runtime-generated icons (please don't), you will need to change this to \icon[icon] to prevent crashes.

	msg += "<EM>[src.name]</EM>"

	if(wear_id)
		if(src.get_authentification_name("") == src.name && src.get_assignment("","") != "")
			msg += ", [src.get_assignment_russian(src.get_assignment("", ""))]"
	msg += "!\n"

	if(!(name == "Unknown"))
		if(age < 27)
			msg += "* [he] ����&#255;��� ������ ������."
		else
			if (age < 42)
				msg += "* [he] ����&#255;��� ���������� �����."
			else
				if (age < 75)
					msg += "* [he] ����&#255;��� ������������."
				else
					msg += "* [he] ��������� ����������&#255; �� ����� �� ��������!"
		msg += "\n"

	//head
	if(head)
		if(!istype(head, /obj/item/clothing/head/HoS/dermal))
			if(istype(head, /obj/item/weapon/reagent_containers/food/snacks/grown))
				msg += "* � [has] �� ���� \icon[head] ������.\n"
			else
				if(istype(head,/obj/item/weapon/paper))
					msg += "* � [has] �� ������ \icon[head] �������&#255; �����.\n"
				else
					msg += "* � [has] �� ������ \icon[head] [head.r_name].\n"

	//eyes
	if(glasses && !(slot_glasses in obscured))
		if(glasses.accusative_case)
			msg += "* [he] ����� \icon[glasses] [glasses.accusative_case].\n"
		else
			msg += "* [he] ����� \icon[glasses] [glasses.r_name].\n"

	//ears
	if(ears && !(slot_ears in obscured))
		if(istype(ears, /obj/item/device/radio/headset))
			msg += "* �� [has] ������ \icon[ears] [ears.r_name].\n"
		else
			msg += "* � [has] �� ���� \icon[ears] [ears.r_name].\n"

	//mask
	if(wear_mask && !(slot_wear_mask in obscured))
		if(istype(wear_mask, /obj/item/clothing/mask/cigarette))
			msg += "* � [has] � ����� \icon[wear_mask] [wear_mask.r_name].\n"
		else
			msg += "* � [has] �� ���� \icon[wear_mask] [wear_mask.r_name].\n"

	//uniform
	if(w_uniform && !(slot_w_uniform in obscured))
		//Ties
		if(istype(w_uniform,/obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.hastie)
				if(istype(U.hastie,/obj/item/clothing/tie/medal))
					msg += "* � [has] �� ����� \icon[U.hastie] [U.hastie.r_name].\n"
				else if(istype(U.hastie,/obj/item/clothing/tie/armband))
					msg += "* � [has] �� ������ \icon[U.hastie] [U.hastie.r_name].\n"

	//suit/armor
	if(wear_suit)
		msg += "* �� [him] \icon[wear_suit] [wear_suit.r_name].\n"

	//  suit/armor storage
	//	if(s_store)
	//		msg += "* [t_He] [t_is] carrying \icon[s_store] \a [s_store] on [t_his] [wear_suit.name].\n"

	//back
	if(back)
		if(back.r_name)
			msg += "* � [has] �� ������ \icon[back] [back.r_name].\n"
		else
			msg += "* � [has] �� ������ \icon[back] [back.name].\n"

	//left hand
	if(l_hand && !(l_hand.flags&ABSTRACT))
//		if(l_hand.blood_DNA)
//			msg += "* <span class='warning'>[he] ������ \icon[l_hand] blood-stained [l_hand.name] � ����� ����!</span>\n"
//		else
		if(l_hand.accusative_case)
			msg += "* [he] ������ \icon[l_hand] [l_hand.accusative_case] � ����� ����.\n"
		else if(l_hand.r_name)
			msg += "* [he] ������ \icon[l_hand] [l_hand.r_name] � ����� ����.\n"
		else
			msg += "* [he] ������ \icon[l_hand] [l_hand] � ����� ����.\n" // TODO: accusative_case needed

	//right hand
	if(r_hand && !(r_hand.flags&ABSTRACT))
//		if(r_hand.blood_DNA)
//			msg += "* <span class='warning'>[he] ������ \icon[r_hand]  blood-stained [r_hand.name] � ������ ����!</span>\n"
//		else
		if(r_hand.accusative_case)
			msg += "* [he] ������ \icon[r_hand] [r_hand.accusative_case] � ������ ����.\n"
		else if(r_hand.r_name)
			msg += "* [he] ������ \icon[r_hand] [r_hand.r_name] � ������ ����.\n"
		else
			msg += "* [he] ������ \icon[r_hand] [r_hand] � ������ ����.\n" // TODO: accusative_case needed

	//gloves
	if(gloves && !(slot_gloves in obscured))
		if(istype(gloves,/obj/item/clothing/gloves/brassknuckles))
			if(gloves.blood_DNA)
				msg += "* <span class='warning'>� ���� � [has] \icon[gloves] ������������� ������!</span>\n"
			else
				msg += "* � [has] � ���� \icon[gloves] ������.\n"

		else
			if(gloves.blood_DNA)
				msg += "* <span class='warning'>�� ����� � [has] \icon[gloves] ������������� [gloves.r_name]!</span>\n"
			else
				msg += "* �� ����� � [has] \icon[gloves] [gloves.r_name].\n"
	else if(blood_DNA)
		msg += "* <span class='warning'>� [has] ����������� ����!</span>\n"


	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/weapon/restraints/handcuffs/cable))
			msg += "* <span class='warning'>[he] \icon[handcuffed] ��&#255;���[end] �������!</span>\n"
		else
			msg += "* <span class='warning'>[he] \icon[handcuffed] � ����������!</span>\n"

	//belt
	if(belt)
		if(istype(belt, /obj/item/weapon/storage/belt))
			msg += "* [he] ����� \icon[belt] [belt.r_name].\n"
		else
			if(!istype(belt, /obj/item/device/pda))
				if(belt.r_name)
					msg += "* � [has] �� ��&#255;�� \icon[belt] [belt.r_name].\n"
				else
					msg += "* � [has] �� ��&#255;�� \icon[belt] [belt].\n"

	//shoes
	if(!shoes)
		msg += "* � [has] ����� ����.\n"

	if(shoes && !(slot_shoes in obscured))
		if(istype(shoes,/obj/item/clothing/shoes/galoshes) || istype(shoes,/obj/item/clothing/shoes/magboots))
			msg += "* �� [him] \icon[shoes] [shoes.r_name].\n"

	//ID

	if(wear_id)
		if(src.get_authentification_name("") != src.name)
			if(wear_id.accusative_case)
				msg += "* [he] ����� \icon[wear_id] [wear_id.accusative_case].\n"
			else
				msg += "* [he] ����� \icon[wear_id] [wear_id].\n"

		/*var/id
		if(istype(wear_id, /obj/item/device/pda))
			var/obj/item/device/pda/pda = wear_id
			id = pda.owner
		else if(istype(wear_id, /obj/item/weapon/card/id)) //just in case something other than a PDA/ID card somehow gets in the ID slot :[
			var/obj/item/weapon/card/id/idcard = wear_id
			id = idcard.registered_name
		if(id && (id != real_name) && (get_dist(src, user) <= 1) && prob(10))
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[wear_id] \a [wear_id] yet something doesn't seem right...</span>\n"
		else*/
	//	msg += "* �� [him] \icon[wear_id] [wear_id].\n"

	//Jitters
	switch(jitteriness)
		if(300 to INFINITY)
			msg += "* <span class='warning'><B>[he] �����&#255; � ��������!</B></span>\n"
		if(100 to 300)
			msg += "* <span class='warning'>[he] ������������ �����������&#255;.</span>\n"

	if(gender_ambiguous) //someone fucked up a gender reassignment surgery
		if (gender == MALE)
			msg += "* [he] ���-�� ����� ����� �� �������.\n"
		else
			msg += "* [he] ���-�� ����� ������ �� �������.\n"

	var/temp = getBruteLoss() //no need to calculate each of these twice

	msg += "<span class='warning'>"

	if(temp)
		if(temp < 30)
			msg += "* � [has] �������������� �������.\n"
		else
			msg += "* <B>[he] [gender=="male"?"����":"��&#255;"] �������[end]!</B>\n"

	temp = getFireLoss()
	if(temp)
		if(temp < 30)
			msg += "* � [has] �������������� �����.\n"
		else
			msg += "* <B>� [has] ��������� �����!</B>\n"

	temp = getCloneLoss()
	if(temp)
		if(temp < 30)
			msg += "* � [has] ��������� ������������ �������.\n"
		else
			msg += "* <B>� [has] ��������� ������������ �������.</B>\n"


	for(var/obj/item/organ/limb/L in organs)
		for(var/obj/item/I in L.embedded_objects)
			msg += "* <B>� [has] � [L.getNamePrepositional()] \icon[I] [I.r_name]!</B>\n"

	if(!stat == DEAD)
		if(nutrition < NUTRITION_LEVEL_HUNGRY)
			msg += "* [he] ����&#255;��� ������[gender=="male"?"��":"��"].\n"
		else if(nutrition < NUTRITION_LEVEL_STARVING)
			msg += "* [he] &#255;��� �������� �� ���������&#255;.\n"
		else if(nutrition >= NUTRITION_LEVEL_FAT)
			if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
				msg += "* [he] ����[gender=="male"?"��":"�&#255;"] � ��������[gender=="male"?"��":"�&#255;"], ��� ������� ��������. �-�-����� ������� ��������.\n"
			else
				msg += "* [he] �������� ����[gender=="male"?"��":"�&#255;"].\n"

	if(pale)
		msg += "* � [has] ������&#255; ����.\n"

	if(blood_max && !bleedsupress)
		msg += "* <B>[he] �������� ������!</B>\n"

	if(getOxyLoss() > 30 && !(slot_wear_mask in obscured))
		msg += "* � [has] ���������� ����.\n"

	msg += "</span>"

	var/appears_dead = 0
	if(stat == DEAD || (status_flags & FAKEDEATH))
		appears_dead = 1
	if(!appears_dead)
		if(stat == UNCONSCIOUS && !sleeping)
			msg += "* [he] �� ��������� �� ��������&#255;��� ������. ������, ��� [gender == "male" ? "��":"���"] ��� �������&#255;.\n"
		else if(sleeping)
			msg += "* ������, ��� [gender == "male" ? "��":"���"] ����.\n"
		else if(getBrainLoss() >= 30)
			msg += "* � [has] ������ ��������� ����.\n"

		if(getorgan(/obj/item/organ/brain))
			if(!key && !stat)
				msg += "* <span class='deadsay'>[he] ��������� �������[end], �� �������&#255; �������� ����� � �������� �������. ��� ������� �������, ��� [gender=="male"?"��":"���"] ����� � ���&#255;.</span>\n"
			else if(!client)
				msg += "* � [gender == "male" ? "����":"��"] ������, ������������� ����&#255;�...\n"

		if(digitalcamo)
			msg += "* [he] ����&#255;��� ��� ��������������� ������ �� ����� ������!\n"

	else
		if(getorgan(/obj/item/organ/brain))//Only perform these checks if there is no brain
			msg += "* <span class='deadsay'>[he] ��������� �����[gender=="male"?"":"��"], �� ���&#255;��&#255;&#255; ��������� �����."
			if(!key)
				var/foundghost = 0
				if(mind)
					for(var/mob/dead/observer/G in player_list)
						if(G.mind == mind)
							foundghost = 1
							if (G.can_reenter_corpse == 0)
								foundghost = 0
							break
				if(!foundghost)
					msg += " [gender=="male"?"���":"Ÿ"] ��� ������ ���������&#255;."
			msg += "..</span>\n"
		else //Brain is gone, doesn't matter if they are AFK or present
			msg += "* <span class='deadsay'>������, ��� [his] ���� ��� ��������...</span>\n"


	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		var/obj/item/cybernetic_implant/eyes/hud/CIH = locate(/obj/item/cybernetic_implant/eyes/hud) in H.internal_organs
		if(istype(H.glasses, /obj/item/clothing/glasses/hud) || CIH)
			var/perpname = get_face_name(get_id_name(""))
			if(perpname)
				var/datum/data/record/R = find_record("name", perpname, data_core.general)
				if(R)
					msg += "<span class = 'deptradio'>Rank:</span> [R.fields["rank"]]<br>"
					msg += "<a href='?src=\ref[src];hud=1;photo_front=1'>\[Front photo\]</a> "
					msg += "<a href='?src=\ref[src];hud=1;photo_side=1'>\[Side photo\]</a><br>"
				if(istype(H.glasses, /obj/item/clothing/glasses/hud/health) || istype(CIH,/obj/item/cybernetic_implant/eyes/hud/medical))
					var/implant_detect
					for(var/obj/item/cybernetic_implant/CI in internal_organs)
						implant_detect += "[name] is modified with a [CI.name].<br>"
					if(implant_detect)
						msg += "Detected cybernetic modifications:<br>"
						msg += implant_detect
					if(R)
						var/health = R.fields["p_stat"]
						msg += "<a href='?src=\ref[src];hud=m;p_stat=1'>\[[health]\]</a>"
						health = R.fields["m_stat"]
						msg += "<a href='?src=\ref[src];hud=m;m_stat=1'>\[[health]\]</a><br>"
					R = find_record("name", perpname, data_core.medical)
					if(R)
						msg += "<a href='?src=\ref[src];hud=m;evaluation=1'>\[Medical evaluation\]</a><br>"


				if(istype(H.glasses, /obj/item/clothing/glasses/hud/security) || istype(CIH,/obj/item/cybernetic_implant/eyes/hud/security))
					if(!user.stat && user != src) //|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
						var/criminal = "None"

						R = find_record("name", perpname, data_core.security)
						if(R)
							criminal = R.fields["criminal"]

						msg += "<span class = 'deptradio'>Criminal status:</span> <a href='?src=\ref[src];hud=s;status=1'>\[[criminal]\]</a>\n"
						msg += "<span class = 'deptradio'>Security record:</span> <a href='?src=\ref[src];hud=s;view=1'>\[View\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;add_crime=1'>\[Add crime\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;view_comment=1'>\[View comment log\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;add_comment=1'>\[Add comment\]</a>\n"

	msg += "*---------*</span>"

	user << msg
