;	DIGSITE, ALPHA MOON GAMEPLAY

(global boolean dig_100percentready false);	actually really important, do not remove this

(global boolean G_lz_middle false)

(global boolean 1turret_jack_elites false)
(global boolean 1_turret_cargo_dropped false)


(global boolean G_turret_left_elites02 false)
(global boolean G_turret_left_middle_trigger false)
(global boolean G_turret_right false)
(global boolean G_turret_right02 false)
(global boolean G_turret_left_right_move false)

(global boolean G_1turret_interior false)
(global boolean G_1turret_interior_back false)

(global boolean G_runandgun02_g false)
(global boolean G_runandgun02_g_reinforcements false)
(global boolean G_runandgun02_interior_l false)

(global boolean G_pre_s_trap_back false)

(global boolean G_2turret_interior_front false)

(global boolean G_trap01_dialog false)

(global boolean G_1turret_turret_dialog false)
(global boolean G_a_1turret_v_attack_b false)
(global boolean G_1turret_hbanshee false)

(global boolean G_runandgun02_dialog false)

(global boolean G_boss_fight_reinforce false)

(global boolean G_prize false)

(global boolean boss_fight_reinforce_cnt_end false)
(global boolean boss_fight_reinforce_ent_end false)
(global boolean boss_fight_reinforce_back_end false)

(global real subtitle_time 30) ;Number of ticks in a second - General_101
(global real subtitle_time_add 0) ;Append to each line for failsafe length. Not a division. - N.

(global string_id fx_com "radio_default")
(global string_id fx_com3d_3D "radio_3D")
(global string_id fx_her "heretic_elite")

; soc/shipmaster
(global real Audio_gain_shipmaster 2)
(global string_id Audio_filter_shipmaster "radio_covy") 

; elite allied 1 and 2
(global string_id Audio_filter_elite_l_1 "radio_covy_3d") 
(global string_id Audio_filter_elite_l_2 "radio_covy_3d")

; elite heretic 1 and 2
(global string_id Audio_filter_elite_h_1 "heretic_elite") 
(global string_id Audio_filter_elite_h_2 "heretic_elite") 

; heretic leader
(global string_id Audio_filter_heretic "heretic_elite") 

; grunt 1 and 2
(global string_id Audio_filter_grunt_1 "radio_covy_3d") 
(global string_id Audio_filter_grunt_2 "radio_covy_3d")

;
;DIGSITE CREW
;
; config:

; enable this to magically despawn the phantom shot down at the start (original version)
(global boolean phantom_magic_despawn true)
; use the digsite version of the phantom shoot-down at the start of BSP1
(global boolean use_dig_phantom_shootdown true)
; use the working AI version of hdropship01 instead of a vehicle
(global boolean restore_1guntower_hdropship01 true)

; should the single random dropship be used (false), or should the second wave ones be used (true)?
(global boolean use_final_battle_dropships false)

; status variables:
; these are used to control the scripts
;
; the value latches a script forward
; map_reset before testing

(global short phantom_intro_dig 0)
(global boolean should_cleanup_hdropship01 false)

(script stub boolean is_cinematic_opening
	false
)

(script stub void intro
	; tell them their scripts are broken if they see this
	(print "your cinematic scripts are broken btw")
)

;	+++++++++++
;	EPIC MUSIC
;	+++++++++++

(script dormant music_interior
	(print "Music (INTERIOR) oneshot")
	(sound_looping_start "digsite\sound\music\am\am_control_ambient" none 1)
	(sleep_forever)	(sleep 240)
)

(global boolean music_control_1 false)
(script dormant music_control
	(print "Music (CONTROL), start A section")	(wake music_interior) (wake music_interior)
	
	(sleep_until music_control_1)
	(sound_looping_start "digsite\sound\music\am\am_control" none 1)
	(sleep 240)
	(sleep_until 
		(and
			(<= (ai_living_count controlroom_back_elites01) 0)
			(<= (ai_living_count controlroom_ent_elites01) 0)
		)
	)
	(print "Music (CONTROL), stop B section")
	(sound_looping_stop "digsite\sound\music\am\am_control")	(sound_looping_stop "digsite\sound\music\am\am_control_ambient")
)

(script dormant music_remnant
	(print "Music (REMNANT)")	(sound_looping_start "digsite\sound\music\am\am_remnant" none 1)
	(sleep_forever)
	(sound_looping_stop "digsite\sound\music\am\am_remnant")
)

(script dormant music_victory
	(print "Music (VICTORY) oneshot")
	(sound_impulse_start "digsite\sound\music\am\ancient" none 1)
)

(global boolean music_mirage_1 false)
(script dormant music_mirage
	(print "Music (MIRAGE), start glue")	(sound_looping_start "digsite\sound\music\am\am_mirage" none 1)
	(sleep_until music_mirage_1)
	(print "Music (MIRAGE), stop rhythm")	(sound_looping_stop "digsite\sound\music\am\am_mirage")
)

(global short music_trojan_progress 0)
(script dormant music_trojan
	(print "Music (TROJAN), start glue")	(sound_looping_start "digsite\sound\music\am\am_trojan_glue" none 1)
	(sleep_until (> music_trojan_progress 1))
	(print "Music (TROJAN), transition glue to alternate")	(sound_looping_set_alternate "digsite\sound\music\am\am_trojan_glue" 1)
	(sleep_until (> music_trojan_progress 2))
	(print "Music (TROJAN), stop glue")	(sound_looping_stop "digsite\sound\music\am\am_trojan_glue")
	(sleep_until (and (> music_trojan_progress 2) (< music_trojan_progress 5)))
	(print "Music (TROJAN), kick it, baby")	(sound_looping_start "digsite\sound\music\am\am_trojan" none 1)
	(sleep_until (> music_trojan_progress 3))
	(print "Music (TROJAN), transition rhythm to alternate")	(sound_looping_set_alternate "digsite\sound\music\am\am_trojan" 1)
	(sleep_until (or (volume_test_objects 2turret_intro_dialog_e (players)) (> music_trojan_progress 4)))
	(print "Music (TROJAN), stop rhythm")	(sound_looping_stop "digsite\sound\music\am\am_trojan")
)

(global boolean music_wraith_1 false)
(script dormant music_thunder
	(print "Music (THUNDER), start glue")
	(sound_looping_start "digsite\sound\music\am\am_thunder_glue" none 1)
	(sleep_until music_wraith_1 60 3000)
	(sound_looping_start "digsite\sound\music\am\am_thunder" none 1)
	(sleep_until (or (volume_test_objects runandgun01 (players)) (volume_test_objects runandgun01_filler (players)) G_trap01_dialog))
	(sound_looping_stop "digsite\sound\music\am\am_thunder_glue")
	(sleep_until G_trap01_dialog)
	(sound_looping_set_alternate "digsite\sound\music\am\am_thunder" true)
	(print "Music (THUNDER), no intensity")
	(sleep_until (volume_test_objects runandgun01_filler (players)))
	(sleep 240)
	(sound_looping_stop "digsite\sound\music\am\am_thunder")
	(print "Music (THUNDER), stopping")
)

;	+++++++++++
;	NAVPOINTS	---	get out the compass, ye old salty dog
;	+++++++++++

(global short nav 0);	This keeps track of our nav index. Zero it out and "wake navpoints" to clear all navpoints

(script static void nav_cleanup;														GARBAGE TRUCK, BEEP BEEP
	(deactivate_team_nav_point_object player (ai_get_object "0guntower_center"))
	(deactivate_team_nav_point_object player (ai_get_object "1turret_a_dropship01"))
	(deactivate_team_nav_point_object player "player_wraith01")	(deactivate_team_nav_point_object player "1guntower")
	(deactivate_team_nav_point_object player (list_get (ai_actors "2guntower") 0))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2guntower") 1))
	(deactivate_team_nav_point_object player (ai_get_object "2guntower_left"))
	(deactivate_team_nav_point_object player (ai_get_object "2guntower_right"))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2turret_av_turrets") 0))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2turret_av_turrets") 1))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2turret_tankelites01") 0))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2turret_tankelites01") 1))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2turret_tankelites01") 2))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2turret_ghostelites01") 0))
	(deactivate_team_nav_point_object player (list_get (ai_actors "2turret_ghostelites01") 1))
	(deactivate_team_nav_point_flag player "breadcrumb_1")(deactivate_team_nav_point_flag player "breadcrumb_2")
	(deactivate_team_nav_point_flag player "breadcrumb_3")(deactivate_team_nav_point_flag player "breadcrumb_4")
	(deactivate_team_nav_point_flag player "breadcrumb_5")(deactivate_team_nav_point_flag player "breadcrumb_6")
	(deactivate_team_nav_point_flag player "breadcrumb_7")(deactivate_team_nav_point_flag player "breadcrumb_8")
	(deactivate_team_nav_point_flag player "breadcrumb_9")(deactivate_team_nav_point_flag player "breadcrumb_10")
	(deactivate_team_nav_point_flag player "breadcrumb_hideout")
)

(script dormant navhelper_runandgun01;	(This one has to be declared before the nav continuous)
	(sleep_until (volume_test_objects tv_nav_canyon (players)))
	(set nav 0)	(deactivate_team_nav_point_flag player "breadcrumb_1")
)

(script dormant navhelper_wraith;	(This one has to be declared before the nav continuous)
	(sleep_until (vehicle_test_seat_list "player_wraith01" "" (players)))
	(set nav 0)	(deactivate_team_nav_point_object player "player_wraith01")
)

