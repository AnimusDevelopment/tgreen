/obj/item/clothing/under/color
	desc = "A standard issue colored jumpsuit. Variety is the spice of life!"

/obj/item/clothing/under/color/random/New()
	..()
	var/list/excluded = list(/obj/item/clothing/under/color/random, /obj/item/clothing/under/color)
	var/obj/item/clothing/under/color/C = pick(typesof(/obj/item/clothing/under/color) - excluded)
	name = initial(C.name)
	icon_state = initial(C.icon_state)
	item_state = initial(C.item_state)
	item_color = initial(C.item_color)
	suit_color = initial(C.item_color)

/obj/item/clothing/under/color/black
	r_name = "������ ����������"
	name = "black jumpsuit"
	icon_state = "black"
	item_state = "bl_suit"
	item_color = "black"

/obj/item/clothing/under/color/grey
	r_name = "����� ����������"
	name = "grey jumpsuit"
	desc = "A tasteful grey jumpsuit that reminds you of the good old days."
	icon_state = "grey"
	item_state = "gy_suit"
	item_color = "grey"

/obj/item/clothing/under/color/blue
	r_name = "����� ����������"
	name = "blue jumpsuit"
	icon_state = "blue"
	item_state = "b_suit"
	item_color = "blue"

/obj/item/clothing/under/color/green
	r_name = "������ ����������"
	name = "green jumpsuit"
	icon_state = "green"
	item_state = "g_suit"
	item_color = "green"

/obj/item/clothing/under/color/orange
	r_name = "��������� ����������"
	name = "orange jumpsuit"
	desc = "Don't wear this near paranoid security officers."
	icon_state = "orange"
	item_state = "o_suit"
	item_color = "orange"

/obj/item/clothing/under/color/pink
	r_name = "������� ����������"
	name = "pink jumpsuit"
	icon_state = "pink"
	desc = "Just looking at this makes you feel <i>fabulous</i>."
	item_state = "p_suit"
	item_color = "pink"

/obj/item/clothing/under/color/red
	r_name = "������� ����������"
	name = "red jumpsuit"
	icon_state = "red"
	item_state = "r_suit"
	item_color = "red"

/obj/item/clothing/under/color/white
	r_name = "����� ����������"
	name = "white jumpsuit"
	icon_state = "white"
	item_state = "w_suit"
	item_color = "white"

/obj/item/clothing/under/color/yellow
	r_name = "������ ����������"
	name = "yellow jumpsuit"
	icon_state = "yellow"
	item_state = "y_suit"
	item_color = "yellow"

/obj/item/clothing/under/color/lightblue
	r_name = "������� ����������"
	name = "lightblue jumpsuit"
	icon_state = "lightblue"
	item_state = "b_suit"
	item_color = "lightblue"

/obj/item/clothing/under/color/aqua
	r_name = "������������� ����������"
	name = "aqua jumpsuit"
	icon_state = "aqua"
	item_state = "b_suit"
	item_color = "aqua"

/obj/item/clothing/under/color/purple
	r_name = "���������� ����������"
	name = "purple jumpsuit"
	icon_state = "purple"
	item_state = "p_suit"
	item_color = "purple"

/obj/item/clothing/under/color/lightpurple
	r_name = "��������� ����������"
	name = "lightpurple jumpsuit"
	icon_state = "lightpurple"
	item_state = "p_suit"
	item_color = "lightpurple"

/obj/item/clothing/under/color/lightgreen
	r_name = "������-������ ����������"
	name = "lightgreen jumpsuit"
	icon_state = "lightgreen"
	item_state = "g_suit"
	item_color = "lightgreen"

/obj/item/clothing/under/color/lightbrown
	r_name = "������-���������� ����������"
	name = "lightbrown jumpsuit"
	icon_state = "lightbrown"
	item_state = "lb_suit"
	item_color = "lightbrown"

/obj/item/clothing/under/color/brown
	r_name = "���������� ����������"
	name = "brown jumpsuit"
	icon_state = "brown"
	item_state = "lb_suit"
	item_color = "brown"

/obj/item/clothing/under/color/yellowgreen
	r_name = "����-������ ����������"
	name = "yellowgreen jumpsuit"
	icon_state = "yellowgreen"
	item_state = "y_suit"
	item_color = "yellowgreen"

/obj/item/clothing/under/color/darkblue
	r_name = "����-����� ����������"
	name = "darkblue jumpsuit"
	icon_state = "darkblue"
	item_state = "b_suit"
	item_color = "darkblue"

/obj/item/clothing/under/color/lightred
	r_name = "&#255;���-��������� ����������"
	name = "lightred jumpsuit"
	icon_state = "lightred"
	item_state = "r_suit"
	item_color = "lightred"

/obj/item/clothing/under/color/darkred
	r_name = "����-������� ����������"
	name = "darkred jumpsuit"
	icon_state = "darkred"
	item_state = "r_suit"
	item_color = "darkred"

/obj/item/clothing/under/color/maroon
	r_name = "�������� ����������"
	name = "maroon jumpsuit"
	icon_state = "maroon"
	item_state = "r_suit"
	item_color = "maroon"