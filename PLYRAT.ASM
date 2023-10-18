**************************************************************
*
* Software:		Shawn Liptak, Mark Turmell
* Initiated:		11/20/92
*
* Modified:		Shawn Liptak, 10/5/92	-Split from plyr2.asm
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 1/13/93 0:55
**************************************************************
	.file	"plyrat.asm"
	.title	"basketball player code"
	.width	132
	.option	b,d,l,t
	.mnolist


	.include	"mproc.equ"		;Mproc equates
	.include	"disp.equ"		;Display proc equates
	.include	"gsp.equ"		;Gsp asm equates
	.include	"sys.equ"
	.include	"shawn.hdr"		;Macros
	.asg		0,SEQT
	.include	"plyr.equ"
;	.include	"plyrhd.tbl"
	.include	"imgpalp.asm"


;sounds external


;symbols externally defined

	.ref	scale57_t,scale58_t,scale60_t
	.ref	scale61_t,scale63_t
	.ref	scale64_t,scale65_t,scale66_t,scale66t_t,scale66f_t
	.ref	scale67_t,scale68_t,scale69_t
	.ref	scale610_t,scale610t_t,scale610f_t,scale611_t
	.ref	scale70_t,scale71_t,scale72_t,scale72f_t

	.ref	team1,team2
	.ref	McHale_h,Lohaus_h,Gug_h,Laim_h,Edwrd_h,Iuz_h
	.ref	Worthy_h,Laetner_h,Hawkins_h,LJohnson_h,Divac_h,Seikaly_h
	.ref	Lewis_h,KMalone_h,Stockton_h,Ewing_h,RHarper_h
	.ref	Seikaly_h,Price_h,Rice_h,Miller_h,Mutumbo_h,Oakley_h,Olajuwon_h
	.ref	Skiles_h,Petrovic_h,Porter_h,Schrempf_h,Robinson_h,Tisdale_h
	.ref	Webb_h,Smith_h,Thomas_h,ONeal_h
	.ref	Kemp_h,Pippen_h,Gill_h,Daughert_h,Mullin_h,Wilkins_h
	.ref	Person_h,Augmon_h,Benjamin_h,Barkley_h,Coleman_h,Drexler_h
	.ref	Ellis_h,Elliot_h,Hardaway_h,DHarper_h,HCGrant_h,HVGrant_h
	.ref	Hornacek_h,Majerle_h,Manning_h


;symbols defined in this file

	.def	tm_t
	.def	spechds_t

;	.def	TG05
;	.def	jamie5
;	.def	JC5
;	.def	SAL5
;	.def	SHAW5
;	.def	MT05
;	.def	JONH5
;	.def	GEOR5
;	.def	JOHNN05
;	.def	SHER5
;	.def	steve5
;	.def	wil5
;	.def	tonysc5

;uninitialized ram definitions


;equates for this file



	.text



;ATL_t
;	LWWWWWW	scale610_t,BV5,SHT3,DNK10,DEF4,SDEF1,DSKL0
;	.long	FL53_p, Un4_p,Un14_p, TR1_p,TR4_p,Wilkins_h
;	LWWWWWW	scale66_t,BV8,SHT7,DNK3,DEF6,SDEF1,DSKL0
;	.long	FL1_p, Un4_p,Un14_p, TR1_p,TR4_p,Augmon_h



tm_t	.long	ATL_t,BOST_t,CHAR_t,CHI_t,CLEV_t,DAL_t,DEN_t,DET_t,GOLD_t
	.long	HOU_t,IND_t,LAC_t,LAL_t,MIAMI_t,MILW_t,MINN_t,NJ_t,NY_t,ORL_t
	.long	PHIL_t,PHX_t,PORT_t,SAC_t,SANANT_t,SEA_t,UTAH_t,WASH_t

;Speeds
	.asg	>1040->80,BV
	.asg	>1040->80+>40*1,BV1
	.asg	>1040->80+>40*2,BV2
	.asg	>1040->80+>40*3,BV3
	.asg	>1040->80+>40*4,BV4
	.asg	>1040->80+>40*5,BV5
	.asg	>1040->80+>40*6,BV6
	.asg	>1040->80+>40*7,BV7
	.asg	>1040->80+>40*8,BV8
	.asg	>1040->80+>40*9,BV9
	.asg	>1040->80+>40*10,BV10
