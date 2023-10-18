**************************************************************
*
* Software:	Mark Turmell
* Initiated:	7/17/90
*
* Modified:	Shawn Liptak, 11/13/91	-Insert coin fix, clean up
* 		Shawn Liptak, 2/18/92	-Basketball
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 3/19/93 13:10
**************************************************************
	.file	"score2.asm"
	.title	"score stuff"
	.width	132
	.option	b,d,l,t
	.mnolist


	.include	"mproc.equ"
	.include	"disp.equ"
	.include	"gsp.equ"
	.include	"sys.equ"
	.include	"imgtbl.glo"
	.include	"imgtbl2.glo"
	.include	"game.equ"
	.include	"shawn.hdr"
	.include	"mac2.asm"
	.include	"audit.equ"
	.asg		0,SEQT
	.include	"plyr.equ"


;sounds

infoex_snd	.word	>f3ff,>8,>8097,0	;Info box exit
warn2_snd	.word	>fbf7,19,>80a3,0	;Warning for info box

;symbols externally defined

	.ref	TWOPLAYERS
	.ref	player_toggle1		;0 = no toggle
	.ref	player_toggle2		;0 = no toggle
	.ref	pal_set,amode_start,GAMSTATE,P1DATA
	.ref	KILBGND
	.ref	WIPEOUT
	.ref	WNDWON
	.ref	WFLG
 	.ref	get_but_val_cur,PSTATUS,cntrs_delay,HALT,GET_ADJ
	.ref	names,pal_getf,team1,team2
	.ref	arrow1r,arrow2r,arrow3r,arrow4r
	.ref	arrow1r2p,arrow2r2p
	.ref	AUD,AUD1,scores,PSTATUS2
	.ref	UNIT_CLR,get_all_buttons_down
	.ref	player1_data,player2_data,inbound
	.ref	player3_data,player4_data

;symbols defined in this file

	.def	player_data

;uninitialized ram definitions

	BSSX	idiot_bits,16
	.bss	fontram,30*32		;font imgs for red/white flashing

;equates first originated in this file
CONT_MAX	equ	10

	.text

#*****************************************************************************
*
* Increment dropout count & add in score differential

 SUBR	dropout_stats

	movi	AUD_NUMDROPOUT,a0
	calla	AUD1

	move	@scores,a1
	move	@scores+10h,a0
	sub	a0,a1
	abs	a1
	movi	AUD_DROPDIFF,a0
	calla	AUD

	move	@PSTATUS2,a0
	andi	011b,a0
	jrz	#t1_cpu
	move	@PSTATUS2,a0
	andi	01100b,a0
	jrz	#t2_cpu

	movi	AUD_DROPVSHUM,a0
	calla	AUD1
	rets

#t1_cpu
#t2_cpu
	movi	AUD_DROPVSCPU,a0
	calla	AUD1
	rets

#************************************
* Instructions
* 

 SUBR	instructions
	clr	a11
	move	@PSTATUS,a0
	btst	0,a0
	jrz	#nx1
	CREATE	1123,print_inst
#nx1
	movk	1,a11
  
	move	@PSTATUS,a0
	btst	1,a0
	jrz	#nx2
	CREATE	1123,print_inst
#nx2
	movk	2,a11
	move	@PSTATUS,a0
	btst	2,a0
	jrz	#nx3
	CREATE	1123,print_inst
#nx3
	movk	3,a11
	move	@PSTATUS,a0
	btst	3,a0
	jrz	#nx4
	CREATE	1123,print_inst
#nx4	SLEEPK	1
	movi	1123,a0
	clr	a1
	not	a1
	calla	EXISTP
	jrnz	#nx4
	RETP


* A11=Plyr # (0-3)

 SUBR	print_inst

	SLEEPK	1

;Check player experience first!

	move	a11,a14
	sll	5,a14
	addi	player_data,a14
	move	*a14,a14,L
	move	*a14(PR_COUNT),a7
	jrn	#no_inits
	subk	5,a7
	jage	SUCIDE

#no_inits

	move	a11,*a13(PDATA+288)

	CREATE0	do_warns

	move	a11,a0
	movi	35*60,a0
	move	a0,@cntrs_delay

	sll	5,a11
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	firstwin,a2
	movi	19990,a3			;z pos
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA),L

	movi	pal_t,a0
	add	a11,a0
	move	*a0,a0,L
	calla	pal_getf
	move	a0,*a8(OPAL)

	CREATE0	flsh_box

;Blink this img red/wht

	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	ply_t,a2
  



	move	@TWOPLAYERS,a14		;0 = NO, 1 = YES 2 players
	jrz	#not2
	movi	ply2_t,a2
#not2




	add	a11,a2
	move	*a2,a2,L			;Player #x
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+32),L

	CREATE0	blink_plyr
	move	a0,*a13(PDATA+192),L

;Turn on msgs
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[2,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	joycontrol,a2
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+64),L

