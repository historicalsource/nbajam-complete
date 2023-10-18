**************************************************************
*
* Software:		Shawn Liptak, Mark Turmell
* Initiated:		9/17/92
*
* Modified:		Shawn Liptak, 9/17/92	-Split from BB.asm
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 12/21/92 18:31
**************************************************************
	.file	"plyr.asm"
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
	.include	"game.equ"
	.include	"shawn.hdr"		;Macros
	.asg		0,SEQT
	.include	"plyr.equ"


;sounds external

;swipe_snd	.word	>f484,>4,>8119,0	;swipe at ball
sqk1_snd	.word	>f584,>4,>8114,0	;Sneaker squeek
sqk2_snd	.word	>f584,>4,>8115,0
sqk3_snd	.word	>f584,>4,>8116,0
sqk4_snd	.word	>f584,>4,>8117,0
airball_snd	.word	>f084,>8,>814d,0	;crowd screams "air ball"
pass_snd	.word	>f3a7,>8,>808c,0	;short pass
whstle_snd	.word	>f9f5,>30,>8149,0	;Ref whistle at game start
whstle2_snd	.word	>f9f5,>30,>8148,0	;Ref whistle for fouls

anncr1_snd	.word	>f9f6,120,>818e,0	;He shoots from downtown
anncr2_snd	.word	>f9f6,110,>8190,0	;He shoots from the outside
anncr4_snd	.word	>f9f6,80,>8183,0	;At the buzzer
anncr5_snd	.word	>f9f6,70,>818b,0	;From long range

pass_speech

 .word	>f9f6,2*TSEC,>81ac,0	;WILKINS TO AUGMON	( ATLANTA )
 .word	>f9f6,2*TSEC,>81ad,0	;AUGMON TO WILKINS

 .word	>f9f6,2*TSEC,>81b4,0	;LEWIS TO McDANIEL	( BOSTON )
 .word	>f9f6,2*TSEC,>81b5,0	;McDANIEL TO LEWIS

 .word	>f9f6,2*TSEC,>81a7,0	;JOHNSN_L TO GILL	( CHARLOTTE )
 .word	>f9f6,2*TSEC,>81a6,0	;GILL TO JOHNSN_L

 .word	>f9f6,2*TSEC,>81a2,0	;PIPPEN TO GRANT_HC	( CHICAGO )
 .word	>f9f6,2*TSEC,>81a3,0	;GRANT_HC TO PIPPEN

 .word	>f9f6,2*TSEC,>81c9,0	;PRICE TO DAUGHRTY	( CLEVELAND )
 .word	>f9f6,2*TSEC,>81c8,0	;DAUGHRTY TO PRICE

 .word	>f9f6,2*TSEC,>81c4,0	;HARPER_D TO JACKSON	( DALLAS )
 .word	>f9f6,2*TSEC,>81c5,0	;JACKSON TO HARPER_D

 .word	>f9f6,2*TSEC,>81cd,0	;MUTUMBO TO ELLIS	( DENVER )
 .word	>f9f6,2*TSEC,>81cc,0	;ELLIS TO MUTUMBO

 .word	>f9f6,2*TSEC,>81ba,0	;THOMAS TO RODMAN	( DETROIT )
 .word	>f9f6,2*TSEC,>81bb,0	;RODMAN TO THOMAS

 .word	>f9f6,2*TSEC,>81b9,0	;HARDAWAY TO MULLIN	( GOLDEN STATE )
 .word	>f9f6,2*TSEC,>81b8,0	;MULLIN TO HARDAWAY

 .word	>f9f6,2*TSEC,>81ca,0	;OLAJUWON TO SMITH	( HOUSTON )
 .word	>f9f6,2*TSEC,>81cb,0	;SMITH TO OLAJUWON

 .word	>f9f6,2*TSEC,>81be,0	;MILLER TO SCHREMPF	( INDIANA )
 .word	>f9f6,2*TSEC,>81bf,0	;SCHREMPF TO MILLER

 .word	>f9f6,2*TSEC,>81c3,0	;MANNING TO HARPER_R	( L.A. CLIPPERS )
 .word	>f9f6,2*TSEC,>81c2,0	;HARPER_R TO MANNING

 .word	>f9f6,2*TSEC,>81c0,0	;WORTHY TO DIVAC	( L.A. LAKERS )
 .word	>f9f6,2*TSEC,>81c1,0	;DIVAC TO WORTHY

 .word	>f9f6,2*TSEC,>81c6,0	;RICE TO SEIKALY	( MIAMI )
 .word	>f9f6,2*TSEC,>81c7,0	;SEIKALY TO RICE

 .word	>f9f6,2*TSEC,>81bd,0	;MALONE_M TO DAY	( MILWAUKEE )
 .word	>f9f6,2*TSEC,>81bc,0	;DAY TO MALONE_M

 .word	>f9f6,2*TSEC,>81d0,0	;LAETNER TO PERSON	( MINNESOTTA )
 .word	>f9f6,2*TSEC,>81d1,0	;PERSON TO LAETNER

 .word	>f9f6,2*TSEC,>81d2,0	;COLEMAN TO PETROVIC	( NEW JERSEY )
 .word	>f9f6,2*TSEC,>81d3,0	;PETROVIC TO COLEMAN

 .word	>f9f6,2*TSEC,>81aa,0	;EWING TO OAKLEY	( NEW YORK )
 .word	>f9f6,2*TSEC,>81ab,0	;OAKLEY TO EWING

 .word	>f9f6,2*TSEC,>81a0,0	;ONEAL TO SKILES	( ORLANDO )
 .word	>f9f6,2*TSEC,>81a1,0	;SKILES TO ONEAL

 .word	>f9f6,2*TSEC,>81d5,0	;HAWKINS TO HORNACEK	( PHILADELPHIA )
 .word	>f9f6,2*TSEC,>81d4,0	;HORNACEK TO HAWKINS

 .word	>f9f6,2*TSEC,>81a8,0	;BARKLEY TO MAJERLE	( PHOENIX )
 .word	>f9f6,2*TSEC,>81a9,0	;MAJERLE TO BARKLEY

 .word	>f9f6,2*TSEC,>81b0,0	;DREXLER TO PORTER	( PORTLAND )
 .word	>f9f6,2*TSEC,>81b1,0	;PORTER TO DREXLER

 .word	>f9f6,2*TSEC,>81cf,0	;TISDALE TO WEBB	( SACRAMENTO )
 .word	>f9f6,2*TSEC,>81ce,0	;WEBB TO TISDALE

 .word	>f9f6,2*TSEC,>81b3,0	;ROBINSON TO ELLIOT	( SAN ANTONIO )
 .word	>f9f6,2*TSEC,>81b2,0	;ELLIOT TO ROBINSON

 .word	>f9f6,2*TSEC,>81af,0	;KEMP TO BENJAMIN	( SEATTLE )
 .word	>f9f6,2*TSEC,>81ae,0	;BENJAMIN TO KEMP

 .word	>f9f6,2*TSEC,>81b6,0	;MALONE_K TO STOCKTON	( UTAH )
 .word	>f9f6,2*TSEC,>81b7,0	;STOCKTON TO MALONE_K

 .word	>f9f6,2*TSEC,>81a4,0	;ELLISON TO GRANT_HV	( WASHINGTON )
 .word	>f9f6,2*TSEC,>81a5,0	;GRANT_HV TO ELLISION


name_speech

 .word	>f9f6,2*TSEC,>80bb,0	;WILKINS	( ATLANTA )
 .word	>f9f6,2*TSEC,>80bc,0	;AUGMON

 .word	>f9f6,2*TSEC,>80c3,0	;LEWIS		( BOSTON )
 .word	>f9f6,2*TSEC,>80c4,0	;McDANIEL

 .word	>f9f6,2*TSEC,>80b6,0	;JOHNSN_L	( CHARLOTTE )
 .word	>f9f6,2*TSEC,>80b5,0	;GILL

 .word	>f9f6,2*TSEC,>80b2,0	;PIPPEN		( CHICAGO )
 .word	>f9f6,2*TSEC,>80b3,0	;GRANT_HC

 .word	>f9f6,2*TSEC,>80d7,0	;PRICE		( CLEVELAND )
 .word	>f9f6,2*TSEC,>80d6,0	;DAUGHRTY

 .word	>f9f6,2*TSEC,>80d1,0	;HARPER_D	( DALLAS )
 .word	>f9f6,2*TSEC,>80d3,0	;JACKSON

 .word	>f9f6,2*TSEC,>80db,0	;MUTUMBO	( DENVER )
 .word	>f9f6,2*TSEC,>80da,0	;ELLIS

 .word	>f9f6,2*TSEC,>80c9,0	;THOMAS		( DETROIT )
 .word	>f9f6,2*TSEC,>80ca,0	;RODMAN

 .word	>f9f6,2*TSEC,>80c8,0	;HARDAWAY	( GOLDEN STATE )
 .word	>f9f6,2*TSEC,>80c7,0	;MULLIN

 .word	>f9f6,2*TSEC,>80d8,0	;OLAJUWON	( HOUSTON )
 .word	>f9f6,2*TSEC,>80d9,0	;SMITH

 .word	>f9f6,2*TSEC,>80cd,0	;MILLER		( INDIANA )
 .word	>f9f6,2*TSEC,>80ce,0	;SCHREMPF

 .word	>f9f6,2*TSEC,>80d2,0	;MANNING	( L.A. CLIPPERS )
 .word	>f9f6,2*TSEC,>80d1,0	;HARPER_R

 .word	>f9f6,2*TSEC,>80cf,0	;WORTHY		( L.A. LAKERS )
 .word	>f9f6,2*TSEC,>80d0,0	;DIVAC

 .word	>f9f6,2*TSEC,>80d4,0	;RICE		( MIAMI )
 .word	>f9f6,2*TSEC,>80d5,0	;SEIKALY

 .word	>f9f6,2*TSEC,>80cc,0	;MALONE_M	( MILWAUKEE )
 .word	>f9f6,2*TSEC,>80cb,0	;DAY

 .word	>f9f6,2*TSEC,>80de,0	;LAETNER	( MINNESOTTA )
 .word	>f9f6,2*TSEC,>80df,0	;PERSON

 .word	>f9f6,2*TSEC,>80e0,0	;COLEMAN	( NEW JERSEY )
 .word	>f9f6,2*TSEC,>80e1,0	;PETROVIC

 .word	>f9f6,2*TSEC,>80b9,0	;EWING		( NEW YORK )
 .word	>f9f6,2*TSEC,>80ba,0	;OAKLEY

 .word	>f9f6,2*TSEC,>80b0,0	;ONEAL		( ORLANDO )
 .word	>f9f6,2*TSEC,>80b1,0	;SKILES

 .word	>f9f6,2*TSEC,>80e3,0	;HAWKINS	( PHILADELPHIA )
 .word	>f9f6,2*TSEC,>80e2,0	;HORNACEK

 .word	>f9f6,2*TSEC,>80b7,0	;BARKLEY	( PHOENIX )
 .word	>f9f6,2*TSEC,>80b8,0	;MAJERLE

 .word	>f9f6,2*TSEC,>80bf,0	;DREXLER	( PORTLAND )
 .word	>f9f6,2*TSEC,>80c0,0	;PORTER

 .word	>f9f6,2*TSEC,>80dd,0	;TISDALE	( SACRAMENTO )
 .word	>f9f6,2*TSEC,>80dc,0	;WEBB

 .word	>f9f6,2*TSEC,>80c2,0	;ROBINSON	( SAN ANTONIO )
 .word	>f9f6,2*TSEC,>80c1,0	;ELLIOT

 .word	>f9f6,2*TSEC,>80be,0	;KEMP		( SEATTLE )
 .word	>f9f6,2*TSEC,>80bd,0	;BENJAMIN

 .word	>f9f6,2*TSEC,>80c5,0	;MALONE_K	( UTAH )
 .word	>f9f6,2*TSEC,>80c6,0	;STOCKTON

 .word	>f9f6,2*TSEC,>80b4,0	;ELLISON	( WASHINGTON )
 .word	>f9f6,2*TSEC,>80b3,0	;GRANT_HV

_shoot4_3_snd
 .word	>f9f8,3*TSEC,>81e6,0	;shoots for 3




;symbols externally defined

	.ref	def_play_reward,flash_reward,sinecos_get,slamming
	.ref	start_animate,pass_off,steals_off,idiot_box

	.ref	plyr_getattributes,snd_play1ovr

	.ref	scores,prt_top_scores
	.ref	score_add,score_showtvpanel2
	.ref	score_showtvpanel,tvpanelon
	.ref	gmqrtr
	.ref	clock_active
	.ref	crplate_ptr
	.ref	shot_clock,shotimer
	.ref	arw_on1plyr
	.ref	cntrs_delay
	.ref	game_time
	.ref	sc_proc
	.ref	stick_number
	.ref	doalert_snd
	.ref	flash_bigtxt

	.ref	inc_player_stat
	.ref	stats_page,hint_page
	.ref	rank_screen
	.ref	result_screen
	.ref	save_player_records
	.ref	game_purchased
	.ref	team1
	.ref	show_ot_msg,scr1

	.ref	winner_stays_on
	.ref	print_string_C2
	.ref	mess_objid
	.ref	setup_message
	.ref	omlgmd_ascii

	.ref	pal_getf,pal_set
	.ref	fade_down_half,fade_up_half

	.ref	SCRTST
	.ref	IRQSKYE
	.ref	PCNT
	.ref	GAMSTATE,HALT
	.ref	gndx
	.ref	AUD,AUD1,GET_AUD,STORE_AUDIT
	.ref	PSTATUS2
	.ref	RNDPER
	.ref	game_over

	.ref	scale63_t

	.ref	ball_convfmprel
	.ref	ballobj_p
	.ref	ballpnum,ballpnumlast,ballpnumshot,ballfree
	.ref	ballpasstime
	.ref	ballscorezhit
	.ref	ballptsforshot
	.ref	ballprcv_p
	.ref	ballgoaltcnt
	.ref	ballsclastp
	.ref	inbound
	.ref	ballflash
	.ref	t1dunkcnt
	.ref	plyr_setptsdown

	.ref	w3run1

;symbols defined in this file

	.def	name_speech


;uninitialized ram definitions

	BSSX	PSTATUS		,16	;Player in game bits (0-3)
					;/Must be in order!
	BSSX	P1CTRL		,16	;P1 joy/but bits (0-3=UDLR, 4-6=B1-B3)
	BSSX	P2CTRL		,16	;P2 (^ 8-14 are on for a on transition
	BSSX	P3CTRL		,16	;P3 of 0-6)
	BSSX	P4CTRL		,16	;P4

	BSSX	P1DATA		,PDSIZE	;Player 1 data
	BSSX	P2DATA		,PDSIZE	;P2
	BSSX	P3DATA		,PDSIZE	;P3
	BSSX	P4DATA		,PDSIZE	;P4

	BSSX	plyrobj_t	,32*4	;*player obj (4)
	BSSX	plyrproc_t	,32*4	;*player process (4)

	BSSX	plyrcharge	,16	;!0=Dunker rammed an opponent
	BSSX	plyrpasstype	,16	;!0=Turbo pass
	BSSX	plyrairballoff	,16	;!0=No airball sound

	.bss	plyrinautorbnd	,16	;!0=A plyr is in auto rebound
	.bss	drnzzcnt	,16	;Drone zigzag mode cntdn
	.bss	drnzzmode	,16	;Drone zigzag mode (0-?)

	.bss	plyrpals_t ,256*16*4	;Assembled palette for each plyr

;equates for this file

PLYRMINX	.equ	WRLDMID-342
PLYRMAXX	.equ	WRLDMID+342-9
PLYRMINX2	.equ	WRLDMID-370
PLYRMAXX2	.equ	WRLDMID+370


	.text


********************************
* Start player processes

 SUBR	plyr_start

;	movk	1,a0
;	move	a0,@>fff80000,L

	clr	a0
	move	a0,@plyrinautorbnd
	move	a0,@plyrcharge
	move	a0,@plyrairballoff

	CREATE0	plyr_referee

	movi	plyrproc_t+4*32,a2
	movi	plyrobj_t+3*32,a9
	movk	3,a8
#strtp	CREATE0	plyr_main
	move	a0,-*a2,L		;Save *proc
	subk	32,a9
	dsj	a8,#strtp

	move	a13,-*a2,L
;	jruc	plyr_main		;#0



#*******************************
* Main player control code (Process)
* A8=Plyr # (0-3)
* A9=*plyrobj_t for plyr #


 SUBRP	plyr_main


	move	a13,a1			;>Clr PDATA & PSDATA areas
	addi	PDATA,a1
	movi	(PRCSIZ-PDATA)/16,a2
	clr	a0
#clrpd	move	a0,*a1+
	dsj	a2,#clrpd


	movi	-1,a1
	move	a1,*a13(plyr_newdir)

	move	a8,*a13(plyr_num)
	move	a8,a11

	movk	1,a7
	xor	a8,a7
	sll	5,a7			;*32
	addi	plyrproc_t,a7
	move	*a7,a7,L
	move	a7,*a13(plyr_tmproc_p),L

	movi	P2DATA-P1DATA,a7,W
	mpyu	a8,a7
	addi	P1DATA,a7
	move	a7,*a13(plyr_PDATA_p),L

	calla	plyr_getattributes	;Set attribute_p


	movi	#pd1-#pdat_t,a7,W
	mpyu	a8,a7
	addi	#pdat_t,a7

	move	*a7+,a0
	move	a0,*a13(PROCID)

	move	*a7+,a1			;Dir
	move	a1,*a13(plyr_dir)

	move	*a7+,a0			;X
	move	@WORLDTLX+16,a1
	add	a1,a0
	sll	16,a0
	clr	a1			;Y
	move	*a7+,a3			;Z
	move	*a7,a2,L
	movi	DMAWNZ|M_3D,a4
	movi	CLSPLYR|TYPPLYR,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a9,L		;Save *obj


	move	*a13(plyr_attrib_p),a7,L
	move	a7,a6
	move	*a7,a0,L		;Get *scale_t
	move	a0,*a8(ODATA_p),L
	move	*a7(PAT_BVEL),a0
	move	a0,*a13(plyr_bvel)

	movi	team1,a14		;>Chk for conflicting pals
	move	*a14+,a3
	move	*a14,a4
	btst	1,a11
	jrz	#t1
	SWAP	a3,a4
#t1	sll	3,a3
	sll	3,a4
	addi	#team_t,a3
	addi	#team_t,a4
	movb	*a3,a3
	jrn	#keepc			;I always keep?
	movb	*a4,a4
	move	a4,a14
	sll	32-4,a3
	sll	32-4,a14
	cmp	a3,a14
	jrne	#keepc			;Different colors?
	move	a4,a4
	jrn	#altc			;Other team always keeps?
	btst	1,a11
	jrnz	#keepc			;2nd team?
#altc	addk	32,a6			;*Alternates
#keepc

	move	a11,a2			;>Build plyr palette
	sll	8+4,a2
	addi	plyrpals_t,a2
	PUSH	a2

	movi	255,a0
	move	a0,*a2+			;Set # colors

	move	*a6(PAT_PALU_p),a1,L	;Copy uniform
	move	*a1+,a0
#plulp	move	*a1+,*a2+
	dsj	a0,#plulp

	move	*a7(PAT_PALF_p),a1,L	;Copy flesh
	move	*a1+,a0
	addk	16,a1
	subk	1,a0
#plflp	move	*a1+,*a2+
	dsj	a0,#plflp

	move	*a6(PAT_PALT_p),a1,L	;Copy trim
	move	*a1+,a0
	addk	16,a1
	subk	1,a0
#pltlp	move	*a1+,*a2+
	dsj	a0,#pltlp

	movi	31<<10+31<<5+31,a0	;White
	move	a0,*a2+

	movi	ltshoepal_t,a1		;Copy shoes
;	btst	0,a11
;	jrz	#p02
;	movi	dkshoepal_t,a1
;#p02
	movk	5,a0			;5 colors
#plslp	move	*a1+,*a2+
	dsj	a0,#plslp

	clr	a0			;Black
	move	a0,*a2+

	PULL	a0
	calla	pal_getf
	move	a0,*a8(OPAL)


	PUSH	a8

	clr	a0			;>Get head
	clr	a1
	move	*a7(PAT_HEADT_p),a2,L
	move	*a2,a2,L
	movi	CZMID,a3		;Z
	movi	DMAWNZ|M_3D|M_NOCOLL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(plyr_headobj_p),L
	move	*a13(plyr_attrib_p),a0,L
	move	*a0,a0,L		;Get *scale_t
	addi	SCALETSIZE*2,a0
;	addi	>200,a0			;Small bodies big hds funny option
;	addi	>800,a0			;Our heads & dipswitch option
	move	a0,*a8(ODATA_p),L

	clr	a0			;>Get shadow
	clr	a1
	movi	shadow1,a2
	move	*a8(OZPOS),a3
	subi	50,a3
	movi	DMAWNZ|M_3D|M_SHAD|M_NOCOLL,a4
	calla	BEGINOBJ2
	move	a8,*a13(plyr_shadobj_p),L
	movi	50,a0
	move	a0,*a8(OMISC)		;Z offset

	PULL	a8



	.if	DEBUG
;	callr	plyr_getgndaligndot
	.endif


	sll	4,a11			;*16
	addi	P1CTRL,a11		;A11=*PxCTRL


	movk	STND_SEQ,a0		;Initial sequence
	move	*a13(plyr_dir),a7
	callr	plyr_setseq		;Rets: A10=Ani cntdn


	movi	HOOPLX,a0
	movi	HOOPRX,a1
	move	*a13(plyr_num),a14
	subk	2,a14
	jrlt	#_p0or1
	SWAP	a0,a1
#_p0or1	move	a0,*a13(plyr_myhoopx)
	move	a1,*a13(plyr_ohoopx)


;	move	*a13(plyr_num),a0	;DEBUG
;	subk	2,a0
;	jreq	#num2
;	SLEEP	30000
;#num2

	SLEEPK	2			;Wait for others to establish data

;---------------------------

#lp
	move	@HALT,a0
	jrnz	#halted


	.if	IMGVIEW
	move	*a13(plyr_num),a0
	cmpi	0,a0
	jrz	#yes
	cmpi	3,a0
	jrne	#halted
#yes
	movk	1,a2			;+=Me
	jruc	#nobl2
	.endif


;This could be a dipswitch setting for our home games
;FIX
	move	@DIPSWITCH,a0
	btst	0,a0			;UJ2 switch 8
	jrnz	#notfair		;OFF?
	clr	a0
	move	a0,*a13(plyr_ptsdown)
#notfair

	clr	a2			;>Set flag if we have ball
	move	*a13(plyr_num),a0
	move	@ballpnum,a1
	cmp	a1,a0
	jrne	#nobl1			;No ball?
	move	*a13(plyr_seqflgs),a14
	btst	NOBALL_B,a14
	jrnz	#nohold			;Can't hold the ball?

	move	*a13(plyr_ownball),a0
	jrgt	#hadball		;Already had?

	move	@ballobj_p,a1,L
	move	*a1(OYPOS),a0
	cmpi	-28,a0
	jrlt	#inair
	move	*a1(OYVEL),a0,L
	abs	a0
	cmpi	>c000,a0
	jrgt	#inair
	move	*a13(plyr_jmpcnt),a0
	jrnz	#nohold			;In air?

	movi	PICKUP_SEQ,a0
	move	*a13(plyr_dir),a7
	callr	plyr_setseq
#inair	movk	1,a2			;+=Me
	jruc	#nobl2
#nohold
	subk	1,a2			;-1
	move	a2,@ballpnum
	move	a2,@ballpnumlast
	calla	ball_convfmprel
	clr	a2
	jruc	#nobl2
#nobl1
	XORK	1,a0
	cmp	a1,a0
	jrne	#nobl2			;No ball?
	subk	1,a2			;-=Teammate
#nobl2
	move	a2,*a13(plyr_ownball)

	move	a2,a2
	jrle	#hadball

	PUSH	a10
	move	a13,a10
	calla	arw_on1plyr		;Guy who picks up ball gets arw
	PULL	a10

	move	*a13(plyr_num),a0
	srl	1,a0			;A0=0/1 for left/rgt hoop start clock
	move	@ballsclastp,a1
	srl	1,a1
	cmp	a0,a1
	jreq	#hadball		;Same team?

	calla	shot_clock		;New 24

#hadball


	clr	a0			;>Setup turbo flag
	move	*a13(plyr_nojoy),a6
	jrn	#newjoy			;Override plyr input?
	move	*a11,a6
#newjoy	btst	BUT3_B,a6		;Turbo but
	jrz	#turboff
	move	*a13(plyr_PDATA_p),a1,L
	move	*a1(ply_turbo),a1
	jrz	#turboff		;No turbo left?
	movk	1,a0
#turboff
	move	a0,*a13(plyr_turbon)



	move	*a13(plyr_num),a4	;>Do 1 in 4 ticks
	move	@PCNT,a0
	move	a4,a1
	sll	32-2,a0
	sll	32-2,a1
	cmp	a0,a1
	jrne	#skip

	movk	1,a14			;>Get teammates dir/dist
	xor	a4,a14
	sll	5,a14			;*32
	addi	plyrobj_t,a14
	move	*a14,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_tmdir)
	move	a1,*a13(plyr_tmdist)

	srl	1,a4			;>Get opponents dir/dist
	movk	1,a14
	xor	a14,a4
	sll	6,a4			;*64
	addi	plyrobj_t,a4
	move	*a4+,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_o1dir)
	move	a1,*a13(plyr_o1dist)

	move	*a4+,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_o2dir)
	move	a1,*a13(plyr_o2dist)

	move	@ballobj_p,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_balldir)
	move	a1,*a13(plyr_balldist)

	move	*a13(plyr_myhoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_hpdir)
	move	a1,*a13(plyr_hpdist)

	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_ohpdir)
	move	a1,*a13(plyr_ohpdist)