;Drone skills
	.asg	0,DSKL0
	.asg	1,DSKL1
	.asg	2,DSKL2
	.asg	3,DSKL3
	.asg	4,DSKL4
	.asg	5,DSKL5
	.asg	-1,DSKL_1
	.asg	-2,DSKL_2
	.asg	-3,DSKL_3
	.asg	-4,DSKL_4
	.asg	-5,DSKL_5
	.asg	-6,DSKL_6
	.asg	-7,DSKL_7
	.asg	-8,DSKL_8
	.asg	-9,DSKL_9
	.asg	-10,DSKL_10
	.asg	-11,DSKL_11
;Shot skill %
	.asg	890,SHT0		;890
	.asg	910,SHT1		;910
	.asg	960,SHT2		;960
	.asg	980,SHT3		;980
	.asg	1000,SHT4		;1000
	.asg	1020,SHT5		;1020
	.asg	1040,SHT6		;1040
	.asg	1060,SHT7
	.asg	1070,SHT8
	.asg	1090,SHT9
	.asg	1150,SHT10
;	.asg	890,SHT0		
;	.asg	910,SHT1
;	.asg	960,SHT2
;	.asg	980,SHT3
;	.asg	1000,SHT4
;	.asg	1020,SHT5
;	.asg	1040,SHT6
;	.asg	1060,SHT7
;	.asg	1070,SHT8
;	.asg	1090,SHT9
;	.asg	1150,SHT10
;Dunk ability
	.asg	0,DNK0
	.asg	1,DNK1
	.asg	2,DNK2
	.asg	3,DNK3
	.asg	4,DNK4
	.asg	5,DNK5
	.asg	6,DNK6
	.asg	7,DNK7
	.asg	8,DNK8
	.asg	9,DNK9
	.asg	10,DNK10
;Defensive ability
	.asg	0,DEF0
	.asg	1,DEF1
	.asg	2,DEF2
	.asg	3,DEF3
	.asg	4,DEF4
	.asg	5,DEF5
	.asg	6,DEF6
	.asg	7,DEF7
	.asg	8,DEF8
	.asg	9,DEF9
	.asg	10,DEF10
;Defensive steal ability
	.asg	180,SDEF0
	.asg	185,SDEF1
	.asg	190,SDEF2		;Old normal
	.asg	195,SDEF3
	.asg	200,SDEF4
	.asg	205,SDEF5
	.asg	210,SDEF6
	.asg	215,SDEF7
	.asg	220,SDEF8
	.asg	225,SDEF9
	.asg	230,SDEF10


;Size,speed,shot%,dunk ability,defensive ability,steal ability,drone skill

ATL_t
	LWWWWWW	scale610_t,BV7,SHT5,DNK10,DEF4,SDEF2,DSKL0	;Can shatter
	.long	FL53_p, Un4_p,Un14_p, TR1_p,TR4_p,Wilkins_h
	LWWWWWW	scale66t_t,BV8,SHT7,DNK3,DEF6,SDEF3,DSKL0
	.long	FL1_p, Un4_p,Un14_p, TR1_p,TR4_p,Augmon_h

BOST_t
	LWWWWWW	scale67_t,BV7,SHT8,DNK4,DEF5,SDEF3,DSKL0
	.long	FL25_p, Un13_p,Un1_p, TR2_p,TR1_p,Lewis_h
	LWWWWWW	scale70_t,BV3,SHT4,DNK2,DEF9,SDEF2,DSKL0
	.long	FL37_p, Un13_p,Un1_p, TR2_p,TR1_p,McHale_h

CHAR_t
	LWWWWWW	scale610f_t,BV6,SHT7,DNK9,DEF4,SDEF2,DSKL0   	;Can shatter
	.long	FL23_p, Un12_p,Un14_p, TR2_p,TR2_p,LJohnson_h
	LWWWWWW	scale65_t,BV7,SHT7,DNK7,DEF7,SDEF4,DSKL0
	.long	FL14_p, Un12_p,Un14_p, TR2_p,TR2_p,Gill_h

