;	DIGSITE, ALPHA MOON CINEMATICS

(global boolean dig_ready false)
(global boolean dig_skip false)
(global boolean dig_actuallyready false)

(script stub void termsandconditions
	(print "weow");	Workaround for stuff not working...around
)

(script dormant intro_intake;            DIGSITE, intro menu hack
    (if (cinematic_skip_start)
        (begin
            (object_create_anew dig_intake)
            (object_set_permutation dig_intake "" "dig_eula")
            (camera_set dig_eula_cam_0 0)       (camera_set_field_of_view 75 0)
            (sleep 30)
			(rasterizer_bloom_override true)	(rasterizer_bloom_override_brightness 0)
            (fade_in 0 0 0 5)					(cinematic_screen_effect_start true)
            (sound_impulse_start "sound\ui\advance" none 1.0)
            (camera_set dig_eula_cam_1 5)       (sleep 1320);    DIGSITE coop 45 second EULA sleep
            (fade_out 0 0 0 5)
        )
    (cinematic_skip_stop)
    )
    (sound_impulse_start "sound\ui\forward1" none 1.0)
    (fade_out 0 0 0 0)    (set dig_skip true)    (sleep 5)
	(rasterizer_bloom_override_reset true)
)

(script startup intro_ready;				DIGSITE, gracefully transition from the intake to the logo
	
	; skip if dev playtesting
	(if global_playtest_mode (sleep_forever))
	(sound_class_set_gain ambient_nature 0 0)
	
	(cinematic_snap_to_black)
	(camera_control 1)

	(sleep 1)	(switch_bsp 3)	(sleep 1)

	(wake intro_intake)	(sleep_until dig_skip)
	;(sleep_forever intro_options);	DIGSITE, old logic for original sandbox/nav conrfig
	(camera_set dig_eula_cam_0 5)	(camera_set_field_of_view 120 10)
	
	(fade_out 0 0 0 5)	(sleep 5)	(switch_bsp 0)	(set dig_ready true)
	(object_destroy dig_intake)	(termsandconditions)
)


;-OUTRO-------------------------------------------------------------------------

(script static void wheresmymoney
	(if (<= (random_range 1 1500) 1)
        (begin			(cinematic_set_title_delayed prize_loser 0.0)	(print "you win $1!!!!!")		(sleep 60))
        (begin			(cinematic_set_title_delayed prize_loser 0.0)	(print "sorry you did not win")	(sleep 60))
    )    (sleep 120)    (game_won)
)

(script dormant level_ending_dig
	(fade_out 1 1 1 0)
	
	(sound_class_set_gain ambient_nature 0 90)	(sound_class_set_gain ambient_device 0 90)
	
	(ai_erase_all)
	(rasterizer_bloom_override 1)	(rasterizer_bloom_override_threshold 1)
	(camera_control 1)	(object_create "dig_ending_nickelodeon")
	(cinematic_start)	(cinematic_screen_effect_start true)
	(camera_set "nickelodeon_cam" 0)	(camera_set_field_of_view 53 0)	(sleep 30)
	
	(sound_looping_start "digsite\sound\cinematics\alphamoon\outro_music" none 1.0);			music and ambience
	(sound_impulse_start "digsite\sound\cinematics\alphamoon\outro\radioplay_foley" none 1.0);	foley sfx
	(sound_impulse_start "digsite\sound\cinematics\alphamoon\outro\radioplay_dialog" none 1.0);	character dialog
	
	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_01")
	
	(fade_in 1 1 1 120)
	(sleep 144)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_02")
	(sleep 195)	(cinematic_screen_effect_set_crossfade 2)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_03")
	(sleep 140)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_04")
	(sleep 110)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_05")
	(sleep 184)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_06")
	(sleep 130)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_07")
	(sleep 198)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_08")
	(sleep 160)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_09")
	(sleep 138)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_10")
	(sleep 130)	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_11")
	(cinematic_screen_effect_set_crossfade 2)
	
	(sleep 90)	(fade_out 0 0 0 120)	(sleep 120)
	
	(object_set_permutation "dig_ending_nickelodeon" "" "outro_1_black")
	(object_create_anew dig_credits)	(object_set_permutation "dig_credits" "" "credit_1")
	(sound_impulse_start "digsite\sound\music\am\credits" none 1.0)
    	
    (fade_in 0 0 0 60)    (sleep 300)    (fade_out 0 0 0 60)
	
    (sleep 60)	(object_set_permutation "dig_credits" "" "credit_2")    (fade_in 0 0 0 60)
    (sleep 300)	(fade_out 0 0 0 60)
	(sleep 60)	(object_set_permutation "dig_credits" "" "credit_3")    (fade_in 0 0 0 60)
    (sleep 300)	(fade_out 0 0 0 60)
    (sleep 60)	(object_set_permutation "dig_credits" "" "credit_4")    (fade_in 0 0 0 60)
    (sleep 300)	(fade_out 0 0 0 60)
    (sleep 60)	(object_set_permutation "dig_credits" "" "credit_5")    (fade_in 0 0 0 60)
    (sleep 300)	(fade_out 0 0 0 60)
    (sleep 60)	(object_set_permutation "dig_credits" "" "credit_6")    (fade_in 0 0 0 60)
    (sleep 300)	(fade_out 0 0 0 60)
    (sleep 60)	(object_set_permutation "dig_credits" "" "credit_7")    (fade_in 0 0 0 60)
    (sleep 300)	(fade_out 0 0 0 210)	(print "please wrap it up")
    (sleep 700)	(object_destroy "dig_credits")    (print "game won")    (wheresmymoney)
)

