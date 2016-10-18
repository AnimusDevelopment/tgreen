/datum/game_mode
	// this includes admin-appointed traitors and multitraitors. Easy!
	var/traitor_name = "traitor"
	var/list/datum/mind/traitors = list()

	var/datum/mind/exchange_red
	var/datum/mind/exchange_blue

/datum/game_mode/traitor
	name = "traitor"
	config_tag = "traitor"
	antag_flag = BE_TRAITOR
	restricted_jobs = list("Cyborg", "AI") //They are part of the AI if he is traitor so are they, they use to get double chances
	protected_jobs = list("Security Officer", "Warden", "Head of Security", "Captain", "Detective")//AI", Currently out of the list as malf does not work for shit
	required_players = 0
	required_enemies = 1
	recommended_enemies = 4
	reroll_friendly = 1

	var/traitors_possible = 4 //hard limit on traitors if scaling is turned off
	var/num_modifier = 0 // Used for gamemodes, that are a child of traitor, that need more than the usual.


/datum/game_mode/traitor/announce()
	world << "<B>Òåêóùèé èãðîâîé ðåæèì - traitor!</B>"
	world << "<B>Ñðåäè ïåðñîíàëà ñòàíöèè çàìå÷åíû ïðåäàòåëè! Íå äàéòå èì âûïîëíèòü èõ çàäàíè&#255;.</B>"


/datum/game_mode/traitor/pre_setup()

	if(config.protect_roles_from_antagonist)
		restricted_jobs += protected_jobs

	var/num_traitors = 1

	if(config.traitor_scaling_coeff)
		num_traitors = max(1, min( round(num_players()/(config.traitor_scaling_coeff*2))+ 2 + num_modifier, round(num_players()/(config.traitor_scaling_coeff)) + num_modifier ))
	else
		num_traitors = max(1, min(num_players(), traitors_possible))

	for(var/j = 0, j < num_traitors, j++)
		if (!antag_candidates.len)
			break
		var/datum/mind/traitor = pick(antag_candidates)
		traitors += traitor
		traitor.special_role = traitor_name
		traitor.restricted_roles = restricted_jobs
		log_game("[traitor.key] (ckey) has been selected as a [traitor_name]")
		antag_candidates.Remove(traitor)


	if(traitors.len < required_enemies)
		return 0
	return 1


/datum/game_mode/traitor/post_setup()
	for(var/datum/mind/traitor in traitors)
		forge_traitor_objectives(traitor)
		spawn(rand(10,100))
			greet_traitor(traitor)
			finalize_traitor(traitor)
	if(!exchange_blue)
		exchange_blue = -1 //Block latejoiners from getting exchange objectives
	modePlayer += traitors
	..()
	return 1

/datum/game_mode/traitor/make_antag_chance(var/mob/living/carbon/human/character) //Assigns traitor to latejoiners
	var/traitorcap = min(round(joined_player_list.len / (config.traitor_scaling_coeff * 2)) + 2 + num_modifier, round(joined_player_list.len/config.traitor_scaling_coeff) + num_modifier )
	if(ticker.mode.traitors.len >= traitorcap) //Upper cap for number of latejoin antagonists
		return
	if(ticker.mode.traitors.len <= (traitorcap - 2) || prob(100 / (config.traitor_scaling_coeff * 2)))
		if(character.client.prefs.be_special & BE_TRAITOR)
			if(!jobban_isbanned(character.client, "traitor") && !jobban_isbanned(character.client, "Syndicate"))
				if(!(character.job in restricted_jobs))
					add_latejoin_traitor(character.mind)

/datum/game_mode/traitor/proc/add_latejoin_traitor(var/datum/mind/character)
	character.make_Traitor()


