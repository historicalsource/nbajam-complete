**************************************************************
*
* Software:		Shawn Liptak, Mark Turmell
* Initiated:		10/8/92
*
* Modified:		Shawn Liptak, 10/8/92	-Split from BB.asm
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 11/24/92 19:40
**************************************************************
	.file	"plyrseq.asm"
	.title	"basketball plyr sequence code"
	.width	132
	.option	b,d,l,t
	.mnolist


	.include	"mproc.equ"
	.include	"disp.equ"
	.include	"sys.equ"
	.include	"imgtbl.glo"
	.include	"imgtbl2.glo"
	.include	"game.equ"
	.include	"shawn.hdr"
	.asg		1,SEQT
	.include	"plyr.equ"
	.include	"plyrseq.tbl"
	.include	"plyrseq2.tbl"



;sounds external

land_snd	.word	>fd89,40,>811d,0	;Body land on grnd
oof_snd		.word	>f387,40,>815b,0	;Oof push
ungh_snd	.word	>f387,40,>815c,0	;Ungh push
boo_snd		.word	>f894,180,>8150,0	;Boo
swipe_snd	.word	>f484,>4,>8119,0	;swipe at ball
;Turmell
push1_snd	.word	>fd85,15,>8160,0	;Push ugh
push2_snd	.word	>fd85,15,>8163,0	;Push ugh
push3_snd	.word	>fd85,15,>816a,0	;Push ugh
fall1_snd	.word	>fd86,20,>8164,0	;Fall ugh
fall2_snd	.word	>fd86,20,>8166,0	;Fall ugh
fall3_snd	.word	>fd86,20,>8170,0	;Fall ugh



;symbols externally defined

	.ref	plyr_pass,plyr_shoot
	.ref	seq_newdir
	.ref	seq_slamball
	.ref	seq_strtdunk
	.ref	seq_jump
	.ref	seq_resetseq
	.ref	seq_stand
	.ref	seq_stealstand
	.ref	seq_block,seq_push,seq_elbo,seq_rebounda
	.ref	seq_snd


;symbols defined in this file

	.def	w3run1
	.def	w3desp1

;uninitialized ram definitions



;equates for this file

M_YF	.equ	>8000	;Y free (OFLAGS)


	.text


********************************


	.asg	M_WRNONZ,F
	.asg	M_WRNONZ|M_FLIPH,FF


stnd_t	.word	EASYSTAG_M
	.long	0
	.long	#stnd1_l,#stnd2_l,#stnd3_l,#stnd4_l
	.long	#stnd5_l,#stnd4_l,#stnd3_l,#stnd2_l

#stnd1_l
	WLW	10,w1stand,F
	W0
#stnd2_l
	WLW	10,w2stand,F
	W0
#stnd3_l
	WLW	10,w3stand,F
	W0
#stnd4_l
	WLW	10,w4stand,F
	W0
#stnd5_l
	WLW	10,w5stand,F
	W0


stnddef_t
	.word	EASYSTAG_M
	.long	0
	.long	#sdef1_l,#sdef2_l,#sdef3_l,#sdef4_l
	.long	#sdef5_l,#sdef4_l,#sdef3_l,#sdef2_l


#sdef1_l
	WLW	10,w1dfcr1,F
	W0
#sdef2_l
	WLW	10,w2dfcr1,F
	W0
#sdef3_l
	WLW	10,w3dfcr1,F
	W0
#sdef4_l
	WLW	10,w4dfcr1,F
	W0
#sdef5_l
	WLW	10,w5dfcr1,F
	W0


stndwb_t
	.word	EASYSTAG_M|NOMV_M
	.long	0
	.long	#stndwb1_l,#stndwb2_l,#stndwb3_l,#stndwb4_l
	.long	#stndwb5_l,#stndwb4_l,#stndwb3_l,#stndwb2_l

#stndwb1_l
	WLW	10,w1ohp1,F
	W0
#stndwb2_l
	WLW	10,w2stwbl,F
	W0
#stndwb3_l
	WLW	10,w3stwbl,F
	W0
#stndwb4_l
	WLW	10,w4stwbl,F
	W0
#stndwb5_l
	WLW	10,w5stwbl,F
	W0


stnddrib_t
	.word	EASYSTAG_M|DRIBBLE_M
	.long	0
	.long	#stndd1_l,#stndd2_l,#stndd3_l,#stndd4_l
	.long	#stndd5_l,#stndd4_l,#stndd3_l,#stndd2_l

#stndd1_l
	WLW	1,w1dst1,F
	WLW	4,w1dst1,F|M_YF
	WLW	5,w1dst2,F
	WLW	5,w1dst3,F
	WLW	5,w1dst4,F
	WLW	5,w1dst5,F
	WLW	5,w1dst6,F
	W0
#stndd2_l
	WLW	1,w2stand,F
	WLW	29,w2stand,F|M_YF
	W0
#stndd3_l
	WLW	1,w3dst1,F
	WLW	4,w3dst1,F|M_YF
	WLW	5,w3dst2,F
	WLW	5,w3dst3,F
	WLW	5,w3dst4,F
	WLW	5,w3dst5,F
	WLW	5,w3dst6,F
	W0
#stndd4_l
	WLW	1,w4dst1,F
	WLW	4,w4dst1,F|M_YF
	WLW	5,w4dst2,F
	WLW	5,w4dst3,F
	WLW	5,w4dst4,F
	WLW	5,w4dst5,F
	WLW	5,w4dst6,F
	W0
#stndd5_l
	WLW	1,w5dst1,F
	WLW	4,w5dst1,F|M_YF
	WLW	5,w5dst2,F
	WLW	5,w5dst3,F
	WLW	5,w5dst4,F
	WLW	5,w5dst5,F
	WLW	5,w5dst6,F
	W0


stnddribdef_t
	.word	EASYSTAG_M|DRIBBLE_M
	.long	0
	.long	#sdd1_l,#sdd1_l,#sdd3_l,#sdd4_l
	.long	#sdd5_l,#sdd4_l,#sdd3_l,#sdd1_l
#sdd1_l
	WLW	1,w1drcr1,F
	WLW	2,w1drcr1,F|M_YF
	WLW	3,w1drcr2,F
	WLW	3,w1drcr3,F
	WLW	3,w1drcr4,F
	WLW	3,w1drcr5,F
	WLW	3,w1drcr6,F
	W0
#sdd3_l
	WLW	1,w3drcr1,F
	WLW	4,w3drcr1,F|M_YF
	WLW	5,w3drcr2,F
	WLW	4,w3drcr3,F
	WLW	4,w3drcr4,F
	W0
#sdd4_l
	WLW	1,w4drcr1,F
	WLW	3,w4drcr1,F|M_YF
	WLW	4,w4drcr2,F
	WLW	4,w4drcr3,F
	WLW	3,w4drcr4,F
	WLW	3,w4drcr5,F
	W0
#sdd5_l
	WLW	1,w5drcr1,F
	WLW	2,w5drcr1,F|M_YF
	WLW	3,w5drcr2,F
	WLW	3,w5drcr3,F
	WLW	3,w5drcr4,F
	WLW	3,w5drcr5,F
	WLW	3,w5drcr6,F
	W0

