	.OPTION	B,D,L,T
	.include	"BGNDTBL.GLO"
	.DATA

oreHDRS:
	.word	8,4	;x size, y size
	.long	052B7741H	;address
	.word	06000H
	.word	8,4
	.long	052B7801H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	96,4
	.long	052B8FA1H
	.word	06000H
	.word	4,122
	.long	052B98A1H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	44,8
	.long	052B9E89H
	.word	06000H
	.word	120,4
	.long	052BA6C9H
	.word	05000H
	.word	96,4
	.long	052BB029H
	.word	03000H
	.word	180,120
	.long	052BB4A9H
	.word	05000H
	.word	40,115
	.long	052D5A89H
	.word	06000H
	.word	40,121
	.long	052DC659H
	.word	06000H
	.word	36,4
	.long	052E37C9H
	.word	05000H
	.word	28,48
	.long	052E3A99H
	.word	06000H
	.word	152,8
	.long	052E5A19H
	.word	06000H
	.word	4,71
	.long	052E7699H
	.word	05000H
	.word	152,8
	.long	052E7C25H
	.word	06000H
	.word	16,9
	.long	052E98A5H
	.word	05000H
	.word	48,8
	.long	052E9B75H
	.word	06000H
	.word	52,9
	.long	052EA475H
	.word	03000H
	.word	8,4
	.long	052EA9F1H
	.word	06000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
hiscoreBLKS:
	.word	0140H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0240H,0,250,01H
	.word	0240H,0,4,02H
	.word	0240H,0,128,02H
	.word	0240H,0,107,02H
	.word	0260H,0,254,01H
	.word	0240H,6,250,03H
	.word	0140H,6,0,03H
	.word	0241H,6,128,04H
	.word	0241H,6,4,05H
	.word	0241H,6,4,06H
	.word	0260H,6,254,03H
	.word	0243H,6,14,07H
	.word	0144H,6,22,08H
	.word	0241H,6,8,04H
	.word	0241H,10,4,09H
	.word	045H,10,7,0AH
	.word	045H,10,127,0AH
	.word	045H,10,247,0AH
	.word	0443H,16,4,0BH
	.word	0443H,16,119,0CH
	.word	0144H,19,240,0DH
	.word	04042H,23,184,0EH
	.word	0243H,33,14,0FH
	.word	0144H,55,4,010H
	.word	0144H,55,173,010H
	.word	0144H,55,105,010H
	.word	0144H,55,65,010H
	.word	0140H,100,0,03H
	.word	0240H,100,250,03H
	.word	0260H,100,254,03H
	.word	0144H,103,22,08H
	.word	0241H,104,4,09H
	.word	0243H,183,14,011H
	.word	045H,190,7,0AH
	.word	045H,190,127,0AH
	.word	045H,190,247,0AH
	.word	0260H,193,254,03H
	.word	0140H,194,0,03H
	.word	0240H,194,250,03H
	.word	0241H,199,4,09H
	.word	0144H,210,22,08H
	.word	0140H,286,0,03H
	.word	0260H,287,254,03H
	.word	0240H,288,250,03H
	.word	0241H,293,4,09H
	.word	0240H,296,250,03H
	.word	0240H,296,0,03H
	.word	0260H,302,254,03H
	.word	0144H,327,17,012H
	.word	0243H,331,14,013H
	.word	0141H,334,17,014H
	.word	045H,370,7,0AH
	.word	045H,370,127,0AH
	.word	045H,370,247,0AH
	.word	0140H,390,0,015H
	.word	0140H,390,121,02H
	.word	0240H,390,128,02H
	.word	0240H,390,250,016H
	.word	0240H,390,4,02H
	.word	0250H,394,4,02H
	.word	0250H,394,126,02H
	.word	0250H,394,128,02H
	.word	0250H,394,250,016H
	.word	0150H,394,0,015H
	.word	0260H,396,254,016H
	.word	0FFFFH	;End Marker
hiscoreBMOD:
	.word	550,367,66	;x size, y size, #blocks
	.long	hiscoreBLKS, oreHDRS, orePALS

yjamHDRS:
	.word	8,4	;x size, y size
	.long	052B7741H	;address
	.word	06000H
	.word	8,4
	.long	052B7801H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	96,4
	.long	052B8FA1H
	.word	06000H
	.word	4,122
	.long	052B98A1H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	96,4
	.long	052BB029H
	.word	03000H
	.word	180,120
	.long	052BB4A9H
	.word	05000H
	.word	8,4
	.long	052EA9F1H
	.word	06000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
empjambBLKS:
	.word	0140H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0240H,0,250,01H
	.word	0240H,0,4,02H
	.word	0240H,0,128,02H
	.word	0240H,0,107,02H
	.word	0260H,0,254,01H
	.word	0240H,6,250,03H
	.word	0140H,6,0,03H
	.word	0241H,6,128,04H
	.word	0241H,6,4,05H
	.word	0241H,6,4,06H
	.word	0260H,6,254,03H
	.word	0241H,6,8,04H
	.word	0241H,10,4,07H
	.word	043H,10,7,08H
	.word	043H,10,127,08H
	.word	043H,10,247,08H
	.word	0140H,100,0,03H
	.word	0240H,100,250,03H
	.word	0260H,100,254,03H
	.word	0241H,104,4,07H
	.word	043H,190,7,08H
	.word	043H,190,127,08H
	.word	043H,190,247,08H
	.word	0260H,193,254,03H
	.word	0140H,194,0,03H
	.word	0240H,194,250,03H
	.word	0241H,199,4,07H
	.word	0140H,286,0,03H
	.word	0260H,287,254,03H
	.word	0240H,288,250,03H
	.word	0241H,293,4,07H
	.word	0240H,296,250,03H
	.word	0240H,296,0,03H
	.word	0260H,302,254,03H
	.word	043H,370,7,08H
	.word	043H,370,127,08H
	.word	043H,370,247,08H
	.word	0140H,390,0,09H
	.word	0140H,390,121,02H
	.word	0240H,390,128,02H
	.word	0240H,390,250,0AH
	.word	0240H,390,4,02H
	.word	0250H,394,4,02H
	.word	0250H,394,126,02H
	.word	0250H,394,128,02H
	.word	0250H,394,250,0AH
	.word	0150H,394,0,09H
	.word	0260H,396,254,0AH
	.word	0FFFFH	;End Marker

;file emptyjam blocks not in any module
;	.word	0260H	;flags
;	.word	1082,505 ;x,y
;	.word	01H	;pal5,pal4,hdr13-0
;	.word	0240H,1082,358,02H
;	.word	0240H,1082,379,02H
;	.word	0240H,1082,255,02H
;	.word	0240H,1082,501,01H
;	.word	0140H,1082,251,00H
;	.word	0260H,1088,505,03H
;	.word	0244H,1088,255,06H
;	.word	0241H,1088,255,05H
;	.word	0244H,1088,379,04H
;	.word	0140H,1088,251,03H
;	.word	0240H,1088,501,03H
;	.word	0244H,1088,258,04H
;	.word	042H,1092,498,08H
;	.word	042H,1092,378,08H
;	.word	042H,1092,258,08H
;	.word	0244H,1092,255,07H
;	.word	0260H,1182,505,03H
;	.word	0240H,1182,501,03H
;	.word	0140H,1182,251,03H
;	.word	0244H,1186,255,07H
;	.word	042H,1272,498,08H
;	.word	042H,1272,378,08H
;	.word	042H,1272,258,08H
;	.word	0260H,1275,505,03H
;	.word	0240H,1276,501,03H
;	.word	0140H,1276,251,03H
;	.word	0244H,1281,255,07H
;	.word	0140H,1368,251,03H
;	.word	0260H,1369,505,03H
;	.word	0240H,1370,501,03H
;	.word	0244H,1375,255,07H
;	.word	0240H,1378,251,03H
;	.word	0240H,1378,501,03H
;	.word	0260H,1384,505,03H
;	.word	042H,1452,498,08H
;	.word	042H,1452,378,08H
;	.word	042H,1452,258,08H
;	.word	0240H,1472,255,02H
;	.word	0240H,1472,501,0AH
;	.word	0240H,1472,379,02H
;	.word	0140H,1472,372,02H
;	.word	0140H,1472,251,09H
;	.word	0150H,1476,251,09H
;	.word	0250H,1476,501,0AH
;	.word	0250H,1476,379,02H
;	.word	0250H,1476,377,02H
;	.word	0250H,1476,255,02H
;	.word	0260H,1478,505,0AH
;	.word	0FFFFH	;End Marker
empjambBMOD:
	.word	550,367,49	;x size, y size, #blocks
	.long	empjambBLKS, yjamHDRS, yjamPALS