CHI_t
	LWWWWWW	scale68_t,BV8,SHT6,DNK10,DEF8,SDEF6,DSKL5	;Can shatter
	.long	FL38_p, Un4_p,Un1_p, TR2_p,TR1_p,Pippen_h
	LWWWWWW	scale611_t,BV6,SHT1,DNK7,DEF7,SDEF0,DSKL5
	.long	FL15_p, Un4_p,Un1_p, TR2_p,TR1_p,HCGrant_h

CLEV_t
	LWWWWWW	scale60_t,BV7,SHT8,DNK0,DEF4,SDEF10,DSKL0
	.long	FL40_p, Un8_p,Un14_p, TR5_p,TR7_p,Price_h
	LWWWWWW	scale70_t,BV3,SHT2,DNK8,DEF6,SDEF2,DSKL0
	.long	FL6_p,  Un8_p,Un14_p, TR5_p,TR7_p,Daughert_h

DAL_t
	LWWWWWW	scale64_t,BV5,SHT5,DNK4,DEF9,SDEF2,DSKL_11
	.long	FL5_p,  Un5_p,Un14_p, TR6_p,TR6_p,DHarper_h
	LWWWWWW	scale60_t,BV7,SHT8,DNK0,DEF7,SDEF5,DSKL_11
	.long	FL49_p, Un5_p,Un14_p, TR6_p,TR6_p,Iuz_h

DEN_t
	LWWWWWW	scale72_t,BV5,SHT5,DNK9,DEF7,SDEF2,DSKL_7	;Can shatter
	.long	FL32_p, Un8_p,Un14_p, TR8_p,TR7_p,Mutumbo_h
	LWWWWWW	scale70_t,BV6,SHT4,DNK8,DEF7,SDEF2,DSKL_7
	.long	FL12_p, Un8_p,Un14_p, TR8_p,TR7_p,Ellis_h

DET_t
	LWWWWWW	scale60_t,BV9,SHT9,DNK1,DEF7,SDEF10,DSKL1
	.long	FL50_p, Un9_p,Un14_p, TR4_p,TR7_p,Thomas_h
	LWWWWWW	scale610f_t,BV4,SHT7,DNK0,DEF8,SDEF7,DSKL1
;	.long	FL44_p, Un9_p,Un14_p, TR4_p,TR7_p,Rodman_h
;	.long	FL37_p, Un9_p,Un14_p, TR4_p,TR7_p,Laim_h
	.long	FL27_p, Un9_p,Un14_p, TR4_p,TR7_p,Laim_h

GOLD_t
	LWWWWWW	scale63_t,BV9,SHT6,DNK2,DEF7,SDEF8,DSKL_4
	.long	FL17_p, Un5_p,Un14_p, TR9_p,TR7_p,Hardaway_h
	LWWWWWW	scale68_t,BV4,SHT10,DNK3,DEF5,SDEF3,DSKL_4
	.long	FL31_p, Un5_p,Un14_p, TR9_p,TR7_p,Mullin_h

HOU_t
	LWWWWWW	scale71_t,BV6,SHT3,DNK9,DEF9,SDEF2,DSKL1
	.long	FL35_p, Un4_p,Un14_p, TR9_p,TR4_p,Olajuwon_h
	LWWWWWW	scale63_t,BV7,SHT7,DNK1,DEF4,SDEF3,DSKL1
	.long	FL48_p, Un4_p,Un14_p, TR9_p,TR4_p,Smith_h

IND_t
	LWWWWWW	scale66t_t,BV7,SHT5,DNK7,DEF3,SDEF2,DSKL0
	.long	FL30_p, Un10_p,Un14_p, TR9_p,TR7_p,Miller_h
	LWWWWWW	scale610_t,BV5,SHT4,DNK4,DEF7,SDEF2,DSKL0
	.long	FL45_p, Un10_p,Un14_p, TR9_p,TR7_p,Schrempf_h

LAC_t
	LWWWWWW	scale610t_t,BV5,SHT5,DNK7,DEF4,SDEF2,DSKL0
	.long	FL28_p, Un4_p,Un14_p, TR2_p,TR4_p,Manning_h
	LWWWWWW	scale68_t,BV8,SHT7,DNK4,DEF7,SDEF4,DSKL0
	.long	FL41_p, Un4_p,Un14_p, TR2_p,TR4_p,RHarper_h