#*
run_t
	.word	0
	.long	0
	.long	#1,#2,#3,#4,#5,#4,#3,#2
	.asg	4,N
#1
	WLW	N,w1run1,F
	WLW	N,w1run2,F
	WLW	N,w1run3,F
	WLW	N,w1run4,F
	WLW	N,w1run5,F
	WLW	N,w1run6,F
	WLW	N,w1run7,F
	WLW	N,w1run8,F
	W0
#2
	WLW	N,w2run1,F
	WLW	N,w2run2,F
	WLW	N,w2run3,F
	WLW	N,w2run4,F
	WLW	N,w2run5,F
	WLW	N,w2run6,F
	WLW	N,w2run7,F
	WLW	N,w2run8,F
	W0
#3
	WLW	N,w3run1,F
	WLW	N,w3run2,F
	WLW	N,w3run3,F
	WLW	N,w3run4,F
	WLW	N,w3run5,F
	WLW	N,w3run6,F
	WLW	N,w3run7,F
	WLW	N,w3run8,F
	W0
#4
	WLW	N,w4run1,F
	WLW	N,w4run2,F
	WLW	N,w4run3,F
	WLW	N,w4run4,F
	WLW	N,w4run5,F
	WLW	N,w4run6,F
	WLW	N,w4run7,F
	WLW	N,w4run8,F
	W0
#5
	WLW	N,w5run1,F
	WLW	N,w5run2,F
	WLW	N,w5run3,F
	WLW	N,w5run4,F
	WLW	N,w5run5,F
	WLW	N,w5run6,F
	WLW	N,w5run7,F
	WLW	N,w5run8,F
	W0
#*
runturb_t
	.word	0
	.long	0
	.long	#1,#2,#3,#4,#5,#4,#3,#2
	.asg	3,N
#1
	WLW	N,w1run1,F
	WLW	N,w1run2,F
	WLW	N,w1run3,F
	WLW	N,w1run4,F
	WLW	N,w1run5,F
	WLW	N,w1run6,F
	WLW	N,w1run7,F
	WLW	N,w1run8,F
	W0
#2
	WLW	N,w2run1,F
	WLW	N,w2run2,F
	WLW	N,w2run3,F
	WLW	N,w2run4,F
	WLW	N,w2run5,F
	WLW	N,w2run6,F
	WLW	N,w2run7,F
	WLW	N,w2run8,F
	W0
#3
	WLW	N,w3run1,F
	WLW	N,w3run2,F
	WLW	N,w3run3,F
	WLW	N,w3run4,F
	WLW	N,w3run5,F
	WLW	N,w3run6,F
	WLW	N,w3run7,F
	WLW	N,w3run8,F
	W0
#4
	WLW	N,w4run1,F
	WLW	N,w4run2,F
	WLW	N,w4run3,F
	WLW	N,w4run4,F
	WLW	N,w4run5,F
	WLW	N,w4run6,F
	WLW	N,w4run7,F
	WLW	N,w4run8,F
	W0
#5
	WLW	N,w5run1,F
	WLW	N,w5run2,F
	WLW	N,w5run3,F
	WLW	N,w5run4,F
	WLW	N,w5run5,F
	WLW	N,w5run6,F
	WLW	N,w5run7,F
	WLW	N,w5run8,F
	W0

#*
rundrib_t
	.word	DRIBBLE_M
	.long	0
	.long	#1,#2,#3,#4,#5,#4,#3,#2
	.asg	4,N
#1
	WLW	1,w1drun1,F
	WLW	N-1,w1drun1,F|M_YF
	WLW	N,w1drun2,F
	WLW	N,w1drun3,F
	WLW	N,w1drun4,F
	WLW	N,w1drun5,F
	WLW	N,w1drun6,F
	WLW	N,w1drun7,F
	WLW	N,w1drun8,F
	W0
#2
	WLW	1,w2drun1,F
	WLW	N-1,w2drun1,F|M_YF
	WLW	N,w2drun2,F
	WLW	N,w2drun3,F
	WLW	N,w2drun4,F
	WLW	N,w2drun5,F
	WLW	N,w2drun6,F
	WLW	N,w2drun7,F
	WLW	N,w2drun8,F
	W0
#3
	WLW	1,w3drun1,F
	WLW	N-1,w3drun1,F|M_YF
	WLW	N,w3drun2,F
	WLW	N,w3drun3,F
	WLW	N,w3drun4,F
	WLW	N,w3drun5,F
	WLW	N,w3drun6,F
	WLW	N,w3drun7,F
	WLW	N,w3drun8,F
	W0
#4
	WLW	1,w4drun1,F
	WLW	N-1,w4drun1,F|M_YF
	WLW	N,w4drun2,F
	WLW	N,w4drun3,F
	WLW	N,w4drun4,F
	WLW	N,w4drun5,F
	WLW	N,w4drun6,F
	WLW	N,w4drun7,F
	WLW	N,w4drun8,F
	W0
#5
	WLW	1,w5drun1,F
	WLW	N-1,w5drun1,F|M_YF
	WLW	N,w5drun2,F
	WLW	N,w5drun3,F
	WLW	N,w5drun4,F
	WLW	N,w5drun5,F
	WLW	N,w5drun6,F
	WLW	N,w5drun7,F
	WLW	N,w5drun8,F
	W0
#*
rundribturb_t
	.word	DRIBBLE_M
	.long	0
	.long	#1,#2,#3,#4,#5,#4,#3,#2
	.asg	3,N
#1
	WLW	1,w1drun1,F
	WLW	N-1,w1drun1,F|M_YF
	WLW	N,w1drun2,F
	WLW	N,w1drun3,F
	WLW	N,w1drun4,F
	WLW	N,w1drun5,F
	WLW	N,w1drun6,F
	WLW	N,w1drun7,F
	WLW	N,w1drun8,F
	W0
#2
	WLW	1,w2drun1,F
	WLW	N-1,w2drun1,F|M_YF
	WLW	N,w2drun2,F
	WLW	N,w2drun3,F
	WLW	N,w2drun4,F
	WLW	N,w2drun5,F
	WLW	N,w2drun6,F
	WLW	N,w2drun7,F
	WLW	N,w2drun8,F
	W0
#3
	WLW	1,w3drun1,F
	WLW	N-1,w3drun1,F|M_YF
	WLW	N,w3drun2,F
	WLW	N,w3drun3,F
	WLW	N,w3drun4,F
	WLW	N,w3drun5,F
	WLW	N,w3drun6,F
	WLW	N,w3drun7,F
	WLW	N,w3drun8,F
	W0
#4
	WLW	1,w4drun1,F
	WLW	N-1,w4drun1,F|M_YF
	WLW	N,w4drun2,F
	WLW	N,w4drun3,F
	WLW	N,w4drun4,F
	WLW	N,w4drun5,F
	WLW	N,w4drun6,F
	WLW	N,w4drun7,F
	WLW	N,w4drun8,F
	W0
#5
	WLW	1,w5drun1,F
	WLW	N-1,w5drun1,F|M_YF
	WLW	N,w5drun2,F
	WLW	N,w5drun3,F
	WLW	N,w5drun4,F
	WLW	N,w5drun5,F
	WLW	N,w5drun6,F
	WLW	N,w5drun7,F
	WLW	N,w5drun8,F
	W0


