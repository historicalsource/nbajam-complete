**************************************************************
*
* Software:		Shawn Liptak, Mark Turmell
* Initiated:		9/17/92
*
* Modified:		Shawn Liptak, 9/17/92	-Split from BB.asm
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 9/23/92 15:03
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
	.include	"imgtbl.glo"
	.include	"game.equ"
	.include	"shawn.hdr"		;Macros
	.include	"plyr.tbl"


;sounds external


;symbols externally defined

	.ref	scores,prt_top_scores
	.ref	shot_clock
	.ref	score_add,score_showtvpanel
	.ref	movie_test
	.ref	net_ani

	.ref	pal_getf
	.ref	RNDRNG0

	.ref	PCNT
	.ref	GAMSTATE,HALT
	.ref	scale1_t,scale2_t,scale3_t,scale4_t
	.ref	gndx


;symbols defined in this file


;uninitialized ram definitions

	BSSX	PSTATUS		,16	;Player in game bits (0-3)

	BSSX	P1CTRL		,16	;P1 joy/but bits (0-3=UDLR, 4-6=B1-B3)
	BSSX	P2CTRL		,16	;P2
	BSSX	P3CTRL		,16	;P3
	BSSX	P4CTRL		,16	;P4

	BSSX	P1DATA		,PDSIZE	;Player 1 data
	BSSX	P2DATA		,PDSIZE	;P2
	BSSX	P3DATA		,PDSIZE	;P3
	BSSX	P4DATA		,PDSIZE	;P4

	BSSX	plyrobj_t	,32*4	;*player obj (4)
	BSSX	plyrproc_t	,32*4	;*player process (4)
	.bss	ballobj_p	,32	;* basketball obj
	.bss	ballpnum	,16	;Plyr # who owns (0-3) or Neg
	.bss	ballpnumlast	,16	;Last plyr who owned ^ (0-3)
	.bss	ballfree	,16	;!0=Ball free to move
	.bss	ballscorezhit	,16	;!0=Ball hit score zone, +=Top z, -=Scored



;equates for this file


GRAV		.equ	>2200
GRAVB		.equ	>1400
WRLDMID		.equ	>2000
GZBASE		.equ	894
;GZMID		.equ	1190
GZMAX		.equ	1379+40
CZMIN		.equ	1000
CZMID		.equ	1170
HOOPLX		.equ	>2000-320
HOOPRX		.equ	>2000+320
HOOPY		.equ	-120

	.text




#*******************************
* Main player control code (Process)
* A8=Plyr # (0-3)
* A9=*plyrobj_t for plyr #

	STRUCTPD
	WORD	plyr_num	;P# (0-3)
	APTR	plyr_attrib_p	;*Players attribute table
	WORD	plyr_seq	;Current ani sequence #
	WORD	plyr_seqflgs	;^ flags
	WORD	plyr_seqdir	;^ dir 0-7
	APTR	plyr_seqcode_p	;*Code to run when seq at end
	APTR	plyr_ani1st_p	;*1st ani_l pos
	APTR	plyr_ani_p	;*Current ani_l pos
	WORD	plyr_ownball	;-=Teammate, 0=Neither, +=I have ball
	LONG	plyr_ballxo	;Ball X offset (16:16)
	WORD	plyr_ballyo	;Ball Y offset
	WORD	plyr_ballzo	;Z^
	WORD	plyr_shtdly	;Shoot delay
	WORD	plyr_myhoopx	;Plyrs hoop X
	WORD	plyr_ohoopx	;Opponents hoop X
	WORD	plyr_tmdir	;Teammates dir
	WORD	plyr_tmdist	;^ distance
	WORD	plyr_o1dir	;Opponent 1 dir
	WORD	plyr_o1dist	;^ dist
	WORD	plyr_o2dir	;Opponent 1 dir
	WORD	plyr_o2dist	;^ dist
	WORD	plyr_balldir	;Balls dir
	WORD	plyr_balldist	;^ dist
	WORD	plyr_hpdir	;Plyrs hoop dir
	WORD	plyr_hpdist	;^ dist
	WORD	plyr_indef	;!0=In defensive posture
	WORD	plyr_nojoy	;!0=Ignore joystick
	WORD	plyr_dir	;Current dir 0-127 (3:4)
	WORD	plyr_newdir	;New dir or -1
	WORD	plyr_jmpcnt	;0=No jmp, +=# ticks since jump
	WORD	plyr_hangcnt	;0=No hang, +=Hang cnt down
	WORD	plyr_aniy	;Current frames y anipt
	APTR	plyr_headobj_p	;*Head obj
	APTR	plyr_aligndot_p	;*Alignment obj


	STRUCT	0		;Plyr attribute table
	APTR	PAT_SCL_p	;*Scale table
	APTR	PAT_PAL_p	;*Body palette
	APTR	PAT_HEADT_p	;*Head_t


SEQ	.macro	n,d
:n:	.equ	SOFF
	.eval	SOFF+1,SOFF
	.long	:d:
	.endm

SEQF	.macro	n
:n:_B	.equ	SOFF
:n:_M	.equ	1<<SOFF
	.eval	SOFF+1,SOFF
	.endm

	.asg	0,SOFF
pseq_t	SEQ	NULL_SEQ	,0
	SEQ	STND_SEQ	,stnd_t
	SEQ	STNDDEF_SEQ	,stnddef_t
	SEQ	STNDDRIB_SEQ	,stnddrib_t
	SEQ	STNDDRIBDEF_SEQ	,stnddribdef_t
	SEQ	WALKFDEF_SEQ	,walkfdef_t
	SEQ	WALKBDEF_SEQ	,walkbdef_t
	SEQ	WALKLDEF_SEQ	,walkldef_t
	SEQ	WALKRDEF_SEQ	,walkrdef_t
	SEQ	RUN_SEQ		,run_t
	SEQ	RUNDRIB_SEQ	,rundrib_t
	SEQ	BLOCK_SEQ	,block_t
	SEQ	BLOCKDEF_SEQ	,blockdef_t	;Defensive block
	SEQ	SHOOTJ_SEQ	,shootj_t	;Shoot jump
	SEQ	SHOOT_SEQ	,shoot_t	;Shooting ball
	SEQ	SHOOTL_SEQ	,shootl_t	;Shoot landing
	SEQ	PASSS_SEQ	,passs_t	;Short pass
	SEQ	PASSC_SEQ	,passc_t	;Long chest pass
	SEQ	STEAL_SEQ	,steal_t	;Swipe at ball
	SEQ	DUNKSPIN13_SEQ	,dunkspin13_t	;360 Spin
	SEQ	DUNK2H3_SEQ	,dunk2h3_t	;Two handed
;Turmell
	SEQ	image_stuff	,stuffed


;Seq flags
	.asg	0,SOFF
	SEQF	WALK		;In a defensive walk
	SEQF	DUNK		;Dunk sequence
	SEQF	JUMP		;Jumping type seq
	SEQF	NOMV		;No XZ movement


M_YF	.equ	>8000	;Y free (OFLAGS)



 SUBR	plyr_main


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

	move	a8,a0			;>Set attribute_p
	movi	pattr1-pattr_t,a7,W
	mpyu	a0,a7
	addi	pattr_t,a7
	move	a7,*a13(plyr_attrib_p),L

	movi	#pd1-#pdat_t,a7,W
	mpyu	a8,a7
	addi	#pdat_t,a7

	move	*a7+,a0
	move	a0,*a13(PROCID)

	move	*a7+,a0			;X
	move	*a7+,a1			;Dir
	move	a1,*a13(plyr_dir)

	move	@WORLDTLX+16,a1
	add	a1,a0
	sll	16,a0
	clr	a1			;Y
	move	*a7,a2,L
	movi	CZMID,a3		;Z
	movi	DMAWNZ|M_3D,a4
	movi	CLSPLYR|TYPPLYR,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a9,L		;Save *obj

	move	*a13(plyr_attrib_p),a7,L
	move	*a7,a0,L		;Get *scale_t
	move	a0,*a8(ODATA_p),L

	move	*a7(PAT_PAL_p),a0,L
	calla	pal_getf
	jrz	#nopal
	move	a0,*a8(OPAL)
#nopal
	PUSH	a8
	clr	a0
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
	move	a0,*a8(ODATA_p),L
	PULL	a8

	callr	plyr_getshadow		;Into A9

	callr	plyr_getgndaligndot


	sll	4,a11			;*16
	addi	P1CTRL,a11		;A11=*PxCTRL


	movi	STND_SEQ,a0		;Initial sequence
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
#num2

;---------------------------

#lp
	move	@HALT,a0
	jrnz	#halted

;Turmell
	move	*a13(plyr_num),a0
	jrnz	#halted

	clr	a2			;>Set flag if we have ball
	move	*a13(plyr_num),a0
	move	@ballpnum,a1
	cmp	a1,a0

;Turmell
;	jrne	#nobl1			;No ball?

	movk	1,a2			;+=Me
	jruc	#nobl2
#nobl1	movk	1,a14
	xor	a14,a0
	cmp	a1,a0
	jrne	#nobl2			;No ball?
	subk	2,a2			;-=Teammate
#nobl2	move	a2,*a13(plyr_ownball)


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


#skip	clr	a14			;>Setup def flag
	move	*a13(plyr_ownball),a1
	jrnz	#setdef

	move	*a13(plyr_hpdir),a0	;Find dir difference
	move	*a13(plyr_balldir),a1
	sub	a1,a0
	abs	a0
	cmpi	64,a0
	jrle	#dsml
	subi	128,a0
	abs	a0
#dsml	subk	24,a0
	jrle	#setdef			;Not between ball and hoop?

	move	*a13(plyr_seq),a2
	cmpi	RUNDRIB_SEQ,a2
	jrhi	#setdef
	move	*a13(plyr_o1dist),a1
	cmpi	100,a1
	jrlt	#defon
	move	*a13(plyr_o2dist),a1
	cmpi	100,a1
	jrge	#setdef
#defon	movk	1,a14
#setdef	move	a14,*a13(plyr_indef)


	callr	plyr_chkpcollide

	move	@PSTATUS,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	btst	a1,a0
	jrnz	#human
	callr	drone_main
#human
	move	*a13(plyr_indef),a14
	jrz	#nodef
	move	*a13(plyr_balldir),*a13(plyr_newdir)

#nodef
	move	*a11,a6			;A6=Ctrl bits
	move	*a13(plyr_nojoy),a0
	jrz	#joyon			;Joystick on
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
	move	a6,a0
	sll	32-4,a0
	jrz	#nodir			;No stick?

	srl	32-4-3,a0		;>Convert to dir 0-127
	addi	#dirc_t,a0
	movb	*a0,a0

	sub	a7,a0			;A0=Difference
	jrz	#nodir

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

	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	#nodir
	move	*a13(plyr_seqdir),a0
	move	a7,a1			;Dir
	addk	8,a1
	srl	4,a1
	sll	32-3,a0
	sll	32-3,a1
	cmp	a0,a1
	jreq	#nodir			;Already in this dir?
	move	*a13(plyr_seq),a0
	callr	plyr_setseq


#nodir

	move	*a13(plyr_jmpcnt),a0
	jrnz	#nomv			;Jumping?

	move	*a13(plyr_seq),a0
	cmpi	BLOCK_SEQ,a0
	jreq	#nomv

	move	*a8(OXVEL),a2,L		;>Move
	move	*a8(OZVEL),a3,L

	move	a2,a0			;>-1/4 from XYVEL
	sra	2,a0
	sub	a0,a2
	move	a3,a0
	sra	2,a0
	sub	a0,a3

	move	*a13(plyr_seqflgs),a0
	btst	NOMV_B,a0
	jrnz	#setvel			;No moving?


	movi	>6000*2,a14
	btst	6,a6			;Turbo but
	jrz	#noturb
	addi	>3000*2,a14

#noturb
	move	*a8(OXPOS),a4
	move	*a8(OXANI+16),a0
	add	a0,a4
	move	*a8(OZPOS),a5

	btst	0,a6			;Up
	jrz	#noup
	cmpi	CZMIN+3,a5
	jrle	#noup			;Min?
	sub	a14,a3
#noup
	btst	1,a6			;Dn
	jrz	#nodn
	cmpi	GZMAX-3,a5
	jrge	#nodn			;Max?
	add	a14,a3
#nodn
	btst	2,a6			;Lft
	jrz	#nol
	cmpi	WRLDMID-350,a4
	jrle	#nol			;Max?
	sub	a14,a2
#nol
	btst	3,a6			;Rgt
	jrz	#nor
	cmpi	WRLDMID+350-26,a4
	jrge	#nor			;Max?
	add	a14,a2
#nor
#setvel	move	a2,*a8(OXVEL),L
	move	a3,*a8(OZVEL),L
#nomv



	move	*a13(plyr_shtdly),a0
	jrle	#nodly			;No delay?
	subk	1,a0
	move	a0,*a13(plyr_shtdly)
#nodly

	move	*a13(plyr_seq),a2
	cmpi	RUNDRIB_SEQ,a2
	jrhi	#anicnt

	move	a6,a1			;>Change ani if no joy
	sll	32-4,a1
	jrz	#nojoy			;Joy neutral?


	move	*a13(plyr_indef),a14
	jrz	#nodef2

	srl	32-4-3,a1		;>Convert to dir 0-127
	addi	#dirc_t,a1
	movb	*a1,a1
	sub	a7,a1
	movk	WALKFDEF_SEQ,a0
	move	a1,a14
	abs	a14
	cmpi	16,a14
	jrlt	#setseq
	movk	WALKBDEF_SEQ,a0
	cmpi	112,a14
	jrge	#setseq
	movk	WALKLDEF_SEQ,a0
	cmpi	64,a14
	jrle	#tstdir
	neg	a1
#tstdir	move	a1,a1
	jrn	#setseq
	movk	WALKRDEF_SEQ,a0
	jruc	#setseq

#nodef2
	movk	RUN_SEQ,a0		;>Setup run sequence
	move	*a13(plyr_ownball),a1
	jrle	#setseq
	movk	RUNDRIB_SEQ,a0
	jruc	#setseq

#nojoy
	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	#anicnt

	movk	STNDDEF_SEQ,a0		;>Setup stand sequence
	movk	STNDDRIBDEF_SEQ,a1
	move	*a13(plyr_indef),a14
	jrnz	#chkb
	movk	STND_SEQ,a0
	movk	STNDDRIB_SEQ,a1