;Turn on msgs
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[1,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	colormessage,a2
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+96),L

;Turn on msgs
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[1,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	colors_t,a2
	add	a11,a2
	move	*a2,a2,L
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+128),L

;Turn on arws
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[4fh,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	addi	[0ch,0],a0
	movi	arws_t,a2




	move	@TWOPLAYERS,a14		;0 = NO, 1 = YES 2 players
	jrz	#not2c
	movi	arws2_t,a2
#not2c






	add	a11,a2
	move	*a2,a2,L
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+160),L

;Turn on head
	.ref	getwindowhead

	movi	team1,a1
	cmpi	64,a11
	jrlt	#tag0
	movi	team2,a1
#tag0
	calla	getwindowhead

;a0=plyr 1 head img
;a1=plyr 2 head img

	cmpi	64,a11
	jrlt	#tmx0
	move	@player_toggle2,a14
	jrz	#norm
	SWAP	a0,a1
	jruc	#norm
#tmx0
	move	@player_toggle1,a14
	jrz	#norm
	SWAP	a0,a1
#norm

	move	a0,a2
	cmpi	0,a11
	jrz	#tag1
	cmpi	64,a11
	jrz	#tag1
	move	a1,a2

#tag1
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[61h,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	addi	[4ch,0],a0
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+224),L

	movi	names,a0
	add	a11,a0
	move	*a0,a2,L

	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[23h,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	addi	[32h,0],a0
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+256),L


	SLEEP	12

;Make sure the proper player presses his button

	movi	10*60,a8
#whopper_with_cheese
	SLEEPK	1

	move	*a13(PDATA+288),a0
	calla	get_but_val_cur

	move	a0,a0
	jrnz	#exit
	dsj	a8,#whopper_with_cheese

#exit	move	*a13(PDATA+192),a0,L
	calla	KILL

	movi	infoex_snd,a0
	calla	snd_play1

	move	*a13(PDATA+32),a0,L
	calla	DELOBJ
	move	*a13(PDATA+64),a0,L
	calla	DELOBJ
	move	*a13(PDATA+96),a0,L
	calla	DELOBJ
	move	*a13(PDATA+128),a0,L
	calla	DELOBJ
	move	*a13(PDATA+160),a0,L
	calla	DELOBJ
	move	*a13(PDATA+224),a0,L
	calla	DELOBJ
	move	*a13(PDATA+256),a0,L
	calla	DELOBJ

;Show second page of instructions

	move	@PSTATUS,a0
	move	*a13(PDATA+288),a1
	XORK	1,a1
	btst	a1,a0
	jrnz	#no_drone


	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[4,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	dronetxt,a2
	movi	19990,a3			;z pos
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+32),L

	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	ply_t,a2






	move	@TWOPLAYERS,a14		;0 = NO, 1 = YES 2 players
	jrz	#not2a
	movi	ply2_t,a2
#not2a




	add	a11,a2
	move	*a2,a2,L			;Player #x
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+64),L

	CREATE0	blink_plyr
	move	a0,*a13(PDATA+192),L

	SLEEP	12

;Make sure the proper player presses his button

	movi	11*60,a9
#whopper_with_cheese1
	SLEEPK	1
	move	*a13(PDATA+288),a0
	calla	get_but_val_cur
	move	a0,a0
	jrnz	#exit1
	dsj	a9,#whopper_with_cheese1

#exit1
	move	*a13(PDATA+192),a0,L
	calla	KILL

	movi	infoex_snd,a0
	calla	snd_play1

	move	*a13(PDATA+32),a0,L
	calla	DELOBJ
	move	*a13(PDATA+64),a0,L
	calla	DELOBJ

#no_drone

;3rd page of instructions
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[1,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	message4,a2
	movi	19990,a3			;z pos
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+32),L

	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[1,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	message7,a2
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+64),L


	SLEEP	12

;Make sure the proper player presses his button

	movi	11*60,a9
#whopper_with_cheese2
	SLEEPK	1
	move	*a13(PDATA+288),a0
	calla	get_but_val_cur
	move	a0,a0
	jrnz	#exit2
	dsj	a9,#whopper_with_cheese2
#exit2

	movi	infoex_snd,a0
	calla	snd_play1

	move	*a13(PDATA+32),a0,L
	calla	DELOBJ
	move	*a13(PDATA+64),a0,L
	calla	DELOBJ


;4th page of instructions
	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[2,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	message9,a2
	movi	19990,a3			;z pos
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+32),L

	movi	#boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	addi	[2,0],a1
	movi	#boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	message2,a2
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+64),L


	SLEEP	12

;Make sure the proper player presses his button

	movi	10*60,a9
#whopper_with_cheese3
	SLEEPK	1
	move	*a13(PDATA+288),a0
	calla	get_but_val_cur
	move	a0,a0
	jrnz	#exit3
	dsj	a9,#whopper_with_cheese3