walkfdef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wfdef1_l,#wfdef2_l,#wfdef3_l,#wfdef4_l
	.long	#wfdef5_l,#wfdef4_l,#wfdef3_l,#wfdef2_l

#wfdef1_l
	WLW	4,w1defwd1,F
	WLW	4,w1defwd6,F
	WLW	4,w1defwd5,F
	WLW	4,w1defwd4,F
	WLW	4,w1defwd3,F
	WLW	4,w1defwd2,F
	W0
#wfdef2_l
	WLW	4,w2defwd1,F
	WLW	4,w2defwd6,F
	WLW	4,w2defwd5,F
	WLW	4,w2defwd4,F
	WLW	4,w2defwd3,F
	WLW	4,w2defwd2,F
	W0
#wfdef3_l
	WLW	4,w3defwd1,F
	WLW	4,w3defwd6,F
	WLW	4,w3defwd5,F
	WLW	4,w3defwd4,F
	WLW	4,w3defwd3,F
	WLW	4,w3defwd2,F
	W0
#wfdef4_l
	WLW	4,w4defwd1,F
	WLW	4,w4defwd6,F
	WLW	4,w4defwd5,F
	WLW	4,w4defwd4,F
	WLW	4,w4defwd3,F
	WLW	4,w4defwd2,F
	W0
#wfdef5_l
	WLW	4,w5defwd1,F
	WLW	4,w5defwd6,F
	WLW	4,w5defwd5,F
	WLW	4,w5defwd4,F
	WLW	4,w5defwd3,F
	WLW	4,w5defwd2,F
	W0


walkbdef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wbdef1_l,#wbdef2_l,#wbdef3_l,#wbdef4_l
	.long	#wbdef5_l,#wbdef4_l,#wbdef3_l,#wbdef2_l

#wbdef1_l
	WLW	4,w1defwd1,F
	WLW	4,w1defwd2,F
	WLW	4,w1defwd3,F
	WLW	4,w1defwd4,F
	WLW	4,w1defwd5,F
	WLW	4,w1defwd6,F
	W0
#wbdef2_l
	WLW	4,w2defwd1,F
	WLW	4,w2defwd2,F
	WLW	4,w2defwd3,F
	WLW	4,w2defwd4,F
	WLW	4,w2defwd5,F
	WLW	4,w2defwd6,F
	W0
#wbdef3_l
	WLW	4,w3defwd1,F
	WLW	4,w3defwd2,F
	WLW	4,w3defwd3,F
	WLW	4,w3defwd4,F
	WLW	4,w3defwd5,F
	WLW	4,w3defwd6,F
	W0
#wbdef4_l
	WLW	4,w4defwd1,F
	WLW	4,w4defwd2,F
	WLW	4,w4defwd3,F
	WLW	4,w4defwd4,F
	WLW	4,w4defwd5,F
	WLW	4,w4defwd6,F
	W0
#wbdef5_l
	WLW	4,w5defwd1,F
	WLW	4,w5defwd2,F
	WLW	4,w5defwd3,F
	WLW	4,w5defwd4,F
	WLW	4,w5defwd5,F
	WLW	4,w5defwd6,F
	W0


walkldef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wldef1_l,#wldef2_l,#wldef3_l,#wldef4_l
	.long	#wldef5_l,#wldef4_l,#wldef3_l,#wldef2_l

#wldef1_l
	WLW	4,w1dfcr1,F
	WLW	4,w1dfcr2,F
	WLW	4,w1dfcr3,F
	WLW	4,w1dfcr4,F
	WLW	4,w1dfcr5,F
	WLW	4,w1dfcr6,F
	W0
#wldef2_l
	WLW	4,w2dfcr1,F
;	WLW	4,w2dfcr6,F
	WLW	4,w2dfcr5,F
	WLW	4,w2dfcr4,F
	WLW	4,w2dfcr3,F
	WLW	4,w2dfcr2,F
	W0
#wldef3_l
	WLW	4,w3dfcr1,F
	WLW	4,w3dfcr6,F
	WLW	4,w3dfcr5,F
	WLW	4,w3dfcr4,F
	WLW	4,w3dfcr3,F
	WLW	4,w3dfcr2,F
	W0
#wldef4_l
	WLW	4,w4dfcr1,F
	WLW	4,w4dfcr6,F
	WLW	4,w4dfcr5,F
	WLW	4,w4dfcr4,F
	WLW	4,w4dfcr3,F
	WLW	4,w4dfcr2,F
	W0
#wldef5_l
	WLW	4,w5dfcr1,F
	WLW	4,w5dfcr6,F
	WLW	4,w5dfcr5,F
	WLW	4,w5dfcr4,F
	WLW	4,w5dfcr3,F
	WLW	4,w5dfcr2,F
	W0

walkrdef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wrdef1_l,#wrdef2_l,#wrdef3_l,#wrdef4_l
	.long	#wrdef5_l,#wrdef4_l,#wrdef3_l,#wrdef2_l

#wrdef1_l
	WLW	4,w1dfcr1,F
	WLW	4,w1dfcr6,F
	WLW	4,w1dfcr5,F
	WLW	4,w1dfcr4,F
	WLW	4,w1dfcr3,F
	WLW	4,w1dfcr2,F
	W0
#wrdef2_l
	WLW	4,w2dfcr1,F
	WLW	4,w2dfcr2,F
	WLW	4,w2dfcr3,F
	WLW	4,w2dfcr4,F
	WLW	4,w2dfcr5,F
;	WLW	4,w2dfcr6,F
	W0
#wrdef3_l
	WLW	4,w3dfcr1,F
	WLW	4,w3dfcr2,F
	WLW	4,w3dfcr3,F
	WLW	4,w3dfcr4,F
	WLW	4,w3dfcr5,F
	WLW	4,w3dfcr6,F
	W0
#wrdef4_l
	WLW	4,w4dfcr1,F
	WLW	4,w4dfcr2,F
	WLW	4,w4dfcr3,F
	WLW	4,w4dfcr4,F
	WLW	4,w4dfcr5,F
	WLW	4,w4dfcr6,F
	W0
#wrdef5_l
	WLW	4,w5dfcr1,F
	WLW	4,w5dfcr2,F
	WLW	4,w5dfcr3,F
	WLW	4,w5dfcr4,F
	WLW	4,w5dfcr5,F
	WLW	4,w5dfcr6,F
	W0


#*
block_t
	.word	NOJUMP_M|DRIFT_M|BLOCKREB_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#5,#4,#3,#2

#1
	WLW	3,w1blok1,F
	WLW	3,w1blok2,F
	WLL	-1,seq_block,w1blok3
	WLW	99,w1blok3,F
	W0
#2
	WLW	3,w2blok1,F
	WLW	3,w2blok2,F
	WLL	-1,seq_block,w2blok3
	WLW	99,w2blok3,F
	W0
#3
	WLW	3,w3blok1,F
	WLW	3,w3blok2,F
	WLL	-1,seq_block,w3blok3
	WLW	99,w3blok3,F
	W0
#4
	WLW	3,w4blok1,F
	WLW	3,w4blok2,F
	WLL	-1,seq_block,w4blok3
	WLW	99,w4blok3,F
	W0
