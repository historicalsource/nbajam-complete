**************************************************************
*
* Software:		Shawn Liptak, Mark Turmell
* Initiated:		9/17/92
*
* Modified:		Mark Turmell, 1/6/93	-Split from PLYR.asm
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 3/23/93 15:13
**************************************************************
	.file	"plyr3.asm"
	.title	"basketball player code"
	.width	132
	.option	b,d,l,t
	.mnolist


	.include	"mproc.equ"		;Mproc equates
	.include	"disp.equ"		;Display proc equates
	.include	"gsp.equ"		;Gsp asm equates
	.include	"sys.equ"
	.include	"audit.equ"
	.include	"mac2.asm"
	.include	"imgtbl.glo"
	.include	"imgtbl2.glo"
	.include	"bgndtbl.glo"
	.include	"game.equ"
	.include	"shawn.hdr"		;Macros
	.asg		0,SEQT
	.include	"plyr.equ"
	.include	"frame.tbl"
	.include	"card.tbl"
	.include	"plyrhd2.tbl"
	.include	"dipequ.asm"

;sounds external

tunehalf_snd	.word	>f3ff,>8,>8004,0	;Half time tune
report_snd	.word	>f981,1*60,>8171,1	;Halftime report
altitude_snd	.word	>f981,30,>81cc,0	;Altitude
cheer1_snd	.word	>fd84,100,>8111,0	;Long cheer
cheer2_snd	.word	>f894,100,>8144,0	;Long cheer

;symbols externally defined

	.ref	BAKMODS,BGND_UD1
	.ref	snd_play1ovr
	.ref	IRQSKYE
	.ref	dpageflip
	.ref	GAMSTATE
	.ref	COLCYC
	.ref	system_savegame,system_restoregame
	.ref	tvpanelon
	.ref	movie_run
	.ref	RNDRNG0
	.ref	READ_DIP

	.ref	scale63_t

	.ref	pal_getf


;symbols defined in this file
	.def	card_v

;uninitialized ram definitions

;	.bss	cycram		,9*16
	.bss	clipbits	,32	;Bit set for each clip # shown

	BSSX	clipsrunning	,32

;equates for this file


	.text

#*******************************
* Show halftime intro and clips (JSRP)

CLIPTEST	.equ	0

 SUBR	halftime_showclips


	movi	4*60,a10

#stop	SLEEPK	1
	subk	1,a10
	jrle	#tvout
	move	@tvpanelon,a0,L
	jrnz	#stop
#tvout
;	callr	kill_tvpanel

;	movi	tunehalf_snd,a0
;	calla	snd_play1

	calla	READ_DIP
	btst	DPNOVIDCLIPS_B,a0
	jrnz	#x			;Clips off?


	calla	system_savegame

	movi	>12345678,a0
	move	a0,@clipsrunning,L


	movk	INPLYRINFO,a0
	move	a0,@GAMSTATE

	clr	a0
	move	a0,@dtype		;2D

	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L

	JSRP	scrn_scaleininit

	movi	half_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1
	SLEEPK	2

	JSRP	scrn_scalein

	movi	4<<10+4<<5+4,a0
	move	a0,@IRQSKYE		;background color


	CREATE0	plyr_jscrowdsnda

	SLEEPK	10

	SOUND1	report_snd

	movi	-1,a0
	move	a0,@dpageflip		;No erasure

#test
	movk	2,a5			;# clips to show
	clr	a6
#lp
	move	a6,a0
	addk	1,a6
	sll	5,a0
	addi	#xy_t,a0
	move	*a0+,a10,L		;XY

	move	@clipbits,a2,L
	cmpi	>3ffff,a2		;18 bits
	jrlo	#ok
	clr	a2
#ok
#crlp	movk	18-1,a0			;Total # clips
	calla	RNDRNG0
	btst	a0,a2
	jrnz	#crlp			;Have already shown?

	movk	1,a14			;Set bit
	sll	a0,a14
	or	a14,a2
	move	a2,@clipbits,L

	.if	CLIPTEST
	clr	a0
	.endif

	sll	5,a0
	addi	#mv_t,a0
	move	*a0,a8,L

	clr	a9
	PUSHP	a5,a6
	PUSHP	a8

	move	a10,a0
	sll	32-12,a0
	srl	7,a0			;X
	move	a10,a1
	srl	12,a1
	sll	16,a1			;Y
	movi	scobars,a2
	movi	500,a3			;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	SLEEPK	30
	calla	DELOBJA8

	PULLP	a8
	PUSHP	a10
	JSRP	movie_run
	PULLP	a10

	PULLP	a5,a6

	dsj	a5,#lp

	.if	CLIPTEST
	jruc	#test			;Infinite loop
	.endif

	movi	TSEC*1+30,a10
#butlp
	SLEEPK	1
	.ref	get_all_buttons_cur
	calla	get_all_buttons_cur
	move	a0,a0
	jrnz	#exit1
	dsj	a10,#butlp
#exit1

	calla	display_blank

	clr	a0
	move	a0,@clipsrunning,L

	calla	system_restoregame

#x	RETP


plyr_jscrowdsnda
	CREATE0	scrms
	SLEEP	40
	movi	cheer1_snd,a0
	calla	snd_play1
	movi	cheer2_snd,a0
	calla	snd_play1
	SLEEP	35
	movi	cheer1_snd,a0
	calla	snd_play1ovr
	movi	cheer2_snd,a0
	calla	snd_play1ovr
	SLEEP	24
	movi	cheer1_snd,a0
	calla	snd_play1ovr
	movi	cheer2_snd,a0
	calla	snd_play1ovr