#chkb	move	*a13(plyr_ownball),a14
	jrle	#setseq
	move	a1,a0
#setseq	cmp	a0,a2
	jreq	#anicnt

;Turmell
	movk	image_stuff,a0
	callr	plyr_setseq



#anicnt	dsj	a10,#noani

	move	*a13(plyr_ani_p),a14,L	;>Set new ani
#getdel	move	*a14+,a10		;Delay
	jrnn	#nocode			;Not code?

	move	*a14+,a0,L		;*Code
	move	a14,b4
	call	a0
	move	b4,a14
	jruc	#getdel

#nocode	jrnz	#100
	move	*a13(plyr_seqcode_p),a0,L
	jrge	#noendc
	call	a0
#noendc	move	*a13(plyr_ani1st_p),a14,L ;Head of list
	move	*a14+,a10

#100	move	*a14+,a0,L		;*Img
	move	*a14+,a1		;Flags
	move	a1,a2

	move	*a0(IANI2Z),*a13(plyr_ballzo)

	move	a14,*a13(plyr_ani_p),L
	callr	plyr_ani

	callr	anipt2_getsclxy
	move	a0,*a13(plyr_ballxo),L
	sra	16,a1
	move	a2,a2
	jrnn	#ynorm			;!YFree flag?
	movi	-200,a1
#ynorm	move	a1,*a13(plyr_ballyo)

	move	*a13(plyr_jmpcnt),a14
	jrnz	#injmp			;Jumping?
	move	*a13(plyr_aniy),a1
	neg	a1
	move	a1,*a8(OYPOS)		;Set on gnd
#injmp

	move	*a8(OIMG),a2,L		;>Set new head img
	move	*a2(IANI3ID),a1
	sll	5,a1			;*32
	move	*a2(IANI3Z),a14
	neg	a14

	move	*a13(plyr_attrib_p),a0,L
	move	*a0(PAT_HEADT_p),a0,L
	add	a1,a0
	move	*a0,a2,L

	move	*a13(plyr_headobj_p),a3,L
	move	a14,*a3(OMISC)
	move	a2,*a3(OIMG),L		;Set new img
	move	*a2,a14,L
	move	a14,*a3(OSIZE),L
	move	*a2(ISAG),*a3(OSAG),L
	setf	1,0,0
	move	*a8(OCTRL+4),*a3(OCTRL+4) ;Copy HFlip bit
	setf	16,1,0


#noani

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
	addi	GRAV,a0			;+Gravity
	jrn	#200
	move	*a8(OYPOS),a1
	move	*a13(plyr_aniy),a14
	add	a14,a1			;Ani pt position
	jrlt	#200			;Above gnd
	neg	a14
	move	a14,*a8(OYPOS)		;Set on gnd

	movk	1,a10			;Run landing seq
	clr	a0
	move	a0,*a13(plyr_jmpcnt)
;	move	a0,*a13(plyr_nojoy)
#200	move	a0,*a8(OYVEL),L


	move	*a13(plyr_ownball),a1
	jrle	#pass			;No ball?

	move	*a13(plyr_jmpcnt),a0
	cmpi	15,a0
	jrlt	#pass			;Too soon?
	cmpi	45,a0
	jrgt	#shoot			;Make plyr shoot?

	btst	4,a6
	jrnz	#pass			;Holding shoot button?

#shoot
	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	#pass			;Already started?

	move	*a13(plyr_seq),a0
	cmpi	SHOOT_SEQ,a0
	jreq	#pass
	cmpi	BLOCKDEF_SEQ,a0
	jreq	#pass


;ZZZ
	callr	plyr_shoot		;DEBUG!!
	jruc	#pass


	movk	SHOOT_SEQ,a0
	callr	plyr_setseq
	jruc	#pass



#noj	btst	4,a6			;>Shoot/block (But1)
	jrz	#pass


	move	*a13(plyr_seqflgs),a0
	btst	JUMP_B,a0
	jrnz	#pass			;Already started?

	callr	plyr_startjmp



#pass	btst	5,a6			;>Pass/steal (But2)
	jrz	#slp

	move	*a13(plyr_ownball),a1
	jrle	#steal			;No ball?
	callr	plyr_startpass
	jruc	#slp

#steal	movi	STEAL_SEQ,a0
	callr	plyr_setseq

#slp
	move	*a13(plyr_ownball),a1
	jrle	#nob
	callr	plyr_setballxyz
#nob
	callr	plyr_headalign
	callr	shadow_align
	callr	plyr_setgndaligndot

#halted
	SLEEPK	1
	jruc	#lp



#pdat_t	.word	P1_PID,120,2<<4
	.long	w3run1
#pd1	.word	P2_PID,160,2<<4
	.long	w3run1
	.word	P3_PID,240,6<<4
	.long	w3run1
	.word	P4_PID,280,6<<4
	.long	w3run1


#dirc_t	.byte	0,0,4<<4,0,6<<4,7<<4,5<<4,0,2<<4,1<<4,3<<4,0,0,0,0,0


pattr_t
;Turmell
	.long	scale1_t,NWil_b,ewing_h
pattr1	.long	scale2_t,NWil_b,harp_h
	.long	scale3_t,NWil_b,shiek_h
	.long	scale4_t,NWil_b,todd_h

ewing_h	.long	ewing1_hd
	.long	ewing1_hd,ewing2_hd,ewing3_hd,ewing4_hd,ewing5_hd
	.long	ewing6_hd,ewing7_hd,ewing8_hd,ewing9_hd,ewing10_hd
	.long	ewing11_hd,ewing12_hd,ewing13_hd,ewing14_hd,ewing15_hd
	.long	ewing16_hd
harp_h	.long	harp1_hd
	.long	harp1_hd,harp2_hd,harp3_hd,harp4_hd,harp5_hd
	.long	harp6_hd,harp7_hd,harp8_hd,harp9_hd,harp10_hd
	.long	harp11_hd,harp12_hd,harp13_hd,harp14_hd,harp15_hd
	.long	harp16_hd
todd_h	.long	thead1
	.long	thead1,thead2,thead3,thead4,thead5
	.long	thead1,thead2,thead3,thead4,thead5
	.long	thead1,thead2,thead3,thead4,thead5
	.long	thead1
shiek_h	.long	shiek1_hd
	.long	shiek1_hd,shiek2_hd,shiek3_hd,shiek4_hd,shiek5_hd
	.long	shiek6_hd,shiek7_hd,shiek8_hd,shiek9_hd,shiek10_hd
	.long	shiek11_hd,shiek12_hd,shiek13_hd,shiek14_hd,shiek15_hd
	.long	shiek16_hd


********************************

	.asg	M_WRNONZ,F


;Turmell
stuffed	.word	0
       	.long	0
       	.long	stuff1,stuff1,stuff1,stuff1
       	.long	stuff1,stuff1,stuff1,stuff1

stuff1
	WLW	10,w1stand,F
	W0


stnd_t	.word	0
	.long	0
	.long	#stnd1_l,#stnd2_l,#stnd3_l,#stnd4_l
	.long	#stnd5_l,#stnd6_l,#stnd7_l,#stnd8_l

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
#stnd6_l
	WLW	10,w4stand,F|M_FLIPH
	W0
#stnd7_l
	WLW	10,w3stand,F|M_FLIPH
	W0
#stnd8_l
	WLW	10,w2stand,F|M_FLIPH
	W0


stnddef_t
	.word	0
	.long	0
	.long	#sdef1_l,#sdef2_l,#sdef3_l,#sdef4_l
	.long	#sdef5_l,#sdef6_l,#sdef7_l,#sdef8_l


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
#sdef6_l
	WLW	10,w4dfcr1,F|M_FLIPH
	W0
#sdef7_l
	WLW	10,w3dfcr1,F|M_FLIPH
	W0
#sdef8_l
	WLW	10,w2dfcr1,F|M_FLIPH
	W0


stnddrib_t
	.word	0
	.long	0
	.long	#stndd1_l,#stndd2_l,#stndd3_l,#stndd4_l
	.long	#stndd5_l,#stndd6_l,#stndd7_l,#stndd8_l

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
#stndd6_l
	WLW	1,w4dst1,F|M_FLIPH
	WLW	4,w4dst1,F|M_FLIPH|M_YF
	WLW	5,w4dst2,F|M_FLIPH
	WLW	5,w4dst3,F|M_FLIPH
	WLW	5,w4dst4,F|M_FLIPH
	WLW	5,w4dst5,F|M_FLIPH
	WLW	5,w4dst6,F|M_FLIPH
	W0
#stndd7_l
	WLW	1,w3dst1,F|M_FLIPH
	WLW	4,w3dst1,F|M_FLIPH|M_YF
	WLW	5,w3dst2,F|M_FLIPH
	WLW	5,w3dst3,F|M_FLIPH
	WLW	5,w3dst4,F|M_FLIPH
	WLW	5,w3dst5,F|M_FLIPH
	WLW	5,w3dst6,F|M_FLIPH
	W0
#stndd8_l
	WLW	1,w2stand,F|M_FLIPH
	WLW	29,w2stand,F|M_FLIPH|M_YF
	W0


stnddribdef_t
	.word	0
	.long	0
	.long	#sdd1_l,#sdd1_l,#sdd3_l,#sdd4_l
	.long	#sdd5_l,#sdd6_l,#sdd7_l,#sdd8_l
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
#sdd6_l
	WLW	1,w4drcr1,F|M_FLIPH
	WLW	3,w4drcr1,F|M_FLIPH|M_YF
	WLW	4,w4drcr2,F|M_FLIPH
	WLW	4,w4drcr3,F|M_FLIPH
	WLW	3,w4drcr4,F|M_FLIPH
	WLW	3,w4drcr5,F|M_FLIPH
	W0
#sdd7_l
	WLW	1,w3drcr1,F|M_FLIPH
	WLW	4,w3drcr1,F|M_FLIPH|M_YF
	WLW	5,w3drcr2,F|M_FLIPH
	WLW	4,w3drcr3,F|M_FLIPH
	WLW	4,w3drcr4,F|M_FLIPH
	W0
#sdd8_l
	WLW	1,w1drcr1,F|M_FLIPH
	WLW	2,w1drcr1,F|M_FLIPH|M_YF
	WLW	3,w1drcr2,F|M_FLIPH
	WLW	3,w1drcr3,F|M_FLIPH
	WLW	3,w1drcr4,F|M_FLIPH
	WLW	3,w1drcr5,F|M_FLIPH
	WLW	3,w1drcr6,F|M_FLIPH
	W0


run_t
	.word	0
	.long	0
	.long	#run1_l,#run2_l,#run3_l,#run4_l
	.long	#run5_l,#run6_l,#run7_l,#run8_l

#run1_l
	WLW	4,w1run1,F
	WLW	4,w1run2,F
	WLW	4,w1run3,F
	WLW	4,w1run4,F
	WLW	4,w1run5,F
	WLW	4,w1run6,F
	WLW	4,w1run7,F
	W0
#run2_l
	WLW	4,w2run1,F
	WLW	4,w2run2,F
	WLW	4,w2run3,F
	WLW	4,w2run4,F
	WLW	4,w2run5,F
	WLW	4,w2run6,F
	WLW	4,w2run7,F
	WLW	4,w2run8,F
	W0
#run3_l
	WLW	4,w3run1,F
	WLW	4,w3run2,F
	WLW	4,w3run3,F
	WLW	4,w3run4,F
	WLW	4,w3run5,F
	WLW	4,w3run6,F
	WLW	4,w3run7,F
	WLW	4,w3run8,F
	W0
#run4_l
	WLW	4,w4run1,F
	WLW	4,w4run2,F
	WLW	4,w4run3,F
	WLW	4,w4run4,F
	WLW	4,w4run5,F
	WLW	4,w4run6,F
	WLW	4,w4run7,F
	WLW	4,w4run8,F
	W0
#run5_l
	WLW	4,w5run1,F
	WLW	4,w5run2,F
	WLW	4,w5run3,F
	WLW	4,w5run4,F
	WLW	4,w5run5,F
	WLW	4,w5run6,F
	WLW	4,w5run7,F
	WLW	4,w5run8,F
	W0
#run6_l
	WLW	4,w4run1,F|M_FLIPH
	WLW	4,w4run2,F|M_FLIPH
	WLW	4,w4run3,F|M_FLIPH
	WLW	4,w4run4,F|M_FLIPH
	WLW	4,w4run5,F|M_FLIPH
	WLW	4,w4run6,F|M_FLIPH
	WLW	4,w4run7,F|M_FLIPH
	WLW	4,w4run8,F|M_FLIPH
	W0
#run7_l
	WLW	4,w3run1,F|M_FLIPH
	WLW	4,w3run2,F|M_FLIPH
	WLW	4,w3run3,F|M_FLIPH
	WLW	4,w3run4,F|M_FLIPH
	WLW	4,w3run5,F|M_FLIPH
	WLW	4,w3run6,F|M_FLIPH
	WLW	4,w3run7,F|M_FLIPH
	WLW	4,w3run8,F|M_FLIPH
	W0
#run8_l
	WLW	4,w2run1,F|M_FLIPH
	WLW	4,w2run2,F|M_FLIPH
	WLW	4,w2run3,F|M_FLIPH
	WLW	4,w2run4,F|M_FLIPH
	WLW	4,w2run5,F|M_FLIPH
	WLW	4,w2run6,F|M_FLIPH
	WLW	4,w2run7,F|M_FLIPH
	WLW	4,w2run8,F|M_FLIPH
	W0


rundrib_t
	.word	0
	.long	0
	.long	#rund1_l,#rund2_l,#rund3_l,#rund4_l
	.long	#rund5_l,#rund6_l,#rund7_l,#rund8_l

#rund1_l
	WLW	1,w1drun1,F
	WLW	3,w1drun1,F|M_YF
	WLW	4,w1drun2,F
	WLW	4,w1drun3,F
	WLW	4,w1drun4,F
	WLW	4,w1drun5,F
	WLW	4,w1drun6,F
	WLW	4,w1drun7,F
	WLW	4,w1drun8,F
	W0
#rund2_l
	WLW	1,w2drun1,F
	WLW	3,w2drun1,F|M_YF
	WLW	4,w2drun2,F
	WLW	4,w2drun3,F
	WLW	4,w2drun4,F
	WLW	4,w2drun5,F
	WLW	4,w2drun6,F
	WLW	4,w2drun7,F
	WLW	4,w2drun8,F
	W0
