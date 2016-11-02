
//Defines copying names of mutations in all cases, make sure to change this if you change mutation's name
#define HULK		"Hulk"
#define XRAY		"X Ray Vision"
#define COLDRES		"Cold Resistance"
#define TK			"Telekinesis"
#define NERVOUS		"Nervousness"
#define EPILEPSY	"Epilepsy"
#define MUTATE		"Unstable DNA"
#define COUGH		"Cough"
#define CLOWNMUT	"Clumsiness"
#define TOURETTES	"Tourettes Syndrome"
#define DEAFMUT		"Deafness"
#define BLINDMUT	"Blindness"
#define RACEMUT		"Monkified"
#define BADSIGHT	"Near Sightness"
#define LASEREYES	"Laser Eyes"
#define STEALTH		"Cloak Of Darkness"
#define CHAMELEON	"Chameleon"
#define WACKY		"Wacky"
#define MUT_MUTE	"Mute"
#define SMILE		"Smile"
#define UNINTELLIGABLE		"Unintelligable"
#define SWEDISH		"Swedish"
#define CHAV		"Chav"
#define ELVIS		"Elvis"

// String identifiers for associative list lookup

//Types of usual mutations
#define	POSITIVE 			1
#define	NEGATIVE			2
#define	MINOR_NEGATIVE		3

//Mutations that cant be taken from genetics and are not in SE
#define	NON_SCANNABLE		-1

	// Extra powers:
#define LASER			9 	// harm intent - click anywhere to shoot lasers from eyes
#define HEAL			10 	// healing people with hands
#define SHADOW			11 	// shadow teleportation (create in/out portals anywhere) (25%)
#define SCREAM			12 	// supersonic screaming (25%)
#define EXPLOSIVE		13 	// exploding on-demand (15%)
#define REGENERATION	14 	// superhuman regeneration (30%)
#define REPROCESSOR		15 	// eat anything (50%)
#define SHAPESHIFTING	16 	// take on the appearance of anything (40%)
#define PHASING			17 	// ability to phase through walls (40%)
#define SHIELD			18 	// shielding from all projectile attacks (30%)
#define SHOCKWAVE		19 	// attack a nearby tile and cause a massive shockwave, knocking most people on their asses (25%)
#define ELECTRICITY		20 	// ability to shoot electric attacks (15%)

//DNA - Because fuck you and your magic numbers being all over the codebase.
#define DNA_BLOCK_SIZE				3

#define DNA_UNI_IDENTITY_BLOCKS		7
#define DNA_HAIR_COLOR_BLOCK		1
#define DNA_FACIAL_HAIR_COLOR_BLOCK	2
#define DNA_SKIN_TONE_BLOCK			3
#define DNA_EYE_COLOR_BLOCK			4
#define DNA_GENDER_BLOCK			5
#define DNA_FACIAL_HAIR_STYLE_BLOCK	6
#define DNA_HAIR_STYLE_BLOCK		7

#define DNA_STRUC_ENZYMES_BLOCKS	23
#define DNA_UNIQUE_ENZYMES_LEN		32

//Transformation proc stuff
#define TR_KEEPITEMS	1
#define TR_KEEPVIRUS	2
#define TR_KEEPDAMAGE	4
#define TR_HASHNAME		8	// hashing names (e.g. monkey(e34f)) (only in monkeyize)
#define TR_KEEPIMPLANTS	16
#define TR_KEEPSE		32 // changelings shouldn't edit the DNA's SE when turning into a monkey
#define TR_DEFAULTMSG	64
#define TR_KEEPSRC		128

//Organ stuff, It's here because "Genetics" is the most relevant file for organs
#define ORGAN_ORGANIC   1
#define ORGAN_ROBOTIC   2

//Organ states
#define ORGAN_FINE		1
#define ORGAN_REMOVED	2

//Nutrition levels for humans. No idea where else to put it
#define NUTRITION_LEVEL_FAT 600
#define NUTRITION_LEVEL_FULL 550
#define NUTRITION_LEVEL_WELL_FED 450
#define NUTRITION_LEVEL_FED 350
#define NUTRITION_LEVEL_HUNGRY 250
#define NUTRITION_LEVEL_STARVING 150

#define WATER_LEVEL_NORMAL	300
#define WATER_LEVEL_THIRSTY	200
#define WATER_LEVEL_DEHYDRATED 100

//spacewine behavior owerrides flags. They're prodused by mutations, so have to do with genetics, right?
#define SPACEVINE_BEHAVIOR_INERT 1              //universal. means that those vines in this situation DO NOT HAVE ANY REACTOION. oblivios, isnt it?
//hit, temperature change and such
#define SPACEVINE_BEHAVIOR_TOUGH 2              //wont break by sharp tools
#define SPACEVINE_BEHAVIOR_FRAGILE 4            //will break by any brute damage weapons
#define SPACEVINE_BEHAVIOR_INCOMBUSTIBLE 8      //wont break by weldingtools and fire
#define SPACEVINE_BEHAVIOR_IGNITABLE 16         //will break by any fire damege weapons
#define SPACEVINE_BEHAVIOR_REAGENT_PRODUCING 32 //hawe harvestable reagents
//spread
#define SPACEVINE_BEHAVIOR_FORSE_GROWH 2        //will growh on despite blockings
#define SPACEVINE_BEHAVIOR_GEN_SATABLE 4      //don't mutate futher
#define SPACEVINE_BEHAVIOR_GEN_MUTATIVE 8     //have higterchanse for mutation. notice that it's also used as constant
#define SPACEVINE_BEHAVIOR_GEN_REGRESSIVE 16  //lose mutations insted of geting them
//chems
#define SPACEVINE_BEHAVIOR_HERBICIDE_IMMUNE 2   //wont break by herbicide
#define SPACEVINE_BEHAVIOR_ACID_IMMUNE 4        //I think this won't work, but, anyway
#define SPACEVINE_BEHAVIOR_HYDROPHOBIC 8        //will break by water
//processing
#define SPACEVINE_PROCESSING_GROWING_FAST 2     //take half the resorse to grow
#define SPACEVINE_PROCESSING_GROWING_SLOW 4     //take twice the resorse to grow
#define SPACEVINE_PROCESSING_SHORT_LIVING 8     //stop processing after fully grown