LAL_t
	LWWWWWW	scale68_t,BV5,SHT6,DNK8,DEF4,SDEF3,DSKL1
	.long	FL54_p, Un2_p,Un15_p, TR3_p,TR10_p,Worthy_h
	LWWWWWW	scale70_t,BV3,SHT4,DNK7,DEF7,SDEF2,DSKL1
	.long	FL8_p, Un2_p,Un15_p, TR3_p,TR10_p,Divac_h

MIAMI_t
	LWWWWWW	scale610f_t,BV6,SHT9,DNK5,DEF4,SDEF2,DSKL_6
	.long	FL42_p, Un1_p,Un14_p, TR4_p,TR4_p,Rice_h
	LWWWWWW	scale70_t,BV4,SHT3,DNK8,DEF8,SDEF2,DSKL_6
	.long	FL46_p, Un1_p,Un14_p, TR4_p,TR4_p,Seikaly_h

MILW_t
	LWWWWWW	scale610_t,BV4,SHT6,DNK3,DEF7,SDEF2,DSKL_2
	.long	FL37_p, Un11_p,Un14_p, TR6_p,TR6_p,Lohaus_h
	LWWWWWW	scale68_t,BV6,SHT4,DNK7,DEF4,SDEF4,DSKL_2
	.long	FL2_p, Un11_p,Un14_p, TR6_p,TR6_p,Edwrd_h

MINN_t
	LWWWWWW	scale70_t,BV3,SHT3,DNK6,DEF7,SDEF3,DSKL_10
	.long	FL24_p, Un5_p,Un14_p, TR2_p,TR7_p,Laetner_h
	LWWWWWW	scale66f_t,BV5,SHT7,DNK8,DEF3,SDEF3,DSKL_10
	.long	FL36_p, Un5_p,Un14_p, TR2_p,TR7_p,Person_h

NJ_t
	LWWWWWW	scale610f_t,BV5,SHT4,DNK8,DEF3,SDEF2,DSKL0
	.long	FL4_p, Un14_p,Un14_p, TR4_p,TR1_p,Coleman_h
	LWWWWWW	scale66t_t,BV4,SHT7,DNK1,DEF7,SDEF5,DSKL0
	.long	FL37_p, Un14_p,Un14_p, TR4_p,TR1_p,Petrovic_h

NY_t
	LWWWWWW	scale72f_t,BV7,SHT5,DNK9,DEF9,SDEF2,DSKL2	;Shatter
	.long	FL13_p, Un5_p,Un14_p, TR5_p,TR1_p,Ewing_h
	LWWWWWW	scale610f_t,BV4,SHT2,DNK7,DEF8,SDEF2,DSKL2
	.long	FL34_p, Un5_p,Un14_p, TR5_p,TR1_p,Oakley_h

ORL_t
	LWWWWWW	scale72f_t,BV6,SHT1,DNK10,DEF7,SDEF5,DSKL2	;Can shatter
	.long	FL33_p, Un1_p,Un14_p, TR7_p,TR7_p,ONeal_h
	LWWWWWW	scale61_t,BV6,SHT9,DNK0,DEF6,SDEF8,DSKL2
	.long	FL47_p, Un1_p,Un14_p, TR7_p,TR7_p,Skiles_h

PHIL_t
	LWWWWWW	scale66t_t,BV7,SHT7,DNK4,DEF4,SDEF2,DSKL_9
	.long	FL18_p, Un4_p,Un14_p, TR7_p,TR4_p,Hawkins_h
	LWWWWWW	scale65_t,BV6,SHT6,DNK1,DEF6,SDEF5,DSKL_9
	.long	FL19_p, Un4_p,Un14_p, TR7_p,TR4_p,Hornacek_h

PHX_t
	LWWWWWW	scale610f_t,BV7,SHT6,DNK9,DEF2,SDEF5,DSKL3
	.long	FL2_p, Un3_p,Un14_p, TR2b_p,TR1_p,Barkley_h
	LWWWWWW	scale66_t,BV5,SHT2,DNK7,DEF7,SDEF2,DSKL3
	.long	FL27_p, Un3_p,Un14_p, TR2b_p,TR1_p,Majerle_h