#rund3_l
	WLW	1,w3drun1,F
	WLW	3,w3drun1,F|M_YF
	WLW	4,w3drun2,F
	WLW	4,w3drun3,F
	WLW	4,w3drun4,F
	WLW	4,w3drun5,F
	WLW	4,w3drun6,F
	WLW	4,w3drun7,F
	WLW	4,w3drun8,F
	W0
#rund4_l
	WLW	1,w4drun1,F
	WLW	3,w4drun1,F|M_YF
	WLW	4,w4drun2,F
	WLW	4,w4drun3,F
	WLW	4,w4drun4,F
	WLW	4,w4drun5,F
	WLW	4,w4drun6,F
	WLW	4,w4drun7,F
	WLW	4,w4drun8,F
	W0
#rund5_l
	WLW	1,w5drun1,F
	WLW	3,w5drun1,F|M_YF
	WLW	4,w5drun2,F
	WLW	4,w5drun3,F
	WLW	4,w5drun4,F
	WLW	4,w5drun5,F
	WLW	4,w5drun6,F
	WLW	4,w5drun7,F
	WLW	4,w5drun8,F
	W0
#rund6_l
	WLW	1,w4drun1,F|M_FLIPH
	WLW	3,w4drun1,F|M_FLIPH|M_YF
	WLW	4,w4drun2,F|M_FLIPH
	WLW	4,w4drun3,F|M_FLIPH
	WLW	4,w4drun4,F|M_FLIPH
	WLW	4,w4drun5,F|M_FLIPH
	WLW	4,w4drun6,F|M_FLIPH
	WLW	4,w4drun7,F|M_FLIPH
	WLW	4,w4drun8,F|M_FLIPH
	W0
#rund7_l
	WLW	1,w3drun1,F|M_FLIPH
	WLW	3,w3drun1,F|M_FLIPH|M_YF
	WLW	4,w3drun2,F|M_FLIPH
	WLW	4,w3drun3,F|M_FLIPH
	WLW	4,w3drun4,F|M_FLIPH
	WLW	4,w3drun5,F|M_FLIPH
	WLW	4,w3drun6,F|M_FLIPH
	WLW	4,w3drun7,F|M_FLIPH
	WLW	4,w3drun8,F|M_FLIPH
	W0
#rund8_l
	WLW	1,w2drun1,F|M_FLIPH
	WLW	3,w2drun1,F|M_FLIPH|M_YF
	WLW	4,w2drun2,F|M_FLIPH
	WLW	4,w2drun3,F|M_FLIPH
	WLW	4,w2drun4,F|M_FLIPH
	WLW	4,w2drun5,F|M_FLIPH
	WLW	4,w2drun6,F|M_FLIPH
	WLW	4,w2drun7,F|M_FLIPH
	WLW	4,w2drun8,F|M_FLIPH
	W0


walkfdef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wfdef1_l,#wfdef2_l,#wfdef3_l,#wfdef4_l
	.long	#wfdef5_l,#wfdef6_l,#wfdef7_l,#wfdef8_l

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
#wfdef6_l
	WLW	4,w4defwd1,F|M_FLIPH
	WLW	4,w4defwd6,F|M_FLIPH
	WLW	4,w4defwd5,F|M_FLIPH
	WLW	4,w4defwd4,F|M_FLIPH
	WLW	4,w4defwd3,F|M_FLIPH
	WLW	4,w4defwd2,F|M_FLIPH
	W0
#wfdef7_l
	WLW	4,w3defwd1,F|M_FLIPH
	WLW	4,w3defwd6,F|M_FLIPH
	WLW	4,w3defwd5,F|M_FLIPH
	WLW	4,w3defwd4,F|M_FLIPH
	WLW	4,w3defwd3,F|M_FLIPH
	WLW	4,w3defwd2,F|M_FLIPH
	W0
#wfdef8_l
	WLW	4,w2defwd1,F|M_FLIPH
	WLW	4,w2defwd6,F|M_FLIPH
	WLW	4,w2defwd5,F|M_FLIPH
	WLW	4,w2defwd4,F|M_FLIPH
	WLW	4,w2defwd3,F|M_FLIPH
	WLW	4,w2defwd2,F|M_FLIPH
	W0


walkbdef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wbdef1_l,#wbdef2_l,#wbdef3_l,#wbdef4_l
	.long	#wbdef5_l,#wbdef6_l,#wbdef7_l,#wbdef8_l

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
#wbdef6_l
	WLW	4,w4defwd1,F|M_FLIPH
	WLW	4,w4defwd2,F|M_FLIPH
	WLW	4,w4defwd3,F|M_FLIPH
	WLW	4,w4defwd4,F|M_FLIPH
	WLW	4,w4defwd5,F|M_FLIPH
	WLW	4,w4defwd6,F|M_FLIPH
	W0
#wbdef7_l
	WLW	4,w3defwd1,F|M_FLIPH
	WLW	4,w3defwd2,F|M_FLIPH
	WLW	4,w3defwd3,F|M_FLIPH
	WLW	4,w3defwd4,F|M_FLIPH
	WLW	4,w3defwd5,F|M_FLIPH
	WLW	4,w3defwd6,F|M_FLIPH
	W0
#wbdef8_l
	WLW	4,w2defwd1,F|M_FLIPH
	WLW	4,w2defwd2,F|M_FLIPH
	WLW	4,w2defwd3,F|M_FLIPH
	WLW	4,w2defwd4,F|M_FLIPH
	WLW	4,w2defwd5,F|M_FLIPH
	WLW	4,w2defwd6,F|M_FLIPH
	W0


walkldef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wldef1_l,#wldef2_l,#wldef3_l,#wldef4_l
	.long	#wldef5_l,#wldef6_l,#wldef7_l,#wldef8_l

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
#wldef6_l
	WLW	4,w4dfcr1,F|M_FLIPH
	WLW	4,w4dfcr6,F|M_FLIPH
	WLW	4,w4dfcr5,F|M_FLIPH
	WLW	4,w4dfcr4,F|M_FLIPH
	WLW	4,w4dfcr3,F|M_FLIPH
	WLW	4,w4dfcr2,F|M_FLIPH
	W0
#wldef7_l
	WLW	4,w3dfcr1,F|M_FLIPH
	WLW	4,w3dfcr6,F|M_FLIPH
	WLW	4,w3dfcr5,F|M_FLIPH
	WLW	4,w3dfcr4,F|M_FLIPH
	WLW	4,w3dfcr3,F|M_FLIPH
	WLW	4,w3dfcr2,F|M_FLIPH
	W0
#wldef8_l
	WLW	4,w2dfcr1,F|M_FLIPH
;	WLW	4,w2dfcr6,F|M_FLIPH
	WLW	4,w2dfcr5,F|M_FLIPH
	WLW	4,w2dfcr4,F|M_FLIPH
	WLW	4,w2dfcr3,F|M_FLIPH
	WLW	4,w2dfcr2,F|M_FLIPH
	W0

walkrdef_t
	.word	WALK_M
	.long	seq_resetseq
	.long	#wrdef1_l,#wrdef2_l,#wrdef3_l,#wrdef4_l
	.long	#wrdef5_l,#wrdef6_l,#wrdef7_l,#wrdef8_l

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
#wrdef6_l
	WLW	4,w4dfcr1,F|M_FLIPH
	WLW	4,w4dfcr2,F|M_FLIPH
	WLW	4,w4dfcr3,F|M_FLIPH
	WLW	4,w4dfcr4,F|M_FLIPH
	WLW	4,w4dfcr5,F|M_FLIPH
	WLW	4,w4dfcr6,F|M_FLIPH
	W0
#wrdef7_l
	WLW	4,w3dfcr1,F|M_FLIPH
	WLW	4,w3dfcr2,F|M_FLIPH
	WLW	4,w3dfcr3,F|M_FLIPH
	WLW	4,w3dfcr4,F|M_FLIPH
	WLW	4,w3dfcr5,F|M_FLIPH
	WLW	4,w3dfcr6,F|M_FLIPH
	W0
#wrdef8_l
	WLW	4,w2dfcr1,F|M_FLIPH
	WLW	4,w2dfcr2,F|M_FLIPH
	WLW	4,w2dfcr3,F|M_FLIPH
	WLW	4,w2dfcr4,F|M_FLIPH
	WLW	4,w2dfcr5,F|M_FLIPH
;	WLW	4,w2dfcr6,F|M_FLIPH
	W0

block_t
	.word	JUMP_M
	.long	seq_stand
	.long	#block1_l,#block2_l,#block3_l,#block4_l
	.long	#block5_l,#block6_l,#block7_l,#block8_l

#block1_l
	WLW	3,w1js1,F
	WLW	3,w1js2,F
	WL	-1,seq_jump
	WLW	777,w1js3,F
	W0
#block2_l
	WLW	2,w2js1,F
	WLW	2,w2js2,F
	WLW	2,w2js3,F
	WL	-1,seq_jump
	WLW	777,w2js4,F
	W0
#block3_l
	WLW	2,w3js1,F
	WLW	2,w3js2,F
	WLW	2,w3js3,F
	WL	-1,seq_jump
	WLW	777,w3js4,F
	W0
#block4_l
	WLW	2,w4js1,F
	WLW	2,w4js2,F
	WLW	2,w4js3,F
	WL	-1,seq_jump
	WLW	777,w4js4,F
	W0
#block5_l
	WLW	2,w5js1,F
	WLW	2,w5js2,F
	WLW	2,w5js3,F
	WL	-1,seq_jump
	WLW	777,w5js4,F
	W0
#block6_l
	WLW	2,w4js1,F|M_FLIPH
	WLW	2,w4js2,F|M_FLIPH
	WLW	2,w4js3,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w4js4,F|M_FLIPH
	W0
#block7_l
	WLW	2,w3js1,F|M_FLIPH
	WLW	2,w3js2,F|M_FLIPH
	WLW	2,w3js3,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w3js4,F|M_FLIPH
	W0
#block8_l
	WLW	2,w2js1,F|M_FLIPH
	WLW	2,w2js2,F|M_FLIPH
	WLW	2,w2js3,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w2js4,F|M_FLIPH
	W0


blockdef_t
	.word	JUMP_M
	.long	seq_stand
	.long	#blockd1_l,#blockd2_l,#blockd3_l,#blockd4_l
	.long	#blockd5_l,#blockd6_l,#blockd7_l,#blockd8_l

#blockd1_l
	WLW	3,w1blok1,F
	WLW	3,w1blok2,F
	WL	-1,seq_jump
	WLW	777,w1blok3,F
	W0
#blockd2_l
	WLW	3,w2blok1,F
	WLW	3,w2blok2,F
	WL	-1,seq_jump
	WLW	777,w2blok3,F
	W0
#blockd3_l
	WLW	3,w3blok1,F
	WLW	3,w3blok2,F
	WL	-1,seq_jump
	WLW	777,w3blok3,F
	W0
#blockd4_l
	WLW	3,w4blok1,F
	WLW	3,w4blok2,F
	WL	-1,seq_jump
	WLW	777,w4blok3,F
	W0
#blockd5_l
	WLW	3,w5blok1,F
	WLW	3,w5blok2,F
	WL	-1,seq_jump
	WLW	777,w5blok3,F
	W0
#blockd6_l
	WLW	3,w4blok1,F|M_FLIPH
	WLW	3,w4blok2,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w4blok3,F|M_FLIPH
	W0
#blockd7_l
	WLW	3,w3blok1,F|M_FLIPH
	WLW	3,w3blok2,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w3blok3,F|M_FLIPH
	W0
#blockd8_l
	WLW	3,w2blok1,F|M_FLIPH
	WLW	3,w2blok2,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w2blok3,F|M_FLIPH
	W0


shootj_t
	.word	JUMP_M
	.long	0
	.long	#shootj1_l,#shootj2_l,#shootj3_l,#shootj4_l
	.long	#shootj5_l,#shootj6_l,#shootj7_l,#shootj8_l

#shootj1_l
	WLW	7,w1js1,F
	WLW	7,w1js2,F
	WL	-1,seq_jump
	WLW	777,w1js3,F
	W0
#shootj2_l
	WLW	5,w2js1,F
	WLW	5,w2js2,F
	WLW	5,w2js3,F
	WL	-1,seq_jump
	WLW	777,w2js4,F
	W0
#shootj3_l
	WLW	5,w3js1,F
	WLW	5,w3js2,F
	WLW	5,w3js3,F
	WL	-1,seq_jump
	WLW	777,w3js4,F
	W0
#shootj4_l
	WLW	5,w4js1,F
	WLW	5,w4js2,F
	WLW	5,w4js3,F
	WL	-1,seq_jump
	WLW	777,w4js4,F
	W0
#shootj5_l
	WLW	5,w5js1,F
	WLW	5,w5js2,F
	WLW	5,w5js3,F
	WL	-1,seq_jump
	WLW	777,w5js4,F
	W0
#shootj6_l
	WLW	5,w4js1,F|M_FLIPH
	WLW	5,w4js2,F|M_FLIPH
	WLW	5,w4js3,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w4js4,F|M_FLIPH
	W0
#shootj7_l
	WLW	5,w3js1,F|M_FLIPH
	WLW	5,w3js2,F|M_FLIPH
	WLW	5,w3js3,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w3js4,F|M_FLIPH
	W0
#shootj8_l
	WLW	5,w2js1,F|M_FLIPH
	WLW	5,w2js2,F|M_FLIPH
	WLW	5,w2js3,F|M_FLIPH
	WL	-1,seq_jump
	WLW	777,w2js4,F|M_FLIPH
	W0


shoot_t
	.word	JUMP_M
	.long	seq_shoot
	.long	#shoot1_l,#shoot2_l,#shoot3_l,#shoot4_l
	.long	#shoot5_l,#shoot6_l,#shoot7_l,#shoot8_l

#shoot1_l
	WLW	5,w1js4,F
	WLW	1,w1js5,F
	W0
#shoot2_l
	WLW	1,w2js5,F
	W0
#shoot3_l
	WLW	1,w3js5,F
	W0
#shoot4_l
	WLW	1,w4js5,F
	W0
#shoot5_l
	WLW	1,w5js5,F
	W0
#shoot6_l
	WLW	1,w4js5,F|M_FLIPH
	W0
#shoot7_l
	WLW	1,w3js5,F|M_FLIPH
	W0