/datum/game_mode/proc/forge_traitor_objectives(var/datum/mind/traitor)
	if(istype(traitor.current, /mob/living/silicon))
		var/objective_count = 0

		if(prob(10))
			var/datum/objective/block/block_objective = new
			block_objective.owner = traitor
			traitor.objectives += block_objective
			objective_count++

		for(var/i = objective_count, i < config.traitor_objectives_amount, i++)
			var/datum/objective/assassinate/kill_objective = new
			kill_objective.owner = traitor
			kill_objective.find_target()
			traitor.objectives += kill_objective

		var/datum/objective/survive/survive_objective = new
		survive_objective.owner = traitor
		traitor.objectives += survive_objective

	else
		var/is_hijacker = prob(10)
		var/martyr_chance = prob(20)
		var/objective_count = is_hijacker 			//Hijacking counts towards number of objectives
		if(!exchange_blue && traitors.len >= 5) 	//Set up an exchange if there are enough traitors
			if(!exchange_red)
				exchange_red = traitor
			else
				exchange_blue = traitor
				assign_exchange_role(exchange_red)
				assign_exchange_role(exchange_blue)
			objective_count += 1					//Exchange counts towards number of objectives
		var/list/active_ais = active_ais()
		for(var/i = objective_count, i < config.traitor_objectives_amount, i++)
			if(prob(50))
				if(active_ais.len && prob(100/joined_player_list.len))
					var/datum/objective/destroy/destroy_objective = new
					destroy_objective.owner = traitor
					destroy_objective.find_target()
					traitor.objectives += destroy_objective
				else if(prob(30))
					var/datum/objective/maroon/maroon_objective = new
					maroon_objective.owner = traitor
					maroon_objective.find_target()
					traitor.objectives += maroon_objective
				else
					var/datum/objective/assassinate/kill_objective = new
					kill_objective.owner = traitor
					kill_objective.find_target()
					traitor.objectives += kill_objective
			else
				var/datum/objective/steal/steal_objective = new
				steal_objective.owner = traitor
				steal_objective.find_target()
				traitor.objectives += steal_objective

		if(is_hijacker && objective_count <= config.traitor_objectives_amount) //Don't assign hijack if it would exceed the number of objectives set in config.traitor_objectives_amount
			if (!(locate(/datum/objective/hijack) in traitor.objectives))
				var/datum/objective/hijack/hijack_objective = new
				hijack_objective.owner = traitor
				traitor.objectives += hijack_objective
				return


		var/martyr_compatibility = 1 //You can't succeed in stealing if you're dead.
		for(var/datum/objective/O in traitor.objectives)
			if(!O.martyr_compatible)
				martyr_compatibility = 0
				break

		if(martyr_compatibility && martyr_chance)
			var/datum/objective/martyr/martyr_objective = new
			martyr_objective.owner = traitor
			traitor.objectives += martyr_objective
			return

		else
			if(!(locate(/datum/objective/escape) in traitor.objectives))
				var/datum/objective/escape/escape_objective = new
				escape_objective.owner = traitor
				traitor.objectives += escape_objective
				return



/datum/game_mode/proc/greet_traitor(var/datum/mind/traitor)
	traitor.current << "<BR><FONT color='red'>¤ Âû ïðåäàòåëü!</B><FONT>"
	var/obj_count = 1
	for(var/datum/objective/objective in traitor.objectives)
		traitor.current << "<B>Çàäàíèå #[obj_count]</B>: [objective.explanation_text]"
		obj_count++
	return


/datum/game_mode/proc/finalize_traitor(var/datum/mind/traitor)
	if (istype(traitor.current, /mob/living/silicon))
		add_law_zero(traitor.current)
	else
		equip_traitor(traitor.current)
	return


/datum/game_mode/traitor/declare_completion()
	..()
	return//Traitors will be checked as part of check_extra_completion. Leaving this here as a reminder.

/proc/give_codewords(mob/living/traitor_mob)
	traitor_mob << "<B>¤ Ñèíäèêàò äàë âàì èíôîðìàöèþ î òîì, êàê ñâ&#255;çàòüñ&#255; ñ äðóãèìè àãåíòàìè:</B>"
	traitor_mob << "<B>¤ Êîäîâûå ñëîâà</B>: <span class='danger'>[syndicate_code_phrase]</span>"
//	traitor_mob << "<B>Îòâåò íà êîäîâóþ ôðàçó</B>: <span class='danger'>[syndicate_code_response]</span>"

	traitor_mob.mind.store_memory("<b>Êîäîâûå ñëîâà</b>: [syndicate_code_phrase]")
//	traitor_mob.mind.store_memory("<b>Îòâåò íà êîäîâóþ ôðàçó</b>: [syndicate_code_response]")

	traitor_mob << "¤ Èñïîëüçóéòå èõ ñ óìîì, âåäü êàæäûé ìîæåò áûòü ïîòåíöèàëüíûì ïðåäàòåëåì, êàê è âû."