#5
	WLW	3,w5blok1,F
	WLW	3,w5blok2,F
	WLL	-1,seq_block,w5blok3
	WLW	99,w5blok3,F
	W0
#*
blockrej_t
	.word	NOJUMP_M|DRIFT_M|BLOCKREB_M
	.long	seq_stand
	.long	#2,#2,#3,#3,#3,#3,#3,#2
#2
	WLW	2,w2rej1,F
	WLW	2,w2rej2,F
	WLW	2,w2rej3,F
	WLL	-1,seq_block,w2rej6
	WLW	20,w2rej4,F
	WLL	-1,seq_snd,swipe_snd
	WLW	6,w2rej5,F
	WLW	8,w2rej6,F
	WLW	4,w2rej7,F
	WLW	77,w2rej8,F
	WLW	3,w2rej9,F		;Land
	W0
#3
	WLW	5,w3rej1,F
	WLL	-1,seq_block,w3rej4
	WLW	20,w3rej2,F
	WLL	-1,seq_snd,swipe_snd
	WLW	6,w3rej3,F
	WLW	8,w3rej4,F
	WLW	3,w3rej5,F
	WLW	3,w3rej6,F
	WLW	77,w3rej7,F
	WLW	3,w3rej8,F
	WLW	3,w3rej9,F
	W0

#*
rebound_t
	.word	NOJUMP_M|DRIFT_M|BLOCKREB_M|NOSTEAL_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#4,#4,#3,#2
#1
	WLW	6,w1blok1,F
	WLL	-1,seq_block,w1reb3
	WLW	3,w1reb1,F
	WLW	27,w1reb2,F
	WLW	77,w1reb3,F
	WLW	3,w1reb4,F		;Land
	WLW	3,w1reb5,F
	W0
#2
	WLW	2,w2blok1,F
	WLW	2,w2reb1,F
	WLW	2,w2reb2,F
	WLL	-1,seq_block,w2reb5
	WLW	27,w2reb3,F
	WLW	3,w2reb4,F
	WLW	77,w2reb5,F
	WLW	3,w2reb6,F
	WLW	3,w2reb7,F
	W0
#3
	WLW	3,w3blok1,F
	WLW	3,w3reb1,F
	WLL	-1,seq_block,w3reb4
	WLW	27,w3reb2,F
	WLW	3,w3reb3,F
	WLW	77,w3reb4,F
	WLW	3,w3reb5,F
	W0
#4
	WLW	3,w4blok1,F
	WLW	3,w4reb1,F
	WLL	-1,seq_block,w4reb4
	WLW	27,w4reb2,F
	WLW	3,w4reb3,F
	WLW	77,w4reb4,F
	WLW	3,w4reb5,F
	WLW	3,w4reb6,F
	W0
#*
rebounda_t
	.word	NOJUMP_M|DRIFT_M|BLOCKREB_M|NOSTEAL_M|NOCOLLP_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#4,#4,#3,#2
#1
	WLW	5,w1blok1,F
	WLL	-1,seq_rebounda,w1reb3
	WLW	5,w1reb1,F
	WLW	14,w1reb2,F
	WLW	77,w1reb3,F
	WLW	3,w1reb4,F		;Land
	WLW	3,w1reb5,F
	W0
#2
	WLW	1,w2blok1,F
	WLW	2,w2reb1,F
	WLW	2,w2reb2,F
	WLL	-1,seq_rebounda,w2reb5
	WLW	16,w2reb3,F
	WLW	3,w2reb4,F
	WLW	77,w2reb5,F
	WLW	3,w2reb6,F
	WLW	3,w2reb7,F
	W0
#3
	WLW	2,w3blok1,F
	WLW	3,w3reb1,F
	WLL	-1,seq_rebounda,w3reb4
	WLW	16,w3reb2,F
	WLW	3,w3reb3,F
	WLW	77,w3reb4,F
	WLW	3,w3reb5,F
	W0
#4
	WLW	2,w4blok1,F
	WLW	3,w4reb1,F
	WLL	-1,seq_rebounda,w4reb4
	WLW	16,w4reb2,F
	WLW	3,w4reb3,F
	WLW	77,w4reb4,F
	WLW	3,w4reb5,F
	WLW	3,w4reb6,F
	W0

#*
shoot_t
	.word	NOJUMP_M|SHOOT_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#5,#4,#3,#2

	.asg	5,N
#1
	WLW	N,w1js1,F
	WLW	N,w1js2,F
	WLW	N,w1js3,F
	WL	-1,seq_jump
	WLW	77,w1js4,F
	WLW	77,w1js5,F
	WLW	4,w1js2,F
	WLW	3,w1js1,F
	W0
#2
	WLW	N,w2js1,F
	WLW	N,w2js2,F
	WLW	N,w2js3,F
	WL	-1,seq_jump
	WLW	77,w2js4,F
	WLW	77,w2js5,F
	WLW	3,w2js4,F
	WLW	3,w2js3,F
	WLW	3,w2js2,F
	WLW	2,w2js1,F
	W0
#3
	WLW	N,w3js1,F
	WLW	N,w3js2,F
	WLW	N,w3js3,F
	WL	-1,seq_jump
	WLW	77,w3js4,F
	WLW	3,w3js4,F
	WLW	77,w3js5,F
	WLW	3,w3js4,F
	WLW	3,w3js3,F
	WLW	3,w3js2,F
	WLW	2,w3js1,F
	W0
#4
	WLW	N,w4js1,F
	WLW	N,w4js2,F
	WLW	N,w4js3,F
	WL	-1,seq_jump
	WLW	77,w4js4,F
	WLW	3,w4js4,F
	WLW	77,w4js5,F
	WLW	3,w4js4,F
	WLW	3,w4js3,F
	WLW	3,w4js2,F
	WLW	2,w4js1,F
	W0
#5
	WLW	N,w5js1,F
	WLW	N,w5js2,F
	WLW	N,w5js3,F
	WL	-1,seq_jump
	WLW	77,w5js4,F
	WLW	77,w5js5,F
	WLW	3,w5js4,F
	WLW	3,w5js3,F
	WLW	3,w5js2,F
	WLW	2,w5js1,F
	W0

#*
shootdesp_t
	.word	NOJUMP_M|SHOOT_M
	.long	seq_stand
	.long	#3,#3,#3,#3,#3,#3,#3,#3
#3
	WLW	4,w3desp1,F
	WL	-1,seq_jump
	WLW	50,w3desp2,F
	WLW	50,w3desp3,F
	WLW	3,w3desp3,F	;Land
	WLW	3,w3desp4,F
	WLW	3,w3desp5,F
	WLW	3,w3desp6,F
	W0

#*
shootdesp2_t
	.word	NOJUMP_M
	.long	seq_stand
	.long	#3,#3,#3,#3,#3,#3,#3,#3
#3
	WLW	4,T1DESP1,F
	WLW	4,T1DESP2,F
	WLW	4,T1DESP3,F
	WLW	4,T1DESP4,F
	WL	-1,seq_jump
	WLW	4,T1DESP5,F
	WL	-1,plyr_shoot
	WLW	4,T1DESP6,F
	WLW	66,T1DESP7,F
	WLW	4,T1DESP8,F
	WLW	4,T1DESP9,F
	W0