#skip	clr	a14			;>Setup defensive flag
	move	@ballpnum,a0
	jrn	#setdef			;No owner?
	move	*a13(plyr_ownball),a0
	jrnz	#setdef			;My team has?

	move	*a13(plyr_hpdist),a0
	cmpi	220,a0
	jrge	#setdef			;Too far from my hoop?

	move	*a13(plyr_hpdir),a0	;Find dir difference
	move	*a13(plyr_balldir),a1
	sub	a1,a0
	abs	a0
	cmpi	>40,a0
	jrle	#dsml
	subi	>80,a0
	abs	a0
#dsml	subk	24,a0
	jrle	#setdef			;Not between ball and hoop?

	move	*a13(plyr_seq),a2
	cmpi	RUNDRIBTURB_SEQ,a2
	jrhi	#setdef
	move	*a13(plyr_o1dist),a1
	cmpi	90,a1
	jrlt	#defon
	move	*a13(plyr_o2dist),a1
	cmpi	90,a1
	jrge	#setdef
#defon	movk	1,a14
#setdef	move	a14,*a13(plyr_indef)



;-------


	move	*a13(plyr_autoctrl),a0
	jrnz	#tcc			;Temp computer control?


	move	*a13(plyr_seqflgs),a0
	btst	NOCOLLP_B,a0
	jrnz	#nocol			;No collide?
	callr	plyr_chkpcollide
#nocol


					;>Stagger/fall
	move	*a13(plyr_stagcnt),a2
	jrle	#nostag
	subk	1,a2
	move	a2,*a13(plyr_stagcnt)
	subk	15,a2
	jrle	#nostag

	move	*a13(plyr_seq),a14

	subk	30-15,a2
	jrle	#chkstag		;Chk stag?

	movi	FLYBACK_SEQ,a0
	cmp	a0,a14
	jreq	#cstag
	cmpi	FLYBACKWB_SEQ,a14
	jreq	#cstag
	cmpi	FLYBACKWB2_SEQ,a14
	jreq	#cstag
	cmpi	FLYBACK2_SEQ,a14
	jreq	#cstag

	move	*a13(plyr_ownball),a1
	jrle	#fall

;If toward rear edge of court and is being pushed back into crowd, always do
;normal flyback and never keep ball!

	movi	FLYBACK_SEQ,a0

	move	*a8(OZPOS),a1
	cmpi	>410,a1
	jrgt	#not_rear
	move	*a8(OZVEL),a1,L
	jrn	#fall			;Heading over scores table?

#not_rear
	move	*a13(plyr_ptsdown),a1
	jrle	#fall			;I'm winning?

;If player is in elbo mode, have him keep ball more often!

	movi	400,a0			;40% chance of keeping ball if in ELBO
	cmpi	ELBO_SEQ,a14		;Could also do ELBO2_SEQ
	jrz	#fbnorm

	movi	150,a0			;15% chance of keeping ball if winning
	move	*a13(plyr_ptsdown),a1
	jrle	#fbnorm			;!Losing?
	cmpi	15,a1
	jrle	#fbmok
	movk	15,a1
#fbmok	sll	4,a1
	addi	#flyb_t,a1
	move	*a1,a0
#fbnorm
	calla	RNDPER
	jrls	#fb

;Yes, keep ball even though I've been pushed.

	clr	a0
	move	a0,*a13(plyr_dribmode)	;Allow dribble when he gets up