oHDRS:
	.word	8,4	;x size, y size
	.long	052B7741H	;address
	.word	06000H
	.word	8,4
	.long	052B7801H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	96,4
	.long	052B8FA1H
	.word	06000H
	.word	4,122
	.long	052B98A1H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	96,4
	.long	052BB029H
	.word	03000H
	.word	180,120
	.long	052BB4A9H
	.word	05000H
	.word	48,8
	.long	052EAB71H
	.word	06000H
	.word	52,11
	.long	052EB471H
	.word	03000H
	.word	48,8
	.long	052E9B75H
	.word	06000H
	.word	52,11
	.long	052EBB25H
	.word	03000H
	.word	8,4
	.long	052EA9F1H
	.word	06000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
yesnoBLKS:
	.word	0140H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0240H,0,250,01H
	.word	0240H,0,4,02H
	.word	0240H,0,128,02H
	.word	0240H,0,107,02H
	.word	0260H,0,254,01H
	.word	0240H,6,250,03H
	.word	0140H,6,0,03H
	.word	0241H,6,128,04H
	.word	0241H,6,4,05H
	.word	0241H,6,4,06H
	.word	0260H,6,254,03H
	.word	0241H,6,8,04H
	.word	0241H,10,4,07H
	.word	042H,10,7,08H
	.word	042H,10,127,08H
	.word	042H,10,247,08H
	.word	0443H,36,27,09H
	.word	0341H,38,28,0AH
	.word	0140H,100,0,03H
	.word	0240H,100,250,03H
	.word	0260H,100,254,03H
	.word	0241H,104,4,07H
	.word	042H,190,7,08H
	.word	042H,190,127,08H
	.word	042H,190,247,08H
	.word	0260H,193,254,03H
	.word	0140H,194,0,03H
	.word	0240H,194,250,03H
	.word	0241H,199,4,07H
	.word	0140H,286,0,03H
	.word	0260H,287,254,03H
	.word	0240H,288,250,03H
	.word	0241H,293,4,07H
	.word	0240H,296,250,03H
	.word	0240H,296,0,03H
	.word	0260H,302,254,03H
	.word	0443H,315,27,0BH
	.word	0341H,316,28,0CH
	.word	042H,370,7,08H
	.word	042H,370,127,08H
	.word	042H,370,247,08H
	.word	0140H,390,0,0DH
	.word	0140H,390,121,02H
	.word	0240H,390,128,02H
	.word	0240H,390,250,0EH
	.word	0240H,390,4,02H
	.word	0250H,394,4,02H
	.word	0250H,394,126,02H
	.word	0250H,394,128,02H
	.word	0250H,394,250,0EH
	.word	0150H,394,0,0DH
	.word	0260H,396,254,0EH
	.word	0FFFFH	;End Marker
yesnoBMOD:
	.word	550,367,53	;x size, y size, #blocks
	.long	yesnoBLKS, oHDRS, oPALS

ackHDRS:
	.word	8,4	;x size, y size
	.long	052B7741H	;address
	.word	06000H
	.word	12,122
	.long	052EC1D9H
	.word	06000H
	.word	12,122
	.long	052EE429H
	.word	06000H
	.word	8,4
	.long	052B7801H
	.word	06000H
	.word	96,122
	.long	052F0679H
	.word	06000H
	.word	96,8
	.long	053018F9H
	.word	06000H
	.word	96,4
	.long	052B8FA1H
	.word	06000H
	.word	40,171
	.long	05302AF9H
	.word	06000H
	.word	4,4
	.long	0530CB49H
	.word	06000H
	.word	8,122
	.long	0530CBA9H
	.word	06000H
	.word	8,122
	.long	0530E289H
	.word	06000H
	.word	4,4
	.long	0530F969H
	.word	06000H
	.word	56,172
	.long	0530F9C9H
	.word	06000H
	.word	56,172
	.long	0531DB89H
	.word	06000H
	.word	64,171
	.long	0532BD49H
	.word	06000H
	.word	8,4
	.long	052EA9F1H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
	.word	8,50
	.long	0533BDC9H
	.word	06000H
	.word	188,11
	.long	0533C729H
	.word	06000H
	.word	84,36
	.long	0533F7A1H
	.word	05000H
	.word	172,6
	.long	053432B1H
	.word	06000H
	.word	172,8
	.long	05344AE1H
	.word	06000H
	.word	8,36
	.long	05346B21H
	.word	06000H
	.word	56,14
	.long	053471E1H
	.word	06000H
	.word	52,11
	.long	05348441H
	.word	06000H
	.word	8,50
	.long	053491A9H
	.word	06000H
	.word	8,28
	.long	05349B09H
	.word	05000H
	.word	84,36
	.long	05349F69H
	.word	04000H
	.word	8,28
	.long	0534CEA9H
	.word	06000H
selbackBLKS:
	.word	0240H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0240H,0,4,01H
	.word	0240H,0,116,02H
	.word	0240H,0,128,02H
	.word	0240H,0,250,03H
	.word	040H,5,6,04H
	.word	040H,5,128,04H
	.word	0240H,5,0,05H
	.word	0240H,5,250,06H
	.word	0140H,26,20,07H
	.word	0240H,99,0,08H
	.word	0240H,99,4,09H
	.word	0240H,99,120,0AH
	.word	0240H,99,128,0AH
	.word	0240H,99,250,0BH
	.word	040H,102,6,04H
	.word	040H,102,128,04H
	.word	0240H,102,0,05H
	.word	0240H,103,250,06H
	.word	0140H,120,20,0CH
	.word	0240H,196,0,08H
	.word	0240H,196,4,09H
	.word	0240H,196,128,0AH
	.word	0240H,196,119,0AH
	.word	0240H,196,250,0BH
	.word	040H,200,6,04H
	.word	040H,200,128,04H
	.word	0240H,200,0,05H
	.word	0240H,200,250,06H
	.word	0140H,219,20,0DH
	.word	0240H,293,0,08H
	.word	0240H,293,4,09H
	.word	0240H,293,128,0AH
	.word	0240H,293,120,0AH
	.word	0240H,293,250,0BH
	.word	040H,297,6,04H
	.word	040H,297,128,04H
	.word	0240H,297,0,05H
	.word	0240H,297,250,06H
	.word	0140H,312,20,0EH
	.word	0240H,390,0,0FH
	.word	0240H,390,4,010H
	.word	0240H,390,124,011H
	.word	0240H,390,128,011H
	.word	0240H,390,250,012H
	.word	0FFFFH	;End Marker
namebox2BLKS:
	.word	06441H	;flags
	.word	0,0 ;x,y
	.word	013H	;pal5,pal4,hdr13-0
	.word	05F44H,0,42,014H
	.word	05F42H,6,6,015H
	.word	06441H,6,0,016H
	.word	06441H,6,42,017H
	.word	06441H,89,6,018H
	.word	05F42H,95,6,015H
	.word	06044H,164,42,019H
	.word	06441H,165,43,01AH
	.word	06441H,178,0,01BH
	.word	05F44H,180,4,01CH
	.word	05F44H,180,15,01CH
	.word	06441H,194,0,013H
	.word	05F44H,195,42,014H
	.word	06441H,200,0,016H
	.word	05F42H,200,6,01DH
	.word	06441H,200,42,017H
	.word	06441H,283,6,018H
	.word	05F42H,289,6,01DH
	.word	06441H,372,0,01BH
	.word	05F44H,373,15,01EH
	.word	05F44H,373,4,01EH
	.word	0FFFFH	;End Marker
selbackBMOD:
	.word	398,254,45	;x size, y size, #blocks
	.long	selbackBLKS, ackHDRS, ackPALS
namebox2BMOD:
	.word	383,56,22	;x size, y size, #blocks
	.long	namebox2BLKS, ackHDRS, ackPALS