#*
shootdesp3_t
	.word	NOJUMP_M|SHOOT_M
	.long	seq_stand
	.long	#3,#3,#3,#3,#3,#3,#3,#3
#3
	WLW	4,T2DESP1,F
	WLW	4,T2DESP2,F
	WL	-1,seq_jump
	WLW	12h,T2DESP3,F
	WLW	62h,T2DESP4,F
	WLW	28,T2DESP5,F
	WLW	4,T2DESP6,F
	W0


#*
pass_t
	.word	PASS_M|NOMV_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#5,#4,#3,#2
#1
	WLW	4,w1cp1,F
	W0
#2
	WLW	4,w2cp1,F
	W0
#3
	WLW	4,w3cp1,F
	W0
#4
	WLW	4,w4cp1,F
	W0
#5
	WLW	4,w5cp1,F
	W0

passs_t
	.word	PASS_M
	.long	seq_stand
	.long	#passs1_l,#passs2_l,#passs3_l,#passs4_l
	.long	#passs5_l,#passs4_l,#passs3_l,#passs2_l
	.asg	3,N
#passs1_l
	WLW	N,w1cp1,F
	WLW	N,w1cp2,F
	WL	-1,plyr_pass
	WLW	4,w1cp1,F
	W0
#passs2_l
	WLW	N,w2cp1,F
	WLW	N,w2cp2,F
	WL	-1,plyr_pass
	WLW	4,w2cp1,F
	W0
#passs3_l
	WLW	N,w3cp1,F
	WLW	N,w3cp2,F
	WL	-1,plyr_pass
	WLW	4,w3cp1,F
	W0
#passs4_l
	WLW	N,w4cp1,F
	WLW	N,w4cp2,F
	WL	-1,plyr_pass
	WLW	4,w4cp1,F
	W0
#passs5_l
	WLW	N,w5cp1,F
	WLW	N,w5cp2,F
	WL	-1,plyr_pass
	WLW	4,w5cp1,F
	W0

passc_t
	.word	PASS_M
	.long	seq_stand
	.long	#passc1_l,#passc2_l,#passc3_l,#passc4_l
	.long	#passc5_l,#passc4_l,#passc3_l,#passc2_l
	.asg	4,N
#passc1_l
	WLW	N,w1cp1,F
	WLW	N,w1cp2,F
	WLW	N,w1cp3,F
	WL	-1,plyr_pass
	WLW	N,w1cp4,F
	WLW	4,w1cp3,F
	WLW	4,w1cp1,F
	W0
#passc2_l
	WLW	N,w2cp1,F
	WLW	N,w2cp2,F
	WLW	N,w2cp3,F
	WL	-1,plyr_pass
	WLW	N,w2cp4,F
	WLW	4,w2cp3,F
	WLW	4,w2cp1,F
	W0
#passc3_l
	WLW	N,w3cp1,F
	WLW	N,w3cp2,F
	WLW	N,w3cp3,F
	WL	-1,plyr_pass
	WLW	N,w3cp4,F
	WLW	4,w3cp3,F
	WLW	4,w3cp1,F
	W0
#passc4_l
	WLW	N,w4cp1,F
	WLW	N,w4cp2,F
	WLW	N,w4cp3,F
	WL	-1,plyr_pass
	WLW	N,w4cp4,F
	WLW	4,w4cp3,F
	WLW	4,w4cp1,F
	W0
#passc5_l
	WLW	N,w5cp1,F
	WLW	N,w5cp2,F
	WLW	N,w5cp3,F
	WL	-1,plyr_pass
	WLW	N,w5cp4,F
	WLW	4,w5cp3,F
	WLW	4,w5cp1,F
	W0


;Turmell
passnewoh_t
	.word	PASS_M
	.long	seq_stand
	.long	#passnoh1_l,#passnoh2_l,#passnoh3_l,#passnoh4_l
	.long	#passnoh5_l,#passnoh4_l,#passnoh3_l,#passnoh2_l

	.asg	4,N
#passnoh1_l
	WLW	N,w1ohp1,F
	WLW	N,w1ohp2,F
	WLW	N,w1ohp3,F
	WLW	N,w1ohp4,F
	WLW	N,w1ohp5,F
	WL	-1,plyr_pass
	WLW	N,w1ohp6,F
	WLW	N,w1ohp5,F
	WLW	N,w1ohp4,F
	W0
#passnoh2_l
	WLW	N,w2ohp1,F
	WLW	N,w2ohp2,F
	WLW	N,w2ohp3,F
	WLW	N,w2ohp4,F
	WL	-1,plyr_pass
	WLW	N,w2ohp5,F
	WLW	N,w2ohp4,F
	WLW	N,w2ohp3,F
	W0
#passnoh3_l
	WLW	N,w3ohp1,F
	WLW	N,w3ohp2,F
	WLW	N,w3ohp3,F
	WLW	N,w3ohp4,F
	WLW	1,w3ohp5,F
	WL	-1,plyr_pass
	WLW	N-1,w3ohp5,F
	WLW	N,w3ohp4,F
	WLW	N,w3ohp3,F
	W0
#passnoh4_l
	WLW	N,w4ohp1,F
	WLW	N,w4ohp2,F
	WLW	N,w4ohp3,F
	WLW	N,w4ohp4,F
	WL	-1,plyr_pass
	WLW	N,w4ohp5,F
	WLW	N,w4ohp4,F
	WLW	N,w4ohp3,F
	W0
#passnoh5_l
	WLW	N,w5ohp1,F
	WLW	N,w5ohp2,F
	WLW	N,w5ohp3,F
	WLW	N,w5ohp4,F
	WL	-1,plyr_pass
	WLW	N,w5ohp5,F
	WLW	N,w5ohp4,F
	WLW	N,w5ohp3,F
	W0


passoh_t

;Turmell
	.if	0
	
	.word	PASS_M
	.long	seq_stand
	.long	#passoh1_l,#passoh2_l,#passoh3_l,#passoh4_l
	.long	#passoh5_l,#passoh4_l,#passoh3_l,#passoh2_l

	.asg	4,N
#passoh1_l
	WLW	N,w1ohp1,F
	WLW	N,w1ohp2,F
	WLW	N,w1ohp3,F
	WLW	N,w1ohp4,F
	WLW	N,w1ohp5,F
	WL	-1,plyr_pass
	WLW	N,w1ohp6,F
	W0
#passoh2_l
	WLW	N,w2ohp1,F
	WLW	N,w2ohp2,F
	WLW	N,w2ohp3,F
	WLW	N,w2ohp4,F
	WL	-1,plyr_pass
	WLW	N,w2ohp5,F
	W0
#passoh3_l
	WLW	N,w3ohp1,F
	WLW	N,w3ohp2,F
	WLW	N,w3ohp3,F
	WLW	N,w3ohp4,F
	WL	-1,plyr_pass
	WLW	N,w3ohp5,F
	W0
#passoh4_l
	WLW	N,w4ohp1,F
	WLW	N,w4ohp2,F
	WLW	N,w4ohp3,F
	WLW	N,w4ohp4,F
	WL	-1,plyr_pass
	WLW	N,w4ohp5,F
	W0