;Rules for using short flyback/WITH BALL sequence:
;If in dunk, don't do short flybacks
;If in jump shot, 50%
;If losing, 50%
;What else?

	movi	FLYBACKWB_SEQ,a0

	move	*a13(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrnz	#fall			;In dunk?


	move	*a13(plyr_seq),a14
	subk	SHOOT_SEQ,a14		;Am I shooting?
	jrz	#_50_50

	move	*a13(plyr_ptsdown),a1
	jrle	#fall			;I'm winning?
#_50_50
;I'm losing or shooting, 50% of time don't fly all the way back.
	move	@HCOUNT,a1
	btst	0,a1
	jrz	#fall

	move	*a8(OZVEL),a0,L		;He lucked out, fly short distance
	sra	2,a0
	move	a0,*a8(OZVEL),L
	move	*a8(OXVEL),a0,L
	sra	2,a0
	move	a0,*a8(OXVEL),L

	movi	FLYBACKWB2_SEQ,a0
	jruc	#fall

#fb
;Rules for using short flyback/NO BALL sequence:
;If in dunk, don't do short flybacks
;If losing, 35%
;What else?

	movi	FLYBACK_SEQ,a0

	move	*a13(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrnz	#fall			;In dunk?

	move	*a13(plyr_ptsdown),a1
	jrle	#fall			;Br= I'm winning!

;I'm losing, 35% of time don't fly all the way back.
	movi	350,a0
	calla	RNDPER
	jrhi	#fly_short

	movi	FLYBACK_SEQ,a0
	jruc	#fall

#fly_short
;He lucked out, make him fly short distance
	move	*a8(OZVEL),a0,L
	sra	2,a0
	move	a0,*a8(OZVEL),L
	move	*a8(OXVEL),a0,L
	sra	2,a0
	move	a0,*a8(OXVEL),L

	movi	FLYBACK2_SEQ,a0

	jruc	#fall

#chkstag
	move	*a13(plyr_jmpcnt),a1
	jrz	#stag			;On gnd?

	movi	FALL_SEQ,a0
	cmp	a14,a0
	jrne	#fall
	jruc	#cstag

#stag	subi	STAGGER_SEQ,a14
	jreq	#nostag
	subk	FALL_SEQ-STAGGER_SEQ,a14
	jreq	#cstag

	movk	3,a0
	callr	rnd
	jrnz	#nostag
	movi	STAGGER_SEQ,a0

#fall
	move	*a13(plyr_dir),a7
	callr	plyr_setseq
#cstag	clr	a2
	move	a2,*a13(plyr_stagcnt)
#nostag


;-------


	move	@PSTATUS,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	btst	a1,a0
	jrnz	#human
	callr	drone_main
#human
#tcc

	move	*a13(plyr_indef),a14
	jrz	#nodef
	move	*a13(plyr_balldir),*a13(plyr_newdir)

#nodef
	move	*a11,a6			;A6=Ctrl bits

;	move	*a13(plyr_jmpcnt),a0
;	jrnz	#clrsb			;In air?

	movb	*a13(plyr_seqflgs+NOJOY_B-7),a0
	jrn	#clrsb			;Joy off?

	move	*a13(plyr_nojoy),a0
	jrz	#joyon			;Joystick on?
	jrgt	#clrsb
	move	a0,a6
	jruc	#joyon
#clrsb
	srl	4,a6			;Clr stick bits
	sll	4,a6
#joyon
	move	*a13(plyr_dir),a7	;A7=Dir

	move	*a13(plyr_newdir),a0
	jrn	#stick			;No forced dir?
	sub	a7,a0
	jrnz	#turn
	movi	-1,a0
	move	a0,*a13(plyr_newdir)

#stick
	move	*a13(plyr_autoctrl),a1
	jrnz	#rok

	move	*a8(OZPOS),a0		;>Clr joy bits that make us go out of bounds
	cmpi	CZMIN+8,a0
	jrgt	#upok			;OK?
	movk	JOYU_M,a0
	andn	a0,a6
#upok
	cmpi	GZMAX-6,a0
	jrlt	#dnok			;OK?
	movk	JOYD_M,a0
	andn	a0,a6
#dnok
	move	*a8(OXPOS),a0
	move	*a8(OXANI+16),a14
	add	a14,a0
	cmpi	PLYRMINX,a0
	jrgt	#lok			;OK?
	movk	JOYL_M,a0
	andn	a0,a6
#lok
	cmpi	PLYRMAXX,a0
	jrlt	#rok			;OK?
	movk	JOYR_M,a0
	andn	a0,a6
#rok

	move	a6,a0
	sll	32-4,a0
	jrz	#setdt			;No stick?

	srl	32-4-3,a0		;>Convert to dir 0-127
	addi	#dirc_t,a0
	movb	*a0,a0

	sub	a7,a0			;A0=Difference
	jrz	#samedir

#turn	move	a0,a1			;>Turn the shortest way
	abs	a0

	subk	6,a0
	jrge	#340			;Far?
	add	a1,a7			;Make exact
	jruc	#380

#340	cmpi	64-6,a0
	jrle	#350
	neg	a1
#350	move	a1,a1
	jrnn	#360
	subk	12,a7			;-6
#360	addk	6,a7			;+6

#380	sll	32-7,a7			;Make 0-127
	srl	32-7,a7
	move	a7,*a13(plyr_dir)

	movk	>1f,a0
	callr	rnd
	jrnz	#nosq			;No squeak?
	move	@PCNT,a0
	movk	3,a1
	and	a1,a0
	sll	5,a0
	addi	#sqsnds,a0
	move	*a0,a0,L
	calla	snd_play1
#nosq

	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	#nodir
	move	*a13(plyr_seqdir),a0
	move	a7,a1			;Dir
	addk	8,a1
	sll	32-7,a1
	srl	32-7+4,a1		;Kill frac
	cmp	a0,a1
	jreq	#nodir			;Already in this dir?
	move	*a13(plyr_seq),a0
	callr	plyr_setseq
#nodir	clr	a0
	jruc	#setdt

#samedir
	move	*a13(plyr_dirtime),a0
	addk	1,a0
#setdt	move	a0,*a13(plyr_dirtime)



;-------


					;>Movement/boundary check
	move	*a8(OXVEL),a2,L
	move	*a8(OZVEL),a3,L

	move	*a13(plyr_jmpcnt),a0
	jrnz	#drift			;Jumping?

	move	*a13(plyr_seqflgs),a4
	btst	DRIFT_B,a4
	jrz	#nodrift

#drift	move	*a8(OXPOS),a4		;>Put drag on vel if we drift too far
	move	*a8(OXANI+16),a0
	add	a0,a4
	move	*a8(OZPOS),a5

	move	a3,a3
	jrge	#zvpos
	cmpi	CZMIN+8,a5
	jrgt	#chkx			;OK?
	jruc	#ydrag

#zvpos	cmpi	GZMAX-6,a5
	jrlt	#chkx			;OK?
#ydrag	move	a3,a0			;-1/4 from vel
	sra	2,a0
	sub	a0,a3

#chkx
	move	a2,a2
	jrge	#xvpos
	cmpi	PLYRMINX2,a4
	jrgt	#setvel			;OK?
	jruc	#xdrag
#xvpos
	cmpi	PLYRMAXX2,a4
	jrlt	#setvel			;OK?
#xdrag	move	a2,a0			;-1/4 from vel
	sra	2,a0
	sub	a0,a2
	jruc	#setvel


#nodrift
	move	a2,a0			;>-1/4 from XZVEL
	sra	2,a0
	sub	a0,a2
	move	a3,a0
	sra	2,a0
	sub	a0,a3

	btst	NOMV_B,a4
	jrnz	#setvel			;No moving?


	move	*a13(plyr_autoctrl),a1
	jrz	#noautoc
	movi	>1a000,a14
	jruc	#noturb

#noautoc
	move	*a13(plyr_bvel),a14
	sll	4,a14

	move	*a13(plyr_offscrn),a1
	jrz	#onscrn
	addi	>e000,a14		;Speedup when offscrn on defense
	clr	a1
	move	a1,*a13(plyr_offscrn)
#onscrn

	move	*a13(plyr_ownball),a1
	jrz	#chkturb
	subi	>e00,a14		;Slow offense down
	move	a1,a1
	jrn	#chkturb		;Buddy has ball?
	subi	>1000,a14		;Slow him down
#chkturb
	move	*a13(plyr_turbon),a0
	jrz	#noturb
	addi	>3e00,a14
#noturb
	movk	11b,a0
	and	a6,a0
	jrz	#nodiag			;Neither up or dn?
	movk	1100b,a0
	and	a6,a0
	jrz	#nodiag			;Neither lft or rgt?
	move	a14,a0
	sra	3,a0
	sub	a0,a14			;-12%
#nodiag

;	btst	4,a6			;3point DEBUG
;	jrz	#DEBUG
;	movi	>2000,a14
;#DEBUG

	move	*a8(OXPOS),a4
	move	*a8(OXANI+16),a0
	add	a0,a4
	move	*a8(OZPOS),a5

	btst	JOYU_B,a6
	jrz	#noup
	cmpi	CZMIN+8,a5
	jrle	#noup			;Min?
	sub	a14,a3
#noup
	btst	JOYD_B,a6
	jrz	#nodn
	cmpi	GZMAX-6,a5
	jrge	#nodn			;Max?
	add	a14,a3
#nodn
	btst	JOYL_B,a6
	jrz	#chkr
	sub	a14,a2
	cmpi	PLYRMINX,a4
	jrgt	#setvel			;In bounds?
	move	*a13(plyr_autoctrl),a0
	jrnz	#setvel
	add	a14,a2
	jruc	#setvel
#chkr
	btst	JOYR_B,a6
	jrz	#setvel
	add	a14,a2
	cmpi	PLYRMAXX,a4
	jrlt	#setvel			;In bounds?
	move	*a13(plyr_autoctrl),a0
	jrnz	#setvel
	sub	a14,a2

#setvel	move	a2,*a8(OXVEL),L
	move	a3,*a8(OZVEL),L
#nomv


;-------

					;>Do turbo meters
	btst	BUT3_B,a6		;Turbo but
	jrz	#turdone


;Allow guy with ball to throw elbows if turbo button pressed twice quickly
	btst	BUT3_B+8,a6
	jrz	#noelbo

	move	*a13(plyr_tbutn),a14
	clr	a0
	move	a0,*a13(plyr_tbutn)
	subk	1,a14
	jrlt	#noelbo			;Too quick?
	subk	8-1,a14
	jrgt	#noelbo			;Too late?

	move	*a13(plyr_seq),a14
	cmpi	STNDWB_SEQ,a14
	jreq	#ok
	subk	STNDDRIB_SEQ,a14
	jrne	#noelbo
#ok
;	move	*a13(plyr_num),a0
;	move	@PSTATUS,a2
;	btst	a0,a2
;	jrz	#notingame
					;Shrink turbo meter for this plyr
	move	*a13(plyr_PDATA_p),a2,L
	move	*a2(ply_turbo),a1
	cmpi	>14,a1			;>2f is max
	jrlt	#noelbo			;Turbo too low?
	subk	>12,a1			;Use a bunch up!
	move	a1,*a2(ply_turbo)
	move	*a2(ply_meter_imgs+40h),a0,L
	move	*a0(OFSET),a1		;Shrink meter
	addk	>12,a1
	move	a1,*a0(OFSET)

#notingame
	movi	60,a0
	move	a0,@steals_off		;Don't allow steals for 60 ticks

	movi	ELBO2_SEQ,a0
	callr	plyr_setseq
	jruc	#turdone
#noelbo


;	move	*a13(plyr_num),a0	;Don't allow drones to mess with
;	move	@PSTATUS,a2		;img ofsets!
;	btst	a0,a2
;	jrz	#turdone

	move	*a13(plyr_PDATA_p),a0,L
	move	*a0(ply_turbo),a1	;Turbo info in PxDATA (0-2f OXSIZE)
	jrz	#turdone		;No turbo left?
	move	*a0(ply_turbo_dl),a2	;Cnt for delaying dec of ply_turbo
	subk	1,a2
	move	a2,*a0(ply_turbo_dl)
	jrnz	#turdone

	movk	8,a2			;Rate of decline adjustment
	move	a2,*a0(ply_turbo_dl)
	subk	1,a1
	move	a1,*a0(ply_turbo)	;Turbo meter size to get smaller

	movk	4,a1
	move	a1,*a0(used_turbo)	;Cntr for replenishing meter after use

	move	*a0(ply_meter_imgs+40h),a0,L	;LITUP img 
	move	*a0(OFSET),a1		;Need to shrink LITUP img
	addk	1,a1
	move	a1,*a0(OFSET)
#turdone

	move	*a13(plyr_tbutn),a0	;Ticks since turbo button last hit
	addk	1,a0			
	move	a0,*a13(plyr_tbutn)


	move	*a13(plyr_shtdly),a0
	jrle	#nodly			;No delay?
	subk	1,a0
	move	a0,*a13(plyr_shtdly)
#nodly


;-------


	move	*a13(plyr_rcvpass),a0	;>Pass receiving
	jrle	#norcvp			;No pass?
	subk	1,a0
	move	a0,*a13(plyr_rcvpass)
	jrgt	#norcvp			;Not yet?
;	move	*a13(plyr_nojoy),a1
	move	a0,*a13(plyr_nojoy)
;	move	@ballobj_p,a2,L
;	move	*a2(OYVEL+16),a0
;	jrge	#balllow
;	move	*a8(OYPOS),a0
;	subk	10,a0
;	move	*a2(OYPOS),a1
;	cmp	a0,a1
;	jrgt	#balllow
;	subk	REBOUND_SEQ,a1
;	jrne	#noreb
;	movk	REBOUND_SEQ,a0
;	callr	plyr_setseq
;#noreb
#norcvp



	move	*a13(plyr_seq),a2
	cmpi	RUNDRIBTURB_SEQ,a2
	jrhi	#anicnt

	move	a6,a1			;>Change ani if no joy
	sll	32-4,a1
	jrz	#nojoy			;Joy neutral?


	movi	38,a14			;Delay before auto turn toward ball
	move	*a13(plyr_ownball),a0
	jrz	#indef
	movi	60,a14			;^
#indef	move	a14,*a13(plyr_turndelay)


	move	*a13(plyr_indef),a14
	jrz	#nodef2

	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	#anicnt

	srl	32-4-3,a1		;>Convert to dir 0-127
	addi	#dirc_t,a1
	movb	*a1,a1

	sub	a7,a1
	move	a1,a14			;Calc dir dist
	abs	a14
	cmpi	>40,a14
	jrle	#diffsml
	neg	a1
	subi	>80,a14
	abs	a14
#diffsml
	movk	WALKFDEF_SEQ,a0
	cmpi	16,a14
	jrlt	#setseq
	movk	WALKBDEF_SEQ,a0
	cmpi	>30,a14
	jrgt	#setseq
	movk	WALKLDEF_SEQ,a0
	move	a1,a1
	jrn	#setseq
	movk	WALKRDEF_SEQ,a0
	jruc	#setseq

#nodef2
	movk	RUN_SEQ,a0		;>Setup run sequence
	move	*a13(plyr_ownball),a14
	jrle	#nobl
	move	*a13(plyr_dribmode),a14
	jrn	#stndwb			;Can't drib?
	movk	RUNDRIB_SEQ,a0
#nobl
	move	a0,a1
	move	*a13(plyr_turbon),a14
	jrz	#slow
	addk	1,a0			;Turbo version
#slow
	addk	1,a1
	sub	a2,a1
	subk	1,a1
	jrhi	#setseq			;Different type?

	move	*a13(plyr_ani_p),a14,L
	move	*a14+,a14
	jrnz	#anicnt			;!At end?
	jruc	#setseq

#nojoy
	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	#anicnt

	movk	STNDDEF_SEQ,a0		;>Setup stand sequence
	movk	STNDDRIBDEF_SEQ,a1
	move	*a13(plyr_indef),a14
	jrnz	#chkb

	movk	STND2_SEQ,a0
	movk	STNDDRIB_SEQ,a1

	move	*a13(plyr_turndelay),a14
	jrz	#turnok1
	subk	1,a14
	move	a14,*a13(plyr_turndelay)
	subk	20,a14
	jrgt	#chkb
#turnok1
	move	*a13(plyr_o1dist),a14
	cmpi	155,a14
	jrlt	#stnd0
	move	*a13(plyr_o2dist),a14
	cmpi	155,a14
	jrgt	#stnd1
#stnd0
	movk	STND_SEQ,a0
	movk	STNDDRIB2_SEQ,a1
#stnd1

	move	*a13(plyr_ownball),a14
	jrle	#chka
	move	*a13(plyr_turndelay),a14
	jrz	#turnok0
	dec 	a14
	move	a14,*a13(plyr_turndelay)
	jruc	#chkb

#turnok0
	move	*a13(plyr_ohpdir),a14
	move	a14,*a13(plyr_newdir)
	jruc	#chkb
#chka
	move	*a13(plyr_turndelay),a14
	jrz	#turnok
	dec 	a14
	move	a14,*a13(plyr_turndelay)
	jruc	#chkb
#turnok	move	*a13(plyr_balldir),a14
	move	a14,*a13(plyr_newdir)



#chkb	move	*a13(plyr_ownball),a14
	jrle	#setseq
	move	a1,a0
	move	*a13(plyr_dribmode),a14
	jrgt	#setseq			;Dribbling?
#stndwb	movk	STNDWB_SEQ,a0
	move	@inbound,a14
	jrnn	#setseq
	move	*a13(plyr_num),a14
	btst	0,a14
	jrnz	#setseq
	movk	STNDWB2_SEQ,a0


#setseq	cmp	a0,a2
	jreq	#anicnt

	.if	IMGVIEW
	movi	debug_SEQ1,a0
	.endif

	callr	plyr_setseq



#anicnt	dsj	a10,#noani

	move	*a13(plyr_ani_p),a14,L		;>Set new ani
#getdel	move	*a14+,a10			;Delay
	jrnn	#nocode				;Not code?

	move	*a14+,a0,L			;*Code
	move	a14,b4
	call	a0				;Can trash scratch, A2-A5
	move	b4,a14
	jruc	#getdel

#nocode	jrnz	#100
	move	*a13(plyr_seqcode_p),a0,L
	jrge	#noendc
	call	a0				;Can trash scratch, A2-A5
#noendc	move	*a13(plyr_ani1st_p),a14,L	;Head of list
	move	*a14+,a10

#100	move	*a14+,a0,L			;*Img
	move	*a14+,a1			;Flags (OCTRL)
	move	*a13(plyr_anirevff),a2		;Get reverse flip flag
	xor	a2,a1
	move	a1,a4

	move	*a0(IANI2Z),*a13(plyr_ballzo)

	move	a14,*a13(plyr_ani_p),L
	callr	plyr_ani

	callr	anipt2_getsclxy
	move	a0,*a13(plyr_ballxo),L
	sra	16,a1
	move	a4,a4
	jrnn	#ynorm				;!YFree flag?
	movi	-200,a1
#ynorm	move	a1,*a13(plyr_ballyo)

	move	*a13(plyr_jmpcnt),a14
	jrnz	#injmp				;Jumping?

	move	*a13(plyr_aniy),a1
	neg	a1
	move	a1,*a8(OYPOS)			;Set on gnd

	cmpi	30,a10
	jrlt	#injmp
	movk	4,a10
#injmp

	move	*a8(OIMG),a2,L			;>Set new head img
	move	*a2(IANI3ID),a1
	sll	5,a1				;*32
	move	*a2(IANI3Z),a14
	neg	a14

	move	*a13(plyr_attrib_p),a0,L
	move	*a0(PAT_HEADT_p),a0,L
	add	a1,a0
	move	*a0,a4,L

	move	*a13(plyr_headobj_p),a3,L
	move	a14,*a3(OMISC)
	move	a4,*a3(OIMG),L			;Set new img
	move	*a4,a14,L
	move	a14,*a3(OSIZE),L
	move	*a4(ISAG),*a3(OSAG),L

	setf	1,0,0
	move	*a8(OCTRL+4),*a3(OCTRL+4)	;Copy HFlip bit
	move	*a2(IFLAGS+FLIPH_IFB),a14	;Chk reverse bit
	jrz	#nohflip
	move	*a3(OCTRL+4),a14		;Reverse hflip
	addk	1,a14
	move	a14,*a3(OCTRL+4)
#nohflip
	setf	16,1,0
#noani


;-------


	move	*a13(plyr_jmpcnt),a0	;>Jumping
	jrz	#noj
	addk	1,a0
	move	a0,*a13(plyr_jmpcnt)

	move	*a13(plyr_hangcnt),a0
	jrle	#nohang			;Not hanging?
	subk	1,a0
	move	a0,*a13(plyr_hangcnt)
	jruc	#pass			;Skip grav
#nohang
	move	*a8(OYVEL),a0,L
	move	*a13(plyr_ownball),a14
	jrgt	#grav			;Have ball?
;	btst	BUT1_B,a6		;Mario like jump
;	jrnz	#grav
;	addi	GRAV/2,a0		;+Grav/2
#grav	addi	GRAV,a0			;+Gravity
	jrn	#200
	move	*a8(OYPOS),a1
	move	*a13(plyr_aniy),a14
	add	a14,a1			;Ani pt position
	jrlt	#200			;Above gnd
	neg	a14
	move	a14,*a8(OYPOS)		;Set on gnd

	.if	DEBUG
;	clr	a0
;	move	a0,@slowmotion
	.endif

	movk	1,a10			;Run landing seq
	clr	a0
	move	a0,*a13(plyr_jmpcnt)
#200	move	a0,*a8(OYVEL),L

	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	#znubb			;In dunk?

	move	*a8(OZPOS),a1		;Get SZ
	subi	CZMID,a1
	abs	a1
	cmpi	40,a1
	jrge	#znubb
	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	subi	WRLDMID,a0
	abs	a0
	move	a0,a3
	movi	>20000,a14
	cmpi	HOOPRX-WRLDMID+13,a0
	jrge	#undrbb			;Under backboard?

	subk	10,a1
	jrgt	#znubb
	cmpi	HOOPRX-WRLDMID-8,a3
	jrlt	#znubb			;!Under rim?
;	cmpi	HOOPRX-WRLDMID+13,a3
;	jrgt	#znubb			;!Under rim?

	movi	>10000,a14
	move	*a8(OXVAL),a1,L
	cmpi	WRLDMID<<16,a1
	jrlt	#rhoop
	neg	a14
#rhoop	add	a14,a1
	move	a1,*a8(OXVAL),L

	movi	>10000,a14
#undrbb
	move	*a8(OZVAL),a1,L
	cmpi	CZMID<<16,a1
	jrge	#dzpos			;In front of?
	neg	a14
#dzpos	add	a14,a1
	move	a1,*a8(OZVAL),L

#znubb

	move	*a13(plyr_ownball),a1
	jrle	#pass			;No ball?

	move	*a13(plyr_jmpcnt),a0
	subk	12,a0
	jrlt	#pass			;Too soon?

;	move	*a8(OYVEL+16),a0
;	jrn	#chkb1

	move	*a8(OYPOS),a1
	move	*a13(plyr_aniy),a14
	add	a14,a1			;Ani pt position
	addk	15,a1
	jrlt	#chkb1			;High enough?

	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	#slp			;Already started?

;	btst	BUT2_B+8,a6
;	jrnz	#dopass			;Air dish off pass?

	btst	SHOOT_B,a0
	jrz	#slp

	move	@gmqrtr,a0
	jrnz	#shoot2
					;Force him to shoot 
;Turmell
	movk	5,a0
	move	*a13(plyr_num),a1
	calla	idiot_box		;Tell him to release ball at peak of jump

	jruc	#shoot2			;Too low?


#chkb1
	btst	BUT1_B,a6
	jrnz	#pass			;Holding shoot button?

	btst	BUT2_B+8,a6
	jrnz	#dopass			;Air dish off pass?

	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	#slp			;Already started?

	btst	SHOOT_B,a0
	jrz	#slp

#shoot2
	callr	plyr_shoot
	movk	1,a10
	jruc	#pass




#noj	move	@ballpnum,a0
	jrge	#sblk			;Somebody has ball?
	move	*a13(plyr_seq),a0
	cmpi	RUNDRIBTURB_SEQ,a0
	jrhi	#sblk			;Doing something?
	move	@ballgoaltcnt,a0
	jrgt	#sblk			;Going towards rim?
	move	*a13(plyr_balldist),a0
	cmpi	100,a0
	jrgt	#sblk			;Too far?
	move	@ballprcv_p,a1,L
	jrnz	#sblk			;Pass in progress?
	move	*a13(plyr_seqflgs),a0
	btst	NOJUMP_B,a0
	jrnz	#sblk			;No jumping?
	move	*a13(plyr_autoctrl),a0
	jrnz	#sblk			;Temp computer control?
	callr	plyr_tryrebound
	move	*a13(plyr_seqflgs),a0
	btst	NOJUMP_B,a0
	jrnz	#slp			;No jumping?



#sblk	btst	BUT1_B,a6		;>Shoot/block (But1)
	jrz	#pass

	move	*a13(plyr_ownball),a1
	jrlt	#drnshoot

#tshoot	move	*a13(plyr_seqflgs),a0
	btst	NOJUMP_B,a0
	jrnz	#pass			;No jumping?

	move	*a13(plyr_rcvpass),a0
	jrgt	#slp			;Waiting on pass?

	callr	plyr_startjmp
	jruc	#pass

#drnshoot				;>Tell drone to shoot
	btst	BUT3_B,a6
	jrnz	#tshoot			;Turbo override?

	move	@PSTATUS,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	XORK	1,a1
	btst	a1,a0
	jrnz	#pass			;Teammate is a human?

	move	*a13(plyr_tmproc_p),a0,L
	movk	DRN_SHOOT_M,a1
	move	a1,*a0(plyr_d_cflgs)

	move	*a0(plyr_ohpdist),a14
;Turmell
	cmpi	350,a14
	jrlt	#pass			;Drone is close enough?
;Turmell
	move	@gmqrtr,a14
	jrnz	#pass

	move	*a13(plyr_idiotbit),a14
	btst	1,a14
	jrnz	#pass
	addk	2,a14
	move	a14,*a13(plyr_idiotbit)

	movk	4,a0
	move	*a13(plyr_num),a1
	calla	idiot_box		;Tell drone to shoot ball




#pass					;>Pass/steal (But2)
	move	*a13(plyr_ownball),a2
	jrz	#steal			;No ball?

	move	*a13(plyr_rcvpass),a0
	jrgt	#slp			;Waiting on pass?

	btst	BUT2_B+8,a6
	jrz	#slp
	move	*a13(plyr_seqflgs),a14
	btst	PASS_B,a14
	jrnz	#slp			;Passing?

	move	@pass_off,a14
	jrnz	#slp			;Lockout passing for now?

	move	a2,a2
	jrlt	#passtome
#dopass
	callr	plyr_startpass
	jruc	#slp

#passtome				;>Tell drone to pass
	btst	BUT3_B,a6
	jrnz	#steal			;Turbo?

	move	*a13(plyr_tmproc_p),a0,L
	movk	DRN_PASS_M,a1
;	btst	6,a6
;	jrz	#regds			;No turbo?
;	ori	>8000,a1
#regds	move	a1,*a0(plyr_d_cflgs)
	jruc	#slp




#steal
	btst	BUT2_B,a6
	jrz	#slp			;No button?
	move	*a13(plyr_jmpcnt),a0
	jrnz	#slp
	move	*a13(plyr_seq),a0
	btst	BUT3_B,a6
	jrnz	#push			;Turbo?

	subi	STEAL_SEQ,a0
	jreq	#slp

	move	*a13(plyr_rcvpass),a0
	jrgt	#slp			;Getting pass?
	move	*a13(plyr_tmproc_p),a1,L
	move	*a1(plyr_rcvpass),a0
	jrgt	#slp			;Getting pass?

	movi	STEAL_SEQ,a0
	callr	plyr_setseq
	move	*a13(plyr_balldir),*a13(plyr_newdir)

	jruc	#slp

#push
	btst	BUT2_B+8,a6
	jrz	#slp			;No button?
	move	*a13(plyr_PDATA_p),a2,L
	move	*a2(ply_turbo),a1
	cmpi	20,a1
	jrlt	#slp			;Turbo too low?
	subi	PUSH_SEQ,a0
	jreq	#slp

;	move	*a13(plyr_num),a0	;Don't allow drones to mess with
;	move	@PSTATUS,a14		;img ofsets!
;	btst	a0,a14
;	jrz	#notingame2

	subk	10,a1
	move	a1,*a2(ply_turbo)
	move	*a2(ply_meter_imgs+40h),a0,L
	move	*a0(OFSET),a1		;Shrink meter
	addk	10,a1
	move	a1,*a0(OFSET)

#notingame2
	movi	PUSH_SEQ,a0
	callr	plyr_setseq



#slp
	move	*a13(plyr_ownball),a1
	jrle	#nob
	callr	plyr_setballxyz
#nob
	callr	plyr_headalign
	callr	plyr_setshadow

	.if	DEBUG
;	callr	plyr_setgndaligndot
	.endif

#halted
	SLOOP	1,#lp



#pdat_t	.word	P1_PID,2<<4,120,CZMID-50
	.long	w3run1
#pd1	.word	P2_PID,2<<4,160,CZMID
	.long	w3run1
	.word	P3_PID,6<<4,240,CZMID
	.long	w3run1
	.word	P4_PID,6<<4,280,CZMID+50
	.long	w3run1

ltshoepal_t
	COLORW	31,31,31, 27,27,27, 22,22,22, 18,18,18
	COLORW	14,14,14
;dkshoepal_t
;	COLORW	8,8,8, 6,6,6, 5,5,5, 4,4,4
;	COLORW	2,2,2


#dirc_t	.byte	0,0,4<<4,0,6<<4,7<<4,5<<4,0,2<<4,1<<4,3<<4,0,0,0,0,0

pdta_l	.long	P1DATA,P2DATA,P3DATA,P4DATA


#sqsnds	.long	sqk1_snd,sqk2_snd,sqk3_snd,sqk4_snd

#flyb_t
;Extra % chance of allowing losing team to keep ball after being pushed
;1 pt down up to 15 & over down
	.word	175,175,200,225,250,275,300,325,350,375,400,425,450,475,500
	.word	500,500

RED_C	.equ	0
GRN_C	.equ	1
BLU_C	.equ	3
PUR_C	.equ	4
BLK_C	.equ	3
WHT_C	.equ	6
YEL_C	.equ	7
	.asg	>80,I	;Always keeps home colors

#team_t	.byte	RED_C,GRN_C+I,BLU_C+I,RED_C+I,BLU_C,BLU_C,BLU_C,BLU_C
	.byte	BLU_C,RED_C,BLU_C,RED_C,PUR_C,BLK_C,GRN_C,BLU_C
	.byte	WHT_C,BLU_C+I,BLK_C,RED_C,YEL_C,BLK_C,BLU_C,BLK_C
	.byte	GRN_C,PUR_C+I,RED_C


********************************
* Setup player sequence data
* A0=Sequence #
* A7=Dir 0-127
* A13=*Player process
* >A10=New ani cnt
* Trashes scratch

 SUBR	plyr_setseq

	move	a0,*a13(plyr_seq)

	sll	5,a0			;*32
	addi	pseq_t,a0
	move	*a0,a0,L
	move	*a0+,a1			;Get flags
	move	a1,*a13(plyr_seqflgs)


	btst	DRIBBLE_B,a1		;>Calc new dribble mode
	jrnz	#d

	move	*a13(plyr_dribmode),a14
	jrz	#n
	movi	-1,a1
	jruc	#setd

#d	move	*a13(plyr_dribmode),a14
	jrnz	#n
	movk	1,a1

#setd	move	a1,*a13(plyr_dribmode)
#n

	move	*a0+,a1,L		;Get *code
	move	a1,*a13(plyr_seqcode_p),L
	move	a7,a1			;Dir
	addk	8,a1			;Round off
	sll	32-7,a1
	srl	32-7+4,a1		;Kill frac
	move	a1,*a13(plyr_seqdir)

	clr	a14			;Dir 5-7 have reversed FLIPH
	cmpi	5,a1
	jrlt	#nohf
	movi	M_FLIPH,a14
#nohf	move	a14,*a13(plyr_anirevff)

	sll	32-3,a1			;Clr bits
	srl	32-3-5,a1		;*32
	add	a1,a0
	move	*a0,a0,L
	move	a0,*a13(plyr_ani1st_p),L
	move	a0,*a13(plyr_ani_p),L

	movk	1,a10

	rets


********************************
* Delete a players processes and objects
* A0=Plyr # (0-3)

; SUBRP	plyr_del
;
;	PUSH	a2,a3
;
;	move	a0,a2
;	move	a0,a3
;	sll	5,a3		;*32
;	addi	pdel_t,a3
;
;	move	*a3+,a0
;	calla	KIL1C		;Kill process
;
;	move	*a3+,a0
;	calla	obj_del1c	;Kill plyr images
;
;	clr	a0
;	sll	5,a2		;*32
;	movi	plyrobj_t,a1
;	add	a2,a1
;	move	a0,*a1,L
;
;	addi	plyrproc_t,a2
;	move	a0,*a2,L
;
;	PULL	a2,a3
;	rets
;
;
;pdel_t	.word	P1_PID,CLSPLYR|TYPPLYR|SUBPL1
;	.word	P2_PID,CLSPLYR|TYPPLYR|SUBPL2
;	.word	P3_PID,CLSPLYR|TYPPLYR|SUBPL3
;	.word	P4_PID,CLSPLYR|TYPPLYR|SUBPL4




#*******************************
* Update player controls (called by main loop)

 SUBR	joy_read

	move	@GAMSTATE,a0
	subk	INGAME,a0
	jrne	#x
	move	@HALT,a0
	jrnz	#x
	move	@plyrproc_t,a0,L	;Get 1st plyr proc
	move	*a0(plyr_autoctrl),a0
	jrnz	#x			;Temp computer control?

	move	@PSTATUS,a0		;Plyr start bits 0-3
	movi	P1CTRL,a1		;A1=*PxCTRL

	.if	TUNIT

	move	@SWITCH,a2
	not	a2

	srl	1,a0			;P1
	jrnc	#nop1
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	move	a2,a3
	sll	32-8,a3
	srl	32-8,a3
	or	a3,a14
	move	a14,*a1

#nop1	addk	16,a1			;P2
	srl	1,a0
	jrnc	#nop2
	zext	a2
	srl	8,a2
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	or	a2,a14
	move	a14,*a1

#nop2
	move	@SWITCH2,a2
	not	a2

	addk	16,a1			;P3
	srl	1,a0
	jrnc	#nop3
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	move	a2,a3
	sll	32-8,a3
	srl	32-8,a3
	or	a3,a14
	move	a14,*a1

#nop3	srl	1,a0			;P4
	jrnc	#x
	addk	16,a1
	zext	a2
	srl	8,a2
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	or	a2,a14
	move	a14,*a1

	.else

	move	@SWITCH,a2,L
	not	a2

	srl	1,a0			;P1
	jrnc	#nop1
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	move	a2,a3
	sll	32-8,a3
	srl	32-8,a3
	or	a3,a14
	move	a14,*a1

#nop1	addk	16,a1			;P2
	srl	8,a2
	srl	1,a0
	jrnc	#nop2
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	move	a2,a3
	sll	32-8,a3
	srl	32-8,a3
	or	a3,a14
	move	a14,*a1

#nop2	addk	16,a1			;P3
	srl	1,a0
	jrnc	#nop3
	srl	16,a2
	move	a2,a14			;>Move bit 7 to 6 (But 3)
	sll	32-6,a2
	srl	7,a14
	or	a14,a2
	rl	6,a2
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	or	a2,a14
	move	a14,*a1

#nop3	srl	1,a0
	jrnc	#x
	move	@SWITCH+>20,a2
	not	a2
	addk	16,a1
	sll	32-8,a2
	srl	32-8,a2
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	or	a2,a14
	move	a14,*a1


	.endif

#x
	rets


#*******************************
* Check for collision with opponent players
* A8=*Obj
* A13=*Player process
* Trashes scratch

 SUBRP	plyr_chkpcollide

	PUSH	a2,a3,a4,a5,a6,a7,a9,a10,a11

	movk	2,b1
	move	*a8(OXPOS),a4
	move	*a8(OXANI+16),a14
	add	a14,a4
	move	a4,a5
	move	*a8(OSIZEX),a14

	move	*a8(OIMG),a1,L
	move	*a1(IFLAGS),a1
	jrn	#lscl			;Large art?
	move	a14,a1			;*75%
	srl	2,a1
	sub	a1,a14
	sll	1,a14
#lscl	srl	2,a14			;/4
	sub	a14,a4			;A4=Box left
	add	a14,a5			;A5=Box rgt
	move	*a8(OZPOS),a6		;A6=Z
;	move	*a8(OIMG),a0,L
;	move	*a0(ICBZ),a11		;A11=Z radius (1-?)
;	jrnz	#test
	movk	13,a11
;#test

	movi	plyrobj_t,a7
	move	*a13(plyr_num),a0
	subk	2,a0
	jrge	#lp
	addi	64,a7

#lp	move	*a7+,a9,L
;	cmp	a9,a8
;	jreq	#next

;	move	*a9(OPLINK),a14,L
;	move	*a13(plyr_num),a0
;	move	*a14(plyr_num),a2
;	srl	1,a0
;	srl	1,a2
;	cmp	a0,a2
;	jreq	#next			;Same team?


	move	*a9(OZPOS),a2		;>Chk Z
	sub	a6,a2
	abs	a2
	move	*a9(OIMG),a1,L
	move	*a1(ICBZ),a3		;Get Z radius
	jrnz	#test2
	movk	13,a3
#test2	add	a11,a3
	cmp	a3,a2
	jrge	#next

	move	*a9(OXPOS),a1		;>Chk box X
	move	*a9(OXANI+16),a14
	add	a14,a1
	move	*a9(OSIZEX),a14

	move	*a8(OIMG),a2,L
	move	*a2(IFLAGS),a2
	jrnn	#smlscl2		;Small art?
	move	a14,a2			;*75%
	srl	2,a2
	sub	a2,a14
#smlscl2
	srl	1,a14			;/2
	add	a14,a1
	sub	a4,a1
	jrle	#next			;His rgt <= my lft edge?
	move	a1,a10
	add	a4,a1
	sub	a14,a1
	sub	a14,a1
	sub	a5,a1
	jrge	#next			;His lft >= my rgt edge?

	move	a1,a0			;A10=Closer edge match
	abs	a0
	cmp	a0,a10
	jrle	#smledge
	move	a0,a10
#smledge

	move	*a8(OYPOS),a0
	move	*a9(OYPOS),a1
	addk	25,a1			;Y difference
	cmp	a1,a0
	jrgt	#next			;Opponent much higher?


					;>Outer box collision
	move	*a8(OXVEL),a14,L
	abs	a14
	srl	15,a14
	jrnz	#otrbnc			;Moving?
	move	*a8(OZVEL),a2,L
	abs	a2
	srl	15,a2
	jrz	#chkib			;Not moving?
#otrbnc
	PUSH	a6,a7
	clr	a0
	clr	a1
	move	*a8(OXVEL),a6,L
	move	*a8(OZVEL),a7,L
	callr	seekdir_xyxy128		;Customize?
	PULL	a6,a7

	move	*a13(plyr_num),a2
	sll	2,a2			;*4
	move	*a9(OPLINK),a1,L
	move	*a1(plyr_num),a1
	add	a1,a2
	sll	4,a2			;*16
	addi	#c_t,a2
	move	*a2,a2			;Get my dir variable offset
	add	a13,a2
	move	*a2,a2			;Get dir

	sub	a0,a2
	move	a2,a14
	abs	a14
	cmpi	>40,a14
	jrle	#dsml
	neg	a2
#dsml	move	a2,a2
	jrge	#angpos			;Positive angle?
	addi	>28+>28,a0
#angpos	subi	>28,a0

	addk	4,a0
	sll	32-7,a0
	srl	32-7+3,a0		;Leave 4 bits
	sll	4,a0
	addi	#vel_t,a0

	move	*a0,a1
	move	*a0(16*4),a0
	sll	1,a0
	sll	1,a1
	move	*a8(OXVAL),a14,L
	add	a0,a14
	move	a14,*a8(OXVAL),L
	move	*a8(OZVAL),a14,L
	add	a1,a14
	move	a14,*a8(OZVAL),L


#chkib
	subk	6,a10
	jrle	#next			;X edges slightly touching?

	move	*a9(OZPOS),a1
	sub	a6,a1
	abs	a1			;Z distance
	subk	6,a3
	cmp	a3,a1			;Z radius
	jrge	#next

					;>Inner box collision
	move	*a8(OXVEL),a14,L
	move	*a9(OXVEL),a2,L
	move	a2,a3
	xor	a14,a2
	move	a2,a2
	jrn	#xvdif			;XV different dir?
	move	a14,a0
	abs	a3
	abs	a0
	cmp	a3,a0
	jrlt	#skipxv			;My vel smaller?
	xor	a14,a2			;Fix A2
	sub	a2,a14
#xvdif
	move	*a8(OXVAL),a1,L
	sub	a14,a1
	move	a1,*a8(OXVAL),L
#skipxv
	move	*a8(OZVEL),a14,L
	move	*a9(OZVEL),a2,L
	move	a2,a3
	xor	a14,a2
	move	a2,a2
	jrn	#zvdif			;ZV different dir?
	move	a14,a0
	abs	a3
	abs	a0
	cmp	a3,a0
	jrlt	#next			;My vel smaller?
	xor	a14,a2			;Fix A2
	sub	a2,a14
#zvdif
	move	*a8(OZVAL),a1,L
	sub	a14,a1
	move	a1,*a8(OZVAL),L


	move	*a13(plyr_ownball),a0
	jrgt	#next			;I have ball?

	move	*a13(plyr_stagcnt),a10	;>Add some stagger
	move	*a9(OPLINK),a14,L

	move	*a14(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrz	#nodunk			;!Dunking?

	addk	1,a10
	move	*a13(plyr_num),a0
	move	*a14(plyr_num),a2
	srl	1,a0
	srl	1,a2
	cmp	a0,a2
	jreq	#nodunk			;Same team?

	move	*a13(plyr_jmpcnt),a0
	jrz	#nopop
	move	*a8(OYPOS),a0
	move	*a9(OYPOS),a1
	addk	9,a1			;15

	cmp	a1,a0
	jrgt	#nopop			;Dunker is higher?


	move	@slamming,a0		;Ball already successfully into hoop
	jrnz	#nopop

	move	@HCOUNT,a0
	sll	32-4,a0
	jrnz	#noflsh

	calla	flash_reward

#noflsh
;Shawn, this % should also key off from ptsdown.  The % should never get
;higher, but maybe get a bit lower for the good team?

	movk	21,a0			;38,25
	calla	RNDPER
	jrls	#nopop

;	movk	>1f,a0
;	callr	rnd
;	jrnz	#nopop


	move	a13,a3
	calla	def_play_reward		;Good defensive play reward snds, etc

;If player is still going up, give him ball, otherwise, maybe disrupt dunk

	move	*a13(plyr_seq),a0
	cmpi	BLOCKREJ_SEQ,a0
	jreq	#disrupt

	movi	190,a0
	calla	RNDPER
	jrhi	#disrupt

	move	*a8(OYVEL),a0,L
	jrn	#gvbl

#disrupt
;If coming down, disrupt ball

	move	*a13(plyr_dir),a0
	calla	sinecos_get

	move	@ballobj_p,a2,L

	sll	4,a0
	sll	4,a1
	move	a0,*a2(OZVEL),L
	move	a1,*a2(OXVEL),L
	movi	-GRAV*18,a1		;Towards roof
	move	a1,*a2(OYVEL),L

	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast

	calla	ball_convfmprel

	move	*a9(OPLINK),a14,L

	clr	a0
	move	a0,*a14(plyr_ownball)

	movk	15,a0
	move	a0,*a13(plyr_shtdly)
	move	a0,*a14(plyr_shtdly)

     	jruc	#nopop

#gvbl
	move	*a13(plyr_num),a0	;Give defender the ball
	move	a0,@ballpnum
	clr	a0
	move	a0,*a13(plyr_dribmode)



#nopop	move	@plyrcharge,a0
	addk	1,a0
	move	a0,@plyrcharge

#nodunk	move	*a14(plyr_jmpcnt),a3
	jrz	#ongnd
	addk	1,a10			;Collided with a jumper
#ongnd
	move	*a13(plyr_seqflgs),a2
	btst	EASYSTAG_B,a2
	jrz	#nesy			;!An easy stagger?
	move	*a13(plyr_num),a0
	move	*a14(plyr_num),a2
	srl	1,a0
	srl	1,a2
	cmp	a0,a2
	jreq	#setstg			;Same team?
	addk	1,a10
#nesy
#setstg	move	a10,*a13(plyr_stagcnt)



#next	dsj	b1,#lp


#x	PULL	a2,a3,a4,a5,a6,a7,a9,a10,a11
	rets

#c_t	.word	0,plyr_tmdir,plyr_o1dir,plyr_o2dir
	.word	plyr_tmdir,0,plyr_o1dir,plyr_o2dir
	.word	plyr_o1dir,plyr_o2dir,0,plyr_tmdir
	.word	plyr_o1dir,plyr_o2dir,plyr_tmdir,0

#vel_t
	.word	-16384,-15137,-11585,-6270
	.word	0,6270,11585,15137,16384,15137,11585,6270
	.word	0,-6269,-11585,-15137,-16384,-15137,-11585,-6270



#*******************************
* Change the players image
* A0=*New image
* A1=New OCTRL (low 8 bits)
* A8=*Obj
* A13=*Plyr process
* Trashes scratch, A2,A3

 SUBRP	plyr_ani


	cmpi	ROM,a0
	jrlo	#anierr

	move	a0,a2
	move	a1,a3

	callr	anipt_getsclxy

	movb	a3,*a8(OCTRL)

	move	a2,*a8(OIMG),L
	move	*a2(0),*a8(OSIZE),L
	move	*a2(ISAG),*a8(OSAG),L

	move	*a13(plyr_attrib_p),a14,L
	move	*a14,a14,L		;Get *scale_t
	move	*a2(IFLAGS),a2
	jrnn	#small			;Bit15 = Scale
;	addi	>1600,a14		;Funny option - small bodies
	addi	SCALETSIZE,a14
#small
	move	a14,*a8(ODATA_p),L

	move	a0,a2
	move	a1,a3
	callr	anipt_getsclxy

	sub	a0,a2			;Subtract new from old
	sub	a1,a3

	move	a0,*a8(OXANI),L		;Save scaled anipt
	sra	16,a1
	move	a1,*a13(plyr_aniy)

	move	a8,a0			;Get base address
	addi	OXVAL,a0
	move	*a0,a14,L		;New OXVAL
	add	a2,a14
	move	a14,*a0+,L
	move	*a0,a14,L		;New OYVAL
	add	a3,a14
	move	a14,*a0,L

#x	rets


#anierr 
	.if	DEBUG
	LOCKUP
	eint
	.else
	CALLERR	2,2
	.endif
	jruc	#x




#*******************************
* Start player jumping (block, shoot, dunk)
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	plyr_startjmp

	PUSH	a6,a7

	move	*a13(plyr_ownball),a5
	jrz	#blk			;We don't have ball?


	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128

	move	*a13(plyr_newdir),a4	;Get old
	move	a0,*a13(plyr_newdir)	;Turn toward basket

	move	a5,a5
	jrlt	#blkd			;Teammate has ball?

	cmpi	400,a1
	jrge	#desp			;Long shot?

	cmpi	280,a1
	jrge	#3ptr			;3ptr


	cmpi	200,a1
	jrge	#tag1

	move	*a13(plyr_seqdir),a14
	jrz	#ahook
	subk	4,a14
	jrne	#tag1
#ahook
	move	*a13(plyr_ohpdir),a14
	addk	8,a14			;Round off
	sll	32-7,a14
	srl	32-7+4,a14		;Kill frac
	jrz	#tag1
	subk	4,a14
	jrz	#tag1


	move	*a13(plyr_ohpdist),a14
	cmpi	48h,a14
	jrlt	#tag1			;Too close for hook?
	move	*a8(OZPOS),a14
	cmpi	>430,a14
	jrlt	#tag1
	cmpi	>4fa,a14
	jrgt	#tag1
;Okay to do hook!	

	move	a4,*a13(plyr_newdir)	;Turn toward basket
	jruc	#hs			;Hook shot
#tag1


	move	a0,a3
	move	a1,a4

					;>Skip dunks from behind the hoop
	addk	8,a0			;Round off
	sll	32-7,a0
	srl	32-3,a0			;Kill frac
	move	*a13(plyr_num),a14
	srl	1,a14
	jrnz	#lhoop			;Team2?
	subk	5,a0
	jrlt	#trydunk
	jruc	#sj


;If behind hoop, I will try to do a hook shot...

#lhoop	move	a0,a0
	jrz	#trydunk
	subk	4,a0
	jrlt	#sj


#trydunk				;>Try a dunk
	cmpi	60,a4
	jrle	#velok			;Close to hoop?

	move	*a13(plyr_dir),a14
	sub	a3,a14
	abs	a14
	cmpi	>40,a14
	jrle	#nodov
	subi	>80,a14
	abs	a14
#nodov
	subk	24,a14
	jrgt	#sj			;!Facing basket?

;Shawn, stop dunker if he just made a real quick move.  Should we do this?
;	move	*a13(plyr_dirtime),a14
;	subk	4,a14
;	jrgt	#dnk_ok
;	nop
;	jruc	#sj
;
;#dnk_ok

	cmpi	170,a4			;Max dunk range
	jrge	#sj			;Too far for dunk?

;	cmpi	36,a4			;Short range
;	jrle	#sj			;Too close?

	move	*a8(OXVEL),a14,L	;>Chk velocity
	abs	a14
	srl	16,a14
	jrnz	#velok
	move	*a8(OZVEL),a14,L
	abs	a14
	srl	16,a14
	jrz	#sj
#velok

;	movk	7,a0			;12%
;	callr	rnd
;	jrz	#dunk			;Ignore opponents?

	move	*a13(plyr_o1dist),a14
	cmp	a14,a4
	jrlt	#o1dok			;I'm closer?
	cmpi	50,a14
	jrgt	#o1dok			;He's too far?
	move	*a13(plyr_o1dir),a2
	sub	a3,a2
	abs	a2
	cmpi	>40,a2
	jrle	#o1dsml
	subi	>80,a2
	abs	a2
#o1dsml	subk	32,a2
	jrlt	#trylyup		;In front of me?
#o1dok
	move	*a13(plyr_o2dist),a14
	cmp	a14,a4
	jrlt	#o2dok			;I'm closer?
	cmpi	50,a14
	jrgt	#o2dok			;He's too far?
	move	*a13(plyr_o2dir),a2
	sub	a3,a2
	abs	a2
	cmpi	>40,a2
	jrle	#o2dsml
	subi	>80,a2
	abs	a2
#o2dsml	subk	32,a2
	jrlt	#trylyup		;In front of me?
#o2dok

#dunk	move	a3,*a13(plyr_dir)
	movi	-1,a14
	move	a14,*a13(plyr_newdir)	;Cancel turn

	addk	8,a3			;Round off
	srl	4,a3			;Kill frac
	sll	5,a3			;*32
	addi	#du_t,a3

	cmpi	60,a4
	jrle	#shortd			;Under hoop?
	addi	#ds_t-#du_t,a3

	cmpi	80,a4			;Short range
	jrle	#shortd

	move	*a13(plyr_turbon),a14
	jrz	#idiot

;Turmell
;	setf	1,0,0
;	movk	1,a0
;	move	a0,*a13(plyr_idiotbit+2)
;	setf	16,1,0

	addi	#dm_t-#ds_t,a3,W

	cmpi	120,a4			;Med range
	jrle	#shortd
	addi	#dl_t-#dm_t,a3,W

#shortd	move	*a3,a2,L
	move	*a2+,a0			;#Entries-1
	callr	rndrng0

	sll	4,a0			;*16
	add	a2,a0
	move	*a0,a0
	jrz	#sj			;Null entry?


;	movi	DUNKZA_SEQ,a0		;DEBUG
;	movi	DUNKZ_SEQ,a0
;	movi	DUNKZ2_SEQ,a0
;	movi	DUNKZ3_SEQ,a0


	.if	DEBUG
;Shawn, I'm stuffing the dunk into ram so I can pause the game when someone
;has a problem with a dunk and I can jot down the dunk # and fix it.
	.bss	debug_dunk_num,16
	.ref	slowmotion

	move	a0,@debug_dunk_num
	clr	a1
	move	a1,@slowmotion
	.endif


	PUSH	a0
	CREATE0	start_animate
	PULL	a0

	movk	2,a14
	move	a14,@ballptsforshot

	move	*a13(plyr_dir),a7
	callr	plyr_setseq		;Dunk!

	move	*a13(plyr_num),a14
	srl	1,a14
	jrz	#x			;Team1?
	movi	M_FLIPH,a14
	move	a14,*a13(plyr_anirevff)
	jruc	#x



#trylyup
	move	@HCOUNT,a14
	btst	0,a14
	jrnz	#sj

	move	*a13(plyr_ohpdist),a14
	cmpi	138,a14
	jrgt	#sj
	cmpi	45,a14
	jrlt	#sj


	move	a3,*a13(plyr_dir)
	movi	-1,a14
	move	a14,*a13(plyr_newdir)	;Cancel turn
	movi	LAYUP_SEQ,a0
	jruc	#sseq

#hs
	movk	2,a4
	move	a4,@ballptsforshot

	movk	HOOK_SEQ,a0
	move	*a13(plyr_turbon),a4
	jrnz	#hs1
	movk	HOOK2_SEQ,a0		;Not a high arc


#hs1	move	*a13(plyr_dir),a7
	callr	plyr_setseq

	move	*a13(plyr_num),a14
	srl	1,a14
	jrz	#x			;Team1?
	movi	M_FLIPH,a14
	move	a14,*a13(plyr_anirevff)
	jruc	#x


#idiot					;>Tell him how to dunk
;Turmell
;	move	*a13(plyr_idiotbit),a0
;	btst	2,a0
;	jrnz	#sj
;	addk	4,a0
;	move	a0,*a13(plyr_idiotbit)
;	movk	8,a0
;	move	*a13(plyr_num),a1
;	calla	idiot_box



#sj					;>Start a jump shot seq
	movk	2,a4
	move	*a8(OZPOS),a0
	subi	CZMIN+18,a0
	jrlt	#3ptr
	cmpi	CZMID+178-(CZMIN+18),a0
	jrgt	#3ptr
	srl	2,a0			;/4
	sll	4,a0			;*16
	addi	#3pt_t,a0
	move	*a0,a0
	move	*a8(OXPOS),a2
	move	*a8(OXANI+16),a14
	add	a14,a2
	subi	WRLDMID,a2
	abs	a2
	cmp	a0,a2
	jrgt	#2ptr			;Far from center court?


;	addi	WRLDMID,a0		;3point DEBUG
;	sub	a14,a0
;	move	a0,*a8(OXPOS)
;#3ptr	clr	a0
;	move	a0,*a13(plyr_nojoy)
;	movk	STNDDRIB_SEQ,a0
;	jruc	#sseq

#3ptr
	movk	3,a4
#2ptr	move	a4,@ballptsforshot
	movk	SHOOT_SEQ,a0
	jruc	#sseq



#desp	movk	3,a14
	move	a14,@ballptsforshot
	movk	2,a0
	callr	rndrng0
	addk	SHOOTDESP_SEQ,a0
	move	*a13(plyr_newdir),a14
	move	a14,*a13(plyr_dir)
	movi	-1,a14
	move	a14,*a13(plyr_newdir)
	jruc	#sseq


#blk
	move	*a13(plyr_rcvpass),a0
	jrgt	#x			;Waiting on pass?

	move	@ballpnum,a14
	jrn	#inair

	sll	5,a14			;*32
	addi	plyrproc_t,a14
	move	*a14,a14,L
	move	*a14(plyr_seqflgs),a0
	btst	SHOOT_B,a0
;	jrz	#faceb			;!Shooting?
	jrnz	#inair

	move	@ballobj_p,a5,L
	move	*a5(OXPOS),a6
	addk	6,a6
	move	*a5(OZPOS),a7
	PUSH	A0
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_newdir)	;Turn toward ball
	PULL	A0
	btst	DUNK_B,a0
	jrz	#blkd
	movk	7,a0
	calla	rndrng0
	sll	5,a0
	addi	blktype_t,a0
	move	*a0,a0,L
	jruc	#sseq

blktype_t
	.long	BLOCK_SEQ,BLOCK_SEQ,BLOCK_SEQ,BLOCK_SEQ
	.long	REBOUND_SEQ,BLOCKREJ_SEQ
	.long	REBOUND_SEQ,BLOCKREJ_SEQ


#inair	move	@ballobj_p,a5,L

	move	*a5(OYPOS),a1
	cmpi	-20,a1
	jrge	#faceb			;Ball close to gnd?

	move	*a5(OXVAL),a6,L
	move	*a5(OXANI),a14,L
	add	a14,a6
	move	*a5(OZVAL),a7,L

	move	@ballpnum,a14
	jrge	#chkdist		;Other team has ball?

	movk	20,a0
	move	*a5(OXVEL),a1,L
	mpys	a0,a1
	add	a1,a6
	move	*a5(OZVEL),a1,L
	mpys	a0,a1
	add	a1,a7

#chkdist
	sra	16,a6
	sra	16,a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_newdir)	;Turn where ball is headed
	cmpi	120,a1
	jrge	#blkd			;Too far to jump?

	movk	1,a0			;50%
	move	@ballpnum,a1
	jrge	#dornd

	move	@ballgoaltcnt,a14
	jrle	#dorb			;Do rebound?

	movk	1,a0			;50%
#dornd	callr	rnd
	jrnz	#dorej

#dorb	movk	REBOUND_SEQ,a0
	jruc	#sseq
#dorej	movk	BLOCKREJ_SEQ,a0
	jruc	#sseq


#faceb	move	@ballobj_p,a5,L
	move	*a5(OXPOS),a6
	addk	6,a6
	move	*a5(OZPOS),a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_newdir)	;Turn toward ball