(script continuous navpoints (sleep_forever) (nav_cleanup)
	(cond
		((= nav 1);					0guntower_center
			(activate_team_nav_point_object "default" player "0guntower_center" -0.7)
		(print "navpointer 1"))
		
		((= nav 2);					your wraith
			(activate_team_nav_point_object "default" player "player_wraith01" 1)
		(print "navpointer 2") (wake navhelper_wraith))
		
		((= nav 3);				 	runandgun01 (field trip)
			(activate_team_nav_point_flag "default" player "breadcrumb_1" 2.0)
		(print "navpointer 3") (wake navhelper_runandgun01))
		
		((= nav 4);					the tunnel connecting bsp0, bsp1
			(activate_team_nav_point_flag "default" player "breadcrumb_2" 0.5)
		(print "navpointer 4"))
		
		((= nav 5);					1turret
			(activate_team_nav_point_object "default" player "1guntower" -0.7)
		(print "navpointer 5"))
		
		((= nav 6);					1turret interior (if you trigger the "fall back" line)
			(activate_team_nav_point_flag "default" player "breadcrumb_4" 2.0) (activate_team_nav_point_object "default" player "1guntower" -0.7)
		(print "navpointer 6"))
		
		((= nav 7);					your allied phantom reinforcements
			(activate_team_nav_point_object "default" player (ai_get_object "1turret_a_dropship01") 3.0)
		(print "navpointer 7"))
		
		((= nav 8);					runandgun02 (beyond thunderdome)
			(activate_team_nav_point_flag "default" player "breadcrumb_5" 2.0)
		(print "navpointer 8"))
		
		((= nav 9);					runandgun02_interior (if you clear out everything outside) 
			(activate_team_nav_point_flag "default" player "breadcrumb_hideout" 2.0)
		(print "navpointer 9"))
		
		((= nav 10);				runandgun02 exit, ;(<= (ai_living_count supertrap_enemies) 5)
			(activate_team_nav_point_flag "default" player "breadcrumb_6" 2.0)
		(print "navpointer 10"))
		
		((= nav 11);				supertrap exit (if you take a while)
			(activate_team_nav_point_flag "default" player "breadcrumb_7" 1.2)
		(print "navpointer 11"))
		
		((= nav 12);				2turret guns (if they're the last thing left)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2guntower") 0) 3.0)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2guntower") 1) 3.0)
			;(activate_team_nav_point_object "default" player (ai_get_object "2guntower_left") 3.0)
			;(activate_team_nav_point_object "default" player (ai_get_object "2guntower_right") 3.0)
		(print "navpointer 12 - 2turret, guns remaining"))
		
		((= nav 13);				2turret shades (if they're the last thing left)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2turret_av_turrets") 0) 0.6)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2turret_av_turrets") 1) 0.6)
		(print "navpointer 13 - 2turret, shades remaining"))
		
		((= nav 14);				2turret wraiths (if they're the last thing left)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2turret_tankelites01") 0) 1.4)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2turret_tankelites01") 1) 1.4)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2turret_tankelites01") 2) 1.4)
		(print "navpointer 14 - 2turret, wraiths remaining"))
		
		((= nav 14);				2turret ghosts (if they're the last thing left)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2turret_ghostelites01") 0) 3.0)
			(activate_team_nav_point_object "default" player (list_get (ai_actors "2turret_ghostelites01") 1) 3.0)
		(print "navpointer 15 - 2turret, ghosts remaining"))
		
		((= nav 16);				victory / control room teleport area
			(activate_team_nav_point_flag "default" player "breadcrumb_9" 2.0)
		(print "navpointer 16"))
	)
	(print "ye old navpointer ith slumber")
)

(script dormant navhelper_mirage;	(This one has to be declared after the nav continuous)
	(sleep_until (volume_test_objects "runandgun02_low" (players)))
)

(script dormant navhelper_runandgun02;	(This one has to be declared after the nav continuous)
	;(sleep_until (or (volume_test_objects "runandgun02" (players)) (volume_test_objects "runandgun02_low" (players))))
	;(set nav 9)  (wake navpoints)
	(sleep_until (and
		(<= (ai_living_count runandgun02_tankelites01) 0)
		(<= (ai_living_count runandgun02_low_wraiths) 0)
		(<= (ai_living_count runandgun02_ghostelites01) 0)
		(<= (ai_living_count runandgun02_interior_i) 0)
		(<= (ai_living_count runandgun02_t_grunts02) 0)
	))
	(set nav 10) (wake navpoints)
	(sleep_until (volume_test_objects "2turret01_e" (players)))
	(set nav 0)  (wake navpoints)
)

;	+++++++++++
;	OBJECTIVES
;	+++++++++++
(script dormant objective0_set (sleep 30) (objectives_show_up_to 0)) (script dormant objective0_clear (objectives_finish_up_to 0))
(script dormant objective1_set (sleep 30) (objectives_show_up_to 1)) (script dormant objective1_clear (objectives_finish_up_to 1))
(script dormant objective2_set (sleep 30) (objectives_show_up_to 2)) (script dormant objective2_clear (objectives_finish_up_to 2))
(script dormant objective3_set (sleep 30) (objectives_show_up_to 2)) (script dormant objective3_clear (objectives_finish_up_to 2))
(script dormant objective4_set (sleep 30) (objectives_show_up_to 2)) (script dormant objective4_clear (objectives_finish_up_to 2))

;	+++++++++++
;	HUD TEXT (well, sorta. looks like halo 2 doesn't really do this the same way)
;	+++++++++++
(script static void hud_help_1 			(cinematic_set_title_delayed help_demolition 0))
(script static void hud_help_2 			(cinematic_set_title_delayed help_destruction 0))
(script static void hud_allies 			(cinematic_set_title_delayed obj_allies 0))
(script static void hud_obj_demolition 	(cinematic_set_title_delayed obj_demolition 0))
(script static void hud_obj_canyon 		(cinematic_set_title_delayed obj_canyon 0))
(script dormant hud_obj_flank 			(cinematic_set_title_delayed obj_flank 0));	Dormant for a reason, notouchies
(script static void hud_obj_mirage 		(cinematic_set_title_delayed obj_mirage 0))
(script static void hud_obj_stronghold 	(cinematic_set_title_delayed obj_stronghold 0))
(script static void hud_obj_victory 	(cinematic_set_title_delayed obj_victory 0))
(script static void hud_obj_showdown 	(cinematic_set_title_delayed obj_showdown 0))

;	+++++++++++
;	CHAPTER TITLES (come on this is like one of the coolest parts of Halo. We had to do them!
;	+++++++++++
(script dormant chapter_intro
	(sleep 30)	(cinematic_set_title_delayed title_1 0.0)
	(sleep 150)	(hud_cinematic_fade 1 0.5)
	(cinematic_show_letterbox false)	(wake objective0_set)
	(sleep 30)	(hud_obj_demolition)
)
(script static void chapter_intro_stubby (wake chapter_intro));	Stublink to cinematic.hsc to be triggered by intro
(script dormant chapter_kickoff
	(hud_cinematic_fade 0 0.5)	(cinematic_show_letterbox true)
	(sleep 30)	(cinematic_set_title_delayed title_2 0.0)
	(sleep 150)	(hud_cinematic_fade 1 0.5)
	(cinematic_show_letterbox false)
)
(script dormant chapter_runandgun02
	(cinematic_show_letterbox true)	(sleep 30)	(cinematic_set_title_delayed title_3 0.0)
	(sleep 150)
	(cinematic_show_letterbox false)
	(sleep 30)	(hud_obj_stronghold)
)
(script dormant chapter_mirage
	(hud_cinematic_fade 0 0.5)	(cinematic_show_letterbox true)
	(sleep 30)	(cinematic_set_title_delayed title_4 0.0)
	(sleep 150)	(hud_cinematic_fade 1 0.5)
	(cinematic_show_letterbox false)
	(sleep 30)	(hud_obj_mirage)
)
;	+++++++++++

(script dormant outro_prep
	(wake music_control)
	(fade_out 1 1 1 45)
	;(cinematic_start)
	(sleep 90)
)

(script dormant prize
	(if (<= (random_range 1 1500) 1) 
		(begin
			(print "YOU WIN $1!!!!!")
			(sleep 60)
			(print "Show this screen to Stephen to collect your prize")
			)
		(begin
			(print "Sorry you did not WIN")
			(sleep 60)
			(print "try again")
		)
	)
	(sleep 120)
	(game_won)
)


; CHECKS IF THE VEHICLE THE AI IS IN IS DEAD
; DO NOT USE OUTSIDE OF CS
(script static boolean cs_is_my_mount_dead
	; is the horse we rode in on dead?
	(<= (unit_get_health (ai_get_unit ai_current_actor)) 0.000001)
)

(script static void cs_make_immortal
	(ai_cannot_die ai_current_actor 1)
)

(script static void cs_make_mortal
	(ai_cannot_die ai_current_actor 0)
)

; CS: delete just our actor
(script static void cs_erase_actor
	(ai_cannot_die ai_current_actor 0)
	(ai_erase ai_current_actor)
)

; CS: delete our whole squad
(script static void cs_erase_squad
	(ai_cannot_die ai_current_actor 0)
	(ai_erase ai_current_squad)
)

; CS: get the object for the AI actor
(script static object cs_get_object
	(ai_get_object ai_current_actor)
)

; CS: get the unit for the AI actor
(script static unit cs_get_unit
	(ai_get_unit ai_current_actor)
)

; CS: get the vehicle the AI actor is in
(script static vehicle cs_vehicle_get
	(ai_vehicle_get ai_current_actor)
)

; CS: check (assuming current actor is driver of a c_dropship) if the turret is dead 
(script static boolean cs_dropship_turret_dead
	(<= (object_get_health (object_at_marker (cs_vehicle_get) "gunseat")) 0)
)

; CS: get the turret auto-gunner AI (assuming current actor is driver of a c_dropship)
(script static ai cs_dropship_turret_get_ai
	(object_get_ai (object_at_marker (cs_vehicle_get) "gunseat"))
)

; if only halo 2 had arguments for static scripts
; if only

; CS: get the chin-gun AI  (assuming current actor is driver of a phantom)
(script static ai cs_phantom_chin_gun_get_ai
	(object_get_ai (object_at_marker (cs_vehicle_get) "chin_gun"))
)

(script static ai cs_phantom_left_gun_get_ai
	(object_get_ai (object_at_marker (cs_vehicle_get) "left_gun"))
)

(script static ai cs_phantom_right_gun_get_ai
	(object_get_ai (object_at_marker (cs_vehicle_get) "right_gun"))
)

(script stub void bomb_primer_0 (print "wake bomb hud"))
(script stub void bomb_primer_1 (print "wake bomb hud"))
(script stub void bomb_primer_2 (print "wake bomb hud"))
(script stub void bomb_primer_3 (print "wake bomb hud"))
(script stub void bomb_primer_4 (print "wake bomb hud"))
(script stub void bomb_primer_5 (print "wake bomb hud"))

(global string bomb_sfx_spatial "")

(script dormant plant_gt_0_bomb
	(sleep_until (or (object_model_target_destroyed 0guntower_center target_shield) (<= (unit_get_health 0guntower_center)0)))
	(if (<= (unit_get_health 0guntower_center)0) (sleep_forever))
	(object_create 0guntower_center_bomb)

    (sleep_until (or (= (device_group_get 0guntower_center_bomb) 1.0) (<= (unit_get_health 0guntower_center)0)))
	(object_destroy 0guntower_center_bomb)
	(if (<= (unit_get_health 0guntower_center)0) (sleep_forever))
	
	(object_set_permutation 0guntower_center bomb active)
	(bomb_primer_0) (sleep 120)
	(unit_kill 0guntower_center)
	(object_set_permutation 0guntower_center bomb inactive)
)

(script dormant plant_gt_1_bomb
	(sleep_until (or (object_model_target_destroyed 0guntower_left target_shield) (<= (unit_get_health 0guntower_left)0)))
	(if (<= (unit_get_health 0guntower_left)0) (sleep_forever))
	(object_create 0guntower_left_bomb)

    (sleep_until (or (= (device_group_get 0guntower_left_bomb) 1.0) (<= (unit_get_health 0guntower_left)0)))
	(object_destroy "0guntower_left_bomb")
	(if (<= (unit_get_health 0guntower_left)0) (sleep_forever))
	
	(object_set_permutation 0guntower_left bomb active)
	(bomb_primer_1) (sleep 120)
	(unit_kill 0guntower_left)
	(object_set_permutation 0guntower_left bomb inactive)
)

(script dormant plant_gt_2_bomb
	(sleep_until (or (object_model_target_destroyed 0guntower_right target_shield) (<= (unit_get_health 0guntower_right)0)))
	(if (<= (unit_get_health 0guntower_right)0) (sleep_forever))
	(object_create 0guntower_right_bomb)

    (sleep_until (or (= (device_group_get 0guntower_right_bomb) 1.0) (<= (unit_get_health 0guntower_right)0)))
	(object_destroy "0guntower_right_bomb")
	(if (<= (unit_get_health 0guntower_right)0) (sleep_forever))
	
	(object_set_permutation 0guntower_right bomb active)
	(bomb_primer_2) (sleep 120)
	(unit_kill 0guntower_right)
	(object_set_permutation 0guntower_right bomb inactive)
)

(script dormant plant_gt_3_bomb
	(sleep_until (or (object_model_target_destroyed 1guntower target_shield) (<= (unit_get_health 1guntower)0)))
	(if (<= (unit_get_health 1guntower)0) (sleep_forever))
	(object_create 1guntower_bomb)

    (sleep_until (or (= (device_group_get 1guntower_bomb) 1.0) (<= (unit_get_health 1guntower)0)))
	(object_destroy "1guntower_bomb")
	(if (<= (unit_get_health 1guntower)0) (sleep_forever))
	
	(object_set_permutation 1guntower bomb active)
	(bomb_primer_3) (sleep 120)
	(unit_kill 1guntower)
	(object_set_permutation 1guntower bomb inactive)
)

(script dormant plant_gt_4_bomb
	(sleep_until (or (object_model_target_destroyed 2guntower_left target_shield) (<= (unit_get_health 2guntower_left)0)))
	(if (<= (unit_get_health 2guntower_left)0) (sleep_forever))
	(object_create 2guntower_left_bomb)

    (sleep_until (or (= (device_group_get 2guntower_left_bomb) 1.0) (<= (unit_get_health 2guntower_left)0)))
	(object_destroy "2guntower_left_bomb")
	(if (<= (unit_get_health 2guntower_left)0) (sleep_forever))
	
	(object_set_permutation 2guntower_left bomb active)
	(bomb_primer_4) (sleep 120)
	(unit_kill 2guntower_left)
	(object_set_permutation 2guntower_left bomb inactive)
)

(script dormant plant_gt_5_bomb
	(sleep_until (or (object_model_target_destroyed 2guntower_right target_shield) (<= (unit_get_health 2guntower_right)0)))
	(if (<= (unit_get_health 2guntower_right)0) (sleep_forever))
	(object_create 2guntower_right_bomb)

    (sleep_until (or (= (device_group_get 2guntower_right_bomb) 1.0) (<= (unit_get_health 2guntower_right)0)))
	(object_destroy "2guntower_right_bomb")
	(if (<= (unit_get_health 2guntower_right)0) (sleep_forever))
	
	(object_set_permutation 2guntower_right bomb active)
	(bomb_primer_5) (sleep 120)
	(unit_kill 2guntower_right)
	(object_set_permutation 2guntower_right bomb inactive)
)

(script stub void outro_dig
	(print "outro_dig")
)

(script dormant level_ending

	(sleep_until 
		(and
			(<= (ai_living_count controlroom_back_elites01) 0)
			(<= (ai_living_count controlroom_ent_elites01) 0)
			(<= (ai_living_count controlroom_elites01) 0)
		)
	)
	
	(fade_out 0 0 0 0)
	
	(cinematic_start)
	(camera_control on)
	
	(camera_set hlead_fight_ending_push_1 0)
	
	(sleep 30)
	
	(fade_in 1 1 1 15)
	
	(print "Level Finished")
	
	(camera_set hlead_fight_ending_push_2 180)
	
	(sleep 30)
	
	(sound_impulse_start "digsite\sound\dialog\alphamoon\cinematic\c05_5000_hld" none 1)
	(cinematic_subtitle c05_5000_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\cinematic\c05_5000_hld") subtitle_time) subtitle_time_add))

	(camera_set hlead_fight_ending_push_3 180)
	
	(sleep 30)
	
	(camera_set hlead_fight_ending_push_4 180)
	
	(sleep 60)
	
	(sound_impulse_start "digsite\sound\dialog\alphamoon\cinematic\c05_5010_der" none 1)
	(cinematic_subtitle c05_5010_der (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\cinematic\c05_5010_der") subtitle_time) subtitle_time_add))
	
	(camera_set hlead_fight_ending_push_5 180)
	
	(sleep 90)
	
	(sound_impulse_start "digsite\sound\dialog\alphamoon\cinematic\c05_5020_hld" none 1)
	(cinematic_subtitle c05_5020_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\cinematic\c05_5020_hld") subtitle_time) subtitle_time_add))
	
	(camera_set hlead_fight_ending_push_6 180)
	
	(sleep 90)
	
	(sound_impulse_start "digsite\sound\dialog\alphamoon\cinematic\c05_5030_gsp" none 1)
	(cinematic_subtitle c05_5030_gsp (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\cinematic\c05_5030_gsp") subtitle_time) subtitle_time_add))
	
	(camera_set hlead_fight_ending_push_7 180)
	
	(sleep 90)
	
	(fade_out 0 0 0 15)
	
	(sleep 90)
	
	(print "--- Mission Complete!!!! ---")
	
	(sleep 70)
	
	(print "--- GET MORE WHEN YOU PURCHASE HALO 2 ---")
	
	(sleep 70)
	
	(print "--- COMING WINTER 2004 ---")
	
	(sleep 70)
	
	(print "Stand by to see if your a winner!")
	
	(sleep 90)
	
	(wake prize);wake
)

(script dormant boss_fight_reinforce_cnt

	(sleep_until 
			(and
			   	(<= (ai_living_count controlroom_back_elites01) 0)
			   	(<= (ai_living_count controlroom_ent_elites01) 0)
			)
	)

	(set boss_fight_reinforce_cnt_end true)

	(if G_boss_fight_reinforce (sleep_forever))
	(set G_boss_fight_reinforce true)
	
	(ai_place controlroom_back_elites01)
	
	(ai_set_orders controlroom_back_elites01 controlroom_back_attack)
	
	(print "05_115_hlead --- KILL THEM ALL!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1150_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1150_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1150_hld") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1150_hld"))
)

(script dormant boss_fight_reinforce_ent

	(sleep_until 
			(and
			   	(<= (ai_living_count controlroom_elites01) 0)
			   	(<= (ai_living_count controlroom_ent_elites01) 0)
			)
	)

	(set boss_fight_reinforce_ent_end true)

	(if G_boss_fight_reinforce (sleep_forever))
	(set G_boss_fight_reinforce true)
	
	(ai_place controlroom_elites01)
	
	(ai_set_orders controlroom_elites01 controlroom_center_attack)
	
	(print "05_117_hlead --- KILL THEM ALL!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1170_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1170_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1170_hld") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1170_hld"))
)

(script dormant boss_fight_reinforce_back

	(sleep_until 
			(and
			   	(<= (ai_living_count controlroom_elites01) 0)
			   	(<= (ai_living_count controlroom_back_elites01) 0)
			)
	)

	(set boss_fight_reinforce_back_end true)

	(if G_boss_fight_reinforce (sleep_forever))
	(set G_boss_fight_reinforce true)
	
	(ai_place controlroom_elites01)
	
	(ai_set_orders controlroom_elites01 controlroom_center_attack)
	
	(print "05_118_hlead --- KILL THEM ALL!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1180_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1180_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1180_hld") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1180_hld"))
)

(script dormant boss_fight

	(Print "---ROUND 1---")
	
	(sleep 75)
	
	(Print "---FIGHT---")
	
	(ai_place controlroom_elites01)
	
	(print "05_115_hlead --- Heretic Leader: Where are your Prophets now?")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1130_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1130_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1130_hld") subtitle_time) subtitle_time_add))
	
	(ai_set_orders controlroom_elites01 controlroom_center_attack)
	
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1130_hld"))
	
	(ai_place controlroom_ent_elites01)
	
	(ai_set_orders controlroom_elites01 controlroom_ent_attack)
	
	(print "05_115_hlead --- Heretic Leader: I have more blood to spill!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1140_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1140_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1140_hld") subtitle_time) subtitle_time_add))
	
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1140_hld"))

	(ai_place controlroom_back_elites01)

	(ai_set_orders controlroom_elites01 controlroom_back_attack)
	
	(print "05_115_hlead --- Heretic Leader: You may tire, but I shall not!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1160_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1160_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1160_hld") subtitle_time) subtitle_time_add))
	
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1160_hld"))

	(ai_place controlroom_bu_grunts01)

	(ai_set_orders controlroom_bu_grunts01 controlroom_bu_attack)
	
	(ai_place controlroom_eu_grunts01)

	(ai_set_orders controlroom_eu_grunts01 controlroom_eu_attack)
	
	(wake boss_fight_reinforce_ent);wake
	(wake boss_fight_reinforce_back);wake
	(wake boss_fight_reinforce_cnt);wake

	(sleep_until 
			(and
				(<= (ai_living_count controlroom_elites01) 0)
				(<= (ai_living_count controlroom_ent_elites01) 0)
				(<= (ai_living_count controlroom_back_elites01) 0)
				;(<= (ai_living_count controlroom_bu_grunts01) 0)
				;(<= (ai_living_count controlroom_eu_grunts01) 0)
				boss_fight_reinforce_cnt_end
				boss_fight_reinforce_ent_end
				boss_fight_reinforce_back_end
			)
	)
	
	(wake outro_prep)
	
	(sleep 40)
	
	(outro_dig)

)

(script static void hlead_fight_intro


	(camera_set hlead_fight_intro_pan_1 0)
	
	(sleep 30)
	
	(fade_in 1 1 1 15)
	
	(print "HERETIC BOSS FIGHT INTRO")
	
	(camera_set hlead_fight_intro_pan_2 120)
	
	(sleep 20)
	
	(print "05_110_hlead --- Heretic Leader: You know nothing of what goes on here!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1100_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1100_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1100_hld") subtitle_time) subtitle_time_add))

	(camera_set hlead_fight_intro_pan_2 90)
	
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1100_hld"))
	
	(camera_set hlead_fight_intro_pan_3 90)
	
	(sleep 60)
	
	(print "05_112_hlead --- Heretic Leader: You've allowed your self to become a mindless pawn of the prophets")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1120_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1120_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1120_hld") subtitle_time) subtitle_time_add))
	
	(camera_set hlead_fight_intro_pan_4 120)
	
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1120_hld"))
	
	(fade_out 1 1 1 15)
	
	(sleep 15)
)	




(script dormant heretic_leader_intro

	(sleep_until (volume_test_objects controlroom_debris_spawn (players))15)

	;(wake ai_kill05)
	
	(object_create_containing "wrckd_cntrlrm")

	(object_destroy_containing "excavation_end")
	(object_destroy_containing "excavation_mid_low_debris")
	
	(sleep_until (volume_test_objects heretic_leader_intro (players))15)
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(print "HERETIC LEADER FIGHT INTRO")
	
	(cinematic_fade_to_white)
	(if (cinematic_skip_start)
		(begin
			(hlead_fight_intro);wake
		)
	)
    (cinematic_skip_stop)
	(cinematic_fade_from_white)
	
	(wake boss_fight);wake

	(wake music_control)
)


(script dormant teleport_to_cr

	(sleep_until (volume_test_objects teleport_to_cr (players))15)

    (object_teleport (player0) "wrecked_controlroom")
    (object_teleport (player1) "wrecked_controlroom")
    (switch_bsp 3)
	
	(print "---YOU HAVE BEEN TELEPORTED!!!---")
	
	(wake music_control)
	
	(sleep 50)
	
	(print "---PREPARE TO DIE!---")
)

;V_V_V_V_V_V_V   EXCAVATION !_!_!_!_!_!_!  V_V_V_V_V_V_V_V
;V_V_V_V_V_V_V   EXCAVATION !_!_!_!_!_!_!  V_V_V_V_V_V_V_V

(script dormant excavation_end_covenant_victory

	(wake teleport_to_cr);wake

	(sleep 95)
	
	(hud_obj_victory) (wake objective3_clear) (wake objective4_set)

	(print "05_105_soc --- C.O.: The Heretic army has been crushed!")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1050_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	;(cinematic_subtitle l05_1050_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1050_soc") subtitle_time) subtitle_time_add))
	;(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1050_soc"))
	(sleep 15)
	
	(print "05_106_elite1 --- Allies: yea hoo!  We've won!")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1060_el1" none 1 Audio_filter_elite_l_1)
	;(cinematic_subtitle l05_1060_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1060_el1") subtitle_time) subtitle_time_add))
	;(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1060_e11"))
	(sleep 15)
	
	(print "05_107_elite2 --- Allies: we are victorious!")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1070_el2" none 1 Audio_filter_elite_l_2)
	;(cinematic_subtitle l05_1070_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1070_el2") subtitle_time) subtitle_time_add))
	;(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1070_e12"))
	(sleep 15)
	
	(print "05_108_elite1 --- Allies: the dishonorable fools are no more!")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1080_el1" none 1 Audio_filter_elite_l_1)
	;(cinematic_subtitle l05_1080_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1080_el1") subtitle_time) subtitle_time_add))
	;(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1080_e11"))
	(sleep 15)
	
	(print "05_109_soc --- C.O.: your mission is not over Dervish. ")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1090_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	;(cinematic_subtitle l05_1090_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1090_soc") subtitle_time) subtitle_time_add))
	;(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1090_soc"))
	(sleep 15)
	
	(print "05_109_soc --- C.O.: Find the Heretic leader... ")
	(sleep 15)
	
	(print "05_109_soc --- C.O.: and destroy him... ")
)


	;vvvvvvvv ------  excavation_end_heretic_leader_intro ------- vvvv

(script static void hlead_intro
	(camera_set hlead_intro_push_1 0)
	
	(fade_in 1 1 1 15)
	(sleep 15)
	
	(print "HERETIC LEADER INTRO")
	
	(print "--- Heretic Leader: Damn your ignorance, you doom us all!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1040_hld" none 1 Audio_filter_heretic)
	(cinematic_subtitle l05_1040_hld (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1040_hld") subtitle_time) subtitle_time_add))
	(camera_pan hlead_intro_push_1 hlead_intro_push_2 240 0 0 240 0)
	
	(wake music_victory)
	(sleep 240)
	
	(print "---FIND TO THE RING OF CRAP!!!---")
	
	(camera_set hlead_intro_push_3 0)
	
	(sleep 120)
	(fade_out 1 1 1 15)
	(sleep 15)
	
	(hud_obj_showdown)
)	

(script dormant excavation_end_heretic_leader_i

	(sleep_until (<= (ai_living_count excavation_end) 1))
	
	(ai_braindead  (object_get_ai (object_at_marker (ai_vehicle_get 2turret_hdropship01/starting_locations_0) "gunseat")) true)
	(sleep 30)

	(cinematic_fade_to_white)
	(if (cinematic_skip_start)
		(begin
			(hlead_intro);wake
		)
	)
    (cinematic_skip_stop)
	(cinematic_fade_from_white)

	(ai_braindead  (object_get_ai (object_at_marker (ai_vehicle_get 2turret_hdropship01/starting_locations_0) "gunseat")) false)
	(wake excavation_end_covenant_victory);wake
)

	;vvvvvvvv --excavation end ( dropship staging area )-- vvvvvvvv

	;vvvvvvvv ------  excavation_end_heretic_dialog ------- vvvv

(script dormant excavation_end_heretic_dialog

	(sleep_until (volume_test_objects excavation_end_g_strt (players))15)
	
	(wake excavation_end_heretic_leader_i);wake
	
	(sleep 30)
	
	;(wake music_7)

	(sleep 40)
	
	(print "05_097_helite1 --- Heretic: they broken through the defenses!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0970_he1" none 1 Audio_filter_elite_h_1)
	(cinematic_subtitle l05_0970_he1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0970_he1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0970_he1"))

	(print "05_098_helite2 --- Heretic: we couldn�t hold them!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0980_he2" none 1 Audio_filter_elite_h_2)
	(cinematic_subtitle l05_0980_he2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0980_he2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0980_he2"))
	
	(print "05_099_helite1 --- Heretic: escape while you can!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0990_he1" none 1 Audio_filter_elite_h_1)
	(cinematic_subtitle l05_0990_he1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0990_he1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0990_he1"))
	
	(print "05_100_helite2 --- Heretic: get these ships out of here!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1000_he2" none 1 Audio_filter_elite_h_2)
	(cinematic_subtitle l05_1000_he2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1000_he2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1000_he2"))
	
	(print "05_101_helite1 --- Heretic: save what you can!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_1010_he2" none 1 Audio_filter_elite_h_1)
	(cinematic_subtitle l05_1010_he2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1010_he2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_1010_he2"))
)

;(script dormant excavation_end_hds02
	
	;(ai_place excavation_end_hds02)
;)

(script dormant excavation_end_hds01

	(sleep_until (volume_test_objects excavation_end_g_strt (players))15)

	;(ai_place excavation_end_hds01)
	
	;(sleep_until 
	;	(not 
	;		(cs_command_script_running excavation_end_hds01 cs_excavation_end_hds01)
	;	)
	;)
)

(script dormant excavation_end_turrets01

	(sleep_until (volume_test_objects excavation_end_g_strt (players))15)
	
	(sleep 20)
			
	;(ai_place excavation_end_turrets01)
)

(script dormant excavation_end_wraiths01

	(sleep_until (volume_test_objects excavation_end_g_strt (players))15)
	
	;(ai_place excavation_end_w_left)
	
	;-------------excavation end right wraith-------------- 
	
	;(ai_place excavation_end_w_right)
)

	;vvv----  Creates 4 wraiths at the entrance to end   -------vvvvv
	;vvv-----  theses wraiths migrate in sapian -----vvvv
	
(script dormant excavation_end_strt

	(sleep_until 
		(or
			(volume_test_objects excavation_end_strt_v_right (players))
			(volume_test_objects excavation_end_strt_v_left (players))
		)
	15)

	;(ai_place excavation_end_strt_left_w01)
	;(ai_place excavation_end_strt_right_w01)
	
	(wake excavation_end_heretic_dialog);wake
	
)

	;vvv--------  creates 4 ghosts and migrates them to excavation end ---v


;(script dormant excavation_middle_low

	;(sleep_until (volume_test_objects excavation_middle_low_v (players))15)
	
	;(wake excavation_end_strt);wake
	;(wake excavation_end_turrets01);wake
	;(wake excavation_end_wraiths01);wake
	
	;(ai_place excavation_middle_low_g02)
;)

(script dormant excavation_save

	(sleep_until (volume_test_objects excavation_middle_lower (players))15)
	
	(game_save_immediate);SSSAAAVVVEEE---
)

;(script dormant excavation_m_hds01_int

	;(sleep_until (volume_test_objects excavation_m_hds01 (players))15)

	;(sleep 10)
	
	;(ai_place excavation_m_hds01)
;)

;(script dormant excavation_middle

;	(sleep_until (volume_test_objects excavation_start_g_r (players))15)
	
;	(wake excavation_middle_low);wake	
	
;	(wake excavation_m_hds01_int);wake
	
;	(sleep 30)

;	(wake excavation_save);wake

	;(ai_place excavation_turretgrunts02)
		
	;(ai_place excavation_tankelites02)
;)

;(script dormant excavation_middle_wraiths01

;	(sleep_until (volume_test_objects excavation_start_g_r (players))15)
	
;	(sleep 10)
	
	;(ai_place excavation_middle_w_elites01)
		
;)

;(script dormant excavation_middle_turrets01

;	(sleep_until (volume_test_objects excavation_start_g_r (players))15)
	
;	(sleep 5)
	
	;(ai_place excavation_middle_turrets_g01)
;)


(script dormant excavation_start_g_r

	;(ai_place excavation_start_g_r01)
	
	(sleep 10)
	
	;(ai_place excavation_start_i_r01)
	
)

	;v------------excavation start ghosts--------------v

(script dormant excavation_start_ghosts

	(sleep 10)

	;(ai_place excavation_start_g_elites01)

)

;(script dormant excavation_start01

;	(sleep_until (volume_test_objects excavation_e_i_back (players))15)
	
;	(game_save_immediate);SSSAAAVVVEEE---
	
;	(wake excavation_start_ghosts);wake
;	(wake excavation_start_g_r);wake
	
;	(wake excavation_middle_wraiths01);wake
;	(wake excavation_middle_turrets01);wake

;v------------excavation start grunt turrets--------------v

	;(ai_place excavation_turretgrunts01)
	
;v------------excavation start elite tanks--------------v

	;(ai_place excavation_start_w_left)
	;(ai_place excavation_start_w_right)
	
;v------------excavation start flee grunts--------------v

	;(ai_place excavation_fleegrunts01)

;	(wake excavation_middle);wake
;)

;(script dormant excavation_start_allied_dialog

;	(sleep_until (volume_test_objects excavation_start_center (players))15)
	
;	(sleep 30)
	
;	(print "05_095_soc --- Allies: encountering fierce resistance")
;	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0950_soc" none Audio_gain_shipmaster Audio_filter_shipmaster) 
;	(cinematic_subtitle l05_0950_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0950_soc") subtitle_time) subtitle_time_add))
;	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0950_soc"))
	
;	(print "05_096_soc --- Allies: they are fighting to the end")
;	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0960_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
;	(cinematic_subtitle l05_0960_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0960_soc") subtitle_time) subtitle_time_add))
;	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0960_soc"))
	
;	(object_destroy_containing "supertrap_debris")
;)

;(script dormant excavation_e_allied_dialog
	
;	(sleep_until (volume_test_objects excavation_e_allied_dialog (players))15)
	
;	(wake excavation_start_allied_dialog);wake

;	(print "05_091_elite1 --- Allies: This is amazing")
;	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0910_el1" none 1 Audio_filter_elite_l_1) 
;	(cinematic_subtitle l05_0910_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0910_el1") subtitle_time) subtitle_time_add))
;	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0910_el1"))
	
;	(print "05_092_elite2 --- Allies: they are using this wreckage as their base!")
;	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0920_el2" none 1 Audio_filter_elite_l_2) 
;	(cinematic_subtitle l05_0920_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0920_el2") subtitle_time) subtitle_time_add))
;	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0920_el2"))
	
;	(print "05_093_elite1 --- Allies: weve entered the enemy strong hold!")
;	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0930_el1" none 1 Audio_filter_elite_l_1) 
;	(cinematic_subtitle l05_0930_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0930_el1") subtitle_time) subtitle_time_add))
;	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0930_el1"))
	
;	(print "05_094_elite2 --- Allies: Their forces are almost crushed")
;	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0940_el2" none 1 Audio_filter_elite_l_2) 
;	(cinematic_subtitle l05_0940_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0940_el2") subtitle_time) subtitle_time_add))
;	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0940_el2"))
	
;)

;(script dormant excavation_e

;	(sleep_until (volume_test_objects excavation_start01 (players))15)
	
;	(wake ai_kill05_script);wake
	
;	(wake excavation_e_allied_dialog);wake
	
	;(ai_place excavation_e_avturret_g)
	
	;(ai_place excavation_e_i_front)
	
	;(ai_place excavation_e_i_back)
	
	;(ai_place excavation_e_shadow01)
	
;	(sleep 10)

	;(ai_place excavation_tankelites01)
;)



;VVVVVVV-----------FINAL---____BATTLE____FINAL---____BATTLE!!!-----------vvvvv
;VVVVVVV-----------FINAL---____BATTLE____FINAL---____BATTLE!!!-----------vvvvv
;VVVVVVV-----------FINAL---____BATTLE____FINAL---____BATTLE!!!-----------vvvvv


(script command_script cs_final_bat_hds03

	(cs_vehicle_speed 1)

	(cs_fly_to final_bat_hds03/p0 3)
	(cs_fly_to final_bat_hds03/p1 3)
	(cs_fly_to final_bat_hds03/p2 3)
	(cs_fly_to_and_face final_bat_hds03/p3 final_bat_hds03/p4 3)
	
	(vehicle_unload (cs_vehicle_get) "c_dropship_lc")
	
	(sleep_until (cs_dropship_turret_dead))
	(cs_fly_to final_bat_hds03/p1 3)
	(cs_fly_to final_bat_hds03/p0 3)
	(cs_erase_squad)
)


(script command_script cs_final_bat_hds02

	(cs_vehicle_speed 1)

	(cs_fly_to final_bat_hds02/p0 3)
	(cs_fly_to final_bat_hds02/p1 3)
	(cs_fly_to_and_face final_bat_hds02/p2 final_bat_hds02/p3 3)
	
	(vehicle_unload (cs_vehicle_get) "c_dropship_lc")
	
	
	(sleep_until (cs_dropship_turret_dead))
	(cs_fly_to final_bat_hds02/p1 3)
	(cs_fly_to final_bat_hds02/p0 3)
	(cs_erase_squad)
	
	
)


(script command_script cs_final_bat_hds01

	(cs_vehicle_speed 1)

	(cs_fly_to final_bat_hds01/p0 3)
	(cs_fly_to final_bat_hds01/p1 3)
	(cs_fly_to_and_face final_bat_hds01/p2 final_bat_hds01/p3 3)
	
	(vehicle_unload (cs_vehicle_get) "c_dropship_sc_01")
	
	(sleep 30)
	
	(vehicle_unload (cs_vehicle_get) "c_dropship_sc_02")
	
	(sleep 30)
	
	(vehicle_unload (cs_vehicle_get) "c_dropship_sc_03")
	
	
	(sleep_until (cs_dropship_turret_dead))
	(cs_fly_to final_bat_hds01/p1 3)
	(cs_fly_to final_bat_hds01/p0 3)
	(cs_erase_squad)
)

(script static void final_bat_hds_setup
	(ai_place final_bat_hds01)
	
	(ai_place final_bat_hds02)
	
	(ai_place final_bat_hds03)

	;(ai_place_in_vehicle lz01_allied_grunts01 lz01_a_dropship01)

	(cs_run_command_script final_bat_hds01 cs_final_bat_hds01)
	
	(cs_run_command_script final_bat_hds02 cs_final_bat_hds02)
	
	(cs_run_command_script final_bat_hds03 cs_final_bat_hds03)
	
	(ai_place_in_vehicle final_bat_ghosts01 final_bat_hds01)
	
	(ai_place_in_vehicle final_bat_shadow01 final_bat_hds02)
	
	(ai_place_in_vehicle final_bat_wraith01 final_bat_hds03)
)

(script dormant final_bat_hds

	;(sleep_until (<= (ai_living_count 2turret_1st_v)0)) 
	(sleep_until (<= (ai_living_count 2turret_tankelites01)0)) 
	
	(print "final_bat_hds triggered")
	
	(final_bat_hds_setup)
)





;VVVVVVV-----------SUPER---____TRAP____!!!-----------vvvvv
;VVVVVVV-----------SUPER---____TRAP____!!!-----------vvvvv

(script dormant supertrap_allied_reminder

	(sleep_until 
		(and
			(volume_test_objects super_trap_allied_end (players))
			(> (ai_living_count supertrap_enemies) 5)
		)
	15)
	
	(print "--- Allies: We cant proceed until you clear out the trap!!!")
	
	(sleep 55)
	
	(print "--- Allies: Destroy the Heretic Trap!!!")

)

(script dormant supertrap_allied_praise

	(sleep_until 
		(and
			(volume_test_objects super_trap_allied_end (players))
			(<= (ai_living_count supertrap_enemies) 5)
		)
	15)
	
	(object_destroy_containing "stdebris")

	(print "ALLIES PROCEEDING THROUGH SUPER TRAP")
	
	(sleep 30)
	
	(print "05_089_elite1 --- Allies: There's no way we could have done it with out you!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0890_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0890_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0890_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0890_el1"))
	
	(print "05_090_elite2 --- Allies: we're lucky to have you in our group!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0900_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0900_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0900_el2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0900_el2"))

	(set music_trojan_progress 6)

)

(script command_script cs_supertrap_hds01

	(cs_vehicle_speed 1)

	(cs_fly_to_and_face supertrap_hds01/p0 supertrap_hds01/p4 4)
	(cs_fly_to_and_face supertrap_hds01/p1 supertrap_hds01/p4 4)
	(cs_fly_to_and_face supertrap_hds01/p2 supertrap_hds01/p4 4)
	(cs_fly_to_and_face supertrap_hds01/p3 supertrap_hds01/p4 4)	
	
	(sleep_until (cs_dropship_turret_dead))
	(cs_fly_to_and_face supertrap_hds01/p5 supertrap_hds01/p6 4)
	(cs_fly_to supertrap_hds01/p5)
	(cs_erase_squad)
)

(script static void dtest14

	(ai_erase supertrap_hds01)
	
	(sleep 10)
	
	(ai_place supertrap_hds01)
	
	(cs_run_command_script supertrap_hds01 cs_supertrap_hds01)
)

(script dormant supertrap_hds01

	(sleep_until (volume_test_objects supertrap_hds01 (players))15)
	
	(ai_erase supertrap_hds01)
	
	(sleep 10)
	
	(ai_place supertrap_hds01)
	
	(sleep 300)
	
	(cs_run_command_script supertrap_hds01 cs_supertrap_hds01)
	
;	(sleep_until (volume_test_objects excavation_e_i_back (players))15)
	
;	(object_destroy (ai_vehicle_get supertrap_hds01))
)

(script dormant supertrap_end
	;ln1225
	(sleep_until (volume_test_objects super_trap_allied_end (players))15)

	(ai_place supertrap_end01)
	
	(sleep_until 
		(or
			(volume_test_objects supertrap_end02 (players))
			(<= (ai_living_count supertrap_end01) 2)
		)
		15)

	(ai_place supertrap_end02)
	
	(sleep_until 
		(or
			(volume_test_objects supertrap_end02 (players))
			(<= (ai_living_count supertrap_end01) 0)
			(<= (ai_living_count supertrap_end01) 2)
		)
		15)
		
	(ai_set_orders supertrap_end02 supertrap_end02)
	
	(sleep_until 
		(or
			(<= (ai_living_count supertrap_end01_02) 0)
		
			(and
				(volume_test_objects supertrap_end03 (players))
				(<= (ai_living_count supertrap_end01_02) 2)
			)
		)
	15)
	
	(ai_place supertrap_end03)
	
	(ai_set_orders supertrap_end03 supertrap_end02)
	
	(sleep_until 
		(or
			(volume_test_objects supertrap_end03 (players))
			(<= (ai_living_count supertrap_end03) 1)
		)
	)
	
	(ai_place supertrap_end04)
	
	(ai_set_orders supertrap_end03 supertrap_end03)
	
	
	(print "supertrap_end01")
)

(script dormant supertrap_save
	
	(print "supertrap_save")
	
	(sleep_until (volume_test_objects supertrap_save (players))15)
	
	; delete old AI
	(ai_disposable runandgun02 1)
	(ai_disposable 1turret 1)
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(object_create_containing "supertrap_debris")

)

(script dormant supertrap_bridge01; maybe eventually add script to check for # of guys before these guys spawn
	;ln1197
	(sleep_until (volume_test_objects supertrap_bridge01 (players))15)
	
	(ai_place supertrap_bridge01)
	
)

(script dormant supertrap_interior
	;ln1196
	(sleep_until 
		(or
			(volume_test_objects supertrap_interior_low (players))
			(volume_test_objects supertrap_interior (players))
		)
	15)
	
	(ai_place supertrap_interior)

)

(script dormant supertrap_v

	(sleep 20)
	
	(sleep_until (volume_test_objects supertrap01 (players))15)
	
	(wake supertrap_interior);wake ln1156
	(wake supertrap_bridge01);wake ln1169
	
	(wake supertrap_end);wake ln1144
	
	
	(object_create supertrap_jackable_wraith01)

	;(object_create supertrap_wraith_right)
	;(object_create supertrap_wraith_left)
	
	(ai_place supertrap_left_v)
	(ai_place supertrap_right_v)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors supertrap_left_v) 0)) supertrap_wraith_left "wraith_driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors supertrap_right_v) 0)) supertrap_wraith_right "wraith_driver")
	
	(ai_set_orders supertrap_left_v supertrap_v_left_intro)
	(ai_set_orders supertrap_right_v supertrap_v_right_intro)
	
	(sleep_until (volume_test_objects supertrap_v_attack (players))15)
	
	(ai_set_orders supertrap_left_v supertrap_v_attack)
	(ai_set_orders supertrap_right_v supertrap_v_attack)
	
	(object_create_containing "excavation_e_debris")
	
	

)

(script dormant supertrap_middle_save

	(sleep_until 
		(or	
			(volume_test_objects supertrap_middle_save (players))
			(volume_test_objects supertrap_bridge01_cntr (players))
			(volume_test_objects supertrap_third_bridge (players))
		)	
	15)
	
	(game_save_immediate);SSSAAAVVVEEE---
)

(script dormant supertrap01
	
	(print "supertrap01")
	
	(wake supertrap_allied_praise);wake
	
	(wake supertrap_allied_reminder);wake
	
	(wake supertrap_save);wake
	
	(wake supertrap_v);wake
	
;	(wake excavation_e);wake
	
	(sleep_until (volume_test_objects supertrap01 (players))15)
	
	(print "trigger")
	
	(object_create_containing "stdebris")
	
	(ai_place supertrap_turretgrunts01)
	
	(ai_set_orders supertrap_turretgrunts01 supertrap_turret_attack)
	
	(sleep 15)
	
	;(wake ai_kill04);wake
	
	(wake supertrap_middle_save);wake
	
	(wake supertrap_hds01);wake

	;v--------------supertrap ground tank-----------v
	
	(ai_place supertrap_tankelites01)
		
	(ai_set_orders supertrap_tankelites01 supertrap_ground_v_intro)
	
	;v-------------supertrap frontgrunts------------v

	(ai_place supertrap_grunts01)
	(ai_place supertrap_grunts02)
	
	(ai_set_orders supertrap_grunts01 supertrap_first_bridge)
	(ai_set_orders supertrap_grunts02 supertrap_turret_attack)
	
	;v------------more supertrap grunts-------------v

	(sleep_until (volume_test_objects supertrap02 (players))15)

	(ai_place supertrap_grunts03)
	
	(ai_set_orders supertrap_grunts03 supertrap_right_i_attack)
	
	(sleep 1800)
	
	(set music_trojan_progress 6)

)


;vvvvvvvv====================Pre_s_trap==================vvvvvvvvvvv

(script dormant pre_s_trap_front_back

	(sleep_until (<= (ai_living_count pre_s_trap_front_back) 3))
	
	(ai_set_orders pre_s_trap_front_back pre_s_trap_back)
	

)
(script dormant pre_s_trap_back_all

	(sleep_until (volume_test_objects pre_s_trap_back_all (players))15)

	(if G_pre_s_trap_back (sleep_forever))
	(set G_pre_s_trap_back true)

	(ai_place pre_s_trap_back)
	
	(ai_place pre_s_trap_back02)
	
	(wake pre_s_trap_front_back);wake

)

(script dormant pre_s_trap_back

	(sleep_until 
		(or
			(volume_test_objects pre_s_trap_back (players))
			(<= (ai_living_count pre_s_trap_front) 2)
		)
	)

	(if G_pre_s_trap_back (sleep_forever))
	(set G_pre_s_trap_back true)

	(ai_place pre_s_trap_back)
	
	(ai_set_orders pre_s_trap_back pre_s_trap_front)
	
	(wake pre_s_trap_front_back);wake
	
	(sleep_until (volume_test_objects pre_s_trap_back_all (players))15)
	
	(ai_place pre_s_trap_back02)
	

)

(script dormant pre_s_trap
	;ln2313
	(sleep_until (volume_test_objects supertrap_save (players))15)

	(ai_place pre_s_trap_front)
	
	(wake pre_s_trap_back);wake
	
	(wake pre_s_trap_back_all);wake
	
	(wake supertrap01);wake
	
	(set music_trojan_progress 4)
	
)



(script dormant supertrap_allied_trap_response

	(sleep_until (volume_test_objects supertrap01 (players))15)
	
	(print "05_084_elite1 --- Allies: retreat!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0840_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0840_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0840_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0840_el1"))
	
	(print "05_085_elite2 --- Allies: were sitting ducks!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0850_el2" none 1 Audio_filter_elite_l_2) 
	(cinematic_subtitle l05_0850_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0850_el2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0850_el2"))
	
	(print "05_085_elite2 --- Allies: this was a stupid idea!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0860_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0860_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0860_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0860_el1"))
	
	;vvvvv------ allies telling player they wont progress------vvvv
	
	(print "05_087_elite1 --- Allies: That area is too well defended!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0870_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0870_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0870_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0870_el1"))
	
	;(print " --- Allies: We cant advance with our vehicles!!!!")
	(sleep 45)
	
	(print "05_088_elite2 --- Allies: We'll all be killed if we go through that with our vehicles!!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0880_el2" none 1 Audio_filter_elite_l_2) 
	(cinematic_subtitle l05_0880_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0880_el2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0880_el2"))
)

(script dormant supertrap_allied_warning

	(sleep_until (volume_test_objects supertrap_allied_warning (players))15)
	
	(print "05_082_elite1 --- Allies: that looks dangerous")
	(print "05_082_elite1 NEWEST --- Allies: This is a narrow path...")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0820_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0820_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0820_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0820_el1"))
	
	(print "05_083_elite2 --- Allies: we'll be helpless in there")
	(print "05_083_elite2 NEWEST --- Allies: ...and dangerous. Be vigiliant")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0830_el2" none 1 Audio_filter_elite_l_2) 
	(cinematic_subtitle l05_0830_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0830_el2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0830_el2"))
	
	(wake supertrap_allied_trap_response);wake

)

;vvvvvv-------vvvvvvvvvvv-- 2 TURRET --vvvvvvvvv------------------------------------------------------------VVVVVVV
;vvvvvv-------vvvvvvvvvvv-- 2 TURRET --vvvvvvvvv------------------------------------------------------------VVVVVVV
;vvvvvv-------vvvvvvvvvvv-- 2 TURRET --vvvvvvvvv------------------------------------------------------------VVVVVVV

(script static boolean l_or_r_2guntowers_dead
	(or 
		(<= (unit_get_health 2guntower_right) 0)
		(<= (unit_get_health 2guntower_left) 0)
	)
)

(script command_script cs_2turret_hdropship01

	(cs_fly_by 2turret_hdropship01/p0)
	(cs_fly_to_and_face 2turret_hdropship01/p1 2turret_hdropship01/p2)
	(cs_fly_to_and_face 2turret_hdropship01/p2 2turret_hdropship01/p3)
	(cs_fly_to_and_face 2turret_hdropship01/p3 2turret_hdropship01/p4)
	(cs_fly_to 2turret_hdropship01/p4)
	(sleep_until (or (cs_dropship_turret_dead) (l_or_r_2guntowers_dead)))
	(cs_fly_by 2turret_hdropship01/p4)
	(cs_fly_to_and_face 2turret_hdropship01/p3 2turret_hdropship01/p4)
	(cs_fly_to_and_face 2turret_hdropship01/p2 2turret_hdropship01/p3)
	(cs_fly_to_and_face 2turret_hdropship01/p1 2turret_hdropship01/p2)
	(cs_fly_to 2turret_hdropship01/p1)
	(cs_fly_to 2turret_hdropship01/p0)
	(cs_erase_actor)
)

(script static boolean are_guntowers2_dead
	(and
		(<= (unit_get_health 2guntower_left)0) 
		(<= (unit_get_health 2guntower_right)0)
	)
)

(script dormant 2turret_hdropship01

	(sleep_until (volume_test_objects 2turret_attack_back (players))15)
	
	(sleep 110)
	
	(ai_place 2turret_hdropship01)
	
	(ai_set_orders 2turret_hdropship01 2turret_dropship_right)
	
	(cs_run_command_script 2turret_hdropship01 cs_2turret_hdropship01)
)

(global object 2turret_cinematic_p0_vehicle NONE)
(global object 2turret_cinematic_p1_vehicle NONE)

(script dormant 2turret_cinematic
	(sleep_until
		(and
			(<= (ai_living_count 2turret_tankelites01) 1)
			(<= (ai_living_count 2turret_ghostelites01) 1)
		)
	)	
	
	(set music_mirage_1 true)
	
	(sleep_until
		(and
			(<= (ai_living_count 2turret_tankelites01) 0)
			(<= (ai_living_count 2turret_ghostelites01) 0)
			(<= (ai_living_count 2turret_av_turrets) 0)
		)
	)	
	(wake excavation_end_heretic_dialog)

	(sleep_until (are_guntowers2_dead))
	(ai_braindead  (object_get_ai (object_at_marker (ai_vehicle_get 2turret_hdropship01/starting_locations_0) "gunseat")) true)
	(sleep 30)

	(cinematic_fade_to_white)
	(if (cinematic_skip_start)
		(begin
			(hlead_intro);wake
		)
	)
    (cinematic_skip_stop)
	(cinematic_fade_from_white)

	(ai_braindead  (object_get_ai (object_at_marker (ai_vehicle_get 2turret_hdropship01/starting_locations_0) "gunseat")) false)
	(wake excavation_end_covenant_victory);wake
)

	
(script dormant 2turret_allied_reinforcements

	(sleep 20)
	
	(wake supertrap_allied_warning);wake
	
	(object_create_containing "2turret_allied_R")
	
	(sleep 35)
	
	(print "--- Allies: what a relief")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0780_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0780_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0780_el1") subtitle_time) subtitle_time_add))
	
	(sleep 65)
	
	(print "--- Allies: they don�t stand a chance now")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0790_el2" none 1 Audio_filter_elite_l_2) 
	(cinematic_subtitle l05_0790_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0790_el2") subtitle_time) subtitle_time_add))
	
	(sleep 65)

	(print "--- Reinforcements: ready to serve!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0800_gr1" none 1 Audio_filter_grunt_1) 
	(cinematic_subtitle l05_0800_gr1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0800_gr1") subtitle_time) subtitle_time_add))
	
	(sleep 38)
	
	(print "--- Reinforcements: victory will be ours!!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0810_gr2" none 1 Audio_filter_grunt_2) 
	(cinematic_subtitle l05_0810_gr2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0810_gr2") subtitle_time) subtitle_time_add))
)
	
	
	
(script command_script cs_2turret_a_ds02

	(cs_vehicle_speed 1)

	(cs_fly_to 2turret_a_ds02/p0 4)
	(cs_fly_to 2turret_a_ds02/p1 4)
	(cs_fly_to 2turret_a_ds02/p2 4)
	(cs_fly_to 2turret_a_ds02/p3 4)
	(cs_vehicle_speed 1)
	(cs_fly_to 2turret_a_ds02/p4 4)
	(cs_fly_to_and_face 2turret_a_ds02/p5 2turret_a_ds02/p6 4)
	
	(vehicle_unload (cs_vehicle_get) "phantom_p")
	
	(cs_pause 32000)
	(ai_braindead ai_current_actor 1); disable
	(sleep_forever)
)	
	
(script command_script cs_2turret_a_ds01

	(cs_vehicle_speed 1)

	(cs_fly_to 2turret_a_ds01/p0 4)
	(cs_fly_to 2turret_a_ds01/p1 4)
	(cs_fly_to 2turret_a_ds01/p2 4)
	(cs_vehicle_speed 1)
	(cs_fly_to 2turret_a_ds01/p3 4)
	
	(print "--- DS pilot:Prepare for landing")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0770_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0770_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0770_el1") subtitle_time) subtitle_time_add))
	
	(cs_fly_to_and_face 2turret_a_ds01/p4 2turret_a_ds01/p5 4)
	
	;(cs_pause 90)
	(print "unload")
	
	(vehicle_unload (cs_vehicle_get) "phantom_lc")
	(vehicle_unload (cs_vehicle_get) "phantom_p")
	
	(wake 2turret_allied_reinforcements);wake
	
	(cs_pause 32000)
	(ai_braindead ai_current_actor 1) ; disable
	(sleep_forever)
)

(script static void 2turret_a_ds_run

	(ai_erase 2turret_a_ds01)
	
	(sleep 10)
	
	(ai_place 2turret_a_ds01)
	
	(ai_place_in_vehicle 2turret_a_ds_wraith 2turret_a_ds01)
	(ai_place_in_vehicle 2turret_allies_cds 2turret_a_ds01)
	
	(cs_run_command_script 2turret_a_ds01/1 cs_2turret_a_ds01)
	
	(sleep 30)
	
	(ai_place_in_vehicle 2turret_allies_cds 2turret_a_ds01)
	
	(cs_run_command_script 2turret_a_ds01/2 cs_2turret_a_ds02)
	
)

(script dormant 2turret_a_ds01
	(print "2turret_a_ds01")
	(2turret_a_ds_run) ; run
)

(script dormant 2turret_allied_reinforce_dialog
	
	(sleep_until (are_guntowers2_dead))
	
	(sleep 30)
	
	(wake 2turret_a_ds01);wake
	
	(print "--- DS pilot: Proceeding to new LZ")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0760_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0760_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0760_el1") subtitle_time) subtitle_time_add))
	
	(sleep 65)
	
	;(object_destroy 2turret_dropship02)
)


(script command_script cs_2turret_trench
	
	(print "guys walk off cliff")
	
	(cs_move_in_direction 71 7 0)
)	


(script dormant 2turret_trench

	(sleep_until (volume_test_objects 2turret_trench (players))15)
	
	(ai_place 2turret_trench01)

	(cs_run_command_script 2turret_trench01 cs_2turret_trench)
)

(script dormant 2turret_interior_front_front

	(sleep_until (volume_test_objects 2turret_interior_front_front (players))15)

	(if G_2turret_interior_front (sleep_forever))
	(set G_2turret_interior_front true)
	
	(wake 2turret_trench);wake
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(ai_place 2turret_interior_front)

	(ai_set_orders 2turret_interior_front 2turret_interior_front)
	
	(sleep_until 
		(or
			(volume_test_objects 2turret_interior_f_exit (players))
			(<= (ai_living_count 2turret_interior_front) 2)
		)	
	15)
	
	(ai_place 2turret_interior_f_exit)
	
	(ai_set_orders 2turret_interior_f_exit 2turret_interior_f_exit)
	
	(sleep_until 
		(volume_test_objects 2turret_interior_middle_f02 (players))15)
		
	(ai_set_orders 2turret_interior_f_exit 2turret_interior_middle_f)
	
	(ai_set_orders 2turret_interior_front 2turret_interior_f_exit)
		
	(ai_place 2turret_interior_middle_b)
	
	(ai_set_orders 2turret_interior_middle_b 2turret_interior_middle_b)
	
)

(script dormant 2turret_interior_front_back

	(sleep_until (volume_test_objects 2turret_interior_front_back (players))15)

	(if G_2turret_interior_front (sleep_forever))
	(set G_2turret_interior_front true)
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(ai_place 2turret_interior_middle_b)
	
	(ai_set_orders 2turret_interior_middle_b 2turret_interior_middle_b)
	
	(ai_place 2turret_interior_f_exit)
	
	(ai_set_orders 2turret_interior_f_exit 2turret_interior_middle_b)
	
	(sleep_until 
		(or
			(<= (ai_living_count 2turret_interior_middle) 2)
			(volume_test_objects 2turret_interior_middle_f (players))
		)
	)
		(ai_set_orders 2turret_interior_middle 2turret_interior_middle_f)
		
	(sleep_until (volume_test_objects 2turret_interior_front_front (players))15)
	
	(ai_set_orders 2turret_interior_middle 2turret_interior_f_exit_r)
	
	(ai_place 2turret_interior_front)
	
	(ai_set_orders 2turret_interior_front 2turret_interior_front)
	
)

	;vvvvvvvvvv 2 turret--------interior back  vvvvvvvvvvvvvvvv

(script dormant 2turret_interior_back
	
	(sleep_until (volume_test_objects 2turret_interior_back (players))15)
	
	(game_save_immediate);SSSAAAVVVEEE---
	
		(ai_place 2turret_interior_back)
	
		(ai_set_orders 2turret_interior_back 2turret_interior_back)
	
		(ai_place 2turret_interior_back_low)
	
	(sleep_until (volume_test_objects 2turret_interior_back02 (players))15)
	
		(ai_set_orders 2turret_interior_back_low 2turret_interior_back)
)

(script static void unbreak_guntower
	(print "unbreak_guntower")
	(unit_kill (ai_get_unit ai_current_actor))
	(ai_kill ai_current_actor)
)

(script command_script cs_guntower_shoot_player
	(print "cs_guntower_shoot_player")
	;(cs_make_immortal) ; immortality!! what an idea!
	;(cs_force_combat_status 3)
	(cs_enable_targeting 1)
	(cs_aim_player 1)
	(cs_shoot 1)
	; neat hack from the game scripts themselves
	; you can implement a loop using sleep_until
	; try it sometimes
	(sleep_until
		(begin
			; disable force aim if a player is close to the vehicle
			(if (> 25 (objects_distance_to_object (players) (cs_get_object))) (begin (cs_aim_player 0)) (cs_aim_player 1))
			(cs_is_my_mount_dead) ; basically loop forever until the vehicle is destroyed
		)
		1
	)
	
	(unbreak_guntower)
	;(cs_erase_actor) ; die die die!
)


(script static void 2turret_creation
	; place the vehicles
	(object_create_anew 2guntower_left)
	(object_create_anew 2guntower_right)
	; link them to the AI squad
	(ai_attach 2guntower_left 2_guntower)
	(ai_attach 2guntower_right 2_guntower)
	
	(ai_force_active 2_guntower 1)
	
	(wake plant_gt_4_bomb)
	(wake plant_gt_5_bomb)	
	
	(cs_run_command_script 2_guntower cs_guntower_shoot_player)
)

(script static void 2turret_test
	; clear old
	(ai_erase 2guntower)
	(ai_erase 2_guntower)
	(2turret_creation)
)


(script dormant 2turret_allies_cds

	(object_create_containing "2turret_a_cds_debris")
	
	(object_create 2turret_allies_cds01)
	
	(sleep 45)
	
	(ai_place 2turret_allies_cds)
	
	(ai_set_orders 2turret_allies_cds 2turret_allies_cds)
)



(script dormant 2turret_middle_dialog

	(sleep_until (volume_test_objects 2turret_attack_back (players))15)
	
	;(wake 2turret_allied_reinforce_dialog);wake

	(print "--- Allies: we need to get around them!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0720_el1" none 1 Audio_filter_elite_l_1) 
	(cinematic_subtitle l05_0720_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0720_el1") subtitle_time) subtitle_time_add))
	
	(sleep 60)
	
	(print "--- Allies: attacking these turrets with vehicles is futil!!") 
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0730_el2" none 1 Audio_filter_elite_l_2) 
	(cinematic_subtitle l05_0730_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0730_el2") subtitle_time) subtitle_time_add))

)

(script dormant 2turret_intro_dialog

	(sleep_until (volume_test_objects 2turret_intro_dialog (players))15)
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(wake 2turret_middle_dialog);wake
	
	(sleep 25)
	
	;(wake music_6)
	
	(sleep 25)
	
	(print "--- Allies: WART WART!! Theres 2 turrets!!") 
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0700_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0700_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0700_el1") subtitle_time) subtitle_time_add))
	
	(sleep 60)
	
	(print "--- Allies: Our vehicles are vunerable!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0710_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0710_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0710_el2") subtitle_time) subtitle_time_add))

)

(script dormant 2turret01

	(sleep_until (volume_test_objects 2turret01 (players))15)
	
	; delete old AI
	(ai_disposable supertrap 1)
	(ai_disposable runandgun02 1)
	
	(wake chapter_mirage)
	
	(2turret_creation);run
	(wake 2turret_intro_dialog);wake
	
	(ai_place 2turret_tankelites01)
	(ai_place 2turret_ghostelites01)
	(ai_place 2turret_av_turrets)
	
	(wake music_mirage)
	
	(sleep 5)
	
	(wake 2turret_allies_cds);wake
	
	(object_destroy_containing "1turret_debris")
	
	;(object_create 2turret_ghost01)
	;(object_create 2turret_ghost02)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors 2turret_ghostelites01) 0)) 2turret_ghost01 "g-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors 2turret_ghostelites01) 1)) 2turret_ghost02 "g-driver")
	
	;(ai_set_orders 2turret_tankelites01 2turret_w_intro)
	
	(ai_set_orders 2turret_ghostelites01 2turret_g_intro)
	
	(ai_set_orders 2turret_av_turrets 2turret_w_attack_front)
	
	
	(sleep_until (volume_test_objects 2turret_attack_back (players)))
	
	;(ai_set_orders 2turret_tankelites01 2turret_w_attack_back)
	
	(sleep 5)
	
	;(object_create 2turret_avturret01)
	;(object_create 2turret_avturret02)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors 2turret_av_turrets) 0)) 2turret_avturret01 "gt-gunner")
	;(unit_enter_vehicle (unit (list_get (ai_actors 2turret_av_turrets) 1)) 2turret_avturret02 "gt-gunner")
	
	
	;(object_create 2turret_player_wraith01)
	
	(if use_final_battle_dropships (wake final_bat_hds) (wake 2turret_hdropship01));wake
	(wake 2turret_cinematic);wake control script
	
	(sleep 30)
	
	(wake 2turret_interior_front_front);wake
	(wake 2turret_interior_front_back);wake
	
	(wake 2turret_interior_back);wake

)





;VVVVVVVVVVVV+++++++++++   RUNANDGUN02   ++++++++--------------------------------------------------------vvvvvvvvvv
;VVVVVVVVVVVV+++++++++++   RUNANDGUN02   ++++++++--------------------------------------------------------vvvvvvvvvv
;VVVVVVVVVVVV+++++++++++   RUNANDGUN02   ++++++++--------------------------------------------------------vvvvvvvvvv

(script dormant runandgun02_interior_top
;ln1911
	(sleep_until 
		(or
			(volume_test_objects runandgun02_interior_top (players))
			(<= (ai_living_count runandgun02_t_grunts02) 1)
		)
	)

	(ai_place runandgun02_interior_top)
)

(script dormant runandgun02_interior_cnt_l
;ln1899
	(sleep_until 
		(or
			(volume_test_objects runandgun02_interior_up (players))
			(<= (ai_living_count runandgun02_interior_i) 3)
		)
	)

	(if G_runandgun02_interior_l (sleep_forever))
	(set G_runandgun02_interior_l true)
	
	(ai_place runandgun02_interior_left)
	
	(ai_place runandgun02_interior_cnt)
	
	(ai_set_orders runandgun02_interior_l runandgun02_interior_l)
	
	(ai_set_orders runandgun02_interior_cnt_l runandgun02_interior_cnt_l)
	
	(ai_set_orders runandgun02_interior_cnt runandgun02_interior_cnt)
	
	(sleep_until (volume_test_objects runandgun02_interior_trigger (players)))
	
		(ai_set_orders runandgun02_interior_left runandgun02_interior_cnt)
)

(script dormant runandgun02_interior_l
;ln1897
	(sleep_until (volume_test_objects runandgun02_interior_l (players)))

	(if G_runandgun02_interior_l (sleep_forever))
	(set G_runandgun02_interior_l true)
	
	(ai_place runandgun02_interior_left)
	
	(ai_set_orders runandgun02_interior_left runandgun02_interior_l)
	
	;(sleep_until (volume_test_objects runandgun02_interior_cnt_l (players)))
	
	(sleep_until (<= (ai_living_count runandgun02_interior_left) 3))
	
	(ai_place runandgun02_interior_cnt)
	
	(ai_set_orders runandgun02_interior_cnt runandgun02_interior_cnt_l)
)


	;vvvvvvvvVVVV----- runandgun02 ghostelites01 ------VVVVVVvvvvvvv
	
(script dormant runandgun02_interior

	(sleep_until 
		(or
			(volume_test_objects runandgun02_interior_trigger (players))
			(volume_test_objects runandgun02_interior_back (players))	
		)
	)

	(wake runandgun02_interior_l);wake ln1873
	(wake runandgun02_interior_cnt_l);wake ln1844
	(wake runandgun02_interior_top);wake ln1843
	
	(game_save_immediate);SSSAAAVVVEEE---
		
	(ai_place runandgun02_interior)
	(ai_place runandgun02_interior02)
	
	(ai_set_orders runandgun02_interior runandgun02_interior_intro_low)
	(ai_set_orders runandgun02_interior02 runandgun02_interior_intro_hig)
	
	(sleep_until 
		(or	(<= (ai_living_count runandgun02_interior_i) 3)
			(volume_test_objects runandgun02_interior_low_trigge (players))
		)
	)
	
	(ai_place runandgun02_interior_r)
	
	(ai_set_orders runandgun02_interior_r runandgun02_interior_intro_low)
)	

(script dormant runandgun02_g_reinforce_high

	(sleep_until (volume_test_objects runandgun02_up01 (players)))
	
	(sleep_until (<= (ai_living_count runandgun02_ghostelites01) 0))

	(if G_runandgun02_g_reinforcements (sleep_forever))
	(set G_runandgun02_g_reinforcements true)

	(ai_place runandgun02_r_ghostelites01)
	
	;(object_create runandgun02_ghost03)
	;(object_create runandgun02_ghost04)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_r_ghostelites01) 0)) runandgun02_ghost03 "g-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_r_ghostelites01) 0)) runandgun02_ghost04 "g-driver")
	
	(ai_set_orders runandgun02_r_ghostelites01 runandgun02_g_intro_up)
)

(script dormant runandgun02_g_reinforce_low

	(sleep_until (volume_test_objects runandgun02_low (players)))
		
	(sleep_until 
		(or
			(<= (ai_living_count runandgun02_tankelites01) 0)
			(volume_test_objects runandgun02_low (players))
		)
	)

	(if G_runandgun02_g_reinforcements (sleep_forever))
	(set G_runandgun02_g_reinforcements true)
	
	(ai_place runandgun02_r_ghostelites01)
	
	(ai_set_orders runandgun02_r_ghostelites01 runandgun02_g_intro_low)
)

(script dormant runandgun02_ghostelites01

	(sleep_until 
		(or
			(volume_test_objects runandgun02_ghostelites01 (players))
			(<= (ai_living_count runandgun02_low_wraiths) 1)
		)	
	15)
	
	(if G_runandgun02_g (sleep_forever))
	(set G_runandgun02_g true)
	
	;(object_create runandgun02_ghost01)
	;(object_create runandgun02_ghost02)

	(ai_place runandgun02_ghostelites01)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_ghostelites01) 0)) runandgun02_ghost01 "g-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_ghostelites01) 1)) runandgun02_ghost02 "g-driver")
	
	(ai_set_orders runandgun02_ghostelites01 runandgun02_g_intro_low)

)

(script dormant runandgun02_ghostelites02

	(sleep_until 
		;(or
			(volume_test_objects runandgun02_up01 (players))
			;(<= (ai_living_count runandgun02_tankelites01) 1)
		;)	
	15)
	
	(if G_runandgun02_g (sleep_forever))
	(set G_runandgun02_g true)
	
	;(object_create runandgun02_ghost01)
	;(object_create runandgun02_ghost02)

	(ai_place runandgun02_ghostelites01)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_ghostelites01) 0)) runandgun02_ghost01 "g-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_ghostelites01) 1)) runandgun02_ghost02 "g-driver")
	
	(ai_set_orders runandgun02_ghostelites01 runandgun02_g_intro_up)
)

(script dormant runandgun02_up_wraith

	;(object_create runandgun02_wraith03)
	
	(ai_place runandgun02_up_wraith)

	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_up_wraith) 0)) runandgun02_wraith03 "wraith-driver")

	(ai_set_orders runandgun02_up_wraith runandgun02_up_wraith_intro)
)
;(runandgun02_dialog_wraith_warning

;	(sleep_until 
;		(or
;			(volume_test_objects runandgun02_low (players))
;			(volume_test_objects runandgun02_up01 (players))
;		)
;	)

;	(print "--- Allies: Watch out Wraiths!!!")
	
;	(sleep 55)
	
;	(print "--- Allies: How did they get all these tanks?")

;)

(script dormant runandgun02_dialog_low
		 
	(sleep_until (volume_test_objects runandgun02_low (players)))
	
	(if G_runandgun02_dialog  (sleep_forever))
	(set G_runandgun02_dialog  true)
	
		(sleep 15)
	
	(print "--- Allies: Watch out Wraiths!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0610_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0610_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0610_el1") subtitle_time) subtitle_time_add))
	
		(sleep 55)
	
	(print "--- Allies: How did they get all these tanks?")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0620_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0620_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0620_el1") subtitle_time) subtitle_time_add))
	
		(sleep 60)
	
	(print "--- Allies: those turrets above us are hard to hit!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0670_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0670_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0670_el1") subtitle_time) subtitle_time_add))
	
		(sleep 30)
	
	(print "--- Allies: Taking heavy Fire!!!")
)