#shoot8_l
	WLW	1,w2js5,F|M_FLIPH
	W0


shootl_t
	.word	JUMP_M
	.long	seq_stand
	.long	#shootl1_l,#shootl2_l,#shootl3_l,#shootl4_l
	.long	#shootl5_l,#shootl6_l,#shootl7_l,#shootl8_l

#shootl1_l
	WLW	777,w1js4,F
	WLW	4,w1js5,F
	WLW	4,w1js2,F
	WLW	3,w1js1,F
	W0
#shootl2_l
	WLW	777,w2js5,F
	WLW	3,w2js4,F
	WLW	3,w2js3,F
	WLW	3,w2js2,F
	WLW	2,w2js1,F
	W0
#shootl3_l
	WLW	777,w3js5,F
	WLW	3,w3js4,F
	WLW	3,w3js3,F
	WLW	3,w3js2,F
	WLW	2,w3js1,F
	W0
#shootl4_l
	WLW	777,w4js5,F
	WLW	3,w4js4,F
	WLW	3,w4js3,F
	WLW	3,w4js2,F
	WLW	2,w4js1,F
	W0
#shootl5_l
	WLW	777,w5js5,F
	WLW	3,w5js4,F
	WLW	3,w5js3,F
	WLW	3,w5js2,F
	WLW	2,w5js1,F
	W0
#shootl6_l
	WLW	777,w4js5,F|M_FLIPH
	WLW	3,w4js4,F|M_FLIPH
	WLW	3,w4js3,F|M_FLIPH
	WLW	3,w4js2,F|M_FLIPH
	WLW	2,w4js1,F|M_FLIPH
	W0
#shootl7_l
	WLW	777,w3js5,F|M_FLIPH
	WLW	3,w3js4,F|M_FLIPH
	WLW	3,w3js3,F|M_FLIPH
	WLW	3,w3js2,F|M_FLIPH
	WLW	2,w3js1,F|M_FLIPH
	W0
#shootl8_l
	WLW	777,w2js5,F|M_FLIPH
	WLW	3,w2js4,F|M_FLIPH
	WLW	3,w2js3,F|M_FLIPH
	WLW	3,w2js2,F|M_FLIPH
	WLW	2,w2js1,F|M_FLIPH
	W0


passs_t
	.word	0
	.long	seq_stand
	.long	#passs1_l,#passs2_l,#passs3_l,#passs4_l
	.long	#passs5_l,#passs6_l,#passs7_l,#passs8_l

#passs1_l
	WLW	4,w1cp1,F
	WLW	4,w1cp2,F
	WL	-1,plyr_pass
	WLW	4,w1cp1,F
	W0
#passs2_l
	WLW	4,w2cp1,F
	WLW	4,w2cp2,F
	WL	-1,plyr_pass
	WLW	4,w2cp1,F
	W0
#passs3_l
	WLW	4,w3cp1,F
	WLW	4,w3cp2,F
	WL	-1,plyr_pass
	WLW	4,w3cp1,F
	W0
#passs4_l
	WLW	4,w4cp1,F
	WLW	4,w4cp2,F
	WL	-1,plyr_pass
	WLW	4,w4cp1,F
	W0
#passs5_l
	WLW	4,w5cp1,F
	WLW	4,w5cp2,F
	WL	-1,plyr_pass
	WLW	4,w5cp1,F
	W0
#passs6_l
	WLW	4,w4cp1,F|M_FLIPH
	WLW	4,w4cp2,F|M_FLIPH
	WL	-1,plyr_pass
	WLW	4,w4cp1,F|M_FLIPH
	W0
#passs7_l
	WLW	4,w3cp1,F|M_FLIPH
	WLW	4,w3cp2,F|M_FLIPH
	WL	-1,plyr_pass
	WLW	4,w3cp1,F|M_FLIPH
	W0
#passs8_l
	WLW	4,w2cp1,F|M_FLIPH
	WLW	4,w2cp2,F|M_FLIPH
	WL	-1,plyr_pass
	WLW	4,w2cp1,F|M_FLIPH
	W0

passc_t
	.word	0
	.long	seq_stand
	.long	#passc1_l,#passc2_l,#passc3_l,#passc4_l
	.long	#passc5_l,#passc6_l,#passc7_l,#passc8_l

#passc1_l
	WLW	5,w1cp1,F
	WLW	5,w1cp2,F
	WLW	5,w1cp3,F
	WL	-1,plyr_pass
	WLW	5,w1cp4,F
	WLW	4,w1cp3,F
	WLW	4,w1cp1,F
	W0
#passc2_l
	WLW	5,w2cp1,F
	WLW	5,w2cp2,F
	WLW	5,w2cp3,F
	WL	-1,plyr_pass
	WLW	5,w2cp4,F
	WLW	4,w2cp3,F
	WLW	4,w2cp1,F
	W0
#passc3_l
	WLW	5,w3cp1,F
	WLW	5,w3cp2,F
	WLW	5,w3cp3,F
	WL	-1,plyr_pass
	WLW	5,w3cp4,F
	WLW	4,w3cp3,F
	WLW	4,w3cp1,F
	W0
#passc4_l
	WLW	5,w4cp1,F
	WLW	5,w4cp2,F
	WLW	5,w4cp3,F
	WL	-1,plyr_pass
	WLW	5,w4cp4,F
	WLW	4,w4cp3,F
	WLW	4,w4cp1,F
	W0
#passc5_l
	WLW	5,w5cp1,F
	WLW	5,w5cp2,F
	WLW	5,w5cp3,F
	WL	-1,plyr_pass
	WLW	5,w5cp4,F
	WLW	4,w5cp3,F
	WLW	4,w5cp1,F
	W0
#passc6_l
	WLW	5,w4cp1,F|M_FLIPH
	WLW	5,w4cp2,F|M_FLIPH
	WLW	5,w4cp3,F|M_FLIPH
	WL	-1,plyr_pass
	WLW	5,w4cp4,F|M_FLIPH
	WLW	4,w4cp3,F|M_FLIPH
	WLW	4,w4cp1,F|M_FLIPH
	W0
#passc7_l
	WLW	5,w3cp1,F|M_FLIPH
	WLW	5,w3cp2,F|M_FLIPH
	WLW	5,w3cp3,F|M_FLIPH
	WL	-1,plyr_pass
	WLW	5,w3cp4,F|M_FLIPH
	WLW	4,w3cp3,F|M_FLIPH
	WLW	4,w3cp1,F|M_FLIPH
	W0
#passc8_l
	WLW	5,w2cp1,F|M_FLIPH
	WLW	5,w2cp2,F|M_FLIPH
	WLW	5,w2cp3,F|M_FLIPH
	WL	-1,plyr_pass
	WLW	5,w2cp4,F|M_FLIPH
	WLW	4,w2cp3,F|M_FLIPH
	WLW	4,w2cp1,F|M_FLIPH
	W0

steal_t
	.word	NOMV_M
	.long	seq_stand
	.long	#steal1_l,#steal2_l,#steal3_l,#steal4_l
	.long	#steal5_l,#steal6_l,#steal7_l,#steal8_l
#steal1_l
;	WLW	5,w1stel1,F
;	WLW	5,w1stel2,F
;	WLW	5,w1stel3,F
;	WLW	5,w1stel4,F
;	W0
#steal2_l
	WLW	5,w2stel1,F
	WLW	5,w2stel2,F
	WLW	5,w2stel3,F
	WLW	5,w2stel4,F
	W0
#steal3_l
	WLW	5,w3stel1,F
	WLW	5,w3stel2,F
	WLW	5,w3stel3,F
	WLW	5,w3stel4,F
	W0
#steal4_l
	WLW	5,w4stel1,F
	WLW	5,w4stel2,F
	WLW	5,w4stel3,F
	WLW	5,w4stel4,F
	W0
#steal5_l
	WLW	5,w5stel1,F
	WLW	5,w5stel2,F
	WLW	5,w5stel3,F
;	WLW	5,w5stel4,F
	W0
#steal6_l
	WLW	5,w4stel1,F|M_FLIPH
	WLW	5,w4stel2,F|M_FLIPH
	WLW	5,w4stel3,F|M_FLIPH
	WLW	5,w4stel4,F|M_FLIPH
	W0
#steal7_l
	WLW	5,w3stel1,F|M_FLIPH
	WLW	5,w3stel2,F|M_FLIPH
	WLW	5,w3stel3,F|M_FLIPH
	WLW	5,w3stel4,F|M_FLIPH
	W0
#steal8_l
	WLW	5,w2stel1,F|M_FLIPH
	WLW	5,w2stel2,F|M_FLIPH
	WLW	5,w2stel3,F|M_FLIPH
	WLW	5,w2stel4,F|M_FLIPH
	W0


dunkspin13_t
	.word	DUNK_M|JUMP_M
	.long	seq_stand
	.long	#ds1_l,#ds3_l,#ds3_l,#ds3_l
	.long	#ds3_l,#ds3f_l,#ds3f_l,#ds3f_l

#ds1_l
	WLW	4,w1spdu1,F
	WLLW	-1,seq_strtdunk,w1spdu9,42+1
	WLW	6,w1spdu2,F
	WLW	6,w1spdu3,F
	WLW	6,w1spdu4,F
	WLW	6,w1spdu5,F
	WLW	6,w1spdu6,F
	WLW	6,w1spdu7,F
	WLW	6,w1spdu8,F
	WLW	1,w1spdu9,F
	WL	-1,seq_slamball
	WLW	30,w1spdu9,F
	WLW	4,w1spdu10,F
	WLW	4,w1spdu11,F
	WLW	77,w1js4,F
	WLW	4,w1js5,F
	WLW	4,w1js2,F
	WLW	3,w1js1,F
	W0
#ds3_l
	WLW	4,w3spdu1,F
	WLLW	-1,seq_strtdunk,w3spdu7,35+1
	WLW	7,w3spdu2,F
	WLW	7,w3spdu3,F
	WLW	7,w3spdu4,F
	WLW	7,w3spdu5,F
	WLW	7,w3spdu6,F
	WLW	1,w3spdu7,F
	WL	-1,seq_slamball
	WLW	30,w3spdu7,F
	WLW	4,w3spdu8,F
	WLW	4,w3spdu9,F
	WLW	4,w3spdu10,F
	WLW	77,w3js5,F
	WLW	3,w3js4,F
	WLW	3,w3js3,F
	WLW	3,w3js2,F
	WLW	2,w3js1,F
	W0
#ds3f_l
	WLW	4,w3spdu1,F|M_FLIPH
	WLLW	-1,seq_strtdunk,w3spdu7,35+1
	WLW	7,w3spdu2,F|M_FLIPH
	WLW	7,w3spdu3,F|M_FLIPH
	WLW	7,w3spdu4,F|M_FLIPH
	WLW	7,w3spdu5,F|M_FLIPH
	WLW	7,w3spdu6,F|M_FLIPH
	WLW	1,w3spdu7,F|M_FLIPH
	WL	-1,seq_slamball
	WLW	30,w3spdu7,F|M_FLIPH
	WLW	4,w3spdu8,F|M_FLIPH
	WLW	4,w3spdu9,F|M_FLIPH
	WLW	4,w3spdu10,F|M_FLIPH
	WLW	77,w3js5,F|M_FLIPH
	WLW	3,w3js4,F|M_FLIPH
	WLW	3,w3js3,F|M_FLIPH
	WLW	3,w3js2,F|M_FLIPH
	WLW	2,w3js1,F|M_FLIPH
	W0


dunk2h3_t
	.word	DUNK_M|JUMP_M
	.long	seq_stand
	.long	#d2h3_l,#d2h3_l,#d2h3_l,#d2h3_l
	.long	#d2h3_l,#d2h3f_l,#d2h3f_l,#d2h3f_l

#d2h3_l
	WLW	5,w3twdu1,F
	WLLW	-1,seq_strtdunk,w3twdu7,36
	WLW	7,w3twdu2,F
	WLW	7,w3twdu3,F
	WLW	7,w3twdu4,F
	WLW	7,w3twdu5,F
	WLW	7,w3twdu6,F
	WLW	1,w3twdu7,F
	WL	-1,seq_slamball
	WLW	30,w3twdu7,F
	WLW	5,w3twdu8,F
	WLW	77,w3js5,F
	WLW	3,w3js4,F
	WLW	3,w3js3,F
	WLW	3,w3js2,F
	WLW	2,w3js1,F
	W0
#d2h3f_l
	WLW	5,w3twdu1,F|M_FLIPH
	WLLW	-1,seq_strtdunk,w3twdu7,36
	WLW	7,w3twdu2,F|M_FLIPH
	WLW	7,w3twdu3,F|M_FLIPH
	WLW	7,w3twdu4,F|M_FLIPH
	WLW	7,w3twdu5,F|M_FLIPH
	WLW	7,w3twdu6,F|M_FLIPH
	WLW	1,w3twdu7,F|M_FLIPH
	WL	-1,seq_slamball
	WLW	30,w3twdu7,F|M_FLIPH
	WLW	5,w3twdu8,F|M_FLIPH
	WLW	77,w3js5,F|M_FLIPH
	WLW	3,w3js4,F|M_FLIPH
	WLW	3,w3js3,F|M_FLIPH
	WLW	3,w3js2,F|M_FLIPH
	WLW	2,w3js1,F|M_FLIPH
	W0


********************************
* Sequence - stand

 SUBRP	seq_stand

	clr	a0
	move	a0,*a13(plyr_nojoy)

	movi	STND_SEQ,a0		;Set stand sequence
	callr	plyr_setseq

	rets

#*******************************
* Sequence - reset seq, in case dir changed

 SUBRP	seq_resetseq

	clr	a0
	move	a0,*a13(plyr_nojoy)

	move	*a13(plyr_seq),a0
	move	a6,a1
	sll	32-4,a1
	jrnz	#set			;Pushing joy?

	movk	STNDDEF_SEQ,a0		;>Setup stand sequence
	move	*a13(plyr_ownball),a14
	jrle	#set
	movk	STNDDRIBDEF_SEQ,a1

#set	jruc	plyr_setseq


