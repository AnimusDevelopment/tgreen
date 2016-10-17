
/datum/chemical_reaction/leporazine
	name = "Leporazine"
	id = "leporazine"
	result = "leporazine"
	required_reagents = list("silicon" = 1, "copper" = 1)
	required_catalysts = list("plasma" = 5)
	result_amount = 2

/datum/chemical_reaction/rezadone
	name = "Rezadone"
	id = "rezadone"
	result = "rezadone"
	required_reagents = list("carpotoxin" = 1, "cryptobiolin" = 1, "copper" = 1)
	result_amount = 3

/datum/chemical_reaction/spaceacillin
	name = "Spaceacillin"
	id = "spaceacillin"
	result = "spaceacillin"
	required_reagents = list("cryptobiolin" = 1, "epinephrine" = 1)
	result_amount = 2

/datum/chemical_reaction/inacusiate
	name = "inacusiate"
	id = "inacusiate"
	result = "inacusiate"
	required_reagents = list("water" = 1, "carbon" = 1, "charcoal" = 1)
	result_amount = 2

/datum/chemical_reaction/synaptizine
	name = "Synaptizine"
	id = "synaptizine"
	result = "synaptizine"
	required_reagents = list("sugar" = 1, "lithium" = 1, "water" = 1)
	result_amount = 3

/datum/chemical_reaction/charcoal
	name = "Charcoal"
	id = "charcoal"
	result = "charcoal"
	required_reagents = list("ash" = 1, "sodiumchloride" = 1)
	result_amount = 2
	mix_message = "The mixture yields a fine black powder."
	required_temp = 380

/datum/chemical_reaction/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	id = "silver_sulfadiazine"
	result = "silver_sulfadiazine"
	required_reagents = list("ammonia" = 1, "silver" = 1, "sulfur" = 1, "oxygen" = 1, "chlorine" = 1)
	result_amount = 5

/datum/chemical_reaction/salglu_solution
	name = "Saline-Glucose Solution"
	id = "salglu_solution"
	result = "salglu_solution"
	required_reagents = list("sodiumchloride" = 1, "water" = 1, "sugar" = 1)
	result_amount = 3

/datum/chemical_reaction/synthflesh
	name = "Synthflesh"
	id = "synthflesh"
	result = "synthflesh"
	required_reagents = list("blood" = 1, "carbon" = 1, "styptic_powder" = 1)
	result_amount = 3

/datum/chemical_reaction/styptic_powder
	name = "Styptic Powder"
	id = "styptic_powder"
	result = "styptic_powder"
	required_reagents = list("aluminium" = 1, "hydrogen" = 1, "oxygen" = 1, "sacid" = 1)
	result_amount = 4
	mix_message = "The solution yields an astringent powder."

/datum/chemical_reaction/calomel
	name = "Calomel"
	id = "calomel"
	result = "calomel"
	required_reagents = list("mercury" = 1, "chlorine" = 1)
	result_amount = 2
	required_temp = 374

/datum/chemical_reaction/potass_iodide
	name = "Potassium Iodide"
	id = "potass_iodide"
	result = "potass_iodide"
	required_reagents = list("potassium" = 1, "iodine" = 1)
	result_amount = 2

/datum/chemical_reaction/pen_acid
	name = "Pentetic Acid"
	id = "pen_acid"
	result = "pen_acid"
	required_reagents = list("fuel" = 1, "chlorine" = 1, "ammonia" = 1, "formaldehyde" = 1, "sodium" = 1, "cyanide" = 1)
	result_amount = 6

/datum/chemical_reaction/sal_acid
	name = "Salicyclic Acid"
	id = "sal_acid"
	result = "sal_acid"
	required_reagents = list("sodium" = 1, "phenol" = 1, "carbon" = 1, "oxygen" = 1, "sacid" = 1)
	result_amount = 5


/datum/chemical_reaction/salbutamol
	name = "Salbutamol"
	id = "salbutamol"
	result = "salbutamol"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminium" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5