selHDRS:
	.word	208,7	;x size, y size
	.long	0534D3E9H	;address
	.word	06000H
	.word	200,4
	.long	0534F609H
	.word	06000H
	.word	12,124
	.long	053508C9H
	.word	06000H
	.word	96,122
	.long	052F0679H
	.word	06000H
	.word	48,8
	.long	052EAB71H
	.word	06000H
	.word	52,11
	.long	05352BA9H
	.word	06000H
	.word	32,89
	.long	05353911H
	.word	05000H
	.word	184,6
	.long	053570B1H
	.word	06000H
	.word	8,71
	.long	05358A91H
	.word	06000H
	.word	188,9
	.long	053597E1H
	.word	06000H
	.word	172,6
	.long	053432B1H
	.word	06000H
	.word	88,65
	.long	0535BF89H
	.word	05000H
	.word	156,2
	.long	05362F41H
	.word	06000H
	.word	4,85
	.long	05363691H
	.word	06000H
	.word	156,2
	.long	05363E89H
	.word	06000H
	.word	156,84
	.long	053645D9H
	.word	06000H
	.word	152,8
	.long	052E5A19H
	.word	06000H
	.word	152,11
	.long	053778F9H
	.word	06000H
	.word	4,4
	.long	0537A029H
	.word	06000H
	.word	4,4
	.long	0537A089H
	.word	06000H
	.word	4,11
	.long	0537A0E9H
	.word	06000H
	.word	8,71
	.long	0537A1F1H
	.word	06000H
	.word	8,71
	.long	0537AF41H
	.word	06000H
	.word	164,2
	.long	0537BC91H
	.word	06000H
	.word	152,8
	.long	052E7C25H
	.word	06000H
	.word	156,2
	.long	0537C441H
	.word	06000H
	.word	156,11
	.long	0537CB91H
	.word	06000H
	.word	88,66
	.long	0537F3C9H
	.word	06000H
	.word	48,8
	.long	052E9B75H
	.word	06000H
	.word	52,11
	.long	05387BE9H
	.word	06000H
	.word	4,85
	.long	05388951H
	.word	06000H
	.word	24,89
	.long	05389149H
	.word	05000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
	.word	8,124
	.long	0538BB01H
	.word	06000H
teamselBLKS:
	.word	04050H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04050H,3,250,01H
	.word	0240H,3,126,02H
	.word	0240H,3,5,02H
	.word	040H,10,128,03H
	.word	040H,10,6,03H
	.word	0241H,10,13,04H
	.word	0140H,13,15,05H
	.word	0A42H,13,30,06H
	.word	0A41H,13,122,07H
	.word	07841H,13,128,08H
	.word	0145H,15,193,09H
	.word	07841H,19,193,0AH
	.word	04343H,19,128,0BH
	.word	04640H,44,29,0CH
	.word	04640H,44,31,0DH
	.word	04640H,46,114,0EH
	.word	04041H,46,31,0FH
	.word	0241H,51,13,010H
	.word	0140H,53,15,011H
	.word	03E40H,56,243,012H
	.word	03E40H,82,243,013H
	.word	040H,101,128,03H
	.word	040H,101,6,03H
	.word	0145H,102,235,014H
	.word	04343H,103,128,0BH
	.word	07841H,191,128,015H
	.word	040H,192,6,03H
	.word	040H,192,128,03H
	.word	0145H,193,125,016H
	.word	04040H,195,0,00H
	.word	04640H,196,29,017H
	.word	04040H,198,250,01H
	.word	0241H,201,13,018H
	.word	04640H,202,114,019H
	.word	04041H,202,31,0FH
	.word	0140H,203,15,01AH
	.word	07841H,207,128,08H
	.word	0A41H,207,122,07H
	.word	0345H,209,193,09H
	.word	04443H,212,128,01BH
	.word	07841H,213,193,0AH
	.word	040H,283,6,03H
	.word	040H,283,128,03H
	.word	04443H,297,128,01BH
	.word	0145H,297,235,014H
	.word	040H,304,6,03H
	.word	040H,304,128,03H
	.word	0241H,346,13,01CH
	.word	0140H,348,15,01DH
	.word	04640H,356,31,01EH
	.word	0A44H,367,30,01FH
	.word	07841H,385,128,015H
	.word	0145H,387,126,016H
	.word	0145H,388,131,016H
	.word	0240H,394,250,020H
	.word	04040H,394,5,021H
	.word	04040H,394,126,021H
	.word	0FFFFH	;End Marker
teamselBMOD:
	.word	403,254,58	;x size, y size, #blocks
	.long	teamselBLKS, selHDRS, selPALS

hbakHDRS:
	.word	8,4	;x size, y size
	.long	052B7741H	;address
	.word	06000H
	.word	8,4
	.long	052B7801H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	96,4
	.long	052B8FA1H
	.word	06000H
	.word	4,122
	.long	052B98A1H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	96,4
	.long	052BB029H
	.word	03000H
	.word	180,120
	.long	052BB4A9H
	.word	05000H
	.word	132,9
	.long	0538D241H
	.word	06000H
	.word	4,71
	.long	0538EE19H
	.word	06000H
	.word	120,4
	.long	052BA6C9H
	.word	05000H
	.word	136,3
	.long	0538F4C1H
	.word	05000H
	.word	136,3
	.long	0538FCB9H
	.word	05000H
	.word	36,65
	.long	053904B1H
	.word	05000H
	.word	132,4
	.long	05393265H
	.word	05000H
	.word	48,8
	.long	052EAB71H
	.word	06000H
	.word	52,11
	.long	052EB471H
	.word	03000H
	.word	16,22
	.long	05393CB5H
	.word	05000H
	.word	16,22
	.long	05394395H
	.word	05000H
	.word	16,22
	.long	05394A75H
	.word	05000H
	.word	8,22
	.long	05395155H
	.word	05000H
	.word	16,22
	.long	053954C5H
	.word	05000H
	.word	16,9
	.long	052E98A5H
	.word	05000H
	.word	16,22
	.long	05395BA5H
	.word	05000H
	.word	4,65
	.long	05396285H
	.word	05000H
	.word	4,71
	.long	052E7699H
	.word	05000H
	.word	8,11
	.long	05396799H
	.word	05000H
	.word	16,22
	.long	05396951H
	.word	05000H
	.word	40,61
	.long	05397031H
	.word	06000H
	.word	32,61
	.long	0539A961H
	.word	06000H
	.word	24,22
	.long	0539D721H
	.word	05000H
	.word	16,22
	.long	0539E171H
	.word	05000H
	.word	132,9
	.long	0539E851H
	.word	06000H
	.word	4,71
	.long	053A0429H
	.word	06000H
	.word	136,3
	.long	053A0AD1H
	.word	06000H
	.word	136,3
	.long	053A1461H
	.word	06000H
	.word	36,65
	.long	053A1DF1H
	.word	06000H
	.word	12,22
	.long	053A54C9H
	.word	05000H
	.word	16,9
	.long	053A59F1H
	.word	05000H
	.word	16,22
	.long	053A5CC1H
	.word	05000H
	.word	16,22
	.long	053A63A1H
	.word	05000H
	.word	48,8
	.long	052E9B75H
	.word	06000H
	.word	52,11
	.long	052EBB25H
	.word	03000H
	.word	4,65
	.long	053A6A81H
	.word	06000H
	.word	8,4
	.long	052EA9F1H
	.word	06000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
	.word	8,24
	.long	053A7099H
	.word	06000H
	.word	8,24
	.long	053A7519H
	.word	06000H
	.word	12,22
	.long	053A7999H
	.word	05000H
	.word	8,22
	.long	05395155H
	.word	05000H
	.word	16,22
	.long	05394A75H
	.word	05000H
	.word	16,22
	.long	0539E171H
	.word	05000H
	.word	12,22
	.long	053A7EC1H
	.word	05000H
	.word	16,22
	.long	05396951H
	.word	05000H
	.word	12,22
	.long	053A54C9H
	.word	05000H
	.word	16,22
	.long	05394395H
	.word	05000H
	.word	16,22
	.long	053A83E9H
	.word	05000H
	.word	12,22
	.long	053A8AC9H
	.word	05000H
