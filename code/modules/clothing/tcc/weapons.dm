#define TCC_WEAPON_OVERRIDE 'icons/obj/gun.dmi'

/obj/item/weapon/gun/projectile/automatic/tcc/smg
	name = "Mako SMG"
	desc = "The Mako SMG is a lightweight and rapid firing SMG, for when you REALLY need someone dead. Uses 9mm rounds. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp."
	icon_state = "tcc_smg"
	item_state = "tcc_smg"
	slot_flags = SLOT_BACK|SLOT_BELT
	w_class = ITEM_SIZE_LARGE
	force = 10
	throwforce = 10
	accuracy = -1
	caliber = "10mm"
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	slot_flags = SLOT_BELT|SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/box/c9mm/_20
	allowed_magazines = /obj/item/ammo_magazine/box/c9mm/_20
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	one_hand_penalty = 1
	wielded_item_state = "gun_wielded"

	//SMG
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=3, one_hand_penalty=2, burst_accuracy=0, dispersion=0.0),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-2,-2),       dispersion=list(0.0, 0.6, 1.0), jam_chance=10),
		list(mode_name="short bursts",   burst=5, fire_delay=null, move_delay=4,    one_hand_penalty=4, burst_accuracy=list(0,-2,-2,-3,-3), dispersion=list(0.6, 0.6, 1.0, 1.0, 1.2), jam_chance=15),
		)

/obj/item/weapon/gun/projectile/automatic/tcc/smg/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "tcc_smg"
	else
		icon_state = "tcc_smg_unloaded"
	return

/obj/item/weapon/gun/projectile/automatic/tcc/lmg
	name = "'Great White' LMG"
	desc = "A rather traditionally made LMG. Has 'Aussec Armoury- 2531' engraved on the reciever." //probably should refluff this
	icon_state = "tcc_lmg"
	item_state = "tcc_lmg"
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	force = 15
	throwforce = 15
	accuracy = -1
	slot_flags = 0
	max_shells = 50
	caliber = "a556"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = 0 //need sprites for SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/box/machinegun
	allowed_magazines = list(/obj/item/ammo_magazine/box/machinegun)
	one_hand_penalty = 6
	wielded_item_state = "gun_wielded"

	//LMG, better sustained fire accuracy than assault rifles (comparable to SMG), higer move delay and one-handing penalty
	//No single-shot or 3-round-burst modes since using this weapon should come at a cost to flexibility.
	firemodes = list(
		list(mode_name="short bursts",	burst=5, move_delay=12, one_hand_penalty=8, burst_accuracy = list(-1,-3,-3,-2,-3),          dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2), jam_chance=15),
		list(mode_name="long bursts",	burst=8, move_delay=15, one_hand_penalty=9, burst_accuracy = list(-1,-3,-3,-2,-3,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2), jam_chance=20),
		)

	var/cover_open = 0

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/mag
	magazine_type = /obj/item/ammo_magazine/box/machinegun

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/special_check(mob/user)
	if(cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is open! Close it before firing!</span>")
		return 0
	return ..()

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/proc/toggle_cover(mob/user)
	cover_open = !cover_open
	to_chat(user, "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>")
	update_icon()

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/attack_self(mob/user as mob)
	if(cover_open)
		toggle_cover(user) //close the cover
	else
		return ..() //once closed, behave like normal

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/attack_hand(mob/user as mob)
	if(!cover_open && user.get_inactive_hand() == src)
		toggle_cover(user) //open the cover
	else
		return ..() //once open, behave like normal

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/update_icon()
	if(istype(ammo_magazine, /obj/item/ammo_magazine/box))
		icon_state = "tcc_lmg"
		item_state = "tcc_lmg"
	else if(ammo_magazine)
		icon_state = "tcc_lmg"
		item_state = "tcc_lmg"
	else
		icon_state = "tcc_lmg_unloaded"
		item_state = "tcc_lmg_unloaded"
	..()

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/load_ammo(var/obj/item/A, mob/user)
	if(!cover_open)
		to_chat(user, "<span class='warning'>You need to open the cover to load that into [src].</span>")
		return
	..()

/obj/item/weapon/gun/projectile/automatic/tcc/lmg/unload_ammo(mob/user, var/allow_dump=1)
	if(!cover_open)
		to_chat(user, "<span class='warning'>You need to open the cover to unload [src].</span>")
		return
	..()

/obj/item/weapon/gun/projectile/automatic/tcc/arifle
	name = "Goblin Assault Rifle"
	desc = "The rugged STS-35 is a durable automatic weapon of a make popular weapons of choice in frontier conflicts. Uses 5.56mm rounds."
	icon_state = "tcc_assault"
	item_state = "tcc_assault"
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	force = 15
	throwforce = 15
	accuracy = -1
	caliber = "a556"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/box/c556
	allowed_magazines = /obj/item/ammo_magazine/box/c556
	one_hand_penalty = 3
	wielded_item_state = "gun_wielded"

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=5, one_hand_penalty=4, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=6,    one_hand_penalty=5, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0), jam_chance=10),
		list(mode_name="short bursts",   burst=5, fire_delay=null, move_delay=6,    one_hand_penalty=6, burst_accuracy=list(0,-1,-2,-3,-3), dispersion=list(0.6, 1.0, 1.2, 1.2, 1.5), jam_chance=15),
		)

