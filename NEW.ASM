 SUBRP	update_shoes
	PUSH	a11

	move	*a13(PDATA+32),a0,L
	move	*a0(PA11),a11,L
	move	*a11,a6			;A6=Ctrl bits
       

	movi	wht_shoes,a11		;pal data

	btst	6,a6			;Turbo but
	jrz	#noturb
	move	*a0(plyr_PDATA_p),a1,L
	move	*a1(ply_turbo),a1
	jrz	#noturb			;No turbo left?

	movi	red_shoes,a11		;pal data

#noturb
	move	*a13(PDATA+64),A6,L
	cmp	a11,a6
	jrz	#x
  	move	a11,*a13(PDATA+64),L
	move	*a0(plyr_attrib_p),a7,L
	move	*a7(PAT_PAL_p),a0,L

	calla	pal_find
	andi	0ff00h,a0
	move	a0,a1			;dest pal
	ori	249,a1
	move	a11,a0

	movk	5,a2			;5 colors
	calla	pal_set
#x	PULL	a11
	rets

red_shoes
	.word	31<<10+0<<5+0
	.word	27<<10+0<<5+0
	.word	22<<10+0<<5+0
	.word	18<<10+0<<5+0
	.word	14<<10+0<<5+0
wht_shoes
	.word	31<<10+31<<5+31
	.word	27<<10+27<<5+27
	.word	22<<10+22<<5+22
	.word	18<<10+18<<5+18
	.word	14<<10+14<<5+14


#******************************************************************
* Player is off screen for too long - put up an arrow pointing him out
*
*a8=0-3 for plyr #

 SUBR	plyr_lost


   	move	a8,a9
	clr	a0
	move	a0,*a13(PDATA)			;lost cntr
	move	a0,*a13(PDATA+64),L		;Current red/white shoe pal

	sll	5,a8
	movi	plyrproc_t,a0			;*player process (4)
	add	a8,a0
	move	*a0,a0,L
	move	a0,*a13(PDATA+32),L		;Keep player proc around

	SLEEP	3*60				;Make sure plyr gets started

	addi	plyrobj_t,a8
	move	*a8,a8,L

	sll	6,a9
	move	a9,a11

#top	SLEEPK	5
	callr	update_shoes
	SLEEPK	5
	callr	update_shoes
	SLEEPK	5
	callr	update_shoes