#blkd	movk	BLOCK_SEQ,a0


#sseq	move	*a13(plyr_dir),a7
	callr	plyr_setseq


#x	PULL	a6,a7
	rets



#du_t	.long	#d1u_t,#d2u_t,#d3u_t,#d4u_t
	.long	#d5u_t,#d4u_t,#d3u_t,#d2u_t, #d1u_t

#ds_t	.long	#d1s_t,#d2s_t,#d3s_t,#d4s_t
	.long	#d5s_t,#d4s_t,#d3s_t,#d2s_t, #d1s_t

#dm_t	.long	#d1m_t,#d2m_t,#d3m_t,#d4m_t
	.long	#d5m_t,#d4m_t,#d3m_t,#d2m_t, #d1m_t

#dl_t	.long	#d1l_t,#d2l_t,#d3l_t,#d4l_t
	.long	#d5l_t,#d4l_t,#d3l_t,#d2l_t, #d1l_t


;Dunks from under hoop
#d1u_t	.word	1-1,DUNKB2_SEQ
#d2u_t	.word	3-1,DUNKB2_SEQ,DUNKF2_SEQ,DUNKT6_SEQ
#d3u_t	.word	2-1,DUNKB2_SEQ,DUNKT6_SEQ
#d4u_t	.word	2-1,DUNKG2_SEQ,DUNKT6_SEQ
#d5u_t	.word	1-1,DUNKN2_SEQ
    
;List of dunks that can happen in these dirs if plyr is near hoop
#d1s_t	.word	10-1,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKT_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
#d2s_t	.word	15-1,DUNKB_SEQ,DUNKF_SEQ,DUNKT_SEQ,DUNKO_SEQ
	.word	DUNKJ2_SEQ,DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKS_SEQ
	.word	DUNKS2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKW3_SEQ
	.word	DUNKW2_SEQ
	.word	DUNKW_SEQ


#d3s_t	.word	9-1,DUNKP_SEQ,DUNKB_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKT_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
	.word	DUNKU_SEQ
#d4s_t	.word	8-1,DUNKP_SEQ,DUNKE_SEQ,DUNKE2_SEQ,DUNKG_SEQ,DUNKT_SEQ
	.word	DUNKP2_SEQ
	.word	DUNKT2_SEQ
	.word	DUNKT3_SEQ
#d5s_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ,0

;List of dunks that can happen in these dirs if plyr is med dist from hoop
#d1m_t	.word	9-1,DUNKA_SEQ,DUNKB_SEQ,DUNKJ_SEQ,DUNKJ2_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKJ_SEQ
	.word	DUNKQ_SEQ
	.word	DUNKQ3_SEQ
	.word	DUNKV_SEQ
	.word	DUNKV2_SEQ
#d2m_t	.word	39-1,DUNKB_SEQ,DUNKF_SEQ,DUNKJ_SEQ,DUNKO_SEQ
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
	.word	DUNKZ3_SEQ
#d3m_t	.word	48-1,DUNKB_SEQ,DUNKC_SEQ,DUNKE_SEQ,DUNKE2_SEQ
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
#d5m_t	.word	3-1,DUNKN_SEQ,DUNKN_SEQ,0

;List of dunks that can happen in these dirs if plyr is far away from hoop
#d1l_t	.word	1-1,0
#d2l_t
	.word	23-1
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
#d3l_t	.word	32-1
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
#d5l_t	.word	1-1,0

********************************

#3pt_t
	.word	193
	.word	187,175,166,158,153,144,138,130
	.word	125,120,115,110,106,102,100,98
	.word	96,94,92,89,86,84,82,80
	.word	80,79,79,79,78,78,78,77
	.word	77,77,77,77,77,77,77,78
	.word	78,79,81,82,83,84,85,86
	.word	87,88,89,90,91,92,94,95
	.word	96,98,100,104,108,113,116,120
	.word	124,129,133,138,141,145,148,153
	.word	157,162,166,175,180,186,191,198
	.word	204,214,230,230


#*******************************
* Player takes a shot (also called by seq)
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBR	plyr_shoot

	PUSH	a6,a7,a9,a10,a11


	move	*a13(plyr_num),a0
	move	@ballpnum,a1
	cmp	a0,a1
	jrne	#x


	callr	plyr_setballxyz

	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128
	move	a0,a10
	move	a1,a11			;A11=Hoop distance


;Turmell
;Shawn, is this okay?
	movi	1100,a9			;A9=Base %
;	movi	1000,a9			;A9=Base %

	cmpi	70h,a11
	jrgt	#notshort
;Turmell
	movi	1300,a9			;A9=Base %
#notshort


	move	*a13(plyr_num),a4	;>Get opponents dir/dist
	srl	1,a4
	movk	1,a14
	xor	a14,a4
	sll	6,a4			;*64
	addi	plyrobj_t,a4
	move	*a4+,a0,L
	move	*a0(OYPOS),a3
	callr	seekdirdist_obob128


	cmpi	20,a1
	jrgt	#1far2			;Opponent too far?

	subi	50,a9			;-5%

#1far2	cmpi	70,a1
	jrgt	#1far			;Opponent too far?

	sub	a10,a0
	abs	a0
	cmpi	>40,a0
	jrle	#1dsml
	subi	>80,a0
	abs	a0
#1dsml	subk	20,a0
	jrge	#1far			;Not between me and hoop?

	sll	2,a1			;*4
	subi	320,a1			;-320 to -40

	move	*a8(OYPOS),a2
	sub	a3,a2
	jrle	#1ihi			;Shooter higher?
	addk	8,a2
	mpys	a2,a1
	sra	3,a1			;/8

#1ihi	add	a1,a9			;Decrease accuracy
#1far

	move	*a4+,a0,L
	callr	seekdirdist_obob128


	cmpi	20,a1
	jrgt	#2far2			;Opponent too far?

	subi	50,a9			;-5%

#2far2	cmpi	70,a1
	jrgt	#2far			;Opponent too far?

	sub	a10,a0
	abs	a0
	cmpi	>40,a0
	jrle	#2dsml
	subi	>80,a0
	abs	a0
#2dsml	subk	20,a0
	jrge	#2far			;Not between me and hoop?

	sll	2,a1			;*4
	subi	320,a1			;-320 to -40

	move	*a8(OYPOS),a2
	sub	a3,a2
	jrle	#2ihi			;Shooter higher?
	addk	8,a2
	mpys	a2,a1
	sra	3,a1			;/8

#2ihi	add	a1,a9			;Decrease accuracy
#2far

	move	a11,a14
	sll	1,a14			;*2
	sub	a14,a9
	cmpi	50,a9
	jrge	#accok
	movi	50,a9
#accok
;	CREATE	>6000,plyr_showshotpercent

	move	*a13(plyr_ptsdown),a1	;>Adjust shot %
	move	a1,a2
	movk	20,a0
	mpys	a0,a1
	add	a1,a9			;+/-2% per point difference
	cmpi	50,a9
	jrge	#minok
	movi	50,a9
#minok



*If end of qrtr/game, affect shots like this:
*
* 1. If 4th or overtime qrtr has 5 seconds or less remaining and
*
*	a. If score is already tied or I am ahead, do nothing.
*	b. This shot (2 or 3) would tie the score, then make it go in 75% of
*	   the time.  (Regardless of shot distance)
*	c. This shot (2 or 3) would win the game, then make it go in at
*	   least 30% of the time (Close in would be higher, but even bombs
*	   go in 30%)
*	d. If this shot would pull me to within 1/2 points, then make it go
*	   in 90% of the time for max excitement without putting him ahead.
*
* 2. If 1/2/3rd qrtr has 5 seconds or less remaining and
*
*	a. If score is already tied or I am ahead, do nothing.
*	b. This shot (2 or 3) would tie the score, then make it go in 40% of
*	   the time at least.  (Regardless of shot distance)
*	c. If this shot would pull me to within or ahead by 1/2 points, then
*	   make it go in 50% of the time for max excitement)
*	d. If I am losing by a larger margin than 4, then make it go in at
*	   least 60%.  (Regardless of shot distance)


	move	@game_time,a1,L
	cmpi	>500,a1
	jrgt	#nohelp

	move	a2,a0
	jrz	#nohelp			;Not if tied
	jrgt	#tryhelp
	cmpi	-5,a0
	jrgt	#nohelp			;Winning by less than 5

	move	@gmqrtr,a1
	subk	3,a1
	jrlt	#nohelp

;I'm winning big, if end of game, allow shot to go in.

	move	@game_time,a1,L
	cmpi	>200,a1
	jrgt	#losingbige

	movi	anncr4_snd,a0
	calla	snd_play1
	jruc	#losingbige

#tryhelp
	move	@game_time,a1,L
	cmpi	>200,a1
	jrgt	#nobuzz

	movi	anncr4_snd,a0
	calla	snd_play1
#nobuzz


	move	a2,a0

	move	@ballptsforshot,a14
	move	@gmqrtr,a1
	subk	3,a1
	jrge	#endg			;End game help?

	subk	5,a0
	jrgt	#losingbig

	cmp	a2,a14
	jreq	#willtie		;This shot would tie up score!

	movi	700,a3			;Losing by 1-5
	jruc	#chkper
#losingbig
	movi	850,a3			;Losing by more than 5 points
	jruc	#chkper
#willtie
	movi	500,a3			;This will tie game
	jruc	#chkper

#endg
	subk	4,a0
	jrge	#losingbige

	cmp	a2,a14
	jrz	#willtiee		;This shot would tie up score!

	movi	550,a3			;Losing by 1-5
	jruc	#chkper
#losingbige				;Losing by more than 5 points
	movi	850,a3
	jruc	#chkper
#willtiee
	movi	950,a3			;This will tie game at end

#chkper	cmp	a3,a9
	jrge	#nohelp
	move	a3,a9
#nohelp

;Turmell
;	movi	950,a9
	callr	announcer_speech




	move	@ballobj_p,a7,L		;A7=*Ball obj

	move	*a7(OIMG),a3,L		;>Convert ball from player relative
	move	*a3(IANIOFFX),a3
	sll	16,a3
	move	*a7(OXANI),a14,L
	move	a3,*a7(OXANI),L
	sub	a14,a3			;Ani difference

	sra	16-5,a3
	move	*a7(OZPOS),a14		;894 to 1379 (Z range 486)
	addi	(819-GZBASE),a14	;768 to ?
	mpys	a14,a3
	move	a3,a14
	sra	2,a14			;/4
	sub	a14,a3
	sra	1,a14			;/2
	sub	a14,a3
	sll	16-(14+1),a3		;*64k /16k /2


	move	*a13(plyr_seq),a0	;>Adjust pos for desp shots

	cmpi	LAYUP_SEQ,a0
	jrne	#noly

;Turmell
	movi	900,a9			;Make those layups go in...

;Turmell
	movi	TSEC*2,a0
	calla	plyr_setshtdly		;Don't block layups!

	move	*a13(plyr_seqdir),a0
	sll	5,a0
	addi	adjst_t,a0
	move	*a0,a3,L

;	move	*a7(OYPOS),a5
;	subk	1,a5
;	movi	[-8,0],a3
;	move	a5,*a7(OYPOS)

	jruc	#fixde

adjst_t	.long	0,[7,0],[11,0],[6,0],[-8,0],[-8,0],[-8,0],[-8,0]

#noly
	cmpi	HOOK_SEQ,a0
	jreq	#extra
	cmpi	HOOK2_SEQ,a0
	jrne	#noextra
#extra

;Turmell
	movi	900,a9
#noextra

	subk	SHOOTDESP_SEQ,a0
	jrne	#fixd2
	move	*a7(OYPOS),a5
	subk	8,a5
	jruc	#fixdy

#fixd2	subk	1,a0			;SHOOTDESP2_SEQ
	jrne	#fixd3
	clr	a3
	move	*a7(OYPOS),a5
	subk	4,a5
	jruc	#fixdy

#fixd3	subk	1,a0			;SHOOTDESP3_SEQ
	jrne	#fixde
	sra	1,a3
	move	*a7(OYPOS),a5
	subk	2,a5

#fixdy	move	a5,*a7(OYPOS)
#fixde

	move	*a7(OXVAL),a14,L	;Adjust X
	sub	a3,a14
	move	a14,*a7(OXVAL),L



	move	a10,a3
	move	a11,a1
	sll	32-6,a3
	srl	32-6,a3
	subk	>20,a3
	abs	a3			;0-32


	movk	1,a10			;A10=At hoop

;	jruc	#miss			;DEBUG
;	jruc	#good			;DEBUG

	subk	24,a3
	jrge	#athoop			;At bad backboard angle?

	cmpi	100,a1
	jrgt	#longshot		;Too far for bank?

;	jruc	#offbb			;DEBUG

	movk	4,a0			;20%
	addk	24-16,a3
	jrlt	#fmfront
	movk	3,a0			;25%
#fmfront
	callr	rndrng0
	move	a0,a0
	jrnz	#athoop

#offbb					;>Close bank shot
	clr	a10

	move	*a7(OZPOS),a0
	subi	CZMID,a0		;Z delta
	move	a0,a3
	sll	8,a3

	move	*a13(plyr_ohoopx),a1
	move	*a7(OXPOS),a14
	sub	a14,a1
	move	*a7(OXANI+16),a14
	sub	a14,a1			;X delta
	abs	a1
	sll	8+2,a1
	abs	a0
	jrz	#nodiv			;Same Z?
	divu	a0,a1
#nodiv
	addi	512,a1			;2
	divs	a1,a3
	move	a3,a2			;Z

	movi	999,a0
	callr	rndrng0
	cmp	a0,a9
	jrgt	#bgood

;	movk	14,a0			;Miss
;	callr	rndrng0
;	subk	7,a0
;	move	a0,a2			;Z

#bgood
	movi	-10,a0			;X
	movi	-18,a1			;Y
	jruc	#calcshot

#longshot
	movk	3,a0
	callr	rnd
	jrnz	#athoop			;75%?

	movi	999,a0			;>Long bank shot
	callr	rndrng0
	cmp	a0,a9
	jrle	#miss

	movi	-10,a0			;X
	movi	-30,a1			;Y
	clr	a2			;Z
	addk	24-16,a3
	jrlt	#calcshot		;In front of board?
	jruc	#good			;Do good shot at hoop

#athoop
	movk	>1f,a0			;3%
	cmpi	50,a11
	jrge	#chkairb		;Not a close shot?
	movi	>7f,a0			;1.5%
#chkairb
	callr	rnd
	jrnz	#noairb			;No air ball?

	move	*a13(plyr_ptsdown),a0
	subk	2,a0
	jrge	#noairb			;Losing by 2 or more? No airball


	clr	a0
	move	a0,@plyrairballoff

	move	a7,a2
	CREATE0	plyr_airballsnd
	move	a2,a7

	movk	18,a2			;>Air ball
	movk	1,a0
	callr	rnd
	jrnz	#airf
	neg	a2			;-Z
#airf	clr	a0			;X
	clr	a1			;Y
	jruc	#calcshot


#noairb
	movi	999,a0			;>Shoot at hoop
	callr	rndrng0
	cmp	a0,a9
	jrgt	#good

#miss
	movk	>1f,a0			;Miss
	callr	rnd
	sll	4,a0
	addi	#misszx_t,a0
	move	*a0,a5
	move	*a0(8*16),a3

	movk	1,a0			;50%
	callr	rnd
	jrnz	#miss2

	movk	2,a0			;More towards rim edge
	callr	rndrng0
	addk	7,a0
	jruc	#miss3
#miss2
	movk	3,a0			;Regular miss (they go in a fair amount)
	callr	rnd
	addk	6,a0
#miss3
	mpys	a0,a3
	mpys	a0,a5
	move	a3,a0
	move	a5,a2
	sra	12,a0			;X
	sra	12,a2			;Z

	jruc	#cyo