#passoh5_l
	WLW	N,w5ohp1,F
	WLW	N,w5ohp2,F
	WLW	N,w5ohp3,F
	WLW	N,w5ohp4,F
	WL	-1,plyr_pass
	WLW	N,w5ohp5,F
	W0

;Turmell
	.endif


passdo_t
	.word	PASS_M|NOJUMP_M
	.long	seq_stand
	.long	#passdo1_l,#passdo2_l,#passdo3_l,#passdo4_l
	.long	#passdo5_l,#passdo4_l,#passdo3_l,#passdo2_l

#passdo1_l
	WLW	1,w1jupa,F
	WL	-1,plyr_pass
	WLW	4,w1jupa,F
	WLW	77,w1js4,F
	WLW	4,w1js2,F
	WLW	3,w1js1,F
	W0
#passdo2_l
	WLW	1,w2jupa,F
	WL	-1,plyr_pass
	WLW	4,w2jupa,F
	WLW	77,w2js4,F
	WLW	3,w2js3,F
	WLW	3,w2js2,F
	WLW	2,w2js1,F
	W0
#passdo3_l
	WLW	1,w3jupa,F
	WL	-1,plyr_pass
	WLW	4,w3jupa,F
	WLW	77,w3js5,F
	WLW	3,w3js4,F
	WLW	3,w3js3,F
	WLW	3,w3js2,F
	WLW	2,w3js1,F
	W0
#passdo4_l
	WLW	1,w4jupa,F
	WL	-1,plyr_pass
	WLW	4,w4jupa,F
	WLW	77,w4js5,F
	WLW	3,w4js4,F
	WLW	3,w4js3,F
	WLW	3,w4js2,F
	WLW	2,w4js1,F
	W0
#passdo5_l
	WLW	1,w5jupa,F
	WL	-1,plyr_pass
	WLW	4,w5jupa,F
	WLW	77,w5js4,F
	WLW	3,w5js3,F
	WLW	3,w5js2,F
	WLW	2,w5js1,F
	W0

#*
passbh_t
	.word	PASS_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#5,#4,#3,#2

	.asg	4,N
;If passer is facing 3,4,5 and teamate is located in the angles 1,2, or 3
;then we can use the T4HIND pass.
;
;If passer is facing 1,2 and teamate is located in the angles 3 or 4
;then we can use the T2HIND pass.
#1
#2
	WLW	N,T2HIND1,F
	WLW	N,T2HIND2,F
	WLW	N,T2HIND3,F
	WLW	N,T2HIND4,F
	WLW	2,T2HIND5,F
	WL	-1,plyr_pass
	WLW	3,T2HIND5,F
	WLW	5,T2HIND6,F
	W0
#3
#4
#5
	WLW	N,T4HIND1,F
	WLW	N,T4HIND2,F
	WLW	N,T4HIND3,F
	WLW	N,T4HIND4,F
	WLW	N,T4HIND5,F
	WLW	2,T4HIND6,F
	WL	-1,plyr_pass
	WLW	5,T4HIND6,F
	WLW	5,T4HIND7,F
	WLW	5,T4HIND8,F
	W0

;#*
;steal_t
;	.word	NOMV_M|NOSTEAL_M
;	.long	seq_stealstand
;	.long	#1,#2,#3,#4,#5,#4,#3,#2
;#1
;	WLW	3,w1stel1,F
;	WLW	3,w1stel2,F
;	WL	-1,seq_stealstand
;	WLW	3,w1stel3,F
;	WLW	3,w1stel4,F
;	WL	-1,seq_stealstand
;	WLW	3,w1stel3,F
;	WLW	3,w1stel2,F
;	WLW	3,w1stel1,F
;	W0
;#2
;	WLW	3,w2stel1,F
;	WLW	3,w2stel2,F
;	WL	-1,seq_stealstand
;	WLW	3,w2stel3,F
;	WLW	3,w2stel4,F
;	WL	-1,seq_stealstand
;	WLW	3,w2stel3,F
;	WLW	3,w2stel2,F
;	WLW	3,w2stel1,F
;	W0
;#3
;	WLW	3,w3stel1,F
;	WLW	3,w3stel2,F
;	WL	-1,seq_stealstand
;	WLW	3,w3stel3,F
;	WLW	3,w3stel4,F
;	WL	-1,seq_stealstand
;	WLW	3,w3stel3,F
;	WLW	3,w3stel2,F
;	WLW	3,w3stel1,F
;	W0
;#4
;	WLW	3,w4stel1,F
;	WLW	3,w4stel2,F
;	WL	-1,seq_stealstand
;	WLW	3,w4stel3,F
;	WLW	3,w4stel4,F
;	WL	-1,seq_stealstand
;	WLW	3,w4stel3,F
;	WLW	3,w4stel2,F
;	WLW	3,w4stel1,F
;	W0
;#5
;	WLW	4,w5stel1,F
;	WLW	4,w5stel2,F
;	WL	-1,seq_stealstand
;	WLW	4,w5stel3,F
;	WL	-1,seq_stealstand
;	WLW	4,w5stel2,F
;	WLW	4,w5stel1,F
;	W0

#*
steal_t
	.word	NOMV_M|NOSTEAL_M|NOJUMP_M
	.long	seq_stealstand
	.long	#1,#2,#3,#4,#5,#4,#3,#2
#1
	WLW	2,T1SWPE1,F
	WLL	-1,seq_snd,swipe_snd
	WLW	2,T1SWPE2,F
	WLW	3,T1SWPE3,F
	WLW	2,T1SWPE4,F
	WL	-1,seq_stealstand
	WLW	2,T1SWPE5,F
	WLW	3,T1SWPE6,F
	WLW	2,T1SWPE5,F
	WL	-1,seq_stealstand
	WLW	2,T1SWPE4,F
	WLW	3,T1SWPE3,F
	WLW	2,T1SWPE2,F
	WLW	2,T1SWPE1,F
	W0
#2
	WLW	2,T2SWPE1,F
	WLL	-1,seq_snd,swipe_snd
	WLW	2,T2SWPE2,F
	WLW	2,T2SWPE3,F
	WLW	2,T2SWPE4,F
	WLW	2,T2SWPE5,F
	WL	-1,seq_stealstand
	WLW	2,T2SWPE6,F
	WLW	2,T2SWPE7,F
	WLW	2,T2SWPE6,F
	WLW	2,T2SWPE5,F
	WL	-1,seq_stealstand
	WLW	2,T2SWPE4,F
	WLW	2,T2SWPE3,F
	WLW	2,T2SWPE2,F
	WLW	2,T2SWPE1,F
	W0
#3
	WLW	2,T3SWPE1,F
	WLL	-1,seq_snd,swipe_snd
	WLW	2,T3SWPE2,F
	WLW	2,T3SWPE3,F
	WLW	2,T3SWPE4,F
	WLW	2,T3SWPE5,F
	WL	-1,seq_stealstand
	WLW	2,T3SWPE6,F
	WLW	2,T3SWPE7,F
	WLW	2,T3SWPE6,F
	WLW	2,T3SWPE5,F
	WL	-1,seq_stealstand
	WLW	2,T3SWPE4,F
	WLW	2,T3SWPE3,F
	WLW	2,T3SWPE2,F
	WLW	2,T3SWPE1,F
	W0