(script dormant runandgun02_dialog_hi
	
	(sleep_until (volume_test_objects runandgun02_up01 (players)))
	
	; dispose of AI from view and previous turret section
	(ai_disposable view 1)
	(ai_disposable 1turret 1)
		 
	(if G_runandgun02_dialog  (sleep_forever))
	(set G_runandgun02_dialog  true)
	
	(sleep 15)
	
	(print "--- Allies: Watch out Wraiths!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0610_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0610_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0610_el1") subtitle_time) subtitle_time_add))
	
	(sleep 55)
	
	(print "--- Allies: How did they get all these tanks?")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0620_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0620_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0620_el1") subtitle_time) subtitle_time_add))
	
	(sleep 60)
	
	(print "--- Allies: theres no cover from drop ships up there!!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0660_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0660_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0660_el1") subtitle_time) subtitle_time_add))
	
	(sleep 30)
	
	(print "--- Allies: Taking heavy Fire!!!")
)

(script dormant runandgun02_banshees

	(ai_place runandgun02_banshees)
)

(script command_script cs_runandgun02_hds01

	(cs_vehicle_speed 1)

	(cs_fly_to_and_face runandgun02_hds01/p0 runandgun02_hds01/p3 4)
	(cs_fly_to_and_face runandgun02_hds01/p1 runandgun02_hds01/p3 4)
	(cs_fly_to_and_face runandgun02_hds01/p2 runandgun02_hds01/p3 4)
)