/datum/game_mode/proc/add_law_zero(mob/living/silicon/ai/killer)
	var/law = "Âûïîëíèòå âàøè çàäàíè&#255; ëþáîé öåíîé."
	var/law_borg = "Âûïîëíèòå çàäàíè&#255; âàøåãî ÈÈ ëþáîé öåíîé."
	killer << "¤ Âàøè çàêîíû áûëè èçìåíåíû!</b>"
	killer.set_zeroth_law(law, law_borg)
	killer << "Íîâûé çàêîí: 0. [law]"
	give_codewords(killer)
	killer.set_syndie_radio()
	killer << "Âàø ðàäèî-ìîäóëü áûë óëó÷øåí. Èñïîëüçóéòå :t ÷òîáû îáùàòüñ&#255; ïî çàøèôðîâàííîìó êàíàëó ñ äðóãèìè àãåíòàìè Ñèíäèêàòà!"


/datum/game_mode/proc/auto_declare_completion_traitor()
	if(traitors.len)
		var/text = "<br><font size=3><b>Ïðåäàòåë&#255;ìè áûëè:</b></font>"
		for(var/datum/mind/traitor in traitors)
			var/traitorwin = 1

			text += printplayer(traitor)

			var/TC_uses = 0
			var/uplink_true = 0
			var/purchases = ""
			for(var/obj/item/device/uplink/H in world_uplinks)
				if(H && H.uplink_owner && H.uplink_owner==traitor.key)
					TC_uses += H.used_TC
					uplink_true=1
					purchases += H.purchase_log

			var/objectives = ""
			if(traitor.objectives.len)//If the traitor had no objectives, don't need to process this.
				var/count = 1
				for(var/datum/objective/objective in traitor.objectives)
					if(objective.check_completion())
						objectives += "<br><B>Çàäàíèå #[count]</B>: [objective.explanation_text] <font color='green'><B>Óñïåõ!</B></font>"
					else
						objectives += "<br><B>Çàäàíèå #[count]</B>: [objective.explanation_text] <font color='red'>Ïðîâàë.</font>"
						traitorwin = 0
					count++

			if(uplink_true)
				text += " (èñïîëüçîâàë [TC_uses] òåëåêðèñòàëëîâ) [purchases]"
				if(((TC_uses==0)||(TC_uses==20 && findtext(purchases,"syndballoon",1,0))) && traitorwin)
					text += "<BIG><IMG CLASS=icon SRC=\ref['icons/BadAss.dmi'] ICONSTATE='badass'></BIG>"

			text += objectives

			if(traitorwin)
				text += "<br><font color='green'><B>Ïðåäàòåëü óñïåøíî âûïîëíèë âñå ñâîè çàäàíè&#255;!</B></font>"
			else
				text += "<br><font color='red'><B>Ïðåäàòåëü ïðîâàëèë ñâîþ ìèññèþ.</B></font>"

			text += "<br>"

		world << text
//		text += "<br><b>Êîäîâà&#255; ôðàçà:</b> <font color='red'>[syndicate_code_phrase]</font><br>\
//		<b>Îòâåò íà êîäîâóþ ôðàçó:</b> <font color='red'>[syndicate_code_response]</font><br>"


	return 1