#exit3

	movi	infoex_snd,a0
	calla	snd_play1

	movi	30,a9
	movk	8,a10

#lft	SLEEPK	1
;Send box off to lft
	move	*a13(PDATA),a0,L
	move	*a0(OYPOS),a1
	add	a10,a1
	move	a1,*a0(OYPOS)
	move	*a13(PDATA+32),a0,L
	move	*a0(OYPOS),a1
	add	a10,a1
	move	a1,*a0(OYPOS)
	move	*a13(PDATA+64),a0,L
	move	*a0(OYPOS),a1
	add	a10,a1
	move	a1,*a0(OYPOS)

	dsj	a9,#lft


	move	*a13(PDATA),a0,L
	calla	DELOBJ
	move	*a13(PDATA+32),a0,L
	calla	DELOBJ
	move	*a13(PDATA+64),a0,L
	calla	DELOBJ


;	clr	a0
;	move	a0,@HALT
;	move	a0,@cntrs_delay

	DIE


colors_t
	.long	red,yellow,green,blue
arws_t
	.long	arrow1r,arrow2r,arrow3r,arrow4r
arws2_t
	.long	arrow1r2p,arrow1r2p,arrow2r2p,arrow2r2p

#boxy_t	.long	[48-8,0],[48+70+8,0],[48-8,0],[48+70+8,0]
#boxx_t	.long	[7,0],[64h,0],[0c3h,0],[120h,0]
ply_t	.long	plyr1,plyr2,plyr3,plyr4
ply2_t	.long	plyr1,plyr1,plyr2,plyr2
pal_t	.long	GROWBOXr,GROWBOXy,GROWBOXg,GROWBOXb

#***************************************************************
* Shake screen as as if an earthquake is in effect
* A10 = # ticks to shake and power of shake
* Note: time to shake must be more than 6 ticks

	.BSS	AMP,16
	.BSS	AMPCNT,16
	.BSS	XSET,16
	.BSS	YSET,16
	.BSS	SHK_ON,16

	.ref	RNDRNG0

 SUBR	SHAKER

	move	@SHK_ON,a0
	jrnz	#x
	move	a10,a11
	movk	6,a0
	move	a0,@SHK_ON
	divs	a0,a11
	move	a0,@AMP
	move	a11,@AMPCNT
	
	CREATE0	shakelp
#x	RETS
	
shakelp
	move	@AMP,a0
	calla	RNDRNG0
	move	a0,@XSET
	move	@AMP,a0
	calla	RNDRNG0
	move	a0,@YSET
	move	@HCOUNT,a14
	btst	0,a14
	jrz	#shakey

	move	@XSET,a1
	move	@WORLDTLX,a0,L
	sll	16,a1
	add	a1,a0
	move	a0,@WORLDTLX,L
	SLEEPK	1
	move	@XSET,a1
	move	@WORLDTLX,a0,L
	sll	16,a1
	sub	a1,a0
	move	a0,@WORLDTLX,L
	jruc	shakelp

#shakey
	move	@YSET,a1
	move	@WORLDTLY,a0,L
	sll	16,a1
	add	a1,a0
	move	a0,@WORLDTLY,L
	SLEEPK	1
	move	@YSET,a1
	move	@WORLDTLY,a0,L
	sll	16,a1
	sub	a1,a0
	move	a0,@WORLDTLY,L
	move	@AMPCNT,a2
	dec	a2
	move	a2,@AMPCNT
	jrnz	#ampok
	move	a11,@AMPCNT
	move	@AMP,a0
	cmpi	1,a0
	jrz	#ampok
	dec	a0
	move	a0,@AMP
#ampok
	dsj	a10,shakelp
	move	a10,@SHK_ON

	DIE

 SUBR	do_warns
	movi	warn2_snd,a0
	calla	snd_play1
	SLEEPK	20
	movi	warn2_snd,a0
	calla	snd_play1
	SLEEPK	20
	movi	warn2_snd,a0
	calla	snd_play1
	SLEEPK	20
	movi	warn2_snd,a0
	calla	snd_play1
	SLEEPK	20
	movi	warn2_snd,a0
	calla	snd_play1
	SLEEPK	20
	movi	warn2_snd,a0
	calla	snd_play1
	SLEEPK	20
	movi	warn2_snd,a0
	calla	snd_play1
	DIE

#************************************
* Create idiot box process to give the player a message
* A0=Message #
* A1=Plyr # (0-3)

 SUBR	idiot_box
;	RETS

	PUSH	a7,a10,a11

	.ref	game_time
	move	@game_time,a14,L
	cmpi	>900,a14
	jrlt	#x

	move	a1,a14
	sll	5,a14
	addi	player_data,a14
	move	*a14,a14,L
	move	*a14(PR_COUNT),a7
	jrn	#no_inits
	move	a0,a0
	jrz	#no_inits
	subk	5,a7
	jrge	#x