(script continuous runandgun02_hds01_loop
	(if (not global_playtest_mode) (sleep_until dig_100percentready 4))
	(print "continuous running")
	
	(sleep_until 
		(not 
			(cs_command_script_running runandgun02_hds01 cs_runandgun02_hds01)
		)
	)
	
	(print "script running")
	
	(cs_run_command_script runandgun02_hds01 cs_runandgun02_hds01)
)	

(script command_script cs_runandgun02_hds01_int

	(cs_vehicle_speed 1)

	(cs_fly_to runandgun02_hds01_int/p0 4)
	(cs_fly_to runandgun02_hds01_int/p1 4)
	(cs_fly_to runandgun02_hds01_int/p2 4)
	(cs_fly_to runandgun02_hds01_int/p3 4)
	
	(wake runandgun02_hds01_loop);wake
)

(script static void dtest09

	(ai_erase runandgun02_hds01)
	
	(sleep 10)
	
	(ai_place runandgun02_hds01)
	
	(cs_run_command_script runandgun02_hds01 cs_runandgun02_hds01_int)
	
	(sleep_until (volume_test_objects 2turret_intro_dialog (players)))
	(sleep_forever runandgun02_hds01_loop)
	(object_destroy (ai_vehicle_get runandgun02_hds01/starting_locations_0))
)

(script dormant runandgun02_hds01_int
	(ai_erase 1turret_hdropship01)
	
	(sleep 10)
	
	(ai_place 1turret_hdropship01)
	
	(cs_run_command_script runandgun02_hds01 cs_runandgun02_hds01_int)
	
	(sleep_until (volume_test_objects 2turret_intro_dialog (players)))
	(sleep_forever runandgun02_hds01_loop)
	(object_destroy (ai_vehicle_get runandgun02_hds01/starting_locations_0))
)

(script static void runandgun02_create
	; OLD SCRIPT VERSION, NOT USED ANYMORE
	(object_create runandgun02_turret01)
	(object_create runandgun02_turret02)
	(object_create runandgun02_turret03)
	(object_create runandgun02_turret04)
	(object_create runandgun02_turret05)
	(object_create runandgun02_turret06)
	
	(object_create runandgun02_player_w01)
	
	(object_create_containing "runandgun02_debris")
		
	(ai_place runandgun02_t_grunts01)
	(ai_place runandgun02_t_grunts02)
	
	(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_t_grunts01) 0)) runandgun02_turret01 "gt_gunner")
	(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_t_grunts01) 1)) runandgun02_turret02 "gt_gunner")
	(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_t_grunts01) 2)) runandgun02_turret03 "gt_gunner")
	
	(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_t_grunts02) 0)) runandgun02_turret04 "gt_gunner")
	(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_t_grunts02) 1)) runandgun02_turret05 "gt_gunner")
	(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_t_grunts02) 2)) runandgun02_turret06 "gt_gunner")
)

(script dormant runandgun02

	(sleep_until (volume_test_objects runandgun02 (players)))
	(if (< nav 9) (set nav 8))	(wake navpoints)
	(wake navhelper_runandgun02)
	(wake chapter_runandgun02) (wake objective3_set)
	
	; dispose of AI from view section
	(ai_disposable view 1)
	
	(object_destroy runandgun01_turret01)
	
	(object_destroy view_wraith02)
	(object_destroy view_ghost01)
	
	;v---------- wake script ai_kill02------------v
	
	;(wake ai_kill02);wake
	
	;v---------- game save------------v

	(game_save_immediate);SSSAAAVVVEEE---
	
	(if (< music_trojan_progress 2)
		(set music_trojan_progress 2)
	)	
	
	;v---------- runandgun02 enemies------------vv
	
	; DIG: OLD VERSION THAT DIDN'T SPAWN THE VEHICLE WITH THE AI
	;(runandgun02_create)
	
	(set music_trojan_progress 3)
	
	(ai_place runandgun02_t_grunts01)
	(ai_place runandgun02_t_grunts02)
	
	(ai_set_orders runandgun02_t_grunts01 runandgun02_v_attack)
	(ai_set_orders runandgun02_t_grunts02 runandgun02_v_attack)
	
	;(object_create runandgun02_wraith01)
	;(object_create runandgun02_wraith02)
	
	(ai_place runandgun02_tankelites01)
	(ai_place runandgun02_exit_wraith)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_tankelites01) 0)) runandgun02_wraith01 "wraith-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun02_tankelites01) 1)) runandgun02_wraith02 "wraith-driver")
	
	(ai_set_orders runandgun02_tankelites01 runandgun02_v_attack)
	(ai_set_orders runandgun02_exit_wraith runandgun02_exit_wraith)
	
	; OLD (wake navpoint_6)
	
	(wake runandgun02_ghostelites01);wake
	(wake runandgun02_ghostelites02);wake
	(wake runandgun02_interior);wake
	
	(sleep 15)
	
	(wake runandgun02_up_wraith);wake
	
	(wake runandgun02_dialog_hi);wake
	(wake runandgun02_dialog_low);wake
	
	(wake runandgun02_g_reinforce_high);wake
	(wake runandgun02_g_reinforce_low);wake
	
	(sleep 30)
	
	;(wake runandgun02_hds01_int);wake
	(wake runandgun02_banshees);wake
	
	(wake pre_s_trap);wakeln1374
	
	(if (< music_trojan_progress 2)
		(set music_trojan_progress 2)
	)
)






;vvvvvvvvvvv----------- 1TURRET!!!!!!!!!!!!!!!! --------------------------------------------------------vvvvvvvvvv
;vvvvvvvvvvv----------- 1TURRET!!!!!!!!!!!!!!!! --------------------------------------------------------vvvvvvvvvv
;vvvvvvvvvvv----------- 1TURRET!!!!!!!!!!!!!!!! --------------------------------------------------------vvvvvvvvvv