#good	movk	4,a0			;Hit
	callr	rndrng0
	subk	2,a0
	move	a0,a2			;Z

	movk	4,a0
	callr	rndrng0
	subk	2,a0			;X

#cyo
	movi	-3,a1			;Y



#calcshot
	move	*a13(plyr_ohoopx),a3
	cmpi	WRLDMID,a3
	jrlt	#lhoop
	neg	a0
#lhoop	add	a0,a3			;Add X offset
	move	*a7(OXPOS),a14
	sub	a14,a3
	move	*a7(OXANI+16),a14
	sub	a14,a3			;X delta

	movi	CZMID,a5
	add	a2,a5
	move	*a7(OZPOS),a14
	sub	a14,a5			;Z delta

	move	a1,a2

	move	a3,a4			;>Calc distance (long+short/2.667)
	move	a5,a14
	abs	a4
	abs	a14
	cmp	a14,a4
	jrhs	#xbig
	SWAP	a14,a4
#xbig	sra	1,a14			;/2
	add	a14,a4
	sra	2,a14			;/8
	sub	a14,a4

	cmpi	170,a4
	jrls	#distok
	move	a4,a14			;>Reduce excess
	movi	170,a4
	sub	a4,a14
	sra	3,a14			;/8
	add	a14,a4
#distok
	move	a4,a1
	movi	110,a14			;120
	mpys	a14,a1
	move	a1,a4
	sra	8,a4			;/256

	move	a10,a10
	jrnz	#athp			;At hoop?
	move	a4,a1			;Time*.75
	sra	2,a1
	sub	a1,a4
	cmpi	35,a4
	jrge	#divok
	movi	35,a4
	jruc	#divok
#athp
	cmpi	50,a4
	jrge	#divok
	movi	50,a4			;Min
#divok

	move	*a13(plyr_seq),a1
;	cmpi	LAYUP_SEQ,a1
;	jrnz	#hkck
;	addk	2,a4			;8
;	jruc	#hko
;#hkck
	cmpi	HOOK_SEQ,a1
	jrnz	#hky
	addk	10,a4			;Make hook shot go a bit higher
	jruc	#hko
#hky
	cmpi	HOOK2_SEQ,a1
	jrnz	#hko
	subk	10,a4
#hko


	sll	16,a3
	sll	16,a5
	divs	a4,a3
	divs	a4,a5

;	move	*a8(OXVEL),a1,L
;	sra	3,a1			;/8
;	add	a1,a3
	move	a3,*a7(OXVEL),L
;	move	*a8(OZVEL),a1,L
;	sra	3,a1			;/8
;	add	a1,a5
	move	a5,*a7(OZVEL),L

	movi	-GRAVB/2,a1
	mpys	a4,a1
	move	*a7(OYVAL),a3,L		;Adjust for hgt difference
	addi	HOOPY-8,a2
	sll	16,a2
	sub	a2,a3			;- if above
	divs	a4,a3
	sub	a3,a1
	move	a1,*a7(OYVEL),L

	addk	2,a4
	move	a4,@ballgoaltcnt

	move	*a13(plyr_num),a1	;A1=Plyr #
	move	a1,@ballpnumshot
	move	a1,@ballpnumlast
	move	a1,@ballsclastp


	movi	-1,a0
	move	a0,@ballpnum		;No owner
	clr	a0
	move	a0,@ballscorezhit
	move	a0,*a13(plyr_ownball)
	move	a0,@plyrcharge
;Turmell
	movi	35,a0			;20
	move	a0,*a13(plyr_shtdly)


					;>Inc try shot stat
	.if	PS_2PTS_TRY=0
	clr	a0
	.else
	movk	PS_2PTS_TRY,a0
	.endif
	move	@ballptsforshot,a14
	subk	2,a14
	jreq	#2ptr
	movk	PS_3PTS_TRY,a0
#2ptr	calla	inc_player_stat


#x	PULL	a6,a7,a9,a10,a11
	rets


*******************************

;Turmell
 SUBRP	announcer_speech

	cmpi	108h,a11			;Long enough for speech call
	jrlt	#close
	move	@ballptsforshot,a14
	subk	3,a14
	jrnz	#close
	movk	3,a0
	callr	rndrng0
	sll	5,a0
	addi	#long_t,a0
	move	*a0,a0,L
	calla	snd_play1
#ancx	rets

#close	;so just call out players name

	movi	900,a0
	calla	RNDPER
	jrls	#nosnd

	move	*a13(plyr_num),a1
	move	a1,a0
	srl	1,a0			;team 0-1
	sll	4,a0
	addi	team1,a0
	move	*a0,a0			;team (0-26)
	sll	7,a0			;x 16bits x 4 x 2
	addi	name_speech,a0
	andi	1,a1
	sll	6,a1			;x 16bits x 4
	add	a1,a0
	calla	snd_play1
#nosnd
	rets

;Turmell
#long_t	.long	anncr1_snd,anncr2_snd,anncr5_snd
	.long	_shoot4_3_snd


#misszx_t
	.word	-4096,-4017,-3784,-3406,-2896,-2275,-1567,-799
	.word	0,799,1567,2275,2896,3406,3784,4017
	.word	4096,4017,3784,3406,2896,2275,1567,799
	.word	0,-799,-1567,-2275,-2896,-3406,-3784,-4017
	.word	-4096,-4017,-3784,-3406,-2896,-2275,-1567,-799


#*******************************
* Show shot percentage (process)
* A9=Percent (0-1000)

 SUBRP	plyr_showshotpercent

	move	a11,*a13(PDATA),L

	movk	10,a1
	divu	a1,a9

	cmpi	99,a9
	jrls	#maxok
	movi	99,a9
#maxok
	clr	a8
	divu	a1,a8
	sll	5,a8
	addi	#f_t,a8
	move	*a8,a2,L
	movi	[191,0],a0
	movi	[11,0],a1
	movi	950,a3			;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,a10

	sll	5,a9
	addi	#f_t,a9
	move	*a9,a2,L
	movi	[196,0],a0
	movi	[11,0],a1
	movi	950,a3			;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2


	PUSHP	a8
	movi	crplate2,a0		;>Change credit plate
	move	@crplate_ptr,a8,L
	move	*a8(OCTRL),a1
	calla	obj_aniq

	SLEEP	TSEC*2

	movi	crplate,a0
	move	*a8(OCTRL),a1
	calla	obj_aniq
	PULLP	a8

	.if	DEBUG
	move	*a13(PDATA),a0,L
	cmp	a0,a11
	jrz	#db
	LOCKUP
#db
	.endif

	move	a10,a0
	calla	DELOBJ
	jauc	DELOBJDIE


#f_t
	.long	font60,font61,font62,font63,font64
	.long	font65,font66,font67,font68,font69

#*******************************
* Make sound for airball (process)

 SUBRP	plyr_airballsnd

	SLEEP	90

	move	@plyrairballoff,a0
	jrnz	#x

	movi	airball_snd,a0
	calla	snd_play1
	SLEEP	100
	movi	airball_snd,a0
	calla	snd_play1
#x	DIE



#*******************************
* Start player pass to teammate
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	plyr_startpass

	PUSH	a6,a7


	move	*a13(plyr_tmproc_p),a4,L
	move	*a4(plyr_jmpcnt),a0
	jrnz	#x			;Teammate in air?


;Turmell
;	move	@PSTATUS,a0		;Plyr start bits 0-3
;	move	*a13(plyr_num),a1
;	btst	a1,a0
;	jrnz	#human
;	XORK	1,a1
;	btst	a1,a0
;	jrz	#human			;Drone passing to a drone?

;Turmell
;	move	*a13(plyr_idiotbit),a0
;	btst	0,a0
;	jrnz	#human
;	addk	1,a0
;	move	a0,*a13(plyr_idiotbit)
;
;	move	@inbound,a0		;Inbounding team (0-1) or Neg
;	jrnn	#human
;
;	movk	5,a0
;	calla	idiot_box		;This plyr is telling drone to pass ball
;#human


	move	a10,a2
	move	a4,a10
	calla	arw_on1plyr		;Guy who picks up ball gets arw
	move	a2,a10
	move	a4,@ballprcv_p,L

	move	*a4(PA8),a2,L		;Get teammates obj
	move	*a2(OXPOS),a6
	move	*a2(OXANI+16),a14
	add	a14,a6
	move	*a2(OZPOS),a7


;Try to do a no look pass

;If passer is facing 0,1,2 and teamate is located in the angle 2
;then we can use the T2NLPR pass.
;
; OR
;
;If passer is facing 6,7 and teamate is located in the angle 6
;then we can use the T2NLPR pass.
;
; OR
;
;If passer is facing 0,1,2 and teamate is located in the angle 7
;then we can use the T2NLPL pass.
;
; OR
;
;If passer is facing 6,7 and teamate is located in the angle 0
;then we can use the T2NLPL pass.


	move	@inbound,a0
	jrnn	#notnl4			;Inbounding the ball?

	movk	6,a0			;>Try no look pass
	callr	rnd
	jrnz	#notnl4

	move	*a13(plyr_jmpcnt),a14
	jrnz	#notnl4			;In air?

	move	*a13(plyr_tmdist),a14
	cmpi	70,a14
	jrlt	#notnl4			;Too short?
	subi	320,a14
	jrgt	#notnl4			;Too far?

	callr	seekdirdist_obxz128
	move	a1,a2

	move	a0,a14
	addi	>40,a14
	sll	32-7,a14
	srl	32-7,a14

	addk	8,a0			;Round off
	sll	32-7,a0
	srl	32-7+4,a0		;Kill frac

	move	*a13(plyr_seqdir),a1
	cmpi	3,a1
	jrlt	#dir2n
	cmpi	6,a1
	jrlt	#notnl
	cmpi	6,a0
	jrz	#donl
	cmpi	1,a0
	jrz	#dir3
;	cmpi	7,a0
;	jrz	#dir3
	jruc	#notnl

#dir2n	cmpi	2,a0
	jrz	#donl
	cmpi	7,a0
	jrnz	#notnl
#dir3	movi	PASSNL2_SEQ,a0
	jruc	#don1

#donl
	movi	PASSNL_SEQ,a0
#don1	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	#bhpas


#notnl
;If passer is facing 2,3,4 and teamate is located in the angle 5
;then we can use the T4NLPR pass.
;
; OR
;
;If passer is facing 5,6 and teamate is located in the angle 5
;then we can use the T4NLPR pass.
;
; OR
;
;If passer is facing 2,3,4 and teamate is located in the angle 2
;then we can use the T4NLPL pass.
;
; OR
;
;If passer is facing 5,6 and teamate is located in the angle 6
;then we can use the T4NLPL pass.

	cmpi	2,a1
	jrlt	#notnl4
	cmpi	5,a1
	jrlt	#dir2n4

	cmpi	7,a1
	jrz	#notnl4

;	cmpi	3,a0		
;	jrz	#donl4
	cmpi	6,a0
	jrz	#dir34
	jruc	#notnl4

#dir2n4	cmpi	5,a0
	jrz	#donl4a
	cmpi	2,a0
	jrnz	#notnl4
#dir34	movi	PASSNL2_SEQ,a0
	jruc	#don14

#donl4
	movi	PASSNL_SEQ,a0
#don14	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	#bhpas
#donl4a
	movi	PASSNL3_SEQ,a0
	jruc	#don14

#notnl4



 	movi	400,a0
	calla	RNDPER
	jrls	#notbh

;	movk	2,a0			;>Try behind the back pass
;	callr	rnd
;	jrnz	#notbh

	move	*a13(plyr_jmpcnt),a14
	jrnz	#notbh			;In air?

	move	*a13(plyr_tmdist),a14
	cmpi	90,a14
	jrlt	#notbh			;Too short?
	subi	360,a14
	jrgt	#notbh			;Too far?
 
;Want to stop ball from being inbounded using the BHPASS

	move	@inbound,a0
	jrn	#bhcont			;Inbounding the ball?

;I'm ahead, maybe still do cocky inbound

	move	*a13(plyr_ptsdown),a1
	jrgt	#notbh			;If losing, don't bhpass
	addk	7,a1
	jrge	#notbh			;If ahead by 7 or more, allow attempt
#bhcont
 
;Check to see is teamate is in an ok position to receive a behind the back
;pass based on what direction pass is facing and teamate is located.
;
;If passer is facing 2,3,4 and teamate is in 1 or 2 then do it, or if passer 
;is facing 5,6 and teamate is located in the angles 6 or 7 then we can also
;use the T4HIND pass.
;
;If passer is facing 0,1 and teamate is in 2 or 3 then do it,
;or if passer is facing 7 and teamate is located in the angles 5 or 6
;then we can also use the T2HIND pass.


	callr	seekdirdist_obxz128
	move	a1,a2

	move	a0,a14
	addi	>40,a14
	sll	32-7,a14
	srl	32-7,a14

	addk	8,a0			;Round off
	sll	32-7,a0
	srl	32-7+4,a0		;Kill frac

	move	*a13(plyr_seqdir),a1
	cmpi	2,a1
	jrlt	#dir2
	cmpi	7,a1
	jrz	#dir2
					;4 direction possibility
	subk	5,a1
	jrge	#flp4
	move	a0,a0			;Unflipped 4
	jrz	#notbh			;Not in 0 direction
	subk	3,a0
	jrge	#notbh
	jruc	#dobh2
#flp4
	subk	6,a0
	jrlt	#notbh
	jruc	#dobh2

#dir2					;2 direction possibility
	subk	7,a1
	jreq	#flp2
	subk	2,a0
	jreq	#dobh2
	subk	3-2,a0
	jrne	#notbh
#dobh2
	movi	PASSBH_SEQ,a0		;Will do a #2 behind the back pass
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	#bhpas

#flp2	subk	5,a0
	jreq	#dobh2
	subk	6-5,a0
	jreq	#dobh2


#notbh


	callr	seekdirdist_obxz128	;>Turn toward teammate
	move	a0,*a13(plyr_dir)

	move	a0,*a13(plyr_newdir)

	move	a0,a7
	move	a0,a3

	addi	>40,a0
	sll	32-7,a0
	srl	32-7,a0
	move	a0,*a4(plyr_newdir)
	move	a1,a2




	movk	PASSDO_SEQ,a0
	move	*a13(plyr_jmpcnt),a14
	jrz	#contpass
	move	*a13(plyr_tmdist),a14
	cmpi	90,a14
	jrgt	#ss
	movi	PASSDO2_SEQ,a0
	jrnz	#ss			;Air dish off pass?
#contpass


	movk	PASSS_SEQ,a0
	cmpi	170,a2			;50
	jrle	#ss


;FIX!!
;	movk	3,a0
;	callr	rnd
;	jrnz	#tpass			;75%
;
;	movk	PASSOH_SEQ,a0
;
;	move	*a13(plyr_o1dist),a14
;	cmp	a2,a14
;	jrgt	#o1far
;	move	*a13(plyr_o1dir),a14	;Find dir difference
;	sub	a3,a14
;	abs	a14
;	cmpi	>40,a14
;	jrle	#1dsml
;	subi	128,a14
;	abs	a14
;#1dsml	subk	1,a14
;	jrle	#ss			;O1 between us?
;#o1far
;	move	*a13(plyr_o2dist),a14
;	cmp	a2,a14
;	jrgt	#o2far
;	move	*a13(plyr_o2dir),a14	;Find dir difference
;	sub	a3,a14
;	abs	a14
;	cmpi	>40,a14
;	jrle	#2dsml
;	subi	128,a14
;	abs	a14
;#2dsml	subk	1,a14
;	jrle	#ss			;O2 between us?
;#o2far

;#tpass

;
;	movk	PASSS_SEQ,a0
;	cmpi	200,a2
;	jrle	#ss

	movk	PASSC_SEQ,a3
	movk	7,a0
	callr	rnd
	jrnz	#normchest		;12% regular chest?
	movk	PASSNEWOH_SEQ,a3
#normchest
	move	a3,a0

#ss
#bhpas
	move	a0,a3
	callr	plyr_setseq

;	subk	PASSOH_SEQ,a3
;	jreq	#nolead
	cmpi	PASSNL_SEQ,a3
	jreq	#nolead
	cmpi	PASSNL2_SEQ,a3
	jreq	#nolead

;	cmpi	35,a2
;	jrlt	#nolead			;Too close?

	move	*a4(plyr_dirtime),a1
	jrz	#nolead

;Shawn, I increased this because we were getting to many missed leading
;passes.  Because the receiver would bump into a defender and get thrown
;off course. 

	subk	8,a1			;4
	jrgt	#leadingpass

	move	*a4(plyr_o1dist),a0
	cmpi	40,a0
	jrlt	#nolead			;Opponent too close?
	move	*a4(plyr_o2dist),a0
	cmpi	40,a0
	jrge	#leadingpass


;Additional checks are required here to determine if this will cause the
;leading pass to fly off scrn and cause the receiver to become stuck
;against the glass wall.



	cmpi	25,a2
	jrlt	#nolead			;Too close?
	move	*a4(plyr_dirtime),a1
	subk	4,a1
	jrgt	#leadingpass


#nolead
	movk	1,a0
	move	a0,*a4(plyr_nojoy)

	jruc	#end


#leadingpass
	move	*a4(plyr_jmpcnt),a1
	jrnz	#nolead			;He's jumping?


;Disallow leading behind the back pass if using #4 or #2 behind back pass art
;and teamate is running toward passer
;At the moment, receiver must be running horizontally away from me!  (2 or 6)
	cmpi	PASSBH_SEQ,a3
	jrne	#notst
	move	*a13(plyr_seqdir),a1
	move	*a4(plyr_seqdir),a0
	cmpi	5,a1
	jrge	#ck1
	cmpi	2,a0
	jrz	#bhin
	jruc	#nolead
#ck1	cmpi	6,a0
	jrne	#nolead
	jruc	#bhin
#notst		

;Will be a leading pass, rotate passer so that pass will go to where
;receiver will be when he receives the pass

	move	*a13(plyr_tmproc_p),a4,L
	move	*a4(PA8),a2,L		;Get teammates obj
	move	*a2(OXPOS),a6
	move	*a2(OXANI+16),a14
	add	a14,a6
	move	*a2(OZPOS),a7

	move	*a2(OXVEL),a0,L		;Where will teamate be in 32 ticks?
	sra	16-5,a0
	add	a0,a6
	move	*a2(OZVEL),a0,L
	sra	16-5,a0
	add	a0,a7

	callr	seekdirdist_obxz128	;>Turn toward where teammate will be
	move	a0,*a13(plyr_dir)
	move	a0,*a13(plyr_newdir)


;;Is this needed again?
;	move	a3,a0
;	move	*a13(plyr_dir),a7
;	callr	plyr_setseq


#bhin
	move	*a4(PA11),a0,L		;>Keep teammate moving in same dir
	move	*a0,a0
	sll	32-4,a0
	srl	32-4,a0
	ori	>8000,a0
	move	a0,*a4(plyr_nojoy)	;Neg
	move	a0,*a4(plyr_newdir)

#end
	movk	30,a0
	move	a0,*a4(plyr_rcvpass)


#x	PULL	a6,a7
	rets



#*******************************
* Player passes to teammate (called from seq)
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBR	plyr_pass

	PUSH	a6

	move	@ballpnum,a0
	move	*a13(plyr_num),a1
	cmp	a0,a1
	jrne	#x			;I don't have ball?


	calla	ball_convfmprel

	move	@ballobj_p,a0,L

	move	*a13(plyr_tmproc_p),a6,L
	move	*a6(PA8),a2,L		;Get * teammates obj

	move	*a2(OXPOS),a3
	move	*a2(OXANI+16),a14
	add	a14,a3
	move	*a2(OZPOS),a5

	move	*a0(OXPOS),a1
	move	*a0(OXANI+16),a14
	add	a14,a1
	sub	a1,a3			;X delta
	move	*a0(OZPOS),a1
	sub	a1,a5			;Y delta

	move	a3,a4			;>Calc distance (long+short/2.667)
	move	a5,a14
	abs	a4
	abs	a14
	cmp	a14,a4
	jrhs	#xbig
	SWAP	a14,a4
#xbig	sra	1,a14			;/2
	add	a14,a4
	sra	2,a14			;/8
	sub	a14,a4



;Turmell
	PUSH	a0

	move	@inbound,a0
	jrnn	#no_speech

	cmpi	200,a4			;too close to call
	jrlt	#no_speech

	move	*a13(plyr_num),a1
	move	a1,a0
	srl	1,a0			;team 0-1
	sll	4,a0
	addi	team1,a0
	move	*a0,a0			;team (0-26)
	sll	7,a0			;x 16bits x 4 x 2
	addi	pass_speech,a0
	andi	1,a1
	sll	6,a1			;x 16bits x 4
	add	a1,a0
	calla	snd_play1
#no_speech
	PULL	a0


;FIX!!
;	move	*a13(plyr_seq),a14	;>Chk for overhead pass
;	subk	PASSOH_SEQ,a14
;	jrne	#calct
;	sra	3,a4			;/8
;	addk	20,a4
;	cmpi	60,a4
;	jrle	#ohok
;	movi	60,a4			;Max
;#ohok	move	*a13(plyr_turbon),a14
;	jrz	#nshrt			;No turbo?
;	sra	1,a4
;	addk	6,a4
;	jruc	#nshrt
;#calct


	movi	95,a1			;>Calc time
	cmpi	300,a4
	jrgt	#ct

;Turmell
;	movi	125,a1
	movi	115,a1

#ct	move	*a13(plyr_turbon),a14
	jrz	#noturb			;No turbo?
	subi	32,a1			;Quicker
;	subi	42,a1			;Quicker




#noturb
	move	a14,@plyrpasstype	;0=Normal, !0=Turbo

	mpys	a4,a1
	sra	10,a1			;/1024
	move	a1,a4
	subk	16,a1
	jrge	#nshrt			;!Short?
	movk	16,a4			;Min
#nshrt

	move	*a6(PA8),a2,L		;Get * teammates obj
	move	*a6(plyr_nojoy),a14
	jrnn	#nolead

	move	*a2(OXVEL),a3,L
	mpys	a4,a3
	move	*a2(OXVAL),a14,L
	add	a14,a3
	move	*a2(OXANI),a14,L
	add	a14,a3
	move	*a2(OZVEL),a5,L
	mpys	a4,a5
	move	*a2(OZVAL),a14,L
	add	a14,a5
	sra	16,a3
	sra	16,a5

	move	*a0(OXPOS),a1
	move	*a0(OXANI+16),a14
	add	a14,a1
	sub	a1,a3			;X delta
	move	*a0(OZPOS),a1
	sub	a1,a5			;Y delta


#nolead
	sll	16,a3
	sll	16,a5
	divs	a4,a3
	divs	a4,a5

	move	a3,*a0(OXVEL),L
	move	a5,*a0(OZVEL),L

	move	*a0(OYVAL),a3,L		;Adjust for hgt difference
	move	*a2(OYVAL),a14,L
	sub	a14,a3			;- if ball above dest
	move	a14,a1
	sra	2,a1
	add	a1,a3

	move	a4,a5
	move	*a6(plyr_nojoy),a2
	jrn	#nopoh			;Leading pass?

	subk	4,a5

;FIX!!
;	move	*a13(plyr_seq),a2
;	subk	PASSOH_SEQ,a2
;	jrne	#nopoh
;	sub	a1,a3
;	subk	26,a5
;	movk	REBOUND_SEQ,a14
#nopoh
	movi	-GRAVB/2,a1
;	move	@HCOUNT,a14
;	btst	0,a14
;	jrz	#level
;	movi	-GRAVB/4,a1
;#level
	mpys	a4,a1
	divs	a4,a3
	sub	a3,a1
	move	a1,*a0(OYVEL),L

	move	*a13(plyr_num),a0
	move	a0,@ballpnumshot
	move	a0,@ballpnumlast
	move	a0,@ballsclastp
	movi	-1,a0
	move	a0,@ballpnum		;No owner
	clr	a0
	move	a0,@ballscorezhit
	move	a0,@ballpasstime
	move	a0,*a13(plyr_ownball)
	movk	30,a0
	move	a0,*a13(plyr_shtdly)

	addk	5,a5
	move	a5,*a6(plyr_rcvpass)	;Tell teammate when to expect pass

	movi	pass_snd,a0
	calla	snd_play1


#x	PULL	a6
	rets



#*******************************
* Try a rebound if possible
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

RTIME	.equ	25

 SUBRP	plyr_tryrebound

	PUSH	a6,a7

	move	@plyrinautorbnd,a1
	jrnz	#x			;Someone else doing?

					;>Chk my start
	move	*a8(OZPOS),a1		;Get SZ
	subi	CZMID,a1
	abs	a1
	cmpi	40,a1
	jrgt	#posok
	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	subi	WRLDMID,a0
	abs	a0
	cmpi	HOOPRX-WRLDMID+13,a0
	jrge	#x			;Under backboard?

	subk	12,a1
	jrgt	#posok
	cmpi	HOOPRX-WRLDMID-8,a3
	jrge	#x			;Under rim?


#posok
	move	@ballobj_p,a5,L


	movk	RTIME,a0		;>Find new Y pos in x ticks
	move	*a5(OYVAL),a4,L
	move	*a5(OYVEL),a2,L
	movi	GRAVB,a1
#newblp
	add	a2,a4
	add	a1,a2
	dsj	a0,#newblp

	sra	16,a4

	cmpi	-140,a4
	jrlt	#x			;Too hi?

	addk	30,a4
	move	*a8(OYPOS),a0
	cmp	a0,a4
	jrge	#x			;Ball lower than plyr?



	move	*a5(OXVAL),a6,L		;>Find new XZ pos in x ticks
	move	*a5(OXANI),a14,L
	add	a14,a6
	move	*a5(OZVAL),a7,L

	move	a6,a0			;>Chk ball pos
	move	a7,a1
	sra	16,a0
	sra	16,a1

	subi	CZMID,a1
	abs	a1
	subk	12,a1
	jrgt	#bposok
	subi	WRLDMID,a0
	abs	a0
	cmpi	HOOPRX-WRLDMID-10,a3
	jrge	#x			;Under rim or backboard?