#*******************************
* Sequence - jump

 SUBRP	seq_jump

	btst	4,a6			;But1 (Shoot/block)
	jrz	seq_stand		;Fake?

	movk	1,a0			;Start jump
	move	a0,*a13(plyr_jmpcnt)

	move	*a8(OXVEL),a2,L		;>1/4 vel
	move	*a8(OZVEL),a3,L
	sra	1,a2
	sra	1,a3

	move	*a13(plyr_seq),a0
	cmpi	BLOCK_SEQ,a0
	jreq	#blk
	cmpi	BLOCKDEF_SEQ,a0
	jreq	#blk

	sra	1,a2
	sra	1,a3

#blk	move	a2,*a8(OXVEL),L
	move	a3,*a8(OZVEL),L

	movi	->38000,a0
	move	a0,*a8(OYVEL),L

	rets


#*******************************
* Sequence - start dunk jump
* B4=*Next data in seq list

 SUBRP	seq_strtdunk

	move	*b4+,b0,L
	move	b0,a2			;*Slam img

	move	*b4+,b0
	move	b0,a4			;#ticks till we reach rim

	movk	1,a0			;Start jump
	move	a0,*a13(plyr_jmpcnt)


	move	*a13(plyr_ohoopx),a3

	move	*a2(IANIOFFX),a0
	move	*a2(IANI2X),a14
	sub	a14,a0

	move	*b4(16+32),b0		;Next seq flags
	move	b0,a14
	btst	B_FLIPH,a14
	jrz	#nof			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a0
	add	a2,a0			;+size
#nof
	add	a0,a3

;	move	@ballobj_p,a0,L

;	move	*a8(OIMG),a2,L


	move	*a8(OXPOS),a1
	move	*a8(OXANI+16),a14
	add	a14,a1
	sub	a1,a3			;X delta

	movi	CZMID,a5
	move	*a8(OZPOS),a1
	sub	a1,a5			;Y delta

;	move	a3,a4			;>Calc distance
;	abs	a4
;	move	a5,a14
;	abs	a14
;	cmp	a14,a4
;	jrhs	#big
;	move	a14,a4
;#big
;	cmpi	100,a4
;	jrls	#distok
;	movi	100,a4
;#distok
;	move	a4,a1
;	srl	2,a1			;/4
;	sub	a1,a4
;	jrgt	#divok
;	movk	1,a4
;#divok
	sll	16,a3
	sll	16,a5
	divs	a4,a3
	divs	a4,a5

	move	a3,*a8(OXVEL),L
	move	a5,*a8(OZVEL),L

	movi	-GRAV/2,a1
	mpys	a4,a1
	move	*a8(OYVAL),a3,L		;Adjust for hgt difference
	subi	(HOOPY+12)<<16,a3	;- if above
	divs	a4,a3
	sub	a3,a1
	move	a1,*a8(OYVEL),L


	rets



#*******************************
* Sequence - slam ball through hoop (dunk)
* B4=*Next data in seq list

 SUBRP	seq_slamball

	move	@ballobj_p,a0,L

	move	*a0(OIMG),a1,L		;>Convert ball from player relative
	move	*a1(IANIOFFX),a1
	sll	16,a1
	move	*a0(OXANI),a14,L
	move	a1,*a0(OXANI),L
	sub	a14,a1			;Ani difference

	sra	16-5,a1
	move	*a0(OZPOS),a2		;894 to 1379 (Z range 486)
	addi	(819-GZBASE),a2		;768 to ?
	mpys	a2,a1
	move	a1,a3
	sra	2,a3			;/4
	sub	a3,a1
	sra	1,a3			;/2
	sub	a3,a1
	sra	14+1,a1			;/16k /2

	move	*a0(OXPOS),a14		;Adjust X
	sub	a1,a14
	move	a14,*a0(OXPOS)


	move	*a13(plyr_ohoopx),a14	;FIX
	subk	6,a14
	move	a14,*a0(OXPOS)
	movi	HOOPY-8,a14
	move	a14,*a0(OYPOS)
	movi	CZMID,a14
	move	a14,*a0(OZPOS)

	clr	a1
	move	a1,*a0(OXVEL),L
	move	a1,*a0(OZVEL),L
	movi	GRAVB*8,a1
	move	a1,*a0(OYVEL),L


	clr	a1
	move	a1,*a8(OXVEL),L
	move	a1,*a8(OZVEL),L
	move	a1,*a8(OYVEL),L


	move	@ballpnum,@ballpnumlast
	movi	-1,a0
	move	a0,@ballpnum		;No owner
	clr	a0
	move	a0,@ballscorezhit
	move	a0,*a13(plyr_ownball)
	movk	30,a0
	move	a0,*a13(plyr_shtdly)

	move	*b4,b0
	move	b0,a0			;#ticks we hang
	move	a0,*a13(plyr_hangcnt)


	rets



********************************
* Sequence - stand

 SUBRP	seq_shoot

	clr	a0
	clr	a1
	clr	a2
	callr	plyr_shoot

	movi	SHOOTL_SEQ,a0
	callr	plyr_setseq

	rets


********************************
* Setup player sequence data
* A0=Sequence #
* A7=Dir 0-127
* A13=*Player process
* >A10=New ani cnt
* Trashes scratch

 SUBRP	plyr_setseq

	move	a0,*a13(plyr_seq)

	sll	5,a0			;*32
	addi	pseq_t,a0
	move	*a0,a0,L
	move	*a0+,a1			;Get flags
	move	a1,*a13(plyr_seqflgs)

;	btst	DUNK_B,a1
;	jrz	#nodunk
;	move	*a0+,a1,L		;Get *last dunk img
;#nodunk
	move	*a0+,a1,L		;Get *code
	move	a1,*a13(plyr_seqcode_p),L
	move	a7,a1			;Dir
	addk	8,a1			;Round off
	srl	4,a1
	move	a1,*a13(plyr_seqdir)
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

 SUBRP	plyr_del

	PUSH	a2,a3

	move	a0,a2
	move	a0,a3
	sll	5,a3		;*32
	addi	pdel_t,a3

	move	*a3+,a0
	calla	KIL1C		;Kill process

	move	*a3+,a0
	calla	obj_del1c	;Kill plyr images

	clr	a0
	sll	5,a2		;*32
	movi	plyrobj_t,a1
	add	a2,a1
	move	a0,*a1,L

	addi	plyrproc_t,a2
	move	a0,*a2,L

	PULL	a2,a3
	rets


pdel_t	.word	P1_PID,CLSPLYR|TYPPLYR|SUBPL1
	.word	P2_PID,CLSPLYR|TYPPLYR|SUBPL2
	.word	P3_PID,CLSPLYR|TYPPLYR|SUBPL3
	.word	P4_PID,CLSPLYR|TYPPLYR|SUBPL4




#*******************************
* Update player controls (Process)

 SUBR	joy_read

#lp	move	@GAMSTATE,a0
	cmpi	INGAME,a0
	jrne	#slp
	move	@HALT,a0
	jrnz	#slp

	.if	TUNIT

	move	@PSTATUS,a0		;Plyr start bits 0-3

	move	@SWITCH,a5
	not	a5

	srl	1,a0
	jrnc	#nop1
	movb	a5,@P1CTRL

#nop1
	srl	1,a0
	jrnc	#nop2
	srl	8,a5
	movb	a5,@P2CTRL

#nop2
	move	@SWITCH2,a5
	not	a5

	srl	1,a0
	jrnc	#nop3
	movb	a5,@P3CTRL

#nop3	srl	1,a0
	jrnc	#slp
	srl	8,a5
	movb	a5,@P4CTRL

	.else

	move	@SWITCH,a5,L
	not	a5
	move	@PSTATUS,a0		;Plyr start bits 0-3

	srl	1,a0
	jrnc	#nop1
	movb	a5,@P1CTRL

#nop1	srl	8,a5
	srl	1,a0
	jrnc	#nop2
	movb	a5,@P2CTRL

#nop2	srl	1,a0
	jrnc	#nop3
	srl	16,a5
	move	a5,a1			;>Move bit 7 to 6 (But 3)
	sll	32-6,a5
	srl	7,a1
	or	a1,a5
	rl	6,a5
	movb	a5,@P3CTRL

#nop3	srl	1,a0
	jrnc	#slp
	move	@SWITCH+>20,a6
	not	a6
	movb	a6,@P4CTRL

	.endif

#slp	SLEEPK	1
	jruc	#lp



#*******************************
* Check for collision with other players
* A8=*Obj
* A13=*Player process
* Trashes scratch

 SUBRP	plyr_chkpcollide

	PUSH	a2,a3,a4,a5,a6,a7,a9

	movk	4,b1
	move	*a8(OXPOS),a4
	move	*a8(OXANI+16),a14
	add	a14,a4
	move	a4,a5
	move	*a8(OSIZEX),a14
	srl	1,a14			;/2
	sub	a14,a4			;A4=Box left
	add	a14,a5			;A5=Box rgt
	move	*a8(OZPOS),a6		;A6=Z
	movi	plyrobj_t,a7

#lp	move	*a7+,a0,L
	cmp	a0,a8
	jreq	#next

	move	*a0(OZPOS),a2		;>Chk Z
	sub	a6,a2
	abs	a2
	subk	18,a2
	jrge	#next

	move	*a0(OXPOS),a1		;>Chk box X
	move	*a0(OXANI+16),a14
	add	a14,a1
	move	*a0(OSIZEX),a14
	srl	2,a14			;/4
	sub	a14,a1
	cmp	a1,a5
	jrle	#next			;Rgt edge <= lft?
	add	a14,a1
	add	a14,a1
	cmp	a1,a4
	jrge	#next			;Lft edge >= rgt?


	movi	>2000,a9		;>Outer box collision

	sub	a14,a1
	move	*a8(OXANI+16),a14
	add	a4,a14
	sub	a14,a1			;Other CX - Plyr CX
	move	*a8(OXVAL),a14,L
	abs	a1
	jrn	#decx
	add	a9,a14
	jruc	#setx
#decx	sub	a9,a14
#setx	move	a14,*a8(OXVAL),L


	move	*a0(OZPOS),a2		;>Chk Z
	sub	a6,a2
	move	*a8(OZVAL),a14,L
	abs	a2
	jrn	#decz
	add	a9,a14
	jruc	#setz
#decz	sub	a9,a14
#setz	move	a14,*a8(OZVAL),L


	subk	15,a1			;X
	jrge	#x
	subk	16,a2			;Z
	jrge	#x

					;>Inner box collision
	move	*a8(OXVEL),a14,L
	move	*a0(OXVEL),a2,L
	move	a2,a3
	xor	a14,a2
	move	a2,a2
	jrn	#xvdif			;XV different dir?
	move	a14,a9
	abs	a3
	abs	a9
	cmp	a3,a9
	jrlt	#skipxv			;My vel smaller?
	xor	a14,a2			;Fix A2
	sub	a2,a14
#xvdif
	move	*a8(OXVAL),a1,L
	sub	a14,a1
	move	a1,*a8(OXVAL),L
#skipxv
	move	*a8(OZVEL),a14,L
	move	*a0(OZVEL),a2,L
	move	a2,a3
	xor	a14,a2
	move	a2,a2
	jrn	#zvdif			;ZV different dir?
	move	a14,a9
	abs	a3
	abs	a9
	cmp	a3,a9
	jrlt	#x			;My vel smaller?
	xor	a14,a2			;Fix A2
	sub	a2,a14
#zvdif
	move	*a8(OZVAL),a1,L
	sub	a14,a1
	move	a1,*a8(OZVAL),L
	jruc	#x

#next	dsj	b1,#lp

#x	PULL	a2,a3,a4,a5,a6,a7,a9
	rets


#*******************************
* Change the players image
* A0=*New image
* A1=New flip flags
* A8=*Obj
* A13=*Plyr process
* Trashes scratch

 SUBRP	plyr_ani


	PUSH	a2,a3

	cmpi	ROM,a0
	jrlo	#anierr

	move	a0,a2
	move	a1,a3

	callr	anipt_getsclxy

	setf	6,0,0
	move	a3,*a8(OCTRL)		;Write 6 low bits
	setf	16,1,0

	move	a2,*a8(OIMG),L
	move	*a2,a14,L
	move	a14,*a8(OSIZE),L
	move	*a2(ISAG),*a8(OSAG),L

	move	*a13(plyr_attrib_p),a14,L
	move	*a14,a14,L		;Get *scale_t
	move	*a2(IFLAGS),a2
	jrnn	#small			;Bit15 = Scale
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

#x	PULL	a2,a3
	rets

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

	move	*a8(OZPOS),a1		;Get SZ
	subi	CZMID,a1
	abs	a1
	subi	40,a1
	jrge	#jmpok
	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	subi	WRLDMID,a0
	abs	a0
	subi	HOOPRX-WRLDMID+13,a0
	jrge	#x			;Under backboard?

#jmpok
	movk	1,a0
	move	a0,*a13(plyr_nojoy)

	move	*a13(plyr_ownball),a14
	jrle	#blk			;No ball?

	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128

	move	a0,*a13(plyr_newdir)	;Turn toward basket


	cmpi	100,a1
	jrge	#sj			;Shoot?

					;>Try a dunk

	move	*a13(plyr_o1dir),a2
	sub	a0,a2
	abs	a2
	subk	16,a2
	jrge	#o1dok			;Not in front of me?
	move	*a13(plyr_o1dist),a3
	cmp	a1,a3
	jrlt	#sj			;Between me and basket?
#o1dok
	move	*a13(plyr_o2dir),a2
	sub	a0,a2
	abs	a2
	subk	16,a2
	jrge	#o2dok			;Not in front of me?
	move	*a13(plyr_o2dist),a3
	cmp	a1,a3
	jrlt	#sj			;Between me and basket?
#o2dok

	addk	8,a0			;Round off
	srl	4,a0			;Kill frac
	sll	5,a0			;*32
	addi	#dunk_t,a0
	move	*a0,a2,L
	move	*a2+,a0			;#Entries-1
	calla	RNDRNG0
	sll	4,a0			;*16
	add	a2,a0
	move	*a0,a0
	jruc	#sseq


#sj	movk	SHOOTJ_SEQ,a0
	jruc	#sseq


#blk	movk	BLOCKDEF_SEQ,a0
#sseq	move	*a13(plyr_dir),a7
	callr	plyr_setseq


#x	PULL	a6,a7
	rets


#dunk_t	.long	#d1_t,#d2_t,#d3_t,#d4_t,#d5_t,#d4_t,#d3_t,#d2_t, #d1_t