(script dormant 1turret_a_dropship01_cnt

		(sleep 30)
	
	(print "--- Allies: Excellent, reinforcements!")	
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0570_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0570_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0570_el1") subtitle_time) subtitle_time_add))
	
		(sleep 45)
	
	(print "--- Allies: good to see you brothers!")	
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0580_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0580_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0580_el2") subtitle_time) subtitle_time_add))
	
		(sleep 60)
	
	(print "--- Reinforcements: ready for next assualt!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0590_gr1" none 1 Audio_filter_grunt_1)
	(cinematic_subtitle l05_0590_gr1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0590_gr1") subtitle_time) subtitle_time_add))
	
		(sleep 65)
	
	(print "--- Reinforcements: locked and loaded!")

	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0600_gr2" none 1 Audio_filter_grunt_2)
	(cinematic_subtitle l05_0600_gr2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0600_gr2") subtitle_time) subtitle_time_add))

	(sleep 240)

	(if (< music_trojan_progress 2)
		(set music_trojan_progress 2)
	)
	
	(sleep_until (volume_test_objects 2turret01 (players)))
	(ai_erase 1turret_a_dropship01)
)

(script dormant 1turret_a_dropship01_d
	
	(sleep 55)
		
	(print "--- DS pilot: Clear Landing Zone for reinforcements")	
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0561_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0561_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0561_el1") subtitle_time) subtitle_time_add))
)

(script command_script cs_1turret_a_dropship01
	;; OLD (wake navpoint_phantom_1turret)
	(if (< nav 7) (set nav 7))	(wake navpoints)
	
	(object_create 1turret_allied_wraith01)
	(objects_attach (cs_vehicle_get) "large_cargo" 1turret_allied_wraith01 "")

	(cs_face true 1turret_a_dropship01/p2)
	(cs_vehicle_speed_instantaneous 35)
	(cs_face false 1turret_a_dropship01/p2)
	
	;(cs_fly_to 1turret_a_dropship01/p0 4)
	;(cs_fly_to 1turret_a_dropship01/p1 4)
	(cs_vehicle_boost 0)
	(cs_vehicle_speed 1)
	(cs_fly_to 1turret_a_dropship01/p2 10)
	(cs_fly_to 1turret_a_dropship01/p3 4)
	
	(cs_vehicle_speed 1)
	
	(wake 1turret_a_dropship01_d);wake
	
	(cs_fly_to_and_face 1turret_a_dropship01/p4 1turret_a_dropship01/p5 4)
	(sleep 20)
	(objects_detach (cs_vehicle_get) (object_at_marker (cs_vehicle_get) "large_cargo"))
	(set 1_turret_cargo_dropped true)
	
	;; OLD (wake navpoint_phantom_1turret)
	(if (< nav 8) (set nav 8))	(wake navpoints)
	
	(wake 1turret_a_dropship01_cnt);wake
	
	; wait until we are done fighting any remaining enemies
	(sleep_until (<= (ai_combat_status ai_current_squad) 2))

	;(sleep 1500)
	
	(cs_fly_by 1turret_a_dropship01/p5 4)
	(cs_fly_by 1turret_a_dropship01/p3 3)
	(cs_fly_by 1turret_a_dropship01/p2 3)
	(cs_fly_by 1turret_a_dropship01/flyaway1 3)
	(cs_fly_by 1turret_a_dropship01/flyaway2 3)
	(cs_fly_by 1turret_a_dropship01/flyaway3 3)
	
	; if cs_fly_by atom fails this can go wrong, make sure the player is far away before deleting
	(sleep_until (< 100 (objects_distance_to_object (players) (cs_get_object))))
	
	(cs_erase_squad)
)

(script static void 1turret_a_dropship01

	(ai_erase 1turret_a_dropship01)
	
	(sleep 10)
	
	(ai_place 1turret_a_dropship01)
	
	(cs_run_command_script 1turret_a_dropship01 cs_1turret_a_dropship01)
	
	(set should_cleanup_hdropship01 true)
)

(script dormant allied_reinforcements

	(sleep_until 
		(and
			(<= (ai_living_count 1turret_jack_elites01) 0)
			(<= (unit_get_health 1guntower)0)
		)
	)
	
	(1turret_a_dropship01);run
	
	(hud_allies) 
	; OLD (wake navpoint_5) 
	(if (< nav 7) (set nav 7))	(wake navpoints)
	
	(wake objective2_clear) 
	(wake objective3_set)
	
	(sleep 35)
	
	(print "--- DS pilot: Drop ships on route")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0560_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0560_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0560_el1") subtitle_time) subtitle_time_add))
	
	(sleep 300)
	
	(if (< music_trojan_progress 2)
		(set music_trojan_progress 2)
	)
)

	;Vvvvvvvvvvvvv----------- 1turret_jack_elites03 ----------vvvvvvvV

(script dormant 1turret_jack_elites03

	(sleep_until (<= (ai_living_count 1turret_end_i) 2))
	
	(if 1turret_jack_elites (sleep_forever))
	(set 1turret_jack_elites true)

	(ai_place 1turret_jack_elites01)

	;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_jack_elites01) 0)) 1turret_jack_wraith01 "wraith-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_jack_elites01) 1)) 1turret_jack_wraith02 "wraith-driver")
	
	(ai_set_orders 1turret_jack_elites01 1turret_jack_elites_attack)
	
	(wake allied_reinforcements);wake

)

(script dormant 1turret_jack_elites02

	(sleep_until (volume_test_objects 1turret_jack_activate03 (players)))
	
	(if 1turret_jack_elites (sleep_forever))
	(set 1turret_jack_elites true)
	
	(ai_place 1turret_jack_elites01)

	;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_jack_elites01) 0)) 1turret_jack_wraith01 "wraith-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_jack_elites01) 1)) 1turret_jack_wraith02 "wraith-driver")
	
	(ai_set_orders 1turret_jack_elites01 1turret_jack_elites_attack)
	
	(wake allied_reinforcements);wake

)

(script dormant 1turret_jack_elites01

	(sleep_until (volume_test_objects 1turret_jack (players)))
	
	(if 1turret_jack_elites (sleep_forever))
	(set 1turret_jack_elites true)
	
	(ai_place 1turret_jack_elites01)
	
	(ai_set_orders 1turret_jack_elites01 1turret_jack_elites_intro)
	
	(sleep_until 
		(or
			(volume_test_objects 1turret_jack_activate01 (players))
			(volume_test_objects 1turret_jack_activate02 (players))
			(volume_test_objects 1turret_jack_activate03 (players))
		)
	)

	
	
	(ai_set_orders 1turret_jack_elites01 1turret_jack_elites_attack)
	
	(wake allied_reinforcements);wake
)





	;Vvvvvvvvv------------ 1turret_middle -------------vvvvvvvvV
	
	
	


(script command_script cs_1turret_i_r
	
	(print "guys walk off cliff")
	
	(cs_move_in_direction 373 7 0)
)	


(script dormant 1turret_middle

	(print "1turret_middle_setup")

	(sleep_until 
		(or
			(volume_test_objects 1turret_middle (players))
			(<= (ai_living_count 1turret_intro_v) 2)
		)
	)
	
	(print "1turret_middle_running")
	(game_save_no_timeout)
	
	(ai_set_orders 1turret_begining_guys 1turret_1stguys_fallback)
	
	;(garbage_collect_unsafe)
	
	; only place if we aren't using the AI version
	(if (not use_dig_phantom_shootdown) (object_create 1turret_dropship01))
	;(object_create 1turret_wraith03)
	
	(ai_place 1turret_tankelites02)

	(ai_set_orders 1turret_tankelites02 1turret_intro_t)
	
	(ai_place 1turret_ghostelites02)
	
	(ai_set_orders 1turret_ghostelites02 1turret_intro_g)
	
	(ai_place 1turret_turret_elites01)
	(ai_set_orders 1turret_turret_elites01 1turret_i_attack)
	
	;v---------1turretgrunts---------v
	
	(ai_place 1turret_end_grunts01)
	
	(ai_set_orders 1turret_end_grunts01 1turret_attack)

	;v---------1turret jackable wraiths---------v	

	;(object_create 1turret_jack_wraith01)
	(object_create 1turret_jack_wraith02)
	
	(wake 1turret_jack_elites03);wake
	(wake 1turret_jack_elites02);wake
	(wake 1turret_jack_elites01);wake
	
	(sleep_until (<= (ai_living_count 1turret_end_i) 3))
	
	(ai_place 1turret_i_r)

	(cs_run_command_script 1turret_i_r cs_1turret_i_r)

)

	

	;vvvvv-------IIII  1turret interior  IIII-----------vvvv
	
(script dormant 1turret_sniper

	(sleep_until (volume_test_objects 1turret_sniper_post (players)))

		(ai_place 1turret_sniper_post)
)	
	
	
(script dormant 1turret_interior_r

	(sleep_until
		(or
			(volume_test_objects 1turret_interior_r (players))
			(<= (ai_living_count 1turret_interior_back) 3)
		)
	)
	
	(game_save_no_timeout)
	
	(ai_place 1turret_interior_r)
)	

	

(script dormant 1turret_interior_back
	
	(sleep_until 
		(or
			(volume_test_objects 1turret_interior_low_ent (players))
			(volume_test_objects 1turret_interior_center_ent (players))
		)
	)
	
	(if G_1turret_interior_back (sleep 32000))
	(set G_1turret_interior_back true)
	
	(ai_place 1turret_interior_back)
	
	(ai_set_orders 1turret_interior_low 1turret_interior_back_attack)
	
	(wake 1turret_interior_r);wake

)

(script dormant 1turret_interior_back_rear
	
	(sleep_until (volume_test_objects 1turret_interior_rear_ent (players)))
	
	(if G_1turret_interior_back (sleep_forever))
	(set G_1turret_interior_back true)
	
	(ai_place 1turret_interior_back)
	
	(ai_set_orders 1turret_interior_low 1turret_interior_back_attack)
	
	(wake 1turret_sniper);wake

)

	;vvvvvvvv------ 1turret interior low ------------vvvvvvvvv

(script dormant 1turret_interior_low
	
	(sleep_until (volume_test_objects 1turret_interior_low_ent (players)))
	
	(if G_1turret_interior (sleep_forever))
	(set G_1turret_interior true)
	
	(wake 1turret_sniper);wake
	
	(ai_place 1turret_interior_low)
	
	(ai_set_orders 1turret_interior_low 1turret_interior_low_attack)
	
	(ai_place 1turret_interior_low_g)
	
	(ai_set_orders 1turret_interior_low_g 1turret_interior_low_retreat)
	
	(sleep_until (volume_test_objects 1turret_interior_save (players)))
	
	(game_save_immediate);SSSAAAVVVEEE---
)

(script dormant 1turret_interior_center
	
	(sleep_until (volume_test_objects 1turret_interior_center_ent (players)))
	
	(if G_1turret_interior (sleep_forever))
	(set G_1turret_interior true)
	
	(wake 1turret_sniper);wake
	
	(ai_place 1turret_interior_low)
	
	(ai_set_orders 1turret_interior_low 1turret_interior_cntr_attack)
	
	(ai_place 1turret_interior_low_g)
	
	(ai_set_orders 1turret_interior_low_g 1turret_interior_cntr_retreat)
	
	(sleep_until (volume_test_objects 1turret_interior_save (players)))
	
	(game_save_immediate);SSSAAAVVVEEE---

)
	;v---------1turret wraiths behind---------v
	
(script dormant 1turret_wraiths_behind

	(sleep_until 
		(and
			(<= (ai_living_count view_tankelites01) 0)
			(volume_test_objects 1turret_intro (players))
		)
	)
	
		;(object_create 1turret_wraith_behind01)
		;(object_create 1turret_wraith_behind02)
		
		;(ai_place 1turret_wraith_behind)
		
		;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_wraith_behind) 0)) 1turret_wraith_behind01 "wraith-driver")
		;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_wraith_behind) 1)) 1turret_wraith_behind02 "wraith-driver")		
)

; check if we should fly away and if so do it
(script static void hdropship01_cleanup_check
	(print "hdropship01_cleanup_check")
	(if (or should_cleanup_hdropship01 (cs_dropship_turret_dead))
		(begin
			(print "cs_1turret_hdropship01: cleaning up")
			(cs_fly_to 1turret_hdropship01/flyaway1 3)
			(cs_fly_by 1turret_hdropship01/flyaway2 3)
			(cs_fly_to 1turret_hdropship01/flyaway3)
			(cs_fly_to 1turret_hdropship01/p_erase)
			(print "cs_1turret_hdropship01: deleting ourselves")
			(cs_erase_squad) ; die die die!
			(print "what good is a command script without an AI?")
			(sleep_forever)
		)
	)
)

; loop we can run multiple times
(script static void cs_1guntower_hdropship01_loop
	(print "cs_1turret_hdropship01 loop start")
	
	(cs_vehicle_speed 1)
	
	; cleanup checks are put in spots in the loop where breaking out would be possible
	; e.g. won't hit anything in the way

	(cs_fly_to_and_face 1turret_hdropship01/p0 1turret_hdropship01/p1 4)
	(hdropship01_cleanup_check)
	(cs_fly_to_and_face 1turret_hdropship01/p1 1turret_hdropship01/p2 4)
	(cs_fly_to 1turret_hdropship01/p2 4)
	(cs_fly_to_and_face 1turret_hdropship01/p3 1turret_hdropship01/p5 4)
	(cs_fly_by 1turret_hdropship01/p4 4)
	(cs_fly_by 1turret_hdropship01/p5 4)
	(hdropship01_cleanup_check)
	(cs_fly_by 1turret_hdropship01/p6 4)
	(hdropship01_cleanup_check)
	(cs_fly_by 1turret_hdropship01/p7 4)
	(hdropship01_cleanup_check)
	(cs_fly_by 1turret_hdropship01/p8 4)
	(hdropship01_cleanup_check)
	(cs_fly_to_and_face 1turret_hdropship01/p9 1turret_hdropship01/p0 4)
	(hdropship01_cleanup_check)
	(cs_pause 1)
)

(script command_script cs_1guntower_hdropship01
	(sleep_until (begin (cs_1guntower_hdropship01_loop) false)) ; loop forever
	(print "unreachable")
)

(script static void 1guntower_hdropship01_reset
	(ai_erase 1turret_hdropship01)
	(sleep 10)
	(ai_place 1turret_hdropship01)
	(cs_run_command_script 1turret_hdropship01 cs_1guntower_hdropship01)
)

(script dormant 1turret_hbanshee
	
	(sleep_until (<= (ai_living_count view_hbanshees) 0))
	
	(if G_1turret_hbanshee (sleep_forever))
	(set G_1turret_hbanshee true)
	
	(ai_place 1turret_hbanshee)	
)

(script dormant 1turret_hbanshee_alt
	
	(sleep_until (volume_test_objects 1turret_turret_wake (players)))
	
	(if G_1turret_hbanshee (sleep_forever))
	(set G_1turret_hbanshee true)
	
	;(wake runandgun02_2banshees);wake
)

(script command_script cs_1turret_ghostelites01s2

	(cs_go_to 1turret_ghostelites01s2/p0 1)
	(cs_go_to 1turret_ghostelites01s2/p1 )
)


(script command_script cs_1turret_ghostelites01s1

	(cs_go_to 1turret_ghostelites01s1/p0 1)
	(cs_go_to 1turret_ghostelites01s1/p1 1)
	(cs_go_to 1turret_ghostelites01s1/p2 )
)

;v---------1turret intro---------v

(script dormant 1turret_intro

	(sleep_until (volume_test_objects view_dialog (players)))
	
	; PLACE these earlier so they don't pop into view
	(ai_place 1turret_turretgrunts01)
	(ai_place 1turret_ghostelites01)
	
	(ai_set_orders 1turret_turretgrunts01 at_ease)
	(ai_set_orders 1turret_ghostelites01 at_ease)
	
	(sleep_until (volume_test_objects 1turret_intro (players)))
	
	(print "tyson EYES!!!")
	(game_save_immediate);SSSAAAVVVEEE---
	(wake 1turret_wraiths_behind)

;v---------1turret intro grunt turrets---------v

	
	(ai_set_orders 1turret_turretgrunts01 1turret_attack)

	;v---------1turret intro tanks---------v

	;(object_create 1turret_wraith01)
	;(object_create 1turret_wraith02)
	;(object_create 1turret_wraith04)
	
	;(ai_place 1turret_tankelites01)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_tankelites01) 0)) 1turret_wraith01 "wraith-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_tankelites01) 1)) 1turret_wraith02 "wraith-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors 1turret_tankelites01) 2)) 1turret_wraith04 "wraith-driver")
	
	;(ai_set_orders 1turret_tankelites01 1turret_intro_t)
	
	;----=====1turret intro shadows=========------V
	
	;(ai_place 1turret_shadows01)
	
	;(ai_set_orders 1turret_shadows01 1turret_intro_t)

	;v---------1turret intro ghosts---------v
	
	
	(cs_run_command_script 1turret_ghostelites01/s1 cs_1turret_ghostelites01s1)
	(cs_run_command_script 1turret_ghostelites01/s2 cs_1turret_ghostelites01s2)


	(ai_set_orders 1turret_ghostelites01 1turret_intro_g)
	
	(wake 1turret_middle);wake
	
	(wake 1turret_interior_back);wake
	(wake 1turret_interior_back_rear);wake
	
	(wake 1turret_interior_low) ;wake
	(wake 1turret_interior_center) ;wake
	
	(wake 1turret_hbanshee);wake
	(wake 1turret_hbanshee_alt);wake
	
	(if restore_1guntower_hdropship01 (1guntower_hdropship01_reset))
)

	;vvvvvvvvvvvv---------------  1turret_fire   --------------vvvv


(script dormant 1turret_dialog_onfoot

	(sleep_until (volume_test_objects 1turret_interior_rear_ent (players))15)

	(if G_1turret_turret_dialog (sleep_forever))
	(set G_1turret_turret_dialog true)
	
	(print "--- Allies: You�ve found the turret's weakness!!")
	
	(if (< nav 5) (set nav 5))	(wake navpoints)
	
	(sleep 55)

	(print "--- Allies: Assualting that turret with the vehicles would have been disaterous")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0550_el2" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0550_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0550_el2") subtitle_time) subtitle_time_add))

)

(script dormant 1turret_dialog_vehicles

	(sleep_until (volume_test_objects 1turret_turret_wake (players))15)
	
	(if G_1turret_turret_dialog (sleep_forever))
	(set G_1turret_turret_dialog true)
	
	(print "--- Allies: that turret is too powerful!!")
	
	(wake hud_obj_flank) 
	; OLD (wake navpoint_3)
	(if (< nav 6) (set nav 6))	(wake navpoints)
	
	(wake objective2_set)
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0520_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0520_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0520_el1") subtitle_time) subtitle_time_add))
	
	(sleep 45)
	
	(print "--- Allies: pull back and see if theres another way to destroy it!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0530_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0530_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0530_el1") subtitle_time) subtitle_time_add))

)

(script command_script cs_1guntower_fire
	(print "cs_guntower_free_fire")
	;(cs_make_immortal) ; immortality!! what an idea!
	(cs_enable_targeting 1)
	(cs_shoot 1)
	; neat hack from the game scripts themselves
	; you can implement a loop using sleep_until
	; try it sometimes
	(sleep_until
		(begin
			(if (volume_test_objects_all dig_1guntower_manual_fire (players))
				(cs_aim_player 1); aim directly at the players and fire
				(cs_aim_player 0); fire at will (standard AI)
			)
			(cs_is_my_mount_dead) ; basically loop forever until the vehicle is destroyed
		)
		1
	)
	
	(sound_impulse_start "digsite\sound\dialog\alphamoon\level\l05_0540_el1" none 1)
	(cinematic_subtitle l05_0540_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0540_el1") subtitle_time) subtitle_time_add))
	
	(set music_trojan_progress 1)	(wake music_remnant)
	
	(unbreak_guntower)
	
	;(cs_erase_actor) ; die die die!
)

(script dormant 1turret_turret_wake
	(object_create_anew 1guntower)
	(ai_attach 1guntower 1_guntower)
	
	(wake plant_gt_3_bomb)

	(sleep_until 
		(or
			(volume_test_objects 1turret_turret_wake (players))
			(volume_test_objects 1turret_interior_rear_ent (players))
		)
	15)

	(cs_run_command_script 1_guntower/center cs_1guntower_fire)
)

; nums test script
(script static void 1turret_test
	(object_create_anew 1guntower)
	(ai_attach 1guntower 1_guntower)
	(wake plant_gt_3_bomb)
	(cs_run_command_script 1_guntower/center cs_1guntower_fire)
)

(script dormant a_1turret_reinforce
	
	(sleep_until (volume_test_objects 1turret_intro (players))15)

	(ai_place a_1turret_ghosts)
	(ai_place a_1turret_wraiths)
	
)

(script dormant a_1turret_v_moveup

	(sleep_until (volume_test_objects a_1turret_v_attack_b (players))15)
	
	(if G_a_1turret_v_attack_b (sleep_forever))
	(set G_a_1turret_v_attack_b true)
	
	(ai_set_orders a_1turret_wraiths a_1turret_v_mid_adv)
	(ai_set_orders a_1turret_ghosts a_1turret_v_mid_adv)
	
	(if 
		(> (unit_get_health 1guntower)0)  
		(begin
			(sleep 150)
			(ai_set_orders a_1turret_wraiths a_1turret_w_fback)
			(ai_set_orders a_1turret_ghosts a_1turret_g_back)
		)
		
		(begin
			(sleep 120)
			(ai_set_orders a_1turret_ghosts a_1turret_g_front)
		)
	)
)

(script dormant a_1turret_v_moveup_alt

	(sleep_until (volume_test_objects 1turret_interior_low_retreat (players))15)
	
	(if G_a_1turret_v_attack_b (sleep_forever))
	(set G_a_1turret_v_attack_b true)

	(sleep_until (<= (unit_get_health 1guntower)0))

	(ai_set_orders a_1turret_ghosts a_1turret_g_front)
	(ai_set_orders a_1turret_wraiths a_1turret_w_fback)
)




;vvvvv-----clean up 01------------------------------vvvvv

(script dormant clean_up01

	(object_destroy_containing "runandgun01_interior_debris")
)

;vvvvvvvvvvvv------------------  VIEW!!!   ---------------------------------------------------vvvvvv
;vvvvvvvvvvvv------------------  VIEW!!!   ---------------------------------------------------vvvvvv
;vvvvvvvvvvvv------------------  VIEW!!!   ---------------------------------------------------vvvvvv

(script dormant view_dialog

	(sleep_until (volume_test_objects view_dialog (players)))
	
	(print "05_048_elite1 --- Allies: whoa!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0480_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0480_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0480_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0480_el1"))
	
	(print "<chance of playing a sexy music oneshot>")
	(sound_impulse_start digsite\sound\music\am\mirage\loops_atmosphere none 1)
	
	(print "05_049_elite1 --- Allies: That wreckages is huge!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0490_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0490_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0490_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0490_el1"))
	
	(print "05_050_elite1 --- Allies: This moon has been devistated")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0500_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0500_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0500_el1") subtitle_time) subtitle_time_add))
	(sleep (+ 45 (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0500_el1")))
	
	(print "<chance of playing a sexy music oneshot>")
	(sound_impulse_start digsite\sound\music\am\mirage\loops_dive none 1)
	
	(print "05_051_soc --- C.O.: That giant piece of wreackage must be where their stonghold is!!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0510_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0510_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0510_soc") subtitle_time) subtitle_time_add))
)

	;view-dropships----------------vvv---------------------------

(script command_script cs_view_hdropship_near
	(cs_enable_moving 0) ; lock to script
	(cs_fly_to_and_face view_hdropship_near/p0 view_hdropship_near/p3)
	(cs_fly_to_and_face view_hdropship_near/p1 view_hdropship_near/p3)
	(cs_fly_to_and_face view_hdropship_near/p2 view_hdropship_near/p3)
	; wait till the player goes past the spot it's waiting at, then fly to the next location
	(sleep_until (or (cs_dropship_turret_dead) (volume_test_objects_all a_view_g_back (players))))
	(cs_fly_to_and_face view_hdropship_near/follow1 view_hdropship_near/follow2)
	; wait till they leave the volume (or kill our gun)
	(sleep_until (or (cs_dropship_turret_dead) (not (volume_test_objects_all a_view_g_back (players)))))
	(cs_fly_to view_hdropship_near/follow2 4)
	(if (not (cs_dropship_turret_dead) ) (cs_pause 15)) ; wait?
	; fly away
	(cs_fly_by view_hdropship_near/fly_away1 5)
	(cs_fly_by view_hdropship_near/fly_away2 5)
	(cs_fly_to view_hdropship_near/p_erase)
	(cs_erase_squad) ; disappear
)


(script static void view_hdropship_near
	
	(ai_erase view_hdropship_near)
	
	(sleep 10)
	
	(ai_place view_hdropship_near)
	
	(cs_run_command_script view_hdropship_near cs_view_hdropship_near)
)