#no_inits
	move	@PSTATUS,a14
	btst	a1,a14

	jrnz	#notdrn			;Drone?
	move	a0,a0
	jrnz	#x			;Out of credit message?

#notdrn
	move	a0,a10
	move	a1,a11
	CREATE0	idiot_box2

#x	PULL	a7,a10,a11
	rets

player_data
	.long	player1_data,player2_data
	.long	player3_data,player4_data

#************************************
* Idiot box (process)
* A10=Message #
* A11=Plyr # (0-3)

 SUBRP	idiot_box2

;Check player experience first!

#slp	SLEEPK	1

	move	@idiot_bits,a0
	btst	a11,a0
	jrnz	#slp
	move	@inbound,a0
	jann	SUCIDE			;#slp

	move	a11,a0
	sll	4,a0
	addi	bit_t,a0
	move	*a0,a0
	move	@idiot_bits,a1
	or	a0,a1
	move	a0,@idiot_bits

	movi	5*60,a0
	move	a0,@HALT
	move	a0,@cntrs_delay

	sll	5,a11
	movi	boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	movi	boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	infobox,a2
	movi	19990,a3			;z pos
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA),L
	movi	pal_t,a0
	add	a11,a0
	move	*a0,a0,L
	calla	pal_getf
	move	a0,*a8(OPAL)


	CREATE0	flsh_box

;Blink this img red/wht

	movi	boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	movi	boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	movi	ply_t,a2





	move	@TWOPLAYERS,a14		;0 = NO, 1 = YES 2 players
	jrz	#not2b
	movi	ply2_t,a2
#not2b




	add	a11,a2
	move	*a2,a2,L			;Player #x
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+32),L

	CREATE0	blink_plyr

	movi	msg_t,a2
	sll	5,a10
	add	a10,a2
	move	*a2,a2,L

	move	a0,a10				;Keep blink proc

	movi	boxy_t,a0
	add	a11,a0
	move	*a0,a1,L
	movi	boxx_t,a0
	add	a11,a0
	move	*a0,a0,L
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a13(PDATA+64),L

	SLEEP	TSEC*1

	movi	4*60,a8
#whopper_with_cheese
	SLEEPK	1
	callr	get_all_buttons_down
	move	a0,a0
	jrnz	#exit
	dsj	a8,#whopper_with_cheese

#exit	move	a10,a0
	calla	KILL

	movi	infoex_snd,a0
	calla	snd_play1

	movi	30,a9
	movi	-8,a10
	cmpi	64,a11
	jrlt	#lft
;Send box off to right	
	movk	8,a10
#lft	SLEEPK	1
;Send box off to lft
	move	*a13(PDATA),a0,L
	move	*a0(OXPOS),a1
	add	a10,a1
	move	a1,*a0(OXPOS)
	move	*a13(PDATA+32),a0,L
	move	*a0(OXPOS),a1
	add	a10,a1
	move	a1,*a0(OXPOS)
	move	*a13(PDATA+64),a0,L
	move	*a0(OXPOS),a1
	add	a10,a1
	move	a1,*a0(OXPOS)
	dsj	a9,#lft

	move	*a13(PDATA),a0,L
	calla	DELOBJ
	move	*a13(PDATA+32),a0,L
	calla	DELOBJ
	move	*a13(PDATA+64),a0,L
	calla	DELOBJ


	addi	bit_and,a11
	move	*a11,a0,L
	move	@idiot_bits,a1
	and	a0,a1
	move	a1,@idiot_bits

	move	a1,a1
	janz	SUCIDE

	move	@PSTATUS,a0
	jaz	SUCIDE

	clr	a0
	move	a0,@HALT
	move	a0,@cntrs_delay

	DIE


 SUBR	blink_plyr	
	SLEEPK	20

blink_plyr1
	movi	SGMD8RED,a0
	calla	pal_getf
	move	a0,*a8(OPAL)
	SLEEPK	4
	movi	SGMD8WHT,a0
	calla	pal_getf
	move	a0,*a8(OPAL)
	SLEEPK	7
	jruc	blink_plyr1


 SUBR 	flsh_box

	SLEEPK	2

	movi	>1616,a2
	move	a2,*a8(OCONST)

	movk	3,a10
#again
	callr	const_on

	SLEEPK	3

	callr	const_off

	SLEEPK	3

	dsj	a10,#again
	DIE


bit_t	.word	1,2,4,8
bit_and	.long	>e,>d,>b,>7
boxy_t	.long	[48,0],[48+70,0],[48,0],[48+70,0]
boxx_t	.long	[7,0],[47h+6,0],[0dah+6,0],[127h-23,0]
msg_t	.long	message1,message2,message3,message4,message5,message6
	.long	message7,message2a
const_on
	setf	4,0,0
	movk	M_CONNON,a0		;Replace non-zero data with constant
	move	a0,*a8(OCTRL)		;Write 4 low bits
	setf	16,1,0
	rets


