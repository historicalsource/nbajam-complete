****************************************************************
*
* Software:	Jamie Rivett
* Initiated:	?
*
* Modified:	?
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 1/15/93 15:29
****************************************************************
	.file	"select2.asm"
	.title	"name & team selection"
	.width	132
	.option	b,d,l,t
	.mnolist

	.include	"mproc.equ"
	.include	"disp.equ"
	.include	"sys.equ"
	.include	"gsp.equ"
	.include	"mac2.asm"

	.include	"imgtblm.glo"
	.include	"mugshot.tbl"

	.include	"imgtbl.glo"
	.include	"imgtblp.glo"
	.include	"imgtbl2.glo"
	.include	"bgndtbl.glo"
	.include	"game.equ"
	.include	"audit.equ"
	.include	"shawn.hdr"

	.include	"imgpalm.asm"
	.include	"imgtblm.glo"

;sounds

tunegc_snd	.word	>f3fe,1,>800c,0		;Grand champion play tune

;symbols defined in this file


************************************************************************

	.ref	HALT
	.ref	snd_play1

	.ref	TWOPLAYERS			;0 = NO, 1 = YES 2 players
	.ref	concat_string
	.ref	copy_rom_string
	.ref	mess_cursy,mess_objid
	.ref	mess_line_spacing
	.ref	CYCLE_TABLE,COLTAB2
	.ref	pal_getf
	.ref	get_initials_string
	.ref	dropout_stats
	.ref	conttimers
	.ref	PSTATUS2
	.ref	GET_ADJ
	.ref	game_purchased
	.ref	blue_shadow
	.ref	GAMSTATE
	.ref	monitor_fullgame
	.ref	message_buffer
	.ref	pleasewt
	.ref	game_over
	.ref	credits
	.ref	KILBGND
	.ref	print_string_C2
	.ref	cntrs_delay
	.ref	can_enter_inits
	.ref	page_scrolling
	.ref	winningteam
	.ref	newptr
	.ref	CR_CONTP
	.ref	team_control
	.ref	challenger
	.ref	plyrsdropped
	.ref	P1DATA
	.ref	pal_clean
	.ref	qtr_purchased
	.ref	credit_messages
	.ref	newplyrs
	.ref	monitor_buyins
	.ref	COLRTEMP
	.ref	gmqrtr


*************************************************************************

	.ref	fade_up,fade_down

	.ref	calc_num_defeated
	.ref	RNDRNG0
	.ref	team2
	.ref	team1

	.ref	BAKMODS
	.ref	switches_cur
	.ref	inmatchup
	.ref	player1_data
	.ref	dec_to_asc
	.ref	cntdown_snd
	.ref	pal_set
	.ref	player2_data
	.ref	get_teams_pop
	.ref	create_logos
	.ref	call_matchup
	.ref	pal_find
	.ref	special_heads
	.ref	player3_data
	.ref	create_player_heads
	.ref	update_player_heads
	.ref	dpageflip
	.ref	IRQSKYE
	.ref	PSTATUS
	.ref	player4_data
	.ref	switches_down
	.ref	print_string_C
	.ref	BGND_UD1
	.ref	obj_on
	.ref	force_selection
	.ref	obj_off
	.ref	print_ranking
	.ref	scores
	.ref	WIPEOUT
	.ref	mess_cursx
	.ref	update_logos
	.ref	setup_message
	.ref	osgemd_ascii
	.ref	copy_string
	.ref	speech_playovrp

	.ref	_DAL	;27
	.ref	_MIN	;26
	.ref	_MI	;22
	.ref	_WAS	;21
	.ref	_PHI	;25
	.ref	_SAC	;24
	.ref	_MIL	;18
	.ref	_DEN	;23
	.ref	_GOL	;20
	.ref	_SAN	;19
	.ref	_SEA	;17
	.ref	_ATL	;16
	.ref	_ORL	;15
	.ref	_LAC	;14
	.ref	_NJ	;13
	.ref	_CHA	;12
	.ref	_BOS	;11
	.ref	_CLE	;10
	.ref	_DET	;9
	.ref	_HOU	;8
	.ref	_IND	;7
	.ref	_LAL	;6
	.ref	_UTA	;5
	.ref	_NY	;4
	.ref	_POR	;3
	.ref	_PHX	;2
	.ref	_CHI	;1
************************************************************************


	.text



congrats_snd	.word	>f3ff,>8,>8004,0	;



********************************
#*

MAX_CRTIME	equ	>7fff		;30*60
NAMENT_PAGE	equ	1*256

	.asg	>82,x1
	.asg	>103,x1a
	.asg	>ad,x1b
	.asg	>12f5+2,y1
	.asg	>131f,y1a


	.def	ladder_imgs0
	.def	ladder_imgs1,ladder_imgs2,ladder_imgs3,ladder_imgs4
	.def	ladder_imgs5,ladder_imgs6

ladder_imgs0
	.long	HPR_DAL,x1,y1
	.long	IUZ_DAL,x1a,y1
	.long	T_MAVS,x1b,y1a

	.long	LTN_MIN,x1,y1->b3
	.long	PRS_MIN,x1a,y1->b3
	.long	T_TWOLV,x1b,y1a->b3

	.long	0

ladder_imgs1

	.long	RCE_MIA,x1,y1->b3*2-2
	.long	SKL_MIA,x1a,y1->b3*2-2
	.long	T_HEAT,x1b,y1a->b3*2-2

	.long	GUG_WAS,x1,y1->b3*3-2
	.long	GRT_WAS,x1a,y1->b3*3-2
	.long	T_BULTS,x1b,y1a->b3*3-2

	.long	HWK_PHL,x1,y1->b3*4-4
	.long	HRN_PHL,x1a,y1->b3*4-4
	.long	T_76RS,x1b,y1a->b3*4-4

	.long	TIS_SAC,x1,y1->b3*5-4
	.long	WEB_SAC,x1a,y1->b3*5-4
	.long	T_KINGS,x1b,y1a->b3*5-4

	.long	0

ladder_imgs2

	.long	MUT_DEN,x1,y1->b3*6-6
	.long	ELL_DEN,x1a,y1->b3*6-6
	.long	T_NUGS,x1b,y1a->b3*6-6

	.long	LOH_MLW,x1,y1->b3*7-6
	.long	EDW_MLW,x1a,y1->b3*7-6
	.long	T_BUCKS,x1b,y1a->b3*7-6

	.long	MIL_IND,x1,y1->b3*8-8
	.long	SCH_IND,x1a,y1->b3*8-8
	.long	T_PACER,x1b,y1a->b3*8-8

	.long	WLK_ATL,x1,y1->b3*9-8
	.long	AUG_ATL,x1a,y1->b3*9-8
	.long	T_HAWKS,x1b,y1a->b3*9-8

	.long	0

ladder_imgs3

	.long	MAN_CLP,x1,y1->b3*10-10
	.long	HRP_CLP,x1a,y1->b3*10-10
	.long	T_CLIPS,x1b,y1a->b3*10-10

	.long	ONE_ORL,x1,y1->b3*11-10
	.long	SKL_ORL,x1a,y1->b3*11-10
	.long	T_MAGIC,x1b,y1a->b3*11-10

	.long	THM_DET,x1,y1->b3*12-12
	.long	LAM_DET,x1a,y1->b3*12-12
	.long	T_PISS,x1b,y1a->b3*12-12

	.long	HRD_GLD,x1,y1->b3*13-12
	.long	MUL_GLD,x1a,y1->b3*13-12
	.long	T_WARS,x1b,y1a->b3*13-12

	.long	0