(script static void outro_dig
	(cheat_active_camouflage true)	(cinematic_stash_players)	(wake level_ending_dig)
)

(global boolean opening_cinematic true)
(script static boolean is_cinematic_opening	opening_cinematic)
(script stub void guntower_center_play_intro	(print "telling main script to start playing that intro bit"))

;-INTRO-------------------------------------------------------------------------

(script stub void chapter_intro_stubby
	(print "chapter_intro");	Needed for the first chapter title to work, don't remove this
)

(global boolean new_intro true)

(script static void cinematic_stash_enemies;	wtf man why would you do it this way
	(print "FILTHY HERETIC (you scripting hack)")
)

(script static void cinematic_unstash_enemies;	wtf man why would you do it this way
	(print "FILTHY HERETIC (you scripting hack)")
)

(script dormant dig_pod_1_animhold
	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 67)
	(sleep 3)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 62)
	(sleep 3)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 62)
	(sleep 3)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 62)
)

(script static void dig_pod_1
	(object_create_anew dervish) (object_teleport dervish dig_x01_pod_flag)
	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" false 0)
	(sleep 30) (sound_impulse_start_3d "sound\characters\elite\warthog_g_exit" 5 0.7)
	(sleep (- (unit_get_custom_animation_time dervish) 32))
	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 67)
	(camera_pan dig_intro_03a dig_intro_03b 130 20 0.3 110 0)
	(camera_set_field_of_view 40 0)	(camera_set_field_of_view 35 89)
	(sleep (- (unit_get_custom_animation_time dervish) 32))
	;(camera_pan dig_intro_03b dig_intro_04b 240 100 0 120 0)
	
	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 67)
	(sleep 1)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 66)
	(sleep 2)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 65)
	(sleep 1)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 64)
	(sleep 2)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 63)
	(sleep 1)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 62)
	(sleep 2)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 61)
	(sleep 1)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 60)
	(sleep 2)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 60)
	(sleep 1)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 59)
	(sleep 2)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 59)
	(sleep 1)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 58)
	(sound_impulse_start_3d "sound\weapons\plasma_rifle\plasrifle_ready" 40 0.60)
	(sleep 2)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 58)
	(sleep 1)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 57)
	(sleep 2)	(unit_custom_animation_at_frame dervish digsite\objects\characters\elite\e3\e3 "e3_out_08_elite" true 57)
	(sleep 35)
)

(script dormant dig_pod_2_animhold
	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" false 0)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
	(sleep 2)	(unit_custom_animation_at_frame dervish objects\characters\dervish\08_intra2\08_intra2 "dervish_01" true 50)
)