/datum/chemical_reaction/perfluorodecalin
	name = "Perfluorodecalin"
	id = "perfluorodecalin"
	result = "perfluorodecalin"
	required_reagents = list("hydrogen" = 1, "fluorine" = 1, "oil" = 1)
	result_amount = 3
	required_temp = 370
	mix_message = "The mixture rapidly turns into a dense pink liquid."

/datum/chemical_reaction/ephedrine
	name = "Ephedrine"
	id = "ephedrine"
	result = "ephedrine"
	required_reagents = list("sugar" = 1, "oil" = 1, "hydrogen" = 1, "diethylamine" = 1)
	result_amount = 4
	mix_message = "The solution fizzes and gives off toxic fumes."

/datum/chemical_reaction/diphenhydramine
	name = "Diphenhydramine"
	id = "diphenhydramine"
	result = "diphenhydramine"
	required_reagents = list("oil" = 1, "carbon" = 1, "bromine" = 1, "diethylamine" = 1, "ethanol" = 1)
	result_amount = 4
	mix_message = "The mixture dries into a pale blue powder."

/datum/chemical_reaction/oculine
	name = "Oculine"
	id = "oculine"
	result = "oculine"
	required_reagents = list("charcoal" = 1, "carbon" = 1, "hydrogen" = 1)
	result_amount = 3
	mix_message = "The mixture sputters loudly and becomes a pale pink color."

/datum/chemical_reaction/atropine
	name = "Atropine"
	id = "atropine"
	result = "atropine"
	required_reagents = list("ethanol" = 1, "acetone" = 1, "diethylamine" = 1, "phenol" = 1, "sacid" = 1)
	result_amount = 5

/datum/chemical_reaction/epinephrine
	name = "Epinephrine"
	id = "epinephrine"
	result = "epinephrine"
	required_reagents = list("phenol" = 1, "acetone" = 1, "diethylamine" = 1, "oxygen" = 1, "chlorine" = 1, "hydrogen" = 1)
	result_amount = 6

/datum/chemical_reaction/strange_reagent
	name = "Strange Reagent"
	id = "strange_reagent"
	result = "strange_reagent"
	required_reagents = list("omnizine" = 1, "holywater" = 1, "mutagen" = 1)
	result_amount = 3

/datum/chemical_reaction/mannitol
	name = "Mannitol"
	id = "mannitol"
	result = "mannitol"
	required_reagents = list("sugar" = 1, "hydrogen" = 1, "water" = 1)
	result_amount = 3
	mix_message = "The solution slightly bubbles, becoming thicker."

/datum/chemical_reaction/mutadone
	name = "Mutadone"
	id = "mutadone"
	result = "mutadone"
	required_reagents = list("mutagen" = 1, "acetone" = 1, "bromine" = 1)
	result_amount = 3

/datum/chemical_reaction/antihol
	name = "antihol"
	id = "antihol"
	result = "antihol"
	required_reagents = list("ethanol" = 1, "charcoal" = 1, "copper" = 1)
	result_amount = 3

/datum/chemical_reaction/cryoxadone
	name = "Cryoxadone"
	id = "cryoxadone"
	result = "cryoxadone"
	required_reagents = list("stable_plasma" = 1, "acetone" = 1, "mutagen" = 1)
	result_amount = 3

/datum/chemical_reaction/haloperidol
	name = "Haloperidol"
	id = "haloperidol"
	result = "haloperidol"
	required_reagents = list("chlorine" = 1, "fluorine" = 1, "aluminium" = 1, "potass_iodide" = 1, "oil" = 1)
	result_amount = 5

/datum/chemical_reaction/hyronalin
	name="Hyronalin"
	id="hyronalin"
	result="hyronalin"
	required_reagents=list("anti_toxin"=1,"radium"=1)
	result_amount=2