;	SLEEP	12
;	movi	cheer1_snd,a0
;	calla	snd_play1ovr
;	movi	cheer2_snd,a0
;	calla	snd_play1ovr
	DIE

scrms	movi	scrm1_snd,a0
	calla	snd_play1ovr
	SLEEP	15
	movi	scrm2_snd,a0
	calla	snd_play1ovr
	SLEEP	15
	movi	scrm3_snd,a0
	calla	snd_play1ovr
	SLEEP	15
	movi	scrm4_snd,a0
	calla	snd_play1ovr
	SLEEP	15
	DIE

	.ref	scrm1_snd,scrm2_snd,scrm3_snd,scrm4_snd


half_mod
	.long	htclipsBMOD
	.word	0,0
	.long	0

#xy_t	.long	(88+52*512)*8
;	.long	(212+52*512)*8
;	.long	(88+140*512)*8
	.long	(212+140*512)*8
#mv_t
	.long	V4C_F
	.long	V5C_F
	.long	V6C_F
	.long	V8C_F
	.long	V10C_F
	.long	V11C_F
	.long	V13C_F
	.long	V14C_F
	.long	V15C_F
	.long	V17C_F
	.long	V18C_F
	.long	V19C_F
	.long	V20C_F
	.long	V22C_F
	.long	V23C_F
	.long	VNEW2_F
	.long	V1C_F
	.long	V3C_F

;	.long	V7C_F
;	.long	VNEW1_F


#*******************************
* Smoke trail (Process)
* A8=*Src obj
* A10=*Plyr process

 SUBR	plyr_smoketrail

	movk	15,a11
#lp	CREATE0	plyr_smokepuff
	SLEEPK	4
	dsj	a11,#lp

	DIE


#*******************************
* Smoke trail puff (Process)
* A8=*Src obj
* A10=*Plyr process

 SUBRP	plyr_smokepuff

	move	*a10(plyr_dir),a10
	srl	2,a10

	move	*a8(OZPOS),a3
	movk	3,a0
	callr	rnd
	subk	2,a0
	add	a0,a3			;-2 to 1

	movk	3,a0
	callr	rnd
	sll	5,a0			;*32
	addi	smoke_t,a0
	move	*a0,a9,L

	move	*a8(OXVEL),a6,L
	move	*a8(OYVEL),a7,L
	sra	2,a6			;/4
	sra	2,a7

	move	*a8(OXPOS),a0
	move	*a8(OSIZEX),a2
	srl	1,a2			;/2
	add	a2,a0
	move	*a8(OYPOS),a1
	move	*a8(OSIZEY),a2
	srl	1,a2			;/2
	add	a2,a1
	sll	4,a10			;*16
	addi	mslstxy_t,a10
	move	*a10(8*16),a2
	add	a2,a0			;+X offset
	move	*a10,a2
	add	a2,a1			;+YO
	sll	16,a0			;X
	sll	16,a1			;Y
	movi	CLDB1ORNG,a2
	movi	DMAWNZ|M_3D|M_NOCOLL,a4	;No collisions
	movi	CLSDEAD,a5
	calla	BEGINOBJ2
	movi	scale50_t,a0
	move	a0,*a8(ODATA_p),L
	SLEEPK	3
	jauc	FRQDELDIE

mslstxy_t
	.word	12,12,11,10,8,6,3,1		;Y
	.word	0,-1,-3,-6,-8,-10,-11,-12	;X
	.word	-12,-12,-11,-10,-8,-6,-3,-1
	.word	0,1,3,6,8,10,11,12
	.word	12,12,11,10,8,6,3,1


#*******************************
* Smoke trail (Process)
* A8=*Src obj
;* A10=*Plyr process

; SUBR	ball_smoketrail
;
;	movi	8000,a11
;#lp	CREATE0	ball_smokepuff
;	SLEEPK	2
;	dsj	a11,#lp
;	DIE


#*******************************
* Smoke trail puff (Process)
* A8=*Src obj
;* A10=*Plyr process

 SUBR	ball_smokepuff

	move	a8,a11

;	move	@HCOUNT,a0
;	sll	32-1,a0
;	jrnz	#nosprk
;	CREATE0	ball_spark
;#nosprk
	move	*a8(OZPOS),a3
	movk	3,a0
	callr	rnd
	subk	2,a0
	add	a0,a3			;-2 to 1

	movk	3,a0
	callr	rnd
	sll	5,a0			;*32
	addi	smoke_t,a0
	move	*a0,a9,L

	move	*a8(OXVEL),a6,L
	move	*a8(OYVEL),a7,L
	sra	2,a6			;/4
	sra	2,a7

	move	*a8(OXPOS),a0
	move	*a8(OSIZEX),a2
	srl	1,a2			;/2
	add	a2,a0
	move	*a8(OXANI+16),a2
	add	a2,a0
	move	*a8(OYPOS),a1
	move	*a8(OSIZEY),a2
	srl	1,a2			;/2
	add	a2,a1
	addk	15,a1