matchupBLKS:
	.word	0140H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0240H,0,250,01H
	.word	0240H,0,4,02H
	.word	0240H,0,128,02H
	.word	0240H,0,107,02H
	.word	0260H,0,254,01H
	.word	0240H,6,250,03H
	.word	0140H,6,0,03H
	.word	0241H,6,128,04H
	.word	0241H,6,4,05H
	.word	0241H,6,4,06H
	.word	0260H,6,254,03H
	.word	0241H,6,8,04H
	.word	0241H,10,4,07H
	.word	048H,10,7,08H
	.word	048H,10,127,08H
	.word	048H,10,247,08H
	.word	0644H,17,76,09H
	.word	0644H,21,119,0AH
	.word	0544H,21,85,0BH
	.word	0644H,24,119,0CH
	.word	0644H,24,187,0DH
	.word	0644H,24,122,0EH
	.word	0544H,25,190,0FH
	.word	0443H,25,25,010H
	.word	0341H,28,26,011H
	.word	0644H,36,85,09H
	.word	0544H,40,94,0BH
	.word	0644H,57,122,0EH
	.word	04042H,80,19,012H
	.word	0644H,90,122,0EH
	.word	04042H,93,19,013H
	.word	0140H,100,0,03H
	.word	0240H,100,250,03H
	.word	0260H,100,254,03H
	.word	0241H,104,4,07H
	.word	04042H,107,19,014H
	.word	04042H,121,19,015H
	.word	0644H,121,122,0EH
	.word	04042H,128,19,016H
	.word	0544H,138,80,017H
	.word	04042H,142,19,018H
	.word	0644H,154,122,019H
	.word	04042H,156,19,012H
	.word	0544H,157,123,01AH
	.word	0544H,157,89,017H
	.word	04042H,169,19,01BH
	.word	04042H,176,19,01CH
	.word	0645H,179,78,01DH
	.word	0645H,182,140,01EH
	.word	048H,190,7,08H
	.word	048H,190,127,08H
	.word	048H,190,247,08H
	.word	0260H,193,254,03H
	.word	0140H,194,0,03H
	.word	0240H,194,250,03H
	.word	0241H,199,4,07H
	.word	04042H,202,19,01FH
	.word	04042H,223,19,020H
	.word	0644H,235,76,021H
	.word	04042H,237,19,012H
	.word	0644H,239,119,022H
	.word	0544H,239,85,0BH
	.word	0644H,242,119,023H
	.word	0644H,242,187,024H
	.word	0644H,242,122,025H
	.word	0544H,243,190,0FH
	.word	04042H,250,19,026H
	.word	0644H,253,85,021H
	.word	0544H,256,94,0BH
	.word	04042H,262,19,018H
	.word	0644H,275,122,025H
	.word	04042H,276,25,027H
	.word	0140H,286,0,03H
	.word	0260H,287,254,03H
	.word	0240H,288,250,03H
	.word	04042H,290,19,028H
	.word	0241H,293,4,07H
	.word	0240H,296,250,03H
	.word	0240H,296,0,03H
	.word	0260H,302,254,03H
	.word	04042H,304,19,029H
	.word	0644H,308,122,025H
	.word	0443H,325,25,02AH
	.word	0341H,326,26,02BH
	.word	0644H,339,122,025H
	.word	0544H,355,80,017H
	.word	048H,370,7,08H
	.word	048H,370,127,08H
	.word	048H,370,247,08H
	.word	0644H,372,122,02CH
	.word	0544H,373,89,017H
	.word	0544H,375,123,01AH
	.word	0140H,390,0,02DH
	.word	0140H,390,121,02H
	.word	0240H,390,128,02H
	.word	0240H,390,250,02EH
	.word	0240H,390,4,02H
	.word	0250H,394,4,02H
	.word	0250H,394,126,02H
	.word	0250H,394,128,02H
	.word	0250H,394,250,02EH
	.word	0150H,394,0,02DH
	.word	0260H,396,254,02EH
	.word	0FFFFH	;End Marker
finalBLKS:
	.word	0260H	;flags
	.word	0,254 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	0240H,0,107,02H
	.word	0240H,0,128,02H
	.word	0240H,0,4,02H
	.word	0240H,0,250,01H
	.word	0140H,0,0,00H
	.word	0260H,6,254,03H
	.word	0241H,6,4,06H
	.word	0241H,6,4,05H
	.word	0241H,6,128,04H
	.word	0140H,6,0,03H
	.word	0240H,6,250,03H
	.word	0241H,6,8,04H
	.word	048H,10,247,08H
	.word	048H,10,127,08H
	.word	048H,10,7,08H
	.word	0241H,10,4,07H
	.word	0644H,17,76,09H
	.word	0544H,21,85,0BH
	.word	0644H,21,119,0AH
	.word	0644H,24,122,0EH
	.word	0644H,24,187,0DH
	.word	0644H,24,119,0CH
	.word	0544H,25,190,0FH
	.word	0646H,33,204,02FH
	.word	0644H,36,85,09H
	.word	0546H,36,208,030H
	.word	0544H,40,94,0BH
	.word	0644H,57,122,0EH
	.word	0443H,69,25,010H
	.word	0341H,70,26,011H
	.word	0644H,90,122,0EH
	.word	0260H,100,254,03H
	.word	0240H,100,250,03H
	.word	0140H,100,0,03H
	.word	0241H,104,4,07H
	.word	0644H,121,122,0EH
	.word	04042H,129,18,031H
	.word	0544H,138,80,017H
	.word	04042H,140,18,032H
	.word	0646H,140,204,02FH
	.word	0546H,143,208,030H
	.word	04042H,147,18,033H
	.word	0644H,154,122,019H
	.word	0544H,157,89,017H
	.word	0544H,157,123,01AH
	.word	04042H,161,18,034H
	.word	04042H,175,18,035H
	.word	048H,190,247,08H
	.word	048H,190,127,08H
	.word	048H,190,7,08H
	.word	0260H,193,254,03H
	.word	0240H,194,250,03H
	.word	0140H,194,0,03H
	.word	04042H,197,18,036H
	.word	0241H,199,4,07H
	.word	04042H,210,18,037H
	.word	04042H,222,18,038H
	.word	0644H,235,76,021H
	.word	04042H,236,18,039H
	.word	0544H,239,85,0BH
	.word	0644H,239,119,022H
	.word	0644H,242,122,025H
	.word	0644H,242,187,024H
	.word	0644H,242,119,023H
	.word	0544H,243,190,0FH
	.word	04042H,250,18,03AH
	.word	0647H,250,204,02FH
	.word	0644H,253,85,021H
	.word	0546H,253,208,030H
	.word	0544H,256,94,0BH
	.word	0644H,275,122,025H
	.word	0341H,275,26,02BH
	.word	0443H,276,25,02AH
	.word	0140H,286,0,03H
	.word	0260H,287,254,03H
	.word	0240H,288,250,03H
	.word	0241H,293,4,07H
	.word	0240H,296,0,03H
	.word	0240H,296,250,03H
	.word	0260H,302,254,03H
	.word	0644H,308,122,025H
	.word	0644H,339,122,025H
	.word	0544H,355,80,017H
	.word	0647H,357,204,02FH
	.word	0546H,360,208,030H
	.word	048H,370,247,08H
	.word	048H,370,127,08H
	.word	048H,370,7,08H
	.word	0644H,372,122,02CH
	.word	0544H,373,89,017H
	.word	0544H,375,123,01AH
	.word	0240H,390,4,02H
	.word	0240H,390,250,02EH
	.word	0240H,390,128,02H
	.word	0140H,390,121,02H
	.word	0140H,390,0,02DH
	.word	0150H,394,0,02DH
	.word	0250H,394,250,02EH
	.word	0250H,394,128,02H
	.word	0250H,394,126,02H
	.word	0250H,394,4,02H
	.word	0260H,396,254,02EH
	.word	0FFFFH	;End Marker
matchupBMOD:
	.word	550,367,104	;x size, y size, #blocks
	.long	matchupBLKS, hbakHDRS, hbakPALS
finalBMOD:
	.word	550,367,103	;x size, y size, #blocks
	.long	finalBLKS, hbakHDRS, hbakPALS

scrnHDRS:
	.word	180,120	;x size, y size
	.long	052BB4A9H	;address
	.word	05000H
	.word	96,17
	.long	053A8FF1H
	.word	06000H
	.word	76,38
	.long	053AB631H
	.word	06000H
	.word	4,65
	.long	053AF9E1H
	.word	06000H
	.word	192,4
	.long	053AFFF9H
	.word	06000H
	.word	68,66
	.long	053B11F9H
	.word	05000H
	.word	16,22
	.long	053B69A1H
	.word	05000H
	.word	12,22
	.long	053B7081H
	.word	05000H
	.word	4,65
	.long	053B75A9H
	.word	05000H
	.word	120,4
	.long	053B7ABDH
	.word	06000H
	.word	4,107
	.long	053B85FDH
	.word	06000H
	.word	68,66
	.long	053B9005H
	.word	06000H
	.word	16,22
	.long	053BF935H
	.word	05000H
	.word	16,22
	.long	053C0015H
	.word	05000H
	.word	96,17
	.long	053C06F5H
	.word	06000H