ladder_imgs4

	.long	LEW_BOS,x1,y1->b3*14-14
	.long	MCH_BOS,x1a,y1->b3*14-14
	.long	T_CELTS,x1b,y1a->b3*14-14

	.long	OLA_HOU,x1,y1->b3*15-14
	.long	SMT_HOU,x1a,y1->b3*15-14
	.long	T_ROCKS,x1b,y1a->b3*15-14

	.long	JON_CHA,x1,y1->b3*16-16
	.long	GIL_CHA,x1a,y1->b3*16-16
	.long	T_HORS,x1b,y1a->b3*16-16

	.long	WOR_LAK,x1,y1->b3*17-16
	.long	DIV_LAK,x1a,y1->b3*17-16
	.long	T_LAKS,x1b,y1a->b3*17-16

	.long	0

ladder_imgs5

	.long	COL_NEJ,x1,y1->b3*18-18
	.long	PET_NEJ,x1a,y1->b3*18-18
	.long	T_NETS,x1b,y1a->b3*18-18

	.long	PRC_CLE,x1,y1->b3*19-18
	.long	DAU_CLE,x1a,y1->b3*19-18
	.long	T_CAVS,x1b,y1a->b3*19-18

	.long	ROB_SAN,x1,y1->b3*20-20
	.long	ELL_SAN,x1a,y1->b3*20-20
	.long	T_SPURS,x1b,y1a->b3*20-20

	.long	EWG_NEY,x1,y1->b3*21-20
	.long	OAK_NEY,x1a,y1->b3*21-20
	.long	T_KNIKS,x1b,y1a->b3*21-20
	
	.long	0

ladder_imgs6

	.long	DRX_PRT,x1,y1->b3*22-22
	.long	POR_PRT,x1a,y1->b3*22-22
	.long	T_BLAZ,x1b,y1a->b3*22-22

	.long	MLN_UTA,x1,y1->b3*23-22
	.long	STK_UTA,x1a,y1->b3*23-22
	.long	T_JAZZ,x1b,y1a->b3*23-22

	.long	KMP_SEA,x1,y1->b3*24-24
	.long	BEN_SEA,x1a,y1->b3*24-24
	.long	T_SONICS,x1b,y1a->b3*24-24

	.long	BRK_PHX,x1,y1->b3*25-24
	.long	MAJ_PHX,x1a,y1->b3*25-24
	.long	T_SUNS,x1b,y1a->b3*25-24

	.long	0


#*****************************************************************************
* a8  = sleep time
* a9  = palette to change
* a10 = * palette list
* a11 = * morf pal ram


START_PAL	equ	PDATA
CUR_PAL		equ	PDATA+20h
PAL_ADDR	equ	PDATA+40h
MORF_PAL	equ	PDATA+60h
SLEEP_TIME	equ	PDATA+80h

 SUBR	morf_pal


	move	a8,*a13(SLEEP_TIME)
	move	a10,*a13(START_PAL),L
	move	a10,*a13(CUR_PAL),L
	move	a11,*a13(MORF_PAL),L

#wait
	SLEEPK	1

	move	a9,a0
	calla	pal_find
	jrz	#wait
	srl	8,a0
	sll	8,a0
	move	a0,*a13(PAL_ADDR),L

	move	*a13(MORF_PAL),a1,L
	move	*a10,a2,L
	move	*a2+,a3		;num colours
#loop
	move	*a2+,*a1+
	dsj	a3,#loop

;	SLEEP	4
	move	*a13(SLEEP_TIME),a10
#dly1
	SLEEPK	1
	dsj	a10,#dly1
#next_pal

	move	*a13(CUR_PAL),a10,L
	addi	20h,a10
	move	*a10,a0,L
	jrn	#ok
	jrz	#not_sleep

	move	a10,*a13(CUR_PAL),L
	move	a0,a10
	jruc	#dly1

#not_sleep
	move	*a13(START_PAL),a10,L
#ok
	move	a10,*a13(CUR_PAL),L

#again
;	SLEEP	2
	move	*a13(SLEEP_TIME),a10
	srl	1,a10
	jrnz	#dly2
	movk	1,a10
#dly2
	SLEEPK	1
	dsj	a10,#dly2


	move	*a13(MORF_PAL),a1,L
	move	*a13(CUR_PAL),a10,L
	move	*a10,a2,L
	move	*a2+,a0			;num colours
	clr	a11
#morfit
	move	*a1,a3			;CURRENT PALETTE
	movi	0111110000000000b,a4	;5 bits of red
	and	a3,a4
	movi	0000001111100000b,a5	;5 bits of green
	and	a3,a5
	movi	0000000000011111b,a6	;5 bits of blue
	and	a3,a6

	move	*a2+,a7			;DEST PALETTE
	movi	0111110000000000b,a8	;5 bits of red
	and	a7,a8
	movi	0000001111100000b,a9	;5 bits of green
	and	a7,a9
	movi	0000000000011111b,a10	;5 bits of blue
	and	a7,a10

	srl	10,a4
	srl	10,a8
	cmp	a4,a8			;a8-a4
	jreq	#redok
	jrlt	#decr
	inc	a11
	inc	a4
	jruc	#redok
#decr
	inc	a11
	dec	a4
#redok
	sll	10,a4

	srl	5,a5
	srl	5,a9
	cmp	a5,a9
	jreq	#greenok
	jrlt	#decg
	inc	a11
	inc	a5
	jruc	#greenok
#decg
	inc	a11
	dec	a5
#greenok
	sll	5,a5

	cmp	a6,a10
	jreq	#blueok
	jrlt	#decb
	inc	a11
	inc	a6
	jruc	#blueok
#decb
	inc	a11
	dec	a6
#blueok

	or	a5,a4
	or	a6,a4
	move	a4,*a1+

	dsj	a0,#morfit

	move	*a13(CUR_PAL),a0,L	;* palette list
	move	*a0,a0,L		;* palette
	move	*a0,a2			;num colours
	move	*a13(MORF_PAL),a0,L	;* palette
	move	*a13(PAL_ADDR),a1,L	;dest palette
	calla	pal_set

	move	a11,a11
	jrnz	#again

	jruc	#next_pal

	DIE


;	movi	GREENPAL,a0	;* palette
;	move	*a0+,a2		;num colours
;	move	a10,a1		;dest palette
;	calla	pal_set

#*****************************************************************************
*
* RETURN:	a0 = start button bits
*-----------------------------------------------------------------------------

 SUBR	get_all_starts_down

	clr	a1

	move	@PSTATUS,a2

	btst	0,a2
	jrz	#no_player1
	clr	a0			;player 1
	calla	get_start_down
	or	a0,a1
#no_player1

	btst	1,a2
	jrz	#no_player2
	movk	1,a0			;player 2
	calla	get_start_down
	or	a0,a1
#no_player2

	btst	2,a2
	jrz	#no_player3
	movk	2,a0			;player 3
	calla	get_start_down
	or	a0,a1
#no_player3

	btst	3,a2
	jrz	#no_player4
	movk	3,a0			;player 4
	calla	get_start_down
	or	a0,a1
#no_player4

	move	a1,a0
	rets

#*****************************************************************************
*
* RETURN:	a0 = start bit
*-----------------------------------------------------------------------------

 SUBR	get_start_down

	sll	4,a0			;x 16 bits
	addi	start_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	1,a0
	rets


	.if	TUNIT
start_offs	.word	12h,15h,19h,1ah
	.else
start_offs	.word	12h,15h,17h,27h
	.endif

#*****************************************************************************

 SUBR	get_team1_turbo

	clr	a1

	move	@PSTATUS,a2

	btst	0,a2
	jrz	#no_player1
	clr	a0			;player 1
	calla	get_turbo_down
	or	a0,a1