;	sll	4,a10			;*16
;	addi	mslstxy_t,a10
;	move	*a10(8*16),a2
;	add	a2,a0			;+X offset
;	move	*a10,a2
;	add	a2,a1			;+YO
	sll	16,a0			;X
	sll	16,a1			;Y
	movi	CLDB1YELL,a2
	movi	DMAWNZ|M_3D|M_NOCOLL,a4	;No collisions
	movi	CLSDEAD,a5
	calla	BEGINOBJ2

	movi	scale50_t,a0
	move	a0,*a8(ODATA_p),L
	move	*a11(OZVEL),a0,L
	sra	2,a0			;/4
	move	a0,*a8(OZVEL),L


	move	*a8(OZPOS),a14		;894 to 1379 (Z range 486)
	subi	GZBASE,a14		;-Base
	jrge	#zok
	clr	a14
#zok	srl	4,a14			;/16
	sll	6,a14			;*64
	move	*a8(ODATA_p),a0,L
	addk	32,a0
	add	a14,a0

	move	*a0+,a14
	sll	4,a14			;*16
	move	*a8(OIMG),a2,L

	move	*a2(IANIOFFX),a1
	mpys	a14,a1
	move	a1,*a8(OXANI),L
	move	*a0,a14
	sll	4,a14			;*16
	move	a1,a0

	move	*a2(IANIOFFY),a1
	mpys	a14,a1

	sra	16,a0
	sra	16,a1
	neg	a0
	neg	a1

	move	*a11(OXPOS),a14
	add	a14,a0
	move	*a11(OSIZEX),a2
	srl	1,a2			;/2
	add	a2,a0
;	move	*a11(OXANI+16),a2
;	add	a2,a0
	move	*a11(OYPOS),a14
	add	a14,a1
	move	*a11(OSIZEY),a2
	srl	1,a2			;/2
	add	a2,a1
	move	a0,*a8(OXPOS)
	move	a1,*a8(OYPOS)


;	SLEEPK	2
;	jauc	FRQDELDIE



	move	*a9+,a0,L
#alp	move	*a8(OCTRL),a1
	calla	obj_aniq_scld
	move	*a9+,a0
	cmpi	>100,a0
	jrlo	#slp			;No flags?
	move	a0,a2
	move	*a9+,a0,L
	calla	pal_getf
	move	a0,*a8(OPAL)
	move	a2,a0
	sll	32-8,a0
	srl	32-8,a0
#slp
	calla	PRCSLP
	move	*a9+,a0,L
	jrnz	#alp
	jauc	DELOBJDIE


smoke_t
	.long	cldbw_l,cldblg_l,cldbgry_l,cldblg2_l

cldbw_l
	LW	CLDB2,3
	LWL	CLDB3,NEWPALET|3,ORNGPAL
	LW	CLDB4,2
	LWL	CLD5,NEWPALET|2,WHTPAL
	LW	CLD6,2
	LW	CLD7,2
	LW	CLD8,2
	LW	CLD9,2
	LW	CLD10,2
	LWL0	CLD11,2
cldblg_l
	LW	CLDB2,2
	LWL	CLDB3,NEWPALET|3,ORNGPAL
	LW	CLDB4,2
	LWL	CLD5,NEWPALET|2,LGRYPAL
	LW	CLD6,2
	LW	CLD7,2
	LW	CLD8,2
	LW	CLD9,2
	LW	CLD10,2
	LWL0	CLD11,1
cldbgry_l
	LW	CLDB2,3
	LWL	CLDB3,NEWPALET|2,ORNGPAL
	LW	CLDB4,2
	LWL	CLD5,NEWPALET|2,GREYPAL
	LW	CLD6,2
	LW	CLD7,2
	LW	CLD8,2
	LW	CLD9,1
	LW	CLD10,1
	LWL0	CLD11,1
cldblg2_l
	LW	CLDB2,2
	LWL	CLDB3,NEWPALET|2,ORNGPAL
	LWL	CLDB4,NEWPALET|2,LGRYPAL
	LW	CLD5,2
	LW	CLD6,2
	LW	CLD7,2
	LW	CLD8,2
	LW	CLD9,2
	LW	CLD10,2
	LWL0	CLD11,2



SCLT	.macro	sx,sy,sxa,sya
	.eval	:sx:*1048,X	;Convert (has slight error)
	.eval	:sy:*1048,Y
	.eval	:sxa:*1048,XA
	.eval	:sya:*1048,YA
	.loop	10
	.word	>10000000/X,>10000000/Y
	.word	>100000/(>10000000/X),>100000/(>10000000/Y)
	.eval	X+XA*1/4,X
	.eval	Y+YA*1/4,Y
	.endloop
	.loop	10
	.word	>10000000/X,>10000000/Y
	.word	>100000/(>10000000/X),>100000/(>10000000/Y)
	.eval	X+XA*2/4,X
	.eval	Y+YA*2/4,Y
	.endloop
	.loop	10
	.word	>10000000/X,>10000000/Y
	.word	>100000/(>10000000/X),>100000/(>10000000/Y)
	.eval	X+XA*3/4,X
	.eval	Y+YA*3/4,Y
	.endloop
	.loop	10
	.word	>10000000/X,>10000000/Y
	.word	>100000/(>10000000/X),>100000/(>10000000/Y)
	.eval	X+XA,X
	.eval	Y+YA,Y
	.endloop
	.endm

				;>Generate scale tables
scale30_t
	SCLT	300,300,19,19
scale50_t
	SCLT	500,500,31,31

	.if	0