statscrnBLKS:
	.word	041H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	041H,0,120,00H
	.word	041H,0,240,00H
	.word	04043H,0,7,01H
	.word	0443H,6,99,02H
	.word	0443H,6,34,03H
	.word	0443H,6,30,04H
	.word	0443H,6,137,04H
	.word	0443H,6,141,03H
	.word	0443H,6,206,02H
	.word	0444H,9,33,05H
	.word	0444H,9,140,05H
	.word	0542H,59,143,06H
	.word	0542H,62,36,07H
	.word	0443H,76,34,08H
	.word	0443H,76,141,08H
	.word	0443H,79,133,09H
	.word	0443H,79,240,09H
	.word	041H,180,0,00H
	.word	041H,180,120,00H
	.word	041H,180,240,00H
	.word	0543H,195,30,0AH
	.word	0543H,195,137,0AH
	.word	0440H,202,30,04H
	.word	0440H,202,34,03H
	.word	0440H,202,99,02H
	.word	0440H,202,137,04H
	.word	0440H,202,141,03H
	.word	0440H,202,206,02H
	.word	0444H,205,33,0BH
	.word	0444H,205,140,0BH
	.word	0545H,254,143,0CH
	.word	0545H,255,36,0DH
	.word	0440H,272,34,08H
	.word	0440H,272,141,08H
	.word	0440H,275,133,09H
	.word	0440H,275,240,09H
	.word	04040H,307,7,0EH
	.word	041H,360,0,00H
	.word	041H,360,120,00H
	.word	041H,360,240,00H
	.word	0540H,391,30,0AH
	.word	0540H,391,137,0AH
	.word	0FFFFH	;End Marker
statscrkBLKS:
	.word	04043H	;flags
	.word	0,7 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	041H,0,240,00H
	.word	041H,0,120,00H
	.word	041H,0,0,00H
	.word	0443H,6,206,02H
	.word	0443H,6,141,03H
	.word	0443H,6,137,04H
	.word	0443H,6,30,04H
	.word	0443H,6,34,03H
	.word	0443H,6,99,02H
	.word	0444H,9,140,05H
	.word	0444H,9,33,05H
	.word	0542H,62,36,07H
	.word	0443H,76,141,08H
	.word	0443H,76,34,08H
	.word	0443H,79,240,09H
	.word	0443H,79,133,09H
	.word	041H,180,240,00H
	.word	041H,180,120,00H
	.word	041H,180,0,00H
	.word	0543H,195,137,0AH
	.word	0543H,195,30,0AH
	.word	0440H,202,206,02H
	.word	0440H,202,141,03H
	.word	0440H,202,137,04H
	.word	0440H,202,99,02H
	.word	0440H,202,34,03H
	.word	0440H,202,30,04H
	.word	0444H,205,140,0BH
	.word	0444H,205,33,0BH
	.word	0545H,255,36,06H
	.word	0440H,272,141,08H
	.word	0440H,272,34,08H
	.word	0440H,275,240,09H
	.word	0440H,275,133,09H
	.word	04040H,307,7,0EH
	.word	041H,360,240,00H
	.word	041H,360,120,00H
	.word	041H,360,0,00H
	.word	0540H,391,137,0AH
	.word	0540H,391,30,0AH
	.word	0FFFFH	;End Marker
statscrnBMOD:
	.word	540,360,43	;x size, y size, #blocks
	.long	statscrnBLKS, scrnHDRS, scrnPALS
statscrkBMOD:
	.word	540,360,41	;x size, y size, #blocks
	.long	statscrkBLKS, scrnHDRS, scrnPALS

eHDRS:
	.word	200,36	;x size, y size
	.long	053C2D35H	;address
	.word	06000H
	.word	60,223
	.long	053CD5F5H
	.word	06000H
	.word	16,194
	.long	053E0F8DH
	.word	06000H
	.word	144,29
	.long	053E584DH
	.word	06000H
	.word	128,8
	.long	053EBA2DH
	.word	06000H
	.word	128,9
	.long	053ED22DH
	.word	06000H
	.word	132,88
	.long	053EED2DH
	.word	04000H
	.word	132,88
	.long	053EED2DH
	.word	04000H
	.word	132,4
	.long	053FA2ADH
	.word	00H
	.word	132,4
	.long	053FA2ADH
	.word	00H
	.word	228,9
	.long	053FB32DH
	.word	06000H
	.word	96,18
	.long	053FE345H
	.word	06000H
	.word	132,88
	.long	053EED2DH
	.word	04000H
	.word	132,4
	.long	053FA2ADH
	.word	00H
	.word	128,8
	.long	05400BC5H
	.word	06000H
	.word	200,36
	.long	054023C5H
	.word	06000H
	.word	144,29
	.long	053E584DH
	.word	06000H
	.word	60,223
	.long	0540CC85H
	.word	06000H
titleBLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,36,01H
	.word	04040H,59,36,02H
	.word	04040H,59,230,03H
	.word	04040H,72,36,04H
	.word	04040H,72,221,05H
	.word	04042H,72,133,06H
	.word	04042H,72,45,07H
	.word	04041H,72,45,08H
	.word	04341H,72,45,09H
	.word	03F40H,86,235,0AH
	.word	04340H,155,9,0BH
	.word	04042H,199,133,0CH
	.word	04042H,199,48,06H
	.word	04341H,199,44,0DH
	.word	04040H,200,36,0EH
	.word	04040H,200,221,05H
	.word	04040H,200,0,0FH
	.word	04040H,200,230,010H
	.word	04050H,325,36,02H
	.word	04040H,341,36,011H
	.word	0FFFFH	;End Marker
titleBMOD:
	.word	401,259,21	;x size, y size, #blocks
	.long	titleBLKS, eHDRS, ePALS

ratsHDRS:
	.word	8,4	;x size, y size
	.long	052B7741H	;address
	.word	06000H
	.word	8,4
	.long	052B7801H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	96,4
	.long	052B8FA1H
	.word	06000H
	.word	4,122
	.long	052B98A1H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	4,4
	.long	052B9E59H
	.word	03000H
	.word	96,4
	.long	052BB029H
	.word	03000H
	.word	180,120
	.long	052BB4A9H
	.word	05000H
	.word	8,122
	.long	0530E289H
	.word	06000H
	.word	8,122
	.long	0530CBA9H
	.word	06000H
	.word	4,4
	.long	0530F969H
	.word	06000H
	.word	4,4
	.long	0530CB49H
	.word	06000H
	.word	8,4
	.long	052EA9F1H
	.word	06000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
congratbBLKS:
	.word	0140H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0240H,0,250,01H
	.word	0240H,0,4,02H
	.word	0240H,0,128,02H
	.word	0240H,0,107,02H
	.word	0260H,0,254,01H
	.word	0240H,6,250,03H
	.word	0140H,6,0,03H
	.word	0241H,6,128,04H
	.word	0241H,6,4,05H
	.word	0241H,6,4,06H
	.word	0260H,6,254,03H
	.word	0241H,6,8,04H
	.word	0241H,6,4,04H
	.word	0241H,10,4,07H
	.word	043H,10,7,08H
	.word	043H,10,127,08H
	.word	043H,10,247,08H
	.word	0140H,100,0,03H
	.word	0240H,100,250,03H
	.word	0260H,100,254,03H
	.word	0241H,104,4,07H
	.word	043H,190,7,08H
	.word	043H,190,127,08H
	.word	043H,190,247,08H
	.word	0260H,193,254,03H
	.word	0140H,194,0,03H
	.word	0240H,194,250,03H
	.word	0340H,196,4,09H
	.word	0340H,196,128,09H
	.word	0340H,196,91,0AH
	.word	04040H,196,250,0BH
	.word	04040H,196,0,0CH
	.word	0241H,199,4,07H
	.word	0441H,200,4,04H
	.word	0441H,200,128,04H
	.word	0441H,200,74,04H
	.word	0140H,286,0,03H
	.word	0260H,287,254,03H
	.word	0240H,288,250,03H
	.word	0241H,293,4,07H
	.word	0240H,296,250,03H
	.word	0240H,296,0,03H
	.word	0260H,302,254,03H
	.word	043H,370,7,08H
	.word	043H,370,127,08H
	.word	043H,370,247,08H
	.word	0140H,390,0,0DH
	.word	0140H,390,121,02H
	.word	0240H,390,128,02H
	.word	0240H,390,250,0EH
	.word	0240H,390,4,02H
	.word	0250H,394,4,02H
	.word	0250H,394,126,02H
	.word	0250H,394,128,02H
	.word	0250H,394,250,0EH
	.word	0150H,394,0,0DH
	.word	0260H,396,254,0EH
	.word	0FFFFH	;End Marker