const_off
	setf	4,0,0
	movk	M_WRNONZ,a0
	move	a0,*a8(OCTRL)		;Write 4 low bits
	setf	16,1,0
	rets

#*****************************************************************************

	.ref	CR_CONTP
	.ref	BTIME
	.ref	setup_message,print_string_C2
	.ref	copy_string,print_string_C
	.ref	dec_to_asc
	.ref	osgemd_ascii,sgmd8_ascii,osgmd8_ascii
	.ref	lgmd_ascii,omlgmd_ascii,ogmd10_ascii
	.ref	mess_line_spacing
	.ref	mess_cursy
	.ref	mess_objid

 SUBR	update_cont_message

	movi	CLSNEUT|TYPTEXT|SUBMES1,A0
	calla	obj_del1c

	movi	LN0_setup,a2
	calla	setup_message

	calla	CR_CONTP		;ENOUGH TO CONTINUE?
	jrlo	#need_credits		;BR = NO
	movi	#str_press,a8
	jruc	#cont
#need_credits
	MOVI	#str_insert,A8
#cont
	MOVI	CLSNEUT|TYPTEXT|SUBMES1,A0
	move	a0,@mess_objid		;OBJ ID's for text
	move	a8,a4
	calla	print_string_C2

	movi	LN1_setup,a2
	calla	setup_message
	MOVI	CLSNEUT|TYPTEXT|SUBMES1,A0
	move	a0,@mess_objid		;OBJ ID's for text
	movi	#str_tocont,a4
	calla	print_string_C2

	movi	LN2_setup,a2
	calla	setup_message
	MOVI	CLSNEUT|TYPTEXT|SUBMES1,A0
	move	a0,@mess_objid		;OBJ ID's for text
	move	@BTIME,a0
	movi	CONT_MAX,a1		;max value
	calla	dec_to_asc
	calla	copy_string
	calla	print_string_C

	rets

LN0_setup
	RJR_STR	osgemd_ascii,6,0,200,132-20-12-26,GOLD,0
LN1_setup
	RJR_STR	osgemd_ascii,6,0,200,132-20-12,GOLD,0
LN2_setup
	RJR_STR	osgemd_ascii,6,0,200,132-20-12+26,GREENPAL,0
#str_insert
	.string	"INSERT COINS",0
#str_press		     
	.string	"PRESS START",0
#str_tocont
	.string	"TO CONTINUE",0
	.even


 SUBR	flash_bigtxt
  
	movi	OBJLST,a14
	movi	fontram,a3
	clr	a4
	move	a4,*a3,L
	
#lp
	move	*a14,a14,L
	jrz	#x
	move	*a14(OID),a2
	cmpi	CLSDEAD|123,a2
	jrne	#lp
	move	a14,*a3+,L
	move	a4,*a3,L
	jruc	#lp
	
#x	
	movi	LGMDWHT,a0		;slv
	calla	pal_getf
	movi	fontram,a3
	
#lp2
	move	*a3+,a1,L
	jrz	#xx
	move	a0,*a1(OPAL)
	jruc	#lp2

#xx	SLEEPK	3

	movi	LGMDRED2,a0
	calla	pal_getf
	movi	fontram,a3
	
#lp3
	move	*a3+,a1,L
	jrz	#xxx
	move	a0,*a1(OPAL)
	jruc	#lp3

#xxx	SLEEPK	5
	jruc	#x
#*
 SUBR	flash_bigtxt2
  
	movi	OBJLST,a14
	movi	fontram,a3
	clr	a4
	move	a4,*a3,L
	
#lp
	move	*a14,a14,L
	jrz	#x
	move	*a14(OID),a2
	cmpi	CLSDEAD|123,a2
	jrne	#lp
	move	a14,*a3+,L
	move	a4,*a3,L
	jruc	#lp
	
#x	
;	movi	WHITE2PAL,a0		;slv
	movi	LGMDWHT,a0		;slv
	calla	pal_getf
	movi	fontram,a3
	
#lp2
	move	*a3+,a1,L
	jrz	#xx
	move	a0,*a1(OPAL)
	jruc	#lp2

#xx	SLEEPK	3

;	movi	PURPLE,a0
	movi	LGMDPURP,a0
	calla	pal_getf
	movi	fontram,a3
	
#lp3
	move	*a3+,a1,L
	jrz	#xxx
	move	a0,*a1(OPAL)
	jruc	#lp3

#xxx	SLEEPK	5
	jruc	#x



