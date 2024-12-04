;	DIGSITE, ALPHA MOON MUSIC (by Neo Te Aika)
;	This is the old, OLD music scripts i started in 2022
; 	Had to cut most of what's in here bc no more forerunner tank, sorryyyy.

(script dormant nusic_1
	(print "neo music 1 start")
	(sound_looping_start "digsite\sound\music\am\am_01" none 1)
	
	(sleep 960)

	(print "neo music 1 stop (natural)")
	(sound_looping_stop "digsite\sound\music\am\am_01")

)

(script dormant nusic_3w
	(sound_looping_stop "digsite\sound\music\am\am_01")
	(print "omg, is that a cool ancient structure in the distance??? [neo music 3 (wreckage stinger) start]")
	(sound_impulse_start digsite\sound\music\am\88_wreckage\alt_out none 1)

)

(script startup nusic
	(print "neo's music script active")
	(sleep_until 
		(volume_test_objects nusic1 (players))
	)
	(print "waking nusic_1...")
	(wake nusic_1)
	(sleep_until 
        (or
            (volume_test_objects nusic3w_l (players))
            (volume_test_objects nusic3w_r (players))
        )
    )
	(print "waking nusic_3w...")
	(wake nusic_3w)
)