#4
	WLW	2,T4SWPE1,F
	WLL	-1,seq_snd,swipe_snd
	WLW	2,T4SWPE2,F
	WLW	3,T4SWPE3,F
	WLW	2,T4SWPE4,F
	WL	-1,seq_stealstand
	WLW	2,T4SWPE5,F
	WLW	3,T4SWPE6,F
	WLW	2,T4SWPE5,F
	WL	-1,seq_stealstand
	WLW	2,T4SWPE4,F
	WLW	3,T4SWPE3,F
	WLW	2,T4SWPE2,F
	WLW	2,T4SWPE1,F
	W0
#5
	WLW	2,T5SWPE1,F
	WLL	-1,seq_snd,swipe_snd
	WLW	2,T5SWPE2,F
	WLW	3,T5SWPE3,F
	WLW	2,T5SWPE4,F
	WL	-1,seq_stealstand
	WLW	2,T5SWPE5,F
	WLW	3,T5SWPE6,F
	WLW	3,T5SWPE5,F
	WL	-1,seq_stealstand
	WLW	2,T5SWPE4,F
	WLW	3,T5SWPE3,F
	WLW	2,T5SWPE2,F
	WLW	2,T5SWPE1,F
	W0

#*
push_t
	.word	NOMV_M|NOJUMP_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#5,#4,#3,#2
#1
	WLW	4,w1cp1,F
	WLW	4,w1cp2,F
	WLW	4,w1cp3,F
	WL	-1,seq_push
	WLW	4,w1cp4,F
	WLW	4,w1cp3,F
	WLW	4,w1cp1,F
	W0
#2
	WLW	4,w2push2,F
	WLW	4,w2push3,F
	WL	-1,seq_push
	WLW	4,w2push4,F
	WLW	4,w2push3,F
	WLW	4,w2push2,F
	W0
#3
	WLW	4,w3cp1,F
	WLW	4,w3cp2,F
	WLW	4,w3cp3,F
	WL	-1,seq_push
	WLW	4,w3cp4,F
	WLW	4,w3cp3,F
	WLW	4,w3cp1,F
	W0
#4
	WLW	4,w4push1,F
	WLW	4,w4push2,F
	WL	-1,seq_push
	WLW	4,w4push3,F
	WLW	4,w4push2,F
	WLW	4,w4push1,F
	W0
#5
	WLW	4,w5cp1,F
	WLW	4,w5cp2,F
	WLW	4,w5cp3,F
	WL	-1,seq_push
	WLW	4,w5cp4,F
	WLW	4,w5cp3,F
	WLW	4,w5cp1,F
	W0



stagger_t
	.word	NOMV_M|NOBALL_M|NOJUMP_M
	.long	seq_stand
	.long	#stag2_l,#stag2_l,#stag3_l,#stag4_l
	.long	#stag4_l,#stag4_l,#stag3_l,#stag2_l
	.asg	5,N
#stag2_l
	WLW	N,w2fall1,F
;Turmell
	WLL	-1,seq_snd,push1_snd
	WLW	N,w2fall2,F
	WLW	N,w2fall3,F
	WLW	N,w2fall4,F
	WLW	N,w2fall5,F
	WLW	N,w2fall4,F
	WLW	N,w2fall3,F
	WLW	N,w2fall2,F
	WLW	N,w2fall1,F
	W0
#stag3_l
	WLW	N,w3fall1,F
;Turmell
	WLL	-1,seq_snd,push2_snd
	WLW	N,w3fall2,F
	WLW	N,w3fall3,F
	WLW	N,w3fall4,F
	WLW	N,w3fall5,F
	WLW	N,w3fall6,F
	WLW	N,w3fall7,F
	WLW	N,w3fall8,F
	W0
#stag4_l
	WLW	N,w4fall1,F
;Turmell
	WLL	-1,seq_snd,push3_snd
	WLW	N,w4fall2,F
	WLW	N,w4fall1,F
	W0
#*
fall_t
	.word	NOMV_M|NOBALL_M|NOJUMP_M
	.long	seq_stand
	.long	#2,#2,#3,#4,#4,#4,#3,#2
	.asg	5,N
	.asg	6,N2
#2
	WLW	N,w2fall1,F
;Turmell
	WLL	-1,seq_snd,fall1_snd
	WLW	N,w2fall2,F
	WLW	N,w2fall3,F
	WLW	N,w2fall4,F
	WLW	N,w2fall5,F
	WLW	N,w2fall6,F
	WLW	N,w2fall7,F
	WLW	N,w2fall8,F
	WLW	N,w2fall9,F
	WLW	N2,w2fall10,F
	WLW	N2,w2fall11,F
	WLW	N2,w2fall12,F
	WLW	N2,w2fall13,F
	WLW	N2,w2fall14,F
	WLW	N2,w2fall15,F
	WLW	N2,w2fall16,F
	W0
#3
	WLW	N,w3fall1,F
;Turmell
	WLL	-1,seq_snd,fall2_snd
	WLW	N,w3fall2,F
	WLW	N,w3fall3,F
;Turmell - duped out this list because of a sound call
	WLW	N,w4fall1,F
	WLW	N,w4fall2,F
	WLW	N,w4fall3,F
	WLW	N,w4fall4,F
	WLW	N,w4fall5,F
	WLW	N,w4fall6,F
	WLW	N,w4fall7,F
	WLW	N,w4fall8,F
	WLW	N,w4fall9,F
	WLW	N,w4fall10,F
	WLW	N,w4fall11,F
	WLW	N2,w4fall12,F
	WLW	N2,w4fall13,F
	WLW	N2,w4fall14,F
	WLW	N2,w4fall15,F
	WLW	N2,w4fall16,F
	WLW	N2,w4fall17,F
	WLW	N2,w4fall18,F
	W0
#4
	WLW	N,w4fall1,F
;Turmell
	WLL	-1,seq_snd,fall3_snd
	WLW	N,w4fall2,F
	WLW	N,w4fall3,F
	WLW	N,w4fall4,F
	WLW	N,w4fall5,F
	WLW	N,w4fall6,F
	WLW	N,w4fall7,F
	WLW	N,w4fall8,F
	WLW	N,w4fall9,F
	WLW	N,w4fall10,F
	WLW	N,w4fall11,F
	WLW	N2,w4fall12,F
	WLW	N2,w4fall13,F
	WLW	N2,w4fall14,F
	WLW	N2,w4fall15,F
	WLW	N2,w4fall16,F
	WLW	N2,w4fall17,F
	WLW	N2,w4fall18,F
	W0
#*
flyback_t
	.word	NOMV_M|NOBALL_M|NOJUMP_M|NOCOLLP_M
	.long	seq_stand
	.long	#2,#2,#3,#4,#4,#4,#3,#2
flybackwb_t
	.word	NOMV_M|NOJUMP_M|NOCOLLP_M
	.long	seq_stand
	.long	#2,#2,#3,#4,#4,#4,#3,#2
	.asg	3,N
	.asg	6,N2
#2
	WLW	N,w2fall1,F
