;	DIGSITE, ALPHA MOON DIALOG

(script static void v0060
	(print "Elite (Radio): Commander, we are under siege!")
	(sound_impulse_start_effect "digsite\sound\dialog\alphamoon\level\l05_0060_elr" none 1.0 covy_radio)
	;(cinematic_subtitle l05_0060_elr (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0060_elr") subtitle_time))
)

(script stub void l05_0060
	(sound_impulse_start "digsite\sound\dialog\alphamoon\level\l05_0060_elr" none 1.0)
	;(cinematic_subtitle l05_0060_elr (/ (sound_impulse_time "digsite\sound\dialog\alphamoon\level\l05_0060_elr") subtitle_time))
)