/datum/chemical_reaction/arithrazine
	name = "Arithrazine"
	id = "arithrazine"
	result = "arithrazine"
	required_reagents = list("hyronalin" = 1, "hydrogen" = 1)
	result_amount = 2


/datum/chemical_reaction/kelotane
	name = "Kelotane"
	id = "kelotane"
	result = "kelotane"
	required_reagents = list("silicon" = 1, "carbon" = 1)
	result_amount = 2

/datum/chemical_reaction/leporazine
	name = "Leporazine"
	id = "leporazine"
	result = "leporazine"
	required_reagents = list("silicon" = 1, "copper" = 1)
	required_catalysts = list("plasma" = 5)
	result_amount = 2


/datum/chemical_reaction/tricordrazine
	name = "Tricordrazine"
	id = "tricordrazine"
	result = "tricordrazine"
	required_reagents = list("inaprovaline" = 1, "anti_toxin" = 1)
	result_amount = 2

/datum/chemical_reaction/alkysine
	name = "Alkysine"
	id = "alkysine"
	result = "alkysine"
	required_reagents = list("chlorine" = 1, "nitrogen" = 1, "anti_toxin" = 1)
	result_amount = 2

/datum/chemical_reaction/dexalin
	name = "Dexalin"
	id = "dexalin"
	result = "dexalin"
	required_reagents = list("oxygen" = 2)
	required_catalysts = list("plasma" = 5)
	result_amount = 1

/datum/chemical_reaction/dermaline
	name = "Dermaline"
	id = "dermaline"
	result = "dermaline"
	required_reagents = list("oxygen" = 1, "phosphorus" = 1, "kelotane" = 1)
	result_amount = 3

/datum/chemical_reaction/dexalinp
	name = "Dexalin Plus"
	id = "dexalinp"
	result = "dexalinp"
	required_reagents = list("dexalin" = 1, "carbon" = 1, "iron" = 1)
	result_amount = 3

/datum/chemical_reaction/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	result = "bicaridine"
	required_reagents = list("inaprovaline" = 1, "carbon" = 1)
	result_amount = 2

/datum/chemical_reaction/hyperzine
	name = "Hyperzine"
	id = "hyperzine"
	result = "hyperzine"
	required_reagents = list("sugar" = 1, "phosphorus" = 1, "sulfur" = 1,)
	result_amount = 3

/datum/chemical_reaction/ryetalyn
	name = "Ryetalyn"
	id = "ryetalyn"
	result = "ryetalyn"
	required_reagents = list("arithrazine" = 1, "carbon" = 1)
	result_amount = 2

/datum/chemical_reaction/inaprovaline
	name = "Inaprovaline"
	id = "inaprovaline"
	result = "inaprovaline"
	required_reagents = list("oxygen" = 1, "carbon" = 1, "sugar" = 1)
	result_amount = 3

/datum/chemical_reaction/anti_toxin
	name = "Anti-Toxin (Dylovene)"
	id = "anti_toxin"
	result = "anti_toxin"
	required_reagents = list("silicon" = 1, "potassium" = 1, "nitrogen" = 1)
	result_amount = 3

/*datum/chemical_reaction/ethylredoxrazine
	name = "Ethylredoxrazine"
	id = "ethylredoxrazine"
	result = "ethylredoxrazine"
	required_reagents = list("oxygen" = 1, "anti_toxin" = 1, "carbon" = 1)
	result_amount = 3

not now

/datum/chemical_reaction/ethanoloxidation
	name = "ethanoloxidation"	//Kind of a placeholder in case someone ever changes it so that chemicals
	id = "ethanoloxidation"		//	react in the body. Also it would be silly if it didn't exist.
	result = "water"
	required_reagents = list("ethylredoxrazine" = 1, "ethanol" = 1)
	result_amount = 2 */

/datum/chemical_reaction/stoxin
	name = "Sleep Toxin"
	id = "stoxin"
	result = "stoxin"
	required_reagents = list("chloralhydrate" = 1, "sugar" = 4)
	result_amount = 5