(script command_script cs_view_hdropship_far

	(cs_fly_by view_hdropship_far/p0)
	(cs_fly_by view_hdropship_far/p1)
	(cs_fly_by view_hdropship_far/p2)
	(cs_fly_to_and_face view_hdropship_far/p3 view_hdropship_far/p4)
	(cs_fly_to view_hdropship_far/p4)
	(cs_fly_to_and_face view_hdropship_far/p4 view_hdropship_far/p5)
	; addition by digsite -num0005
	(cs_fly_by view_hdropship_far/p5 5)
	(cs_fly_to view_hdropship_far/p6)
	
	(wake music_remnant)
	
	; wait for the players to leave
	; or for them to destroy our turret
	(sleep_until (or (cs_dropship_turret_dead) (< 40 (objects_distance_to_object (players) (cs_get_object)))))
	(cs_fly_by view_hdropship_far/fly_away1 10)
	(cs_fly_to view_hdropship_far/fly_away2 4)
	(cs_pause 5)
	(cs_fly_to view_hdropship_far/fly_away3 4)
	(cs_fly_to view_hdropship_far/p_erase 2)
	(sleep 30)
	(sleep_until (not (cs_moving)))
	(cs_erase_squad)
)

(script static void view_hdropship_far
	
	(ai_erase view_hdropship_far)
	
	(sleep 10)
	
	(ai_place view_hdropship_far)
	
	(cs_run_command_script view_hdropship_far cs_view_hdropship_far)
)

(script dormant view_shadow01
	
	;-(sleep_until (volume_test_objects view (players)))

	(ai_place view_shadow01)
	(ai_place view_shadow02)
)

(script dormant view

	(sleep_until (volume_test_objects view (players)))
	
	; dispose of AI from the previous sections
	(ai_disposable runandgun01 1)
	(ai_disposable 3turrets 1)
	(ai_disposable lz_dig_phantoms 1)
	
	(wake music_trojan)
		
	(wake view_shadow01);wake
	
	(wake view_dialog);wake
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	;(object_create_containing "1turret_debris")
	
	(object_create view_player_wraith01)
	
	;(object_create view_wraith02)
	
	(ai_place view_tankelites01)

	;(unit_enter_vehicle (unit (list_get (ai_actors view_tankelites01) 0)) view_wraith02 "wraith-driver")
	
	;(ai_set_orders view_tankelites01 view_wraith_intro)
	
	;vvvvvvvvvvvvv----------view ghost----------vvvvvvvvvvvvv
	
	(ai_place view_ghostelites01)
	
	(ai_set_orders view_ghostelites01 view_attack)
	
	(ai_place view_hbanshees)
	
	(wake 1turret_turret_wake);wake
	(wake clean_up01);wake
	
	(sleep 10)
	
	(view_hdropship_near);call
	(view_hdropship_far);call
	
	(wake 1turret_dialog_vehicles);wake
	(wake 1turret_dialog_onfoot);wake
	
	(sleep_until (volume_test_objects 1turret_attack (players)))
		
	(ai_set_orders view_v view_attack)
)


(script dormant view_i

	(sleep_until 
		(or
			(volume_test_objects runandgun01_ghostelites04 (players))
			(<= (ai_living_count runandgun01_ghostelites03) 1)
			(<= (ai_living_count runandgun01_t_grunts03) 1)
		)
	)
	
	(ai_place view_i_01)
	
	(ai_set_orders view_i_01 view_i_front)
	
	(sleep_until (volume_test_objects runandgun01_ghostelites04 (players)))
	
	(ai_set_orders view_i_01 view_i_back)
	
	(game_save_immediate);SSSAAAVVVEEE---
)

;vvvvvvvvvvvv---------------    RUNANDGUN01   ----------------------------------------------------VVVVVVVV
;vvvvvvvvvvvv---------------    RUNANDGUN01   ----------------------------------------------------VVVVVVVV
;vvvvvvvvvvvv---------------    RUNANDGUN01   ----------------------------------------------------VVVVVVVV

(script dormant runandgun01_filler
;ln3539
	(sleep_until
		(and
			(volume_test_objects runandgun01_filler (players))
			(<= (ai_living_count runandgun01_ghostelites) 0)
			(<= (ai_living_count runandgun01_ghostelites02) 1)
			(<= (ai_living_count runandgun01_i01) 1)
		)
	)		
	
		(ai_place runandgun01_filler)		
)

(script dormant runandgun01_turret01

	;(object_create runandgun01_turret01)
	
	(ai_place runandgun01_turretgrunt01)

	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_turretgrunt01) 0)) runandgun01_turret01 "gt_gunner")
	
	(ai_set_orders runandgun01_turretgrunt01 runandgun01_ghost_attack)
	
	;v--------------runandgun flee grunts----------v

	(ai_place runandgun01_fleegrunts01)
	
	(ai_set_orders runandgun01_fleegrunts01 runandgun01_flee_g_defense)
)	

(script dormant runandgun01_elites04

	(sleep 30)

	(sleep_until 
		(or
			(volume_test_objects runandgun01_ghostelites04 (players))
			(<= (ai_living_count runandgun01_ghostelites03) 0)
			(<= (ai_living_count runandgun01_t_grunts03) 0)
		)
	)
	
	(print "runandgun ghostelites04")
	
	;(object_create runandgun01_ghost07)
	;(object_create runandgun01_ghost08)
	
	(ai_place runandgun01_ghostelites04)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites04) 0)) runandgun01_ghost07 "G-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites04) 1)) runandgun01_ghost08 "G-driver")

	(ai_set_orders runandgun01_ghostelites04 runandgun01_g03_intro)
	
	;(object_create_containing "view_debris");creates debris for view area
	
	(sleep_until (volume_test_objects view_dialog (players)))
	
	(ai_set_orders runandgun01_ghostelites03 view_attack)
	
	(ai_set_orders runandgun01_ghostelites04 view_attack)
)

(script dormant runandgun01_t_grunts_02

	(sleep_until (volume_test_objects runandgun01_elites03 (players)))
	
	(ai_disposable trap01 true) ; we are past the trap now, allow it to be garbage collected
	
	(sleep 10)
	
	;(object_create runandgun01_t_grunt_t03)
	;(object_create runandgun01_t_grunt_t04)
	;(object_create runandgun01_t_grunt_t05)
	
	(ai_place runandgun01_t_grunts03)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_t_grunts03) 0)) runandgun01_t_grunt_t03 "gt_gunner")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_t_grunts03) 1)) runandgun01_t_grunt_t04 "gt_gunner")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_t_grunts03) 2)) runandgun01_t_grunt_t05 "gt_gunner")
	
	(ai_set_orders runandgun01_t_grunts03 runandgun01_ghost_attack)
	
	(wake runandgun01_elites04);wake
)

(script dormant  runandgun01_t_grunts_01

	;(object_create runandgun01_t_grunt_t01)
	;(object_create runandgun01_t_grunt_t02)
	
	(ai_place runandgun01_t_grunts02)

	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_t_grunts02) 0)) runandgun01_t_grunt_t01 "gt_gunner")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_t_grunts02) 1)) runandgun01_t_grunt_t02 "gt_gunner")
	
	(ai_set_orders runandgun01_t_grunts02 runandgun01_ghost_attack)
	
	(wake runandgun01_t_grunts_02);wake
)
	;v--v-v-v-v-v runandgun01 ghost elites03 --v-v-v-v-v-v---


(script dormant runandgun01_elites03
	
	(print "tyson eyes!!!")
	
	(garbage_collect_unsafe)
	
	(sleep_until 
		(or
			(volume_test_objects runandgun01_elites03 (players))
			(<= (ai_living_count runandgun01_ghostelites02) 0)
		)
	)

	;(object_create runandgun01_ghost05)
	;(object_create runandgun01_ghost06)
	
	(ai_place runandgun01_ghostelites03)
	
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites03) 0)) runandgun01_ghost05 "G-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites03) 1)) runandgun01_ghost06 "G-driver")

	(ai_set_orders runandgun01_ghostelites03 runandgun01_g03_intro)
	
	(wake runandgun01_turret01);wake
	;(wake ai_kill01);wake
	
	(sleep 10)
	
	(wake view_i);wake
)

	;:::::v:::::scripted runandgun01 allied dropship::::::::v:::::::::
	;:::::v:::::scripted runandgun01 allied dropship::::::::v:::::::::
	
(script dormant runandgun01_big_d_d

	(sleep 60)
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0460_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0460_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0460_el2") subtitle_time) subtitle_time_add))

	(sleep 90)
	
	;(object_destroy_containing "runandgun01_big_debris")
	
	;(effect_new "effects\test\stephen_explosion" runandgun01_bigd_exp01)
	;(effect_new "effects\test\stephen_explosion" runandgun01_bigd_exp02)
)

(script command_script cs_runandgun_part2_dropship01

	(cs_vehicle_speed 1)

	;(cs_fly_by runandgun01_part2_dropship01/p0 4)
	(cs_fly_to runandgun01_part2_dropship01/p0_1 4)
	(cs_fly_to runandgun01_part2_dropship01/p1 4)
	(cs_fly_to runandgun01_part2_dropship01/p2 4)
	(cs_fly_to_and_face runandgun01_part2_dropship01/p3 runandgun01_part2_dropship01/p4 4)
	
	(print "blow up wall")

	(wake runandgun01_big_d_d);wake
	(cs_vehicle_speed 0.4)
	(cs_fly_by runandgun01_part2_dropship01/p4 4)
	(cs_fly_by runandgun01_part2_dropship01/p5 4)
	(cs_fly_by runandgun01_part2_dropship01/p6 4)
	;(cs_fly_by runandgun01_part2_dropship01/p7 4)
	
	(object_destroy (ai_vehicle_get runandgun01_part2_dropship01/1))
)

(script static void dtest
	
	(ai_erase runandgun01_part2_dropship01)
	
	(sleep 10)
	
	(ai_place runandgun01_part2_dropship01)

	(cs_run_command_script runandgun01_part2_dropship01 cs_runandgun_part2_dropship01)
)

(script dormant runandgun01_part2

	(sleep_until 
		(or
			(volume_test_objects runandgun01_elites03 (players))
			(<= (ai_living_count runandgun01_ghostelites) 0)
		)
	)
	
	(game_save_no_timeout) ; dig save point
	
	;(object_destroy runandgun01_part2_dropship01)
	
	(ai_erase runandgun01_part2_dropship01)
	
	(sleep 10)
	
	;(object_create runandgun01_part2_dropship01)
	
	(ai_place runandgun01_part2_dropship01)

	;(vehicle_load_magic runandgun01_part2_dropship01 "p_driver" (ai_actors runandgun01_part2_dropship01))
	
	(cs_run_command_script runandgun01_part2_dropship01 cs_runandgun_part2_dropship01)
)

	;------------vv runandgun01 ghost elites vv--------------------

(script dormant runandgun01_elites02
	
	(sleep_until 
		(or
			(volume_test_objects runandgun01_elites02 (players))
			(<= (ai_living_count runandgun01_ghostelites) 0)
		)
	)
	
	(print "runandgun01_ghostelites02")
	
	;(object_create runandgun01_ghost03)
	;(object_create runandgun01_ghost04)
	
	(ai_place runandgun01_ghostelites02)

	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites02) 0)) runandgun01_ghost03 "G-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites02) 1)) runandgun01_ghost04 "G-driver")
	
	(ai_set_orders runandgun01_ghostelites02 runandgun01_g_attack_1st)
	
	(wake runandgun01_elites03);wake
	
	(wake runandgun01_part2);wake
	
	;(wake view);wake
	
)

(script dormant allies02

	(ai_set_orders allied_wraith01 allied_w_runandgun01)
	(ai_set_orders allied_ghost01_02 allied_g_runandgun01)

)

(script dormant allies_ghost_warning

	(sleep 90)
	
	(print "--- Allies: Watch out for those ghosts!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0440_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0440_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0440_el1") subtitle_time) subtitle_time_add))
	
	
	(sleep 45)
	
	(print "--- Allies: Enemy vehicls incoming!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0450_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0450_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0450_el1") subtitle_time) subtitle_time_add))
 
)


(script dormant runandgun01_ghostelites01

	(sleep_until (volume_test_objects runandgun01_ghostelites01 (players))15)
	
	(game_save_no_timeout) ; dig save point
	
	(wake allies_ghost_warning);wake
	
	(wake allies02);wake

	(print "runandgun01_ghostelites01")

	;(object_create runandgun01_ghost01)
	;(object_create runandgun01_ghost02)
	
	(ai_place runandgun01_ghostelites)

	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites) 0)) runandgun01_ghost01 "G-driver")
	;(unit_enter_vehicle (unit (list_get (ai_actors runandgun01_ghostelites) 1)) runandgun01_ghost02 "G-driver")

	(ai_set_orders runandgun01_ghostelites runandgun01_g_attack_1st)
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(wake runandgun01_elites02);wake
	
	(sleep 10)
	
	(wake runandgun01_t_grunts_01);wake
	
	(wake runandgun01_filler);wake3247
	
	
	
)

(script dormant runandgun01
	
	
	;(vehicle_load_magic runandgun01_ghost01 "g-driver" (ai_actors runandgun01_ghostelites))
	
	(print "runandgun_i")
	
	(ai_place runandgun01_i_elites01)
	(ai_place runandgun01_i_grunts01)
	
	(ai_set_orders runandgun01_i_elites01 runandgun01_i_attack01)
	(ai_set_orders runandgun01_i_grunts01 runandgun01_i_attack01)
	
	(ai_place runandgun01_i_elites02)
	(ai_place runandgun01_i_grunts02)
	
	(ai_set_orders runandgun01_i_elites02 runandgun01_i_attack02)
	(ai_set_orders runandgun01_i_grunts02 runandgun01_i_attack02)
			
	(wake runandgun01_ghostelites01);wake
	;(wake runandgun01_filler);wake
	
	(sleep_until (volume_test_objects runandgun01_interior (players))15)
	
	(ai_place runandgun01_interior)
	
	(ai_set_orders runandgun01_i_elites02 runandgun01_i_defend02)
	
	
	(sleep_until (<= (ai_living_count runandgun01_interior) 0))
	

	(ai_place runandgun01_interior02)
	
)

;vvvvvvvvvvv------TRAP01--------------------------------------------------------------vvvvvvvvvvvvv
;vvvvvvvvvvv------TRAP01--------------------------------------------------------------vvvvvvvvvvvvv
;vvvvvvvvvvv------TRAP01--------------------------------------------------------------vvvvvvvvvvvvv


	;vvvvv----- trap01 counter ---------vvvvvvv
	
(script dormant trap01_counter_dialog

	(sleep_until (volume_test_objects trap01_counter (players))15)

	(if G_trap01_dialog (sleep_forever))
	(set G_trap01_dialog true)

	(print "--- Allies: we're lucky you saw that trap")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0380_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0380_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0380_el1") subtitle_time) subtitle_time_add))
	
	(sleep 50)
	
	(print "--- Allies: we almost went into that trap")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0390_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0390_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0390_el2") subtitle_time) subtitle_time_add))
	
	(sleep 90)
	
	(print "--- C.O.: heretics are dishonorable and will use deception in combat")

	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0400_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0400_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0400_soc") subtitle_time) subtitle_time_add))

	(sleep 90)

	(print "--- C.O.: becareful of more traps")

	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0410_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0410_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0410_soc") subtitle_time) subtitle_time_add))
)

	;vvvvv------ trap01 spring------vvvvv

(script dormant trap01_spring_dialog

	(if G_trap01_dialog (sleep_forever))
	(set G_trap01_dialog true)
	
	(wake music_thunder)
	
	(print "--- Allies: A TRAP!!!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0350_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0350_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0350_el1") subtitle_time) subtitle_time_add))
	
	(sleep 30)
	
	(print "--- Allies: damn they are all around us!!!!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0360_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0360_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0360_el1") subtitle_time) subtitle_time_add))
	
	(sleep 39)
	
	(print "--- Allies: those sneeky bastards!!!")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0370_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0370_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0370_el1") subtitle_time) subtitle_time_add))
	
	(sleep 90)
	
	(print "--- C.O.: heretics are dishonorable and will use deception in combat")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0400_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0400_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0400_soc") subtitle_time) subtitle_time_add))

	(sleep 90)

	(print "--- C.O.: becareful of more traps")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0410_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0410_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0410_soc") subtitle_time) subtitle_time_add))
)

(script command_script cs_trap01_r
	
	(object_cannot_take_damage (ai_actors trap01_r))
	
	(cs_move_in_direction 0 8 0)
	
	(sleep 20)
	
	(object_can_take_damage (ai_actors trap01_r))
	
	(print "guys walk off cliff")
)	

(script static void testrr
	
	(ai_erase trap01_r)
	
	(sleep 10)


	(ai_place trap01_r)
	
	(cs_run_command_script trap01_r cs_trap01_r)

)


(script dormant trap01_r

	(print "trap01_r_wake")
	
	(sleep_until 
		(and
			(volume_test_objects trap01_center_retreat (players))
			(<= (ai_living_count trap01_grunts) 0)
		)
	)
		
	(ai_place trap01_r)
	
	(cs_run_command_script trap01_r cs_trap01_r)

)

(script command_script cs_trap01_low
	
	(cs_move_in_direction 127 3 0)
	
	(sleep 20)
	
	(print "guys walk off cliff")
)


(script dormant trap01_low
	
	(ai_place trap01_low)
	
	(object_cannot_take_damage (ai_actors trap01_low))
	
	(sleep 6)
	
	(object_can_take_damage (ai_actors trap01_low))
	
	(sleep_until (volume_test_objects runandgun01_ghostelites01 (players)))
	
	(cs_run_command_script trap01_low cs_trap01_low)
	
	(ai_set_orders trap01_low trap01_retreat_grunts)

)

(script dormant trap01_bait
	 
	(sleep_until (volume_test_objects trap01_bait (players))15)
	
	(ai_place trap01_bait)
	(ai_disposable lz_dig_phantoms 1)
	(ai_disposable 3turrets 1)
	(ai_disposable intro_intro 1)
	
	(wake chapter_kickoff)
)

(script dormant trap01

	(wake trap01_bait);wake
	
	(sleep_until (volume_test_objects runandgun01 (players))15)
	(print "trap01 triggered")
	
	(ai_disposable 3turrets 1)
	(garbage_collect_unsafe)
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(wake trap01_counter_dialog);wake
	
	(wake runandgun01);wake
	
	(ai_place trap01_grunts)
	(ai_set_orders trap01_grunts trap01_intro_grunts)
	(ai_place trap01_grunts02)
	
	(sleep 10)
	
	(ai_place trap01_turret_grunts)
	
	(ai_set_orders trap01_turret_grunts trap01_intro_grunts)
	
	(wake trap01_r);wake
	
	(sleep_until (volume_test_objects trap01_spring (players))15)
	
	(object_create_containing "trap01_block")
	
	(object_create_containing "trap01_havok")
	
	(wake trap01_low);wake
	
	(object_destroy trap01_edebris01)
	(object_destroy trap01_edebris02)
	(object_destroy trap01_edebris03)
	(object_destroy trap01_edebris04)
	(object_destroy trap01_edebris05)
	
	(wake trap01_spring_dialog);wake
	
	(ai_set_orders trap01_grunts trap01_attack_grunts)
	
	;(sleep_until (<= (ai_living_count trap01_grunts) 4))
	
	;(object_destroy trap01_block01)

	;(object_destroy trap01_block02)
	
	;(object_destroy trap01_block06)
	
	;(object_create_containing "runandgun01_b_debris")
	
	(sleep 10)
	
	(object_create_containing "runandgun01_interior_debris")
	
	(sleep 30)
	
	(object_create_containing "runandgun01_big_debris")
	
)

(script dormant pretrap_debris_destroy

		(sleep_until (volume_test_objects pretrap_debris_destroy (players))15)

		(object_destroy_containing "pretrap_debris")
)

;vvvvvvvvvvv------allied vehicles----------vvvvvvvvvvvvv

(script dormant dig_allied_teleport_hack
	; works around the currently unfixed pathfinding bug after the first 3 turrets
	(sleep_until (volume_test_objects pretrap_debris_destroy (players))15)
	; teleport our allies one by one
	(object_teleport (ai_vehicle_get allied_ghost01_02/a) dig_ai_teleport_bsp1_hack)
	(sleep 30)
	(object_teleport (ai_vehicle_get allied_ghost01_02/b) dig_ai_teleport_bsp1_hack)
	(sleep 50)
	; no can do
	(object_teleport (ai_vehicle_get allied_wraith01/wraith) dig_ai_teleport_bsp1_hack)
)

(script dormant dig_allied_clear_path_hack
	; make sure the allies don't get stuck on pathfinding
	(sleep_until (volume_test_objects pretrap_debris_destroy (players))15)
	
	(object_destroy_containing "blocked_lz_exit_")
)

(script dormant save01
	
	(print "save01")
	(sleep_until (<= (ai_living_count turret_left_elites) 0))
	(game_save_immediate)

)

(script command_script cs_lz01_a_dropship04

	(cs_vehicle_speed 1)

	(cs_fly_to lz01_a_dropship04/p0 3)
	(cs_fly_to lz01_a_dropship04/p1 3)
	(cs_fly_to lz01_a_dropship04/p2 3)
	
	(cs_pause 40)
	(cs_fly_to lz01_a_dropship_leave/flyaway0_right 4)
	(cs_fly_to lz01_a_dropship_leave/flyaway1_right 4)
	(cs_fly_to lz01_a_dropship_leave/flyaway2_right 4)
	(cs_erase_squad)
)

(script static void dtest04

	(ai_erase lz01_a_dropship04)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship04)
	
	(cs_run_command_script lz01_a_dropship04 cs_lz01_a_dropship04)
)

(script dormant lz01_a_dropship04

	(sleep 60)
	
	(ai_erase lz01_a_dropship04)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship04)
	
	(cs_run_command_script lz01_a_dropship04 cs_lz01_a_dropship04)
)

	;v======--- allied dropship 03 ---======v
	
(script dormant lz01_a_dropship03_cnts

	(sleep 60)
	
	;(ai_place allied_wraith01)
	
	(vehicle_unload (ai_vehicle_get lz01_a_dropship03/starting_locations_0) "phantom_lc")
	
	(print "0290_el2 - allies - my weapons are ready, what are my orders?")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0290_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0290_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0290_el2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0290_el2"))

	(hud_help_2) 
	; OLD (wake navpoint_1) 
	(if (< nav 3) (set nav 3))	(wake navpoints)
	
	(wake objective1_set)
	(set music_wraith_1 true)
)

(script command_script cs_lz01_a_dropship03

	(ai_place allied_wraith01)
	(ai_cannot_die allied_wraith01 1) ; make immortal for transport
	(objects_attach (cs_vehicle_get) "large_cargo" (ai_vehicle_get_from_starting_location allied_wraith01/wraith) "")

	(cs_vehicle_speed 1)

	(cs_fly_to_and_face lz01_a_dropship03/p0 lz01_a_dropship03/p4 3)
	(cs_fly_to_and_face lz01_a_dropship03/p1 lz01_a_dropship03/p4 3)
	(cs_fly_to_and_face lz01_a_dropship03/p2 lz01_a_dropship03/p4 3)
	(cs_fly_to_and_face lz01_a_dropship03/p3 lz01_a_dropship03/p4 1)
	
	(objects_detach (cs_vehicle_get) (object_at_marker (cs_vehicle_get) "large_cargo"))
	
	(wake lz01_a_dropship03_cnts);wake
	(sleep 600)
	(ai_cannot_die allied_wraith01 0)
	(ai_force_active allied_wraith01 1)
	(cs_pause 30)
	
	(cs_fly_to lz01_a_dropship_leave/flyaway0_left 4)
	(cs_fly_to lz01_a_dropship_leave/flyaway1_left 4)
	(cs_erase_squad)
)