#bposok

	movk	RTIME,a0
	move	*a5(OXVEL),a1,L
	mpys	a0,a1
	add	a1,a6
	move	*a5(OZVEL),a1,L
	mpys	a0,a1
	add	a1,a7

	sra	16,a6
	sra	16,a7


	move	a6,a0			;>Chk my destination
	move	a7,a1

	subi	CZMID,a1
	abs	a1
	cmpi	40,a1
	jrgt	#eposok
	subi	WRLDMID,a0
	abs	a0
	cmpi	HOOPRX-WRLDMID+13,a0
	jrge	#x			;Under backboard?
	subk	14,a1
	jrgt	#eposok
	cmpi	HOOPRX-WRLDMID-10,a3
	jrge	#x			;Under rim?
#eposok

	callr	seekdirdist_obxz128
	cmpi	60,a1
	jrge	#x			;Too far to jump?

	move	a0,*a13(plyr_newdir)	;Turn where ball is headed

	movk	REBOUNDA_SEQ,a0
	move	a0,@plyrinautorbnd

	move	*a13(plyr_dir),a7
	callr	plyr_setseq


#x	PULL	a6,a7
	rets


#*******************************
* Clear auto rebound flag - Called when SEQ_REBOUNDA lands

 SUBR	clr_autorbnd

	clr	a0
	move	a0,@plyrinautorbnd
	rets


#*******************************
* Set the ball xyz position from player
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch

 SUBRP	plyr_setballxyz

	move	@ballobj_p,a0,L

	move	*a8(OZPOS),a1		;>Set Z
	move	*a13(plyr_ballzo),a14
	add	a14,a1
	move	a1,*a0(OZPOS)

	move	*a8(OXVAL),a1,L		;>Set X
	move	a1,b0
	move	*a13(plyr_ballxo),a14,L
	add	a14,a1
	move	*a0(OIMG),a14,L
	move	*a14(IANIOFFX),a14
	sll	16,a14
	sub	a14,a1
	move	a1,*a0(OXVAL),L

	move	*a8(OXANI),a14,L	;Make 3D ball X+ani = plyr X+ani
	sub	a14,a1
	move	b0,a14
	sub	a1,a14
	move	a14,*a0(OXANI),L

	move	*a13(plyr_ballyo),a1
	cmpi	-200,a1
	jreq	#bfree			;Ball Y free?

	move	*a0(OIMG),a14,L		;>Set Y
	move	*a14(IANIOFFY),a14
	sub	a14,a1
	move	*a8(OYPOS),a14
	add	a14,a1
	move	a1,*a0(OYPOS)
	clr	a1
	move	a1,*a0(OYVEL),L		;Stop grav from accumulating
	move	a1,*a0(OXVEL),L
	move	a1,*a0(OZVEL),L
	move	a1,@ballfree		;!Free

	rets

#bfree
	move	@ballfree,a14
	jrnz	#x			;Already free?
	movk	1,a14
	move	a14,@ballfree		;Free
	move	*a0(OYPOS),a1
	move	*a0(OIMG),a14,L
	move	*a14(IANIOFFY),a14
	add	a14,a1
	movi	->a00,a14		;Push it towards gnd
	mpys	a14,a1
	addi	>16000,a1
	move	a1,*a0(OYVEL),L
#x	rets