;file congrats blocks not in any module
;	.word	0260H	;flags
;	.word	1082,505 ;x,y
;	.word	01H	;pal5,pal4,hdr13-0
;	.word	0240H,1082,358,02H
;	.word	0240H,1082,379,02H
;	.word	0240H,1082,255,02H
;	.word	0240H,1082,501,01H
;	.word	0140H,1082,251,00H
;	.word	0260H,1088,505,03H
;	.word	0242H,1088,255,06H
;	.word	0241H,1088,255,05H
;	.word	0242H,1088,379,04H
;	.word	0140H,1088,251,03H
;	.word	0240H,1088,501,03H
;	.word	0242H,1088,258,04H
;	.word	044H,1092,498,08H
;	.word	044H,1092,378,08H
;	.word	044H,1092,258,08H
;	.word	0242H,1092,255,07H
;	.word	0260H,1182,505,03H
;	.word	0240H,1182,501,03H
;	.word	0140H,1182,251,03H
;	.word	0242H,1186,255,07H
;	.word	044H,1272,498,08H
;	.word	044H,1272,378,08H
;	.word	044H,1272,258,08H
;	.word	0260H,1275,505,03H
;	.word	0240H,1276,501,03H
;	.word	0140H,1276,251,03H
;	.word	0340H,1278,255,09H
;	.word	0340H,1278,379,09H
;	.word	0340H,1278,325,09H
;	.word	04040H,1278,251,0CH
;	.word	04040H,1278,501,0BH
;	.word	0242H,1281,255,07H
;	.word	0442H,1282,379,04H
;	.word	0442H,1282,255,04H
;	.word	0442H,1282,355,04H
;	.word	0140H,1368,251,03H
;	.word	0260H,1369,505,03H
;	.word	0240H,1370,501,03H
;	.word	0242H,1375,255,07H
;	.word	0240H,1378,251,03H
;	.word	0240H,1378,501,03H
;	.word	0260H,1384,505,03H
;	.word	044H,1452,498,08H
;	.word	044H,1452,378,08H
;	.word	044H,1452,258,08H
;	.word	0240H,1472,255,02H
;	.word	0240H,1472,501,0EH
;	.word	0240H,1472,379,02H
;	.word	0140H,1472,372,02H
;	.word	0140H,1472,251,0DH
;	.word	0150H,1476,251,0DH
;	.word	0250H,1476,501,0EH
;	.word	0250H,1476,379,02H
;	.word	0250H,1476,377,02H
;	.word	0250H,1476,255,02H
;	.word	0260H,1478,505,0EH
;	.word	0FFFFH	;End Marker
congratbBMOD:
	.word	550,367,58	;x size, y size, #blocks
	.long	congratbBLKS, ratsHDRS, ratsPALS

timeHDRS:
	.word	200,36	;x size, y size
	.long	053C2D35H	;address
	.word	06000H
	.word	60,223
	.long	053CD5F5H
	.word	06000H
	.word	16,194
	.long	053E0F8DH
	.word	06000H
	.word	144,29
	.long	053E584DH
	.word	06000H
	.word	128,8
	.long	053EBA2DH
	.word	06000H
	.word	128,9
	.long	053ED22DH
	.word	06000H
	.word	132,7
	.long	0542061DH
	.word	05000H
	.word	132,7
	.long	05421829H
	.word	05000H
	.word	132,8
	.long	05422A35H
	.word	04000H
	.word	16,76
	.long	05423AB5H
	.word	04000H
	.word	100,8
	.long	05424DB5H
	.word	04000H
	.word	76,51
	.long	05425A35H
	.word	04000H
	.word	96,18
	.long	053FE345H
	.word	06000H
	.word	16,76
	.long	054296C5H
	.word	04000H
	.word	132,7
	.long	0542A9C5H
	.word	05000H
	.word	132,7
	.long	0542BBD1H
	.word	05000H
	.word	128,8
	.long	05400BC5H
	.word	06000H
	.word	200,36
	.long	054023C5H
	.word	06000H
	.word	144,29
	.long	053E584DH
	.word	06000H
	.word	64,65
	.long	0542CDDDH
	.word	06000H
	.word	60,223
	.long	0540CC85H
	.word	06000H
htclipsBLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,36,01H
	.word	04040H,58,36,02H
	.word	04040H,59,230,03H
	.word	04040H,71,36,04H
	.word	04040H,71,221,05H
	.word	04042H,71,127,06H
	.word	04042H,71,214,07H
	.word	04042H,71,44,08H
	.word	04042H,71,52,09H
	.word	04042H,71,140,09H
	.word	04042H,71,132,08H
	.word	04042H,87,120,0AH
	.word	04042H,87,208,0AH
	.word	04041H,98,149,0BH
	.word	04040H,152,10,0CH
	.word	04042H,187,52,0DH
	.word	04042H,187,140,0DH
	.word	04042H,195,127,0EH
	.word	04052H,195,52,0DH
	.word	04052H,195,44,08H
	.word	04052H,195,132,08H
	.word	04052H,195,140,0DH
	.word	04042H,196,214,0FH
	.word	04040H,199,36,010H
	.word	04040H,199,221,05H
	.word	04040H,200,0,011H
	.word	04040H,200,230,012H
	.word	04052H,211,120,0AH
	.word	04052H,211,208,0AH
	.word	04043H,231,53,013H
	.word	04052H,311,52,09H
	.word	04052H,311,140,09H
	.word	04050H,324,36,02H
	.word	04040H,341,36,014H
	.word	0FFFFH	;End Marker
htclipsBMOD:
	.word	401,259,35	;x size, y size, #blocks
	.long	htclipsBLKS, timeHDRS, timePALS

er2HDRS:
	.word	180,120	;x size, y size
	.long	052BB4A9H	;address
	.word	05000H
	.word	132,9
	.long	0539E851H
	.word	06000H
	.word	120,4
	.long	052BA6C9H
	.word	05000H
	.word	136,71
	.long	05432F5DH
	.word	06000H
	.word	132,4
	.long	05393265H
	.word	05000H
	.word	16,9
	.long	052E98A5H
	.word	05000H
	.word	4,71
	.long	052E7699H
	.word	05000H
	.word	92,71
	.long	054411ADH
	.word	05000H
	.word	56,60
	.long	05449141H
	.word	00H
	.word	16,65
	.long	0544FA41H
	.word	04000H
	.word	12,37
	.long	05450A81H
	.word	04000H
	.word	188,183
	.long	05451171H
	.word	00H
	.word	16,65
	.long	0544FA41H
	.word	04000H
	.word	12,35
	.long	05494491H
	.word	04000H
	.word	72,62
	.long	05494B21H
	.word	00H
ladderBLKS:
	.word	040H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	040H,0,120,00H
	.word	040H,0,240,00H
	.word	02841H,121,304,01H
	.word	02841H,121,125,01H
	.word	02341H,125,313,02H
	.word	02341H,125,134,02H
	.word	04041H,127,200,03H
	.word	04041H,127,21,03H
	.word	04041H,131,271,04H
	.word	04041H,131,92,04H
	.word	02841H,142,313,01H
	.word	02841H,142,134,01H
	.word	02341H,147,143,02H
	.word	02341H,148,322,02H
	.word	040H,180,0,00H
	.word	040H,180,120,00H
	.word	040H,180,240,00H
	.word	02341H,243,307,05H
	.word	02341H,243,128,05H
	.word	04041H,263,204,06H
	.word	02341H,263,317,05H
	.word	04041H,263,24,06H
	.word	02341H,263,138,05H
	.word	040H,360,0,00H
	.word	040H,360,120,00H
	.word	040H,360,240,00H
	.word	0FFFFH	;End Marker
dabullBLKS:
	.word	040H	;flags
	.word	180,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	040H,180,120,00H
	.word	040H,180,240,00H
	.word	04045H,222,172,07H
	.word	04044H,226,180,08H
	.word	04056H,285,175,09H
	.word	04047H,290,189,0AH
	.word	04042H,291,22,0BH
	.word	040H,360,0,00H
	.word	040H,360,120,00H
	.word	040H,360,240,00H
	.word	04045H,450,172,07H
	.word	04056H,455,175,0CH
	.word	04047H,460,190,0DH
	.word	04043H,466,178,0EH
	.word	040H,540,240,00H
	.word	040H,540,120,00H
	.word	040H,540,0,00H
	.word	0FFFFH	;End Marker
ladderBMOD:
	.word	540,360,27	;x size, y size, #blocks
	.long	ladderBLKS, er2HDRS, er2PALS
dabullBMOD:
	.word	720,360,18	;x size, y size, #blocks
	.long	dabullBLKS, er2HDRS, er2PALS

gmHDRS:
	.word	36,49	;x size, y size
	.long	0549D6A1H	;address
	.word	05000H
	.word	124,10
	.long	0549F915H
	.word	05000H
	.word	76,22
	.long	054A114DH
	.word	05000H
	.word	132,28
	.long	054A31F5H
	.word	05000H
	.word	44,13
	.long	054A7A25H
	.word	05000H
	.word	140,12
	.long	054A8551H
	.word	05000H
	.word	96,187
	.long	054AA621H
	.word	07000H
loveBLKS:
	.word	04040H	;flags
	.word	0,5 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,30,215,01H
	.word	04040H,55,50,02H
	.word	04040H,99,146,03H
	.word	04040H,112,99,04H
	.word	04040H,157,215,05H
	.word	04041H,242,0,06H
	.word	0FFFFH	;End Marker