********************************
* Spark from flaming ball (Process)
* A8/A11=*Ball obj

 SUBRP	ball_spark

	movi	spark_l,a9

	move	*a11(OXVEL),a6,L
	sra	2,a6
	movk	>f,a0
	callr	rnd
	subk	7,a0
	sll	14,a0			;XVel
	add	a0,a6

	movk	3,a0
	callr	rnd
	jrnz	#xnorm
	sll	2,a6			;*4
#xnorm
	move	*a11(OYVEL),a7,L
	sra	2,a7
	movk	>f,a0
	callr	rnd
	subk	7,a0
	sll	14,a0			;YVel
	add	a0,a7

	movk	3,a0
	callr	rnd
	jrnz	#ynorm
	sll	2,a7			;*4
#ynorm
	move	*a8(OZPOS),a3
	movk	3,a0
	callr	rnd
	subk	2,a0
	add	a0,a3			;-2 to 1

	move	*a8(OXPOS),a0
;	move	*a8(OSIZEX),a2
;	srl	1,a2			;/2
;	add	a2,a0
	move	*a8(OXANI+16),a2
	add	a2,a0
	move	*a8(OYPOS),a1
	move	*a8(OSIZEY),a2
	srl	1,a2			;/2
	add	a2,a1

	sll	16,a0
	sll	16,a1
	movi	spark1,a2
	movi	DMAWNZ|M_3D|M_NOSCALE,a4
	movi	CLSDEAD,a5
	calla	BEGINOBJ2

	move	*a11(OZVEL),a2,L
	sra	2,a2			;/4
	movk	>f,a0
	callr	rnd
	subk	7,a0
	sll	14,a0
	add	a0,a2
	move	a2,*a8(OZVEL),L


	movk	3,a0
	callr	rnd
	addk	1,a0
	move	a0,a11
	jruc	#strt

#lp	dsj	a10,#noani
#strt
	move	a11,a10
	move	*a9,a0,L
	jrz	#noani
	addk	32,a9

	move	*a8(OCTRL),a1
	calla	obj_aniq
#noani
	SLEEPK	1
	move	*a8(OYVEL),a2,L
	addi	GRAV,a2
	move	a2,*a8(OYVEL),L
	jrn	#lp			;Going up?
	move	*a8(OYVAL),a1,L
	jrlt	#lp			;Above gnd?
	clr	a1
	move	a1,*a8(OYVAL),L
;	move	@HCOUNT,a14
;	sll	32-2,a14
;	jrz	#die
;	neg	a2
;	sra	3,a2
;	move	a2,*a8(OYVEL),L
;	cmpi	-(GRAV*2),a2
;	jrlt	#lp
;
;#die
	clr	a0
	move	a0,*a8(OXVEL),L
	move	a0,*a8(OYVEL),L
	move	a0,*a8(OZVEL),L
	SLEEPK	4

	jauc	DELOBJDIE


spark_l	.long	spark1
	.long	spark2
	.long	spark3
	.long	spark4
	.long	spark5,0

	.endif


********************************
* Get random # with mask
* A0=Mask
* >A0=Rnd # (Pass CC)
* Trashes scratch

 SUBRP	rnd

	move	@RAND,a1,L
	rl	a1,a1
	move	@HCOUNT,a14
	rl	a14,a1
	add	sp,a1
	move	a1,@RAND,L

	and	a1,a0
	rets




#*******************************

 SUBR	getdunkseq


	move	*a13(plyr_num),a0	;If on fire, don't use turbo on run
	.ref	plyrnumonfire
	move	@plyrnumonfire,a1
	cmp	a0,a1
	jrz	set5

	move	*a13(plyr_attrib_p),a0,L
	move	*a0(PAT_DUNKSKILL),a0
	sll	5,a0
	addi	jmp_t,a0
	move	*a0,a0,L
	jump	a0


jmp_t	.long	set1,set1,set1,set2
	.long	set2,set3,set4,set4,set5,set5,set5


set5
	addi	d5u_t,a3

	cmpi	60,a4
	jrle	#shortd			;Under hoop?
	addi	d5s_t-d5u_t,a3

	cmpi	80,a4			;Short range
	jrle	#shortd

	move	*a13(plyr_turbon),a14
	jrz	#sj

	addi	d5m_t-d5s_t,a3,W

	cmpi	120,a4			;Med range
	jrle	#shortd
	addi	d5l_t-d5m_t,a3,W
	jruc	#shortd

;
set4
	addi	d4u_t,a3

	cmpi	60,a4
	jrle	#shortd			;Under hoop?
	addi	d4s_t-d4u_t,a3

	cmpi	80,a4			;Short range
	jrle	#shortd

	move	*a13(plyr_turbon),a14
	jrz	#sj

	addi	d4m_t-d4s_t,a3,W

	cmpi	120,a4			;Med range
	jrle	#shortd
	addi	d4l_t-d4m_t,a3,W
	jruc	#shortd

;
set3
	addi	d3u_t,a3

	cmpi	60,a4
	jrle	#shortd			;Under hoop?
	addi	d3s_t-d3u_t,a3

	cmpi	80,a4			;Short range
	jrle	#shortd

	move	*a13(plyr_turbon),a14
	jrz	#sj

	addi	d3m_t-d3s_t,a3,W

	cmpi	120,a4			;Med range
	jrle	#shortd
	addi	d3l_t-d3m_t,a3,W
	jruc	#shortd