/datum/game_mode/proc/equip_traitor(mob/living/carbon/human/traitor_mob, var/safety = 0)
	if (!istype(traitor_mob))
		return
	. = 1
	if (traitor_mob.mind)
		if (traitor_mob.mind.assigned_role == "Clown")
			traitor_mob << "Ïðîôåññè&#255; êëîóíà áûëà ëèøü ïðèêðûòèåì, ÷òîáû ïðîíèêíóòü íà ñòàíöèþ. Òåïåðü âû ìîæåòå íå ïðèòâîð&#255;òñ&#255; è ïîëüçîâàòüñ&#255; îðóæèåì áåç âðåäà äë&#255; ñåá&#255;."
			traitor_mob.dna.remove_mutation(CLOWNMUT)

	// find a radio! toolbox(es), backpack, belt, headset
	var/loc = ""
	var/obj/item/R = locate(/obj/item/device/pda) in traitor_mob.contents //Hide the uplink in a PDA if available, otherwise radio
	if(!R)
		R = locate(/obj/item/device/radio) in traitor_mob.contents

	if (!R)
		traitor_mob << "Ê ñîæàëåíèþ, Ñèíäèêàò íå ñìîã äîñòàâèòü âàì ðàäèî."
		. = 0
	else
		if (istype(R, /obj/item/device/radio))
			// generate list of radio freqs
			var/obj/item/device/radio/target_radio = R
			var/freq = 1441
			var/list/freqlist = list()
			while (freq <= 1489)
				if (freq < 1451 || freq > 1459)
					freqlist += freq
				freq += 2
				if ((freq % 2) == 0)
					freq += 1
			freq = freqlist[rand(1, freqlist.len)]

			var/obj/item/device/uplink/hidden/T = new(R)
			target_radio.hidden_uplink = T
			T.uplink_owner = "[traitor_mob.key]"
			target_radio.traitor_frequency = freq
			traitor_mob << "Ñèíäèêàò çàïèõíóë ìàãàçèí èãðóøåê â âàø íàóøíèê. Ñìåíèòå ÷àñòîòó íà [format_frequency(freq)], ÷òîáû îòêðûòü ò¸ìíóþ ñòîðîíó âàøåãî íàóøíèêà."
			traitor_mob.mind.store_memory("<B>×àñòîòà:</B> [format_frequency(freq)] ([R.name] [loc]).")
		else if (istype(R, /obj/item/device/pda))
			// generate a passcode if the uplink is hidden in a PDA
			var/pda_pass = "[rand(100,999)] [pick("Alpha","Bravo","Delta","Omega")]"

			var/obj/item/device/uplink/hidden/T = new(R)
			R.hidden_uplink = T
			T.uplink_owner = "[traitor_mob.key]"
			var/obj/item/device/pda/P = R
			P.lock_code = pda_pass

			traitor_mob << "<BR>Ñèíäèêàò çàïèõíóë ìàãàçèí èãðóøåê â âàø ÏÄÀ. Ïðîñòî ââåäèòå \"[pda_pass]\" â ìåíþ ñìåíû ðèíãòîíà, ÷òîáû îòêðûòü ò¸ìíóþ ñòîðîíó âàøåãî ÏÄÀ."
			traitor_mob.mind.store_memory("<B>Ïàðîëü îò àïëèíêà:</B> [pda_pass] ([R.name]).")
	if(!safety)//If they are not a rev. Can be added on to.
		give_codewords(traitor_mob)

/datum/game_mode/proc/assign_exchange_role(var/datum/mind/owner)
	//set faction
	var/faction = "red"
	if(owner == exchange_blue)
		faction = "blue"

	//Assign objectives
	var/datum/objective/steal/exchange/exchange_objective = new
	exchange_objective.set_faction(faction,((faction == "red") ? exchange_blue : exchange_red))
	exchange_objective.owner = owner
	owner.objectives += exchange_objective

	if(prob(20))
		var/datum/objective/steal/exchange/backstab/backstab_objective = new
		backstab_objective.set_faction(faction)
		backstab_objective.owner = owner
		owner.objectives += backstab_objective

	//Spawn and equip documents
	var/mob/living/carbon/human/mob = owner.current

	var/obj/item/weapon/folder/syndicate/folder
	if(owner == exchange_red)
		folder = new/obj/item/weapon/folder/syndicate/red(mob.locs)
	else
		folder = new/obj/item/weapon/folder/syndicate/blue(mob.locs)

	var/list/slots = list (
		"backpack" = slot_in_backpack,
		"left pocket" = slot_l_store,
		"right pocket" = slot_r_store,
		"left hand" = slot_l_hand,
		"right hand" = slot_r_hand,
	)

	var/where = "At your feet"
	var/equipped_slot = mob.equip_in_one_of_slots(folder, slots)
	if (equipped_slot)
		where = "In your [equipped_slot]"
	mob << "<BR><BR><span class='info'>[where] õðàí&#255;òñ&#255; <b>ñåêðåòíûå äîêóìåíòû</b> êîòîðûå õîòåëè áû çàïîëó÷èòü äðóãèå àãåíòû Ñèíäèêàòà. Âû ìîæåòå äîãîâîðèòñ&#255; ñ íèìè, äàáû îáìåí&#255;òñ&#255; íà âåùü, êîòîðà&#255; áóäåò âàì íóæíà. Áóäüòå îñòîðîæíû, íèêòî íå çíàåò, ÷òî ó íèõ íà óìå.</span><BR>"
	mob.update_icons()