#d1_t	.word	1-1,DUNKSPIN13_SEQ
#d2_t	.word	2-1,DUNKSPIN13_SEQ,DUNK2H3_SEQ
#d3_t	.word	2-1,DUNKSPIN13_SEQ,DUNK2H3_SEQ
#d4_t	.word	2-1,DUNKSPIN13_SEQ,DUNK2H3_SEQ
#d5_t	.word	1-1,DUNKSPIN13_SEQ



#*******************************
* Player takes a shot
* A0=X rim offset
* A1=Y rim offset
* A2=Z rim offset
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	plyr_shoot

	move	a7,b0

	movk	1,a0
	callr	rnd
	jrnz	#athoop
	movi	-10,a0
	movi	-30,a1
	clr	a2
	jruc	#atbbrd

#athoop	clr	a0
	clr	a1
	clr	a2
#atbbrd

	move	@ballobj_p,a7,L


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

	move	*a7(OXVAL),a14,L	;Adjust X
	sub	a3,a14
	move	a14,*a7(OXVAL),L


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

	move	a3,a4			;>Calc distance
	abs	a4
	move	a5,a14
	abs	a14
	cmp	a14,a4
	jrhs	#xbig
	move	a14,a4
#xbig
	cmpi	180,a4
	jrls	#distok
	movi	180,a4
#distok
	move	a4,a1
	srl	1,a1			;/2
	sub	a1,a4
	jrgt	#divok
	movk	1,a4
#divok	sll	16,a3
	sll	16,a5
	divs	a4,a3
	divs	a4,a5

	move	*a8(OXVEL),a1,L
	sra	3,a1			;/8
	add	a1,a3
	move	a3,*a7(OXVEL),L
	move	*a8(OZVEL),a1,L
	sra	3,a1			;/8
	add	a1,a5
	move	a5,*a7(OZVEL),L

	movi	-GRAVB/2,a1
	mpys	a4,a1
	move	*a7(OYVAL),a3,L		;Adjust for hgt difference
	addi	HOOPY-7,a2
	sll	16,a2
	sub	a2,a3			;- if above
	divs	a4,a3
	sub	a3,a1
	move	a1,*a7(OYVEL),L

	move	@ballpnum,@ballpnumlast
	movi	-1,a0
	move	a0,@ballpnum		;No owner
	clr	a0
	move	a0,@ballscorezhit
	move	a0,*a13(plyr_ownball)
	movk	20,a0
	move	a0,*a13(plyr_shtdly)

;ZZZ
	rets
	move	@ballobj_p,a0,L		;DEBUG
	clr	a1
	move	a1,*a0(OXVEL),L
	move	a1,*a0(OZVEL),L
	move	a1,*a0(OYVEL),L
	move	a1,*a8(OXVEL),L
	move	a1,*a8(OZVEL),L


	move	b0,a7
	rets


#*******************************
* Start player pass to teammate
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	plyr_startpass

	move	*a13(plyr_num),a14	;>Get teammates obj
	movk	1,a2
	xor	a2,a14
	sll	5,a14			;*32
	addi	plyrobj_t,a14
	move	*a14,a2,L
	.if	DEBUG
	jrz	#x
	.endif

	PUSH	a6,a7			;>Turn toward teammate
	move	*a2(OXPOS),a6
	move	*a2(OXANI+16),a14
	add	a14,a6
	move	*a2(OZPOS),a7
	callr	seekdir_obxz128
	move	a0,*a13(plyr_newdir)

	move	*a8(OXPOS),a1		;>Calc distance
	move	*a8(OXANI+16),a14
	add	a14,a1
	move	*a8(OZPOS),a14
	sub	a1,a6
	sub	a14,a7
	abs	a6
	abs	a7
	cmp	a7,a6
	jrge	#big
	move	a7,a6
#big
	movi	PASSS_SEQ,a0
	cmpi	200,a6
	jrle	#short
	movi	PASSC_SEQ,a0
#short	PULL	a6,a7
	callr	plyr_setseq

	movk	1,a0
	move	a0,*a13(plyr_nojoy)


#x	rets


#*******************************
* Player passes to teammate
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	plyr_pass

	move	@ballobj_p,a0,L

	move	*a0(OIMG),a1,L		;>Convert ball from player relative
	move	*a1(IANIOFFX),a1
	sll	16,a1
	move	a1,*a0(OXANI),L


	move	*a13(plyr_num),a14	;>Get teammates obj
	movk	1,a2
	xor	a2,a14
	sll	5,a14			;*32
	addi	plyrobj_t,a14
	move	*a14,a2,L

	move	*a2(OXPOS),a3
	move	*a2(OXANI+16),a14
	add	a14,a3
	move	*a2(OXVEL),a1,L
	sra	14,a1			;*4
	add	a1,a3
	move	*a2(OZPOS),a5
	move	*a2(OZVEL),a1,L
	sra	14,a1			;*4
	add	a1,a5

	move	*a0(OXPOS),a1
	move	*a0(OXANI+16),a14
	add	a14,a1
	sub	a1,a3			;X delta
	move	*a0(OZPOS),a1
	sub	a1,a5			;Y delta
	move	a3,a4			;>Calc distance
	abs	a4
	move	a5,a14
	abs	a14
	cmp	a14,a4
	jrhs	#big
	move	a14,a4
#big
	srl	3,a4			;/8
	jrgt	#divok
	movk	1,a4
#divok	sll	16,a3
	sll	16,a5
	divs	a4,a3
	divs	a4,a5

	move	*a8(OXVEL),a1,L
	sra	3,a1			;/8
	add	a1,a3
	move	a3,*a0(OXVEL),L
	move	*a8(OZVEL),a1,L
	sra	3,a1			;/8
	add	a1,a5
	move	a5,*a0(OZVEL),L

	movi	-GRAVB/2,a1
	mpys	a4,a1
	addk	1,a1
	move	*a0(OYVAL),a3,L		;Adjust for hgt difference
	move	*a2(OYVAL),a14,L
	sra	1,a14			;/2
	sub	a14,a3			;- if above
	divs	a4,a3
	sub	a3,a1
	move	a1,*a0(OYVEL),L

	move	@ballpnum,@ballpnumlast
	movi	-1,a0
	move	a0,@ballpnum		;No owner
	clr	a0
	move	a0,*a13(plyr_ownball)
	movk	30,a0
	move	a0,*a13(plyr_shtdly)

#x	rets


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
	clr	a0
	move	a0,@ballfree		;!Free

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
	movi	->e00,a14		;Push it towards gnd
	mpys	a14,a1
	addi	>30000,a1
	move	a1,*a0(OYVEL),L
#x	rets


#*******************************
* Ball main code (Process)

	STRUCTPD
	WORD	ball_anix	;X anipt offset
	WORD	ball_aniy	;Y ^
	APTR	ball_ani1st_p	;*1st ani_l pos
	APTR	ball_ani_p	;*Current ani_l pos
	WORD	ball_zsznum	;Z size # 0-?
	WORD	ball_colllast	;!0=Had rim collision last frame
	WORD	ball_collcnt	;# of collisions in a row


 SUBR	ball_main

	move	@WORLDTLX+16,a0
	addi	200,a0
	sll	16,a0
	movi	[-100,0],a1		;In air
	movi	ball11,a2
	movi	CZMID,a3
	movi	DMAWNZ|M_3D|M_NOSCALE,a4
	movi	CLSENMY|TYPBALL,a5
	clr	a6
	movi	>4001,a7
	calla	BEGINOBJ2
	move	a8,@ballobj_p,L
	callr	ball_getshadow

	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast
	move	a0,*a13(ball_zsznum)
	movk	1,a0
	move	a0,@ballfree		;Free

	move	*a8(OIMG),a0,L
	move	*a0(IANIOFFX),*a13(ball_anix)

	movk	1,a10			;A10=Anim cntdn

#lp
	move	@HALT,a0
	jrnz	#halted

	move	*a8(OXPOS),a6
	move	*a13(ball_anix),a14
	add	a14,a6

	move	*a8(OXVEL),a1,L
	jrge	#xvpos

	cmpi	WRLDMID-350,a6
	jrge	#xok
	jruc	#badx

#xvpos	cmpi	WRLDMID+350,a6
	jrlt	#xok

#badx	clr	a1
	move	a1,*a8(OXVEL),L
#xok

	move	@ballpnum,a14
	jrge	#pl			;Plyr has me?
	callr	ball_bbcollision


	move	a6,a0
#pl	move	@ballpnum,a14
	jrn	#nop			;Free from plyr?
	sll	5,a14
	addi	plyrobj_t,a14
	move	*a14,a14,L
	move	*a14(OXPOS),a0
	move	*a14(OXANI+16),a1
	add	a1,a0


#nop	move	@WORLDTLX+16,a1		;>Scroll world view
	move	a1,a2
	addi	200,a2
	move	a2,a3
	subk	20,a2
	sub	a0,a2
	jrle	#v20
	cmpi	WRLDMID-200-260-50,a1
	jrlt	#noset
	subk	1,a1
	srl	3,a2
	sub	a2,a1
#v20
	addk	20,a3
	sub	a0,a3
	jrge	#v50
	cmpi	WRLDMID-200+260+50,a1
	jrgt	#noset
	addk	1,a1
	abs	a3
	srl	3,a3
	add	a3,a1

#v50	move	a1,@WORLDTLX+16
	subi	WRLDMID-200,a1
	move	a1,@gndx+16

#noset
	move	*a8(OZPOS),a14		;>Set world Y
	subi	GZBASE,a14		;-Base
	jrge	#zok2
	clr	a14
#zok2	move	a14,a2
	sra	1,a14			;Z/2
	sra	3,a2			;Z/8
	sub	a2,a14			;=Z/2.667

	move	*a8(OYPOS),a1
	add	a14,a1
	addi	70,a1
	jrlt	#byvis
	clr	a1
#byvis	move	a1,@WORLDTLY+16


	move	*a8(OZPOS),a0		;>Check Z
	move	*a8(OZVEL),a1,L
	jrn	#zvneg

	cmpi	GZMAX-4,a0
	jrlt	#zok
	movi	GZMAX-4,a0
	jruc	#zbad

#zvneg	cmpi	CZMIN,a0
	jrge	#zok
	movi	CZMIN,a0

#zbad	move	a0,*a8(OZPOS)
	clr	a1
	move	a1,*a8(OZVEL),L
#zok

	subi	CZMIN,a0		;-Base
	jrge	#zge
	clr	a0
#zge	srl	5,a0			;/32
	move	*a13(ball_zsznum),a1
	cmp	a1,a0
	jreq	#ani
	move	a0,*a13(ball_zsznum)
	sll	5,a0			;*32
	move	a0,a1
	addi	#shad_t,a1		;Set new shadow img
	move	*a1,a2,L
	move	a2,*a9(OIMG),L
	move	*a2,a14,L
	move	a14,*a9(OSIZE),L
	move	*a2(ISAG),*a9(OSAG),L
	move	*a2(IANIOFFY),a1
	neg	a1
	move	a1,*a9(OYPOS)

	addi	#ani_t,a0
	move	*a0,a0,L
	move	a0,*a13(ball_ani1st_p),L
	jruc	#newz


#ani	dsj	a10,#skipa

	move	*a13(ball_ani_p),a0,L
	move	*a0+,a1,L		;*Next img
	jrnz	#notend

	move	*a13(ball_ani1st_p),a0,L
#newz	move	*a0+,a1,L		;*1st img

#notend	move	*a0+,a10
	move	a0,*a13(ball_ani_p),L

	move	a1,*a8(OIMG),L		;>Set new img
	move	*a1,a2,L
	move	a2,*a8(OSIZE),L
	move	*a1(ISAG),*a8(OSAG),L
	move	*a1(IANIOFFX),a2
	move	*a1(IANIOFFY),*a13(ball_aniy)
	move	*a13(ball_anix),a1
	move	a2,*a13(ball_anix)
	move	*a8(OXPOS),a0
	add	a1,a0			;Old ani X
	sub	a2,a0			;-New ani X
	move	a0,*a8(OXPOS)

#skipa
	move	*a8(OYVEL),a0,L

	move	*a8(OYPOS),a1
	move	*a13(ball_aniy),a14
	add	a14,a1
	jrlt	#agnd			;Above gnd?

	neg	a14
	move	a14,*a8(OYPOS)		;Set on gnd
	neg	a0
	sra	1,a0			;/2
#agnd	addi	GRAVB,a0
	move	a0,*a8(OYVEL),L
#nograv
	move	*a8(OXVAL),*a9(OXVAL),L	;>Align shadow
	move	*a8(OXANI),*a9(OXANI),L
	move	*a8(OZPOS),a0
	subk	10,a0			;Adjust
	move	a0,*a9(OZPOS)

	callr	ball_chkpcollide

#halted
	SLEEPK	1
	jruc	#lp


#ani_t
	.long	#b1_l
	.long	#b2_l,#b2_l
	.long	#b3_l,#b3_l,#b4_l,#b4_l
	.long	#b5_l,#b5_l,#b6_l,#b6_l
	.long	#b7_l,#b7_l,#b8_l,#b8_l
	.long	#b9_l,#b9_l, #b9_l,#b9_l
	.long	#b9_l,#b9_l, #b9_l,#b9_l
	.long	#b9_l,#b9_l, #b9_l,#b9_l

#b1_l	LW	ball11,10
	LW	ball12,10
	LWL0	ball13,10

#b2_l	LW	ball21,10
	LW	ball22,10
	LWL0	ball23,10

#b3_l	LW	ball31,10
	LW	ball32,10
	LWL0	ball33,10

#b4_l	LW	ball41,10
	LW	ball42,10
	LWL0	ball43,10

#b5_l	LW	ball51,10
	LW	ball52,10
	LWL0	ball53,10

#b6_l	LW	ball61,10
	LW	ball62,10
	LWL0	ball63,10

#b7_l	LW	ball71,10
	LW	ball72,10
	LWL0	ball73,10

#b8_l	LW	ball81,10
	LW	ball82,10
	LWL0	ball83,10

#b9_l	LW	ball91,10
	LW	ball92,10
	LWL0	ball93,10

#shad_t
;	.long	ballshad12,ballshad12,ballshad11,ballshad11
;	.long	ballshad10,ballshad10,ballshad9,ballshad9
	.long	ballshad8,ballshad8,ballshad7,ballshad7
	.long	ballshad6,ballshad6,ballshad5,ballshad5
	.long	ballshad4,ballshad4,ballshad3,ballshad3
	.long	ballshad2,ballshad2,ballshad1,ballshad1
	.long	ballshad1,ballshad1,ballshad1,ballshad1
	.long	ballshad1,ballshad1,ballshad1,ballshad1
	.long	ballshad1,ballshad1,ballshad1,ballshad1