#*************************************************************************
* Game over process

 SUBR	game_over

	movi	AUDBONE,a0		;DEC CMOS CNT OF GAMES STARTED
	movi	-1,a1
	calla	AUD
	

	movk	INGAMEOV,a0
	move	a0,@GAMSTATE
	clr	a0
	movi	P1DATA,a14

	move	a0,@PSTATUS
	move	a0,@PSTATUS2


	movi	LN1b_setup,a2
	calla	setup_message
	movi	CLSNEUT|TYPTEXT|SUBMES1,a0
	move	a0,@mess_objid		;OBJ ID's for text
	movi	#str_game,a4
	calla	print_string_C2

	movi	LN2b_setup,a2
	calla	setup_message
	movi	CLSNEUT|TYPTEXT|SUBMES1,a0
	move	a0,@mess_objid		;OBJ ID's for text
	movi	#str_over,a4
	calla	print_string_C2


	movi	OBJLST,a10
	jruc	#start
#next_obj
	move	*a10(OID),a0
	cmpi	CLSNEUT|TYPTEXT|SUBMES1,a0
	jrne	#not_gover
	movi	30002,a0
	move	a0,*a10(OZPOS)		;higher priority than black window
#not_gover
#start
	move	*a10,a10,L
	jrnz	#next_obj

	movk	1,a0
	move	a0,@HALT

;	SLEEP	40

 	movi	CYCPID2,a0
	calla	KIL1C
 	movi	CYCPID,a0
	calla	KIL1C

	SLEEPK	3

	movi	#pal_t,a10
	movi	32,a11
	CREATE0	fade_down

;	JSRP	WNDWON

	SLEEP	TSEC*2

	clr	a0
	move	a0,@DISPLAYON		;Turn the display off

	calla	UNIT_CLR		;CLEAR THE FACTIONS OF FRACTIONS


;	movi	40,a10
;#lp	SLEEPK	1
;	move	@WORLDTLY+16,a0
;	addk	5,a0
;	move	a0,@WORLDTLY+16
;	dsjs	a10,#lp

;	clr	a10
;	movk	16,a11
	.ref	fade_down
;	CREATE0	fade_down
;
;	SLEEP	40

	calla	WIPEOUT

	SLEEPK	1

	movk	1,a0
	move	a0,@DISPLAYON		;Turn the display back on
	clr	a0
	move	a0,@WFLG

	jauc	amode_start		;Start attract mode


#pal_t	.long	LGMDBLU,0

LN1b_setup
	RJR_STR	lgmd_ascii,6,2,200,128-10-61,LGMDBLU,0
LN2b_setup
	RJR_STR	lgmd_ascii,6,2,200,128+10,LGMDBLU,0
#str_game
	.byte	"GAME",0
#str_over
	.byte	"OVER",0
	.even


#******************************************************************
* Note: Scratch = A0-A1,A14,B0-B1

 SUBR	update_shoes

	.if	IMGVIEW
	rets				;Debug - no credit cntdwn
	.endif

	PUSH	a11

	move	*a13(PDATA+32),a0,L
	move	*a0(PA11),a11,L
	move	*a11,a6			;A6=Ctrl bits

	movi	wht_shoes,a11		;pal data
;	move	*a0(plyr_num),a1
;	btst	0,a1
;	jrz	#noblk
;	movi	blk_shoes,a11		;pal data
;#noblk

	btst	6,a6			;Turbo but
	jrz	#noturb
	move	*a0(plyr_PDATA_p),a1,L
	move	*a1(ply_turbo),a1
	jrz	#noturb			;No turbo left?

	move	*a13(PDATA+128),a14
	srl	6,a14
	move	@PSTATUS,a6
	btst	a14,a6
	jrz	#noturb

;	movi	red_shoes,a11		;pal data
	move	*a0(plyr_num),a1
	sll	5,a1
	addi	shoec_t,a1
	move	*a1,a11,L

;	move	*a0(plyr_num),a1
;	btst	0,a1
;	jrz	#noblk2
;	movi	grn_shoes,a11		;pal data
;#noblk2

#noturb
	move	@GAMSTATE,a6
	cmpi	INAMODE,a6
	jrz	#x
	move	*a13(PDATA+64),A6,L
	cmp	a11,a6
	jrz	#x
  	move	a11,*a13(PDATA+64),L
	

	move	*a0(PA8),a0,L
	move	*a0(OPAL),a0,W




;	move	*a0(plyr_attrib_p),a7,L
;	move	*a7(PAT_PALT_p),a0,L
;;FIX!!!
;	calla	pal_find		;Put in PDATA??!!!!


	andi	0ff00h,a0

	move	a0,a1			;dest pal
	ori	249,a1
	move	a11,a0



	movk	5,a2			;5 colors
	calla	pal_set
#x	PULL	a11
	rets

shoec_t	.long	#red,#yel,#grn,#blu
#red
	COLORW	31,0,0
	COLORW	26,0,0
	COLORW	20,0,0
	COLORW	15,0,0
	COLORW	10,0,0
#grn
	COLORW	0,(31-7),0
	COLORW	0,(27-7),0
	COLORW	0,(22-7),0
	COLORW	0,(18-7),0
	COLORW	0,(14-7),0