;
set2
	addi	d3u_t,a3

	cmpi	60,a4
	jrle	#shortd			;Under hoop?
	addi	d2s_t-d2u_t,a3

	cmpi	80,a4			;Short range
	jrle	#shortd

	move	*a13(plyr_turbon),a14
	jrz	#sj

	addi	d2m_t-d2s_t,a3,W

	cmpi	120,a4			;Med range
	jrle	#shortd
	addi	d2l_t-d2m_t,a3,W
	jruc	#shortd

;
set1
	addi	d1u_t,a3

	cmpi	60,a4
	jrle	#shortd			;Under hoop?
	addi	d1s_t-d1u_t,a3

	cmpi	80,a4			;Short range
	jrle	#shortd

	move	*a13(plyr_turbon),a14
	jrz	#sj

	addi	d1m_t-d1s_t,a3,W

	cmpi	110,a4			;Med range
	jrle	#shortd

	addi	d1l_t-d1m_t,a3,W


#shortd	clr	a0
	rets
#sj	movk	1,a0
	rets

#****************************************************************************


;Set of dunks for #5 skill players

d5u_t	.long	#d1u_t,#d2u_t,#d3u_t,#d4u_t
	.long	#d5u_t,#d4u_t,#d3u_t,#d2u_t, #d1u_t

d5s_t	.long	#d1s_t,#d2s_t,#d3s_t,#d4s_t
	.long	#d5s_t,#d4s_t,#d3s_t,#d2s_t, #d1s_t

d5m_t	.long	#d1m_t,#d2m_t,#d3m_t,#d4m_t
	.long	#d5m_t,#d4m_t,#d3m_t,#d2m_t, #d1m_t

d5l_t	.long	#d1l_t,#d2l_t,#d3l_t,#d4l_t
	.long	#d5l_t,#d4l_t,#d3l_t,#d2l_t, #d1l_t

;Dunks from under hoop
#d1u_t	.word	1-1,DUNKB2_SEQ
#d2u_t	.word	1-1,DUNKB2_SEQ
#d3u_t	.word	1-1,DUNKB2_SEQ			;,DUNKT6_SEQ
#d4u_t	.word	1-1,DUNKG2_SEQ			;,DUNKT6_SEQ
#d5u_t	.word	1-1,DUNKN2_SEQ

;List of dunks that can happen in these dirs if plyr is near hoop
#d1s_t	.word	12-1,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKT_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY6_SEQ

#d2s_t	.word	18-1,DUNKB_SEQ,DUNKF_SEQ,DUNKT_SEQ,DUNKO_SEQ
	.word	DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKS_SEQ
	.word	DUNKS2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKW2_SEQ
	.word	DUNKW_SEQ
	.word	DUNKLAY6_SEQ

#d3s_t	.word	10-1,DUNKP_SEQ,DUNKB_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKT_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKU_SEQ

#d4s_t	.word	8-1,DUNKP_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ,DUNKT_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
#d5s_t	.word	4-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is med dist from hoop
#d1m_t	.word	12-1,DUNKA_SEQ,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKLAY6_SEQ

#d2m_t	.word	42-1,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ,DUNKO_SEQ
	.word	DUNKK_SEQ,DUNKK2_SEQ,DUNKJ2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKT4_SEQ
	.word	DUNKT5_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ
	.word	DUNKJ2_SEQ,DUNKO2_SEQ,DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKW2_SEQ
	.word	DUNKW_SEQ
	.word	DUNKY_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKZ3_SEQ
	.word	DUNKLAY6_SEQ

#d3m_t	.word	51-1,DUNKB_SEQ,DUNKC_SEQ,DUNKE_SEQ,DUNKE2_SEQ
	.word	DUNKL_SEQ,DUNKL4_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKT4_SEQ
	.word	DUNKT5_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKP_SEQ,DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKE_SEQ,DUNKT_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKL_SEQ,DUNKL2_SEQ,DUNKL3_SEQ,DUNKL4_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKP3_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKU_SEQ
	.word	DUNKU2_SEQ
	.word	DUNKU3_SEQ
	.word	DUNKU4_SEQ
	.word	DUNKU5_SEQ
	.word	DUNKU6_SEQ
	.word	DUNKX_SEQ
	.word	DUNKX2_SEQ
	.word	DUNKX3_SEQ
	.word	DUNKY_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKZ3_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY3A_SEQ

#d4m_t	.word	22-1,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKP2_SEQ,DUNKP_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKT4_SEQ
	.word	DUNKT5_SEQ
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKP_SEQ
	.word	DUNKP2_SEQ			;,DUNKC_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKY_SEQ
	.word	DUNKY2_SEQ

#d5m_t	.word	4-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is far away from hoop
#d1l_t	.word	2-1,0
	.word	DUNKLAY6_SEQ

#d2l_t
	.word	26-1
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ
	.word	DUNKJ2_SEQ,DUNKO2_SEQ,DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT5_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKW2_SEQ
	.word	DUNKW_SEQ
	.word	DUNKY_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKZ3_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKLAY6_SEQ

#d3l_t	.word	35-1
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKP_SEQ,DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKE_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKL_SEQ,DUNKL2_SEQ,DUNKL3_SEQ,DUNKL4_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKP3_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT5_SEQ
	.word	DUNKU2_SEQ
	.word	DUNKU3_SEQ
	.word	DUNKU4_SEQ
	.word	DUNKU5_SEQ
	.word	DUNKU6_SEQ
	.word	DUNKX_SEQ
	.word	DUNKX2_SEQ
	.word	DUNKX3_SEQ
	.word	DUNKY_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKZ3_SEQ