PORT_t
	LWWWWWW	scale610t_t,BV7,SHT5,DNK9,DEF6,SDEF2,DSKL3	;Can shatter
	.long	FL9_p, Un1_p,Un14_p, TR4_p,TR4_p,Drexler_h
	LWWWWWW	scale63_t,BV6,SHT8,DNK3,DEF4,SDEF4,DSKL3
	.long	FL39_p, Un1_p,Un14_p, TR4_p,TR4_p,Porter_h

SAC_t
	LWWWWWW	scale610f_t,BV5,SHT6,DNK7,DEF5,SDEF2,DSKL_8
	.long	FL51_p, Un5_p,Un14_p, TR2_p,TR7_p,Tisdale_h
	LWWWWWW	scale57_t,BV10,SHT6,DNK10,DEF6,SDEF7,DSKL_8	;Can shatter
	.long	FL52_p, Un5_p,Un14_p, TR2_p,TR7_p,Webb_h

SANANT_t
	LWWWWWW	scale71_t,BV5,SHT4,DNK8,DEF10,SDEF2,DSKL_3
	.long	FL43_p, Un1_p,Un14_p, TR2_p,TR11_p,Robinson_h
	LWWWWWW	scale69_t,BV7,SHT6,DNK7,DEF4,SDEF2,DSKL_3
	.long	FL10_p, Un1_p,Un14_p, TR2_p,TR11_p,Elliot_h

SEA_t
	LWWWWWW	scale611_t,BV8,SHT5,DNK10,DEF6,SDEF2,DSKL0
	.long	FL22_p, Un6_p,Un14_p, TR3_p,TR6_p,Kemp_h
	LWWWWWW	scale72f_t,BV3,SHT4,DNK6,DEF4,SDEF2,DSKL0
	.long	FL3_p, Un6_p,Un14_p, TR3_p,TR6_p,Benjamin_h

UTAH_t
	LWWWWWW	scale610f_t,BV5,SHT2,DNK9,DEF7,SDEF2,DSKL4	;Can shatter
	.long	FL21_p, Un7_p,Un14_p, TR2_p,TR2_p,KMalone_h
	LWWWWWW	scale61_t,BV8,SHT8,DNK0,DEF6,SDEF10,DSKL4
	.long	FL49_p, Un7_p,Un14_p, TR2_p,TR2_p,Stockton_h

WASH_t
	LWWWWWW	scale610_t,BV6,SHT5,DNK4,DEF8,SDEF2,DSKL_5
	.long	FL27_p, Un4_p,Un14_p, TR7_p,TR7_p,Gug_h
	LWWWWWW	scale69_t,BV6,SHT4,DNK8,DEF5,SDEF2,DSKL_5
	.long	FL16_p, Un4_p,Un14_p, TR7_p,TR7_p,HVGrant_h

spechds_t
	LWWWWWW	scale61_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL49_p, Un1_p,Un14_p, TR7_p,TR7_p,tg_h
	LWWWWWW	scale66_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL27_p, Un6_p,Un6_p, TR2b_p,TR2b_p,jr_h
	LWWWWWW	scale60_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL49_p, Un4_p,Un1_p, TR2_p,TR1_p,jc_h
	LWWWWWW	scale63_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL49_p, Un1_p,Un1_p, TR4_p,TR4_p,sd_h
	LWWWWWW	scale72_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL49_p, Un6_p,Un6_p, TR2b_p,TR2b_p,sl_h
	LWWWWWW	scale70_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL27_p, Un2_p,Un2_p, TR3_p,TR3_p,mt_h
	LWWWWWW	scale63_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL49_p, Un6_p,Un6_p, TR2b_p,TR2b_p,jh_h
	LWWWWWW	scale66_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL27_p, Un2_p,Un2_p, TR3_p,TR3_p,gp_h
	LWWWWWW	scale610f_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL27_p, Un2_p,Un2_p, TR3_p,TR3_p,jn_h
	LWWWWWW	scale66f_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL27_p, Un2_p,Un2_p, TR3_p,TR3_p,so_h
	LWWWWWW	scale70_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL2_p, Un7_p,Un14_p, TR2_p,TR2_p,sh_h
	LWWWWWW	scale610t_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL36_p, Un4_p,Un1_p, TR2_p,TR1_p,wi_h
	LWWWWWW	scale66f_t,BV10,SHT10,DNK10,DEF8,SDEF6,DSKL5
	.long	FL54_p, Un7_p,Un14_p, TR2_p,TR2_p,ts_h