loveBMOD:
	.word	338,227,7	;x size, y size, #blocks
	.long	loveBLKS, gmHDRS, gmPALS

ks1HDRS:
	.word	52,42	;x size, y size
	.long	054C9101H	;address
	.word	00H
	.word	44,98
	.long	054CD541H
	.word	00H
	.word	40,41
	.long	054D5C01H
	.word	00H
	.word	52,126
	.long	054D8F41H
	.word	00H
	.word	76,167
	.long	054E5C01H
	.word	00H
	.word	236,44
	.long	054FE8A1H
	.word	00H
	.word	36,90
	.long	05512D21H
	.word	06000H
	.word	96,23
	.long	05517911H
	.word	00H
	.word	88,63
	.long	0551BE11H
	.word	00H
	.word	96,35
	.long	05526B51H
	.word	00H
	.word	16,19
	.long	0552D451H
	.word	00H
	.word	60,50
	.long	0552DDD1H
	.word	00H
	.word	44,35
	.long	05533B91H
	.word	00H
	.word	68,37
	.long	05536BB1H
	.word	00H
	.word	8,16
	.long	0553BA51H
	.word	00H
	.word	52,33
	.long	0553BE51H
	.word	00H
	.word	60,37
	.long	0553F3F1H
	.word	00H
	.word	56,60
	.long	05543951H
	.word	00H
	.word	52,50
	.long	0554A251H
	.word	00H
	.word	36,54
	.long	0554F391H
	.word	00H
	.word	136,165
	.long	05553051H
	.word	00H
	.word	36,27
	.long	0557ED91H
	.word	07000H
	.word	108,87
	.long	05580825H
	.word	00H
	.word	84,134
	.long	05592DC5H
	.word	00H
	.word	88,17
	.long	055A8D85H
	.word	00H
	.word	48,56
	.long	055ABC45H
	.word	00H
	.word	24,45
	.long	055B1045H
	.word	00H
	.word	48,51
	.long	055B3205H
	.word	00H
	.word	92,44
	.long	055B7E85H
	.word	00H
	.word	52,50
	.long	055BFD05H
	.word	00H
	.word	40,26
	.long	055C4E45H
	.word	00H
	.word	36,29
	.long	055C6EC5H
	.word	00H
	.word	64,24
	.long	055C8F65H
	.word	00H
	.word	44,21
	.long	055CBF65H
	.word	00H
	.word	40,43
	.long	055CDC45H
	.word	00H
	.word	76,24
	.long	055D1205H
	.word	00H
	.word	36,50
	.long	055D4B05H
	.word	00H
	.word	36,45
	.long	055D8345H
	.word	00H
	.word	68,111
	.long	055DB5E5H
	.word	00H
	.word	36,73
	.long	055EA1C5H
	.word	00H
	.word	68,202
	.long	055EF3E5H
	.word	00H
	.word	64,57
	.long	0560A125H
	.word	00H
	.word	40,77
	.long	05611325H
	.word	00H
chksaBLKS:
	.word	04040H	;flags
	.word	0,213 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04048H,0,132,01H
	.word	04040H,0,126,02H
	.word	04040H,0,0,03H
	.word	04041H,19,59,01004H
	.word	04043H,21,0,01005H
	.word	04043H,27,44,01006H
	.word	04047H,49,232,07H
	.word	04046H,51,184,01008H
	.word	04041H,53,24,01009H
	.word	04046H,75,165,0100AH
	.word	0404CH,79,150,0BH
	.word	0404CH,81,116,0CH
	.word	04044H,86,97,0100DH
	.word	04044H,91,81,0100EH
	.word	04045H,93,48,0FH
	.word	04046H,95,69,010H
	.word	04044H,105,135,011H
	.word	0404DH,124,180,012H
	.word	04041H,125,93,01013H
	.word	04043H,127,22,014H
	.word	0404DH,139,228,015H
	.word	04042H,163,168,016H
	.word	04042H,209,17,01017H
	.word	04042H,246,0,01018H
	.word	04040H,248,166,01019H
	.word	04046H,254,127,0101AH
	.word	0404FH,255,132,01BH
	.word	04046H,263,211,0101CH
	.word	04049H,263,31,01DH
	.word	0404AH,264,73,01EH
	.word	04045H,268,16,0101FH
	.word	04040H,271,196,01020H
	.word	0404EH,273,118,021H
	.word	04046H,280,164,01022H
	.word	04046H,281,108,01023H
	.word	0404BH,286,63,024H
	.word	0404EH,295,125,025H
	.word	04045H,302,15,01026H
	.word	04046H,320,132,01027H
	.word	04042H,332,0,01028H
	.word	04041H,334,198,029H
	.word	0404FH,335,119,02AH
	.word	0FFFFH	;End Marker
chksaBMOD:
	.word	400,255,43	;x size, y size, #blocks
	.long	chksaBLKS, ks1HDRS, ks1PALS

icHDRS:
	.word	108,58	;x size, y size
	.long	05617365H	;address
	.word	00H
	.word	116,182
	.long	05623725H
	.word	00H
	.word	64,61
	.long	0564CAE5H
	.word	00H
	.word	156,38
	.long	056544E5H
	.word	00H
	.word	44,80
	.long	0565FE25H
	.word	06000H
	.word	32,28
	.long	056650A5H
	.word	00H
	.word	20,30
	.long	05666CA5H
	.word	00H
	.word	72,37
	.long	05667F65H
	.word	00H
	.word	72,47
	.long	0566D2A5H
	.word	00H
	.word	24,44
	.long	05673C65H
	.word	00H
	.word	40,30
	.long	05675D65H
	.word	00H
	.word	72,33
	.long	056782E5H
	.word	00H
	.word	132,45
	.long	0567CD25H
	.word	00H
	.word	200,41
	.long	056886C5H
	.word	00H
	.word	124,18
	.long	05698705H
	.word	00H
	.word	88,63
	.long	0569CCC5H
	.word	00H
	.word	20,12
	.long	056A7A05H
	.word	00H
	.word	20,46
	.long	056A8185H
	.word	00H
	.word	44,39
	.long	056A9E45H
	.word	00H
	.word	60,47
	.long	056AD3E5H
	.word	00H
	.word	52,36
	.long	056B2C05H
	.word	00H
	.word	36,38
	.long	056B6685H
	.word	00H
	.word	32,27
	.long	056B9145H
	.word	00H
	.word	88,74
	.long	056BAC45H
	.word	00H
	.word	60,70
	.long	056C77C5H
	.word	00H
	.word	80,34
	.long	056CFB05H
	.word	00H
	.word	88,49
	.long	056D5005H
	.word	00H
	.word	144,50
	.long	056DD6C5H
	.word	00H
	.word	20,39
	.long	056EB7C5H
	.word	00H
	.word	64,30
	.long	056ED025H
	.word	00H
	.word	12,12
	.long	056F0C25H
	.word	07000H
	.word	40,54
	.long	056F1015H
	.word	00H
	.word	40,31
	.long	056F5395H
	.word	00H
	.word	40,23
	.long	056F7A55H
	.word	00H
	.word	12,32
	.long	056F9715H
	.word	00H
	.word	44,63
	.long	056FA315H
	.word	00H
	.word	88,53
	.long	056FF9B5H
	.word	00H
	.word	84,137
	.long	05708B75H
	.word	00H
	.word	16,37
	.long	0571F315H
	.word	07000H
	.word	92,87
	.long	05720345H
	.word	00H
	.word	44,63
	.long	0572FD65H
	.word	00H
	.word	40,63
	.long	05735405H
	.word	00H
	.word	164,79
	.long	0573A2C5H
	.word	00H
	.word	100,55
	.long	057537A5H
	.word	00H
	.word	176,33
	.long	0575E385H
	.word	00H
	.word	128,48
	.long	05769905H
	.word	00H
	.word	16,40
	.long	05775905H
	.word	00H
	.word	48,80
	.long	05776D05H
	.word	00H
	.word	60,39
	.long	0577E505H
	.word	00H
	.word	8,20
	.long	05782E25H
	.word	00H
	.word	48,56
	.long	05783325H
	.word	00H
	.word	112,66
	.long	05788725H
	.word	00H
	.word	72,61
	.long	05796E25H
	.word	00H
	.word	28,21
	.long	0579F765H
	.word	00H
	.word	56,32
	.long	057A09C5H
	.word	00H
	.word	116,46
	.long	057A41C5H
	.word	00H
	.word	64,36
	.long	057AE885H
	.word	00H
	.word	28,24
	.long	057B3085H
	.word	00H
	.word	36,27
	.long	057B4585H
	.word	06000H
	.word	56,50
	.long	057B5C4DH
	.word	00H
	.word	28,31
	.long	057BB3CDH
	.word	00H
	.word	52,61
	.long	057BCEEDH
	.word	00H
	.word	60,114
	.long	057C320DH
	.word	06000H
	.word	40,76
	.long	057CD25DH
	.word	00H
	.word	52,46
	.long	057D315DH
	.word	00H
	.word	40,38
	.long	057D7C1DH
	.word	00H
	.word	36,27
	.long	057DAB9DH
	.word	00H
