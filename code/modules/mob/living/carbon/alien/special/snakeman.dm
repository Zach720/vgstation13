/mob/living/carbon/alien/humanoid/special/snakeman
	name = "Snakeman"
	desc = "This race developed in an extremely hostile environment. They are extremely tough and can resist extreme temperature variations. Their mobility depends on a snake-like giant \"foot\" which protects all the vital organs. "
	xcom_state = "snake"

	movement_delay()
		return 4

/mob/living/carbon/alien/humanoid/special/snakeman/verb/lay_egg(mob/living/carbon/human/M as mob)
	set name = "Impregnate"
	set desc = "Lays an egg on a corpse, allowing the egg to feed."
	set category = "Snakeman"

	set src = view(0)

	if(stat)
		return

	if(!M)
		return

	if(!M.client)
		to_chat(src, "This being is missing a brain.")
		return

	visible_message("[src] extends a probiscis and stabs it into [M]")

	if (!do_mob(usr, M, 50))
		to_chat(usr, "<span class='warning'>The injection of the egg has been interrupted!</span>")
		return

	if(M.client)
		M.client.mob = new/mob/living/carbon/alien/humanoid/special/snakeman(new/obj/effect/snake_egg(src.loc))
		visible_message("[src] injects [M] with an egg.")
		visible_message("The egg absorbs [M]")
		M.mutations |= M_NOCLONE
		M.update_body()
		M.death()
	else
		to_chat(src, "This being is missing a brain.")

	return

/obj/effect/snake_egg
	name = "Egg"
	icon = 'icons/mob/alien.dmi'
	icon_state = "egg"
	density = 1
	anchored = 1

/obj/effect/snake_egg/New()
	..()

	spawn(300)
		for(var/mob/M in src)
			M.forceMove(src.loc)
			icon_state = "egg_hatched"
			setDensity(FALSE)
	return