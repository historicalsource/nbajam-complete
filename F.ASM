dunklay_t		;2,3,4,5 directions
	.word	DFLGS
	.long	seq_stand
	.long	#DD,#dzl2a_l,#dzl3a_l,#dzl4a_l
	.long	#dzl5a_l,#dzl4a_l,#dzl3a_l,#dzl2a_l

#2
	WLW	1,w2fgrl1,F
	WLLW	-1,seq_strtdunk,w2fgrl3,>15
	WLW	4,w2fgrl1,F
	WLW	4,w2fgrl2,F
	WLW	1,w2fgrl3,F
	WLW	-1,seq_slamball,0
	WLW	50,w2fgrl3,F
	WLW	5,w2fgrl4,F
	WLW	-1,seq_newdir,1*16
#1	W0
#3
	WLW	1,w3fgrl2,F
	WLLW	-1,seq_strtdunk,w3fgrl4,>15
	WLW	4,w3fgrl2,F
	WLW	4,w3fgrl3,F
	WLW	1,w3fgrl4,F
	WLW	-1,seq_slamball,0
	WLW	4,w3fgrl4,F
	WLW	50,w3fgrl5,F
	WLW	4,w3fgrl6,F
	WLW	-1,seq_newdir,2*16
	W0
#4
	WLW	1,w4fgrl1,F
	WLLW	-1,seq_strtdunk,w4fgrl3,>15
	WLW	4,w4fgrl1,F
	WLW	4,w4fgrl2,F
	WLW	1,w4fgrl3,F
	WLW	-1,seq_slamball,0
	WLW	50,w4fgrl3,F
	WLW	-1,seq_newdir,3*16
	W0
#5
	WLW	1,w5fgrl1,F
	WLLW	-1,seq_strtdunk,w5fgrl3,>15
	WLW	4,w5fgrl1,F
	WLW	4,w5fgrl2,F
	WLW	1,w5fgrl3,F
	WLW	-1,seq_slamball,0
	WLW	50,w5fgrl3,F
	WLW	5,w5fgrl4,F
	WLW	-1,seq_newdir,4*16
	W0