********************************
* Get shadow obj for ball
* A8=*Obj
* >A9=*Shadow obj
* Trashes scratch, A2-A7

 SUBRP	ball_getshadow

	PUSH	a8

	move	*a8(OXVAL),a0,L
	movi	[-2,0],a1
	movi	ballshad5,a2
	move	*a8(OZPOS),a3
	subk	10,a3			;Z
	move	*a8(OCTRL),a4
	andi	M_FLIPH|M_FLIPV,a4
	ori	DMAWNZ|M_3D|M_SHAD|M_NOCOLL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,a9
	movk	10,a0
	move	a0,*a8(OMISC)		;Z offset

	PULL	a8
	rets


#*******************************
* Check ball for collisions with backboard/hoop
* A6=Ball ani XPOS
* A8=*Ball obj
* A13=*Ball process
* Trashes scratch, B2

 SUBRP	ball_bbcollision

	PUSH	a2,a3,a4,a5,a6,a7,a9,a10,a11

	clr	b2			;B2=Rim collision flag

	movi	hoopl_t,a10
	cmpi	WRLDMID,a6
	jrn	#left
	movi	hoopr_t,a10
#left
	move	*a8(OZPOS),a5		;A5=Ball Z
	move	*a8(OYPOS),a7		;A7=^ Y
	move	*a8(OSIZEY),a14
	srl	1,a14			;/2
	add	a14,a7			;Center Y
	jruc	#nxt


#lp	move	*a10+,a3		;Y
	move	*a10+,a4		;Z
	move	*a10+,a11		;Mode
	sub	a6,a2
	sub	a7,a3
	sub	a5,a4
	abs	a2
	abs	a3
	abs	a4

	cmp	a3,a2			;>Sort A2-A4 large to sml
	jrge	#20
	SWAP	a2,a3

#20	cmp	a4,a3
	jrge	#sorted
	SWAP	a3,a4

	cmp	a3,a2
	jrge	#sorted
	SWAP	a2,a3

#sorted	srl	1,a3			;/2
	srl	2,a4			;/4
	add	a3,a2
	add	a4,a2
	subk	6,a2
	jrgt	#nxt			;Too far?


	movi	clockid,a0		;Kill existing shot clock proc
	calla	KIL1C
	movi	CLSDEAD|clockid,a0	;Delete any 24 second shot clock imgs
	calla	obj_del1c

	move	a11,a11
	jrle	#notrim
					;>Rim

	move	@ballscorezhit,a0
	jrn	#nxt			;Already scored?

	move	b2,b2
	jrnz	#nomv
;	jrnz	#nxt
	addk	1,b2			;Set flag

	move	*a8(OXVEL),a0,L		;>Move back
	move	a8,a1
	addi	OXVAL,a1
	move	*a1,a14,L
	sub	a0,a14
	move	a14,*a1+,L
	move	*a8(OYVEL),a0,L
	move	*a1,a14,L
	sub	a0,a14
	move	a14,*a1+,L
	move	*a8(OZVEL),a0,L
	move	*a1,a14,L
	sub	a0,a14
	move	a14,*a1+,L

#nomv
	move	*a13(ball_collcnt),a1
	subk	5,a1
	jrge	#ballstuck

	subi	16*4,a10
	move	*a10+,a2
	move	*a10+,a3
	move	*a10+,a4
	addk	16,a10
	callr	ball_deflect
	jruc	#nxt

#ballstuck
	movi	>3ffff,a0		;>Ball is stuck
	callr	rnd
	subi	>20000,a0
	move	a0,*a8(OXVEL),L		;Give rnd velocity
	movi	>3ffff,a0
	callr	rnd
	subi	>20000,a0
	move	a0,*a8(OZVEL),L

	clr	a1
	move	a1,*a13(ball_collcnt)
	jruc	#nxt

#notrim
	jrn	#score
					;>Net (slow ball)
	move	a8,a1
	addk	OXVEL,a1

	move	*a1,a0,L		;X
	move	a0,a14
	sra	3,a14			;/8
	sub	a14,a0
	move	a0,*a1+,L

	move	*a1,a0,L		;Y
	move	a0,a14
	sra	3,a14			;/8
	sub	a14,a0
	move	a0,*a1+,L

	move	*a1,a0,L		;Z
	move	a0,a14
	sra	3,a14			;/8
	sub	a14,a0
	move	a0,*a1+,L

	jruc	#nxt


#score	callr	ball_score		;>Score if really a basket


#nxt	move	*a10+,a2		;X
	jrnz	#lp


	clr	a1
	move	b2,a0
	jrz	#svcol			;No rim collision?
	move	*a13(ball_collcnt),a1
	addk	1,a1
#svcol	move	a0,*a13(ball_colllast)
	move	a1,*a13(ball_collcnt)



	subi	CZMID,a5		;>Check backboard
	abs	a5
	subi	35,a5
	jrge	#x			;Z <> backboard Z?
	subi	HOOPY+4,a7
	jrgt	#x			;Y<bottom?
	cmpi	-35,a7
	jrlt	#x			;Y>top?

	subi	WRLDMID,a6
	move	a6,a2
	abs	a6
	subi	HOOPRX-WRLDMID+12,a6
	jrlt	#x			;In front of backboard?

	move	*a8(OXVEL),a0,L
	abs	a0
	move	a2,a2
	jrn	#lbb			;Left bb?
	neg	a0
#lbb	move	a0,*a8(OXVEL),L
	move	*a8(OXVAL),a1,L
	add	a0,a1
	move	a1,*a8(OXVAL),L


#x	PULL	a2,a3,a4,a5,a6,a7,a9,a10,a11
	rets


	.asg	HOOPLX,X
	.asg	HOOPY,Y
	.asg	Y+7,NY
	.asg	CZMID,Z
hoopl_t	.word	X-8	,Y	,Z	,1	;Rim
	.word	X-6	,Y	,Z-7	,1
	.word	X	,Y	,Z-9	,1
	.word	X+6	,Y	,Z-7	,1
	.word	X+8	,Y	,Z	,1
	.word	X+6	,Y	,Z+7	,1
	.word	X	,Y	,Z+9	,1
	.word	X-6	,Y	,Z+7	,1
	.word	X	,Y+2	,Z	,-1	;Score spots
	.word	X	,Y+6	,Z	,-2
;	.word	X-5	,NY	,Z	,0	;Net
;	.word	X	,NY	,Z-5	,0
;	.word	X+5	,NY	,Z	,0
;	.word	X	,NY	,Z+5	,0
	.word	0

	.asg	HOOPRX,X
hoopr_t	.word	X-8	,Y	,Z	,1
	.word	X-6	,Y	,Z-7	,1
	.word	X	,Y	,Z-9	,1
	.word	X+6	,Y	,Z-7	,1
	.word	X+8	,Y	,Z	,1
	.word	X+6	,Y	,Z+7	,1
	.word	X	,Y	,Z+9	,1
	.word	X-6	,Y	,Z+7	,1
	.word	X	,Y+2	,Z	,-1
	.word	X	,Y+6	,Z	,-2
;	.word	X-5	,NY	,Z	,0
;	.word	X	,NY	,Z-5	,0
;	.word	X+5	,NY	,Z	,0
;	.word	X	,NY	,Z+5	,0
	.word	0


#*******************************
* Deflect ball from what it hit
* A2=Hit X
* A3=Hit Y
* A4=Hit Z
* A5=Ball Z
* A6=Ball X
* A7=Ball Y
* A8=*Ball obj
* Trashes scratch, A2-A4

 SUBRP	ball_deflect

	PUSH	a5,a6,a7,a9,a10,a11

	sll	4,a2
	sll	4,a3
	sll	4,a4
	sll	4,a5
	sll	4,a6
	sll	4,a7

	PUSH	a2,a3,a6,a7

	move	a6,a0			;>Deflect XZ
	move	a5,a1
	move	a2,a6
	move	a4,a7
	callr	seekdir_xyxy128
	move	a0,a14
	neg	a0
	addi	>80,a0
	callr	sinecos_get

	move	*a8(OXVEL),a3,L
	move	*a8(OZVEL),a9,L

	move	a3,a5			;>Rotate to 0
	move	a9,a11
	mpys	a1,a3			;X*COS
	mpys	a0,a11			;Z*SIN
	sub	a11,a3			;X-Z
	mpys	a0,a5			;X*SIN
	mpys	a1,a9			;Z*COS
	add	a5,a9			;X+Z
	sra	14,a3
	sra	14,a9

	neg	a9			;Neg Z

	move	a14,a0
	callr	sinecos_get

	move	a3,a5			;>Rotate back
	move	a9,a11
	mpys	a1,a3			;X*COS
	mpys	a0,a11			;Z*SIN
	sub	a11,a3			;X-Z
	mpys	a0,a5			;X*SIN
	mpys	a1,a9			;Z*COS
	add	a5,a9			;X+Z
	sra	14,a3
	sra	14,a9

	move	a3,*a8(OXVEL),L
	move	a9,*a8(OZVEL),L

	PULL	a2,a3,a6,a7

	move	a6,a0			;>Deflect XY
	move	a7,a1
	move	a2,a6
	move	a3,a7
	callr	seekdir_xyxy128
	move	a0,a14
	neg	a0
	addi	>80,a0
	callr	sinecos_get

	move	*a8(OXVEL),a3,L
	move	*a8(OYVEL),a9,L

	move	a3,a5			;>Rotate to 0
	move	a9,a11
	mpys	a1,a3			;X*COS
	mpys	a0,a11			;Z*SIN
	sub	a11,a3			;X-Z
	mpys	a0,a5			;X*SIN
	mpys	a1,a9			;Z*COS
	add	a5,a9			;X+Z
	sra	14,a3
	sra	14,a9

	neg	a9			;Neg Y

	move	a14,a0
	callr	sinecos_get

	move	a3,a5			;>Rotate back
	move	a9,a11
	mpys	a1,a3			;X*COS
	mpys	a0,a11			;Z*SIN
	sub	a11,a3			;X-Z
	mpys	a0,a5			;X*SIN
	mpys	a1,a9			;Z*COS
	add	a5,a9			;X+Z
	sra	14,a3
	sra	14,a9

	move	a3,*a8(OXVEL),L
	move	a9,*a8(OYVEL),L


	PULL	a5,a6,a7,a9,a10,a11
	rets



#*******************************
* Ball touching score zone, score if valid
* A8=*Ball obj
* A11=-1/-2 (upper spot / lower spot)
* Trashes scratch

 SUBRP	ball_score

	PUSH	a2,a3,a4,a5,a6,a7,a9,a10,a11


	move	*a8(OYVEL),a0,L
	jrle	#x			;Moving up?

	addk	1,a11
	jrne	#low

	move	@ballscorezhit,a0
	jrn	#x			;Already scored?
	movk	1,a0			;Upper zone hit
	move	a0,@ballscorezhit
	jruc	#x

#low
;	movk	1,a0
;	calla	RNDRNG0
;	move	a0,a0
;	jrnz	#x

	move	@ballscorezhit,a0
	jrle	#x			;Didn't touch upper zone?
	movi	-1,a0
	move	a0,@ballscorezhit

;	movi	CZMID,a0
;	move	a0,*a8(OZPOS)

	move	*a8(OXVEL),a0,L		;>Slow XZ vel
	sra	1,a0
	move	a0,*a8(OXVEL),L
	move	*a8(OZVEL),a0,L
	sra	1,a0
	move	a0,*a8(OZVEL),L

	clr	a0			;Team 1
	move	*a8(OXANI+16),a1
	neg	a1
	addi	HOOPLX,a1

	move	*a8(OXPOS),a2
	cmpi	WRLDMID,a2
	jrlt	#left
	movk	32,a0			;Team 2
	addi	HOOPRX-HOOPLX,a1
#left
;	move	a1,*a8(OXPOS)

	calla	net_ani

	addi	scores,a0		;+Base
	movk	2,a1			;2 pts
	calla	score_add
	calla	prt_top_scores		;Update scores at scrn top

	CREATE0	score_showtvpanel

	movk	>f,a0
	callr	rnd
	jrnz	#x
	CREATE0	movie_test


#x	PULL	a2,a3,a4,a5,a6,a7,a9,a10,a11
	rets




********************************
* Get sine and cosine
* A0=Angle (0-127) (Not neg!)
* >A0=Sine (0-16384)
* >A1=Cos (0-16384)
* Preserves A14

 SUBRP	sinecos_get

	sll	32-7,a0
	srl	32-7-4,a0		;*16
	addi	sine_t,a0
	move	*a0(cos_t-sine_t),a1
	move	*a0,a0
	rets



sine_t
	.word	-16384,-16364,-16305,-16207,-16069,-15893,-15679,-15426
	.word	-15137,-14811,-14449,-14053,-13623,-13160,-12665,-12140
	.word	-11585,-11003,-10394,-9760,-9103,-8423,-7723,-7005
	.word	-6270,-5520,-4756,-3981,-3196,-2404,-1606,-804
cos_t
	.word	0,803,1605,2404,3196,3981,4756,5519
	.word	6270,7005,7723,8423,9102,9760,10394,11003
	.word	11585,12140,12665,13160,13623,14053,14449,14811
	.word	15137,15426,15678,15893,16069,16207,16305,16364

	.word	16384,16364,16305,16207,16069,15893,15679,15426
	.word	15137,14811,14449,14053,13623,13160,12665,12140
	.word	11585,11003,10394,9760,9102,8423,7723,7005
	.word	6270,5519,4756,3981,3196,2404,1606,804

	.word	0,-803,-1605,-2403,-3196,-3980,-4755,-5519
	.word	-6269,-7005,-7723,-8423,-9102,-9760,-10394,-11002
	.word	-11585,-12139,-12665,-13160,-13623,-14053,-14449,-14811
	.word	-15137,-15426,-15678,-15893,-16069,-16207,-16305,-16364

	.word	-16384,-16364,-16305,-16207,-16069,-15893,-15679,-15426
	.word	-15137,-14811,-14449,-14053,-13623,-13160,-12665,-12140
	.word	-11585,-11003,-10394,-9760,-9103,-8423,-7723,-7005
	.word	-6270,-5520,-4756,-3981,-3196,-2404,-1606,-804



