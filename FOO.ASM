#init_t
;mjt
	.word	>ff4a+3,>ff49+2,Z,0,F
	.long	hooptop
	.word	>ff58+3,>ff46-7,Z,0,F
	.long	hoopbot
	.word	>ff27+3,>ff4b+2,Z-14,14,F
	.long	back1
	WL	4001,backboard_ani
	.word	>ff75+3,>ff7a+2,Z,0,F
	.long	rimbase
	.word	>ff78+3,>ff7d+2,Z-10,0,F
	.long	rim1b
	.word	>ff7a+3,>ff7a+2,Z+10,0,F
	.long	rim1f

	.word	>241-3,>ff49+2,Z-20,20,FF
	.long	hooptop
	.word	>234-3,>ff46-7,Z,0,FF
	.long	hoopbot
	.word	>267-3,>ff4b+2,Z-14,14,FF
	.long	back1
	WL	4001,backboard_ani
	.word	>215-3,>ff7a+2,Z,0,FF
	.long	rimbase
	.word	>214-3,>ff7d+2,Z-10,0,FF
	.long	rim1b
	.word	>212-3,>ff7a+2,Z+10,0,FF
	.long	rim1f

	.word	200-310,1,599,500,F
	.long	reflc2
	.word	200-302,3,720,500,F
	.long	reflc1
	.word	200-156,0,590,500,F
	.long	reflc3
	.word	200-146,0,718,500,F
	.long	reflc4
	.word	200-20,0,590,500,F
	.long	reflc5
	.word	200+140,0,590,500,F
	.long	reflc3
	.word	200+132,0,718,500,F
	.long	reflc4
	.word	200+312,1,599,500,FF
	.long	reflc2
	.word	200+302,3,720,500,FF
	.long	reflc1



	.asg	100,X
#cxs	.equ	151
	.asg	-16,Y

	.word	X-#cxs*3,Y+6,200,0,0
	.long	crowd4
	.word	X-#cxs*2,Y+5,200,0,0
	.long	crowd4
	.word	X-#cxs,Y+4,200,0,0
	.long	crowd4
	.word	X,Y+2,200,0,0
	.long	crowd4
	.word	X+#cxs,Y+10,200,0,0
	.long	ftcrwd4
	.word	X+#cxs+65+150,Y+10,200,0,M_FLIPH
	.long	crowd4
	.word	X+#cxs*2+65+150,Y+3,200,0,M_FLIPH
	.long	crowd4
	.word	X+#cxs*3+65+150,Y+3,200,0,M_FLIPH
	.long	crowd4

	.asg	200-56,X
	.asg	-43,Y
	.asg	919,Z
	.word	X-245,Y,Z,0,F
	.long	crowd3
	.word	X,Y+2,Z,0,F
	.long	table3
	.word	X+102+253-2,Y,Z,0,FF
	.long	crowd3

	.asg	200-63,X
	.asg	-48,Y
	.asg	947,Z
	.word	>fed9,>ffcc,Z+8,0,F
	.long	usher
	.word	>ffa4+12,>ffd0,Z,0,F
	.long	usher
	.word	>35,>ffc6,Z,0,FF
	.long	usher
	.word	>16a,>ffd6,Z,0,FF
	.long	usher
	.word	>1ef,>ffc0,Z,0,FF
	.long	usher
	.word	>2b0,>ffcf,Z+5,0,FF
	.long	usher
	.word	X-256-177+1,Y+2,Z,0,F
	.long	crowd2b
	.word	X-256-5,Y,Z,0,F
	.long	crowd2a
	.word	X-5,Y-2,Z,0,F
	.long	table2
	.word	X+87-4,Y-4,Z,0,F
	.long	crowd2af
	.word	X+87+257+216-6,Y+2,Z,0,FF
	.long	crowd2b

	.asg	200-53,X
	.asg	-40,Y
	.asg	985,Z
	.word	X-438,Y-3,Z,0,F
	.long	crowd1b
	.word	X-232,Y,Z,0,F
	.long	crowd1a
	.word	X,Y+1,Z,0,F
	.long	table1
	.word	X+68,Y-5,Z,0,F
	.long	crowd1af
	.word	X+68+241+231,Y-3,Z,0,FF
	.long	crowd1b

	.word	200-200,6,Z,0,F
	.long	cdre1
	.word	200-185,6,Z,0,F
	.long	cdre2
	.word	200-170,6,Z,0,F
	.long	cdre3
	.word	200-144+2,6,Z,0,F
	.long	avia
	.word	200+41+3,6,Z,0,F
	.long	slamre


	.asg	200-450,X
	.asg	985,Z

	.word	>FEc0,>FFDE,Z,0,F
	.long	sdcrwd8
	.word	>FEFC,>FFDE,Z,0,F
	.long	sdcrwd8
	.word	>FEF9,>FFDB,Z+28,0,F
	.long	sdcrwd7
	.word	>FEF8,>FFD4,Z+70,0,F
	.long	sdcrwd6
	.word	>FEED,>FFCE,Z+98,0,F
	.long	sdcrwd5
	.word	>FEB5,>FFBC,Z+152,0,F
	.long	sdcrwd4
	.word	>FEEC,>FFB0,Z+152,0,F
	.long	sdcrwd4
	.word	>FF00,>FFB7,Z+240,0,F
	.long	sdcrwd3
	.word	>FF0D,>FFC3,Z+284,0,F
	.long	sdcrwd2
	.word	>FF00,>FFB0,Z+379,0,F
	.long	sdcrwd1

	.asg	200+450,X

	.word	>292,>ffdb,Z,0,FF
	.long	sdcrwd8
	.word	>297,>ffd8,Z+28,0,FF
	.long	sdcrwd7
	.word	>299,>ffd1,Z+70,0,FF
	.long	sdcrwd6
	.word	>2a6,>ffcc,Z+98,0,FF
	.long	sdcrwd5
	.word	>2a4,>ffaa,Z+152,0,FF
	.long	sdcrwd4
	.word	>290,>ffba,Z+240,0,FF
	.long	sdcrwd3
	.word	>284,>ffc6,Z+284,0,FF
	.long	sdcrwd2
	.word	>292,>ffb0,Z+379,0,FF
	.long	sdcrwd1

	.word	4000		;End



;mjt
#x	.equ	15
#x2	.equ	215
#y	.equ	1
#z	.equ	300

#init_t
	.word	#x,#y,#z
	.long	Jordan
	.word	#x,#y-2,#z
	.long	METER
	.word	#x,#y-2,#z
	.long	turbo
	.word	#x+115,#y,#z
	.long	Barkley
	.word	#x+115,#y-2,#z
	.long	METER
	.word	#x+115,#y-2,#z
	.long	turbo

	.word	#x2,#y,#z
	.long	Jordan
	.word	#x2,#y-2,#z
	.long	METER
	.word	#x2,#y-2,#z
	.long	turbo
	.word	#x2+115,#y,#z
	.long	Barkley
	.word	#x2+115,#y-2,#z
	.long	METER
	.word	#x2+115,#y-2,#z
	.long	turbo

	.word	185,25,100
	.long	LED_0
	.word	193,25,100
	.long	LED_0

	.word	202,25,100
	.long	LED_0
	.word	210,25,100
	.long	LED_0

	.word	186,35,100
	.long	LED_0
	.word	197,35,100
	.long	LED_0
	.word	205,35,100
	.long	LED_0

	.word	4000