(script static void dtest03

	
	(ai_erase lz01_a_dropship03)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship03)
	
	(cs_run_command_script lz01_a_dropship03 cs_lz01_a_dropship03)
)


(script dormant lz01_a_dropship03

	(sleep 150)
	
	(ai_erase lz01_a_dropship03)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship03)
	
	(cs_run_command_script lz01_a_dropship03 cs_lz01_a_dropship03)
)
	;v======--- allied dropship 02 ---======v
	

(script command_script cs_lz01_a_dropship02
	(ai_place allied_ghost01_02)
	(objects_attach (cs_vehicle_get) "small_cargo01" (ai_vehicle_get_from_starting_location allied_ghost01_02/a) "")
	(objects_attach (cs_vehicle_get) "small_cargo02" (ai_vehicle_get_from_starting_location allied_ghost01_02/b) "")
	(ai_cannot_die allied_ghost01_02 1)

	(cs_vehicle_speed 1)

	(cs_fly_to_and_face lz01_a_dropship02/p0 lz01_a_dropship02/p4 3)
	(cs_fly_to_and_face lz01_a_dropship02/p1 lz01_a_dropship02/p4 3)
	(cs_fly_to_and_face lz01_a_dropship02/p2 lz01_a_dropship02/p4 3)
	(cs_fly_to_and_face lz01_a_dropship02/p3 lz01_a_dropship02/p4 1)
	
	; drop down the ghosts
	(objects_detach (cs_vehicle_get) (object_at_marker (cs_vehicle_get) "small_cargo01"))
	(objects_detach (cs_vehicle_get) (object_at_marker (cs_vehicle_get) "small_cargo02"))
	
	; set their orders
	(ai_set_orders allied_wraith01 allied_w_runandgun01)
	
	;(wake lz01_a_dropship02_cnts);wake
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0290_el2"))
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0260_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0260_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0260_el1") subtitle_time) subtitle_time_add))
	
	(print "0270_el2 - allies - he is the arbiter, whad'ya expect?")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0270_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0270_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0270_el2") subtitle_time) subtitle_time_add))
		
	(set music_wraith_1 true)
	(sleep 600)
	(ai_cannot_die allied_ghost01_02 0)
	(ai_force_active allied_ghost01_02 1)
	
	(cs_pause 70)
	(cs_fly_to lz01_a_dropship_leave/flyaway0_left 4)
	(cs_fly_to lz01_a_dropship_leave/flyaway1_left 4)
	(cs_erase_squad)
)

(script static void dtest02_2
	(sleep 60)
	
	(ai_erase lz01_a_dropship02)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship02)
	
	(cs_run_command_script lz01_a_dropship02/driver cs_lz01_a_dropship02)
	
	(set music_wraith_1 true)
)

(script dormant lz01_a_dropship02

	(sleep 60)
	
	(ai_erase lz01_a_dropship02)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship02)

	(cs_run_command_script lz01_a_dropship02/driver cs_lz01_a_dropship02)
	
	(set music_wraith_1 true)
)

	;v======--- allied dropship 01 ---======v
	
(script dormant lz01_a_dropship01_cnts
	
	(sleep 5)
	
	;(object_create player_wraith01)
	
	(sleep 90)
	
	(sleep 120)
	
	(object_create_containing "lz_allied_storage")
)

(script command_script cs_lz01_a_dropship01
	(hud_allies) (wake objective0_clear)
	
	(if (< nav 2) (set nav 2))	(wake navpoints)

	(print "lz01_a_dropship02")
	(object_create player_wraith01)
	(objects_attach (cs_vehicle_get) "large_cargo" player_wraith01 "")

	(cs_vehicle_speed 1)

	(cs_fly_to_and_face lz01_a_dropship01/p0 lz01_a_dropship01/p4 3)
	(cs_fly_to_and_face lz01_a_dropship01/p1 lz01_a_dropship01/p4 3)
	(cs_fly_to_and_face lz01_a_dropship01/p2 lz01_a_dropship01/p4 3)
	(cs_fly_to_and_face lz01_a_dropship01/p3 lz01_a_dropship01/p4 1)
	
	(print "cs_lz01_a_dropship01: dropping objects!")
	
	(objects_detach (cs_vehicle_get) (object_at_marker (cs_vehicle_get) "large_cargo"))
	
	;What is that "storage" even for??
	;(wake lz01_a_dropship01_cnts);wake
	
	(ai_vehicle_exit ai_current_squad phantom_p)
	
	(cs_pause 100)
	(cs_fly_to lz01_a_dropship_leave/flyaway0_right 4)
	(cs_fly_to lz01_a_dropship_leave/flyaway1_right 4)
	(cs_fly_to lz01_a_dropship_leave/flyaway2_right 4)
	(cs_erase_squad)
)

(script static void dtest02
	
	(ai_erase lz01_a_dropship01)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship01)
	(ai_place_in_vehicle lz01_allied_grunts01 lz01_a_dropship01)
	
	(cs_run_command_script lz01_a_dropship01/driver cs_lz01_a_dropship01)
)


(script dormant lz01_a_dropship01
	
	(ai_erase lz01_a_dropship01)
	
	(sleep 10)
	
	(ai_place lz01_a_dropship01)
	
	(ai_place_in_vehicle lz01_allied_grunts01 lz01_a_dropship01)
	
	(cs_run_command_script lz01_a_dropship01/driver cs_lz01_a_dropship01)
)

(global short a_wraith01_living_left 0)
(global short a_ghost01_02_living_left 0)

(script dormant allied_orders01

	(sleep_until (volume_test_objects allies_moveto_runandgun01 (players))15)
	
	(ai_set_orders allied_wraith01 a_runandgun01_w_front)
	(ai_set_orders allied_ghost01_02 a_runandgun01_g_front)
	
	(sleep_until (volume_test_objects runandgun01_elites03 (players))15)
	
	(ai_set_orders allied_wraith01 a_runandgun01_w_back)
	(ai_set_orders allied_ghost01_02 a_runandgun01_g_front)
	
	
	; HACK: fake the AI transition to BSP2 if some of them get stuck and can't be moved normally
	
	(sleep_until (volume_test_objects "bsp_1,0" (players)) 1)
	; save active count just before the transition
	(set a_wraith01_living_left (ai_living_count allied_wraith01))
	(set a_ghost01_02_living_left (ai_living_count allied_ghost01_02))
	
	;;; COULDNT FIX THIS IN TIME FOR RELEASE
	; move over to new squad
	;(ai_migrate allied_wraith01 a_1turret_wraiths)
	;(ai_migrate allied_ghost01_02 a_1turret_ghosts)
	
	(print "allied_orders01: migrated to new squad")
	
	; wait till we get to the new BSP
	(sleep_until (= (structure_bsp_index) 1) 1)
	
	(sleep 2)
	
	(print "allied_orders01: teleporting to starting locations")

	;;; COULDNT FIX THIS IN TIME FOR RELEASE
	; DISCLAIMER: this is still broken (pathfinding is hard), so we will just place the allies
	; teleport our allies over if they are stuck on the old BSP
	;(ai_teleport_to_starting_location_if_outside_bsp a_1turret_wraiths)
	;(ai_teleport_to_starting_location_if_outside_bsp a_1turret_ghosts)
	
	(sleep 10)
	
	(print "allied_orders01: recreating any AI that disappeared on us")
	
	(ai_place a_1turret_wraiths (- a_wraith01_living_left (ai_living_count a_1turret_wraiths)))
	(ai_place a_1turret_ghosts (- a_ghost01_02_living_left (ai_living_count a_1turret_ghosts)))
	
	; reset their health back up
	;(ai_renew a_1turret_wraiths)
	;(ai_renew a_1turret_ghosts)
	
	(sleep_until (volume_test_objects a_view_g_back (players))15)
	
	(ai_set_orders a_1turret_ghosts a_1turret_g_back)
	(ai_set_orders a_1turret_wraiths a_1turret_w_fback)
)

(script static boolean are_0guntowers_defeated
	(and 
		(<= (unit_get_health 0guntower_center) 0)
		(<= (unit_get_health 0guntower_right) 0)
		(<= (unit_get_health 0guntower_left) 0)
	)
)

(script static boolean is_1orless_0guntowers_left
	(or
		(and 
			;(<= (unit_get_health 0guntower_center) 0)
			(<= (unit_get_health 0guntower_right) 0)
			(<= (unit_get_health 0guntower_left) 0)
		)
		(and 
			(<= (unit_get_health 0guntower_center) 0)
			;(<= (unit_get_health 0guntower_right) 0)
			(<= (unit_get_health 0guntower_left) 0)
		)
		(and 
			(<= (unit_get_health 0guntower_center) 0)
			(<= (unit_get_health 0guntower_right) 0)
			;(<= (unit_get_health 0guntower_left) 0)
		)
	)
)

(script static boolean l_or_r_0guntowers_dead
	(or 
		(<= (unit_get_health 0guntower_right) 0)
		(<= (unit_get_health 0guntower_left) 0)
	)
)

(script static boolean l_and_r_0guntowers_dead
	(and 
		(<= (unit_get_health 0guntower_right) 0)
		(<= (unit_get_health 0guntower_left) 0)
	)
)

(script dormant vehicle_spawn01

	(sleep_until (are_0guntowers_defeated))
	
	(hud_allies)
	
	;(sleep_until (volume_test_objects 3turret_allied_vehicle_spawn (players))15 300)
	
	;(game_save_immediate);SSSAAAVVVEEE---
	
	(wake pretrap_debris_destroy);wake
	
	(wake lz01_a_dropship01);wake
	
	(sleep 30)
	
	(wake lz01_a_dropship02);wake
	
	(sleep 30)
	
	(wake lz01_a_dropship03);wake
	
	(sleep 10)
	
	(wake lz01_a_dropship04);wake
	
	(wake allied_orders01);wake
	
		
	;HACK UNTIL AND UNLESS THE PATHFINDING IS (FULLY) FIXED
	(wake dig_allied_clear_path_hack);wake
)




	;vvvv-----  destroyable_cover_demo_dialog  -----vvvv

(script dormant destroyable_cover_demo_dialog

	(sleep_until (volume_test_objects destroyable_cover_demo (players))15)
	
	(print "05_032_elite1 --- Allies: take out that debris blocking the way")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0320_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0320_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0320_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0320_el1"))
	
	;(wake music_5)
	
	(print "05_033_elite1 --- Allies: we can destroy this debris with our heavy weapons")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0330_el1" none 1 Audio_filter_elite_l_1)
	(cinematic_subtitle l05_0330_el1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0330_el1") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0330_el1"))
	
	(print "05_034_elite2 --- Allies: use the Wrait to destroy  wreckage")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0340_el2" none 1 Audio_filter_elite_l_2)
	(cinematic_subtitle l05_0340_el2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0340_el2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0340_el2"))
)

(script dormant lz_secure_dialog01

	(sleep_until (volume_test_objects lz_secure_trigger01 (players))15)
	
	(wake music_thunder)
		
	(print "05_030_soc --- C.O.:  We've established a secure L.Z.")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0300_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0300_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0300_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0300_soc"))
	
	(print "05_031_soc --- C.O.:  Time to take out the Heretic base")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0310_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0310_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0310_soc") subtitle_time) subtitle_time_add))
	

)

	;vvvvvvvv----  Turret_right Turret_left Dialog   ------vvvvvv

(script dormant destroy_last_turret_dialog

	(print "destroy_last_turret_dialog running")
	
	(sleep_until (is_1orless_0guntowers_left))

	(game_save_no_timeout);SSSAAAVVVEEE---
	
	(sleep 30)
	
	(print "05_018_soc --- C.O.:  One turret left.")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0180_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0180_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0180_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0180_soc"))
	
	(print "05_019_soc --- C.O.:  Hurry, Dervish!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0190_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0190_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0190_soc") subtitle_time) subtitle_time_add))
)

(script dormant lz_r

	(ai_place lz_back)
	(ai_place lz_front)

)

(script dormant last_turret_destroyed_dialog

	(print "last_turret_destroyed_dialog running")

	(sleep_until (are_0guntowers_defeated))
	
	(wake lz_r);wake
	
	(game_save_no_timeout);SSSAAAVVVEEE---

	(sleep 30)
	
	(print "05_020_soc --- C.O.:  At LAST!!!.")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0200_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0200_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0200_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0200_soc"))
	
	(print "05_021_soc --- Tartarus:  All warriors, descend! The path is clear!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0210_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0210_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0210_soc") subtitle_time) subtitle_time_add))
	
	(sleep 75)
	
	(wake destroyable_cover_demo_dialog);wake
	
	(wake vehicle_spawn01);wake
	
	(wake lz_secure_dialog01);wake
	
	;(wake music_4);wake

)

(script dormant lz_middle_l 
;ln4451
	(sleep_until 
		(or
			(volume_test_objects turret_left_middle01 (players))
			(volume_test_objects turret_left_middle02 (players))
		)	
	15)

	(if G_lz_middle (sleep 32000))
	(set G_lz_middle true)

	(ai_place lz_middle_l)
	
	(sleep_until (<= (ai_living_count lz_middle_l) 1))
	
	(sleep_until (l_or_r_0guntowers_dead))
	
	(if (<= (unit_get_health 0guntower_right) 0) 
		(begin	
			(ai_set_orders lz_middle_l turret_left_front04)
		)
		
		(begin
			(ai_set_orders lz_middle_l turret_right_front04)
		)
	)
	
	(sleep_until (l_and_r_0guntowers_dead))
	
	(ai_set_orders lz_middle_l lz_front_right)
	
)

(script dormant lz_middle_r
;ln4452
	(sleep_until (volume_test_objects Turret_right_middle (players))15)

	(if G_lz_middle (sleep 32000))
	(set G_lz_middle true)

	(ai_place lz_middle_r)
	
	(sleep_until (l_or_r_0guntowers_dead))
	
	(if (<= (unit_get_health 0guntower_left) 0) 
		(begin	
			(ai_set_orders lz_middle_r turret_right_front04)
		)
		
		(begin
			(ai_set_orders lz_middle_r turret_left_front04)
		)
	)
	
	(sleep_until (l_and_r_0guntowers_dead))
	
	(ai_set_orders lz_middle_r lz_front_left)
)


;vvvvvvv ------------- turret left/right move ------------------vvvvvvvvvvvv
	; (when a turret dies the troops defending that turret will 
	;            migrate to the other turret)



(script dormant turret_right_2_left	
	
	(sleep_until 
		(and
			(<= (unit_get_health 0guntower_right) 0)
			(> (unit_get_health 0guntower_left) 0)
		)
	)
	
		(if G_turret_left_right_move (sleep_forever))
		(set G_turret_left_right_move true)
		
		(ai_set_orders turret_right turret_left_attack)
		
)

(script dormant turret_left_2_right
	
	(sleep_until 
		(and
			(> (unit_get_health 0guntower_right) 0)
			(<= (unit_get_health 0guntower_left) 0)
		)
	)
	
		(if G_turret_left_right_move (sleep_forever))
		(set G_turret_left_right_move true)
		
		(ai_set_orders turret_left turret_right_attack)
		
)

;END__SEGMENT THING vvvvvvvvvvvvvvVVVVVVVVV

(script dormant g_end_segment01
	(sleep_until 
		(volume_test_objects turret_right_end (players))
    )
	(game_save_no_timeout);SSSAAAVVVEEE---
)





;VVVVVVVVVVVVVVVVVV-----------TURRET_RIGHT-----------------------------------VVVVVVVVVVVVVV
;VVVVVVVVVVVVVVVVVV-----------TURRET_RIGHT-----------------------------------VVVVVVVVVVVVVV
;VVVVVVVVVVVVVVVVVV-----------TURRET_RIGHT-----------------------------------VVVVVVVVVVVVVV

(script dormant turret_right_r01

	(sleep_until (<= (ai_living_count turret_right) 2))
	
	(ai_place turret_right_r01)
	
	(sleep_until (<= (unit_get_health 0guntower_right) 0))
	
	(sleep_until (volume_test_objects Turret_right_middle (players))15)
	
	(if (<= (unit_get_health 0guntower_left) 0) 
		(begin	
			(ai_set_orders turret_right_r01 lz_front_right)
		)
		
		(begin
			(ai_set_orders turret_right_r01 lz_front_left)
		)
	)
)

(script dormant turret_right
	
	(print "turret_right wake")
	(sleep_until (volume_test_objects turret_right (players))15)
	(print "turret_right running")
	
	(if G_turret_right (sleep_forever))
	(set G_turret_right true)
	
	(ai_place turret_right_elites01)
	(ai_place turret_right_grunts01)
	
	(object_create turret_right_ap_turret01)
	
	(ai_vehicle_enter_immediate turret_right_grunts01/starting_locations_0 turret_right_ap_turret01 "c_turret_ap_d")
	
	(wake turret_right_r01);wake
)

	;vvvvvv-----TURRET_RIGHT SPAWN if between turrets triggered---v

(script dormant turret_right_middle
	
	(print "turret_right_middle wake")
	(sleep_until (volume_test_objects turret_right_middle (players))15)
	(print "turret_right_middle running")
	
	(if G_turret_right (sleep_forever))
	(set G_turret_right true)
	
	(ai_place turret_right_elites01)
	(ai_place turret_right_grunts01)
	
	(object_create turret_right_ap_turret01)
	
	(ai_vehicle_enter_immediate turret_right_grunts01/starting_locations_0 turret_right_ap_turret01 "c_turret_ap_d")
	
	(wake turret_right_r01);wake
	
)

	;vvvvvv-----TURRET_RIGHT02 SPAWN if all guys in turret01 are dead---v

(script dormant turret_right02_alldead
	
	(print "turret_right02_alldead wake")
	(sleep_until (<= (unit_get_health 0guntower_center)0))
	(sleep_until (volume_test_objects turret_right02 (players))15)	
	(game_save_no_timeout) ; dig save point
	(print "turret_right02_alldead running")
	
	(if G_turret_right02 (sleep_forever))
	(set G_turret_right02 true)

	(ai_place turret_right_elites02)
	(ai_place turret_right_grunts02)
	
	;(ai_set_orders turret_right_elites02 turret_right_investigate)
	;(ai_set_orders turret_right_grunts02 turret_right_investigate)
	
)

	;vvvvvv-----TURRET_RIGHT02 SPAWN if turret_right triggered---v

(script dormant turret_right02
	
	(print "turret_right02 wake")
	(sleep_until (volume_test_objects turret_right02 (players))15)
	(game_save_no_timeout) ; dig save point
	(print "turret_right02 running")
	
	(if G_turret_right02 (sleep_forever))
	(set G_turret_right02 true)
	
	(ai_place turret_right_elites02)
	(ai_place turret_right_grunts02)
	
	;(ai_set_orders turret_right_elites02 turret_right_intro02)
	;(ai_set_orders turret_right_grunts02 turret_right_intro02)
)



;VVVVVVVVVVVVVVVVVV-----------TURRET_LEFT------------------------------------------VVVVVVVVVVVVVV
;VVVVVVVVVVVVVVVVVV-----------TURRET_LEFT------------------------------------------VVVVVVVVVVVVVV
;VVVVVVVVVVVVVVVVVV-----------TURRET_LEFT------------------------------------------VVVVVVVVVVVVVV

(script dormant turret_left_r01
	
	(sleep_until (<= (ai_living_count turret_left) 3))
	
	(ai_place turret_left_r01)
	
	(sleep_until (<= (unit_get_health 0guntower_left) 0))
	
	(sleep_until 
		(and
			(volume_test_objects turret_left_middle01 (players))
			(volume_test_objects turret_left_middle02 (players))
		)
	)
	
	(if (<= (unit_get_health 0guntower_right) 0) 
		(begin	
			(ai_set_orders turret_left_r01 lz_front_left)
		)
		
		(begin
			(ai_set_orders turret_left_r01 lz_front_right)
		)
	)
)

(script static void G_t_left_middle_trigger_once
	(if G_turret_left_middle_trigger (sleep_forever))
	(set G_turret_left_middle_trigger true)
	
	(print "doing G_turret_left_middle_trigger action")
	(game_save_no_timeout) ; dig save point
)

(script dormant turret_left
	
	(print "turret_left wake")
	(sleep_until (volume_test_objects turret_left (players))15)
	
	(G_t_left_middle_trigger_once)
	
	(print "turret_left running")
	
	(ai_place turret_left_elites)
	
	(object_create turret_left_ap_turret01)
	
	(ai_vehicle_enter_immediate turret_left_elites/starting_locations_1 turret_left_ap_turret01 "c_turret_ap_d")
	
	(ai_set_orders turret_left_elites turret_left_intro)
	
	(wake turret_left_r01);wake
	
	;(wake last_turret_destroyed_dialog);wake
	;(wake save01);wake
	
)

(script dormant turret_left_middle
	
	(print "turret_left wake")
	
	(sleep_until 
		(or
			(volume_test_objects turret_left_middle01 (players))
			(volume_test_objects turret_left_middle02 (players))
		)	
			15)
			
	(G_t_left_middle_trigger_once)
				
	(print "turret_left running")
	
	(ai_place turret_left_elites)
	
	(object_create turret_left_ap_turret01)
	
	(ai_vehicle_enter_immediate turret_left_elites/starting_locations_1 turret_left_ap_turret01 "c_turret_ap_d")
	
	(ai_set_orders turret_left_elites turret_left_intro)
	
	(wake turret_left_r01);wake
	
	(wake vehicle_spawn01);wake
	(wake save01);wake
	
	;(sleep_until (volume_test_objects runandgun01 (players))15)
	
	;(wake runandgun01)
	;(wake trap01)
	
)



	;vvvvvv-----TURRET_LEFT_ELITES02 SPAWN if all guys in turret01 are dead---v
	
(script static void G_tleft_elites02_once
	(if G_turret_left_elites02 (sleep_forever))
	(set G_turret_left_elites02 true)
	
	(print "doing G_tleft_elites02 action")
	(game_save_no_timeout) ; dig save point
)

(script dormant turret_left_elites02_alldead
	
	(print "turret_left_elites02_alldead wake")
	; num0005: changed this from checking 0guntower_center health due to comment ^^^^
	(sleep_until (<= (ai_living_count turret_left_elites02)0))
	(print "turret_left_elites02_alldead running")
	
	
	(sleep_until (volume_test_objects turret_left02 (players)))
	(G_tleft_elites02_once) ; only go past this point once

	(ai_place turret_left_elites02)
	(ai_place turret_left_grunts01)

	(ai_set_orders turret_left_elites02 turret_left_elites02_attack)
	(ai_set_orders turret_left_grunts01 turret_left_elites02_attack)

)

	;vvvvvv-----TURRET_LEFT_ELITES02 SPAWN if trigger Turret_left---v