(script static void dig_pod_2
	(sound_class_set_gain projectile_detonation 1 90)
	(camera_set dig_intro_04a 0) (camera_set_field_of_view 54 0)
	(object_teleport dervish dig_x01_pod_flag2)
	(wake dig_pod_2_animhold)
	
	(object_create_anew dervish_gun)	(objects_attach dervish "right hand" dervish_gun "")
	(guntower_center_play_intro)
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0050_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0050_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0050_soc") subtitle_time) subtitle_time_add))
	
	(sleep 10)	(camera_pan dig_intro_04a dig_intro_04b 240 100 0 120 0)	(camera_set_field_of_view 40 240)
	(sleep (- (unit_get_custom_animation_time dervish) 232))
	
	(fade_out 1 1 1 30)
	(sleep (+ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0050_soc") 50))
)

(script dormant dig_pod_fx
	(player_effect_set_max_translation 0.2 0.2 0.2)	(player_effect_start 0.05 0)
	(sound_impulse_start_3d "sound\materials\hard\terrain_concrete\concrete_burst" 20 0.4)
	(sleep 2)	(player_effect_stop 1)
)

(script dormant intro_cam_01
	(cinematic_enable_ambience_details true)
	(sound_class_set_gain ambient_nature 1 300)
	
	(rasterizer_blur 2)
	
	(if (cinematic_skip_start)
		(begin
			(sound_class_set_gain ambient_nature 1 90) (sound_class_set_gain projectile_detonation 1 240)
			(object_destroy dervish_pod)

			(cinematic_screen_effect_start 1)	(cinematic_screen_effect_set_depth_of_field 3 0 0 0 0 10 0)

			(camera_set dig_intro_00a 0)	(camera_set_field_of_view 40 0)
			
			(cinematic_stash_enemies)
			
			(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0030_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
			(cinematic_subtitle l05_0030_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0030_soc") subtitle_time) subtitle_time_add))
			(sleep (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0030_soc"))
			
			(camera_set_field_of_view 60 120)	(camera_pan dig_intro_00a dig_intro_01a 240 100 0 120 0)
			(sleep 30)
			
			(fade_in 0 0 0 80)
			
			(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0040_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
			(cinematic_subtitle l05_0040_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0040_soc") subtitle_time) subtitle_time_add))
			
			(sleep 140)
			(camera_set_field_of_view 50 120)	
			(cinematic_screen_effect_set_depth_of_field 3 0 0 0 10 0 1)
			
			(sleep 30)
			
			(object_create_anew dervish_pod) (object_set_permutation dervish_pod "" "standard")
			(scenery_animation_start "dervish_pod" "digsite\objects\vehicles\insertion_pod\e3\e3" "e3_pod_landing")
			
			(sleep (- (scenery_get_animation_time "dervish_pod") 62))
			(wake dig_pod_fx)	(sleep 2)
			(effect_new_on_object_marker "effects\scenarios\solo\earthcity\e11_insertion_pod_impact" dervish_pod "pod_attach")
			(effect_new_on_object_marker "effects\scenarios\solo\earthcity\e11_insertion_pod_impact" dervish_pod "pod_attach")
			
			(sleep 45)
			(camera_pan dig_intro_02a_alt dig_intro_02b_alt 240 100 0 120 0)
			(sleep 30)
			
			(effect_new_on_object_marker "effects\objects\vehicles\insertion_pod\insertion_pod_door_ejection" dervish_pod "pod_attach")
			(object_set_permutation dervish_pod "door" "")
			(dig_pod_1)	(dig_pod_2)
		)
	)
	(cinematic_skip_stop)
	(set opening_cinematic false)
	(sound_class_set_gain ambient_nature 1 15) (sound_class_set_gain projectile_detonation 1 15)
	(sleep 15) (rasterizer_blur 2) (cinematic_unstash_enemies)
	(cinematic_fade_from_white_bars) (cinematic_show_letterbox true)
	(chapter_intro_stubby)
	
	(sleep 190)
	
	(print "dialog - remind the player about camouflage")
	
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0080_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0080_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0080_soc") subtitle_time) subtitle_time_add))
	(sleep (+ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0080_soc") 80))
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0090_soc" none Audio_gain_shipmaster Audio_filter_shipmaster)
	(cinematic_subtitle l05_0090_soc (+ (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0090_soc") subtitle_time) subtitle_time_add))
	(sleep (+ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0090_soc") 30))
)

(script static void intro
	(cinematic_enable_ambience_details false)

	(sound_class_set_gain projectile_detonation 0 0)
	(cinematic_snap_to_black)
		
	(sleep_until dig_ready)
	(cinematic_enable_ambience_details true)
	
	(print "playing new intro (switch the names of intro and intro_test in cinemtics.hsc to change this")
	
	(camera_control 1)	(wake intro_cam_01)
)

(script static void intro_old
	(cinematic_snap_to_black)
	
	(sleep_until dig_ready)
	(print "playing old intro (switch the names of intro and intro_test in cinemtics.hsc to change this")
	
	(if (cinematic_skip_start)
		(begin
			(camera_set intro_pan_1 0) (camera_set intro_pan_2 200)
			
			(object_teleport (list_get (players) 0) player_1_intro_pause)
			(object_create_anew dervish)
			(unit_add_equipment dervish "player starting profile_0" true true)
			
			(sleep 60)
			
			(print "the devish lands in an insertion pod")
			(fade_in 0 0 0 60)
			(sleep 170)
			
			(camera_set intro_push_1 0)		(camera_set intro_push_2 180)
			(print "the pod opens, and the dervish emerges")
			(sleep 180)
			
			(guntower_center_play_intro)
			
			(sleep 20)
			
			(camera_set intro_rev_pan_1 0)	(camera_set intro_rev_pan_2 120)
			(print "heretic artillery-fire shoots skyward")
			(sleep 180)
			
			;(camera_set intro_close_1 0)	(camera_set intro_close_2 90)
			;(print "the dervish readies his weapon")	
			;(sleep 60)
			
			(cinematic_fade_to_white)
			(sleep 30)
			
			(object_teleport (list_get (players) 0) player_1_intro_start)
			(object_destroy dervish)
		)
	)
	
	(cinematic_skip_stop)
	(set opening_cinematic false)
	
	(sleep 15)
	(rasterizer_blur 2)
	(cinematic_fade_from_white_bars)	(cinematic_show_letterbox true)
	(chapter_intro_stubby)
)
	
;-MAIN & SHORTCUTS--------------------------------------------------------------

;(script static void expunge	(object_destroy_all)	(ai_erase_all))


;--cool-bomb-stuff-by-neo-do-not-touch------------------------------------------

(script static void bomb_hud
	(print "start bomb hud") ;(cinematic_set_title_delayed bomb_frame 0)
	(sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_arm" none 1.0)
	(cinematic_set_title_delayed bomb_4 0) (sleep 30) (sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_tick" none 1.0)
	(cinematic_set_title_delayed bomb_3 0) (sleep 30) (sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_tick" none 1.0)
	(cinematic_set_title_delayed bomb_2 0) (sleep 30) (sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_tick" none 1.0)
	(cinematic_set_title_delayed bomb_1 0) (sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_boom" none 1.0) (sleep 30) 
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0) (sleep 4)
	(cinematic_set_title_delayed bomb_0 0)
)

(script dormant bomb_primed_0 (print "wake bomb hud, pt.2") (bomb_hud))
(script dormant bomb_primed_1 (print "wake bomb hud, pt.2") (bomb_hud))
(script dormant bomb_primed_2 (print "wake bomb hud, pt.2") (bomb_hud))
(script dormant bomb_primed_3 (print "wake bomb hud, pt.2") (bomb_hud))
(script dormant bomb_primed_4 (print "wake bomb hud, pt.2") (bomb_hud))
(script dormant bomb_primed_5 (print "wake bomb hud, pt.2") (bomb_hud))

(script static void bomb_primer_0 (print "wake bomb hud") (wake bomb_primed_0)
	(sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_plant" 0guntower_center_bomb 1.0))
(script static void bomb_primer_1 (print "wake bomb hud") (wake bomb_primed_1)
	(sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_plant" 0guntower_left_bomb 1.0))
(script static void bomb_primer_2 (print "wake bomb hud") (wake bomb_primed_2)
	(sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_plant" 0guntower_right_bomb 1.0))
(script static void bomb_primer_3 (print "wake bomb hud") (wake bomb_primed_3)
	(sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_plant" none 1.0))
(script static void bomb_primer_4 (print "wake bomb hud") (wake bomb_primed_4)
	(sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_plant" none 1.0))
(script static void bomb_primer_5 (print "wake bomb hud") (wake bomb_primed_5)
	(sound_impulse_start "digsite\sound\weapons\plasma_charge\alien_bomb_plant" none 1.0))