#blu
	COLORW	0,10,31
	COLORW	0,8,27
	COLORW	0,6,22
	COLORW	0,4,18
	COLORW	0,0,14
#yel
	COLORW	31,31,0
	COLORW	27,27,0
	COLORW	22,22,0
	COLORW	18,18,0
	COLORW	14,14,0

wht_shoes
	COLORW	31,31,31
	COLORW	27,27,27
	COLORW	22,22,22
	COLORW	18,18,18
	COLORW	14,14,14

;	.endif


 SUBR	drwnbalogo

	SLEEP	3*60
	movi	[3,0],a10
	movi	[-300,0],a11
#drw
	movi	nbalogo,a9
	CREATE0	logo_drift
	SLEEP	120
	movi	stay,a9
	CREATE0	logo_drift
	SLEEP	120
	movi	nbalogo,a9
	CREATE0	logo_drift
	SLEEP	14*60
	movi	[-3,0],a10
	movi	[520,0],a11
	jruc	#drw


logo_drift

	move	a11,a0
	movi	[40,0],a1
	movi	>7591,a3				;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	move	a9,a2
	movi	CLSDEAD,a5
	move	a10,a6
	clr	a7
	calla	BEGINOBJ2

	SLEEP	700/3+120

	jauc	DELOBJDIE

 .if 0

 SUBR	drw_cards
;Turn on backboard and hoop base
	movi	[200,0],a0
	movi	[20,0],a1
	movi	bkbd1,a2
	movi	>7591,a3				;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
;
	movi	[200,0],a0
	movi	[20,0],a1
	movi	bkbd2,a2
	movi	>7591,a3				;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
;
	movi	[200,0],a0
	movi	[20,0],a1
	movi	bkbd3,a2
	movi	>7591,a3				;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2

;Turn on a top card
	movi	player_t,a10
	
	movk	26,a9
	movi	[-100,0],a0
	movi	[20,0],a1
	movi	card_g,a2
	movi	>7591,a3				;Z
	movi	DMAWNZ|M_NOCOLL,a4
	movi	CLSDEAD,a5
	movi	[1,0],a6
	clr	a7
	calla	BEGINOBJ2

	SLEEP	700/3+120

	jauc	DELOBJDIE

px	.equ	-100
py	.equ	20
boxx	.equ	-100
boxy	.equ	20

player_t
	.long	card_g
	.word	boxx,boxy
	.long	r_hbar
	.word	boxx,boxy
	.long	r_vbar
	.word	boxx,boxy
	.long	AUG_ATL
	.word	px,py	
	.long	augmon_90
	.word	boxx+80,boxy+30

	.long	0

;---> card_g,card_v,l_hbar,l_vbar,r_hbar,r_vbar,lohaus_90,iuzzo_90,mchale_90
;---> laim_90,edwards_90,gugli_90,augmon_90,barkley_90,benj_90,coleman_90
;---> daug_90,day_90,divac_90,drexler_90,elliot_90,ellis_90,smith_90
;---> stockton_90,thomas_90,tisdale_90,ellison_90,ewing_90,gill_90,grant_90
;---> hardaway_90,harper_90,hawkins_90,horna_90,jackson_90,johnson_90,kemp_90
;---> laetner_90,lewis_90,majerle_90,malone_90,manning_90,miller_90,mullin_90
;---> mutumbo_90,mcdan_90,oakley_90,olaj_90,oneal_90,person_90,petro_90
;---> pippen_90,porter_90,price_90,rice_90,robinson_90,rodman_90,schrempf_90
;---> seik_90,skiles_90,webb_90,wilkins_90,worthy_90

 .endif



#********************************
* Print starring NBA players list

 SUBR	starring

	movi	#ln0_setup,a2
	calla	setup_message

	CLR	a0
	move	a0,@mess_objid

	movi	>20,a0
	move	a0,@mess_cursy
	movi	#str_1,a4
	calla	print_string_C2

	SLEEP	20

	movi	#ln0_setup1,a2
	calla	setup_message

	movi	CLSDEAD|123,a0
	move	a0,@mess_objid

	movi	>60,a0
	move	a0,@mess_cursy

	.ref	card_v

	movi	guyhds,a9
	movi	#guys,a10

	movi	>12,a11

#lp	move	*a10+,a4,L
	jrz	#x
	calla	print_string_C2

	move	a11,a0
	sll	16,a0

	movi	[170,0],a1
	movi	card_v,a2
	movi	>7591,a3				;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2


	CREATE0	del_me

	move	a11,a0
	sll	16,a0
	addi	[4,0],a0

	movi	[0edh,0],a1
	move	*a9+,a2,L
	movi	>7591,a3				;Z
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2

	CREATE0	del_me

	addi	90,a11
	cmpi	310,a11
	jrlt	#ok
	movi	12h,a11
#ok
	PUSHP	a10

	movk	12,a10