#d4l_t	.word	12-1
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKP_SEQ
	.word	DUNKP2_SEQ			;,DUNKC_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT5_SEQ
	.word	DUNKY_SEQ
	.word	DUNKY2_SEQ

#d5l_t	.word	1-1
	.word	DUNKLAY_SEQ


#****************************************************************************
;Set of dunks for #4 skill players

d4u_t	.long	#d1u_t,#d2u_t,#d3u_t,#d4u_t
	.long	#d5u_t,#d4u_t,#d3u_t,#d2u_t, #d1u_t

d4s_t	.long	#d1s_t,#d2s_t,#d3s_t,#d4s_t
	.long	#d5s_t,#d4s_t,#d3s_t,#d2s_t, #d1s_t

d4m_t	.long	#d1m_t,#d2m_t,#d3m_t,#d4m_t
	.long	#d5m_t,#d4m_t,#d3m_t,#d2m_t, #d1m_t

d4l_t	.long	#d1l_t,#d2l_t,#d3l_t,#d4l_t
	.long	#d5l_t,#d4l_t,#d3l_t,#d2l_t, #d1l_t

;Dunks from under hoop
#d1u_t	.word	1-1,DUNKB2_SEQ
#d2u_t	.word	1-1,DUNKB2_SEQ
#d3u_t	.word	1-1,DUNKB2_SEQ			;,DUNKT6_SEQ
#d4u_t	.word	1-1,DUNKG2_SEQ			;,DUNKT6_SEQ
#d5u_t	.word	1-1,DUNKN2_SEQ

;List of dunks that can happen in these dirs if plyr is near hoop
#d1s_t	.word	12-1,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKT_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY6_SEQ

#d2s_t	.word	19-1,DUNKB_SEQ,DUNKF_SEQ,DUNKT_SEQ,DUNKO_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKS_SEQ
	.word	DUNKS2_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKW2_SEQ
	.word	DUNKW_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY6_SEQ

#d3s_t	.word	15-1,DUNKP_SEQ,DUNKB_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKT_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKU_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY5_SEQ

#d4s_t	.word	9-1,DUNKP_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ,DUNKT_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKLAY_SEQ

#d5s_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is med dist from hoop
#d1m_t	.word	14-1,DUNKA_SEQ,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2m_t	.word	38-1,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ,DUNKO_SEQ
	.word	DUNKK_SEQ,DUNKK2_SEQ,DUNKJ2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ
	.word	DUNKJ2_SEQ,DUNKO2_SEQ,DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKW2_SEQ
	.word	DUNKW_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKZ3_SEQ
	.word	DUNKLAY6_SEQ

#d3m_t	.word	47-1,DUNKB_SEQ,DUNKC_SEQ,DUNKE_SEQ,DUNKE2_SEQ
	.word	DUNKL_SEQ,DUNKL4_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKP_SEQ,DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKE_SEQ,DUNKT_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKL_SEQ,DUNKL2_SEQ,DUNKL3_SEQ,DUNKL4_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKP3_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKU_SEQ
	.word	DUNKU2_SEQ
	.word	DUNKU3_SEQ
	.word	DUNKU4_SEQ
	.word	DUNKU5_SEQ
	.word	DUNKU6_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKZ3_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY5_SEQ
	.word	DUNKLAY3_SEQ

#d4m_t	.word	20-1,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKP2_SEQ,DUNKP_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKP_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKLAY_SEQ

#d5m_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is far away from hoop
#d1l_t	.word	4-1,0
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2l_t
	.word	26-1
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ
	.word	DUNKJ2_SEQ,DUNKO2_SEQ,DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKW2_SEQ
	.word	DUNKW_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKZ3_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d3l_t	.word	33-1
	.word	DUNKA2_SEQ
	.word	DUNKP_SEQ,DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKLAY5_SEQ
	.word	DUNKE_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKL_SEQ,DUNKL2_SEQ,DUNKL3_SEQ,DUNKL4_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKP3_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKU2_SEQ
	.word	DUNKU3_SEQ
	.word	DUNKU4_SEQ
	.word	DUNKU5_SEQ
	.word	DUNKU6_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKZ3_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY3_SEQ

#d4l_t	.word	11-1
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKP_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKY2_SEQ
	.word	DUNKLAY_SEQ

#d5l_t	.word	1-1
	.word	DUNKLAY_SEQ


#****************************************************************************
;Set of dunks for #3 skill players

d3u_t	.long	#d1u_t,#d2u_t,#d3u_t,#d4u_t
	.long	#d5u_t,#d4u_t,#d3u_t,#d2u_t, #d1u_t

d3s_t	.long	#d1s_t,#d2s_t,#d3s_t,#d4s_t
	.long	#d5s_t,#d4s_t,#d3s_t,#d2s_t, #d1s_t

d3m_t	.long	#d1m_t,#d2m_t,#d3m_t,#d4m_t
	.long	#d5m_t,#d4m_t,#d3m_t,#d2m_t, #d1m_t

d3l_t	.long	#d1l_t,#d2l_t,#d3l_t,#d4l_t
	.long	#d5l_t,#d4l_t,#d3l_t,#d2l_t, #d1l_t