#*******************************
* Check for ball collision with a player
* A8=*Ball obj

 SUBR	ball_chkpcollide

	PUSH	a2,a3,a4,a5,a6

	movk	4,a3
	move	*a8(OXPOS),a4
	move	*a8(OXANI+16),a14
	add	a14,a4			;A4=Center X
	move	*a8(OZPOS),a6		;A6=Z
	movi	plyrobj_t,a5

#lp	move	*a5+,a0,L

	move	*a0(OZPOS),a1		;>Chk Z
	sub	a6,a1
	abs	a1
	subk	19,a1
	jrge	#nxt

	move	*a0(OXPOS),a1		;>Chk box X
	move	*a0(OXANI+16),a14
	add	a14,a1
	move	*a0(OSIZEX),a14
	srl	1,a14			;/2
	sub	a14,a1
	cmp	a1,a4
	jrle	#nxt			;Center X <= lft?
	sll	1,a14
	add	a14,a1
	cmp	a1,a4
	jrge	#nxt			;Center X >= rgt?

	move	*a0(OYPOS),a1
	move	*a8(OYPOS),a14
	addk	7,a14
	cmp	a1,a14
	jrlt	#nxt			;Too hi?


	move	*a0(OPLINK),a2,L
	move	*a2(plyr_shtdly),a14
	jrgt	#nxt			;Just shot?

	move	@ballpnum,a1
	jrlt	#giveball		;No owner?
	move	*a2(plyr_num),a14
	cmp	a1,a14
	jreq	#nxt			;I already have it?

	move	*a2(plyr_seq),a0
	cmpi	STEAL_SEQ,a0
	jrne	#nxt

	movk	>f,a0
	callr	rnd
	jrnz	#nxt

#giveball
	move	*a2(plyr_num),a14
	move	a14,@ballpnum

	move	a14,a0
	srl	1,a0			;A0=0/1 for left/rgt hoop start clock
	move	@ballpnumlast,a1
	srl	1,a1
	cmp	a0,a1
	jreq	#x			;Same team?
	calla	shot_clock		;New 24
	jruc	#x


#nxt	dsj	a3,#lp


#x	PULL	a2,a3,a4,a5,a6
	rets


#*******************************
* Ball hit by player (Called by collision code)
* A0=*Plyr obj
* A8=*Ball obj

; SUBR	ball_hit
;
;	PUSH	a1,a2,a3,a4,a5,a6,a7
;
;	move	*a0(OYPOS),a1
;	move	*a8(OYPOS),a2
;	subk	10,a2
;	cmp	a1,a2
;	jrlt	#x			;Too hi?
;
;	move	*a0(OPLINK),a1,L
;	move	*a1(plyr_shtdly),a2
;	jrgt	#x			;Just shot?
;
;	move	*a1(plyr_num),a2
;	move	@ballpnum,a3
;	jrge	#x			;Owner?
;
;	move	a2,@ballpnum
;
;#x	PULL	a1,a2,a3,a4,a5,a6,a7
;	rets



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



********************************
* Get a shadow obj for a player
* A8=*Obj
* >A9=*Shadow obj
* Trashes scratch, A2-A7

 SUBRP	plyr_getshadow

	PUSH	a8

;	callr	anipt_getsclxy
;	move	*a8(OXVAL),a14,L
;	add	a14,a0
;	move	*a8(OYVAL),a14,L
;	add	a14,a1

	clr	a0
	clr	a1
	movi	shadow1,a2
	move	*a8(OZPOS),a3
	subi	50,a3			;Z
;	move	*a8(OCTRL),a4
;	andi	M_FLIPH|M_FLIPV,a4
;	ori	DMAWNZ|M_3D|M_SHAD|M_NOCOLL,a4
	movi	DMAWNZ|M_3D|M_SHAD|M_NOCOLL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,a9
	movi	50,a0
	move	a0,*a8(OMISC)		;Z offset

	PULL	a8
	rets



#*******************************
* Align shadow obj with a scaled obj
* A8=*Obj
* A9=*Shadow obj
* Trashes scratch, A2-A3

 SUBRP	shadow_align


	move	*a8(OZPOS),a0
	move	a0,a1
	subi	50,a1			;Adjust
	move	a1,*a9(OZPOS)

	subi	CZMIN,a0		;-Base
	jrge	#zok
	clr	a0
#zok	srl	5,a0			;/32
	sll	5,a0			;*32
	addi	#ani_t,a0
	move	*a0,a2,L
	move	a2,*a9(OIMG),L		;Set new img
	move	*a2,a14,L
	move	a14,*a9(OSIZE),L
	move	*a2(ISAG),*a9(OSAG),L

	callr	anipt_getsclxy

	move	*a2(IANIOFFX),a3
	sll	16,a3
	move	a3,*a9(OXANI),L

	move	*a8(OXVAL),a14,L
	add	a0,a14			;Ani X
	sub	a3,a14
	move	a14,*a9(OXVAL),L

	move	*a2(IANIOFFY),a3
	neg	a3
	move	a3,*a9(OYPOS)


	rets


#ani_t	.long	shadow11,shadow10,shadow9,shadow8
	.long	shadow7,shadow6,shadow5,shadow4
	.long	shadow3,shadow2,shadow1,shadow1
	.long	shadow1,shadow1



#*******************************
* Align head obj with player obj
* A8=*Obj
* A13=*Plyr process
* Trashes scratch, A2-A3

 SUBRP	plyr_headalign

	PUSH	a9

	move	*a13(plyr_headobj_p),a9,L
	move	*a9(OIMG),a2,L

	move	*a8(OIMG),a14,L		;>Set Z
	move	*a8(OZPOS),a0
	move	*a14(IANI3Z),a1
	add	a1,a0
	move	a0,*a9(OZPOS)


	callr	plyr_head_getsclanixy
	move	a0,a2
	move	a1,a3

	callr	anipt3_getsclxy

	move	*a8(OYVAL),a14,L
	add	a1,a14			;Ani3 Y
	sub	a3,a14
	move	a14,*a9(OYVAL),L

	move	*a8(OXVAL),a14,L
	move	a14,a1
	add	a0,a14			;Ani3 X
	sub	a2,a14
	move	a14,*a9(OXVAL),L


	move	*a8(OXANI),a0,L		;Make head X+ani = plyr X+ani
	add	a0,a1
	sub	a14,a1
	move	a1,*a9(OXANI),L


	PULL	a9
	rets


#*******************************
* Get a scaled objects anipt XY
* A9=*Obj
* >A0=Scaled Ani X (16:16)
* >A1=Scaled Ani Y
* Trashes scratch

 SUBRP	plyr_head_getsclanixy

	move	a2,b0

	move	*a9(OZPOS),a14		;894 to 1379 (Z range 486)
	move	*a9(OMISC),a0		;Z offset
	add	a0,a14
	subi	GZBASE,a14		;-Base
	jrge	#zok
	clr	a14
#zok	srl	4,a14			;/16
	sll	6,a14			;*64
	move	*a9(ODATA_p),a0,L
	addk	32,a0
	add	a14,a0

	move	*a0+,a14
	sll	4,a14			;*16
	move	*a9(OIMG),a2,L

	move	*a2(IANIOFFX),a1
	mpys	a14,a1
	move	*a0,a14
	sll	4,a14			;*16
	move	a1,a0


	move	*a2(IANIOFFY),a1
	mpys	a14,a1


	move	*a9(OCTRL),a14
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
* Main drone logic
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	drone_main


	move	@ballpnum,a14
	jrn	drone_chaseball

	move	*a13(plyr_ownball),a1
	jrz	drone_defence		;No ball?


 SUBRP	drone_offense

	move	*a13(plyr_jmpcnt),a14
	jrnz	#injmp

	move	*a13(plyr_seq),a14
	cmpi	SHOOTJ_SEQ,a14
	jreq	#injmp

	move	*a13(plyr_ownball),a14
	jrle	#noball


	move	*a13(plyr_num),a14	;>Chk for breakaway
	srl	1,a14
	movk	1,a0
	xor	a0,a14
	sll	6,a14			;*64
	addi	plyrobj_t,a14
	move	*a14+,a2,L
	move	*a14+,a3,L

	move	*a8(OXPOS),a1
	move	*a2(OXPOS),a2
	move	*a3(OXPOS),a3
	move	*a13(plyr_ohoopx),a4
	sub	a4,a1
	abs	a1
	sub	a4,a2
	abs	a2
	sub	a4,a3
	abs	a3
	cmp	a1,a2
	jrlt	#noball			;Closer?
	cmp	a1,a3
	jrlt	#noball			;Closer?

	move	a4,a0
	movi	CZMID,a1
	callr	drone_seekxy

	move	*a8(OXPOS),a14
	sub	a4,a14
	move	*a8(OXANI+16),a2
	add	a2,a14
	abs	a14
	cmpi	70,a14
	jrge	#x			;Too far?
	jruc	#shoot2


#noball
	move	*a13(plyr_ohoopx),a0
	movi	CZMID,a1
	move	a0,a2
	callr	drone_seekxy

	movk	>1f,a0
	callr	rnd
	jrnz	#x

	movk	1,a0
	callr	rnd
	jrnz	#shoot

	callr	drone_pass
	jruc	#x

#shoot
	move	*a8(OXPOS),a14
	sub	a14,a2
	abs	a2
	cmpi	300,a2
	jrge	#x			;Too far?

#shoot2	move	*a11,a0			;>Shoot
	addk	>10,a0
	move	a0,*a11
	jruc	#x


#injmp
	movk	>f,a0
	callr	rnd
	jrnz	#x
	clr	a0			;>Let go of shoot button
	move	a0,*a11


#x	rets


#*******************************
* Drone code - pass if clear
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process

 SUBRP	drone_pass


	move	*a13(plyr_tmdist),a0
	addk	30,a0
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
#dsml	subk	32,a1
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
#dsml2	subk	32,a1
	jrlt	#x

#o2ok
	move	*a11,a0			;>Pass
	addk	>20,a0
	move	a0,*a11

#x	rets


#*******************************
* Drone code - defence
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process

 SUBRP	drone_defence


	move	*a13(plyr_myhoopx),a0	;>Stay near oplyr between his basket
	movi	CZMID,a1


	move	*a13(plyr_num),a14	;>Get opponents obj
	addk	2,a14
	sll	32-2,a14
	srl	32-2-5,a14		;*32
	addi	plyrobj_t,a14
	move	*a14,a2,L
	.if	DEBUG
	jrz	#x
	.endif

	move	*a2(OXPOS),a3
	move	*a2(OXANI+16),a14
	add	a14,a3
	add	a3,a0
	sll	1,a3			;*2
	add	a3,a0
	sra	2,a0			;/4
	move	*a2(OZPOS),a14
	add	a14,a1
	sll	1,a14			;*2
	add	a14,a1
	sra	2,a1			;/4

	callr	drone_seekxy

#x	rets



#*******************************
* Drone code - nobody has ball
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process

 SUBRP	drone_chaseball

	move	@ballobj_p,a2,L

	move	*a2(OXPOS),a0
	move	*a2(OXANI+16),a14
	add	a14,a0

	move	*a2(OZPOS),a1
	callr	drone_seekxy

	rets



#*******************************
* Drone - push stick to move drone towards an XY location
* A0=X to seek
* A1=Y
* A8=*Obj
* A11=*Ctrl bits
* A13=*Plyr process
* Trashes scratch

 SUBRP	drone_seekxy

	PUSH	a2,a3

	clr	a3

	move	*a8(OXPOS),a2
	move	*a8(OXANI+16),a14
	add	a14,a2

	sub	a0,a2
	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	#onx
	move	a14,a14
	jrlt	#nolft
	addk	4,a3			;Left
	jruc	#onx

#nolft	addk	8,a3			;Rgt
#onx
	move	*a8(OZPOS),a2

	sub	a1,a2
	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	#onz
	move	a14,a14
	jrlt	#noup
	addk	1,a3			;Up
	jruc	#onz

#noup	addk	2,a3			;Dn
#onz
	move	a3,*a11

	PULL	a2,a3
	rets




#*******************************
* Create ground alignment dots for debugging (Process)

 SUBR	gnd_aligndots

	.ref	pal_set


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

	PUSH	a2,a3,a4,a5,a6,a7,a8

	callr	anipt_getsclxy
	move	*a8(OXVAL),a14,L
	add	a14,a0
	move	*a13(plyr_aligndot_p),a2,L
	move	a0,*a2(OXVAL),L

	move	*a8(OZPOS),a14
	addi	300,a14
	move	a14,*a2(OZPOS)

	PULL	a2,a3,a4,a5,a6,a7,a8
	rets


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

 SUBRP	seekdir_xyxy128

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

 SUBRP	seekdirdist_obxz128

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


#x	srl	1,b0			;Shorter/2
	add	b0,b1
	move	b1,a1

	movi	>7f,a0
	and	a2,a0
	rets



********************************
* Get random # with mask
* A0=Mask
* Trashes scratch
* >A0=Rnd # (Pass CC)

 SUBRP	rnd

	move	@RAND,a1,L
	rl	a1,a1
	move	@HCOUNT,a14
	rl	a14,a1
	add	sp,a1
	move	a1,@RAND,L

	and	a1,a0
	rets


;Turmell
;Display each frame of our ball player to check 2nd and 3rd ani pnts, etc.

	.ref	img_list
	.ref	img_end

	.bss	debounce,16


 SUBR	image_display

	SLEEP	3*60

	movi	img_list,a8
	movi	stuff1+16,a9
	clr	a0
	move	a0,@debounce

#swtop	SLEEPK	1
	move	*a8,*a9,L
	move	@SWITCH,a0,L
	cmpi	>ffffffff,a0
	jrnz	#sw1
	clr	a0
	move	a0,@debounce
	jruc	#swtop
#sw1	move	@debounce,a1
	jrnz	#swtop

	btst	31,a0
	jrz	advance
	btst	28,a0
	jrnz	#swtop
;go backwards
	cmpi	img_list,a8
	jrz	#swtop
	subi	32,a8
	movk	1,a0
	move	a0,@debounce
	jruc	#swtop
advance	cmpi	img_end,a8
	jrz	#swtop
	addi	32,a8
	movk	1,a0
	move	a0,@debounce
	jruc	#swtop
	

	.end