#no_player1

	btst	1,a2
	jrz	#no_player2
	movk	1,a0			;player 2
	calla	get_turbo_down
	or	a0,a1
#no_player2
	move	a1,a0

	rets

#*****************************************************************************

 SUBR	get_team2_turbo

	clr	a1

	move	@PSTATUS,a2

	btst	2,a2
	jrz	#no_player1
	movk	2,a0			;player 3
	calla	get_turbo_down
	or	a0,a1
#no_player1

	btst	3,a2
	jrz	#no_player2
	movk	3,a0			;player 4
	calla	get_turbo_down
	or	a0,a1
#no_player2
	move	a1,a0

	rets

#*****************************************************************************
*
* RETURN:	a0 = start bit
*-----------------------------------------------------------------------------

 SUBR	get_turbo_down

	sll	4,a0			;x 16 bits
	addi	turbo_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	1,a0
	rets


	.if	TUNIT
turbo_offs	.word	06h,0eh,26h,2eh
	.else
turbo_offs	.word	12h,15h,17h,27h
	.endif

#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_all_sticks_cur

	clr	a1

	move	@PSTATUS,a2

	btst	0,a2
	jrz	#no_player1
	clr	a0			;player 1
	calla	get_stick_val_cur
	or	a0,a1
#no_player1

	btst	1,a2
	jrz	#no_player2
	movk	1,a0			;player 2
	calla	get_stick_val_cur
	or	a0,a1
#no_player2

	btst	2,a2
	jrz	#no_player3
	movk	2,a0			;player 3
	calla	get_stick_val_cur
	or	a0,a1
#no_player3

	btst	3,a2
	jrz	#no_player4
	movk	3,a0			;player 4
	calla	get_stick_val_cur
	or	a0,a1
#no_player4

	move	a1,a0
	rets


#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_all_sticks_cur2

	clr	a1

	clr	a0			;player 1
	calla	get_stick_val_cur
	or	a0,a1

	movk	1,a0			;player 2
	calla	get_stick_val_cur
	or	a0,a1

	movk	2,a0			;player 3
	calla	get_stick_val_cur
	or	a0,a1

	movk	3,a0			;player 4
	calla	get_stick_val_cur
	or	a0,a1

	move	a1,a0
	rets


#*****************************************************************************
*
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_stick_val_cur


	sll	4,a0			;x 16 bits
	addi	joy_offs,a0
	move	*a0,a0
	addi	switches_cur,a0
	move	*a0,a0
	andi	01111b,a0
	rets


#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_all_sticks_down

	clr	a1

	move	@PSTATUS,a2

	btst	0,a2
	jrz	#no_player1
	clr	a0			;player 1
	calla	get_stick_val_down
	or	a0,a1
#no_player1

	btst	1,a2
	jrz	#no_player2
	movk	1,a0			;player 2
	calla	get_stick_val_down
	or	a0,a1
#no_player2

	btst	2,a2
	jrz	#no_player3
	movk	2,a0			;player 3
	calla	get_stick_val_down
	or	a0,a1
#no_player3

	btst	3,a2
	jrz	#no_player4
	movk	3,a0			;player 4
	calla	get_stick_val_down
	or	a0,a1
#no_player4

	move	a1,a0
	rets


#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_all_sticks_down2

	clr	a1

	clr	a0			;player 1
	calla	get_stick_val_down
	or	a0,a1

	movk	1,a0
	calla	get_stick_val_down
	or	a0,a1

	movk	2,a0
	calla	get_stick_val_down
	or	a0,a1

	movk	3,a0
	calla	get_stick_val_down
	or	a0,a1
	move	a1,a0

	rets


******************************************************************************
*
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_stick_val_down

	sll	4,a0			;x 16 bits
	addi	joy_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	01111b,a0
	rets

	.if	TUNIT
joy_offs	.word	00h,08h,20h,28h
	.else
joy_offs	.word	00h,08h,18h,20h
	.endif

#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_all_buttons_cur

	clr	a1

	move	@PSTATUS,a2

	btst	0,a2
	jrz	#no_player1
	clr	a0			;player 1
	calla	get_but_val_cur
	or	a0,a1
#no_player1

	btst	1,a2
	jrz	#no_player2
	movk	1,a0			;player 2
	calla	get_but_val_cur
	or	a0,a1
#no_player2

	btst	2,a2
	jrz	#no_player3
	movk	2,a0			;player 3
	calla	get_but_val_cur
	or	a0,a1
#no_player3

	btst	3,a2
	jrz	#no_player4
	movk	3,a0			;player 4
	calla	get_but_val_cur
	or	a0,a1
#no_player4

	move	a1,a0
	rets


#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

  SUBR	get_all_buttons_cur2

	clr	a1
	clr	a0			;player 1
	calla	get_but_val_cur
	or	a0,a1
	movk	1,a0			;player 2
	calla	get_but_val_cur
	or	a0,a1
	movk	2,a0			;player 3
	calla	get_but_val_cur
	or	a0,a1
	movk	3,a0			;player 4
	calla	get_but_val_cur
	or	a0,a1
	move	a1,a0
	rets


#*****************************************************************************
*
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
*
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------

 SUBR	get_but_val_cur

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_cur,a0
	move	*a0,a0
	andi	0111b,a0
	rets

#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

 SUBR	get_all_buttons_down

	clr	a1

	move	@PSTATUS,a2

	btst	0,a2
	jrz	#no_player1
	clr	a0			;player 1
	calla	get_but_val_down
	or	a0,a1
#no_player1

	btst	1,a2
	jrz	#no_player2
	movk	1,a0			;player 2
	calla	get_but_val_down
	or	a0,a1
#no_player2

	btst	2,a2
	jrz	#no_player3
	movk	2,a0			;player 3
	calla	get_but_val_down
	or	a0,a1
#no_player3

	btst	3,a2
	jrz	#no_player4
	movk	3,a0			;player 4
	calla	get_but_val_down
	or	a0,a1
#no_player4

	move	a1,a0
	rets


#*****************************************************************************
*
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------

 SUBR	get_all_buttons_down2

	clr	a1
	clr	a0			;player 1
	calla	get_but_val_down
	or	a0,a1
	movk	1,a0			;player 2
	calla	get_but_val_down
	or	a0,a1
	movk	2,a0			;player 3
	calla	get_but_val_down
	or	a0,a1
	movk	3,a0			;player 4
	calla	get_but_val_down
	or	a0,a1
	move	a1,a0
	rets


******************************************************************************
*
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
*
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------

 SUBR	get_but_val_down

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	0111b,a0
	rets

	.if	TUNIT
but_offs	.word	04h,0ch,24h,2ch
	.else
but_offs	.word	04h,0ch,1ch,24h
	.endif

******************************************************************************
*
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
*
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------

 SUBR	get_but_val_down_nt		;masks out turbo button

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	011b,a0
	rets

#*****************************************************************************

	.asg	89,X1
	.asg	307,X2
	.asg	207,Y

 SUBR	result_screen

	calla	display_blank
	calla	WIPEOUT			;CLEAN SYSTEM OUT

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	movi	4<<10+4<<5+7,a0
	move	a0,@IRQSKYE

	SLEEPK	1

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	clr	a0
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L

	SLEEPK	2

	movi	result_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1

	clr	a10
	movk	16,a11
	CREATE0	fade_up

	movk	1,a0
	calla	create_player_heads
	calla	update_player_heads
	movk	1,a0
	calla	create_logos
	calla	update_logos

	CREATE0	score_shadow

	movi	#score_setup,a2
	calla	setup_message
	move	@scores,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	calla	print_string_C

	move	@scores+10h,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	X2,a0
	move	a0,@mess_cursx
	calla	print_string_C


	movk	1,a0
	move	a0,@DISPLAYON

	SLEEPK	2
	calla	display_unblank

	SLEEP	1*TSEC

	movi	4*TSEC,a10
