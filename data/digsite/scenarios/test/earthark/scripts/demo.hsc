
(script startup main
	(fade_in 0 0 0 0)
	(sleep_until (volume_test_objects tv_start (players)) 3)
	(sleep 90)
	(damage_object "digsite\scenarios\objects\test\earthark_petals\effects\camera_shake" (player0))
	(sound_impulse_start digsite\sound\ambience\device_machines\earth_ark_details\earth_ark_sub "none" 1)
	(sleep 30)
	(device_group_set none petals 1)
	;(device_group_set_immediate petals 1)
) 