chrvic1BLKS:
	.word	04048H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04047H,0,58,01H
	.word	04040H,81,134,01002H
	.word	0404BH,104,12,03H
	.word	0404BH,104,50,04H
	.word	04048H,106,0,05H
	.word	04040H,107,104,01006H
	.word	04040H,109,67,07H
	.word	04049H,113,163,08H
	.word	0404AH,114,196,09H
	.word	04042H,125,104,0AH
	.word	04043H,126,193,0BH
	.word	0404AH,132,41,0CH
	.word	04049H,134,199,0DH
	.word	04048H,136,0,0EH
	.word	04046H,139,137,0FH
	.word	0404FH,143,134,010H
	.word	0404FH,163,104,011H
	.word	0404AH,173,86,012H
	.word	0404EH,181,124,013H
	.word	0404AH,189,125,014H
	.word	0404EH,196,171,015H
	.word	0404CH,198,191,016H
	.word	0404CH,209,70,017H
	.word	0404CH,228,144,018H
	.word	04048H,235,49,019H
	.word	04049H,255,117,01AH
	.word	04048H,258,0,01BH
	.word	04049H,280,165,01CH
	.word	0404DH,284,54,01DH
	.word	0404DH,284,84,01EH
	.word	0404CH,288,158,01FH
	.word	04044H,293,82,020H
	.word	04045H,295,113,021H
	.word	04049H,308,166,022H
	.word	04041H,314,127,023H
	.word	04048H,315,50,024H
	.word	04047H,320,103,025H
	.word	0404DH,332,83,026H
	.word	0FFFFH	;End Marker
chrvic2BLKS:
	.word	04048H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	047H,0,58,01H
	.word	04041H,50,80,01027H
	.word	04043H,78,167,01028H
	.word	04044H,102,142,01029H
	.word	04BH,104,12,03H
	.word	04049H,104,48,0102AH
	.word	04BH,104,50,04H
	.word	04048H,106,0,05H
	.word	04AH,114,196,09H
	.word	04043H,121,173,0102BH
	.word	04044H,134,207,0102CH
	.word	04048H,136,0,0EH
	.word	04047H,140,0,0102DH
	.word	04043H,141,120,0102EH
	.word	04044H,142,122,0102FH
	.word	04043H,154,109,01030H
	.word	04043H,180,148,01031H
	.word	04049H,186,129,01032H
	.word	04048H,196,152,01033H
	.word	04048H,204,79,01034H
	.word	04045H,223,138,01035H
	.word	04048H,235,49,019H
	.word	04044H,235,125,01036H
	.word	04047H,236,50,01037H
	.word	04045H,243,191,01038H
	.word	04048H,258,0,01BH
	.word	04045H,258,119,01039H
	.word	04047H,272,96,0103AH
	.word	04046H,282,87,0103BH
	.word	04045H,282,128,0103CH
	.word	04044H,286,145,0103DH
	.word	04047H,302,126,0103EH
	.word	04045H,304,151,0103FH
	.word	04042H,305,103,01040H
	.word	048H,315,50,024H
	.word	047H,320,103,025H
	.word	04046H,332,115,01041H
	.word	04046H,336,88,01042H
	.word	0FFFFH	;End Marker
chrvic1BMOD:
	.word	404,240,39	;x size, y size, #blocks
	.long	chrvic1BLKS, icHDRS, icPALS
chrvic2BMOD:
	.word	404,240,39	;x size, y size, #blocks
	.long	chrvic2BLKS, icHDRS, icPALS

ackkHDRS:
	.word	8,4	;x size, y size
	.long	052B7801H	;address
	.word	06000H
	.word	12,122
	.long	052EE429H
	.word	06000H
	.word	12,122
	.long	052EC1D9H
	.word	06000H
	.word	8,4
	.long	052B7741H
	.word	06000H
	.word	96,4
	.long	052B8FA1H
	.word	06000H
	.word	96,8
	.long	053018F9H
	.word	06000H
	.word	96,122
	.long	052F0679H
	.word	06000H
	.word	40,171
	.long	05302AF9H
	.word	06000H
	.word	4,4
	.long	0530F969H
	.word	06000H
	.word	4,4
	.long	0530CB49H
	.word	06000H
	.word	8,122
	.long	0530CBA9H
	.word	06000H
	.word	8,122
	.long	0530E289H
	.word	06000H
	.word	56,172
	.long	0530F9C9H
	.word	06000H
	.word	8,4
	.long	052EAAB1H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	8,122
	.long	052B78C1H
	.word	06000H
	.word	8,4
	.long	052EA9F1H
	.word	06000H
	.word	188,11
	.long	0533C729H
	.word	06000H
	.word	8,50
	.long	0533BDC9H
	.word	06000H
	.word	172,8
	.long	05344AE1H
	.word	06000H
	.word	172,6
	.long	053432B1H
	.word	06000H
	.word	84,36
	.long	0533F7A1H
	.word	05000H
	.word	56,14
	.long	053471E1H
	.word	06000H
	.word	52,11
	.long	05348441H
	.word	06000H
	.word	8,50
	.long	053491A9H
	.word	06000H
	.word	8,28
	.long	05349B09H
	.word	05000H
	.word	84,36
	.long	05349F69H
	.word	04000H
	.word	8,28
	.long	0534CEA9H
	.word	06000H
selbackkBLKS:
	.word	0240H	;flags
	.word	0,250 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0240H,0,128,01H
	.word	0240H,0,116,01H
	.word	0240H,0,4,02H
	.word	0240H,0,0,03H
	.word	0240H,5,250,04H
	.word	0240H,5,0,05H
	.word	040H,5,128,06H
	.word	040H,5,6,06H
	.word	0240H,61,0,05H
	.word	0240H,67,250,04H
	.word	0140H,78,20,07H
	.word	040H,82,6,06H
	.word	040H,82,128,06H
	.word	0240H,102,0,05H
	.word	0240H,103,250,04H
	.word	040H,103,128,06H
	.word	040H,103,6,06H
	.word	0240H,196,250,08H
	.word	0240H,196,0,09H
	.word	0240H,196,4,0AH
	.word	0240H,196,117,0BH
	.word	0240H,196,128,0BH
	.word	0240H,200,250,04H
	.word	0240H,200,0,05H
	.word	040H,200,128,06H
	.word	040H,200,6,06H
	.word	0240H,241,250,04H
	.word	0240H,249,0,05H
	.word	040H,256,7,06H
	.word	040H,256,128,06H
	.word	0140H,268,20,0CH
	.word	0240H,297,250,04H
	.word	0240H,297,0,05H
	.word	040H,298,8,06H
	.word	040H,298,129,06H
	.word	0240H,390,250,0DH
	.word	0240H,390,128,0EH
	.word	0240H,390,124,0EH
	.word	0240H,390,4,0FH
	.word	0240H,390,0,010H
	.word	0FFFFH	;End Marker
nameboxkBLKS:
	.word	05F44H	;flags
	.word	0,42 ;x,y
	.word	011H	;pal5,pal4,hdr13-0
	.word	06441H,0,0,012H
	.word	06441H,6,42,013H
	.word	06441H,6,0,014H
	.word	05F42H,6,6,015H
	.word	05F42H,56,6,015H
	.word	05F42H,95,6,015H
	.word	06044H,164,42,016H
	.word	06441H,165,43,017H
	.word	06441H,178,0,018H
	.word	05F44H,180,15,019H
	.word	05F44H,180,4,019H
	.word	06441H,194,0,012H
	.word	05F44H,195,42,011H
	.word	06441H,200,42,013H
	.word	05F42H,200,6,01AH
	.word	06441H,200,0,014H
	.word	05F42H,246,6,01AH
	.word	05F42H,289,6,01AH
	.word	06441H,372,0,018H
	.word	05F44H,373,4,01BH
	.word	05F44H,373,15,01BH
	.word	0FFFFH	;End Marker
selbackkBMOD:
	.word	398,254,41	;x size, y size, #blocks
	.long	selbackkBLKS, ackkHDRS, ackkPALS
nameboxkBMOD:
	.word	383,56,22	;x size, y size, #blocks
	.long	nameboxkBLKS, ackkHDRS, ackkPALS