tg_h
	.long	TG01
	.long	TG01,TG02,TG03,TG04,TG05
	.long	TG06,TG07,TG08,TG09,TG10
	.long	TG11,TG12,TG13,TG14,TG15
	.long	TG16
jr_h
	.long	jamie1
	.long	jamie1,jamie2,jamie3,jamie4,jamie5
	.long	jamie1,jamie2,jamie3,jamie4,jamie5
	.long	jamie1,jamie2,jamie3,jamie4,jamie5
	.long	jamie1
jc_h
	.long	JC1
	.long	JC1,JC2,JC3,JC4,JC5
	.long	JC6,JC7,JC8,JC9,JC10
	.long	JC11,JC12,JC13,JC14,JC15
	.long	JC16
sd_h
	.long	SAL1
	.long	SAL1,SAL2,SAL3,SAL4,SAL5
	.long	SAL6,SAL7,SAL8,SAL9,SAL10
	.long	SAL11,SAL12,SAL13,SAL14,SAL15
	.long	SAL16
sl_h
	.long	SHAW1
	.long	SHAW1,SHAW2,SHAW3,SHAW4,SHAW5
	.long	SHAW6,SHAW7,SHAW8,SHAW9,SHAW10
	.long	SHAW11,SHAW12,SHAW13,SHAW14,SHAW15
	.long	SHAW16
mt_h
	.long	MT01
	.long	MT01,MT02,MT03,MT04,MT05
	.long	MT06,MT07,MT08,MT09,MT10
	.long	MT11,MT12,MT13,MT14,MT15
	.long	MT16
jh_h
	.long	JONH1
	.long	JONH1,JONH2,JONH3,JONH4,JONH5
	.long	JONH6,JONH7,JONH8,JONH9,JONH10
	.long	JONH11,JONH12,JONH13,JONH14,JONH15
	.long	JONH16
gp_h
	.long	GEOR1
	.long	GEOR1,GEOR2,GEOR3,GEOR4,GEOR5
	.long	GEOR6,GEOR7,GEOR8,GEOR9,GEOR10
	.long	GEOR11,GEOR12,GEOR13,GEOR14,GEOR15
	.long	GEOR16
jn_h
	.long	JOHNN01
	.long	JOHNN01,JOHNN02,JOHNN03,JOHNN04,JOHNN05
	.long	JOHNN06,JOHNN07,JOHNN08,JOHNN09,JOHNN10
	.long	JOHNN11,JOHNN12,JOHNN13,JOHNN14,JOHNN15
	.long	JOHNN16
so_h
	.long	SHER1
	.long	SHER1,SHER2,SHER3,SHER4,SHER5
	.long	SHER6,SHER7,SHER8,SHER9,SHER10
	.long	SHER11,SHER12,SHER13,SHER14,SHER15
	.long	SHER16
sh_h
	.long	steve1
	.long	steve1,steve2,steve3,steve4,steve5
	.long	steve1,steve2,steve3,steve4,steve5
	.long	steve1,steve2,steve3,steve4,steve5
	.long	steve3
wi_h
	.long	wil1
	.long	wil1,wil2,wil3,wil4,wil5
	.long	wil1,wil2,wil3,wil4,wil5
	.long	wil1,wil2,wil3,wil4,wil5
	.long	wil3
ts_h
	.long	tonysc1
	.long	tonysc1,tonysc2,tonysc3,tonysc4,tonysc5
	.long	tonysc1,tonysc2,tonysc3,tonysc4,tonysc5
	.long	tonysc1,tonysc2,tonysc3,tonysc4,tonysc5
	.long	tonysc3
	.long	tonysc1,tonysc2,tonysc3,tonysc4,tonysc5	;PADDING


****************************************************************

	.end