#lplp	SLEEPK	1

	.ref	get_all_buttons_cur2

	calla	get_all_buttons_cur2
	jrz	#nob
      	clr	a0
	.ref	SOUNDSUP
	move	a0,@SOUNDSUP		;turn all sounds on
	SOUND1	bounce_snd
	movk	1,a0
	move	a0,@SOUNDSUP		;turn all sounds off
	PULLP	a10
	jruc	#x
#nob 	dsj	a10,#lplp

	PULLP	a10

	movi	CLSDEAD|123,a0
	calla	obj_del1c		;delete text

	jruc	#lp
#x
	.ref	pal_clean
	calla	pal_clean
	RETP

del_me	SLEEP	>30
	move	a8,a0
	calla	DELOBJ
	DIE

bounce_snd	.word	>fc80,10,>8129,0	;Ball bounce

#guys	.long	#str_2,#str_3,#str_4,#str_5,#str_6,#str_7,#str_8
	.long	#str_9,#str_10,#str_11,#str_12,#str_13,#str_14
	.long	#str_15,#str_16,#str_17,#str_18,#str_19,#str_20
	.long	#str_21,#str_21a,#str_22,#str_23,#str_24,#str_25
	.long	#str_25a
	.long	#str_25b
	.long	#str_26
	.long	#str_27,#str_28,#str_29,#str_30,#str_31,#str_32
	.long	#str_33,#str_34,#str_35,#str_36,#str_37,#str_38
	.long	#str_39,#str_40,#str_41,#str_42,#str_43,#str_44
	.long	#str_45,#str_46,#str_47,#str_48,#str_49,#str_50
	.long	#str_51,#str_52,#str_53,#str_54,#str_55
	.long	0

	.ref	guyhds
#ln0_setup
	RJR_STR	omlgmd_ascii,12,1,200,6,LGMDBLU,0

#ln0_setup1
	RJR_STR	omlgmd_ascii,12,1,200,6,LGMDGLD,0

#str_1
	.string	"STARRING:",0
#str_2
	.string	"Clyde Drexler",0
#str_3
	.string	"Terry Porter",0
#str_4
	.string	"James Worthy",0
#str_5
	.string	"Vlade Divac",0
#str_6
	.string	"Charles Barkley",0
#str_7
	.string	"Dan Majerle",0
#str_8
	.string	"Danny Manning",0
#str_9
	.string	"Ron Harper",0
#str_10
	.string	"Tim Hardaway",0
#str_11
	.string	"Chris Mullin",0
#str_12
	.string	"Shawn Kemp",0
#str_13
	.string	"Benjamin",0
#str_14
	.string	"Wayman Tisdale",0
#str_15
	.string	"Spud Webb",0
#str_16
	.string	"Olajuwon",0
#str_17
	.string	"Kenny Smith",0
#str_18
	.string	"David Robinson",0
#str_19
	.string	"Sean Elliot",0
#str_20
	.string	"Karl Malone",0
#str_21
	.string	"John Stockton",0
#str_21a
	.string	"Stephen Howard",0
#str_22
	.string	"Derek Harper",0
#str_23
	.string	"Mike Iuzzolino",0
#str_24
	.string	"Laetner",0
#str_25
	.string	"Chuck Person",0





#str_25a
	.string	"Tony Scott",0
#str_25b
	.string	"Willie Morris Jr.",0




#str_26
	.string	"Mutumbo",0
#str_27
	.string	"Laphonso Ellis",0
#str_28
	.string	"Scottie Pippen",0
#str_29
	.string	"Horace Grant",0
#str_30
	.string	"Isiah Thomas",0
#str_31
	.string	"Bill Laimbeer",0
#str_32
	.string	"Reggie Miller",0
#str_33
	.string	"Schrempf",0
#str_34
	.string	"Mark Price",0
#str_35
	.string	"Brad Daughrty",0
#str_36
	.string	"Brad Lohaus",0
#str_37
	.string	"Blue Edwards",0
#str_38
	.string	"Dominique",0
#str_39
	.string	"Stacey Augmon",0
#str_40
	.string	"Larry Johnson",0
#str_41
	.string	"Kendall Gill",0
#str_42
	.string	"Hersey Hawkins",0
#str_43
	.string	"Jeff Hornacek",0
#str_44
	.string	"Reggie Lewis",0
#str_45
	.string	"Kevin McHale",0
#str_46
	.string	"Patrick Ewing",0
#str_47
	.string	"Charles Oakley",0
#str_48
	.string	"Derrick Coleman",0
#str_49
	.string	"Petrovic",0
#str_50
	.string	"Tom Gugliotta",0
#str_51
	.string	"Harvey Grant",0
#str_52
	.string	"Shaquille",0
#str_53
	.string	"Scott Skiles",0
#str_54
	.string	"Glen Rice",0
#str_55
	.string	"Rony Seikaly",0

	
	.even

	.end