;Dunks from under hoop
#d1u_t	.word	1-1,DUNKB2_SEQ
#d2u_t	.word	1-1,DUNKB2_SEQ
#d3u_t	.word	1-1,DUNKB2_SEQ			;,DUNKT6_SEQ
#d4u_t	.word	1-1,DUNKG2_SEQ			;,DUNKT6_SEQ
#d5u_t	.word	1-1,DUNKN2_SEQ

;List of dunks that can happen in these dirs if plyr is near hoop
#d1s_t	.word	15-1,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKT_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2s_t	.word	17-1,DUNKB_SEQ,DUNKF_SEQ,DUNKT_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKS_SEQ
	.word	DUNKS2_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY6_SEQ

#d3s_t	.word	11-1,DUNKB_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKT_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKU_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY5_SEQ
	.word	DUNKLAY3_SEQ

#d4s_t	.word	6-1,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ,DUNKT_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKLAY_SEQ

#d5s_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is med dist from hoop
#d1m_t	.word	15-1,DUNKA_SEQ,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2m_t	.word	34-1,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKK_SEQ,DUNKK2_SEQ,DUNKJ2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ
	.word	DUNKJ2_SEQ,DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d3m_t	.word	37-1,DUNKB_SEQ,DUNKC_SEQ,DUNKE_SEQ,DUNKE2_SEQ
	.word	DUNKL_SEQ,DUNKL4_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKE_SEQ,DUNKT_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKL_SEQ,DUNKL2_SEQ,DUNKL3_SEQ,DUNKL4_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKLAY5_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKU_SEQ
	.word	DUNKU6_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY3_SEQ

#d4m_t	.word	14-1,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKLAY_SEQ

#d5m_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is far away from hoop
#d1l_t	.word	3-1
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2l_t
	.word	22-1
	.word	DUNKLAY4_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ
	.word	DUNKJ2_SEQ,DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d3l_t	.word	24-1
	.word	DUNKLAY5_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKE_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKL_SEQ,DUNKL2_SEQ,DUNKL3_SEQ,DUNKL4_SEQ
	.word	DUNKP3_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKU6_SEQ
	.word	DUNKZ_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ

#d4l_t	.word	8-1
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKR_SEQ
	.word	DUNKR2_SEQ
	.word	DUNKLAY_SEQ

#d5l_t	.word	1-1
	.word	DUNKLAY_SEQ

#****************************************************************************
;Set of dunks for #2 skill players

d2u_t	.long	#d1u_t,#d2u_t,#d3u_t,#d4u_t
	.long	#d5u_t,#d4u_t,#d3u_t,#d2u_t, #d1u_t

d2s_t	.long	#d1s_t,#d2s_t,#d3s_t,#d4s_t
	.long	#d5s_t,#d4s_t,#d3s_t,#d2s_t, #d1s_t

d2m_t	.long	#d1m_t,#d2m_t,#d3m_t,#d4m_t
	.long	#d5m_t,#d4m_t,#d3m_t,#d2m_t, #d1m_t

d2l_t	.long	#d1l_t,#d2l_t,#d3l_t,#d4l_t
	.long	#d5l_t,#d4l_t,#d3l_t,#d2l_t, #d1l_t


;Dunks from under hoop
#d1u_t	.word	1-1,DUNKB2_SEQ
#d2u_t	.word	1-1,DUNKB2_SEQ
#d3u_t	.word	1-1,DUNKB2_SEQ			;,DUNKT6_SEQ
#d4u_t	.word	1-1,DUNKG2_SEQ			;,DUNKT6_SEQ
#d5u_t	.word	1-1,DUNKN2_SEQ

;List of dunks that can happen in these dirs if plyr is near hoop
#d1s_t	.word	10-1,DUNKB_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKT_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2s_t	.word	12-1,DUNKB_SEQ,DUNKF_SEQ,DUNKT_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKS_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d3s_t	.word	10-1,DUNKB_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKT_SEQ
	.word	DUNKLAY5_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ

#d4s_t	.word	6-1,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ,DUNKT_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKLAY_SEQ

#d5s_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is med dist from hoop
#d1m_t	.word	10-1,DUNKA_SEQ,DUNKB_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKV_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKV2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2m_t	.word	22-1,DUNKB_SEQ,DUNKF_SEQ
	.word	DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ
	.word	DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKLAY6_SEQ
	.word	DUNKLAY6_SEQ

#d3m_t	.word	24-1,DUNKB_SEQ,DUNKC_SEQ,DUNKE_SEQ,DUNKE2_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKLAY5_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKE_SEQ,DUNKT_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY3_SEQ

#d4m_t	.word	10-1,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKLAY_SEQ

#d5m_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is far away from hoop
#d1l_t	.word	3-1
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY6_SEQ

#d2l_t
	.word	12-1
	.word	DUNKA2_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKF_SEQ
	.word	DUNKK_SEQ,DUNKK2_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKLAY6_SEQ

#d3l_t	.word	16-1
	.word	DUNKA2_SEQ
	.word	DUNKLAY5_SEQ
	.word	DUNKA_SEQ,DUNKB_SEQ,DUNKC_SEQ,DUNKD_SEQ
	.word	DUNKE_SEQ,DUNKE2_SEQ,DUNKD2_SEQ
	.word	DUNKK_SEQ
	.word	DUNKK2_SEQ
	.word	DUNKZ2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ

#d4l_t	.word	7-1
	.word	DUNKD_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ
	.word	DUNKD2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ

#d5l_t	.word	1-1
	.word	DUNKLAY_SEQ



#****************************************************************************
;Set of dunks for #1 skill players

d1u_t	.long	#d1u_t,#d2u_t,#d3u_t,#d4u_t
	.long	#d5u_t,#d4u_t,#d3u_t,#d2u_t, #d1u_t

d1s_t	.long	#d1s_t,#d2s_t,#d3s_t,#d4s_t
	.long	#d5s_t,#d4s_t,#d3s_t,#d2s_t, #d1s_t

d1m_t	.long	#d1m_t,#d2m_t,#d3m_t,#d4m_t
	.long	#d5m_t,#d4m_t,#d3m_t,#d2m_t, #d1m_t

d1l_t	.long	#d1l_t,#d2l_t,#d3l_t,#d4l_t
	.long	#d5l_t,#d4l_t,#d3l_t,#d2l_t, #d1l_t

;Dunks from under hoop
#d1u_t	.word	1-1,DUNKB2_SEQ
#d2u_t	.word	1-1,DUNKB2_SEQ
#d3u_t	.word	1-1,DUNKB2_SEQ			;,DUNKT6_SEQ
#d4u_t	.word	1-1,DUNKG2_SEQ			;,DUNKT6_SEQ
#d5u_t	.word	1-1,DUNKN2_SEQ

;List of dunks that can happen in these dirs if plyr is near hoop
#d1s_t	.word	5-1
;	.word	DUNKV_SEQ
;	.word	DUNKV2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ
	.word	DUNKLAY6_SEQ

#d2s_t	.word	7-1,DUNKF_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKLAY6_SEQ
	.word	DUNKLAY6_SEQ

#d3s_t	.word	5-1
	.word	DUNKLAY5_SEQ
	.word	DUNKB2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ

#d4s_t	.word	5-1,DUNKG_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ

#d5s_t	.word	2-1
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ

;List of dunks that can happen in these dirs if plyr is med dist from hoop
#d1m_t	.word	4-1
;	.word	DUNKV_SEQ
;	.word	DUNKV2_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY6_SEQ
	.word	DUNKLAY6_SEQ
	.word	DUNKLAY2_SEQ

#d2m_t	.word	5-1
;,DUNKF_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY4_SEQ
	.word	DUNKLAY6_SEQ
	.word	DUNKLAY6_SEQ

#d3m_t	.word	4-1
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY5_SEQ

#d4m_t	.word	5-1,DUNKG_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ

#d5m_t	.word	1-1
	.word	DUNKLAY_SEQ


;List of dunks that can happen in these dirs if plyr is far away from hoop
#d1l_t	.word	2-1
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY6_SEQ

#d2l_t
	.word	5-1
	.word	DUNKLAY6_SEQ
;	.word	DUNKF_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY2_SEQ
	.word	DUNKLAY4_SEQ

#d3l_t	.word	4-1
	.word	DUNKLAY_SEQ
	.word	DUNKLAY3A_SEQ
	.word	DUNKLAY3_SEQ
	.word	DUNKLAY5_SEQ

#d4l_t	.word	3-1
;	.word	DUNKG_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ
	.word	DUNKLAY_SEQ

#d5l_t	.word	1-1
	.word	DUNKLAY_SEQ


	.def	McHale_h,Lohaus_h,Gug_h,Laim_h,Edwrd_h,Iuz_h


McHale_h
	.long	McHale1
	.long	McHale1,McHale2,McHale3,McHale4,McHale5
	.long	McHale6,McHale7,McHale8,McHale9,McHale10
	.long	McHale11,McHale12,McHale13,McHale14,McHale15
	.long	McHale16
Lohaus_h
	.long	Lohaus1
	.long	Lohaus1
	.long	Lohaus2,Lohaus3,Lohaus4,Lohaus5,Lohaus6,Lohaus7,Lohaus8,Lohaus9
	.long	Lohaus10,Lohaus11,Lohaus12,Lohaus13,Lohaus14,Lohaus15,Lohaus16
Gug_h
	.long	gug1
	.long	gug1,gug2,gug3,gug4,gug5,gug6,gug7,gug8
	.long	gug9,gug10,gug11,gug12,gug13,gug14,gug15
	.long	gug16
Laim_h
	.long	Laimbeer1
	.long	Laimbeer1,Laimbeer2,Laimbeer3,Laimbeer4,Laimbeer5,Laimbeer6,Laimbeer7,Laimbeer8,Laimbeer9
	.long	Laimbeer10,Laimbeer11,Laimbeer12,Laimbeer13,Laimbeer14,Laimbeer15,Laimbeer16
Edwrd_h
	.long	edwrd1
	.long	edwrd1,edwrd2,edwrd3,edwrd4,edwrd5,edwrd6,edwrd7,edwrd8,edwrd9,edwrd10
	.long	edwrd11,edwrd12,edwrd13,edwrd14,edwrd15,edwrd16
Iuz_h
	.long	iuz1
	.long	iuz1,iuz2,iuz3
	.long	iuz4,iuz5,iuz6,iuz7,iuz8,iuz9,iuz10
	.long	iuz11,iuz12,iuz13,iuz14,iuz15,iuz16
	.long	iuz11,iuz12,iuz13,iuz14,iuz15,iuz16
	.long	iuz11,iuz12,iuz13,iuz14,iuz15,iuz16


	.end