(script dormant turret_left_elites02
	
	(print "turret_left_elites02 wake")
	(sleep_until (volume_test_objects turret_left02 (players))15)
	
	(G_tleft_elites02_once)
	
	(print "turret_left_elites02")

	(ai_place turret_left_elites02)
	(ai_place turret_left_grunts01)

	(ai_set_orders turret_left_elites02 turret_left_elites02_intro)
	
	(sleep_until (<= (ai_living_count turret01_elites) 0))
	
	(ai_set_orders turret_left_elites02 turret_left_elites02_attack)
	(ai_set_orders turret_left_grunts01 turret_left_elites02_attack)

)

	;vvvvvv-----TURRET_LEFT_ELITES02 SPAWN if trigger Turret_Between---v

(script dormant turret_left_elites02_middle

	(sleep_until 
		(or
			(volume_test_objects turret_left_middle01 (players))
			(volume_test_objects turret_left_middle02 (players))
		)	
			15)
			
	(G_tleft_elites02_once)
	
	(print "turret_left_elites02_middle")
	
	(ai_place turret_left_elites02)
	(ai_place turret_left_grunts01)

	(ai_set_orders turret_left_elites02 turret_left_elites02_investig)

)


		
	
	;vvvv-------- DIALOG: turret01-------------------------v
	
(script dormant turret01_dialog_alt
	
	(sleep_until 
		(and
			(> (unit_get_health 0guntower_center) 0)
			(or	
				(volume_test_objects turret_left02 (players))
				(volume_test_objects turret_right02 (players))
			)
		)
	)
	
	(print "turret01_dialog_alt")
	
	(sleep 15)
	
	(print "05_017_soc --- C.O.:  We need their air defenses destroyed before we can land our assault force,")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0170_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0170_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0170_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0170_soc"))
	
	(print "--- C.O.:  find and destroy any AAA guns in the area")
)

(script dormant turret01_dialog

	(sleep_until 
		(or
			(<= (unit_get_health 0guntower_center)0)
			(<= (unit_get_health 0guntower_right)0)
			(<= (unit_get_health 0guntower_left)0)
		)
	)
	
	(print "turret01_dialog")
	
	(game_save_immediate);SSSAAAVVVEEE---
	
	(sleep 40)
	
	(print "05_015_soc --- C.O.:  Good job. their defenses have been weakened..")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0150_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0150_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0150_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0150_soc"))
	
	(print "05_016_soc --- C.O.:  our scanners are detecting 2 more guns in the area. ..")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0160_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0160_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0160_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0160_soc"))
	
	;(wake music_2);wake
	
	(sleep 90)
	
	;(wake music_4);wake
	
	;(sleep 35)
	
	;(print "--- C.O.:  take them out so our assault force can land ") 

)
	;vvvv---------  turret01  ------------------------vvvvvvvvvvvvv
	

(script dormant turret01_2ndwave

	(sleep_until 
		(and
			(<= (unit_get_health 0guntower_center) 0)
			(<= (ai_living_count turret01_reinforcements) 1)	
		)
	)
	
	(print "turret01_2ndwave!")
	
	(ai_place turret01_2ndwave_rr)
	(ai_place turret01_2ndwave_r)
	(ai_place turret01_2ndwave_ll)
)


(script command_script cs_turret01_reinforcements
	
	(print "guys walk off cliff")
	
	(cs_move_in_direction 320 7 0)
)


; 0guntower: fire at the phantom
; ONLY CALLABLE FROM COMMAND SCRIPTS
(script static void cs_0guntower_shoot_dig_phantom
	(cs_force_combat_status 4)
	(cs_shoot true turret01_dropship02)
)

; 0guntower: pick one of the random points and fire at it
; ONLY CALLABLE FROM COMMAND SCRIPTS
(script static void cs_0guntower_shoot_randomly
	(cs_force_combat_status 4)
	(begin_random
		(cs_shoot_point true guntower_opening_dig/shootme0)
		(cs_shoot_point true guntower_opening_dig/shootme1)
		(cs_shoot_point true guntower_opening_dig/shootme2)
		(cs_shoot_point true guntower_opening_dig/shootme3)
		(cs_shoot_point true guntower_opening_dig/shootme4)
		(cs_shoot_point true guntower_opening_dig/shootme5)
		(cs_shoot_point true guntower_opening_dig/shootme6)
		(cs_shoot_point true guntower_opening_dig/shootme7)
		(cs_shoot_point true guntower_opening_dig/shootme8)
	)
)

; 0guntower: pick one of the random points and fire at it
; only points around the opening area are included
; ONLY CALLABLE FROM COMMAND SCRIPTS
(script static void cs_0guntower_shoot_opening
	(cs_force_combat_status 4)
	(cs_ignore_obstacles 1)
	(begin_random
		(cs_shoot_point true guntower_opening_dig/shootme1)
		(cs_shoot_point true guntower_opening_dig/shootme6)
		(cs_shoot_point true guntower_opening_dig/shootme7)
		;(cs_shoot_point true guntower_opening_dig/shootme8)
	)
)

(script command_script cs_dig_phantom_gun_left
	(print "cs_dig_phantom_gun_left")
	(cs_enable_targeting 0)
	(sleep 30)
	(cs_shoot_point true dig_phantom_target_points/left1)
	(sleep_forever)
)

(script command_script cs_dig_phantom_gun_right
	(print "cs_dig_phantom_gun_right")
	(cs_enable_targeting 0)
	(sleep 30)
	(cs_shoot_point true dig_phantom_target_points/right1)
	(sleep_forever)
)

(script command_script cs_dig_phantom
	(print "cs_dig_phantom")
	
	; run command scripts on the two side guns to hit some points *besides* the guntower
	; we can't let the AI shoot on its own cause it will hit the tower
	(cs_run_command_script (cs_phantom_left_gun_get_ai) cs_dig_phantom_gun_left)
	(cs_run_command_script (cs_phantom_right_gun_get_ai) cs_dig_phantom_gun_right)
	(ai_braindead (cs_phantom_chin_gun_get_ai) 1) ; we don't use the middle gun
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_boost 1)
	(cs_fly_by dig_phantom/p0)
	
	(ai_kill (cs_phantom_chin_gun_get_ai))
	
	(cs_fly_by dig_phantom/p1)
	; kill the AI
	(ai_kill (cs_phantom_left_gun_get_ai))
	(ai_kill (cs_phantom_right_gun_get_ai))
	(object_set_phantom_power (ai_vehicle_get ai_current_actor) false)
	(cs_fly_to_and_face dig_phantom/p2 dig_phantom/p2 1.0)
	(cs_fly_to_and_face dig_phantom/p3 dig_phantom/p3 1.0)
	(cs_vehicle_boost 0)

)

(script command_script turret01_look_at_dropship
	(cs_abort_on_damage true)
	(print "look at the thing")
	(cs_enable_moving false)
	(cs_enable_looking true)
	(sleep 10)
	(cs_look_object true (list_get (ai_actors dig_phantom/driver) 0))
	(sleep 120)
	
	(print "05_014_helite2 --- Heretic: Look, another (one) hit!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0140_he2" (list_get (ai_actors turret01_elites) 0) 1 heretic_elite)
	(cinematic_subtitle l05_0140_he2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0140_he2") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0140_he2"))
	
	(print "05_013_helite1 --- Heretic: Our guns will take care of that!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0130_he1" (list_get (ai_actors turret01_elites) 1) 1 heretic_elite)
	(cinematic_subtitle l05_0130_he1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0130_he1") subtitle_time) subtitle_time_add))
	
	;(cs_play_line 0130)
	;(sleep 40)
	;(cs_play_line 0140)
	(cs_abort_on_alert true)
	
	(hud_help_1)
	(if (< nav 1) (set nav 1))	(wake navpoints)
)

(script static void do_dig_phantom_expolsions
	(cs_run_command_script turret01_elites turret01_look_at_dropship)
	(sleep 60)
	(effect_new_on_object_marker "effects\objects\vehicles\creep\trans_hull_destroyed" (ai_vehicle_get_from_starting_location dig_phantom/driver) "target_engine_left")
	(sleep 45)
	(effect_new_on_object_marker "effects\objects\vehicles\creep\trans_hull_destroyed" (ai_vehicle_get_from_starting_location dig_phantom/driver) "left_gun")
	(sleep 10)
	(effect_new_on_object_marker "effects\objects\vehicles\creep\trans_hull_destroyed" (ai_vehicle_get_from_starting_location dig_phantom/driver) "right_gun")
	(sleep 30)
	(effect_new_on_object_marker "effects\objects\vehicles\creep\trans_hull_destroyed" (ai_vehicle_get_from_starting_location dig_phantom/driver) "large_cargo")
	(sleep 5)
	(effect_new_on_object_marker "effects\objects\vehicles\creep\trans_hull_destroyed" (ai_vehicle_get_from_starting_location dig_phantom/driver) "small_cargo01")
	(sleep 60)
	(ai_erase dig_phantom)
)

(script dormant dig_phantom_expolsions
	(do_dig_phantom_expolsions)
)

(script command_script cs_0guntower_generic
	;(cs_make_immortal) ; deathless, dreamless, timeless
	(sleep_until
		(begin
			(cs_0guntower_shoot_randomly) ; pick random points
			(cs_pause (random_range 2 5)) ; wait 2-5 seconds
			(cs_is_my_mount_dead) ; basically loop forever until the vehicle is destroyed
		)
	)
	
	(unbreak_guntower)
	;(cs_erase_actor); die like a heretic
)

; 
; interface between cinematic and guntower
;
(global boolean 0guntower_cinemtatic_start false)
(script static void guntower_center_play_intro
	(set 0guntower_cinemtatic_start true)
)

(script command_script cs_0guntower_center
	(print "cs_0guntower_center waiting on opening")
	; opening cinematic shots!
	(sleep_until (or (not (is_cinematic_opening)) 0guntower_cinemtatic_start (> phantom_intro_dig 0))) 
	(print "cs_0guntower_center running opening")
	(cs_force_combat_status 4)
	(cs_ignore_obstacles 1)
	(cs_shoot_point true guntower_opening_dig/shootme7)
	(cs_pause 0.5)
	(cs_shoot_point true guntower_opening_dig/shootme1)
	(cs_pause 0.5)
	(cs_shoot_point true guntower_opening_dig/shootme7)
	(cs_pause 0.5)
	(sleep 120)
	(print "cs_0guntower_center: entering early loop")
	; loop until the first event
	(sleep_until
		(begin
			(cs_0guntower_shoot_opening) ; pick random points
			(cs_pause 0.7) ; wait 0.7 seconds
			(>= phantom_intro_dig 1) ; loop until phantom section starts
		)
		1
	)
	
	; num0005: wait till the main script tells us to shoot
	(print "cs_0guntower_center: waiting for command to fire")
	; num0005: but we do take aim!
	(if use_dig_phantom_shootdown 
		(cs_aim_object true turret01_dropship02 ) ; dig scene target point
		(cs_aim_object true turret01_dropship02) ; original scene object to aim at
	)
	
	(sleep_until (>= phantom_intro_dig 2) 1)
	(print "cs_0guntower_center: firing")
	
	(if use_dig_phantom_shootdown
		(begin ; digsite shootdown scene
			(cs_force_combat_status 4)
			(ai_place dig_phantom)
			(ai_disregard (ai_actors dig_phantom) true)
			(ai_disregard 0guntower_center true)
			(sleep 10)
			(cs_shoot_point true dig_phantom/p0)
			(wake dig_phantom_expolsions)
			(sleep 60)
			(cs_shoot_point false dig_phantom/p0)
			(cs_aim_object true (ai_vehicle_get_from_starting_location dig_phantom/driver))
			(cs_shoot true (ai_vehicle_get_from_starting_location dig_phantom/driver))
			(print "Elite (Radio): Commander, we are under siege!")
			(sleep 180)
			; restore
			(ai_disregard 0guntower_center false)
		)
		(begin ; original shoot-down scene
			(cs_0guntower_shoot_dig_phantom)
			(cs_pause 0.5)
			(cs_0guntower_shoot_dig_phantom)
			(cs_pause 0.5)
			(cs_0guntower_shoot_dig_phantom)
	
			(sleep (* 30 5))
		)
	)

	; num0005: switch over to the generic script
	(print "cs_0guntower_center: all done, switching to generic mode")
	(cs_run_command_script ai_current_actor cs_0guntower_generic)
)

; callable from sapien
(script static void 0turret_do_setup
	; create vehicles
	(object_create_anew "0guntower_right")
	(object_create_anew "0guntower_left")
	(object_create_anew "0guntower_center")

	; connect them up to the AI
	(ai_attach 0guntower_right 0_guntower)
	(ai_attach 0guntower_left 0_guntower)
	(ai_attach 0guntower_center 0_guntower)

	(ai_force_active 0_guntower 1)

	(wake plant_gt_0_bomb)
	(wake plant_gt_1_bomb)
	(wake plant_gt_2_bomb)	

	(cs_run_command_script (object_get_ai 0guntower_right) cs_0guntower_generic)
	(cs_run_command_script (object_get_ai 0guntower_left) cs_0guntower_generic)
	
	; center gets a special script for the shoot down effect
	(cs_run_command_script (object_get_ai 0guntower_center) cs_0guntower_center)
)

; can only run once!
(script dormant turret01_creation
	(print "turret01_creation")
	(0turret_do_setup)
)


(script dormant turret01	
	(print "turret01 wake-up")
	
	(wake turret01_creation)
	
	(sleep_until (volume_test_objects turret01 (players))15)
	(print "turret01 running")
	
	(ai_place turret01_elites)
	(ai_place turret01_elites02)
	(ai_place turret01_side_i)
	
	(ai_set_orders turret01_elites turret01_intro)
	(ai_set_orders turret01_elites02 turret01_elites02_intro)
	
	(sleep 5)
	
	(ai_place turret01_back_r)
	
	(game_save_no_timeout);SSSAAAVVVEEE---
	
	(wake turret_left);wake
	(wake turret_left_middle);wake
	(wake turret_left_elites02_alldead);wake
	(wake turret_left_elites02);wake
	(wake turret_left_elites02_middle);wake
	
	(wake turret_right);wake
	(wake turret_right_middle);wake
	(wake turret_right02);wake
	(wake turret_right02_alldead);wake
	
	(sleep 15)
	
	(wake turret01_dialog);wake
	
	(wake turret01_dialog_alt);wake
	
	(wake destroy_last_turret_dialog);wake
	
	(wake last_turret_destroyed_dialog);wake
	
	(wake turret_right_2_left);wake
	(wake turret_left_2_right);wake
	
	
	(wake lz_middle_l);wake ln3944
	(wake lz_middle_r);wake ln3960
	

	(wake turret01_2ndwave);wake
	
	(sleep_until (<= (ai_living_count turret01_i) 2))
	
	(ai_place turret01_reinforcements)
	
	(cs_run_command_script turret01_reinforcements cs_turret01_reinforcements)
	
	;(cs_run_command_script turret01_reinforcements cs_turret01_reinforcements)
	
	;(cs_run_command_script turret01_reinforcements/starting_locations_1 cs_turret01_reinforcements)
	;(cs_run_command_script turret01_reinforcements/starting_locations_2 cs_turret01_reinforcements)
	;(cs_run_command_script turret01_reinforcements/starting_locations_3 cs_turret01_reinforcements)
)

(script dormant turret01_heretic_dialog

	(print "turret01_h_d")

	(sleep_until 
		(and
			(volume_test_objects turret01_heretic_dialog (players))
			(> (ai_living_count turret01_i) 3)
		)
	15)

	;(print "05_014_helite1 --- Heretic: Look, another (one) hit!")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0140_he2" (list_get (ai_actors turret01_elites) 0) 1 heretic_elite)
	;(cinematic_subtitle l05_0140_he2 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0140_he2") subtitle_time) subtitle_time_add))
	;(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0140_he2"))
	
	;(print "05_013_helite2 --- Heretic: Our guns will take care of them")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0130_he1" (list_get (ai_actors turret01_elites) 1) 1 heretic_elite)
	;(cinematic_subtitle l05_0130_he1 (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0130_he1") subtitle_time) subtitle_time_add))
	;(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0130_he1"))
)

;vvvvvvvvvvvv---------------3 TURRETS firing fx--------------------------------------------------vv
;vvvvvvvvvvvv---------------3 TURRETS--------------------------------------------------vv
;vvvvvvvvvvvv---------------3 TURRETS--------------------------------------------------vv


; callable from sapien
; moved by DIG to separate function 
(script static void turret01_dropship01_boom
	(object_create turret01_dropship01_debris03)
	;(sleep 5)
	
	;(sound_impulse_start "digsite\sound\temp\alphamoon\dropship_crash" turret01_dropship01_debris03 1)
	
	;(sleep 25)
	
	(set phantom_intro_dig 2); ; DIG: sets off the guntower fire
	; num0005: the scripts for the turrets are already setup at this points
	; the global makes them progress further
	(sleep 45);	DIG timing
	
	(effect_new "effects\objects\vehicles\creep\trans_hull_destroyed" turret01_dropship01_exp01)
	(effect_new "effects\objects\vehicles\creep\trans_hull_destroyed" turret01_dropship01_exp02)
	(sleep 20)
	
	; num0005: simulate physics for a little bit and then disable it
	(unit_set_current_vitality turret01_dropship02 0 0)
	(unit_kill_silent turret01_dropship02)
	(object_wake_physics turret01_dropship02)
	
	(effect_new "effects\objects\vehicles\creep\trans_hull_destroyed" turret01_dropship01_exp03)
	
	(object_create_containing "turret01_dropship01_debris")
	
	(object_dynamic_simulation_disable turret01_dropship02 1)
	
	(sleep 35)
	(effect_new "effects\objects\vehicles\creep\trans_hull_destroyed" turret01_dropship01_exp04)
	
	(if phantom_magic_despawn (object_destroy turret01_dropship02))
	
	(sleep 20)
	;(effect_new "effects\burning_large" turret01_dropship01_smk01)
	
	(object_destroy turret01_dropship01_debris03)
)

(script static void dig_test_dropship
	(ai_erase 0_guntower) ; clear old AI + vehicle
	(0turret_do_setup)
	(if (not use_dig_phantom_shootdown)
		(object_create_anew turret01_dropship02)
		(object_destroy turret01_dropship02)
	)
	(sleep 1)
	(set phantom_intro_dig 1)
	(sleep 80)
	(if use_dig_phantom_shootdown
		(set phantom_intro_dig 2) ; digsite scene: start firing script in CS
		(turret01_dropship01_boom) ; bungie scene: BOOM!
	)
)

(script dormant turret01_dropship01
	; num0005: create object earlier so it doesn't just pop into view
	(if (not use_dig_phantom_shootdown)
		(object_create turret01_dropship02)
	)
	(sleep_until (volume_test_objects turret01 (players))15)

	(print "05_005_soc --- C.O.:  Were pulling back until you have neutralized their defenses")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0050_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0050_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0050_soc") subtitle_time) subtitle_time_add))

	(set phantom_intro_dig 1)
	(sleep_until (volume_test_objects turret01_dropship01 (players))15)
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0050_soc"))
	
	(print "turret01 dropship")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level_fx\l05_0060_elr_fx" none 0.4 covy_radio)
	(cinematic_subtitle l05_0060_elr (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level_fx\l05_0060_elr_fx") subtitle_time) subtitle_time_add))
	
	(print "L05_0060 --- C.O.:  Their defenses are stronger than we thought,")
	
	(wake turret01_heretic_dialog);wake
	
	;(wake music_3)
	
	(if use_dig_phantom_shootdown
		(set phantom_intro_dig 2) ; digsite scene: start firing script in CS
		(turret01_dropship01_boom) ; bungie scene: BOOM!
	)
)

(script command_script v0110
	(cs_abort_on_damage true)
	(cs_abort_on_alert true)
	(cs_suppress_dialogue_global true)
	(cs_play_line 0110)
)

(script dormant intro_dialog

	(sleep 35)
	
	(print "05_003_soc --- C.O.:  Their defenses are stronger than we thought,")
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0030_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	;(cinematic_subtitle l05_0030_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0030_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0030_soc"))
	
	(print "05_004_soc --- C.O.:  no one else survived the first drop")	
	;(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0040_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	;(cinematic_subtitle l05_0040_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0040_soc") subtitle_time) subtitle_time_add))
	(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0040_soc"))
	
	(sleep 210)
	
	(cs_run_command_script intro_elites v0110)
	;(ai_play_line intro_elites 0110)
	;(wake music_1);wake
	
	;(wake music_2);wake
	
	(wake objective0_set)
)

(script dormant intro_reinforcements01
	
	(sleep_until 
		(or
			(<= (ai_living_count intro_intro) 3)	
			(volume_test_objects intro_front_middle_back (players))
		)
	15)
	
	(ai_place intro_reinforcements01)
	(ai_set_orders intro_reinforcements01 intro_reinforcements01)
)

(script dormant intro_i
	
	(ai_place intro_elites)
	(ai_place intro_grunts)
	
	(ai_place intro_front_middle)
	
	(ai_place intro_back)
	
	(ai_set_orders intro_elites intro_intro)
	(ai_set_orders intro_grunts intro_intro)
	
	(sleep 900)
	
	(ai_set_orders intro_elites intro_players_pod)
	(ai_set_orders intro_grunts intro_players_pod)

)

(script static void mission_setup
    (objectives_clear)
    (ai_allegiance player covenant)
    (ai_allegiance covenant prophet)
    (ai_allegiance prophet covenant)
)

;vvvvvvvv-----------start up script---------------vvvvvvvvvvvvv

(script startup elites
	(print "tyson EYES!!!")
	
	(print "HOLD FIRE WAIT NO DON'T DO THE MISSION SCRIPTS YET (hold for eula)")
	
	(if (not global_playtest_mode) (sleep_until dig_100percentready 4))
	
	(mission_setup)
	; setup first set of turrets early
	(wake turret01_creation)
	
	(sleep_forever runandgun02_hds01_loop)
	
		; run cinematic stuff
	(if (not global_playtest_mode) (intro))
		
	;(wake music_1);wake
	
	(wake intro_dialog);wake
	
	(wake intro_i);wake
	
	(wake intro_reinforcements01);wake

	(wake turret01);wake
	
	(wake g_end_segment01);wake  ; on line 3837
	
	
	
	;(wake dropship_grunt);wake
	(wake trap01);wake
	
	
	
	(wake runandgun02);wake
	
;	(wake excavation_start01);wake
	
	(wake turret01_dropship01);wake
	(sleep 5)
	
	(wake 1turret_intro);wake
	
	(wake 2turret01);wake
	
;	(wake excavation_middle_low);wake
	
	(wake heretic_leader_intro);wake

	(sleep 90)
	
	;(wake view_i);wake
	
	(wake view);wake
	
	(wake pre_s_trap);wakeln1373
	
	;(wake a_1turret_reinforce);wake
	
	(sleep_until (volume_test_objects intro_back (players))15)
	(ai_disposable intro_intro 1)
	
	;(ai_set_orders intro_elites turret01_retreat)
	;(ai_set_orders intro_grunts turret01_retreat)
)

(script static void termsandconditions
	(set dig_100percentready true);	Workaround for stuff not working...around
)