;Turmell
	WLL	-1,seq_snd,fall1_snd
	WLW	N,w2fall2,F
	WLW	N,w2fall3,F
	WLW	N,w2fall4,F
	WLW	N,w2fall5,F
	WLW	N,w2fall6,F
	WLW	N,w2fall7,F
	WLW	N,w2fall8,F
	WLL	-1,seq_snd,land_snd
	WLW	30,w2fall9,F
	WLL	-1,seq_snd,boo_snd
	WLW	N2,w2fall10,F
	WLW	N2,w2fall11,F
	WLW	N2,w2fall12,F
	WLW	N2,w2fall13,F
	WLW	N2,w2fall14,F
	WLW	N2,w2fall15,F
	WLW	N2,w2fall16,F
	W0
#3
	WLL	-1,seq_snd,oof_snd
;Turmell
;	WLL	-1,seq_snd,fall2_snd
	WLW	N,w3fall1,F
	WLW	N,w3fall2,F
	WLW	N,w3fall3,F
	WLW	N,w4fall1,F
	WLW	N,w4fall2,F
	WLW	N,w4fall3,F
	WLW	N,w4fall4,F
	WLW	N,w4fall5,F
	WLW	N,w4fall6,F
	WLW	N,w4fall7,F
	WLW	N,w4fall8,F
	WLW	N,w4fall9,F
	WLW	N,w4fall10,F
	WLL	-1,seq_snd,land_snd
	WLW	30,w4fall11,F
	WLL	-1,seq_snd,boo_snd
	WLW	N2,w4fall12,F
	WLW	N2,w4fall13,F
	WLW	N2,w4fall14,F
	WLW	N2,w4fall15,F
	WLW	N2,w4fall16,F
	WLW	N2,w4fall17,F
	WLW	N2,w4fall18,F
	W0
#4
	WLL	-1,seq_snd,ungh_snd
	WLW	N,w4fall1,F
;Turmell
	WLL	-1,seq_snd,fall3_snd
	WLW	N,w4fall2,F
	WLW	N,w4fall3,F
	WLW	N,w4fall4,F
	WLW	N,w4fall5,F
	WLW	N,w4fall6,F
	WLW	N,w4fall7,F
	WLW	N,w4fall8,F
	WLW	N,w4fall9,F
	WLW	N,w4fall10,F
	WLL	-1,seq_snd,land_snd
	WLW	30,w4fall11,F
	WLL	-1,seq_snd,boo_snd
	WLW	N2,w4fall12,F
	WLW	N2,w4fall13,F
	WLW	N2,w4fall14,F
	WLW	N2,w4fall15,F
	WLW	N2,w4fall16,F
	WLW	N2,w4fall17,F
	WLW	N2,w4fall18,F
	W0



;Turmell
#*
flyback2_t
	.word	NOMV_M|NOBALL_M|NOJUMP_M|NOCOLLP_M
	.long	seq_stand
	.long	#2,#2,#3,#4,#4,#4,#3,#2
flybackwb2_t
	.word	NOMV_M|NOJUMP_M|NOCOLLP_M
	.long	seq_stand
	.long	#2,#2,#3,#4,#4,#4,#3,#2
	.asg	5,N


#2
	WLW	N,w2fall1,F
	WLL	-1,seq_snd,boo_snd
	WLW	N,w2fall2,F
	WLW	N,w2fall3,F
	WLW	N,w2fall4,F
	WLW	N,w2fall3,F
	WLW	N,w2fall2,F
	WLW	N,w2fall1,F
	W0
#3
;	WLL	-1,seq_snd,oof_snd
	WLW	N,w3fall1,F
	WLW	N,w3fall2,F
	WLW	N,w3fall3,F
	WLL	-1,seq_snd,boo_snd
	WLW	N,w3fall4,F
	WLW	N,w3fall5,F
	WLW	N,w3fall6,F
	WLW	N,w3fall7,F
	WLW	N,w3fall8,F
	W0
#4
;	WLL	-1,seq_snd,ungh_snd
	WLW	N+1,w4fall1,F
	WLW	N+1,w4fall2,F
	WLW	N+1,w4fall3,F
	WLL	-1,seq_snd,boo_snd
	WLW	N+1,w4fall4,F
	WLW	N+1,w4fall3,F
	WLW	N,w4fall2,F
	WLW	N,w4fall1,F
	W0



#*
pickup_t
	.word	NOMV_M|NOSTEAL_M|NOJUMP_M
	.long	seq_stand
	.long	#1,#2,#3,#4,#5,#4,#3,#2
	.asg	3,N
#1
	WLW	N,w1pikup1,F|M_YF
	WLW	N,w1pikup2,F|M_YF
	WLW	N,w1pikup3,F
	WLW	N,w1pikup2,F
	WLW	N,w1pikup1,F
	W0
#2
	WLW	N,w2pikup1,F|M_YF
	WLW	N,w2pikup2,F|M_YF
	WLW	N,w2pikup3,F
	WLW	N,w2pikup2,F
	WLW	N,w2pikup1,F
	W0
#3
	WLW	N,w3pikup1,F|M_YF
	WLW	N,w3pikup2,F|M_YF
	WLW	N,w3pikup3,F
	WLW	N,w3pikup2,F
	WLW	N,w3pikup1,F
	W0
#4
	WLW	N,w4pikup1,F|M_YF
	WLW	N,w4pikup2,F|M_YF
	WLW	N,w4pikup3,F
	WLW	N,w4pikup2,F
	WLW	N,w4pikup1,F
	W0
#5
	WLW	N,w5pikup1,F|M_YF
	WLW	N,w5pikup2,F|M_YF
	WLW	N,w5pikup3,F
	WLW	N,w5pikup2,F
	WLW	N,w5pikup1,F
	W0
#*
elbo_t
	.word	NOMV_M|NOSTEAL_M|NOJUMP_M
	.long	seq_stand
	.long	#2,#2,#2,#4,#4,#4,#2,#2
	.asg	3,N
#2
;Turmell
;	WLL	-1,seq_snd,push1_snd
	WLW	N,w2elbo3,F
	WL	-1,seq_elbo
	WLW	N,w2elbo2,F
	WLW	N,w2elbo1,F
	WLW	N,w2elbo2,F
	WLW	N,w2elbo3,F
;Turmell
;	WLL	-1,seq_snd,push2_snd
	WLW	N,w2elbo4,F
	WLW	N,w2elbo5,F
	WLW	N,w2elbo4,F
	WLW	N,w2elbo3,F
	W0
#4
;Turmell
;	WLL	-1,seq_snd,push3_snd
	WLW	N,w4elbo4,F
	WL	-1,seq_elbo
	WLW	N,w4elbo3,F
	WLW	N,w4elbo2,F
	WLW	N,w4elbo1,F
	WLW	N,w4elbo2,F
	WLW	N,w4elbo3,F
	WLW	N,w4elbo4,F
;Turmell
;	WLL	-1,seq_snd,push1_snd
	WLW	N,w4elbo5,F
	WLW	N,w4elbo6,F
	WLW	N,w4elbo7,F
	WLW	N,w4elbo6,F
	WLW	N,w4elbo5,F
	WLW	N,w4elbo4,F
	W0


	.end