#*******************************
* Get a scaled objects anipt XY
* A8=*Obj
* >A0=Scaled Ani X (16:16)
* >A1=Scaled Ani Y
* Trashes scratch

 SUBR	anipt_getsclxy

	move	a2,b0

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
	move	*a0,a14
	sll	4,a14			;*16
	move	a1,a0

	move	*a2(IANIOFFY),a1
	mpys	a14,a1


	move	*a8(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	#x			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a0
	add	a2,a0			;+size


#x	move	b0,a2
	rets


#*******************************
* Get a scaled objects 2nd anipt XY
* A8=*Obj
* >A0=Scaled Ani2 X (16:16)
* >A1=Scaled Ani2 Y
* Trashes scratch

 SUBRP	anipt2_getsclxy

	move	a2,b0

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

	move	*a2(IANI2X),a1
	mpys	a14,a1
	move	*a0,a14
	sll	4,a14			;*16
	move	a1,a0

	move	*a2(IANI2Y),a1
	cmpi	-200,a1
	jrne	#ynorm
	sll	16,a1
	jruc	#cflip
#ynorm	mpys	a14,a1


#cflip	move	*a8(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	#x			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a0
	add	a2,a0			;+size


#x	move	b0,a2
	rets



#*******************************
* Get a scaled objects 3rd anipt XY
* A8=*Obj
* >A0=Scaled Ani3 X (16:16)
* >A1=Scaled Ani3 Y
* Trashes scratch

 SUBRP	anipt3_getsclxy

	move	a2,b0

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

	move	*a2(IANI3X),a1
	mpys	a14,a1
	move	*a0,a14
	sll	4,a14			;*16
	move	a1,a0


	move	*a2(IANI3Y),a1
	mpys	a14,a1


#cflip	move	*a8(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	#x			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a0
	add	a2,a0			;+size


#x	move	b0,a2
	rets



#*******************************
* Align shadow obj with player obj and set ani
* A8=*Obj
* A13=*Plyr process
* Trashes scratch, A2-A4

 SUBRP	plyr_setshadow

	move	*a13(plyr_shadobj_p),a4,L

	move	*a8(OZPOS),a0
	move	a0,a1
	subi	50,a1			;Adjust
	move	a1,*a4(OZPOS)

	subi	CZMIN,a0		;-Base
	jrge	#zok
	clr	a0
#zok	srl	5,a0			;/32
	move	*a8(OYPOS),a1
	move	*a13(plyr_aniy),a14
	add	a14,a1			;Ani pt position
	sra	4,a1			;/16 (Neg)
	add	a1,a0
	sll	5,a0			;*32
	addi	#ani_t,a0
	move	*a0,a2,L
	move	a2,*a4(OIMG),L		;Set new img
	move	*a2,a14,L
	move	a14,*a4(OSIZE),L
	move	*a2(ISAG),*a4(OSAG),L

	callr	anipt_getsclxy

	move	*a2(IANIOFFX),a3
	sll	16,a3
	move	a3,*a4(OXANI),L

	move	*a8(OXVAL),a14,L
	add	a0,a14			;Ani X
	sub	a3,a14
	move	a14,*a4(OXVAL),L

	move	*a2(IANIOFFY),a3
	neg	a3
	move	a3,*a4(OYPOS)

	rets


	.long	shadow15,shadow15,shadow15,shadow15
	.long	shadow15,shadow15,shadow15,shadow15
	.long	shadow15,shadow14,shadow13,shadow12
#ani_t	.long	shadow11,shadow10,shadow9,shadow8
	.long	shadow7,shadow6,shadow5,shadow4
	.long	shadow3,shadow2,shadow1,shadow1
	.long	shadow1,shadow1,shadow1



#*******************************
* Align head obj with player obj
* A8=*Obj
* A13=*Plyr process
* Trashes scratch, A2-A6

 SUBRP	plyr_headalign

	move	*a13(plyr_headobj_p),a6,L ;>A6=*Head obj

	move	*a8(OIMG),a0,L		;>Set Z
	move	*a8(OZPOS),a14
	move	*a0(IANI3Z),a1
	add	a1,a14
	move	a14,*a6(OZPOS)
	sub	a1,a14
	neg	a1
	move	a1,*a6(OMISC)		;Z offset

					;>Calc head scale anixy (A3,A5)
	subi	GZBASE,a14		;-Base
	jrge	#zok
	clr	a14
#zok	srl	4,a14			;/16
	sll	6,a14			;*64
	move	*a6(ODATA_p),a0,L
	addk	32,a0
	add	a14,a0

	move	*a0+,a14
	sll	4,a14			;*16
	move	*a6(OIMG),a2,L

	move	*a2(IANIOFFX),a3
	mpys	a14,a3

	move	*a0,a14
	sll	4,a14			;*16

	move	*a2(IANIOFFY),a5
	mpys	a14,a5

	move	*a6(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	#nohf			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a3
	add	a2,a3			;+size
#nohf

	callr	anipt3_getsclxy

	move	*a8(OYVAL),a14,L
	add	a1,a14			;Ani3 Y
	sub	a5,a14
	move	a14,*a6(OYVAL),L

	move	*a8(OXVAL),a14,L
	move	a14,a1
	add	a0,a14			;Ani3 X
	sub	a3,a14
	move	a14,*a6(OXVAL),L


	move	*a8(OXANI),a0,L		;Make head X+ani = plyr X+ani
	add	a0,a1
	sub	a14,a1
	move	a1,*a6(OXANI),L


	rets


#*******************************
* Referee tosses up ball (process)

 SUBRP	plyr_referee

	movk	1,a0
	callr	plyr_setac

	movi	[WRLDMID,0],a0
	clr	a1
	movi	shadow7,a2
	movi	CZMID-30-1,a3
	movi	DMAWNZ|M_3D|M_SHAD|M_NOCOLL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
;	movi	50,a0
;	move	a0,*a8(OMISC)		;Z offset
	move	a8,a11

	movi	[WRLDMID,0],a0
	clr	a1
	movi	reftip1,a2
	movi	CZMID-30,a3
	movi	DMAWNZ|M_3D|M_NOCOLL,a4
	calla	BEGINOBJ2

	movi	#att_t,a0
	move	a0,*a13(plyr_attrib_p),L

	movi	scale63_t,a0
	move	a0,*a8(ODATA_p),L

	SLEEPK	5

	movk	1,a0
	move	a0,*a13(plyr_ownball)		;!0=Ref has ball
	movk	25,a0
	move	a0,*a13(plyr_ballzo)

	movi	#ani_l,a9
	movk	1,a10
#lp
	dsj	a10,#noani

#getwt	move	*a9+,a10
	jrz	#refdone
	jrnn	#nocode
	
	move	*a9+,a0,L			;Call function
	call	a0
	jruc	#getwt
#nocode
	move	*a9+,a0,L
	movk	M_WRNONZ,a1
	callr	plyr_ani

	callr	anipt2_getsclxy
	move	a0,*a13(plyr_ballxo),L
	sra	16,a1
	move	a1,*a13(plyr_ballyo)

	move	*a13(plyr_aniy),a1
	neg	a1
	move	a1,*a8(OYPOS)			;Set on gnd

#noani
	move	*a13(plyr_ownball),a0
	jrz	#noball				;Tossed up?

	callr	plyr_setballxyz
#noball

	SLEEPK	1
	move	@HALT,a0
	jrnz	#noball

	jruc	#lp

#refdone
	SLEEPK	5
	calla	SCRTST
	jrz	#refdone			;Still on screen?
	move	a11,a0
	calla	DELOBJ
	jauc	DELOBJDIE


#att_t	.long	scale63_t,Ref_p


#ani_l	WL	TSEC,reftip1
	WL	10,reftip2
	WL	10,reftip1
	WL	10,reftip3
	WL	10,reftip4
	WL	10,reftip5
	WL	-1,#do_whstle
	WL	10,reftip6
	WL	10,reftip7
	WL	10,reftip8
	WL	8,reftip9
	WL	7,reftip10
	WL	7,reftip11
	WL	7,reftip12
	WL	-1,#tossball
	WL	7,reftip13
	WL	7,reftip14
	WL	6,reftip15
	WL	5,reftip16

	WL	-1,#step_back
	WL	3,refbk1
	WL	3,refbk2
	WL	3,refbk3
	WL	3,refbk4
	WL	3,refbk5
	WL	3,refbk6
	WL	3,refbk7
	WL	3,refbk8
	WL	3,refbk1
	WL	3,refbk2
	WL	3,refbk3
	WL	3,refbk4
	WL	3,refbk5
	WL	3,refbk6
	WL	3,refbk7
	WL	3,refbk8
	WL	3,refbk1
	WL	3,refbk2
	WL	3,refbk3
	WL	3,refbk4
	WL	3,refbk5
	WL	3,refbk6
	WL	3,refbk7
	WL	3,refbk8
	WL	3,refbk1
	WL	3,refbk2
	WL	3,refbk3
	WL	3,refbk4
	WL	3,refbk5
	WL	3,refbk6
	WL	3,refbk7
	WL	3,refbk8
	WL	3,refbk1
	WL	3,refbk2
	WL	3,refbk3
	WL	3,refbk4
	WL	3,refbk5
	WL	3,refbk6
	WL	3,refbk7
;	WL	3,refbk8
	WL	-1,#stop_back
	WL	5,refsqt5
	W0


#do_whstle
	movi	whstle_snd,a0
	jauc	snd_play1ovr


#tossball
	move	@ballobj_p,a1,L
	movi	-GRAVB*50,a0
	move	a0,*a1(OYVEL),L
	clr	a0
	move	a0,@clock_active		;Turn on clock
	move	a0,*a13(plyr_ownball)		;Let go
	rets


#step_back
	movi	-14000h,a0
	move	a0,*a8(OZVEL),L
	move	a0,*a11(OZVEL),L
	clr	a0
	callr	plyr_setac
	rets

#stop_back
	clr	a0
	move	a0,*a8(OZVEL),L
	move	a0,*a11(OZVEL),L
	rets



#*******************************
* End of quarter (JSRP by score)

 SUBR	plyr_endofqrtr

	movi	1000,a0
	move	a0,@cntrs_delay		;Delay credit timers

	move	@gmqrtr,a0		;Next quarter
	addk	1,a0
	move	a0,@gmqrtr

	subk	1,a0
	jrne	#not1st

	movi	AUD_1STQUARTR,a0	;>1st guarter
	calla	AUD1

	JSRP	plyr_endqfinishshot
	JSRP	hint_page
	jruc	#tob


#not1st
	subk	1,a0
	jrne	#nothalf

	movi	AUD_HALFTIME,a0		;>2nd quarter
	calla	AUD1

	JSRP	plyr_endqfinishshot
	clr	a0
	JSRP	stats_page

	movi	t1dunkcnt,a2		;>Setup most dunking team for board shatter
	move	*a2+,a0
	move	*a2,a1
	cmp	a0,a1
	jrhs	#t2md			;Team2 has more dunks
	subk	16,a2
	move	a0,a1
#t2md	cmpi	7,a1
	jrlt	#nobrk			;!Enough dunks?
	subk	4,a1
	neg	a1
	move	a1,*a2			;New cnt
#nobrk
	jruc	#tob


#nothalf
	subk	1,a0
	jrne	#not3rd

	movi	AUD_3RDQUARTR,a0	;>3rd quarter
	calla	AUD1
	JSRP	plyr_endqfinishshot
	JSRP	hint_page
	jruc	#tob


#not3rd
	subk	1,a0
	jrne	#not4th

	movi	AUD_4THQUARTR,a0	;>4th quarter
	calla	AUD1

	JSRP	plyr_endqfinishshot

 	move	@scores,a0
	move	@scores+16,a1
	cmp	a0,a1
	jreq	#tie


#endofg	callr	endgame_audits		;>End of game

	JSRP	result_screen

	movk	1,a0
	JSRP	stats_page

	calla	save_player_records

	JSRP	rank_screen
	JSRP	winner_stays_on
;	move	@PSTATUS,a0
;	jrz	#x
;	jruc	game_start2
;#x
	jauc	game_over



#not4th
	JSRP	plyr_endqfinishshot	;>Overtime

 	move	@scores,a0
	move	@scores+16,a1
	cmp	a0,a1
	jrne	#endofg

;Display Double otr Triple OT message, keep going...




#tie					;>Tie
	movk	1,a0
	move	a0,@HALT

	movi	6*TSEC+10-70+60-20,a11
	CREATE0	scr1
	CREATE0	show_ot_msg
	SLEEP	200+40+60-20

	movk	12,a1			;Free time into OT for
	movi	P1DATA,a2

	move	@game_purchased,a0
	movk	4,b0
	clr	a3

#tlp	btst	a3,a0
	jrz	#nx			;No full game?
	move	a1,*a2(ply_time)	;Give xtra time
#nx	addi	PDSIZE,a2
	addk	1,a3
	dsj	b0,#tlp

	move	b0,@game_purchased

	move	@ballpnum,a11
	jrnn	#ok1
	move	@ballpnumshot,a11
#ok1
	srl	1,a11
	subk	1,a11
	CREATE0	plyr_takeoutball3
	jruc	#tob2




#tob
	movi	nofade_t,a10
	CREATE0	fade_up_half

	move	@gmqrtr,a11
	sll	32-1,a11
	CREATE0	plyr_takeoutball2

#tob2
	clr	a0
	move	a0,@HALT
	move	a0,@cntrs_delay		;Delay credit timers
	movi	2<<10+4<<5+9,a0
	move	a0,@IRQSKYE

;Make sure #'s are on at start of qrtr
	movi	P1DATA,a10
	calla	stick_number
	movi	P2DATA,a10
	calla	stick_number
	movi	P3DATA,a10
	calla	stick_number
	movi	P4DATA,a10
	calla	stick_number

	RETP


#*******************************

 SUBRP	endgame_audits

;	movi	0100b,a0
;	move	a0,@PSTATUS2
;
;	movi	28,a0
;	move	a0,@scores
;	movi	49,a0
;	move	a0,@scores+10h


	movi	AUD_COMPLETED,a0	;>4th quarter
	calla	AUD1

	move	@scores,a0
	move	@scores+10h,a1
	cmp	a1,a0
	jrhi	#t1_wins
#t2_wins
	movi	AUD_LOS_SCORE,a0
	move	@scores,a1
	calla	AUD

	movi	AUD_WIN_SCORE,a0
	move	@scores+10h,a1
	calla	AUD

	jruc	#cont

#t1_wins
	movi	AUD_WIN_SCORE,a0
	move	@scores,a1
	calla	AUD

	movi	AUD_LOS_SCORE,a0
	move	@scores+10h,a1
	calla	AUD
#cont

	move	@PSTATUS2,a0
	andi	011b,a0
	jrnz	#team1_human
;#team1_cpu
	move	@scores,a4		;CPU SCORE
	move	@scores+10h,a5		;HUMAN SCORE

	movi	AUD_CPUGAMES,a0		;a cpu team
	calla	AUD1
	movi	AUD_CPUSCORES,a0
	move	a4,a1			;cpu score
	calla	AUD
	callr	do_cpu_stats
	jruc	#cont2

#team1_human
	movi	AUD_HUMGAMES,a0		;a human team
	calla	AUD1
	movi	AUD_HUMSCORES,a0
	move	@scores,a1		;human score
	calla	AUD


#cont2
	move	@PSTATUS2,a0
	andi	01100b,a0
	jrnz	#team2_human

;#team2_cpu
	move	@scores+10h,a4		;CPU SCORE
	move	@scores,a5		;HUMAN SCORE


	movi	AUD_CPUGAMES,a0		;a cpu team
	calla	AUD1
	movi	AUD_CPUSCORES,a0
	move	a4,a1			;cpu score
	calla	AUD
	callr	do_cpu_stats
	rets

#team2_human
	movi	AUD_HUMGAMES,a0		;a human team
	calla	AUD1
	movi	AUD_HUMSCORES,a0
	move	@scores+10h,a1		;human score
	calla	AUD

	rets


#*******************************
* Update CPU stats
* A4=Cpu score
* A5=Human score

do_cpu_stats

	cmp	a4,a5
	jrhi	#cpu_loses

;cpu_wins
	movi	AUD_CPUWINS,a0		;CPU victories + 1
	calla	AUD1

	movi	AUD_CPUWINMARG,a0
	calla	GET_AUD			;RET in A1

	sub	a5,a4
	cmp	a1,a4
	jrls	#not_higher
	move	a4,a1
	movi	AUD_CPUWINMARG,a0	;new win margin
	calla	STORE_AUDIT
	rets

#cpu_loses
	movi	AUD_CPULOSMARG,a0
	calla	GET_AUD			;RET in A1

	sub	a4,a5			;HUMAN - CPU SCORE
	cmp	a1,a5
	jrls	#not_higher
	move	a5,a1
	movi	AUD_CPULOSMARG,a0	;new loss margin
	calla	STORE_AUDIT
#not_higher
	rets



#*******************************
* Let shot finish at end of quarter (JSRP)

 SUBRP	plyr_endqfinishshot

	movi	TSEC*5/2,a10
#lp
	move	@ballpnum,a0
	jrnn	#stop			;Somebody has ball?
	move	@ballobj_p,a2,L
	move	*a2(OYPOS),a0
	cmpi	-15,a0
	jrgt	#stop			;Ball near gnd?

	SLEEPK	2

#gbcnt	dsj	a10,#lp

#stop
	movk	1,a0
	callr	plyr_setac

	clr	a0			;>Clr ctrl bits
	movi	P1CTRL,a1
	movk	2,b0
#stlp	move	a0,*a1+,L
	dsj	b0,#stlp



	movi	clockid,a0
	calla	KIL1C 			;Kill existing shot clock proc
	movi	CLSDEAD|clockid,a0
	calla	obj_del1c		;Delete any 24 second shot clock imgs
	clr	a0
	move	a0,@sc_proc,L
	move	a0,@game_time,L

	movk	1,a0
	move	a0,@HALT

	CREATE0	score_showtvpanel2


	move	@gmqrtr,a0		;Ran out of time
	subk	4,a0
	jrlt	#fade
	move	@scores,a0
	move	@scores+16,a1
	cmp	a0,a1
	jreq	#x

;Turn on Overtime message saying 2 more minutes

#fade	movi	nofade_t,a10
	CREATE0	fade_down_half


#x	RETP


nofade_t			;Pals not to fade
	.long	scorepr
	.long	scorep
	.long	scorepb
	.long	scorepy
	.long	GROWBOX
	.long   SGMD8RED
	.long   SGMD8WHT
	.long	textp
	.long	ledw
	.long	ledr
	.long	MD_16
	.long	MD_16r
	.long	LED_P
	.long	0

#*******************************
* Player goaltended (Process)
* A11=*Plyr obj

 SUBR	plyr_goaltending

	move	*a11(OPLINK),a11,L
	move	*a11(plyr_num),a0

	srl	1,a0
	move	a0,a11
	XORK	1,a0
	sll	4,a0			;0 or 16

	addi	scores,a0		;+Base
	move	@ballptsforshot,a1
	move	a1,a3
	calla	score_add

	calla	plyr_setptsdown

	clr	a0
	move	a0,@ballptsforshot

	movk	PS_2PTS_MADE,a0		;>Inc try shot stat
	subk	2,a3
	jreq	#2ptr
	movk	PS_3PTS_MADE,a0
#2ptr	move	@ballpnumshot,a1
	calla	inc_player_stat

	calla	prt_top_scores		;Update scores at scrn top

	movi	TSEC*2,a0
	callr	plyr_setshtdly

	CREATE0	goaltend_text

	movi	whstle_snd,a0
	calla	snd_play1

	move	@tvpanelon,a0,L
	jrz	#turnon
	movi	4*TSEC+10-70,a1
	move	a1,*a0(PTIME)
	jruc	#alrdyon
#turnon
	CREATE0	score_showtvpanel
#alrdyon


;	movi	#gt_t,a8
;	CREATE0	plyr_showfoul

	movi	P1DATA,a10
	calla	stick_number
	movi	P2DATA,a10
	calla	stick_number
	movi	P3DATA,a10
	calla	stick_number
	movi	P4DATA,a10
	calla	stick_number

	SLEEP	30

	jruc	plyr_takeoutball3


;#gt_t	WWL	155,20,refgltnd
;	.word	-1


#*******************************
* Show goaltending message (JSRP)

 SUBRP	goaltend_text


;	move	@ballobj_p,a2,L		;clear out ball vels
;	clr	a0
;	move	a0,*a2(OXVEL),L
;	move	a0,*a2(OYVEL),L
;	move	a0,*a2(OZVEL),L
;
;	movk	4,a3
;	movi	plyrobj_t,a2,L		;clear out player vels
;#velini_lp
;	move	*a2+,a1,L
;	move	a0,*a1(OXVEL),L
;	move	a0,*a1(OYVEL),L
;	move	a0,*a1(OZVEL),L
;	dsj	a3,#velini_lp
;
;	SLEEPK	1
;
;	movk	1,a0
;	move	a0,@HALT

	movi	#ln0_setup,a2
	calla	setup_message

	movi	CLSDEAD|123,a0
	move	a0,@mess_objid

	movi	#str_goaltend,a4
	calla	print_string_C2


	CREATE0	flash_bigtxt
	move	a0,a9

	movk	5,a10
	CREATE0	doalert_snd

	SLEEP	TSEC*2

	move	a9,a0
	calla	KILL

	movi	CLSDEAD|123,a0
	calla	obj_del1c		;delete text

;	clr	a0
;	move	a0,@HALT

	DIE


#ln0_setup
	RJR_STR	omlgmd_ascii,12,0,200,120-44/2,LGMDRED2,0

#str_goaltend
	.string	"GOAL TENDING",0

	.even


#*******************************
* Show message "G" (process)

; SUBRP	plyr_showfoul
;
;	movi	whstle2_snd,a0
;	calla	snd_play1
;
;	move	*a8+,a0
;	sll	16,a0
;	move	*a8+,a1
;	sll	16,a1
;	move	*a8+,a2,L
;	movi	1005,a3
;	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
;	movi	CLSDEAD,a5
;	clr	a6
;	clr	a7
;	calla	BEGINOBJ2
;	move	a8,a9
;
;	movi	[150,0],a0
;	movi	[20,0],a1
;	movi	BkgFlr,a2
;	movi	990,a3
;	calla	BEGINOBJ2
;	move	a8,a10
;
;	movi	[192,0],a0
;	movi	[120,0],a1
;	movi	OSGEMD_G,a2
;	movi	1010,a3
;	calla	BEGINOBJ2
;
;	SLEEP	TSEC*2
;
;	move	a9,a0
;	calla	DELOBJ
;	move	a10,a0
;	calla	DELOBJ
;
;	jauc	DELOBJDIE



#*******************************
* Control players for taking the ball out (Process)
* A11=Team who gets ball (0=1, !0=2)

	STRUCTPD
	WORD	ptob_pball	;Plyr # (0-3) who gets ball
	WORD	ptob_pball2	;P# who gets ball passed to him


 SUBR	plyr_takeoutball

;	move	@ballpnumshot,@ballpnum	;DEBUG
;	move	@ballpnumshot,a2
;	sll	5,a2			;*32
;	addi	plyrproc_t,a2
;	move	*a2,a1,L
;	clr	a0
;	move	a0,*a1(plyr_dribmode)	;Reset dribble
;	movi	-1,a0
;	move	a0,@inbound
;	DIE


	movi	TOB_PID,a0		;Kill any other plyr_takeoutball
	move	a0,*a13(PROCID)
	calla	KIL1C

	movk	8,a0
	move	a0,@ballsclastp

	movi	TSEC+20,a0
	callr	plyr_setshtdly
	clr	a0
	move	a0,@P1CTRL,L			;clear p1 & p2
	move	a0,@P3CTRL,L			;p3 & p4

	SLEEPK	1

	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast


	movk	1,a0
	callr	plyr_setac

	clr	a0			;Clr staggers
	movi	plyr_stagcnt,a1
	callr	plyr_setprocword


	movi	plyrproc_t,a0
	clr	a1
	clr	a2
	move	@PSTATUS,a3
	movk	2,a9
	move	a11,a11
	jrz	#t1
	addi	32*2,a0
	movk	1,a1
	movk	2,a2
	srl	2,a3
	clr	a9
#t1
	move	*a0+,a8,L		;A8=*Proc of plyr who gets ball
	move	*a0+,a7,L
	move	a1,@inbound		;Inbounding team (0-1)

	move	a3,a3			;if human and CPU
	jrz	#no_players		;always make CPU
	cmpi	011b,a3			;pass ball to human
	jreq	#two_players
	andi	1,a3
	jrz	#1st
	jruc	#2nd

#two_players
#no_players
	move	*a8(plyr_balldist),a0
	move	*a7(plyr_balldist),a1

	cmp	a1,a0
	jrle	#1st			;Closer?
#2nd
	move	a7,a8
	addk	1,a2			;2nd in team
#1st
	move	a2,*a13(ptob_pball)
	XORK	1,a2
	move	a2,*a13(ptob_pball2)


	movi	TSEC*3,a10		;>Get ball
#gblp1
	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast

	SLEEPK	1

	callr	plyrtob_moveo3

	move	@ballobj_p,a3,L
	move	*a3(OXPOS),a0
	addk	6,a0
	move	*a3(OZPOS),a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy
	jrz	#atball
	dsj	a10,#gblp1
	jruc	#atball2
#atball
	move	*a8(plyr_jmpcnt),a0
	jrnz	#gblp1
#atball2

	clr	a0
	move	a0,*a8(plyr_shtdly)

	movi	TSEC*1,a10		;>Get ball
#gblp2
	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast
	SLEEPK	1
	move	@ballpnum,a0
	jrn	#gbcnt2
	move	*a13(ptob_pball),a2
	cmp	a0,a2
	jreq	#gotball
#gbcnt2
	callr	plyrtob_moveo3
	move	@ballobj_p,a3,L
	move	*a3(OXPOS),a0
	addk	6,a0
	move	*a3(OZPOS),a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy
	dsj	a10,#gblp2

#gotball
	move	*a13(ptob_pball),a0
	move	a0,@ballpnum
	clr	a0
	move	a0,*a8(plyr_dribmode)



	movi	TSEC*3,a10		;>Run out of bounds

#outlp
	SLEEPK	1

	callr	plyrtob_moveo3

	movi	-355,a0
	move	a11,a11
	jrz	#outl			;Team2 on def
	neg	a0
#outl	addi	WRLDMID,a0
	move	a0,a3
	movi	CZMID-20,a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy
	jrz	#outofb
	dsj	a10,#outlp

#outofb
	movi	TSEC*3,a10		;>Wait for other 3 to get in place

#wtlp	SLEEPK	1
	callr	plyrtob_moveo3
	jrz	#inpos
	dsj	a10,#wtlp
#inpos
	SLEEPK	30

	move	*a13(ptob_pball),a10	;>Pass with turbo
	sll	4,a10			;*16
	addi	P1CTRL,a10
	movi	(BUT2_M|BUT3_M)<<8|BUT2_M|BUT3_M,a0
	move	a0,*a10

	move	*a13(ptob_pball),a0
	move	a0,@ballpnum
	movi	TSEC*2,a2		;>Wait for pass to start
#waitp	PUSHP	a2
	SLEEPK	1
	PULLP	a2
	move	*a8(plyr_seqflgs),a0
	btst	PASS_B,a0
	jrnz	#passing
	dsj	a2,#waitp
#passing

	clr	a0
	move	a0,*a10
	movi	-1,a0
	move	a0,@inbound		;Inbounding off

	SLEEPK	30
#runinlp
	SLEEPK	1
	movi	-345,a0
	move	a11,a11
	jrz	#outl2			;Team2 on def
	neg	a0
#outl2	addi	WRLDMID,a0
	movi	CZMID-20,a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy
	jrnz	#runinlp




plyr_tobend
	calla	shot_clock		;New 24
	clr	a0
	move	a0,@clock_active	;Start game clock again
	move	a0,@plyrinautorbnd	;In case seq didn't clr
	move	a0,@ballflash
	move	a0,@pass_off
	move	a0,@steals_off
	move	a0,@slamming

	callr	plyr_setac

	clr	a0			;Clr staggers
	movi	plyr_stagcnt,a1
	callr	plyr_setprocword

	clr	a0
	movi	plyr_d_cflgs,a1
	callr	plyr_setprocword


	DIE


#*****************************************************************************
* Control players for taking the ball out (Process)
* Teleport players to their positions
* A11=Team who gets ball (0=1, !0=2)

	.asg	60h,FACE_LEFT
	.asg	20h,FACE_RIGHT

 SUBR	plyr_takeoutball2

	movi	TOB_PID,a0		;Kill any other plyr_takeoutball
	move	a0,*a13(PROCID)
	calla	KIL1C

	movk	8,a0
	move	a0,@ballsclastp

	movk	1,a0
	callr	plyr_setac

	clr	a0
	move	a0,@P1CTRL,L			;clear p1 & p2
	move	a0,@P3CTRL,L			;p3 & p4

	clr	a0
	move	a0,@WORLDTLY,L
	movi	[WRLDMID-200-MAX_VIEW1,0],a1
	clr	a2				;player 1 has ball
	movi	#t1_setup_table,a10
	move	a11,a11
	jrz	#setib
	movk	1,a0
	movi	[WRLDMID-200+MAX_VIEW1,0],a1
	movk	3,a2				;player 4 has ball
	movi	#t2_setup_table,a10
#setib	move	a0,@inbound			;Inbounding team
	move	a1,@WORLDTLX,L
	subi	[WRLDMID-200,0],a1
	move	a1,@gndx,L
	move	a2,@ballpnum
	movi	-1,a0
	move	a0,@ballpnumlast
	move	a2,*a13(ptob_pball)		;0,3
	move	a2,a0
	XORK	1,a0
	move	a0,*a13(ptob_pball2)		;1,2


	PUSH	a13
	sll	5,a2				;x 32 bits
	movi	plyrobj_t,a8
	add	a2,a8
	move	*a8,a8,L			;*Plyr obj
	addi	plyrproc_t,a2
	move	*a2,a13,L			;*Plyr process
	callr	plyr_setballxyz
	PULL	a13

	movk	4,a14
#init_loop
	PUSH	a14
	move	*a10+,a0			;player (0-3)
	move	*a10+,a4
	sll	16,a4				;player Z VAL
	move	*a10+,a5
	sll	16,a5				;player X VAL
	move	*a10+,a7			;player direction (right)
	callr	plyr_init
	PULL	a14
	dsj	a14,#init_loop


	SLEEP	1*60

	move	*a13(ptob_pball),a10	;>Pass with turbo
	sll	4,a10			;*16
	addi	P1CTRL,a10
	movi	(BUT2_M|BUT3_M)<<8|BUT2_M|BUT3_M,a0
	move	a0,*a10

#waitp	SLEEPK	1
	move	*a8(plyr_seqflgs),a0
	btst	PASS_B,a0
	jrz	#waitp

	clr	a0
	move	a0,*a10
	movi	-1,a0
	move	a0,@inbound		;Inbounding off

	SLEEPK	30
#runinlp
	SLEEPK	1
	movi	-345,a0
	move	a11,a11
	jrz	#outl2			;Team2 on def
	neg	a0
#outl2	addi	WRLDMID,a0
	movi	CZMID-20,a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy
	jrnz	#runinlp

	jruc	plyr_tobend



#t1_setup_table
;normal setup (left)
	.word	0,CZMID-20,	WRLDMID-365,	20h	;ply,z,x,face
	.word	1,CZMID+15,	WRLDMID-280,	60h	;ply,z,x,face
	.word	2,CZMID-50,	WRLDMID-160,	60h	;ply,z,x,face
	.word	3,CZMID+70,	WRLDMID-160,	60h	;ply,z,x,face

#t2_setup_table
;normal setup	(right)
	.word	3,CZMID-20,	WRLDMID+365,	60h	;ply,z,x,face
	.word	2,CZMID+15,	WRLDMID+280,	20h	;ply,z,x,face
	.word	0,CZMID-50,	WRLDMID+160,	20h	;ply,z,x,face
	.word	1,CZMID+70,	WRLDMID+160,	20h	;ply,z,x,face


#*****************************************************************************
* Clear out plyr variables
*	a0 = player number in (0-3)
*	a4 = player Z VAL
*	a5 = player X VAL
*	a7 = player direction	(00h - 7fh)

 SUBR	plyr_init

	PUSH	a8,a10,a13

	sll	5,a0			;x 32 bits
	movi	plyrproc_t,a13
	add	a0,a13
	move	*a13,a13,L		;*plyr process

	addi	plyrobj_t,a0
	move	*a0,a8,L		;*plyr object

	move	a4,*a8(OZVAL),L
	callr	anipt_getsclxy		;a0 = anix, a1 = aniy
	move	a0,*a8(OXANI),L
	neg	a1
	move	a1,*a8(OYVAL),L
	sub	a0,a5
	move	a5,*a8(OXVAL),L

	movk	STND_SEQ,a0
	callr	plyr_setseq

	clr	a0

	move	a0,*a8(OXVEL),L
	move	a0,*a8(OYVEL),L
	move	a0,*a8(OZVEL),L

	move	a0,*a13(plyr_jmpcnt)
	move	a0,*a13(plyr_dribmode)
	move	a0,*a13(plyr_offscrn)
	move	a0,*a13(plyr_d_cflgs)
	move	a0,*a13(plyr_hangcnt)
	move	a0,*a13(plyr_nojoy)
	move	a0,*a13(plyr_shtdly)
	move	a0,*a13(plyr_passbtime)
	move	a0,*a13(plyr_rcvpass)
	move	a0,*a13(plyr_ownball)
	move	a0,*a13(plyr_stagcnt)

	movi	-1,a0
	move	a0,*a13(plyr_newdir)

	movk	1,a0
	move	a0,*a13(PA10),L		;reset sequence wake count

	PULL	a8,a10,a13
	rets



#*****************************************************************************
* Control players for taking the ball out (Process)
* A11=Team who gets ball (0=1, !0=2)

 SUBR	plyr_takeoutball3

	movi	TOB_PID,a0		;Kill any other plyr_takeoutball
	move	a0,*a13(PROCID)
	calla	KIL1C

	movk	8,a0
	move	a0,@ballsclastp

	movk	25,a0
	callr	plyr_setshtdly

	SLEEPK	1

	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast


	clr	a0
	move	a11,a11
	jrz	#setib
	movk	1,a0
#setib	move	a0,@inbound		;Inbounding team


	movk	1,a0
	callr	plyr_setac

	clr	a0			;Clr staggers
	movi	plyr_stagcnt,a1
	callr	plyr_setprocword


	clr	a2
	movk	2,a9			;A9=1st p# of team on defense
	movi	plyrproc_t,a0
	move	a11,a11
	jrz	#t1
	movk	2,a2
	clr	a9
	addi	32*2,a0
#t1
	move	*a0+,a8,L		;A8=*Proc of plyr who gets ball
	move	*a0+,a7,L
	move	*a8(plyr_hpdist),a0
	move	*a7(plyr_hpdist),a1
	cmp	a1,a0
	jrle	#1st			;Closer?
	move	a7,a8
	addk	1,a2			;2nd in team
#1st
	move	a2,*a13(ptob_pball)
	move	a2,@ballpnum
	XORK	1,a2
	move	a2,*a13(ptob_pball2)
	movi	-1,a0
	move	a0,@ballpnumlast

#outlp
	SLEEPK	1

	move	*a13(ptob_pball),a0
	move	a0,@ballpnum
	clr	a0
	move	a0,*a8(plyr_dribmode)

	callr	plyrtob_moveo3

	movi	-355,a0
	move	a11,a11
	jrz	#outl			;Team2 on def
	neg	a0
#outl	addi	WRLDMID,a0
	movi	CZMID-20,a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy
	jrnz	#outlp


	movi	TSEC*3,a10		;>Wait for other 3 to get in place

#wtlp	SLEEPK	1
	callr	plyrtob_moveo3
	jrz	#inpos
	dsj	a10,#wtlp
#inpos

	SLEEP	60

	move	*a13(ptob_pball),a10	;>Pass with turbo
	sll	4,a10			;*16
	addi	P1CTRL,a10
	movi	(BUT2_M|BUT3_M)<<8|BUT2_M|BUT3_M,a0
	move	a0,*a10


#waitp	SLEEPK	1
	move	*a8(plyr_seqflgs),a0
	btst	PASS_B,a0
	jrz	#waitp

	clr	a0
	move	a0,*a10

	movi	-1,a0
	move	a0,@inbound		;Inbounding off

	SLEEPK	30
#runinlp
	SLEEPK	1
	movi	-345,a0
	move	a11,a11
	jrz	#outl2			;Team2 on def
	neg	a0
#outl2	addi	WRLDMID,a0
	movi	CZMID-20,a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy
	jrnz	#runinlp

	jruc	plyr_tobend



********************************
* Set new autoctrl value
* A0=autoctrl #
* Trashes scratch

 SUBRP	plyr_setac

	movi	plyrproc_t,a14
	movk	4,b0
#aclp	move	*a14+,a1,L
	move	a0,*a1(plyr_autoctrl)
	dsj	b0,#aclp
	rets

#*******************************
* Set new shtdly value
* A0=shtdly #
* Trashes scratch

 SUBR	plyr_setshtdly

	movi	plyrproc_t,a14
	movk	4,b0
#aclp	move	*a14+,a1,L
	move	a0,*a1(plyr_shtdly)
	dsj	b0,#aclp
	rets

#*******************************
* Set word in plyr's proc
* A0=#
* A1=Proc offset
* Trashes scratch

 SUBRP	plyr_setprocword

	move	a2,b1
	movi	plyrproc_t,a14
	movk	4,b0
#aclp	move	*a14+,a2,L
	add	a1,a2
	move	a0,*a2
	dsj	b0,#aclp
	move	b1,a2
	rets



#*******************************
* Move the other 3 guys who aren't getting the ball
* A9=1st pnum of team on defense (0/2)
* A11=Team who gets ball (0=1, !0=2)
* >A0=0 if all players in position (Pass CC)
* Trashes scratch, A2-A4

 SUBRP	plyrtob_moveo3

	movi	-150,a0			;>Send defenders to their spot
	movi	-270,a4
	move	a11,a11
	jrz	#t2			;Team1 gets?
	neg	a0
	neg	a4
#t2	addi	WRLDMID,a0
	move	a0,a3
	movi	CZMID-50,a1
	move	a9,a2
	callr	plyrtob_seekxy
	PUSH	a0

	move	a3,a0
	movi	CZMID+70,a1
	addk	1,a2
	callr	plyrtob_seekxy
	PUSH	a0

	move	a4,a0			;>Send teammate to spot
	addi	WRLDMID,a0
	movi	CZMID+10,a1
	move	*a13(ptob_pball2),a2
	callr	plyrtob_seekxy
	PULL	a1
	or	a1,a0
	PULL	a1
	or	a1,a0

	rets


#*******************************
* Push stick to move plyr towards an XZ location
* A0=X to seek
* A1=Z
* A2=Player # (0-3)
* >A0=Joy bits set or 0 (Pass CC)
* Trashes scratch

 SUBRP	plyrtob_seekxy

	PUSH	a2,a8,a11

	move	a0,b0

	sll	4,a2			;*16
	move	a2,a11
	addi	P1CTRL,a11
	sll	1,a2
	addi	plyrobj_t,a2
	move	*a2,a8,L


	move	*a8(OXPOS),a2
	move	*a8(OXANI+16),a14
	add	a14,a2
	sub	a0,a2

	clr	a0

	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	#onx
	move	a14,a14
	jrlt	#nolft
	subk	4,a0			;Left

#nolft	addk	8,a0			;Rgt
#onx
	move	*a8(OZPOS),a2

	sub	a1,a2
	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	#onz
	move	a14,a14
	jrlt	#noup
	subk	1,a0			;Up

#noup	addk	2,a0			;Dn
#onz
	move	a0,*a11
	move	a0,a0
	jrnz	#x

	move	b0,a14
	move	*a8(OXANI+16),a2
	sub	a2,a14
	move	a14,*a8(OXPOS)

	move	a1,*a8(OZPOS)

	move	*a8(OXVEL),a1,L
	sra	1,a1
	move	a1,*a8(OXVEL),L
	move	*a8(OZVEL),a1,L
	sra	1,a1
	move	a1,*a8(OZVEL),L

#x	PULL	a2,a8,a11
	move	a0,a0
	rets



#*******************************
* Control players for free throws (Process)
* A11=Team who scored (0=2, !0=1)

	STRUCTPD
	WORD	pft_pball	;Plyr # (0-3) who gets ball
	WORD	pft_pball2	;P# who gets ball passed to him
	APTR	pft_bbobj	;*Backboard/crowd object


 SUBR	plyr_freethrow

	jruc	plyr_takeoutball

	movi	TSEC,a10		;>Let shot finish
#lp	movi	-1,a0
	move	a0,@ballpnum
	SLEEPK	1
	dsj	a10,#lp


	movi	[20,0],a0
	movi	[20,0],a1
;	movi	ftbackbd,a2
	movi	[500,0],a3		;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(pft_bbobj),L


	movk	1,a0
	callr	plyr_setac

	clr	a2
	movk	2,a9			;A9=1st p# of team on defense
	movi	plyrproc_t,a0
	move	a11,a11
	jrz	#t1
	movk	2,a2
	clr	a9
	addi	32*2,a0
#t1
	move	*a0+,a8,L		;A8=*Proc of plyr who gets ball
	move	*a0+,a7,L
	move	*a8(plyr_balldist),a0
	move	*a7(plyr_balldist),a1
	cmp	a1,a0
	jrle	#1st			;Closer?
	move	a7,a8
	addk	1,a2			;2nd in team
#1st
	move	a2,*a13(pft_pball)
	XORK	1,a2
	move	a2,*a13(pft_pball2)


	movi	TSEC*4,a10		;>Get ball

#gblp
	movi	-1,a0
	move	a0,@ballpnum
	SLEEPK	1

	callr	plyrtob_moveo3

	move	@ballobj_p,a3,L
	move	*a3(OXPOS),a0
	addk	6,a0
	move	*a3(OZPOS),a1
	move	*a13(pft_pball),a2
	callr	plyrtob_seekxy

	move	@ballpnum,a0
	jrn	#gbcnt
	cmp	a0,a2
	jreq	#gotball

#gbcnt	dsj	a10,#gblp

#gotball
	move	*a13(pft_pball),a0
	move	a0,@ballpnum


	movi	TSEC*3,a10		;>Run out of bounds

#outlp
	SLEEPK	1

	callr	plyrtob_moveo3

	movi	-370,a0
	move	a11,a11
	jrz	#outl			;Team2 on def
	neg	a0
#outl	addi	WRLDMID,a0
	move	a0,a3
	movi	CZMID-20,a1
	move	*a13(pft_pball),a2
	callr	plyrtob_seekxy
	jrz	#outofb

;	move	*a8(PA8),a2,L		;Get * obj
;	move	*a2(OXPOS),a0
;	move	*a2(OXANI+16),a14
;	add	a14,a0
;	abs	a0
;	abs	a3
;	sub	a0,a3
;	subk	20,a3
;	jrlt	#outofb

	dsj	a10,#outlp

#outofb
	movi	TSEC*3,a10		;>Wait for other 3 to get in place

#wtlp	SLEEPK	1
	callr	plyrtob_moveo3
	jrz	#inpos
	dsj	a10,#wtlp
#inpos

	move	*a13(pft_pball),a10	;>Pass with turbo
	sll	4,a10			;*16
	addi	P1CTRL,a10
	movi	>60,a0
	move	a0,*a10

	SLEEPK	10
	clr	a0
	move	a0,*a10

	SLEEP	40

	clr	a0
	callr	plyr_setac

	move	*a13(pft_bbobj),a0,L
	calla	DELOBJ


	DIE







#***************************************************************
* Main drone logic
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	drone_main


	move	@ballpnum,a14
	jrn	drone_chaseball		;No owner?

	move	*a13(plyr_ownball),a1
	jrz	drone_defence		;We don't have ball?
	jrn	drone_offwoball		;Teammate has ball?


;-------				;>Offense
;	move	*a11,a0
;	andi	BUT1_M|BUT1_M<<8,a0
;	jrz	#db1
;	LOCKUP
;#db1

	move	@PSTATUS,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	XORK	1,a1
	btst	a1,a0
	jrz	#tmdrone		;Teammate is a drone?

	move	*a13(plyr_d_cflgs),a2
	btst	DRN_PASS_B,a2
	jrz	#nopass

	movi	BUT2_M<<8+BUT2_M,a14	;>Make him pass
	jruc	#docmd

#nopass
	btst	DRN_SHOOT_B,a2
	jrz	#noshoot
	movi	BUT1_M|BUT3_M,a14	;>Make him shoot
	movk	3,a0
	move	a0,*a13(plyr_d_seekcnt)
#docmd
	move	*a11,a0
	sll	32-4,a0
	srl	32-4,a0
;	move	a2,a2
;	jrnn	#noturb
	ori	BUT3_M,a0		;+turbo
#noturb
	or	a14,a0
	move	a0,*a11
	clr	a0
	move	a0,*a13(plyr_d_cflgs)
	jruc	#x

#noshoot
#tmdrone
;	clr	a0
;	move	a0,*a13(plyr_tbutn)

	move	*a13(plyr_seqflgs),a2
	btst	PASS_B,a2
	jrnz	#kilbuts

	move	*a13(plyr_jmpcnt),a14
	jrnz	#injmp

	move	*a11,a0
	btst	BUT1_B,a0
	jrnz	#fake			;Shoot button down?


	btst	SHOOT_B,a2
	jrnz	#injmp


	move	*a13(plyr_dribmode),a14
	jrn	#nodrib

	move	*a13(plyr_num),a14	;>Chk for breakaway
	srl	1,a14
	movk	1,a0
	xor	a0,a14
	sll	6,a14			;*64
	addi	plyrproc_t,a14
	move	*a14+,a2,L
	move	*a14+,a3,L

	move	*a2(plyr_hpdist),a2
	move	*a3(plyr_hpdist),a3
	move	*a13(plyr_ohpdist),a4

	cmp	a4,a2
	jrlt	#shootrnd		;He's closer?
	cmp	a4,a3
	jrlt	#shootrnd		;He's closer?

	move	*a13(plyr_ohoopx),a0
	movi	CZMID,a1
	callr	drone_seekxy
	ori	BUT3_M,a0		;Push turbo
	move	a0,*a11

	move	@game_time,a1,L
	cmpi	>200,a1
	jrlt	#shoot2			;Less than 2 secs?
	move	@shotimer+16,a1		;Tens
	jrnz	#scok
	move	@shotimer,a1		;Ones
	subk	2,a1
	jrlt	#shoot2			;Less than 2 secs?
#scok
	move	*a13(plyr_ohpdist),a14
	cmpi	160,a14
	jrge	#x			;Too far?
	cmpi	50,a14
	jrlt	#shoot2			;Close?
	movk	>1f,a0
	callr	rnd
	jrnz	#x
	jruc	#shoot2


#nodrib					;>Can't dribble
	move	*a13(plyr_ohpdist),a0
	cmpi	230,a0
	jrlt	#shoot2
	callr	drone_pass
	jrnz	#x			;Pass OK?
	movk	>1f,a0
	callr	rnd
	jrnz	#x			;97%?
	jruc	#shoot2


#shootrnd
	move	@game_time,a1,L
	cmpi	>200,a1
	jrlt	#shoot2			;Less than 2 secs?
	move	@shotimer+16,a1
	jrnz	#scok2
	move	@shotimer,a1
	subk	2,a1
	jrlt	#shoot2			;Less than 2 secs?
#scok2
	PUSH	a6,a7
	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128
	PULL	a6,a7

	move	*a13(plyr_o1dist),a14
	cmpi	80,a14
	jrgt	#o1dok			;He's too far?
	cmp	a14,a1
	jrlt	#o1dok			;I'm closer?
	move	*a13(plyr_o1dir),a2
	sub	a0,a2
	abs	a2
	cmpi	>40,a2
	jrle	#o1dsml
	subi	>80,a2
	abs	a2
#o1dsml	subk	32,a2
	jrlt	#goaround		;In front of me?
#o1dok
	move	*a13(plyr_o2dist),a14
	cmpi	80,a14
	jrgt	#o2dok			;He's too far?
	cmp	a14,a1
	jrlt	#o2dok			;I'm closer?
	move	*a13(plyr_o2dir),a2
	sub	a0,a2
	abs	a2
	cmpi	>40,a2
	jrle	#o2dsml
	subi	>80,a2
	abs	a2
#o2dsml	subk	32,a2
	jrlt	#goaround		;In front of me?
#o2dok
	jruc	#runath

#goaround				;>Opponent in my way
	move	*a13(plyr_tmdist),a0
	cmpi	70,a0
	jrlt	#goa			;Teammate too close?

	callr	drone_pass
	jrnz	#x			;Pass OK?

#goa
	movi	drnzzcnt,a2
	move	*a2,a0
	subk	1,a0
	jrgt	#zzsame

	movk	1,a0			;New mode
	callr	rnd
	move	a0,*a2(drnzzmode-drnzzcnt)
	movi	TSEC-10,a0
	callr	rndrng0
	addk	10,a0
#zzsame
	move	a0,*a2

	move	*a13(plyr_ohoopx),a0
	movi	CZMID,a1
	callr	drone_seekxy
	jrz	#shoot2			;In position?
	sll	3,a0			;*8
	addi	#jbits_t,a0

	move	*a2(drnzzmode-drnzzcnt),a14
	jrz	#md1
	addi	16*8,a0
#md1	movb	*a0,a0
	move	a0,*a11

	cmpi	80,a4
	jrlt	#shoot2			;Close enough for jam?

	jruc	#tryshot


#runath					;>I have a clr path to hoop!
	move	*a13(plyr_ohoopx),a0
	movi	CZMID,a1
	callr	drone_seekxy
	ori	BUT3_M,a0		;Turbo
	move	a0,*a11

#tryshot
	cmpi	50,a4
	jrlt	#shoot2			;Close enough for jam?

	movi	>3f,a0
	callr	rnd
	jrnz	#x

#shoot
	move	*a13(plyr_ohpdist),a14
	cmpi	240,a14
	jrge	#x			;Too far?

#shoot2	move	*a11,a0			;>Shoot
	ori	BUT1_M|BUT3_M,a0
	move	a0,*a11
	movk	1,a0			;Max fakes
	move	a0,*a13(plyr_d_seekcnt)
	jruc	#x


#fake					;>Jumping but still on gnd
	move	*a13(plyr_d_seekcnt),a2
	jrle	#x			;No fakes?
	move	@PSTATUS,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	XORK	1,a1
	btst	a1,a0
	jrnz	#x			;Teammate is a human?
	movk	>1f,a0
	callr	rnd
	jrnz	#x
	subk	1,a2
	move	a2,*a13(plyr_d_seekcnt)
	jruc	#kilbuts


#injmp
	move	@PSTATUS,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	XORK	1,a1
	btst	a1,a0
	jrz	#tmdrn			;Teammate is a drone?

;FIX! give pass ability
	move	*a13(plyr_tmproc_p),a0,L
	move	*a0(PA11),a0,L
	move	*a0,a0			;Get teammates ctrl bits
	btst	BUT1_B,a0
	jrnz	#x			;Holding shoot button?
	jruc	#kilbuts
#tmdrn
	move	*a3(plyr_seqflgs),a0
	btst	BLOCKREB_B,a0
	jrnz	#kilbuts		;Got a rebound?

	movk	15,a0
	callr	rndrng0
	move	a0,a0
	jrz	#kilbuts		;Cause shoot?

	movk	7,a0
	callr	rnd
	jrnz	#x			;88%?

	move	*a13(plyr_ptsdown),a14
	addk	5,a14
	jrlt	#pss			;Winning by >5?
	move	*a13(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrnz	#x			;In a dunk?
	move	@game_time,a1,L
	cmpi	>200,a1
	jrlt	#x			;Less than 2 secs?

#pss	callr	drone_pass

	jruc	#x



#kilbuts
	clr	a0			;>Let go of shoot button
	move	a0,*a11


#x
;	move	*a11,a0
;	andi	BUT1_M|BUT1_M<<8,a0
;	jrz	#xx
;	LOCKUP
;#xx
	rets

#jbits_t
	.byte	0,JOYL_M,JOYR_M,0
	.byte	JOYD_M,JOYD_M|JOYL_M,JOYD_M|JOYR_M,0
	.byte	JOYU_M,JOYU_M|JOYL_M,JOYU_M|JOYR_M,0
	.byte	0,0,0,0

	.byte	0,JOYR_M,JOYL_M,0
	.byte	JOYU_M,JOYU_M|JOYR_M,JOYU_M|JOYL_M,0
	.byte	JOYD_M,JOYD_M|JOYR_M,JOYD_M|JOYL_M,0
	.byte	0,0,0,0


#*******************************
* Drone in offense with out ball

 SUBRP	drone_offwoball

	clr	a0
	move	a0,*a13(plyr_d_cflgs)

	move	*a13(plyr_dir),a3

	move	*a13(plyr_o1dist),a14
	subi	50,a14
	jrgt	#o1far				;Too far?
	move	*a13(plyr_o1dir),a2
	sub	a3,a2
	abs	a2
	cmpi	>40,a2
	jrle	#o1dsml
	subi	>80,a2
	abs	a2
#o1dsml	subk	16,a2
	jrlt	#pusho				;In front of me?
#o1far
	move	*a13(plyr_o2dist),a14
	subi	50,a14
	jrgt	#nopush				;Too far?
	move	*a13(plyr_o2dir),a2
	sub	a3,a2
	abs	a2
	cmpi	>40,a2
	jrle	#o2dsml
	subi	>80,a2
	abs	a2
#o2dsml	subk	16,a2
	jrge	#nopush				;!In front?
#pusho
	movk	>f,a0
	callr	rnd
	jrnz	#newseek			;94% skip push?

	move	*a11,a0				;Push
	ori	BUT2_M<<8|BUT2_M|BUT3_M,a0
	move	a0,*a11
	jruc	#x
#nopush


	movi	>7f,a0
	callr	rnd
	jrz	#newseek

	move	*a13(plyr_d_seekcnt),a0
	subk	1,a0
	jrgt	#seek

#newseek
	move	*a13(plyr_newdir),a0
	jrnn	#contsk				;Turning?

	movk	16,a0
	callr	rndrng0
	sll	5,a0				;*32
	addi	#seek_t,a0

	move	*a0+,a1
	move	*a13(plyr_num),a14
	subk	2,a14
	jrge	#lft
	neg	a1
#lft	addi	WRLDMID,a1
	move	a1,*a13(plyr_d_seekx)

	move	*a0+,a1
	move	a1,*a13(plyr_d_seeky)

	movi	TSEC*4,a0
	callr	rndrng0
	addi	TSEC,a0

#seek	move	a0,*a13(plyr_d_seekcnt)
#contsk
	move	*a13(plyr_d_seekx),a0
	move	*a13(plyr_d_seeky),a1
	callr	drone_seekxy
	jrnz	#notthere

	movk	>1f,a0				;3%
	callr	rnd
	jrnz	#x
	clr	a0
	move	a0,*a13(plyr_d_seekcnt)

#notthere


#x
	rets


	.asg	CZMID,Z
#seek_t
	.word	-320,Z-160, -250,Z-160, -120,Z-100	;3ptrs
	.word	-120,Z
	.word	-120,Z+100, -250,Z+160, -320,Z+160

	.word	-320,Z-100, -250,Z-80, -200,Z-50	;2ptrs
	.word	-180,Z
	.word	-200,Z+50, -250,Z+80, -320,Z+100

	.word	-310,Z-10, -305,Z, -310,Z+10


#*******************************
* Drone code - pass if clear
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process
* >A0=!0 if pass OK (CC)
* Trashes scratch

 SUBRP	drone_pass

	move	@PSTATUS,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	XORK	1,a1
	btst	a1,a0
	jrnz	#x			;Teammate is a human?

	move	*a13(plyr_tmdist),a0
	addk	10,a0
	move	*a13(plyr_o1dist),a1
	cmp	a1,a0
	jrlt	#o1ok

	move	*a13(plyr_tmdir),a14
	move	*a13(plyr_o1dir),a1
	sub	a14,a1
	abs	a1
	cmpi	64,a1
	jrle	#dsml
	subi	128,a1
	abs	a1
#dsml	subk	16,a1
	jrlt	#x

#o1ok
	move	*a13(plyr_o2dist),a1
	cmp	a1,a0
	jrlt	#o2ok

	move	*a13(plyr_tmdir),a14
	move	*a13(plyr_o2dir),a1
	sub	a14,a1
	abs	a1
	cmpi	64,a1
	jrle	#dsml2
	subi	128,a1
	abs	a1
#dsml2	subk	16,a1
	jrlt	#x

#o2ok
	move	*a13(plyr_tmproc_p),a1,L
	move	*a1(plyr_seq),a0
	subk	RUNDRIBTURB_SEQ,a0
	jrhi	#x

	move	*a11,a0			;>Pass
	ori	BUT2_M<<8|BUT2_M|BUT3_M,a0
	move	a0,*a11

	rets

#x	clr	a0
	rets


#*******************************
* Drone code - defence
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process

 SUBRP	drone_defence


	clr	a0
	move	a0,*a13(plyr_d_cflgs)

	move	@ballpnum,a5
	sll	5,a5
	addi	plyrproc_t,a5
	move	*a5,a5,L		;A5=*Proc of opponent with ball


	move	*a13(plyr_d_seekcnt),a0
	cmpi	TSEC,a0
	jrgt	#newseek		;Too large?
	subk	1,a0
	jrgt	#seek
#newseek
	move	*a13(plyr_num),a2
	XORK	2,a2
	move	a2,a4
	sll	5,a4			;*32
	addi	plyrproc_t,a4
	move	*a4,a4,L
	cmp	a5,a4
	jreq	#guard			;I'm on guy with ball?

	move	*a5(plyr_ohpdist),a0
	cmpi	300,a0
	jrgt	#guard			;Too far to worry about?

	move	*a5(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	#gbc			;He's dunking?

	move	*a13(plyr_tmproc_p),a3,L
	move	*a3(plyr_seq),a0
	subi	STAGGER_SEQ,a0
	jrls	#tmok
	subk	FLYBACKWB2_SEQ-STAGGER_SEQ,a0
	jrls	#gbc			;Teammates staggered?
#tmok
	move	*a3(plyr_o1dist),a0
	btst	0,a2
	jrz	#p1
	move	*a3(plyr_o2dist),a0
#p1	cmpi	100,a0
	jrgt	#gbc			;TM not guarding?
;FIX
	jruc	#guard

#gbc	move	a5,a4			;Guard ball carrier
#guard
	move	*a4(PA8),a2,L		;*Obj

	move	*a2(OXPOS),a0
	move	*a2(OXANI+16),a14
	add	a14,a0			;X
	move	*a2(OZPOS),a1		;Z

	move	@game_time,a14,L
	cmpi	>600,a14
	jrlt	#setseek		;Less than 6 secs?
	move	@shotimer+16,a14	;Tens
	jrnz	#scok
	move	@shotimer,a14		;Ones
	subk	5,a14
	jrlt	#setseek		;Less than 5 secs?
#scok
	move	*a2(OXVEL),a14,L
	sra	16-4,a14		;16 ticks from now
	add	a14,a0
	move	*a2(OZVEL),a14,L
	sra	16-4,a14		;16 ticks from now
	add	a14,a1

	move	*a13(plyr_myhoopx),a2	;>Stay near oplyr between my basket
	movi	CZMID,a3

	add	a0,a2
	sll	1,a0
	add	a2,a0
	sra	2,a0			;/4

	add	a1,a3
	sll	1,a1
	add	a3,a1
	sra	2,a1			;/4
#setseek
	move	a0,*a13(plyr_d_seekx)
	move	a1,*a13(plyr_d_seeky)

	movk	25,a0
	move	*a5(plyr_hpdist),a1
	cmpi	310,a1
	jrge	#seek			;Far from my hoop?

	move	*a13(plyr_ptsdown),a14

	movi	TSEC,a0
	cmpi	-7,a14
	jrle	#skrnd			;Kicking humans but?

	movk	25,a0
	addk	3,a14
	jrlt	#skrnd			;Winning?

	movk	4,a0
	subk	3+3,a14
	jrgt	#skrnd			;Losing?

	movk	14,a0
#skrnd	callr	rndrng0
	addk	1,a0

#seek	move	a0,*a13(plyr_d_seekcnt)

	move	*a13(plyr_d_seekx),a0
	move	*a13(plyr_d_seeky),a1
	callr	drone_seekxy
	move	a0,a2



	move	*a13(plyr_num),a14	;>Get opponents proc
	addk	2,a14
	sll	32-2,a14
	srl	32-2-5,a14		;*32
	addi	plyrproc_t,a14
	move	*a14,a0,L
	move	*a0(plyr_ohpdist),a0
	subk	10,a0
	cmpi	300,a0
	jrlt	#long
	subi	80,a0			;Turbo earlier
#long
	move	*a13(plyr_hpdist),a1
	cmp	a0,a1
	jrlt	#icloser
	addi	BUT3_M,a2		;Turbo
#icloser


	move	@HCOUNT,a0
	sll	32-5,a0
	jrnz	#skipsp			;97%?

	move	*a13(plyr_ptsdown),a14
	addk	5,a14
	jrge	#regstl			;Not winning by too much?
	movk	3,a0
	callr	rnd
	jrnz	#skipsp			;75%
#regstl
	move	*a13(plyr_balldist),a1
	cmpi	45,a1
	jrgt	#ballfar
	sll	32-4,a2
	srl	32-4,a2
	addk	BUT2_M,a2		;Steal
	movk	3,a0
	callr	rnd
	jrnz	#ballfar		;75% skip push?
	addi	BUT2_M<<8|BUT3_M,a2	;Push
#ballfar
#skipsp


	move	*a13(plyr_balldist),a14	;>Chk if I can block ball
	cmpi	65,a14
	jrge	#noblk

	move	*a5(plyr_jmpcnt),a0
	jrz	#noblk			;Plyr with ball is on gnd?

	movk	>f,a0			;6% block
	move	*a13(plyr_ptsdown),a14
	addk	3,a14
	jrlt	#blkrnd			;Winning?

	movk	1,a0			;50%
	subk	3+3,a14
	jrgt	#blkrnd			;Losing?

	movk	3,a0			;25%
#blkrnd	callr	rnd
	jrnz	#noblk

	ORK	BUT1_M,a2		;Block
#noblk
	move	a2,*a11

	rets



#*******************************
* Drone code - nobody has ball
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process

 SUBRP	drone_chaseball

	move	*a13(plyr_tmproc_p),a2,L
	move	*a2(plyr_rcvpass),a14
	jrgt	drone_offwoball		;Teammate rcving ball?


	clr	a0
	move	a0,*a13(plyr_d_cflgs)


	move	*a13(plyr_d_seekcnt),a0
	cmpi	30,a0
	jrgt	#newseek		;Too large?
	subk	1,a0
	jrgt	#seek
#newseek

	move	@ballobj_p,a5,L

	move	*a5(OXPOS),a0
	move	*a5(OXANI+16),a14
	add	a14,a0
	move	*a5(OXVEL),a14,L
	sra	16-3,a14		;8 ticks from now
	add	a14,a0
	move	a0,*a13(plyr_d_seekx)

	move	*a5(OZPOS),a1
	move	*a5(OZVEL),a14,L
	sra	16-3,a14		;8 ticks from now
	add	a14,a1
	move	a1,*a13(plyr_d_seeky)

	movk	12,a0
	callr	rndrng0
	addk	5,a0
#seek	move	a0,*a13(plyr_d_seekcnt)

	move	*a13(plyr_d_seekx),a0
	move	*a13(plyr_d_seeky),a1
	callr	drone_seekxy


	move	*a13(plyr_balldist),a2	;>Chk if I can jump at ball
	subk	30,a2
	jrge	#nojmp

	move	*a5(OYPOS),a0
	addk	25,a0
	move	*a8(OYPOS),a1
	cmp	a1,a0
	jrlt	#nojmp

	movk	7,a0
	callr	rnd
	jrnz	#nojmp			;87%?

	move	*a11,a0			;Jmp
	ORK	BUT1_M,a14
	move	a0,*a11
#nojmp

	rets



#*******************************
* Drone - push stick to move drone towards an XY location
* A0=X to seek
* A1=Y
* A8=*Obj
* A11=*Ctrl bits
* >A0=Joy bits set or 0 (Pass CC)
* Trashes scratch

 SUBRP	drone_seekxy

	move	a2,b0

	move	*a8(OXPOS),a2
	move	*a8(OXANI+16),a14
	add	a14,a2
	sub	a0,a2

	clr	a0

	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	#onx
	move	a14,a14
	jrlt	#nolft
	subk	4,a0			;Left

#nolft	addk	8,a0			;Rgt
#onx
	move	*a8(OZPOS),a2

	sub	a1,a2
	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	#onz
	move	a14,a14
	jrlt	#noup
	subk	1,a0			;Up

#noup	addk	2,a0			;Dn
#onz
	move	a0,*a11

	move	b0,a2
	move	a0,a0
	rets



#*******************************
* Create ground alignment dots for debugging (Process)

 SUBR	gnd_aligndots

	.ref	hoopl_t,hoopr_t

	movi	hoopl_t,a11		;>Setup left hoop dots
	jruc	#hlstrt
#hllp
	sll	16,a0
	move	*a11+,a1		;Y
	sll	16,a1
	move	*a11+,a3		;Z
	addi	300,a3
	movi	alignimg_t,a2
	movi	>800c|M_NOCOLL|M_3D|M_NOSCALE,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	movi	>101,a0
	move	a0,*a8(OCONST)
	movi	-300,a0
	move	a0,*a8(OMISC)		;Z offset
	addk	16,a11
#hlstrt	move	*a11+,a0		;X
	jrnz	#hllp			;!End?


	movi	hoopr_t,a11		;>Setup rgt hoop dots
	jruc	#hrstrt
#hrlp
	sll	16,a0
	move	*a11+,a1		;Y
	sll	16,a1
	move	*a11+,a3		;Z
	addi	300,a3
	movi	alignimg_t,a2
	movi	>800c|M_NOCOLL|M_3D|M_NOSCALE,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	movi	>101,a0
	move	a0,*a8(OCONST)
	movi	-300,a0
	move	a0,*a8(OMISC)		;Z offset
	addk	16,a11
#hrstrt	move	*a11+,a0		;X
	jrnz	#hrlp			;!End?


	movi	#init_t,a11		;>Setup gnd dot images
	jruc	#5
#lp
	addi	200,a0
	sll	16,a0
	clr	a1			;Y
	move	*a11+,a3		;Z
	movi	alignimg_t,a2
	movi	>800c|M_NOCOLL|M_3D|M_NOSCALE,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ
	movi	>101,a0
	move	a0,*a8(OCONST)
#5	move	*a11+,a0		;X
	cmpi	4000,a0
	jrne	#lp			;!End?

	move	*a8(OPAL),a9
	sll	8,a9
	addk	1,a9			;Color 1
	clr	a10
#plp
	move	a10,a0
	addi	#color_t,a0
	move	a9,a1
	movk	1,a2			;#Colors
	calla	pal_set
	SLEEPK	10
	addk	16,a10
	sll	32-6,a10		;0-3 color #
	srl	32-6,a10
	jruc	#plp


#z0	.equ	GZBASE
#z1	.equ	1000
#z2	.equ	1095
#z3	.equ	1190
#z4	.equ	1284
#z5	.equ	GZMAX

#init_t
;	.word	-350,#z0, 0,#z0, 350,#z0
;	.word	-350,#z1, 0,#z1, 350,#z1
;	.word	-350,#z2, 0,#z2, 350,#z2
;	.word	-350,#z3, 0,#z3, 350,#z3
;	.word	-350,#z4, 0,#z4, 350,#z4
;	.word	-350,#z5, 0,#z5, 350,#z5
	.word	4000

alignimg_t
	.word	1,1,0,0
	.long	0
	.word	>1000
	.long	#test_p

#test_p	.word	1, 0
#color_t
	COLORW	0,0,0, 0,16,0, 0,31,0, 0,16,0


********************************
	.if	DEBUG

********************************
* Start an alignment dot for a player
* A13=*Plyr proc
* Trashes scratch

 SUBRP	plyr_getgndaligndot

	PUSH	a2,a3,a4,a5,a6,a7,a8

	clr	a0			;X
	clr	a1			;Y
	movi	CZMIN,a3		;Z
	movi	alignimg_t,a2
	movi	>800c|M_NOCOLL|M_3D|M_NOSCALE,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ
	movi	>101,a0
	move	a0,*a8(OCONST)
	movi	-300,a0
	move	a0,*a8(OMISC)		;Z offset

	move	a8,*a13(plyr_aligndot_p),L

	PULL	a2,a3,a4,a5,a6,a7,a8
	rets


********************************
* Set alignment dot to players position
* A8=*Plyr obj
* A13=*Plyr proc
* Trashes scratch

 SUBRP	plyr_setgndaligndot

	PUSH	a2,a3,a4,a5,a6,a7

	callr	anipt_getsclxy
	move	*a8(OXVAL),a14,L
	add	a14,a0
	move	*a13(plyr_aligndot_p),a2,L
	move	a0,*a2(OXVAL),L

	move	*a8(OZPOS),a14
	addi	300,a14
	move	a14,*a2(OZPOS)

	PULL	a2,a3,a4,a5,a6,a7
	rets


	.endif


#*******************************
* Get dir for object to face an XZ
* A6=Dest X
* A7=Dest Z
* A8=*Source obj
* >A0=0-127
* Trashes A0-A2,A14

 SUBRP	seekdir_obxz128

	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	move	*a8(OZPOS),a1		;Get SZ

********************************
* Get dir for src XY to face an XY
* A0=Src X
* A1=Src Y
* A6=Dest X
* A7=Dest Y
* >A0=0-127
* Trashes A0-A2,A14

 SUBR	seekdir_xyxy128

	clr	a2			;Octant 0-1
	sub	a6,a0			;A0=SrcX-DestX
	jrgt	#100
	abs	a0
	sub	a7,a1			;A1=SrcY-DestY
	jrnn	#oct01
	movk	8,a2			;Oct 2-3
	abs	a1
	jruc	#160

#100	movk	16,a2			;Oct 4-5
	sub	a7,a1			;A1=SrcY-DestX
	abs	a1
	jrnn	#200
	movk	16+8,a2			;Oct 6-7
#160	SWAP	a0,a1

#200	sll	2,a2			;Oct*4
#oct01	clr	a14
	cmp	a1,a0			;>Cmp slope
	jrhs	#300

	srl	2+2,a1			;Bigger/16
	jrnz	#250
	jruc	#x
#lp1	addk	1,a2			;Next 1/16 oct
	add	a1,a14			;+1/16
#250	cmp	a0,a14
	jrlo	#lp1
	jruc	#x

#300	addk	31,a2			;End of next octant
	srl	2+2,a0			;Bigger/16
	jrnz	#350
	jruc	#x
#lp2	subk	1,a2			;Next 1/16 oct
	add	a0,a14			;+1/16
#350	cmp	a1,a14
	jrlo	#lp2


#x	movi	>7f,a0
	and	a2,a0
	rets




#*******************************
* Get dir and distance from object to object
* A0=*Dest obj
* A8=*Source obj
* >A0=0-127
* >A1=Distance
* Trashes scratch, A2,A6,A7

 SUBRP	seekdirdist_obob128

	move	*a0(OXPOS),a6		;Get SX
	move	*a0(OXANI+16),a14
	add	a14,a6
	move	*a0(OZPOS),a7		;Get SZ

#*******************************
* Get dir and distance from object to XZ
* A6=Dest X
* A7=Dest Z
* A8=*Source obj
* >A0=0-127
* >A1=Distance
* Trashes scratch, A2

 SUBR	seekdirdist_obxz128

	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	move	*a8(OZPOS),a1		;Get SZ


	clr	a2			;Octant 0-1
	sub	a6,a0			;A0=SrcX-DestX
	jrgt	#100
	abs	a0
	sub	a7,a1			;A1=SrcY-DestY
	jrnn	#oct01
	movk	8,a2			;Oct 2-3
	abs	a1
	jruc	#160

#100	movk	16,a2			;Oct 4-5
	sub	a7,a1			;A1=SrcY-DestX
	abs	a1
	jrnn	#200
	movk	16+8,a2			;Oct 6-7
#160	SWAP	a0,a1

#200	sll	2,a2			;Oct*4
#oct01	clr	a14
	cmp	a1,a0			;>Cmp slope
	jrhs	#300

	move	a0,b0			;Save distance
	move	a1,b1

	srl	2+2,a1			;Bigger/16
	jrnz	#250
	jruc	#x
#lp1	addk	1,a2			;Next 1/16 oct
	add	a1,a14			;+1/16
#250	cmp	a0,a14
	jrlo	#lp1
	jruc	#x

#300	move	a0,b1			;Save distance
	move	a1,b0

	addk	31,a2			;End of next octant
	srl	2+2,a0			;Bigger/16
	jrnz	#350
	jruc	#x
#lp2	subk	1,a2			;Next 1/16 oct
	add	a0,a14			;+1/16
#350	cmp	a1,a14
	jrlo	#lp2

#x					;>Calc distance (long+short/2.667)
	srl	1,b0			;Shorter/2
	add	b0,b1
	srl	2,b0			;Shorter/8
	sub	b0,b1
	move	b1,a1

	movi	>7f,a0
	and	a2,a0
	rets



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


********************************
* Quickly produce a random # in range 0-X
* A0=X
* >A0=Random # (0 to A0) (No CC)
* Trashes scratch

 SUBRP	rndrng0

	move	@RAND,a1,L
	rl	a1,a1
	move	@HCOUNT,a14
	rl	a14,a1
	add	sp,a1
	move	a1,@RAND,L

	addk	1,a0
	mpyu	a1,a0		;Condition codes not valid!

	rets




	.end
