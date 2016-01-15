/mob/living/carbon/verb/give()
	set category = "IC"
	set name = "Give"
	set src in view(1)
	if(!ismonkey(src)&&!ishuman(src)||isalien(src)||src.stat&(UNCONSCIOUS|DEAD)|| usr.stat&(UNCONSCIOUS|DEAD)|| src.client == null)
		usr << "<span class='warning'>[src.name] ������ �� �����.</span>"
		return
	if(src == usr)
//		usr << "<span class='warning'>I feel stupider, suddenly.</span>"
		return
	var/obj/item/I
	if(!usr.hand && usr.r_hand == null)
		usr << "<span class='warning'>� � ��� � ���� ������ ���!</span>"
		return
	if(usr.hand && usr.l_hand == null)
		usr << "<span class='warning'>� � ��� � ���� ������ ���!</span>"
		return
	if(usr.hand)
		I = usr.l_hand
	else if(!usr.hand)
		I = usr.r_hand
	if(!I || I.flags&(ABSTRACT|NODROP) || istype(I,/obj/item/tk_grab))
		return
	if(src.r_hand == null || src.l_hand == null)
		switch(alert(src,"[usr] ��� ��� [(I.accusative_case ? I.accusative_case : I.name)]. �������?",,"��","���"))
			if("��")
				if(!I)
					return
				if(!Adjacent(usr))
					usr << "<span class='warning'>� �� ������ ���&#255;�� �&#255;��� � ���������.</span>"
					src << "<span class='warning'>[usr.name] ������� ������ ����.</span>"
					return
				if((usr.hand && usr.l_hand != I) || (!usr.hand && usr.r_hand != I))
					usr << "<span class='warning'>� � ����� ���� ������ ���.</span>"
					src << "<span class='warning'>[usr.name] ������ �� ����� ������ ��� [(I.accusative_case ? I.accusative_case : I.name)].</span>"
					return
				if(src.lying||src.handcuffed)
					usr << "<span class='warning'>� [src.gender==MALE?"��":"���"] ��&#255;���[src.gender==MALE?"":"�"]!</span>"
					return
				if(src.r_hand != null && src.l_hand != null)
					src << "<span class='warning'>� ���� ���� ���&#255;��.</span>"
					usr << "<span class='warning'>� [src.gender==MALE?"���":"Ÿ"] ���� ���&#255;��.</span>"
					return
				else
					if(src.r_hand == null)
						r_hand = I
						usr.drop_item()
					else if(src.l_hand==null)
						l_hand = I
						usr.drop_item()
					else
						src << "<span class='warning'>� �� �� ������ ��� ��&#255;��.</span>"
						usr << "<span class='warning'>[src.name] �� ����� ��� ��&#255;��!</span>"
						return
				I.loc = src
				I.layer = 20
				I.add_fingerprint(src)
				src.update_inv_r_hand()
				src.update_inv_l_hand()
				usr.update_inv_r_hand()
				usr.update_inv_l_hand()


				src.visible_message("<span class='notice'>[usr.name] �������[usr.gender==MALE?"":"�"] [(I.accusative_case ? I.accusative_case : I.name)] � ���� [src.name].</span>")
			if("���")
				src.visible_message("<span class='warning'>[src.name] �������[src.gender==MALE?"�&#255;":"���"] �� [(I.accusative_case ? I.accusative_case : I.name)].</span>")
	else
		usr << "<span class='warning'>� � [src.gender==MALE?"����":"��"] ���&#255;�� ����.</span>"