#lp	SLEEPK	1
	calla	get_all_buttons_cur2
	jrz	#nob
      	clr	a0
	move	a0,@SOUNDSUP		;turn all sounds on
	.ref	SOUNDSUP
	SOUND1	bounce_snd
	movk	1,a0
	move	a0,@SOUNDSUP		;turn all sounds off
	jruc	#xb
#nob	
	dsj	a10,#lp
#xb

	clr	a10
	movk	16,a11
	CREATE0	fade_down

	SLEEP	18h

	RETP

bounce_snd	.word	>fc80,10,>8129,0	;Ball bounce
#score_setup
	RJR_STR	osgemd_ascii,8,0,X1,Y,WHITEPAL,0


#*****************************************************************************

 SUBRP	score_shadow

#SHAD1	equ	PDATA
#SHAD2	equ	#SHAD1+20h

	.asg	40,X1
	.asg	257,X2
	.asg	205,Y

	movi	[X1,0],a0		;x val
	movi	[Y,0],a1		;y val
	movi	scorshad1,a2		;* image
	movi	300,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	calla	BEGINOBJ
	move	a8,*a13(#SHAD1),L

	movi	[X2,0],a0		;x val
	movi	[Y,0],a1		;y val
	movi	scorshad1,a2		;* image
	movi	300,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	calla	BEGINOBJ
	move	a8,*a13(#SHAD2),L

	clr	a10
#big_mac
	SLEEPK	1
	xori	1,a10

	move	a10,a0
	sll	5,a0			;x 32 bits
	addi	#shadows,a0
	move	*a0,a11,L		;* image

	move	*a13(#SHAD1),a8,L
	calla	#change_shad
	move	*a13(#SHAD2),a8,L
	calla	#change_shad

	jruc	#big_mac

#change_shad
	move	a11,a0
	move	*a8(OCTRL),a1		;DMA flags
	calla	obj_aniq		;change object image
	rets


#shadows
	.long	scorshad1,scorshad2

#*****************************************************************************

 SUBR	matchup_screen

	movk	1,a0
	move	a0,@inmatchup

	calla	display_blank
	calla	WIPEOUT			;CLEAN SYSTEM OUT

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	movi	4<<10+4<<5+7,a0
	move	a0,@IRQSKYE

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	clr	a0
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L

	SLEEPK	2

	movi	matchup_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1

	movk	1,a0
	calla	create_player_heads
	calla	update_player_heads
	movk	1,a0
	calla	create_logos
	calla	update_logos

	calla	get_teams_pop
	calla	print_ranking

	movk	1,a0
	move	a0,@DISPLAYON

	SLEEPK	2
	calla	display_unblank

	CREATE0	call_matchup
	.ref	flash_plyr_wht
	CREATE0	flash_plyr_wht

	SLEEP	TSEC*3

	movi	3*TSEC,a10
#delay
	SLEEPK	1
	calla	get_all_buttons_cur
	jrnz	#exit
	dsj	a10,#delay
#exit

	RETP

matchup_mod
	.long	matchupBMOD		;matchup screen
	.word	0,0
	.long	0

result_mod
	.long	finalBMOD		;final result screen
	.word	0,0
	.long	0


#******************************************************************************
; a10 = sleep count

	.asg	200-2,X
	.asg	80,Y

#restart
	calla	DELOBJA8

 SUBR	timeout

	clr	a0
	move	a0,@force_selection

	move	a10,a11
#wait
	SLEEPK	1
	dsj	a11,#wait

	movi	LGMDRED2,b0
	movi	[X,0],a0			;x val
	movi	[Y,0],a1			;y val
	movi	lgmd_9,a2			;* image
	movi	30001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJP2
	calla	#center_image

	move	@PSTATUS,a9

	movi	9,a11
#loop
	SOUND1	cntdown_snd

	SLEEP	TSEC+25

	move	@PSTATUS,a0		;if player buys in
	cmp	a9,a0			;then restart timer
	jrne	#restart

	calla	obj_off

	SOUND1	cntdown_snd

	SLEEP	(1*TSEC)/2

	move	@PSTATUS,a0
	cmp	a9,a0
	jrne	#restart

	calla	obj_on
	move	a11,a0
	sll	5,a0
	addi	#nums-20h,a0
	move	*a0,a0,L		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	#center_image

	dsj	a11,#loop

	SOUND1	cntdown_snd

	SLEEP	(1*TSEC+25)/2

	movk	1,a0
	move	a0,@force_selection

	calla	DELOBJA8
	DIE


#center_image
	move	*a8(OSIZEX),a0
	srl	1,a0
	movi	X,a1
	sub	a0,a1
	move	a1,*a8(OXPOS)
	rets


#nums	.long	lgmd_0,lgmd_1,lgmd_2
	.long	lgmd_3,lgmd_4,lgmd_5
	.long	lgmd_6,lgmd_7,lgmd_8,lgmd_9

#******************************************************************************
; a10 = sleep count

	.asg	200-2,X
	.asg	80,Y

#restart
	PULLP	a0
	calla	DELOBJA8

 SUBR	timeout2

	clr	a0
	move	a0,@force_selection

	move	a10,a11
#wait
	SLEEPK	1
	dsj	a11,#wait

	movi	LGMDRED2,b0
	movi	[X,0],a0			;x val
	movi	[Y,0],a1			;y val
	movi	lgmd_9,a2			;* image
	movi	30001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJP2
	calla	#center_image

	move	@PSTATUS,a9

	movi	9,a0
#loop
	PUSHP	a0

	SOUND1	cntdown_snd

	movi	TSEC+25,a11
#loop2
	SLEEPK	1
	calla	get_all_starts_down
	jrnz	#xit1
	dsj	a11,#loop2
#xit1

	SOUND1	cntdown_snd

	move	@PSTATUS,a0		;if player buys in
	cmp	a9,a0			;then restart timer
	jrne	#restart

	calla	obj_off

	movi	(1*TSEC)/2,a11
#loop3
	SLEEPK	1
	calla	get_all_starts_down
	jrnz	#xit2
	dsj	a11,#loop3
#xit2

	move	@PSTATUS,a0
	cmp	a9,a0
	jrne	#restart

	calla	obj_on
	PULLP	a0
	PUSHP	a0
	sll	5,a0
	addi	#nums-20h,a0
	move	*a0,a0,L		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	#center_image

	PULLP	a0
	dsj	a0,#loop

	SOUND1	cntdown_snd

	movi	(1*TSEC+25)/2,a11
#loop4
	SLEEPK	1
	calla	get_all_starts_down
	jrnz	#xit3
	dsj	a11,#loop4
#xit3
	SOUND1	cntdown_snd

	movk	1,a0
	move	a0,@force_selection

	calla	DELOBJA8
	DIE


#center_image
	move	*a8(OSIZEX),a0
	srl	1,a0
	movi	X,a1
	sub	a0,a1
	move	a1,*a8(OXPOS)
	rets


#nums	.long	lgmd_0,lgmd_1,lgmd_2
	.long	lgmd_3,lgmd_4,lgmd_5
	.long	lgmd_6,lgmd_7,lgmd_8,lgmd_9

#******************************************************************************
; a10 = sleep count

	.asg	200-2,X
	.asg	80,Y

 SUBR	timeout3

	clr	a0
	move	a0,@force_selection

	.ref	BTIME
	move	a0,@BTIME

;	move	a10,a11
;#wait
;	SLEEPK	1
;
;	move	@BTIME,a0
;	jrnz	#reset
;
;	dsj	a11,#wait

	movi	LGMDRED2,b0
	movi	[X,0],a0			;x val
	movi	[Y,0],a1			;y val
	movi	lgmd_9,a2			;* image
	movi	30001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJP2
	calla	#center_image

	move	@PSTATUS,a9

	movi	9,a0
#loop
	PUSHP	a0

	SOUND1	cntdown_snd

	SLEEPK	3
	movi	TSEC+25-3,a11
#loop2
	SLEEPK	1

	move	@BTIME,a0
	jrnz	#reset

;	calla	get_all_buttons_down2
	calla	get_all_buttons_cur2
	jrnz	#xit1
	dsj	a11,#loop2
#xit1

	SOUND1	cntdown_snd

	calla	obj_off

	SLEEPK	2
	movi	(1*TSEC)/2-3,a11
#loop3
	SLEEPK	1

	move	@BTIME,a0
	jrnz	#reset

;	calla	get_all_buttons_down2
	calla	get_all_buttons_cur2
	jrnz	#xit2
	dsj	a11,#loop3
#xit2

	calla	obj_on
	PULLP	a0
	PUSHP	a0
	sll	5,a0
	addi	#nums-20h,a0
	move	*a0,a0,L		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	#center_image

	PULLP	a0
	dsj	a0,#loop

	SOUND1	cntdown_snd

	SLEEPK	3
	movi	(1*TSEC+25)/2-3,a11
#loop4
	SLEEPK	1

	move	@BTIME,a0
	jrnz	#reset

;	calla	get_all_buttons_down2
	calla	get_all_buttons_cur2
	jrnz	#xit3
	dsj	a11,#loop4
#xit3

	SOUND1	cntdown_snd

	movk	1,a0
	move	a0,@force_selection

	calla	DELOBJA8
	DIE

#reset
	clr	a0
	move	a0,@BTIME
	movi	TSEC,a10
	CREATE0	timeout3
	calla	DELOBJA8
	SOUND1	cntdown_snd
	DIE


#center_image
	move	*a8(OSIZEX),a0
	srl	1,a0
	movi	X,a1
	sub	a0,a1
	move	a1,*a8(OXPOS)
	rets


#nums	.long	lgmd_0,lgmd_1,lgmd_2
	.long	lgmd_3,lgmd_4,lgmd_5
	.long	lgmd_6,lgmd_7,lgmd_8,lgmd_9

#******************************************************************************
*
* a3  = * player data
* a10 = player number (0-3)
* sets special_heads based on initials entered

 SUBR	check_initials

	sll	4,a10				;x 16
	addi	special_heads,a10

	clr	a5

	movi	#team_inits,a2

#next
	move	*a3(PR_INIT1),a0
	jrn	#no_match
	move	*a2,a1
	cmp	a0,a1
	jrne	#no_match

	move	*a3(PR_INIT2),a0
	move	*a2(10h),a1
	cmp	a0,a1
	jrne	#no_match

	move	*a3(PR_INIT3),a0
	move	*a2(20h),a1
	cmp	a0,a1
	jrne	#no_match

	move	*a3(PR_MONTH),a0
	inc	a0
	move	*a2(30h),a1
	cmp	a0,a1
	jrne	#no_match

	move	*a3(PR_DAY),a0
	inc	a0
	move	*a2(40h),a1
	cmp	a0,a1
	jrne	#no_match

	move	a5,*a10			;special head number
	move	a5,a0
	sll	6,a0			;x 16 x 4
	addi	#team_snds,a0
	calla	speech_playovrp

	rets

#no_match
	addi	50h,a2
	inc	a5
	cmpi	13,a5
	jrlt	#next

	rets


#team_inits
	.word	'T'-'A','W'-'A','G'-'A'	,12,07	;0 GOSKIE
	.word	'R'-'A','J'-'A','R'-'A'	,01,17	;1 RIVETT
	.word	'J'-'A','M'-'A','C'-'A'	,08,05	;2 CARLTON
	.word	'S'-'A','A'-'A','L'-'A'	,02,01	;3 DIVITA
	.word	'S'-'A','L'-'A',26	,06,24	;4 LIPTAK
	.word	'M'-'A','J'-'A','T'-'A'	,03,22	;5 TURMELL
	.word	'J'-'A','W'-'A','H'-'A'	,09,20	;6 HEY
	.word	'G'-'A','N'-'A','P'-'A'	,10,08	;7 PETRO
	.word	'J'-'A','R'-'A','N'-'A'	,06,18	;8 NEWCOMER
	.word	'S'-'A','N'-'A','O'-'A'	,01,03	;9 OURSLER
	.word	'H'-'A','O'-'A','W'-'A'	,07,15	;10 HOWARD
	.word	'W'-'A','I'-'A','L'-'A'	,01,01	;11 MORRIS
	.word	'T'-'A','O'-'A','N'-'A'	,07,03	;12 SCOTT

#team_snds
	.word	>f9a9,63,>81f6,0	;0 He scores
	.word	>f9a9,47,>81c8,0	;1 Hello!
	.word	>f9a9,70,>819c,0	;2 boom shakalaka
	.word	>f9a9,67,>8172,0	;3 It's a blowout!
	.word	>f9a9,46,>81c2,0	;4 Yes!

	.word	>f9a9,67,>8172,0	;3 It's a blowout!
;	.word	>f9a8,57,>81c0,0	;5 Excuse Me!

	.word	>f9a9,63,>81f6,0	;6 He scores
	.word	>f9a9,47,>81c8,0	;7 Hello!
	.word	>f9a9,47,>81c8,0	;8 Hello!
	.word	>f9a9,47,>81c8,0	;9 Hello!
	.word	>f9a9,47,>81c8,0	;10 Hello!
	.word	>f9a9,47,>81c8,0	;11 Hello!
	.word	>f9a9,47,>81c8,0	;12 Hello!
	.word	>f9a9,47,>81c8,0	;13 Hello!


#******************************************************************************

 SUBR	select_teams

	move	@team1,a0
	move	@team2,a1
	or	a0,a1
	move	a1,a1
	jrnn	#teams_ok		;both teams selected?

	move	@team1,a0
	jrnn	#select_team2

#select_team1
	movi	07ffffffh,a1
	move	@PSTATUS,a0
	btst	2,a0
	jrz	#nop3
	move	@player3_data+PR_INIT1,a0
	jrn	#nop3

	move	@player3_data+PR_TEAMSDEF,a0,L
	and	a0,a1
#nop3
	move	@PSTATUS,a0
	btst	3,a0
	jrz	#nop4
	move	@player4_data+PR_INIT1,a0
	jrn	#nop4

	move	@player4_data+PR_TEAMSDEF,a0,L
	and	a0,a1
#nop4
	movk	1,a0
	move	@team2,a2
	sll	a2,a0
	or	a0,a1
	PUSH	a1
	calla	calc_num_defeated
	cmpi	27,a0
	jreq	#choose_random1

	movi	26,a1
	sub	a0,a1
	move	a1,a0
	calla	RNDRNG0
	PULL	a1
	calla	get_opponent_team
	move	@team2,a0
	cmp	a0,a2
	jreq	#select_team1
	move	a2,@team1

	jruc	#teams_ok


#choose_random1
	PULL	a1
#choose_random1a
	movk	26,a0			;0-26
	calla	RNDRNG0
	move	@team2,a1
	cmp	a0,a1
	jreq	#choose_random1a
	move	a0,@team1
	jruc	#teams_ok


#select_team2
	movi	07ffffffh,a1
	move	@PSTATUS,a0
	btst	0,a0
	jrz	#nop1
	move	@player1_data+PR_INIT1,a0
	jrn	#nop1

	move	@player1_data+PR_TEAMSDEF,a0,L
	and	a0,a1
#nop1
	move	@PSTATUS,a0
	btst	1,a0
	jrz	#nop2
	move	@player2_data+PR_INIT1,a0
	jrn	#nop2

	move	@player2_data+PR_TEAMSDEF,a0,L
	and	a0,a1
#nop2
	movk	1,a0
	move	@team1,a2
	sll	a2,a0
	or	a0,a1
	PUSH	a1
	calla	calc_num_defeated
	cmpi	27,a0
	jreq	#choose_random2

	movi	26,a1
	sub	a0,a1
	move	a1,a0
	calla	RNDRNG0
	PULL	a1
	calla	get_opponent_team
	move	@team1,a0
	cmp	a0,a2
	jreq	#select_team2
	move	a2,@team2

	jruc	#teams_ok


#choose_random2
	PULL	a1
#choose_random2a
	movk	26,a0			;0-26
	calla	RNDRNG0
	move	@team1,a1
	cmp	a0,a1
	jreq	#choose_random2a
	move	a0,@team2

#teams_ok
	rets

team_orders
	.word	_DAL	;27
	.word	_MIN	;26
	.word	_MI	;22
	.word	_WAS	;21
	.word	_PHI	;25
	.word	_SAC	;24
	.word	_MIL	;18
	.word	_DEN	;23
	.word	_GOL	;20
	.word	_SAN	;19
	.word	_SEA	;17
	.word	_ATL	;16
	.word	_ORL	;15
	.word	_LAC	;14
	.word	_NJ	;13
	.word	_CHA	;12
	.word	_BOS	;11
	.word	_CLE	;10
	.word	_DET	;9
	.word	_HOU	;8
	.word	_IND	;7
	.word	_LAL	;6
	.word	_UTA	;5
	.word	_NY	;4
	.word	_POR	;3
	.word	_PHX	;2
	.word	_CHI	;1
	.word	-1

#******************************************************************************
*
* INPUT:	a0 = Nth undefeated team
*		a1 = teams defeated bits
* RETURN:	a2 = team number
*
*------------------------------------------------------------------------------

 SUBR	get_opponent_team


	movi	team_orders,a0
#next_team
	move	*a0+,a2			;team number (0-26)
	jrn	#err			;shouldn't happen
	btst	a2,a1			;defeated?
	jrnz	#next_team
	rets
#err
	clr	a2
	rets

 .if 0
	PUSH	a1
	clr	a2
#next_team
	srl	1,a1
	jrc	#def
;	dec	a0			;teams defeated count ++
;	jrn	#done
#def
	inc	a2
	cmpi	26,a2
	jrlo	#next_team
#done
	PULL	a1
	rets
 .endif

#*****************************************************************************

	.asg	70,Y1
	.asg	104,Y2

 SUBR	ingame_mess

#wait
	move	@PSTATUS,a0
	btst	a10,a0
	jrnz	#ingame
	SLEEPK	1
	jruc	#wait
#ingame

	movi	#initials_setup,a2
	calla	setup_message

	move	a10,a0
	sll	4,a0				;x 16 bits
	move	a0,a1
	sll	1,a0				;x 32 bits
	addi	#plyrdata,a0
	move	*a0,a4,L			;* scr initials

	movi	#init_x,a2
	move	@TWOPLAYERS,a0		;0 = NO, 1 = YES 2 players
	jrz	#not2a
	movi	#kit_x,a2			;kit x vals
#not2a
	add	a2,a1

	move	*a1,a1
	move	a1,@mess_cursx
	movi	message_buffer,a3		;* string dest
	calla	get_initials_string
	calla	print_string_C			;centered

	move	@gmqrtr,a0
	cmpi	4,a0
	jrls	#ok
	movk	4,a0
#ok
	sll	5,a0			;x 32 bits
	addi	#qtr_msgs,a0
	move	*a0,a2,L		;* image

	sll	4,a10			;x 16 bits

	movi	#qtr_x,a3
	move	@TWOPLAYERS,a0		;0 = NO, 1 = YES 2 players
	jrz	#not2b
	movi	#kit_x,a3			;kit x vals
#not2b
	add	a3,a10

	move	*a10,a0
	sll	16,a0			;x val
	PUSH	a0
	movi	[Y2,0],a1		;y val
	movi	1000,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	movi	TYPTEXT,a5		;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	movi	SGMD8BLU,b0		;pal
	calla	BEGINOBJP

	PULL	a0
	movi	[Y1,0],a1		;y val
	movi	getready,a2		;* image
	movi	1000,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	movi	TYPTEXT,a5		;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	movi	SGMD8BLU,b0		;pal
	calla	BEGINOBJP

	DIE

#plyrdata
	.long	player1_data+PR_INIT1
	.long	player2_data+PR_INIT1
	.long	player3_data+PR_INIT1
	.long	player4_data+PR_INIT1

#initials_setup
	RJR_STR	osgemd_ascii,8,1,200,208,BLUE,0

#qtr_msgs
	.long	_1quart,_2quart
	.long	_3quart,_4quart
	.long	overtme,overtme
	.long	overtme,overtme

#qtr_x	.word	52,149,246,342	;x val

#init_x	.word	56,145,250,339

#kit_x	.word	0,101,295,0	;kit x vals


#*****************************************************************************

 SUBR	winner_stays_on

	movi	ADJWINMODE,a0
	calla	GET_ADJ
	move	a0,a14
	jrz	#exit			;disabled?


	.ref	_4plyrsingame
	move	@_4plyrsingame,a0
	jrnz	#not_4play
;	move	@PSTATUS2,a0
;	cmpi	01111b,a0
;	jrne	#not_4play

;	movk	INHALFPRICE,a0
;	cmpi	1,a14
;	jrz	#hlf
	movk	INFREEPRICE,a0
;#hlf
	move	a0,@GAMSTATE


;Zero PxDATA areas

	clr	a0
	movi	P1DATA,a1
	movi	PDSIZE*4/16,A2
#zlp	move	a0,*a1+
	dsj	a2,#zlp

	move	a0,@conttimers,L	;4 words
	move	a0,@conttimers+20h,L

;	clr	a0
;	move	a0,@scores
;	move	a0,@scores+10h

	clr	a0
	move	a0,@PSTATUS
	move	a0,@PSTATUS2

	calla	display_blank
	calla	WIPEOUT			;CLEAN SYSTEM OUT

	clr	a0
	move	a0,@page_scrolling	;not scrolling

	movi	MAX_CRTIME,a0
	move	a0,@cntrs_delay

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	movi	4<<10+4<<5+7,a0
	move	a0,@IRQSKYE

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	clr	a0
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L




	clr	a10
	move	@scores,a0
	move	@scores+10h,a1
	cmp	a1,a0			;score2 - score1
	jrgt	#t1_wins
	movk	1,a10			;t2_wins
#t1_wins
	move	a10,@winningteam	;0 or 1




	SLEEPK	2

	movi	#winner_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1

	calla	blue_shadow

	movk	1,a0
	move	a0,@DISPLAYON


	CREATE0	monitor_buyins
	CREATE0	team_control

	CREATE0	credits
	CREATE0	credit_messages
	CREATE0	monitor_fullgame

	.asg	102,X1
	.asg	294,X2

	.asg	21,Y1
	.asg	42,Y2
	.asg	110,Y3

;	clr	a10
;	move	@scores,a0
;	move	@scores+10h,a1
;	cmp	a1,a0			;score2 - score1
;	jrgt	#t1_wins
;	movk	1,a10			;t2_wins
;#t1_wins
;	move	a10,@winningteam	;0 or 1
;

	move	a10,a0
	sll	4,a0
	addi	#xpos,a0
	move	*a0,a11

	move	a11,a0				;x val
	sll	16,a0
	movi	[Y1,0],a1			;y val
	movi	congrats_l,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2


	move	a11,a0				;x val
	sll	16,a0
	movi	[Y3,0],a1			;y val
	movi	winfree,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2

	movi	#inits_setup,a2
	calla	setup_message
	movi	#str_pl12,a4
	move	a10,a10
	jrz	#tm1
	movi	#str_pl34,a4		;tm2
#tm1
	move	a11,@mess_cursx
	calla	print_string_C2

	move	a10,a0
	xori	1,a0
	sll	4,a0
	addi	#xpos,a0
	move	*a0,a11
	move	a11,a0				;x val
	sll	16,a0
	movi	[Y3,0],a1			;y val
	movi	chalneed_l,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2


	movi	1*TSEC,a10
	CREATE	CNTDWN_PID,timeout2


	SLEEPK	2
	calla	display_unblank


#slp	SLEEP	20*TSEC				;13
	move	@PSTATUS,a0
	jrnz	#slp


;	movi	13*TSEC,a10
;#whopper_with_cheese
;	SLEEPK	1
;	calla	get_all_buttons_down
;	move	a0,a0
;	jrnz	#exit
;	dsj	a10,#whopper_with_cheese
;#exit
;	SLEEPK	1
;
#not_4play
#exit

	movi	-1,a0
	move	a0,@winningteam		;-1 for no valid half price

	RETP

#inits_setup
	RJR_STR	osgemd_ascii,8,0,X1,Y2,BLUE,0

#str_temp
	.string	"MMM & MMM",0
#str_pl12
	.string	"PLAYERS  1 & 2",0
#str_pl34
	.string	"PLAYERS  3 & 4",0
	.even

#xpos
	.word	X1,X2

#winner_mod
	.long	congratbBMOD
	.word	0,0
	.long	namebox2BMOD
	.word	9,207-14
	.long	0

#*****************************************************************************

 SUBR	buyin_screen

;	calla	WIPEOUT			;CLEAN SYSTEM OUT

	move	@PSTATUS,a0
	move	a0,@plyrsdropped

	clr	a0
	move	a0,@pleasewt
	move	a0,@newplyrs,L

	move	@gmqrtr,a14
	cmpi	4,a14
	jrlt	#tag1
	move	@scores,a14
	move	@scores+16,a1
	cmp	a1,a14
	jrz	#tag1
#exit
	RETP
#tag1
	move	@PSTATUS,a9
	movi	qtr_purchased,a1	; - 1 quarter for each player
	clr	a2
#dec_loop
	move	*a1,a0
	jrz	#skip2
	dec	a0
	move	a0,*a1
	jrnz	#skip2
	movk	1,a0
	sla	a2,a0
	move	@PSTATUS,a3
	andn	a0,a3
	move	a3,@PSTATUS
#skip2
	addk	16,a1
	inc	a2
	cmpi	3,a2
	jrls	#dec_loop
	move	@PSTATUS,a0
#tag2
	cmp	a0,a9
	jrnz	#cont
;But, if someone inserted coins, go to buyin_screen anyway!
	calla	CR_CONTP		;Credits to continue
	jrlo	#bx			;No?
   	move	@game_purchased,a0
	cmpi	>f,a0
	jrnz	#cont
#bx
;2/9/93
	RETP

#cont
	movi	4<<10+4<<5+7,a0
	move	a0,@IRQSKYE		;background color

	clr	a0
	move	a0,@COLRTEMP,L
	move	a0,@dtype		;2D

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	movk	ININTRO,a0
	move	a0,@GAMSTATE

	movi	newplyrs,a0
	move	a0,@newptr,L

	calla	KILBGND			;Kill old background
	calla	pal_clean
	SLEEPK	1
	movi	-1,a1
	calla	obj_delc		;Kill all objs (Screen mem is clr)

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	movi	[NAMENT_PAGE,0],a0
	move	a0,@WORLDTLY,L
	movi	[NAMENT_PAGE,0],a0
	move	a0,@WORLDTL,L

	SLEEPK	2

	movi	#buyin_mod,a0
	move	@TWOPLAYERS,a1		;0 = NO, 1 = YES 2 players
	jrz	#not2
	movi	#buyin_kit_mod,a0
#not2
	move	a0,@BAKMODS,L
	calla	BGND_UD1

	.ref	create_bits
	calla	create_bits

	movi	TSEC,a10
	CREATE0	timeout3

	CREATE0	credits
	CREATE0	credit_messages

	movk	1,a0
	move	a0,@can_enter_inits	;if 0 deletes challenger messages

	movk	1,a10			;player 2
	CREATE0	ingame_mess
	CREATE0	challenger
	movk	2,a10			;player 3
	CREATE0	ingame_mess
	CREATE0	challenger

	move	@TWOPLAYERS,a0		;0 = NO, 1 = YES 2 players
	jrnz	#2_plyrs

	clr	a10			;player 1
	CREATE0	ingame_mess
	CREATE0	challenger
	movk	3,a10			;player 4
	CREATE0	ingame_mess
	CREATE0	challenger

#2_plyrs

	SLEEP	10

#wait
	SLEEPK	1
	move	@force_selection,a0
	jrz	#wait
	move	@PSTATUS,a0
	jrnz	#ok

;2/9/93
	calla	dropout_stats
	jauc	game_over

#ok	RETP


#buyin_mod
	.long	selbackBMOD
	.word	0,NAMENT_PAGE
	.long	namebox2BMOD
	.word	9,NAMENT_PAGE+207-14
	.long	0

#buyin_kit_mod
	.long	selbackkBMOD
	.word	0,NAMENT_PAGE
	.long	nameboxkBMOD
	.word	9,NAMENT_PAGE+207-14
	.long	0

#*****************************************************************************

 SUBR	blink_tmslct

	movi	[200,0],a0
	movi	[17,0],a1
	movi	PRESSBUTT,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	0,a5				;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2

#lp
	SLEEP	90

	movi	SGMD8RED,a0
	calla	pal_getf
	move	a0,*a8(OPAL)

	movi	PRESSTURB,a0		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image

	SLEEP	90

	movi	SGMD8WHT,a0
	calla	pal_getf
	move	a0,*a8(OPAL)

	movi	PRESSBUTT,a0		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	jruc	#lp


#*****************************************************************************

	.asg	50,YSPACE

 SUBR	grand_champs_screen


	clr	a10
#chk_nxt
	callr	#check_champ
	jrnc	#found_champ
	inc	a10
	cmpi	4,a10
	jrlt	#chk_nxt

	clr	a10
	RETP


#found_champ

	calla	display_blank
	calla	WIPEOUT

;	SOUND1	tunegc_snd

	clr	a0
	move	a0,@dtype		;2D
	move	a0,@HALT

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	clr	a0
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L
	move	a0,@IRQSKYE

	SLEEPK	2

	movi	#vmod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1

	movi	#congrats_setup,a2
	calla	setup_message
	movi	YSPACE,a0
	move	a0,@mess_line_spacing
	movi	CLSDEAD|123,a0
	move	a0,@mess_objid
	movi	#congrats_str,a4
	calla	print_string_C2

	movi	#congrats_setup,a2	;print player X on line below
	calla	setup_message
	movi	CLSDEAD|123,a0
	move	a0,@mess_objid
	move	@mess_cursy,a0
	addi	YSPACE,a0
	move	a0,@mess_cursy
	movi	#player_str,a4
	calla	copy_rom_string
	move	a10,a0
	move	@TWOPLAYERS,a1		;0 = NO, 1 = YES 2 players
	jrnz	#iskit
	inc	a0			;1,2,3,4
#iskit					;1,2
	movi	4,a1			;max value
	calla	dec_to_asc
	calla	concat_string
	calla	print_string_C		;centered


	movi	-0c000h,a3		;scroll text up screen
	movi	OBJLST,a14
#lp
	move	*a14,a14,L
	jrz	#x
	move	*a14(OID),a2
	cmpi	CLSDEAD|123,a2
	jrne	#lp
	move	a3,*a14(OYVEL),L
	jruc	#lp
#x

	movi	[10,7],a8		;START AT COLOR 10, CYCLE 7 COLORS
	movi	BLUE,a9			;PAL NAME
	movi	COLTAB2,a10		;TABLE TO CYCLE WITH
	movk	2,a11			;RATE OF CYCLE IN TICKS
	CREATE	CYCPID,CYCLE_TABLE	;START PROCESS TO DO CYCLE

	movk	1,a0
	move	a0,@DISPLAYON

	SLEEPK	8

	SOUND1	tunegc_snd
;	movi	congrats_snd,a0
;	calla	snd_play1

	.ref	plyr_jscrowdsnd
	CREATE0	plyr_jscrowdsnd

	calla	display_unblank

	SLEEP	TSEC*13

	CREATE0	plyr_jscrowdsnd

	movi	300,a0
	move	a0,@WORLDTLY+16
	move	a0,@WORLDTL+16
	calla	BGND_UD1

	SLEEP	42*TSEC

	movk	1,a10
	RETP


;a10 = player number (0-3)
#check_champ

	move	@PSTATUS,a0
	btst	a10,a0
	jrz	#fail
	
	move	a10,a0
	sll	5,a0
	addi	#pdata,a0
	move	*a0,a0,L			;* player data

	move	*a0(PR_INIT1),a1
	jrn	#fail
	move	*a0(PR_NUMDEF),a1
	cmpi	27,a1
	jrlt	#fail
	move	*a0(PR_NUMDEFOLD),a1
	cmpi	27,a1
	jrge	#fail

	clrc
	rets

#fail
	setc
	rets


#pdata
	.long	player1_data
	.long	player2_data
	.long	player3_data
	.long	player4_data


#vmod
	.long	chrvic1BMOD
	.word	0,10
	.long	chrvic2BMOD
	.word	0,310
	.long	0

	.asg	200,X
	.asg	10+300,Y

#congrats_setup
	RJR_STR	osgemd_ascii,10,0,X,Y,BLUE,0

#congrats_str
	.string	"congratulations!",1
	.string	"",1
	.string	"",1
	.string	"",1
	.string	"you have defeated",1
	.string	"all 27 nba teams!",1
	.string	"",1
	.string	"",1
	.string	"",1
	.string	"let's celebrate!",1
	.string	"You are the new NBA jam",1
	.string	"grand champion!",1
	.string	"",1
	.string	"",1
	.string	"",1
	.string	"you are an incredible",1
	.string	"player and one of the",1
	.string	"best nba jam stars of",1
	.string	"all time!",1
	.string	"",1
	.string	"however, there is yet",1
	.string	"a greater challenge",1
	.string	"awaiting you . . .",1
	.string	"",1
	.string	"Play on . . .",1
	.string	"",1
	.string	"",1
	.string	"remember:",1
	.string	"true nba jam stars",1
	.string	"stay straight and",1
	.string	"stay in school!",1
	.string	"",1
	.string	"thank you for playing",1
	.string	"nba jam!",1
	.string	"",0


#player_str
	.string	"PLAYER ",0

#*****************************************************************************

 SUBR	drw_chicks

	calla	display_blank
	calla	WIPEOUT

	clr	a0
	move	a0,@dtype		;2D

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	clr	a0
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L
	move	a0,@IRQSKYE

	SLEEPK	2

	movi	#chick_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1
	
	movi	[10,7],a8		;START AT COLOR 10, CYCLE 7 COLORS
	movi	BLUE,a9			;PAL NAME
	movi	COLTAB2,a10		;TABLE TO CYCLE WITH
	movk	2,a11			;RATE OF CYCLE IN TICKS
	CREATE	CYCPID,CYCLE_TABLE	;START PROCESS TO DO CYCLE

	movi	1,a0
	calla	RNDRNG0
	btst	0,a0
	jrz	#msg1
;message #2
	CREATE0	txt2

	movi	6*TSEC,a10
	jruc 	#x

txt2	SLEEP	2*60
	movi	#chicks_setup2,a2
	calla	setup_message
	movi	YSPACE,a0
	move	a0,@mess_line_spacing
	movi	CLSDEAD|123,a0
	move	a0,@mess_objid
	movi	#chicks_str2,a4
	calla	print_string_C2
	DIE


#msg1
	movi	720h,a10
	movi	#chicks_setup,a2
	calla	setup_message
	movi	YSPACE,a0
	move	a0,@mess_line_spacing
	movi	CLSDEAD|123,a0
	move	a0,@mess_objid
	movi	#chicks_str,a4
	calla	print_string_C2

	movi	-0c000h,a3		;scroll text up screen
	movi	OBJLST,a14
#lp
	move	*a14,a14,L
	jrz	#x
	move	*a14(OID),a2
	cmpi	CLSDEAD|123,a2
	jrne	#lp
	move	a3,*a14(OYVEL),L
	jruc	#lp
#x

;	movi	[10,7],a8		;START AT COLOR 10, CYCLE 7 COLORS
;	movi	BLUE,a9			;PAL NAME
;	movi	COLTAB2,a10		;TABLE TO CYCLE WITH
;	movk	2,a11			;RATE OF CYCLE IN TICKS
;	CREATE	CYCPID,CYCLE_TABLE	;START PROCESS TO DO CYCLE

	movk	1,a0
	move	a0,@DISPLAYON

	SLEEPK	2
	calla	display_unblank

	SLEEP	2*TSEC

;	movi	6*TSEC,a10
#lp2	SLEEPK	1
	calla	get_all_buttons_cur2
	jrz	#nob
      	clr	a0
	move	a0,@SOUNDSUP		;turn all sounds on
	SOUND1	bounce_snd
	movk	1,a0
	move	a0,@SOUNDSUP		;turn all sounds off
	jruc	#xb
#nob	
	dsj	a10,#lp2
#xb

	RETP

#chick_mod
	.long	chksaBMOD
	.word	5,0
	.long	0


	.asg	200,X
	.asg	210,Y

#chicks_setup2
	RJR_STR	osgemd_ascii,10,0,X,Y,BLUE,0

#chicks_str2
	.string	"let's play two on two!",1
	.string	" ",0

	.even

	.asg	200,X
	.asg	10+250,Y

#chicks_setup
	RJR_STR	osgemd_ascii,10,0,X,Y,BLUE,0

#chicks_str
	.string	"ATTENTION BALLPLAYERS:",1
	.string	" ",1
	.string	" ",1
	.string	"WE ARE AWAITING YOUR",1
	.string	"ENTRY INTO THE NBA JAM",1
	.string	"TOURNAMENT!",1
	.string	" ",1
	.string	" ",1
	.string	"CAN YOU DEFEAT ALL 27",1
	.string	"NBA TEAMS TO BECOME",1
	.string	"THE GRAND CHAMPION?",1
	.string	" ",1
	.string	" ",1
	.string	"BECOME THE GRAND CHAMPION",1
	.string	"AND WE'LL CELEBRATE YOUR",1
	.string	"VICTORIES TOGETHER!",1
	.string	" ",1
	.string	" ",1
	.string	"ARE YOU UP FOR THE NBA JAM",1
	.string	"CHALLENGE?",1
	.string	" ",1
	.string	" ",1
	.string	" ",1
	.string	"GOOD LUCK...",1
	.string	" ",0
	.even

******************************************************************************

	.end