/obj/item/weapon/gun/projectile/automatic/tcc/arifle/update_icon()
	icon_state = (ammo_magazine)? "tcc_assault" : "tcc_assault_unloaded"
	wielded_item_state = (ammo_magazine)? "tcc_assault" : "tcc_assault_unloaded"
	..()

/obj/item/weapon/gun/projectile/shotgun/tcc/shotgun
	name = "Bull Shotgun"
	desc = "Built for close quarters combat, the Hephaestus Industries KS-40 is widely regarded as a weapon of choice for repelling boarders."
	icon_state = "tcc_shotgun"
	item_state = "tcc_shotgun"
	load_method = SINGLE_CASING|SPEEDLOADER
	slot_flags = SLOT_BACK
	force = 15
	throwforce = 15
	accuracy = -1
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	max_shells = 3 //match the ammo box capacity, also it can hold a round in the chamber anyways, for a total of 8.
	burst	   = 3
	burst_delay = 0
	loaded = list(/obj/item/ammo_casing/shotgun/pellet, /obj/item/ammo_casing/shotgun)
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	one_hand_penalty = 4 //a little heavier than the regular shotgun
	wielded_item_state = "gun_wielded"

	firemodes = list(
		list(mode_name="fire 1 barrel",       burst=1, fire_delay=0,    move_delay=5, one_hand_penalty=4, burst_accuracy=null, dispersion=0.0),
		list(mode_name="fire 2 barrels",       burst=2, fire_delay=0,    move_delay=6, one_hand_penalty=4, burst_accuracy=null, dispersion=0.0, 0.6),
		list(mode_name="fire 3 barrels",       burst=3, fire_delay=0,    move_delay=6, one_hand_penalty=4, burst_accuracy=null, dispersion=0.0, 0.6, 1.2)
		)

/obj/item/weapon/gun/projectile/automatic/tcc/dmr
	name = "Tigerfin DMR"
	desc = "The rugged STS-35 is a durable automatic weapon of a make popular weapons of choice in frontier conflicts. Uses 5.56mm rounds."
	icon_state = "tcc_dmr"
	item_state = "tcc_dmr"
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	force = 15
	throwforce = 15
	accuracy = -1
	caliber = "a762"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/box/c762
	allowed_magazines = /obj/item/ammo_magazine/box/c762
	one_hand_penalty = 3
	wielded_item_state = "gun_wielded"

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=5, one_hand_penalty=4, burst_accuracy=null, dispersion=0.0),
		)

/obj/item/weapon/gun/projectile/automatic/tcc/dmr/update_icon()
	icon_state = (ammo_magazine)? "tcc_dmr" : "tcc_dmr_unloaded"
	wielded_item_state = (ammo_magazine)? "tcc_dmr" : "tcc_dmr_unloaded"
	..()

//obj/item/weapon/gun/energy/tcc/pulse_rifle
//	name = "X-39 Prototype Thermal Projector"
//	desc = "A weapon that uses advanced pulse-based beam generation technology to emit powerful laser blasts. Because of its complexity and cost, it is rarely seen in use except by specialists."
//	icon_state = "tcclaser"
//	item_state = "tcclaser"
//	slot_flags = SLOT_BACK
//	force = 15
//	throwforce = 15
//	projectile_type = /obj/item/projectile/tcc/thermal
//	max_shots = 9
//	w_class = ITEM_SIZE_HUGE
//	one_hand_penalty= 6
//	multi_aim = 1
//	burst_delay = 0
//	burst = 1
//	move_delay = 4
//	accuracy = -1
//	wielded_item_state = "gun_wielded"

/obj/item/weapon/gun/launcher/grenade/tcc/glauncher
	name = "Hammerhead Grenade Launcher"
	desc = "A bulky pump-action grenade launcher. Holds up to 6 grenades in a revolving magazine."
	icon_state = "tcc_grenadelauncher"
	item_state = "tcc_grenadelauncher"
	w_class = ITEM_SIZE_HUGE
	force = 15
	throwforce = 15
	fire_sound = 'sound/weapons/empty.ogg'
	fire_sound_text = "a metallic thunk"
	screen_shake = 0
	throw_distance = 7
	release_force = 5
	max_grenades = 5
	matter = list(MATERIAL_STEEL = 2000)
	wielded_item_state = "gun_wielded"
	whitelisted_grenades = list(
		/obj/item/weapon/grenade/frag/shell,
		/obj/item/weapon/grenade/frag,
		/obj/item/weapon/grenade/frag/high_yield)