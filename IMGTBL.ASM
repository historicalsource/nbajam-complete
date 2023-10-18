	.FILE "imgtbl.asm"
	.OPTION B,D,L,T

	.include imgtbl.glo
	.DATA
	.even

shadow1:
	.word   59,9,29,4
	.long   04a35215H
	.word   01000H
	.long   shad_p
shadow2:
	.word   55,7,27,3
	.long   04a35428H
	.word   01000H
	.long   shad_p
shadow3:
	.word   51,7,25,3
	.long   04a355a9H
	.word   01000H
	.long   shad_p
shadow4:
	.word   49,7,24,3
	.long   04a3570eH
	.word   01000H
	.long   shad_p
shadow5:
	.word   47,7,23,3
	.long   04a35865H
	.word   01000H
	.long   shad_p
shadow6:
	.word   45,7,22,3
	.long   04a359aeH
	.word   01000H
	.long   shad_p
shadow7:
	.word   43,6,21,2
	.long   04a35ae9H
	.word   01000H
	.long   shad_p
shadow8:
	.word   43,5,21,2
	.long   04a35bebH
	.word   01000H
	.long   shad_p
shadow9:
	.word   39,5,19,2
	.long   04a35cc2H
	.word   01000H
	.long   shad_p
shadow10:
	.word   37,5,18,2
	.long   04a35d85H
	.word   01000H
	.long   shad_p
shadow11:
	.word   35,5,17,2
	.long   04a35e3eH
	.word   01000H
	.long   shad_p
ball11:
	.word   11,11,5,10
	.long   04a35eedH
	.word   07000H
	.long   BALL_p
shadow12:
	.word   31,5,15,2
	.long   04a3623cH
	.word   01000H
	.long   shad_p
shadow13:
	.word   29,5,15,2
	.long   04a362d7H
	.word   01000H
	.long   shad_p
shadow14:
	.word   27,5,14,2
	.long   04a36368H
	.word   01000H
	.long   shad_p
shadow15:
	.word   25,5,13,2
	.long   04a363efH
	.word   01000H
	.long   shad_p
ballshad5:
	.word   14,4,7,2
	.long   04a3646cH
	.word   01000H
	.long   shad_p
reftip1:
	.word   33,91,13,82
	.long   04b0d4b4H
	.word   00H
	.long   Ref_p
	.word   7,35,5,0
reftip10:
	.word   36,73,14,62
	.long   04b1328cH
	.word   00H
	.long   Ref_p
	.word   7,48,5,0
reftip11:
	.word   32,76,13,65
	.long   04b184acH
	.word   00H
	.long   Ref_p
	.word   7,56,5,0
reftip12:
	.word   30,89,11,79
	.long   04b1d0acH
	.word   00H
	.long   Ref_p
	.word   9,27,5,0
reftip13:
	.word   33,118,12,107
	.long   04b2241cH
	.word   00H
	.long   Ref_p
	.word   8,7,-1,0
reftip14:
	.word   36,111,14,102
	.long   04b29dccH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
reftip15:
	.word   45,94,26,86
	.long   04b31aacH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
reftip16:
	.word   43,94,25,86
	.long   04b39edcH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
reftip2:
	.word   33,91,13,82
	.long   04b41d2cH
	.word   00H
	.long   Ref_p
	.word   7,35,5,0
reftip3:
	.word   33,91,13,82
	.long   04b47b04H
	.word   00H
	.long   Ref_p
	.word   7,35,5,0
reftip4:
	.word   31,88,13,80
	.long   04b4d8dcH
	.word   00H
	.long   Ref_p
	.word   7,37,5,0
reftip5:
	.word   31,90,13,81
	.long   04b52e1cH
	.word   00H
	.long   Ref_p
	.word   7,36,5,0
reftip6:
	.word   34,92,13,82
	.long   04b5854cH
	.word   00H
	.long   Ref_p
	.word   7,35,5,0
reftip7:
	.word   34,89,14,80
	.long   04b5e70cH
	.word   00H
	.long   Ref_p
	.word   7,35,5,0
reftip8:
	.word   32,86,13,77
	.long   04b6459cH
	.word   00H
	.long   Ref_p
	.word   8,35,5,0
reftip9:
	.word   40,83,17,73
	.long   04b69b9cH
	.word   00H
	.long   Ref_p
	.word   8,42,5,0
refbk1:
	.word   37,87,18,85
	.long   04b7035cH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refbk2:
	.word   39,87,19,85
	.long   04b767f4H
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refbk3:
	.word   44,89,20,85
	.long   04b7d1fcH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refbk4:
	.word   47,89,21,85
	.long   04b84c5cH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refbk5:
	.word   45,88,21,86
	.long   04b8cf14H
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refbk6:
	.word   44,87,23,85
	.long   04b94ad4H
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refbk7:
	.word   42,87,23,85
	.long   04b9c274H
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refbk8:
	.word   37,89,22,86
	.long   04ba34a4H
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refsqt5:
	.word   48,84,29,83
	.long   04ba9b8cH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
refsqt4:
	.word   37,83,21,81
	.long   04bb198cH
	.word   00H
	.long   Ref_p
	.word   0,0,0,0
t0000:
	.word   55,14,27,0
	.long   04bb7984H
	.word   05000H
	.long   timers_p
tx000:
	.word   55,14,27,0
	.long   04bb888eH
	.word   05000H
	.long   timers_p
txx00:
	.word   55,14,27,0
	.long   04bb9798H
	.word   05000H
	.long   timers_p
txxx0:
	.word   55,14,27,0
	.long   04bba6a2H
	.word   05000H
	.long   timers_p
txxxx:
	.word   55,14,27,0
	.long   04bbb5acH
	.word   05000H
	.long   timers_p
t1000:
	.word   55,14,27,0
	.long   04bbc4b6H
	.word   05000H
	.long   timers_p
t1100:
	.word   55,14,27,0
	.long   04bbd3c0H
	.word   05000H
	.long   timers_p
t1110:
	.word   55,14,27,0
	.long   04bbe2caH
	.word   05000H
	.long   timers_p
t1111:
	.word   55,14,27,0
	.long   04bbf1d4H
	.word   05000H
	.long   timers_p
tx100:
	.word   55,14,27,0
	.long   04bc00deH
	.word   05000H
	.long   timers_p
tx110:
	.word   55,14,27,0
	.long   04bc0fe8H
	.word   05000H
	.long   timers_p
tx111:
	.word   55,14,27,0
	.long   04bc1ef2H
	.word   05000H
	.long   timers_p
txx10:
	.word   55,14,27,0
	.long   04bc2dfcH
	.word   05000H
	.long   timers_p
txx11:
	.word   55,14,27,0
	.long   04bc3d06H
	.word   05000H
	.long   timers_p
txxx1:
	.word   55,14,27,0
	.long   04bc4c10H
	.word   05000H
	.long   timers_p
balltimers:
	.word   55,29,0,0
	.long   04bc5b1aH
	.word   05000H
	.long   timers_p
PETRO:
	.word   34,9,16,0
	.long   04bc7a41H
	.word   06000H
	.long   scorep
NEWCOMER:
	.word   61,9,30,0
	.long   04bc816dH
	.word   06000H
	.long   scorep
OURSLER:
	.word   47,9,23,0
	.long   04bc8e4bH
	.word   06000H
	.long   scorep
MORRIS:
	.word   64,9,31,0
	.long   04bc9835H
	.word   06000H
	.long   scorep
HOWARD:
	.word   46,9,22,0
	.long   04bca5b5H
	.word   06000H
	.long   scorep
SCOTT:
	.word   34,9,16,0
	.long   04bcaf69H
	.word   06000H
	.long   scorep
MCLEARN:
	.word   52,9,25,0
	.long   04bcb695H
	.word   06000H
	.long   scorep
HEY:
	.word   20,9,9,0
	.long   04bcc18dH
	.word   06000H
	.long   scorep
CARLTON:
	.word   46,9,22,0
	.long   04bcc5c5H
	.word   06000H
	.long   scorep
GOSKIE:
	.word   37,9,18,0
	.long   04bccf79H
	.word   06000H
	.long   scorep
DIVITA:
	.word   36,9,17,0
	.long   04bcd747H
	.word   06000H
	.long   scorep
TURMELL:
	.word   50,9,24,0
	.long   04bcdedfH
	.word   06000H
	.long   scorep
RIVETT:
	.word   37,9,18,0
	.long   04bce96bH
	.word   06000H
	.long   scorep
LIPTAK:
	.word   37,9,18,0
	.long   04bcf139H
	.word   06000H
	.long   scorep
DoubleOT:
	.word   107,12,-57,-44
	.long   04bcf907H
	.word   06000H
	.long   scorep
TripleOT:
	.word   105,12,-57,-44
	.long   04bd171fH
	.word   06000H
	.long   scorep
endof1:
	.word   123,14,-58,-43
	.long   04bd34a7H
	.word   06000H
	.long   scorep
endof3:
	.word   124,14,-58,-43
	.long   04bd5d03H
	.word   06000H
	.long   scorep
endof4:
	.word   124,14,-58,-43
	.long   04bd85b3H
	.word   06000H
	.long   scorep
halftime:
	.word   57,12,-58,-44
	.long   04bdae63H
	.word   06000H
	.long   scorep
shotclok:
	.word   48,52,-2,34
	.long   04bdbe6bH
	.word   06000H
	.long   scorep
quarter:
	.word   50,13,-84,-44
	.long   04bdf8ebH
	.word   06000H
	.long   scorep
start:
	.word   35,19,20,0
	.long   04be0827H
	.word   06000H
	.long   scorep
insert:
	.word   37,19,21,0
	.long   04be17bdH
	.word   06000H
	.long   scorep
colon:
	.word   2,5,0,0
	.long   04be2837H
	.word   02000H
	.long   ledw
cpu:
	.word   21,11,0,-4
	.long   04be284bH
	.word   06000H
	.long   scorep
timerlow:
	.word   36,19,18,-4
	.long   04be2db5H
	.word   06000H
	.long   scorep
one:
	.word   20,13,-57,-43
	.long   04be3dbdH
	.word   06000H
	.long   scorep
two:
	.word   23,13,-55,-43
	.long   04be43d5H
	.word   06000H
	.long   scorep
three:
	.word   35,14,-46,-42
	.long   04be4ad7H
	.word   06000H
	.long   scorep
four:
	.word   22,13,-54,-43
	.long   04be5653H
	.word   06000H
	.long   scorep
freeply:
	.word   43,6,0,0
	.long   04be5d07H
	.word   06000H
	.long   scorep
crplate:
	.word   49,12,0,0
	.long   04be6313H
	.word   06000H
	.long   scorep
crplate2:
	.word   49,20,0,0
	.long   04be70dbH
	.word   06000H
	.long   scorep
credit:
	.word   28,6,0,0
	.long   04be87d3H
	.word   06000H
	.long   scorep
scorebox:
	.word   65,36,8,0
	.long   04be8bc3H
	.word   06000H
	.long   scorep
qrtr1:
	.word   34,7,1,1
	.long   04bec29bH
	.word   06000H
	.long   scorep
qrtr2:
	.word   34,7,1,1
	.long   04bec82fH
	.word   06000H
	.long   scorep
qrtr3:
	.word   34,7,1,1
	.long   04becdc3H
	.word   06000H
	.long   scorep
qrtr4:
	.word   34,7,1,1
	.long   04bed357H
	.word   06000H
	.long   scorep
AUGMON:
	.word   46,9,23,0
	.long   04bed8ebH
	.word   06000H
	.long   scorep
BARKLEY:
	.word   47,9,23,0
	.long   04bee29fH
	.word   06000H
	.long   scorep
BENJAMIN:
	.word   54,9,27,0
	.long   04beec89H
	.word   06000H
	.long   scorep
COLEMAN:
	.word   50,9,25,0
	.long   04bef7edH
	.word   06000H
	.long   scorep
DAUGHRTY:
	.word   62,9,31,0
	.long   04bf0279H
	.word   06000H
	.long   scorep
EDWARDS:
	.word   52,9,25,0
	.long   04bf0f8dH
	.word   06000H
	.long   scorep
DREXLER:
	.word   46,9,23,0
	.long   04bf1a85H
	.word   06000H
	.long   scorep
ELLIOT:
	.word   35,9,17,0
	.long   04bf2439H
	.word   06000H
	.long   scorep
ELLIS:
	.word   28,9,14,0
	.long   04bf2b9bH
	.word   06000H
	.long   scorep
GUGLI:
	.word   54,9,26,0
	.long   04bf3183H
	.word   06000H
	.long   scorep
EWING:
	.word   34,9,17,0
	.long   04bf3ce7H
	.word   06000H
	.long   scorep
GILL:
	.word   22,9,11,0
	.long   04bf4413H
	.word   06000H
	.long   scorep
GRANT_HC:
	.word   35,9,17,0
	.long   04bf48b7H
	.word   06000H
	.long   scorep
GRANT_HV:
	.word   35,9,17,0
	.long   04bf48b7H
	.word   06000H
	.long   scorep
HARDAWAY:
	.word   60,9,30,0
	.long   04bf5019H
	.word   06000H
	.long   scorep
HARPER_D:
	.word   41,9,20,0
	.long   04bf5cc1H
	.word   06000H
	.long   scorep
HARPER_R:
	.word   41,9,20,0
	.long   04bf5cc1H
	.word   06000H
	.long   scorep
HAWKINS:
	.word   49,9,24,0
	.long   04bf6567H
	.word   06000H
	.long   scorep
HORNACEK:
	.word   54,9,27,0
	.long   04bf6fbdH
	.word   06000H
	.long   scorep
IUZZ:
	.word   54,9,26,0
	.long   04bf7b21H
	.word   06000H
	.long   scorep
JOHNSN_L:
	.word   48,9,24,0
	.long   04bf8685H
	.word   06000H
	.long   scorep
DIVAC:
	.word   30,9,15,0
	.long   04bf90a5H
	.word   06000H
	.long   scorep
KEMP:
	.word   31,9,15,0
	.long   04bf96f9H
	.word   06000H
	.long   scorep
LAETNER:
	.word   46,9,23,0
	.long   04bf9d83H
	.word   06000H
	.long   scorep
LEWIS:
	.word   33,9,16,0
	.long   04bfa737H
	.word   06000H
	.long   scorep
MAJERLE:
	.word   49,9,24,0
	.long   04bfae2dH
	.word   06000H
	.long   scorep
MALONE_K:
	.word   44,9,22,0
	.long   04bfb883H
	.word   06000H
	.long   scorep
LOHAUS:
	.word   41,9,20,0
	.long   04bfc1cbH
	.word   06000H
	.long   scorep
MANNING:
	.word   49,9,24,0
	.long   04bfca71H
	.word   06000H
	.long   scorep
MILLER:
	.word   39,9,19,0
	.long   04bfd4c7H
	.word   06000H
	.long   scorep
MULLIN:
	.word   40,9,20,0
	.long   04bfdd01H
	.word   06000H
	.long   scorep
MUTUMBO:
	.word   57,9,28,0
	.long   04bfe571H
	.word   06000H
	.long   scorep
McHALE:
	.word   44,9,21,0
	.long   04bff177H
	.word   06000H
	.long   scorep
OAKLEY:
	.word   40,9,20,0
	.long   04bffabfH
	.word   06000H
	.long   scorep
OLAJUWON:
	.word   58,9,29,0
	.long   04c0032fH
	.word   06000H
	.long   scorep
ONEAL:
	.word   36,9,18,0
	.long   04c00f6bH
	.word   06000H
	.long   scorep
PERSON:
	.word   41,9,20,0
	.long   04c01703H
	.word   06000H
	.long   scorep
PETROVIC:
	.word   50,9,25,0
	.long   04c01fa9H
	.word   06000H
	.long   scorep
PIPPEN:
	.word   37,9,18,0
	.long   04c02a35H
	.word   06000H
	.long   scorep
PORTER:
	.word   41,9,20,0
	.long   04c03203H
	.word   06000H
	.long   scorep
PRICE:
	.word   29,9,14,0
	.long   04c03aa9H
	.word   06000H
	.long   scorep
RICE:
	.word   22,9,11,0
	.long   04c040c7H
	.word   06000H
	.long   scorep
ROBINSON:
	.word   52,9,26,0
	.long   04c0456bH
	.word   06000H
	.long   scorep
LAIMBEER:
	.word   53,9,26,0
	.long   04c05063H
	.word   06000H
	.long   scorep
SCHREMPF:
	.word   57,9,28,0
	.long   04c05b91H
	.word   06000H
	.long   scorep
SEIKALY:
	.word   42,9,21,0
	.long   04c06797H
	.word   06000H
	.long   scorep
SKILES:
	.word   36,9,18,0
	.long   04c07073H
	.word   06000H
	.long   scorep
SMITH:
	.word   35,9,17,0
	.long   04c0780bH
	.word   06000H
	.long   scorep
STOCKTON:
	.word   55,9,27,0
	.long   04c07f6dH
	.word   06000H
	.long   scorep
THOMAS:
	.word   46,9,23,0
	.long   04c08b07H
	.word   06000H
	.long   scorep
TISDALE:
	.word   43,9,21,0
	.long   04c094bbH
	.word   06000H
	.long   scorep
WEBB:
	.word   31,9,15,0
	.long   04c09dcdH
	.word   06000H
	.long   scorep
WILKINS:
	.word   44,9,22,0
	.long   04c0a457H
	.word   06000H
	.long   scorep
WORTHY:
	.word   46,9,23,0
	.long   04c0ad9fH
	.word   06000H
	.long   scorep
bbal:
	.word   78,42,0,0
	.long   04c0b753H
	.word   07000H
	.long   bbal_pal
bbal_w:
	.word   78,42,0,0
	.long   04c0b753H
	.word   07000H
	.long   bbal_palw
tocontrol:
	.word   66,9,35,0
	.long   04c110e7H
	.word   06000H
	.long   scorep
METERg:
	.word   49,12,25,-5
	.long   04c11ed3H
	.word   06000H
	.long   scorep
LITUPg:
	.word   49,5,-4,-17
	.long   04c12c9bH
	.word   06000H
	.long   scorep
METERr:
	.word   49,12,25,-5
	.long   04c13259H
	.word   06000H
	.long   scorepr
LITUPr:
	.word   49,5,-4,-17
	.long   04c12c9bH
	.word   06000H
	.long   scorepr
METERy:
	.word   49,12,25,-5
	.long   04c13259H
	.word   06000H
	.long   scorepy
LITUPy:
	.word   49,5,-4,-17
	.long   04c12c9bH
	.word   06000H
	.long   scorepy
METERb:
	.word   49,12,25,-5
	.long   04c13259H
	.word   06000H
	.long   scorepb
LITUPb:
	.word   49,5,-4,-17
	.long   04c12c9bH
	.word   06000H
	.long   scorepb
font60:
	.word   5,6,0,0
	.long   04c14021H
	.word   06000H
	.long   scorep
font61:
	.word   2,6,-3,0
	.long   04c140d5H
	.word   06000H
	.long   scorep
font62:
	.word   5,6,0,0
	.long   04c1411dH
	.word   06000H
	.long   scorep
font63:
	.word   5,6,0,0
	.long   04c141d1H
	.word   06000H
	.long   scorep
font64:
	.word   5,6,0,0
	.long   04c14285H
	.word   06000H
	.long   scorep
font65:
	.word   5,6,0,0
	.long   04c14339H
	.word   06000H
	.long   scorep
font66:
	.word   5,6,0,0
	.long   04c143edH
	.word   06000H
	.long   scorep
font67:
	.word   5,6,0,0
	.long   04c144a1H
	.word   06000H
	.long   scorep
font68:
	.word   5,6,0,0
	.long   04c14555H
	.word   06000H
	.long   scorep
font69:
	.word   5,6,0,0
	.long   04c14609H
	.word   06000H
	.long   scorep
clock:
	.word   40,15,-266,-42
	.long   04c146bdH
	.word   06000H
	.long   scorep
clock2:
	.word   40,15,-266,-42
	.long   04c154cdH
	.word   06000H
	.long   scorep
font90:
	.word   8,9,0,0
	.long   04c162ddH
	.word   02000H
	.long   ledw
font91:
	.word   2,9,-6,0
	.long   04c1636dH
	.word   02000H
	.long   ledw
font92:
	.word   8,9,0,0
	.long   04c16391H
	.word   02000H
	.long   ledw
font93:
	.word   7,9,-1,0
	.long   04c16421H
	.word   02000H
	.long   ledw
font94:
	.word   8,9,0,0
	.long   04c1649fH
	.word   02000H
	.long   ledw
font95:
	.word   8,9,0,0
	.long   04c1652fH
	.word   02000H
	.long   ledw
font96:
	.word   8,9,0,0
	.long   04c165bfH
	.word   02000H
	.long   ledw
font97:
	.word   7,9,-1,0
	.long   04c1664fH
	.word   02000H
	.long   ledw
font98:
	.word   8,9,0,0
	.long   04c166cdH
	.word   02000H
	.long   ledw
font99:
	.word   8,9,0,0
	.long   04c1675dH
	.word   02000H
	.long   ledw
metal2:
	.word   321,21,-47,-39
	.long   04c167edH
	.word   06000H
	.long   scorep
overtime:
	.word   58,12,-57,-44
	.long   04c205ebH
	.word   06000H
	.long   scorep
final:
	.word   36,12,-58,-44
	.long   04c2163bH
	.word   06000H
	.long   scorep
font90r:
	.word   8,9,0,0
	.long   04c2205bH
	.word   02000H
	.long   ledr
metal1:
	.word   40,60,-8,0
	.long   04c220ebH
	.word   06000H
	.long   scorep
S_LED_0:
	.word   7,7,0,0
	.long   04c2592bH
	.word   02000H
	.long   ledw
S_LED_1:
	.word   2,7,-5,0
	.long   04c2598dH
	.word   02000H
	.long   ledw
S_LED_2:
	.word   7,7,0,0
	.long   04c259a9H
	.word   02000H
	.long   ledw
S_LED_3:
	.word   6,7,-1,0
	.long   04c25a0bH
	.word   02000H
	.long   ledw
S_LED_4:
	.word   7,7,0,0
	.long   04c25a5fH
	.word   02000H
	.long   ledw
S_LED_5:
	.word   7,7,0,0
	.long   04c25ac1H
	.word   02000H
	.long   ledw
S_LED_6:
	.word   7,7,0,0
	.long   04c25b23H
	.word   02000H
	.long   ledw
S_LED_7:
	.word   6,7,-1,0
	.long   04c25b85H
	.word   02000H
	.long   ledw
S_LED_8:
	.word   7,7,0,0
	.long   04c25bd9H
	.word   02000H
	.long   ledw
S_LED_9:
	.word   7,7,0,0
	.long   04c25c3bH
	.word   02000H
	.long   ledw
S_LED_MAX:
	.word   25,9,1,1
	.long   04c25c9dH
	.word   02000H
	.long   ledw
BigLED_0:
	.word   16,19,0,0
	.long   04c25e5fH
	.word   06000H
	.long   scorep
BigLED_1:
	.word   4,17,-12,-1
	.long   04c2657fH
	.word   06000H
	.long   scorep
BigLED_2:
	.word   16,19,0,0
	.long   04c26717H
	.word   06000H
	.long   scorep
BigLED_3:
	.word   14,19,-2,0
	.long   04c26e37H
	.word   06000H
	.long   scorep
BigLED_4:
	.word   16,17,0,-1
	.long   04c27473H
	.word   06000H
	.long   scorep
BigLED_5:
	.word   16,19,0,0
	.long   04c27ad3H
	.word   06000H
	.long   scorep
BigLED_6:
	.word   16,19,0,0
	.long   04c281f3H
	.word   06000H
	.long   scorep
BigLED_7:
	.word   14,18,-2,0
	.long   04c28913H
	.word   06000H
	.long   scorep
BigLED_8:
	.word   16,19,0,0
	.long   04c28efbH
	.word   06000H
	.long   scorep
BigLED_9:
	.word   16,19,0,0
	.long   04c2961bH
	.word   06000H
	.long   scorep
please:
	.word   39,19,25,0
	.long   04c29d3bH
	.word   06000H
	.long   scorep
S_LED_0r:
	.word   7,7,0,0
	.long   04c2ae99H
	.word   02000H
	.long   ledr
font6_A:
	.word   5,6,0,0
	.long   04c2aefbH
	.word   02000H
	.long   font6_PAL
font6_B:
	.word   5,6,0,0
	.long   04c2af37H
	.word   02000H
	.long   font6_PAL
font6_C:
	.word   5,6,0,0
	.long   04c2af73H
	.word   02000H
	.long   font6_PAL
font6_D:
	.word   5,6,0,0
	.long   04c2afafH
	.word   02000H
	.long   font6_PAL
font6_E:
	.word   5,6,0,0
	.long   04c2afebH
	.word   02000H
	.long   font6_PAL
font6_F:
	.word   4,6,0,0
	.long   04c2b027H
	.word   02000H
	.long   font6_PAL
font6_G:
	.word   5,6,0,0
	.long   04c2b057H
	.word   02000H
	.long   font6_PAL
font6_H:
	.word   5,6,0,0
	.long   04c2b093H
	.word   02000H
	.long   font6_PAL
font6_I:
	.word   2,6,0,0
	.long   04c2b0cfH
	.word   02000H
	.long   font6_PAL
font6_J:
	.word   5,6,0,0
	.long   04c2b0e7H
	.word   02000H
	.long   font6_PAL
font6_K:
	.word   5,6,0,0
	.long   04c2b123H
	.word   02000H
	.long   font6_PAL
font6_L:
	.word   5,6,0,0
	.long   04c2b15fH
	.word   02000H
	.long   font6_PAL
font6_M:
	.word   6,6,0,0
	.long   04c2b19bH
	.word   02000H
	.long   font6_PAL
font6_N:
	.word   5,6,0,0
	.long   04c2b1e3H
	.word   02000H
	.long   font6_PAL
font6_O:
	.word   5,6,0,0
	.long   04c2b21fH
	.word   02000H
	.long   font6_PAL
font6_P:
	.word   5,6,0,0
	.long   04c2b25bH
	.word   02000H
	.long   font6_PAL
font6_Q:
	.word   5,7,0,0
	.long   04c2b297H
	.word   02000H
	.long   font6_PAL
font6_R:
	.word   5,6,0,0
	.long   04c2b2ddH
	.word   02000H
	.long   font6_PAL
font6_S:
	.word   5,6,0,0
	.long   04c2b319H
	.word   02000H
	.long   font6_PAL
font6_T:
	.word   6,6,0,0
	.long   04c2b355H
	.word   02000H
	.long   font6_PAL
font6_U:
	.word   5,6,0,0
	.long   04c2b39dH
	.word   02000H
	.long   font6_PAL
font6_V:
	.word   6,6,0,0
	.long   04c2b3d9H
	.word   02000H
	.long   font6_PAL
font6_W:
	.word   6,6,0,0
	.long   04c2b421H
	.word   02000H
	.long   font6_PAL
font6_X:
	.word   6,6,0,0
	.long   04c2b469H
	.word   02000H
	.long   font6_PAL
font6_Y:
	.word   6,6,0,0
	.long   04c2b4b1H
	.word   02000H
	.long   font6_PAL
font6_Z:
	.word   6,6,0,0
	.long   04c2b4f9H
	.word   02000H
	.long   font6_PAL
font6_EXP:
	.word   2,6,0,0
	.long   04c2b541H
	.word   02000H
	.long   font6_PAL
back2:
	.word   28,78,-64,3
	.long   04c2b559H
	.word   07000H
	.long   HOOP_p
back3:
	.word   27,78,-64,3
	.long   04c2f111H
	.word   07000H
	.long   HOOP_p
back4:
	.word   26,78,-64,3
	.long   04c32aa7H
	.word   07000H
	.long   HOOP_p
back5:
	.word   25,78,-64,3
	.long   04c3621bH
	.word   07000H
	.long   HOOP_p
back6:
	.word   23,78,-64,3
	.long   04c3976dH
	.word   07000H
	.long   HOOP_p
rim1f:
	.word   24,18,0,1
	.long   04c3c87bH
	.word   07000H
	.long   HOOP_p
rim1b:
	.word   25,19,-1,0
	.long   04c3d44bH
	.word   07000H
	.long   HOOP_p
rim2f:
	.word   24,19,2,1
	.long   04c3e148H
	.word   07000H
	.long   HOOP_p
rim2b:
	.word   25,19,2,-1
	.long   04c3edc0H
	.word   07000H
	.long   HOOP_p
rim3f:
	.word   24,18,2,1
	.long   04c3fabdH
	.word   07000H
	.long   HOOP_p
rim3b:
	.word   25,16,1,-2
	.long   04c4068dH
	.word   07000H
	.long   HOOP_p
rimbase:
	.word   9,6,-1,0
	.long   04c4117dH
	.word   07000H
	.long   HOOP_p
rim4f:
	.word   25,17,2,1
	.long   04c412f7H
	.word   07000H
	.long   HOOP_p
rim4b:
	.word   24,14,-1,-1
	.long   04c41e96H
	.word   07000H
	.long   HOOP_p
hoopbot:
	.word   33,105,65,-92
	.long   04c427c6H
	.word   07000H
	.long   HOOP_p
hooptop:
	.word   123,74,61,-13
	.long   04c48685H
	.word   07000H
	.long   HOOP_p
swish1b:
	.word   25,18,-1,0
	.long   04c57f67H
	.word   07000H
	.long   HOOP_p
swish1f:
	.word   24,18,0,1
	.long   04c58bb5H
	.word   07000H
	.long   HOOP_p
swish2b:
	.word   25,16,-1,0
	.long   04c59785H
	.word   07000H
	.long   HOOP_p
swish2f:
	.word   24,17,0,1
	.long   04c5a275H
	.word   07000H
	.long   HOOP_p
swish3b:
	.word   25,12,-1,0
	.long   04c5ad9dH
	.word   07000H
	.long   HOOP_p
swish3f:
	.word   25,13,0,1
	.long   04c5b5d1H
	.word   07000H
	.long   HOOP_p
swish4b:
	.word   25,9,-1,2
	.long   04c5beb4H
	.word   07000H
	.long   HOOP_p
swish4f:
	.word   24,13,0,9
	.long   04c5c4dbH
	.word   07000H
	.long   HOOP_p
swish5b:
	.word   27,8,0,0
	.long   04c5cd63H
	.word   07000H
	.long   HOOP_p
swish5f:
	.word   27,9,1,1
	.long   04c5d34bH
	.word   07000H
	.long   HOOP_p
farshot1b:
	.word   25,18,-1,0
	.long   04c5d9f0H
	.word   07000H
	.long   HOOP_p
farshot1f:
	.word   24,19,0,1
	.long   04c5e63eH
	.word   07000H
	.long   HOOP_p
farshot2b:
	.word   26,15,0,0
	.long   04c5f2b6H
	.word   07000H
	.long   HOOP_p
farshot2f:
	.word   26,16,2,1
	.long   04c5fd60H
	.word   07000H
	.long   HOOP_p
farshot3b:
	.word   27,10,1,0
	.long   04c608c0H
	.word   07000H
	.long   HOOP_p
farshot3f:
	.word   28,11,4,1
	.long   04c61022H
	.word   07000H
	.long   HOOP_p
farshot4b:
	.word   26,8,0,0
	.long   04c6188eH
	.word   07000H
	.long   HOOP_p
farshot4f:
	.word   29,10,5,1
	.long   04c61e3eH
	.word   07000H
	.long   HOOP_p
bbord_1:
	.word   23,78,-64,3
	.long   04c6262cH
	.word   07000H
	.long   HOOP_p
bbord_2:
	.word   23,78,-64,3
	.long   04c6573aH
	.word   07000H
	.long   HOOP_p
bbord_3:
	.word   23,78,-64,3
	.long   04c68848H
	.word   07000H
	.long   HOOP_p
bbord_4:
	.word   23,78,-64,3
	.long   04c6b956H
	.word   07000H
	.long   HOOP_p
bbord_5:
	.word   23,78,-64,3
	.long   04c6ea64H
	.word   07000H
	.long   HOOP_p
bbord_6:
	.word   23,78,-64,3
	.long   04c71b72H
	.word   07000H
	.long   HOOP_p
bbord_7:
	.word   23,78,-64,3
	.long   04c74c80H
	.word   07000H
	.long   HOOP_p
bbord_8:
	.word   23,78,-64,3
	.long   04c77d8eH
	.word   07000H
	.long   HOOP_p
bbord_9:
	.word   23,78,-64,3
	.long   04c7ae9cH
	.word   07000H
	.long   HOOP_p
bbord_10:
	.word   23,78,-64,3
	.long   04c7dfaaH
	.word   07000H
	.long   HOOP_p
bturn_1:
	.word   25,78,-64,3
	.long   04c810b8H
	.word   07000H
	.long   HOOP_p
bturn_2:
	.word   26,78,-64,3
	.long   04c8460aH
	.word   07000H
	.long   HOOP_p
bturn_3:
	.word   27,78,-64,3
	.long   04c87d7eH
	.word   07000H
	.long   HOOP_p
bturn_4:
	.word   28,78,-64,3
	.long   04c8b714H
	.word   07000H
	.long   HOOP_p
bturn_5:
	.word   30,78,-64,3
	.long   04c8f2ccH
	.word   07000H
	.long   HOOP_p
shard1_1:
	.word   3,1,0,0
	.long   04c932c8H
	.word   07000H
	.long   HOOP_p
shard1_2:
	.word   3,2,0,0
	.long   04c932ddH
	.word   07000H
	.long   HOOP_p
shard1_3:
	.word   3,2,0,0
	.long   04c93307H
	.word   07000H
	.long   HOOP_p
shard1_4:
	.word   3,2,0,0
	.long   04c93331H
	.word   07000H
	.long   HOOP_p
shard1_5:
	.word   3,1,0,0
	.long   04c9335bH
	.word   07000H
	.long   HOOP_p
shard1_6:
	.word   3,2,0,0
	.long   04c93370H
	.word   07000H
	.long   HOOP_p
shard1_7:
	.word   3,2,0,0
	.long   04c9339aH
	.word   07000H
	.long   HOOP_p
shard1_8:
	.word   3,2,0,0
	.long   04c933c4H
	.word   07000H
	.long   HOOP_p
shard2_1:
	.word   3,2,1,0
	.long   04c933eeH
	.word   07000H
	.long   HOOP_p
shard2_2:
	.word   3,3,1,1
	.long   04c93418H
	.word   07000H
	.long   HOOP_p
shard2_3:
	.word   3,3,0,1
	.long   04c93457H
	.word   07000H
	.long   HOOP_p
shard2_4:
	.word   3,3,1,1
	.long   04c93496H
	.word   07000H
	.long   HOOP_p
shard2_5:
	.word   3,2,1,0
	.long   04c934d5H
	.word   07000H
	.long   HOOP_p
shard2_6:
	.word   3,3,0,1
	.long   04c934ffH
	.word   07000H
	.long   HOOP_p
shard2_7:
	.word   3,3,0,1
	.long   04c9353eH
	.word   07000H
	.long   HOOP_p
shard2_8:
	.word   3,3,1,1
	.long   04c9357dH
	.word   07000H
	.long   HOOP_p
shard3_1:
	.word   4,4,1,1
	.long   04c935bcH
	.word   07000H
	.long   HOOP_p
shard3_2:
	.word   4,4,1,1
	.long   04c935bcH
	.word   07000H
	.long   HOOP_p
shard3_3:
	.word   4,4,1,1
	.long   04c9362cH
	.word   07000H
	.long   HOOP_p
shard3_4:
	.word   4,2,1,0
	.long   04c9369cH
	.word   07000H
	.long   HOOP_p
shard3_5:
	.word   4,1,1,0
	.long   04c936d4H
	.word   07000H
	.long   HOOP_p
shard3_6:
	.word   3,3,1,1
	.long   04c936f0H
	.word   07000H
	.long   HOOP_p
shard3_7:
	.word   4,4,1,1
	.long   04c9372fH
	.word   07000H
	.long   HOOP_p
shard3_8:
	.word   4,4,1,1
	.long   04c9372fH
	.word   07000H
	.long   HOOP_p
shard3_9:
	.word   4,4,1,1
	.long   04c9372fH
	.word   07000H
	.long   HOOP_p
shard3_10:
	.word   3,1,1,0
	.long   04c9379fH
	.word   07000H
	.long   HOOP_p
shard3_11:
	.word   4,1,1,0
	.long   04c936d4H
	.word   07000H
	.long   HOOP_p
shard3_12:
	.word   3,3,1,1
	.long   04c937b4H
	.word   07000H
	.long   HOOP_p
shard4_1:
	.word   6,4,2,1
	.long   04c937f3H
	.word   07000H
	.long   HOOP_p
shard4_2:
	.word   7,5,3,2
	.long   04c9389bH
	.word   07000H
	.long   HOOP_p
shard4_3:
	.word   5,5,2,2
	.long   04c93990H
	.word   07000H
	.long   HOOP_p
shard4_4:
	.word   3,4,0,1
	.long   04c93a3fH
	.word   07000H
	.long   HOOP_p
shard4_5:
	.word   3,4,1,1
	.long   04c93a93H
	.word   07000H
	.long   HOOP_p
shard4_6:
	.word   6,4,2,1
	.long   04c93ae7H
	.word   07000H
	.long   HOOP_p
shard4_7:
	.word   7,5,3,2
	.long   04c93b8fH
	.word   07000H
	.long   HOOP_p
shard4_8:
	.word   5,5,2,2
	.long   04c93c84H
	.word   07000H
	.long   HOOP_p
shard4_9:
	.word   3,5,0,2
	.long   04c93d33H
	.word   07000H
	.long   HOOP_p
shard4_10:
	.word   3,4,1,1
	.long   04c93d9cH
	.word   07000H
	.long   HOOP_p
shard5_1:
	.word   4,4,1,1
	.long   04c93df0H
	.word   07000H
	.long   HOOP_p
shard5_2:
	.word   5,3,2,1
	.long   04c93e60H
	.word   07000H
	.long   HOOP_p
shard5_3:
	.word   4,4,1,1
	.long   04c9362cH
	.word   07000H
	.long   HOOP_p
shard5_4:
	.word   3,5,1,2
	.long   04c93ec9H
	.word   07000H
	.long   HOOP_p
shard5_5:
	.word   4,4,1,1
	.long   04c93f32H
	.word   07000H
	.long   HOOP_p
shard5_6:
	.word   5,3,2,1
	.long   04c93e60H
	.word   07000H
	.long   HOOP_p
shard5_7:
	.word   4,4,1,1
	.long   04c93fa2H
	.word   07000H
	.long   HOOP_p
shard5_8:
	.word   3,5,1,2
	.long   04c93ec9H
	.word   07000H
	.long   HOOP_p
shard6_1:
	.word   3,2,0,0
	.long   04c94012H
	.word   07000H
	.long   HOOP_p
shard6_2:
	.word   3,3,0,1
	.long   04c9403cH
	.word   07000H
	.long   HOOP_p
shard6_3:
	.word   3,3,0,1
	.long   04c9407bH
	.word   07000H
	.long   HOOP_p
shard6_4:
	.word   3,3,0,1
	.long   04c940baH
	.word   07000H
	.long   HOOP_p
shard6_5:
	.word   3,3,0,1
	.long   04c940f9H
	.word   07000H
	.long   HOOP_p
shard6_6:
	.word   3,3,0,1
	.long   04c94138H
	.word   07000H
	.long   HOOP_p
shard6_7:
	.word   3,3,0,1
	.long   04c94177H
	.word   07000H
	.long   HOOP_p
shard6_8:
	.word   3,3,0,1
	.long   04c941b6H
	.word   07000H
	.long   HOOP_p
shard7_1:
	.word   5,5,2,2
	.long   04c941f5H
	.word   07000H
	.long   HOOP_p
shard7_2:
	.word   5,5,2,2
	.long   04c942a4H
	.word   07000H
	.long   HOOP_p
shard7_3:
	.word   3,4,1,1
	.long   04c94353H
	.word   07000H
	.long   HOOP_p
shard7_4:
	.word   3,4,0,1
	.long   04c943a7H
	.word   07000H
	.long   HOOP_p
shard7_5:
	.word   3,5,1,2
	.long   04c943fbH
	.word   07000H
	.long   HOOP_p
shard7_6:
	.word   5,5,2,2
	.long   04c94464H
	.word   07000H
	.long   HOOP_p
shard7_7:
	.word   5,6,2,2
	.long   04c94513H
	.word   07000H
	.long   HOOP_p
shard7_8:
	.word   3,6,1,2
	.long   04c945e5H
	.word   07000H
	.long   HOOP_p
shard7_9:
	.word   3,6,0,2
	.long   04c94663H
	.word   07000H
	.long   HOOP_p
shard7_10:
	.word   3,6,1,2
	.long   04c946e1H
	.word   07000H
	.long   HOOP_p
shard8_1:
	.word   3,2,0,0
	.long   04c9475fH
	.word   07000H
	.long   HOOP_p
shard8_2:
	.word   3,2,0,0
	.long   04c94789H
	.word   07000H
	.long   HOOP_p
shard8_3:
	.word   3,1,0,0
	.long   04c947b3H
	.word   07000H
	.long   HOOP_p
shard8_4:
	.word   3,1,0,0
	.long   04c947c8H
	.word   07000H
	.long   HOOP_p
shard8_5:
	.word   3,1,0,0
	.long   04c947ddH
	.word   07000H
	.long   HOOP_p
shard8_6:
	.word   3,1,0,0
	.long   04c947f2H
	.word   07000H
	.long   HOOP_p
shard8_7:
	.word   3,2,0,0
	.long   04c9339aH
	.word   07000H
	.long   HOOP_p
shard8_8:
	.word   3,2,0,0
	.long   04c94807H
	.word   07000H
	.long   HOOP_p
shard8_9:
	.word   3,2,0,0
	.long   04c94831H
	.word   07000H
	.long   HOOP_p
shard8_10:
	.word   3,2,0,0
	.long   04c94789H
	.word   07000H
	.long   HOOP_p
shat1_1:
	.word   10,4,4,1
	.long   04c9485bH
	.word   07000H
	.long   HOOP_p
shat1_2:
	.word   15,5,7,2
	.long   04c94973H
	.word   07000H
	.long   HOOP_p
shat1_3:
	.word   20,5,9,2
	.long   04c94b80H
	.word   07000H
	.long   HOOP_p
shat1_4:
	.word   30,7,14,3
	.long   04c94e3cH
	.word   07000H
	.long   HOOP_p
shat1_5:
	.word   41,9,20,4
	.long   04c953faH
	.word   07000H
	.long   HOOP_p
shat2_1:
	.word   7,5,3,2
	.long   04c95e11H
	.word   07000H
	.long   HOOP_p
shat2_2:
	.word   10,5,4,2
	.long   04c95f06H
	.word   07000H
	.long   HOOP_p
shat2_3:
	.word   18,7,8,3
	.long   04c96064H
	.word   07000H
	.long   HOOP_p
shat2_4:
	.word   27,8,13,3
	.long   04c963d6H
	.word   07000H
	.long   HOOP_p
shat2_5:
	.word   39,9,19,4
	.long   04c969beH
	.word   07000H
	.long   HOOP_p
shat3_1:
	.word   3,2,1,0
	.long   04c933eeH
	.word   07000H
	.long   HOOP_p
shat3_2:
	.word   4,2,1,0
	.long   04c97357H
	.word   07000H
	.long   HOOP_p
shat3_3:
	.word   8,2,3,0
	.long   04c9738fH
	.word   07000H
	.long   HOOP_p
shat3_4:
	.word   12,4,5,1
	.long   04c973ffH
	.word   07000H
	.long   HOOP_p
shat3_5:
	.word   20,5,9,2
	.long   04c9754fH
	.word   07000H
	.long   HOOP_p
shat4_1:
	.word   3,1,0,0
	.long   04c932c8H
	.word   07000H
	.long   HOOP_p
shat4_2:
	.word   4,4,1,1
	.long   04c9780bH
	.word   07000H
	.long   HOOP_p
shat4_3:
	.word   8,5,3,2
	.long   04c9787bH
	.word   07000H
	.long   HOOP_p
shat4_4:
	.word   14,5,6,2
	.long   04c97993H
	.word   07000H
	.long   HOOP_p
shat4_5:
	.word   12,6,5,2
	.long   04c97b7dH
	.word   07000H
	.long   HOOP_p
rimbndF_1:
	.word   24,19,1,1
	.long   04c97d75H
	.word   07000H
	.long   HOOP_p
rimbndF_2:
	.word   24,18,1,1
	.long   04c989edH
	.word   07000H
	.long   HOOP_p
rimbndF_3:
	.word   25,17,2,1
	.long   04c995bdH
	.word   07000H
	.long   HOOP_p
rimbndF_4:
	.word   23,21,4,1
	.long   04c9a15cH
	.word   07000H
	.long   HOOP_p
rimbndF_5:
	.word   15,28,6,1
	.long   04c9ae91H
	.word   07000H
	.long   HOOP_p
rimbndF_6:
	.word   18,25,4,1
	.long   04c9ba0dH
	.word   07000H
	.long   HOOP_p
rimbndF_7:
	.word   22,21,3,1
	.long   04c9c65bH
	.word   07000H
	.long   HOOP_p
rimbndF_8:
	.word   25,17,2,1
	.long   04c9d2fdH
	.word   07000H
	.long   HOOP_p
rimbndF_9:
	.word   25,17,1,1
	.long   04c9de9cH
	.word   07000H
	.long   HOOP_p
rimbndF_10:
	.word   23,20,1,4
	.long   04c9ea3bH
	.word   07000H
	.long   HOOP_p
rimbndF_11:
	.word   25,19,1,7
	.long   04c9f6cfH
	.word   07000H
	.long   HOOP_p
rimbndF_12:
	.word   27,14,1,5
	.long   04ca03ccH
	.word   07000H
	.long   HOOP_p
rimbndF_13:
	.word   27,9,2,1
	.long   04ca0e22H
	.word   07000H
	.long   HOOP_p
rimbndF_14:
	.word   27,10,3,2
	.long   04ca14c7H
	.word   07000H
	.long   HOOP_p
rimbndF_15:
	.word   26,14,3,1
	.long   04ca1c29H
	.word   07000H
	.long   HOOP_p
rimbndF_16:
	.word   27,14,3,1
	.long   04ca261dH
	.word   07000H
	.long   HOOP_p
rimbndF_17:
	.word   27,18,2,1
	.long   04ca3073H
	.word   07000H
	.long   HOOP_p
rimbndB_1:
	.word   25,19,-1,0
	.long   04ca3dbdH
	.word   07000H
	.long   HOOP_p
rimbndB_2:
	.word   25,16,-1,-1
	.long   04ca4abaH
	.word   07000H
	.long   HOOP_p
rimbndB_3:
	.word   24,14,-1,-1
	.long   04ca55aaH
	.word   07000H
	.long   HOOP_p
rimbndB_4:
	.word   22,20,2,-1
	.long   04ca5edaH
	.word   07000H
	.long   HOOP_p
rimbndB_5:
	.word   11,27,2,-1
	.long   04ca6ae2H
	.word   07000H
	.long   HOOP_p
rimbndB_6:
	.word   16,22,0,-2
	.long   04ca7301H
	.word   07000H
	.long   HOOP_p
rimbndB_7:
	.word   21,20,0,-1
	.long   04ca7ca1H
	.word   07000H
	.long   HOOP_p
rimbndB_8:
	.word   24,14,-1,-1
	.long   04ca881dH
	.word   07000H
	.long   HOOP_p
rimbndB_9:
	.word   25,10,-1,0
	.long   04ca914dH
	.word   07000H
	.long   HOOP_p
rimbndB_10:
	.word   25,15,-1,3
	.long   04ca9823H
	.word   07000H
	.long   HOOP_p
rimbndB_11:
	.word   25,13,-1,6
	.long   04caa264H
	.word   07000H
	.long   HOOP_p
rimbndB_12:
	.word   27,11,-1,4
	.long   04caab47H
	.word   07000H
	.long   HOOP_p
rimbndB_13:
	.word   27,8,0,0
	.long   04cab366H
	.word   07000H
	.long   HOOP_p
rimbndB_14:
	.word   27,11,1,-1
	.long   04cab94eH
	.word   07000H
	.long   HOOP_p
rimbndB_15:
	.word   26,14,1,-1
	.long   04cac16dH
	.word   07000H
	.long   HOOP_p
rimbndB_16:
	.word   27,10,1,-1
	.long   04cacb61H
	.word   07000H
	.long   HOOP_p
rimbndB_17:
	.word   25,11,-1,0
	.long   04cad2c3H
	.word   07000H
	.long   HOOP_p
firimB_1:
	.word   25,19,-1,0
	.long   04cada48H
	.word   07000H
	.long   HOOP_p
firimB_2:
	.word   25,18,-1,0
	.long   04cae745H
	.word   07000H
	.long   HOOP_p
firimB_3:
	.word   25,16,-1,0
	.long   04caf393H
	.word   07000H
	.long   HOOP_p
firimB_4:
	.word   25,12,-1,0
	.long   04cafe83H
	.word   07000H
	.long   HOOP_p
firimB_5:
	.word   25,12,-1,5
	.long   04cb06b7H
	.word   07000H
	.long   HOOP_p
firimB_6:
	.word   27,15,0,7
	.long   04cb0eebH
	.word   07000H
	.long   HOOP_p
firimB_7:
	.word   25,11,-1,3
	.long   04cb19feH
	.word   07000H
	.long   HOOP_p
firimB_8:
	.word   25,10,-1,0
	.long   04cb2183H
	.word   07000H
	.long   HOOP_p
firimB_9:
	.word   25,11,-1,0
	.long   04cb2859H
	.word   07000H
	.long   HOOP_p
firimB_10:
	.word   25,11,-1,0
	.long   04cb2859H
	.word   07000H
	.long   HOOP_p
firimF_1:
	.word   24,18,0,1
	.long   04cb2fdeH
	.word   07000H
	.long   HOOP_p
firimF_2:
	.word   24,18,0,1
	.long   04cb3baeH
	.word   07000H
	.long   HOOP_p
firimF_3:
	.word   24,17,0,1
	.long   04cb477eH
	.word   07000H
	.long   HOOP_p
firimF_4:
	.word   25,13,0,1
	.long   04cb52a6H
	.word   07000H
	.long   HOOP_p
firimF_5:
	.word   24,35,0,29
	.long   04cb5b89H
	.word   07000H
	.long   HOOP_p
firimF_6:
	.word   27,25,1,15
	.long   04cb7281H
	.word   07000H
	.long   HOOP_p
firimF_7:
	.word   24,29,0,13
	.long   04cb84f6H
	.word   07000H
	.long   HOOP_p
firimF_8:
	.word   24,36,0,17
	.long   04cb97feH
	.word   07000H
	.long   HOOP_p
firimF_9:
	.word   25,42,1,20
	.long   04cbaf9eH
	.word   07000H
	.long   HOOP_p
firimF_10:
	.word   29,49,3,22
	.long   04cbcc54H
	.word   07000H
	.long   HOOP_p
firimB_11:
	.word   25,9,-1,0
	.long   04cbf32fH
	.word   07000H
	.long   HOOP_p
firimF_11:
	.word   24,9,0,1
	.long   04cbf956H
	.word   07000H
	.long   HOOP_p
firimF_12:
	.word   31,51,3,21
	.long   04cbff3eH
	.word   07000H
	.long   HOOP_p
firimF_13:
	.word   37,31,5,22
	.long   04cc2a79H
	.word   07000H
	.long   HOOP_p
firimF_14:
	.word   48,42,10,26
	.long   04cc49d6H
	.word   07000H
	.long   HOOP_p
firimF_15:
	.word   42,33,8,24
	.long   04cc80f6H
	.word   07000H
	.long   HOOP_p
firimF_16:
	.word   47,34,11,25
	.long   04cca6dcH
	.word   07000H
	.long   HOOP_p
firimF_17:
	.word   50,34,11,25
	.long   04ccd28eH
	.word   07000H
	.long   HOOP_p
firimB_bnd:
	.word   25,7,2,-1
	.long   04cd010aH
	.word   07000H
	.long   HOOP_p
firimF_bnd:
	.word   24,10,2,0
	.long   04cd05d3H
	.word   07000H
	.long   HOOP_p
BirthM_B:
	.word   190,14,94,0
	.long   04cd0c63H
	.word   06000H
	.long   FGAMEPAL
Stats_B:
	.word   190,14,94,0
	.long   04cd4abbH
	.word   06000H
	.long   FGAMEPAL
INITIALS_B:
	.word   190,14,94,0
	.long   04cd8913H
	.word   06000H
	.long   FGAMEPAL
BirthD_B:
	.word   190,14,94,0
	.long   04cdc76bH
	.word   06000H
	.long   FGAMEPAL
PRESSBUTT:
	.word   253,18,126,8
	.long   04ce05c3H
	.word   04000H
	.long   SGMD8WHT
PRESSTURB:
	.word   225,18,112,8
	.long   04ce4cebH
	.word   04000H
	.long   SGMD8RED
selectbox:
	.word   87,40,43,0
	.long   04ce8c33H
	.word   01000H
	.long   selpal
CENTERBAR:
	.word   6,40,3,0
	.long   04ce99cbH
	.word   06000H
	.long   METLPALC
TopTenred:
	.word   83,36,0,0
	.long   04ce9f6bH
	.word   04000H
	.long   fgpalred
TopTengrn:
	.word   83,36,0,0
	.long   04ce9f6bH
	.word   04000H
	.long   fgpalgrn
TopTenorg:
	.word   83,36,0,0
	.long   04ce9f6bH
	.word   04000H
	.long   fgpalorg
TopTengld:
	.word   83,36,0,0
	.long   04ce9f6bH
	.word   04000H
	.long   fgpalgld
start3:
	.word   49,29,24,14
	.long   04cece1bH
	.word   04000H
	.long   SGMD8YEL
insert3:
	.word   56,29,27,14
	.long   04cee44fH
	.word   04000H
	.long   SGMD8YEL
freplay3:
	.word   81,14,40,6
	.long   04cefdafH
	.word   04000H
	.long   SGMD8YEL
join3:
	.word   61,14,30,6
	.long   04cf0f67H
	.word   04000H
	.long   SGMD8YEL
INITIALS:
	.word   92,14,46,0
	.long   04cf1cbfH
	.word   06000H
	.long   FGAMEPAL
BirthM:
	.word   92,14,46,0
	.long   04cf3aefH
	.word   06000H
	.long   FGAMEPAL
BirthD:
	.word   92,14,46,0
	.long   04cf591fH
	.word   06000H
	.long   FGAMEPAL
Stats:
	.word   92,14,46,0
	.long   04cf774fH
	.word   06000H
	.long   FGAMEPAL
start2:
	.word   35,19,17,0
	.long   04cf957fH
	.word   04000H
	.long   SGMD8YEL
insert2:
	.word   37,19,18,0
	.long   04cf9fe3H
	.word   04000H
	.long   SGMD8YEL
freeplay:
	.word   55,9,27,-5
	.long   04cfaadfH
	.word   04000H
	.long   SGMD8VIO
yesnobak:
	.word   115,67,0,0
	.long   04cfb29bH
	.word   04000H
	.long   YESNOPAL
FulGamered:
	.word   83,36,0,0
	.long   04d02affH
	.word   04000H
	.long   fgpalred
FulGameorg:
	.word   83,36,0,0
	.long   04d02affH
	.word   04000H
	.long   fgpalorg
FulGamegrn:
	.word   83,36,0,0
	.long   04d02affH
	.word   04000H
	.long   fgpalgrn
FulGamegld:
	.word   83,36,0,0
	.long   04d02affH
	.word   04000H
	.long   fgpalgld
_4playbx:
	.word   213,95,106,0
	.long   04d059afH
	.word   06000H
	.long   GROWBOX
_4playline:
	.word   117,4,58,1
	.long   04d233f1H
	.word   04000H
	.long   SGMD8GLD
useupbx:
	.word   117,74,58,0
	.long   04d23b41H
	.word   06000H
	.long   WHITEPAL
OSGEMD_AND:
	.word   21,22,0,0
	.long   04d3062dH
	.word   06000H
	.long   OSGEMD
OSGEMD_A:
	.word   14,22,0,0
	.long   04d31101H
	.word   06000H
	.long   ORANGPAL
OSGEMD_B:
	.word   14,22,0,0
	.long   04d31839H
	.word   06000H
	.long   GREENPAL
OSGEMD_C:
	.word   12,22,0,0
	.long   04d31f71H
	.word   06000H
	.long   GOLD
OSGEMD_D:
	.word   14,22,0,0
	.long   04d325a1H
	.word   06000H
	.long   REDPAL
OSGEMD_E:
	.word   12,22,0,0
	.long   04d32cd9H
	.word   06000H
	.long   WHITEPAL
OSGEMD_F:
	.word   11,22,0,0
	.long   04d33309H
	.word   06000H
	.long   PURPLE
OSGEMD_G:
	.word   14,22,0,0
	.long   04d338b5H
	.word   06000H
	.long   TURQUSE
OSGEMD_H:
	.word   14,22,0,0
	.long   04d33fedH
	.word   06000H
	.long   BLUE
OSGEMD_I:
	.word   7,22,0,0
	.long   04d34725H
	.word   06000H
	.long   RUBYPAL
OSGEMD_J:
	.word   11,22,0,0
	.long   04d34ac1H
	.word   06000H
	.long   AQUAPAL
OSGEMD_K:
	.word   14,22,0,0
	.long   04d3506dH
	.word   06000H
	.long   WHITE2PAL
OSGEMD_L:
	.word   11,22,0,0
	.long   04d357a5H
	.word   06000H
	.long   OSGEMD
OSGEMD_M:
	.word   21,22,0,0
	.long   04d35d51H
	.word   06000H
	.long   OSGEMD
OSGEMD_N:
	.word   14,22,0,0
	.long   04d36825H
	.word   06000H
	.long   OSGEMD
OSGEMD_O:
	.word   14,22,0,0
	.long   04d36f5dH
	.word   06000H
	.long   OSGEMD
OSGEMD_P:
	.word   14,22,0,0
	.long   04d37695H
	.word   06000H
	.long   OSGEMD
OSGEMD_Q:
	.word   14,25,0,0
	.long   04d37dcdH
	.word   06000H
	.long   OSGEMD
OSGEMD_R:
	.word   14,22,0,0
	.long   04d38601H
	.word   06000H
	.long   OSGEMD
OSGEMD_S:
	.word   13,22,0,0
	.long   04d38d39H
	.word   06000H
	.long   OSGEMD
OSGEMD_T:
	.word   13,22,0,0
	.long   04d393edH
	.word   06000H
	.long   OSGEMD
OSGEMD_U:
	.word   14,22,0,0
	.long   04d39aa1H
	.word   06000H
	.long   OSGEMD
OSGEMD_V:
	.word   14,22,0,0
	.long   04d3a1d9H
	.word   06000H
	.long   OSGEMD
OSGEMD_W:
	.word   21,22,0,0
	.long   04d3a911H
	.word   06000H
	.long   OSGEMD
OSGEMD_X:
	.word   14,22,0,0
	.long   04d3b3e5H
	.word   06000H
	.long   OSGEMD
OSGEMD_Y:
	.word   14,22,0,0
	.long   04d3bb1dH
	.word   06000H
	.long   OSGEMD
OSGEMD_Z:
	.word   13,22,0,0
	.long   04d3c255H
	.word   06000H
	.long   OSGEMD
OSGEMD_EXP:
	.word   7,22,0,0
	.long   04d3c909H
	.word   06000H
	.long   OSGEMD
OSGEMD_DAS:
	.word   14,9,0,-7
	.long   04d3cca5H
	.word   06000H
	.long   OSGEMD
OSGEMD_DEL:
	.word   19,26,0,0
	.long   04d3cf99H
	.word   06000H
	.long   OSGEMD
OSGEMD_DOT:
	.word   7,9,0,-13
	.long   04d3db2dH
	.word   06000H
	.long   OSGEMD
OSGEMD_DOL:
	.word   16,22,0,0
	.long   04d3dca7H
	.word   06000H
	.long   OSGEMD
OSGEMD_SLS:
	.word   14,22,0,0
	.long   04d3e4e7H
	.word   06000H
	.long   OSGEMD
OSGEMD_APO:
	.word   7,11,0,0
	.long   04d3ec1fH
	.word   06000H
	.long   OSGEMD
OSGEMD_QUE:
	.word   14,22,0,0
	.long   04d3ededH
	.word   06000H
	.long   OSGEMD
growbox:
	.word   91,95,0,0
	.long   04d3f525H
	.word   06000H
	.long   GROWBOX
OSGEMD_BAK:
	.word   14,21,0,0
	.long   04d4bfc3H
	.word   06000H
	.long   OSGEMD
OSGEMD_SPC:
	.word   21,22,0,0
	.long   04d4c6a7H
	.word   06000H
	.long   OSGEMD
OSGEMD_END:
	.word   20,22,0,0
	.long   04d4d17bH
	.word   06000H
	.long   OSGEMD
OSGEMD_COL:
	.word   7,18,0,-3
	.long   04d4dbcbH
	.word   06000H
	.long   OSGEMD
OSGEMD_OBR:
	.word   10,23,0,0
	.long   04d4debfH
	.word   06000H
	.long   OSGEMD
OSGEMD_CBR:
	.word   10,23,0,0
	.long   04d4e423H
	.word   06000H
	.long   OSGEMD
OSGEMD_NUM:
	.word   19,21,0,-1
	.long   04d4e987H
	.word   06000H
	.long   OSGEMD
OSGEMD_0:
	.word   14,22,0,0
	.long   04d4f2e1H
	.word   06000H
	.long   OSGEMD
OSGEMD_1:
	.word   9,22,0,0
	.long   04d4fa19H
	.word   06000H
	.long   OSGEMD
OSGEMD_2:
	.word   14,22,0,0
	.long   04d4febdH
	.word   06000H
	.long   OSGEMD
OSGEMD_3:
	.word   14,22,0,0
	.long   04d505f5H
	.word   06000H
	.long   OSGEMD
OSGEMD_4:
	.word   16,22,0,0
	.long   04d50d2dH
	.word   06000H
	.long   OSGEMD
OSGEMD_5:
	.word   14,22,0,0
	.long   04d5156dH
	.word   06000H
	.long   OSGEMD
OSGEMD_6:
	.word   14,22,0,0
	.long   04d51ca5H
	.word   06000H
	.long   OSGEMD
OSGEMD_7:
	.word   14,22,0,0
	.long   04d523ddH
	.word   06000H
	.long   OSGEMD
OSGEMD_8:
	.word   14,22,0,0
	.long   04d52b15H
	.word   06000H
	.long   OSGEMD
OSGEMD_9:
	.word   14,22,0,0
	.long   04d5324dH
	.word   06000H
	.long   OSGEMD
MD_JAN:
	.word   35,22,0,0
	.long   04d53985H
	.word   06000H
	.long   OSGEMD
MD_FEB:
	.word   33,22,0,0
	.long   04d54b91H
	.word   06000H
	.long   OSGEMD
MD_MAR:
	.word   45,22,0,0
	.long   04d55c95H
	.word   06000H
	.long   OSGEMD
MD_APR:
	.word   38,22,0,0
	.long   04d573c9H
	.word   06000H
	.long   OSGEMD
MD_MAY:
	.word   45,22,0,0
	.long   04d58761H
	.word   06000H
	.long   OSGEMD
MD_JUN:
	.word   35,22,0,0
	.long   04d59e95H
	.word   06000H
	.long   OSGEMD
MD_JUL:
	.word   32,22,0,0
	.long   04d5b0a1H
	.word   06000H
	.long   OSGEMD
MD_AUG:
	.word   38,22,0,0
	.long   04d5c121H
	.word   06000H
	.long   OSGEMD
MD_SEP:
	.word   35,22,0,0
	.long   04d5d4b9H
	.word   06000H
	.long   OSGEMD
MD_OCT:
	.word   35,22,0,0
	.long   04d5e6c5H
	.word   06000H
	.long   OSGEMD
MD_NOV:
	.word   38,22,0,0
	.long   04d5f8d1H
	.word   06000H
	.long   OSGEMD
MD_DEC:
	.word   34,22,0,0
	.long   04d60c69H
	.word   06000H
	.long   OSGEMD
OSGENM_1:
	.word   7,21,0,0
	.long   04d61df1H
	.word   06000H
	.long   OSGEMD
OSGENM_2:
	.word   10,21,0,0
	.long   04d62163H
	.word   06000H
	.long   OSGEMD
OSGENM_3:
	.word   10,21,0,0
	.long   04d6264fH
	.word   06000H
	.long   OSGEMD
OSGENM_4:
	.word   12,21,0,0
	.long   04d62b3bH
	.word   06000H
	.long   OSGEMD
OSGENM_5:
	.word   10,21,0,0
	.long   04d63123H
	.word   06000H
	.long   OSGEMD
OSGENM_6:
	.word   10,21,0,0
	.long   04d6360fH
	.word   06000H
	.long   OSGEMD
OSGENM_7:
	.word   10,21,0,0
	.long   04d63afbH
	.word   06000H
	.long   OSGEMD
OSGENM_8:
	.word   10,21,0,0
	.long   04d63fe7H
	.word   06000H
	.long   OSGEMD
OSGENM_9:
	.word   10,21,0,0
	.long   04d644d3H
	.word   06000H
	.long   OSGEMD
OSGENM_10:
	.word   17,21,0,0
	.long   04d649bfH
	.word   06000H
	.long   OSGEMD
OSGENM_11:
	.word   14,21,0,0
	.long   04d6521dH
	.word   06000H
	.long   OSGEMD
OSGENM_12:
	.word   17,21,0,0
	.long   04d65901H
	.word   06000H
	.long   OSGEMD
OSGENM_13:
	.word   17,21,0,0
	.long   04d6615fH
	.word   06000H
	.long   OSGEMD
OSGENM_14:
	.word   18,21,0,0
	.long   04d669bdH
	.word   06000H
	.long   OSGEMD
OSGENM_15:
	.word   17,21,0,0
	.long   04d67299H
	.word   06000H
	.long   OSGEMD
OSGENM_16:
	.word   17,21,0,0
	.long   04d67af7H
	.word   06000H
	.long   OSGEMD
OSGENM_17:
	.word   17,21,0,0
	.long   04d68355H
	.word   06000H
	.long   OSGEMD
OSGENM_18:
	.word   17,21,0,0
	.long   04d68bb3H
	.word   06000H
	.long   OSGEMD
OSGENM_19:
	.word   17,21,0,0
	.long   04d69411H
	.word   06000H
	.long   OSGEMD
OSGENM_20:
	.word   19,21,0,0
	.long   04d69c6fH
	.word   06000H
	.long   OSGEMD
OSGENM_21:
	.word   17,21,0,0
	.long   04d6a5c9H
	.word   06000H
	.long   OSGCYC1
OSGENM_22:
	.word   19,21,0,0
	.long   04d6ae27H
	.word   06000H
	.long   OSGCYC2
OSGENM_23:
	.word   19,21,0,0
	.long   04d6b781H
	.word   06000H
	.long   OSGCYC3
OSGENM_24:
	.word   20,21,0,0
	.long   04d6c0dbH
	.word   06000H
	.long   OSGCYC4
OSGENM_25:
	.word   19,21,0,0
	.long   04d6cab3H
	.word   06000H
	.long   OSGCYC5
OSGENM_26:
	.word   19,21,0,0
	.long   04d6d40dH
	.word   06000H
	.long   OSGCYC6
OSGENM_27:
	.word   19,21,0,0
	.long   04d6dd67H
	.word   06000H
	.long   OSGCYC7
OSGENM_28:
	.word   19,21,0,0
	.long   04d6e6c1H
	.word   06000H
	.long   OSGCYC8
OSGENM_29:
	.word   19,21,0,0
	.long   04d6f01bH
	.word   06000H
	.long   OSGCYC9
OSGENM_30:
	.word   19,21,0,0
	.long   04d6f975H
	.word   06000H
	.long   OSGCYC10
OSGENM_31:
	.word   17,21,0,0
	.long   04d702cfH
	.word   06000H
	.long   OSGCYC11
T_BULLS:
	.word   59,58,29,29
	.long   04d70b2dH
	.word   0580H
	.long   P_BULS
T_HAWKS:
	.word   62,62,31,31
	.long   04d7554dH
	.word   0580H
	.long   P_HAWKS
T_NUGS:
	.word   79,48,39,24
	.long   04d7b2edH
	.word   0580H
	.long   P_NUGS
T_BLAZ:
	.word   78,18,39,9
	.long   04d8198dH
	.word   080H
	.long   P_BLAZ
T_SONICS:
	.word   81,57,40,29
	.long   04d8444dH
	.word   0680H
	.long   P_SONICS
T_76RS:
	.word   64,60,32,30
	.long   04d8a0ddH
	.word   0580H
	.long   P_76RS
T_SUNS:
	.word   56,60,28,30
	.long   04d904fdH
	.word   080H
	.long   P_SUNS
T_SPURS:
	.word   78,39,39,19
	.long   04d9572dH
	.word   0480H
	.long   P_SPURS
T_MAGIC:
	.word   80,27,40,14
	.long   04d9a5fdH
	.word   0980H
	.long   P_MAGIC
T_PACER:
	.word   72,56,36,28
	.long   04d9dc15H
	.word   0480H
	.long   P_PACER
T_CAVS:
	.word   83,33,41,17
	.long   04da3e55H
	.word   0680H
	.long   P_CAVS
T_BUCKS:
	.word   60,58,30,29
	.long   04da8135H
	.word   0580H
	.long   P_BUCKS
T_HEAT:
	.word   44,60,22,30
	.long   04dab025H
	.word   0180H
	.long   P_HEAT
T_CLIPS:
	.word   81,54,40,27
	.long   04dae20dH
	.word   0680H
	.long   P_CLIPS
T_BULTS:
	.word   82,31,41,16
	.long   04db514dH
	.word   0a80H
	.long   P_BULTS
T_WARS:
	.word   68,61,34,32
	.long   04db7c95H
	.word   0580H
	.long   P_WARS
T_HORS:
	.word   59,60,29,30
	.long   04dbd7cdH
	.word   0580H
	.long   P_HORS
T_PISS:
	.word   62,59,31,30
	.long   04dc2c8dH
	.word   0580H
	.long   P_PISS
T_LAKS:
	.word   81,47,40,24
	.long   04dc89a5H
	.word   0580H
	.long   P_LAKS
T_TWOLV:
	.word   50,63,25,32
	.long   04dcdb25H
	.word   080H
	.long   P_TWOV
T_CELTS:
	.word   51,61,25,31
	.long   04dd2e05H
	.word   0580H
	.long   P_CELTS
T_JAZZ:
	.word   85,34,42,17
	.long   04dd7815H
	.word   0180H
	.long   P_JAZZ
T_KINGS:
	.word   52,63,26,32
	.long   04ddc135H
	.word   080H
	.long   P_KINGS
T_NETS:
	.word   66,63,33,32
	.long   04de21ddH
	.word   0580H
	.long   P_NETS
T_MAVS:
	.word   83,31,41,16
	.long   04de8ce5H
	.word   0880H
	.long   P_MAVS
T_ROCKS:
	.word   62,62,31,31
	.long   04dec155H
	.word   0580H
	.long   P_ROCKS
T_KNIKS:
	.word   86,59,43,30
	.long   04df2255H
	.word   0a80H
	.long   P_KNIKS
cities1:
	.word   79,81,0,0
	.long   04df81bdH
	.word   04000H
	.long   SGMD8YEL
cities2:
	.word   71,69,0,0
	.long   04dfe5b9H
	.word   04000H
	.long   SGMD8YEL
cities3:
	.word   64,81,0,0
	.long   04e03245H
	.word   04000H
	.long   SGMD8VIO
cities4:
	.word   73,81,0,0
	.long   04e08345H
	.word   04000H
	.long   SGMD8VIO
C_PORT:
	.word   55,9,0,0
	.long   04e0dfa9H
	.word   04000H
	.long   SGMD8YEL
C_LA:
	.word   71,9,0,0
	.long   04e0e765H
	.word   04000H
	.long   SGMD8YEL
C_LALaks:
	.word   65,9,0,0
	.long   04e0f161H
	.word   04000H
	.long   SGMD8YEL
C_LAClips:
	.word   74,9,0,0
	.long   04e0fa85H
	.word   04000H
	.long   SGMD8YEL
C_PHX:
	.word   44,9,0,0
	.long   04e104edH
	.word   04000H
	.long   SGMD8YEL
C_GOLD:
	.word   79,9,0,0
	.long   04e10b1dH
	.word   04000H
	.long   SGMD8YEL
C_SEA:
	.word   46,9,0,0
	.long   04e11639H
	.word   04000H
	.long   SGMD8YEL
C_SAC:
	.word   72,9,0,0
	.long   04e11cb1H
	.word   04000H
	.long   SGMD8YEL
C_HOU:
	.word   49,9,0,0
	.long   04e126d1H
	.word   04000H
	.long   SGMD8YEL
C_SAN:
	.word   71,9,0,0
	.long   04e12db5H
	.word   04000H
	.long   SGMD8YEL
C_UTAH:
	.word   28,9,0,0
	.long   04e137b1H
	.word   04000H
	.long   SGMD8YEL
C_DAL:
	.word   40,9,0,0
	.long   04e13ba1H
	.word   04000H
	.long   SGMD8YEL
C_MINN:
	.word   62,9,0,0
	.long   04e14141H
	.word   04000H
	.long   SGMD8YEL
C_DEN:
	.word   40,9,0,0
	.long   04e149f9H
	.word   04000H
	.long   SGMD8YEL
C_CHIC:
	.word   43,9,0,0
	.long   04e14f99H
	.word   04000H
	.long   SGMD8VIO
C_DET:
	.word   44,9,0,0
	.long   04e155a5H
	.word   04000H
	.long   SGMD8VIO
C_IND:
	.word   41,9,0,0
	.long   04e15bd5H
	.word   04000H
	.long   SGMD8VIO
C_CLEV:
	.word   58,9,0,0
	.long   04e16199H
	.word   04000H
	.long   SGMD8VIO
C_MILW:
	.word   64,9,0,0
	.long   04e169c1H
	.word   04000H
	.long   SGMD8VIO
C_ATL:
	.word   48,9,0,0
	.long   04e172c1H
	.word   04000H
	.long   SGMD8VIO
C_CHAR:
	.word   60,9,0,0
	.long   04e17981H
	.word   04000H
	.long   SGMD8VIO
C_PHIL:
	.word   73,9,0,0
	.long   04e181f1H
	.word   04000H
	.long   SGMD8VIO
C_BOST:
	.word   42,9,0,0
	.long   04e18c35H
	.word   04000H
	.long   SGMD8VIO
C_NY:
	.word   57,9,0,0
	.long   04e1921dH
	.word   04000H
	.long   SGMD8VIO
C_NJ:
	.word   69,9,0,0
	.long   04e19a21H
	.word   04000H
	.long   SGMD8VIO
C_WASH:
	.word   70,9,0,0
	.long   04e1a3d5H
	.word   04000H
	.long   SGMD8VIO
C_ORL:
	.word   48,9,0,0
	.long   04e1adadH
	.word   04000H
	.long   SGMD8VIO
C_MIAMI:
	.word   35,9,0,0
	.long   04e1b46dH
	.word   04000H
	.long   SGMD8VIO
C_PORT_O:
	.word   63,11,0,0
	.long   04e1b959H
	.word   04000H
	.long   SGMD8YEL
C_LALaks_O:
	.word   76,11,0,0
	.long   04e1c42dH
	.word   04000H
	.long   SGMD8YEL
C_LAClips_O:
	.word   87,11,0,0
	.long   04e1d13dH
	.word   04000H
	.long   SGMD8YEL
C_PHX_O:
	.word   51,11,0,0
	.long   04e1e031H
	.word   04000H
	.long   SGMD8YEL
C_GOLD_O:
	.word   91,11,0,0
	.long   04e1e8f5H
	.word   04000H
	.long   SGMD8YEL
C_SEA_O:
	.word   53,11,0,0
	.long   04e1f899H
	.word   04000H
	.long   SGMD8YEL
C_SAC_O:
	.word   82,11,0,0
	.long   04e201b5H
	.word   04000H
	.long   SGMD8YEL
C_HOU_O:
	.word   56,11,0,0
	.long   04e20fcdH
	.word   04000H
	.long   SGMD8YEL
C_SAN_O:
	.word   82,11,0,0
	.long   04e2196dH
	.word   04000H
	.long   SGMD8YEL
C_UTAH_O:
	.word   32,11,0,0
	.long   04e22785H
	.word   04000H
	.long   SGMD8YEL
C_DAL_O:
	.word   46,11,0,0
	.long   04e22d05H
	.word   04000H
	.long   SGMD8YEL
C_MINN_O:
	.word   71,11,0,0
	.long   04e234edH
	.word   04000H
	.long   SGMD8YEL
C_DEN_O:
	.word   46,11,0,0
	.long   04e24121H
	.word   04000H
	.long   SGMD8YEL
C_CHIC_O:
	.word   50,11,0,0
	.long   04e24909H
	.word   04000H
	.long   SGMD8YEL
C_DET_O:
	.word   51,11,0,0
	.long   04e251a1H
	.word   04000H
	.long   SGMD8YEL
C_IND_O:
	.word   48,11,0,0
	.long   04e25a65H
	.word   04000H
	.long   SGMD8YEL
C_CLEV_O:
	.word   67,11,0,0
	.long   04e262a5H
	.word   04000H
	.long   SGMD8YEL
C_MILW_O:
	.word   73,11,0,0
	.long   04e26e29H
	.word   04000H
	.long   SGMD8YEL
C_ATL_O:
	.word   55,11,0,0
	.long   04e27ab5H
	.word   04000H
	.long   SGMD8YEL
C_CHAR_O:
	.word   69,11,0,0
	.long   04e28429H
	.word   04000H
	.long   SGMD8YEL
C_PHIL_O:
	.word   85,11,0,0
	.long   04e29005H
	.word   04000H
	.long   SGMD8YEL
C_BOST_O:
	.word   48,11,0,0
	.long   04e29ea1H
	.word   04000H
	.long   SGMD8YEL
C_NY_O:
	.word   65,11,0,0
	.long   04e2a6e1H
	.word   04000H
	.long   SGMD8YEL
C_NJ_O:
	.word   78,11,0,0
	.long   04e2b20dH
	.word   04000H
	.long   SGMD8YEL
C_WASH_O:
	.word   80,11,0,0
	.long   04e2bf75H
	.word   04000H
	.long   SGMD8YEL
C_ORL_O:
	.word   55,11,0,0
	.long   04e2cd35H
	.word   04000H
	.long   SGMD8YEL
C_MIAMI_O:
	.word   40,11,0,0
	.long   04e2d6a9H
	.word   04000H
	.long   SGMD8YEL
lgmd_A:
	.word   37,61,0,0
	.long   04e2dd89H
	.word   06000H
	.long   LGMDGLD
lgmd_B:
	.word   37,61,0,0
	.long   04e3126fH
	.word   06000H
	.long   LGMDBLU
lgmd_C:
	.word   26,61,0,0
	.long   04e34755H
	.word   06000H
	.long   LGGEMD1
lgmd_D:
	.word   38,61,0,0
	.long   04e36c81H
	.word   06000H
	.long   LGMDCHR
lgmd_E:
	.word   30,61,0,0
	.long   04e3a2d5H
	.word   06000H
	.long   LGMDGLD
lgmd_F:
	.word   27,61,0,0
	.long   04e3cdb9H
	.word   06000H
	.long   LGMDORNG
lgmd_G:
	.word   37,61,0,0
	.long   04e3f453H
	.word   06000H
	.long   LGMDRED2
lgmd_H:
	.word   37,61,0,0
	.long   04e42939H
	.word   06000H
	.long   LGMDSLV
lgmd_I:
	.word   18,61,0,0
	.long   04e45e1fH
	.word   06000H
	.long   LGMDWHT
lgmd_J:
	.word   24,61,0,0
	.long   04e477dbH
	.word   06000H
	.long   LGMDPURP
lgmd_K:
	.word   37,61,0,0
	.long   04e49a2bH
	.word   06000H
	.long   LGMDGLDlt
lgmd_L:
	.word   27,61,0,0
	.long   04e4cf11H
	.word   06000H
	.long   LGMDGLDdk
lgmd_M:
	.word   57,61,0,0
	.long   04e4f5abH
	.word   06000H
	.long   LGMDGLD
lgmd_N:
	.word   38,61,0,0
	.long   04e54729H
	.word   06000H
	.long   LGMDGLD
lgmd_O:
	.word   37,61,0,0
	.long   04e57d7dH
	.word   06000H
	.long   LGMDGLD
lgmd_P:
	.word   37,61,0,0
	.long   04e5b263H
	.word   06000H
	.long   LGMDGLD
lgmd_Q:
	.word   38,73,0,0
	.long   04e5e749H
	.word   06000H
	.long   LGMDGLD
lgmd_R:
	.word   38,61,0,0
	.long   04e6284dH
	.word   06000H
	.long   LGMDGLD
lgmd_S:
	.word   31,61,0,0
	.long   04e65ea1H
	.word   06000H
	.long   LGMDGLD
lgmd_T:
	.word   30,61,0,0
	.long   04e68af3H
	.word   06000H
	.long   LGMDGLD
lgmd_U:
	.word   37,61,0,0
	.long   04e6b5d7H
	.word   06000H
	.long   LGMDGLD
lgmd_V:
	.word   37,61,0,0
	.long   04e6eabdH
	.word   06000H
	.long   LGMDGLD
lgmd_W:
	.word   56,61,0,0
	.long   04e71fa3H
	.word   06000H
	.long   LGMDGLD
lgmd_X:
	.word   37,61,0,0
	.long   04e76fb3H
	.word   06000H
	.long   LGMDGLD
lgmd_Y:
	.word   38,61,0,0
	.long   04e7a499H
	.word   06000H
	.long   LGMDGLD
lgmd_Z:
	.word   33,61,0,0
	.long   04e7daedH
	.word   06000H
	.long   LGMDGLD
lgmd_0:
	.word   35,61,0,0
	.long   04e80a1bH
	.word   06000H
	.long   LGMDGLD
lgmd_1:
	.word   20,61,0,0
	.long   04e83c25H
	.word   06000H
	.long   LGMDGLD
lgmd_2:
	.word   36,61,0,0
	.long   04e858bdH
	.word   06000H
	.long   LGMDGLD
lgmd_3:
	.word   35,61,0,0
	.long   04e88c35H
	.word   06000H
	.long   LGMDGLD
lgmd_4:
	.word   44,61,0,0
	.long   04e8be3fH
	.word   06000H
	.long   LGMDGLD
lgmd_5:
	.word   35,61,0,0
	.long   04e8fd27H
	.word   06000H
	.long   LGMDGLD
lgmd_6:
	.word   35,61,0,0
	.long   04e92f31H
	.word   06000H
	.long   LGMDGLD
lgmd_7:
	.word   35,61,0,0
	.long   04e9613bH
	.word   06000H
	.long   LGMDGLD
lgmd_8:
	.word   35,61,0,0
	.long   04e99345H
	.word   06000H
	.long   LGMDGLD
lgmd_9:
	.word   35,61,0,0
	.long   04e9c54fH
	.word   06000H
	.long   LGMDGLD
lgmd_DOT:
	.word   18,22,0,-39
	.long   04e9f759H
	.word   06000H
	.long   LGMDGLD
lgmd_EXP:
	.word   18,61,0,0
	.long   04ea00a1H
	.word   06000H
	.long   LGMDGLD
lgmd_COL:
	.word   18,46,-7,-8
	.long   04ea1a5dH
	.word   06000H
	.long   LGMDGLD
lgmd_NUM:
	.word   31,37,0,0
	.long   04ea2dc5H
	.word   06000H
	.long   LGMDGLD
omlgmd_A:
	.word   28,44,0,0
	.long   04ea48a7H
	.word   06000H
	.long   LGMDCHR
omlgmd_B:
	.word   28,44,0,0
	.long   04ea6587H
	.word   06000H
	.long   LGMDCHR
omlgmd_C:
	.word   20,44,0,0
	.long   04ea8267H
	.word   06000H
	.long   LGMDCHR
omlgmd_D:
	.word   28,44,0,0
	.long   04ea9707H
	.word   06000H
	.long   LGMDCHR
omlgmd_E:
	.word   22,44,0,0
	.long   04eab3e7H
	.word   06000H
	.long   LGMDCHR
omlgmd_F:
	.word   21,44,0,0
	.long   04eaca97H
	.word   06000H
	.long   LGMDCHR
omlgmd_G:
	.word   28,44,0,0
	.long   04eae03fH
	.word   06000H
	.long   LGMDCHR
omlgmd_H:
	.word   27,44,0,0
	.long   04eafd1fH
	.word   06000H
	.long   LGMDCHR
omlgmd_I:
	.word   14,44,0,0
	.long   04eb18f7H
	.word   06000H
	.long   LGMDCHR
omlgmd_J:
	.word   20,44,0,0
	.long   04eb2767H
	.word   06000H
	.long   LGMDCHR
omlgmd_K:
	.word   29,44,0,0
	.long   04eb3c07H
	.word   06000H
	.long   LGMDCHR
omlgmd_L:
	.word   21,44,0,0
	.long   04eb59efH
	.word   06000H
	.long   LGMDCHR
omlgmd_M:
	.word   43,44,0,0
	.long   04eb6f97H
	.word   06000H
	.long   LGMDCHR
omlgmd_N:
	.word   29,44,0,0
	.long   04eb9befH
	.word   06000H
	.long   LGMDCHR
omlgmd_O:
	.word   28,44,0,0
	.long   04ebb9d7H
	.word   06000H
	.long   LGMDCHR
omlgmd_P:
	.word   27,44,0,0
	.long   04ebd6b7H
	.word   06000H
	.long   LGMDCHR
omlgmd_Q:
	.word   28,52,0,0
	.long   04ebf28fH
	.word   06000H
	.long   LGMDCHR
omlgmd_R:
	.word   28,44,0,0
	.long   04ec14afH
	.word   06000H
	.long   LGMDCHR
omlgmd_S:
	.word   24,44,0,0
	.long   04ec318fH
	.word   06000H
	.long   LGMDCHR
omlgmd_T:
	.word   24,44,0,0
	.long   04ec4a4fH
	.word   06000H
	.long   LGMDCHR
omlgmd_U:
	.word   28,44,0,0
	.long   04ec630fH
	.word   06000H
	.long   LGMDCHR
omlgmd_V:
	.word   29,44,0,0
	.long   04ec7fefH
	.word   06000H
	.long   LGMDCHR
omlgmd_W:
	.word   42,44,0,0
	.long   04ec9dd7H
	.word   06000H
	.long   LGMDCHR
omlgmd_X:
	.word   28,44,0,0
	.long   04ecc927H
	.word   06000H
	.long   LGMDCHR
omlgmd_Y:
	.word   28,44,0,0
	.long   04ece607H
	.word   06000H
	.long   LGMDCHR
omlgmd_Z:
	.word   25,44,0,0
	.long   04ed02e7H
	.word   06000H
	.long   LGMDCHR
omlgmd_EXP:
	.word   14,44,0,0
	.long   04ed1cafH
	.word   06000H
	.long   LGMDCHR
omlgmd_DOT:
	.word   14,15,0,-29
	.long   04ed2b1fH
	.word   06000H
	.long   LGMDCHR
scorshad1:
	.word   100,24,0,0
	.long   04ed300bH
	.word   06000H
	.long   METLPALC
scorshad2:
	.word   100,24,0,0
	.long   04ed684bH
	.word   06000H
	.long   METLPALC
attribs:
	.word   33,24,0,0
	.long   04eda08bH
	.word   04000H
	.long   rate_PAL
ratebar0:
	.word   43,5,0,0
	.long   04edacebH
	.word   04000H
	.long   rate_PAL
ratebar1:
	.word   43,5,0,0
	.long   04edb047H
	.word   04000H
	.long   rate_PAL
ratebar2:
	.word   43,5,0,0
	.long   04edb3a3H
	.word   04000H
	.long   rate_PAL
ratebar3:
	.word   43,5,0,0
	.long   04edb6ffH
	.word   04000H
	.long   rate_PAL
ratebar4:
	.word   43,5,0,0
	.long   04edba5bH
	.word   04000H
	.long   rate_PAL
ratebar5:
	.word   43,5,0,0
	.long   04edbdb7H
	.word   04000H
	.long   rate_PAL
ratebar6:
	.word   43,5,0,0
	.long   04edc113H
	.word   04000H
	.long   rate_PAL
ratebar7:
	.word   43,5,0,0
	.long   04edc46fH
	.word   04000H
	.long   rate_PAL
ratebar8:
	.word   43,5,0,0
	.long   04edc7cbH
	.word   04000H
	.long   rate_PAL
ratebar9:
	.word   43,5,0,0
	.long   04edcb27H
	.word   04000H
	.long   rate_PAL
ratebar10:
	.word   43,5,0,0
	.long   04edce83H
	.word   04000H
	.long   rate_PAL
stx_rank:
	.word   54,11,0,0
	.long   04edd1dfH
	.word   04000H
	.long   SGMD8YEL
stx_pct:
	.word   28,11,0,0
	.long   04eddb27H
	.word   04000H
	.long   SGMD8YEL
stx_w:
	.word   24,11,0,0
	.long   04eddff7H
	.word   04000H
	.long   SGMD8YEL
stx_l:
	.word   19,11,0,0
	.long   04ede417H
	.word   04000H
	.long   SGMD8YEL
stx_lastmtch:
	.word   85,11,0,0
	.long   04ede75bH
	.word   04000H
	.long   SGMD8YEL
stx_defeated:
	.word   60,11,0,0
	.long   04edf5f7H
	.word   04000H
	.long   SGMD8YEL
stx_lostto:
	.word   53,11,0,0
	.long   04ee0047H
	.word   04000H
	.long   SGMD8YEL
stx_youhave:
	.word   61,11,0,0
	.long   04ee0963H
	.word   04000H
	.long   SGMD8YEL
stx_ofthe27:
	.word   66,11,0,0
	.long   04ee13dfH
	.word   04000H
	.long   SGMD8YEL
stx_nbateams:
	.word   80,13,0,1
	.long   04ee1f37H
	.word   04000H
	.long   SGMD8YEL
stx_all:
	.word   22,11,0,0
	.long   04ee2f77H
	.word   04000H
	.long   SGMD8YEL
stx_norecord:
	.word   83,14,41,6
	.long   04ee333fH
	.word   04000H
	.long   SGMD8YEL
stx_record:
	.word   51,11,0,0
	.long   04ee4567H
	.word   04000H
	.long   SGMD8YEL
credbox:
	.word   57,11,0,0
	.long   04ee4e2bH
	.word   06000H
	.long   METLPGRA
stx_fgs:
	.word   26,9,0,0
	.long   04ee5cddH
	.word   04000H
	.long   SGMD8YEL
stx_3pts:
	.word   35,9,0,0
	.long   04ee6085H
	.word   04000H
	.long   SGMD8YEL
stx_atline:
	.word   26,9,0,0
	.long   04ee6571H
	.word   04000H
	.long   SGMD8YEL
stx_points:
	.word   41,9,0,0
	.long   04ee6919H
	.word   04000H
	.long   SGMD8YEL
stx_dunks:
	.word   38,9,0,0
	.long   04ee6eddH
	.word   04000H
	.long   SGMD8YEL
stx_ast:
	.word   44,9,0,0
	.long   04ee7435H
	.word   04000H
	.long   SGMD8YEL
stx_steals:
	.word   43,9,0,0
	.long   04ee7a65H
	.word   04000H
	.long   SGMD8YEL
stx_blocks:
	.word   43,9,0,0
	.long   04ee8071H
	.word   04000H
	.long   SGMD8YEL
stx_rebs:
	.word   44,9,0,0
	.long   04ee867dH
	.word   04000H
	.long   SGMD8YEL
stshad1:
	.word   116,99,0,0
	.long   04ee8cadH
	.word   01000H
	.long   SHADOW
stshad2:
	.word   116,99,0,0
	.long   04eeb989H
	.word   01000H
	.long   SHADOW
SGMD8_A:
	.word   7,9,0,0
	.long   04eee665H
	.word   04000H
	.long   SGMD8YEL
SGMD8_B:
	.word   7,9,0,0
	.long   04eee761H
	.word   04000H
	.long   SGMD8BLU
SGMD8_C:
	.word   6,9,0,0
	.long   04eee85dH
	.word   04000H
	.long   SGMD8VIO
SGMD8_D:
	.word   7,9,0,0
	.long   04eee935H
	.word   04000H
	.long   SGMD8WHT
SGMD8_E:
	.word   6,9,0,0
	.long   04eeea31H
	.word   04000H
	.long   SGMD8GRY
SGMD8_F:
	.word   6,9,0,0
	.long   04eeeb09H
	.word   04000H
	.long   SGMD8PLV
SGMD8_G:
	.word   7,9,0,0
	.long   04eeebe1H
	.word   04000H
	.long   SGMD8PLR
SGMD8_H:
	.word   7,9,0,0
	.long   04eeecddH
	.word   04000H
	.long   SGMD8PLB
SGMD8_I:
	.word   3,9,0,0
	.long   04eeedd9H
	.word   04000H
	.long   SGMD8PLY
SGMD8_J:
	.word   6,9,0,0
	.long   04eeee45H
	.word   04000H
	.long   SGMD8YEL
SGMD8_K:
	.word   7,9,0,0
	.long   04eeef1dH
	.word   04000H
	.long   SGMD8YEL
SGMD8_L:
	.word   6,9,0,0
	.long   04eef019H
	.word   04000H
	.long   SGMD8YEL
SGMD8_M:
	.word   11,9,0,0
	.long   04eef0f1H
	.word   04000H
	.long   SGMD8YEL
SGMD8_N:
	.word   7,9,0,0
	.long   04eef27dH
	.word   04000H
	.long   SGMD8YEL
SGMD8_O:
	.word   7,9,0,0
	.long   04eef379H
	.word   04000H
	.long   SGMD8YEL
SGMD8_P:
	.word   7,9,0,0
	.long   04eef475H
	.word   04000H
	.long   SGMD8YEL
SGMD8_Q:
	.word   7,10,0,0
	.long   04eef571H
	.word   04000H
	.long   SGMD8YEL
SGMD8_R:
	.word   7,9,0,0
	.long   04eef689H
	.word   04000H
	.long   SGMD8YEL
SGMD8_S:
	.word   7,9,0,0
	.long   04eef785H
	.word   04000H
	.long   SGMD8YEL
SGMD8_T:
	.word   7,9,0,0
	.long   04eef881H
	.word   04000H
	.long   SGMD8YEL
SGMD8_U:
	.word   7,9,0,0
	.long   04eef97dH
	.word   04000H
	.long   SGMD8YEL
SGMD8_V:
	.word   7,9,0,0
	.long   04eefa79H
	.word   04000H
	.long   SGMD8YEL
SGMD8_W:
	.word   11,9,0,0
	.long   04eefb75H
	.word   04000H
	.long   SGMD8YEL
SGMD8_X:
	.word   7,9,0,0
	.long   04eefd01H
	.word   04000H
	.long   SGMD8YEL
SGMD8_Y:
	.word   7,9,0,0
	.long   04eefdfdH
	.word   04000H
	.long   SGMD8YEL
SGMD8_Z:
	.word   7,9,0,0
	.long   04eefef9H
	.word   04000H
	.long   SGMD8YEL
SGMD8_0:
	.word   7,9,0,0
	.long   04eefff5H
	.word   04000H
	.long   SGMD8YEL
SGMD8_1:
	.word   4,9,0,0
	.long   04ef00f1H
	.word   04000H
	.long   SGMD8YEL
SGMD8_2:
	.word   7,9,0,0
	.long   04ef0181H
	.word   04000H
	.long   SGMD8YEL
SGMD8_3:
	.word   7,9,0,0
	.long   04ef027dH
	.word   04000H
	.long   SGMD8YEL
SGMD8_4:
	.word   7,9,0,0
	.long   04ef0379H
	.word   04000H
	.long   SGMD8YEL
SGMD8_5:
	.word   7,9,0,0
	.long   04ef0475H
	.word   04000H
	.long   SGMD8YEL
SGMD8_6:
	.word   7,9,0,0
	.long   04ef0571H
	.word   04000H
	.long   SGMD8YEL
SGMD8_7:
	.word   7,9,0,0
	.long   04ef066dH
	.word   04000H
	.long   SGMD8YEL
SGMD8_8:
	.word   7,9,0,0
	.long   04ef0769H
	.word   04000H
	.long   SGMD8YEL
SGMD8_9:
	.word   7,9,0,0
	.long   04ef0865H
	.word   04000H
	.long   SGMD8YEL
SGMD8_DOT:
	.word   3,3,0,-6
	.long   04ef0961H
	.word   04000H
	.long   SGMD8YEL
SGMD8_DAS:
	.word   6,3,0,-3
	.long   04ef0985H
	.word   04000H
	.long   SGMD8YEL
SGMD8_EXP:
	.word   3,9,0,0
	.long   04ef09cdH
	.word   04000H
	.long   SGMD8YEL
SGMD8_NUM:
	.word   9,9,0,0
	.long   04ef0a39H
	.word   04000H
	.long   SGMD8YEL
SGMD8_COM:
	.word   3,5,0,-6
	.long   04ef0b7dH
	.word   04000H
	.long   SGMD8YEL
SGMD8_OBR:
	.word   4,9,0,0
	.long   04ef0bb9H
	.word   04000H
	.long   SGMD8YEL
SGMD8_CBR:
	.word   4,9,0,0
	.long   04ef0c49H
	.word   04000H
	.long   SGMD8YEL
SGMD8_COL:
	.word   3,6,0,-2
	.long   04ef0cd9H
	.word   04000H
	.long   SGMD8YEL
SGMD8_AND:
	.word   10,9,0,0
	.long   04ef0d21H
	.word   04000H
	.long   SGMD8YEL
SGMD8_APO:
	.word   3,5,0,0
	.long   04ef0b7dH
	.word   04000H
	.long   SGMD8YEL
SGMD8_SLS:
	.word   7,9,0,0
	.long   04ef0e89H
	.word   04000H
	.long   SGMD8YEL
SGMD8_PCT:
	.word   7,9,0,0
	.long   04ef0f85H
	.word   04000H
	.long   SGMD8YEL
plyr1:
	.word   61,9,-19,-7
	.long   04ef1081H
	.word   04000H
	.long   SGMD8RED
plyr2:
	.word   63,9,-19,-7
	.long   04ef1915H
	.word   04000H
	.long   SGMD8WHT
plyr3:
	.word   63,9,-19,-7
	.long   04ef21f1H
	.word   04000H
	.long   SGMD8WHT
plyr4:
	.word   63,9,-19,-7
	.long   04ef2acdH
	.word   04000H
	.long   SGMD8WHT
threepnts:
	.word   54,26,27,0
	.long   04ef33a9H
	.word   04000H
	.long   SGMD8WHT
osgmd8_A:
	.word   8,11,0,0
	.long   04ef4999H
	.word   04000H
	.long   SGMD8YEL
osgmd8_B:
	.word   8,11,0,0
	.long   04ef4af9H
	.word   04000H
	.long   SGMD8YEL
osgmd8_C:
	.word   7,11,0,0
	.long   04ef4c59H
	.word   04000H
	.long   SGMD8YEL
osgmd8_D:
	.word   8,11,0,0
	.long   04ef4d8dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_E:
	.word   7,11,0,0
	.long   04ef4eedH
	.word   04000H
	.long   SGMD8YEL
osgmd8_F:
	.word   7,11,0,0
	.long   04ef5021H
	.word   04000H
	.long   SGMD8YEL
osgmd8_G:
	.word   8,11,0,0
	.long   04ef5155H
	.word   04000H
	.long   SGMD8YEL
osgmd8_H:
	.word   8,11,0,0
	.long   04ef52b5H
	.word   04000H
	.long   SGMD8YEL
osgmd8_I:
	.word   4,11,0,0
	.long   04ef5415H
	.word   04000H
	.long   SGMD8YEL
osgmd8_J:
	.word   7,11,0,0
	.long   04ef54c5H
	.word   04000H
	.long   SGMD8YEL
osgmd8_K:
	.word   8,11,0,0
	.long   04ef55f9H
	.word   04000H
	.long   SGMD8YEL
osgmd8_L:
	.word   7,11,0,0
	.long   04ef5759H
	.word   04000H
	.long   SGMD8YEL
osgmd8_M:
	.word   12,11,0,0
	.long   04ef588dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_N:
	.word   8,11,0,0
	.long   04ef5a9dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_O:
	.word   8,11,0,0
	.long   04ef5bfdH
	.word   04000H
	.long   SGMD8YEL
osgmd8_P:
	.word   8,11,0,0
	.long   04ef5d5dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_Q:
	.word   8,12,0,0
	.long   04ef5ebdH
	.word   04000H
	.long   SGMD8YEL
osgmd8_R:
	.word   8,11,0,0
	.long   04ef603dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_S:
	.word   8,11,0,0
	.long   04ef619dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_T:
	.word   8,11,0,0
	.long   04ef62fdH
	.word   04000H
	.long   SGMD8YEL
osgmd8_U:
	.word   8,11,0,0
	.long   04ef645dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_V:
	.word   8,11,0,0
	.long   04ef65bdH
	.word   04000H
	.long   SGMD8YEL
osgmd8_W:
	.word   12,11,0,0
	.long   04ef671dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_X:
	.word   8,11,0,0
	.long   04ef692dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_Y:
	.word   8,11,0,0
	.long   04ef6a8dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_Z:
	.word   8,11,0,0
	.long   04ef6bedH
	.word   04000H
	.long   SGMD8YEL
osgmd8_0:
	.word   8,11,0,0
	.long   04ef6d4dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_1:
	.word   5,11,0,0
	.long   04ef6eadH
	.word   04000H
	.long   SGMD8YEL
osgmd8_2:
	.word   8,11,0,0
	.long   04ef6f89H
	.word   04000H
	.long   SGMD8YEL
osgmd8_3:
	.word   8,11,0,0
	.long   04ef70e9H
	.word   04000H
	.long   SGMD8YEL
osgmd8_4:
	.word   8,11,0,0
	.long   04ef7249H
	.word   04000H
	.long   SGMD8YEL
osgmd8_5:
	.word   8,11,0,0
	.long   04ef73a9H
	.word   04000H
	.long   SGMD8YEL
osgmd8_6:
	.word   8,11,0,0
	.long   04ef7509H
	.word   04000H
	.long   SGMD8YEL
osgmd8_7:
	.word   8,11,0,0
	.long   04ef7669H
	.word   04000H
	.long   SGMD8YEL
osgmd8_8:
	.word   8,11,0,0
	.long   04ef77c9H
	.word   04000H
	.long   SGMD8YEL
osgmd8_9:
	.word   8,11,0,0
	.long   04ef7929H
	.word   04000H
	.long   SGMD8YEL
osgmd8_DOT:
	.word   4,5,0,-6
	.long   04ef7a89H
	.word   04000H
	.long   SGMD8YEL
osgmd8_DAS:
	.word   7,5,0,-3
	.long   04ef7ad9H
	.word   04000H
	.long   SGMD8YEL
osgmd8_EXP:
	.word   4,11,0,0
	.long   04ef7b65H
	.word   04000H
	.long   SGMD8YEL
osgmd8_NUM:
	.word   10,11,0,0
	.long   04ef7c15H
	.word   04000H
	.long   SGMD8YEL
osgmd8_COM:
	.word   4,7,0,-6
	.long   04ef7dcdH
	.word   04000H
	.long   SGMD8YEL
osgmd8_OBR:
	.word   5,11,0,0
	.long   04ef7e3dH
	.word   04000H
	.long   SGMD8YEL
osgmd8_CBR:
	.word   5,11,0,0
	.long   04ef7f19H
	.word   04000H
	.long   SGMD8YEL
osgmd8_COL:
	.word   4,8,0,-2
	.long   04ef7ff5H
	.word   04000H
	.long   SGMD8YEL
osgmd8_AND:
	.word   11,11,0,0
	.long   04ef8075H
	.word   04000H
	.long   SGMD8YEL
osgmd8_APO:
	.word   4,7,0,0
	.long   04ef7dcdH
	.word   04000H
	.long   SGMD8YEL
osgmd8_SLS:
	.word   9,11,0,0
	.long   04ef8259H
	.word   04000H
	.long   SGMD8YEL
osgmd8_PCT:
	.word   9,11,0,0
	.long   04ef83e5H
	.word   04000H
	.long   SGMD8YEL
getready:
	.word   85,31,42,0
	.long   04ef8571H
	.word   04000H
	.long   SGMD8GLD
_1quart:
	.word   68,33,33,0
	.long   04efae9dH
	.word   04000H
	.long   SGMD8GLD
continue:
	.word   85,24,42,11
	.long   04efd1adH
	.word   04000H
	.long   SGMD8GLD
_2quart:
	.word   68,33,33,0
	.long   04eff18dH
	.word   04000H
	.long   SGMD8GLD
_3quart:
	.word   68,33,33,0
	.long   04f0149dH
	.word   04000H
	.long   SGMD8GLD
_4quart:
	.word   68,33,33,0
	.long   04f037adH
	.word   04000H
	.long   SGMD8GLD
overtme:
	.word   85,14,42,0
	.long   04f05abdH
	.word   04000H
	.long   SGMD8GLD
congrats_l:
	.word   148,24,73,11
	.long   04f06d55H
	.word   04000H
	.long   SGMD8GLD
winstay_l:
	.word   143,53,71,26
	.long   04f0a4d5H
	.word   04000H
	.long   SGMD8GLD
chalneed_l:
	.word   95,53,47,26
	.long   04f11b41H
	.word   04000H
	.long   SGMD8GLD
chalacc_l:
	.word   85,53,42,26
	.long   04f169edH
	.word   04000H
	.long   SGMD8GLD
winfree:
	.word   144,53,71,26
	.long   04f1b051H
	.word   04000H
	.long   SGMD8GLD
TMATE:
	.word   79,31,39,15
	.long   04f22791H
	.word   04000H
	.long   SGMD8GLD
CHALENG:
	.word   86,31,42,15
	.long   04f24dd5H
	.word   04000H
	.long   SGMD8GLD
osgmd10_A:
	.word   10,13,0,0
	.long   04f2777dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_B:
	.word   10,13,0,0
	.long   04f27985H
	.word   04000H
	.long   SGMD8GLD
osgmd10_C:
	.word   9,13,0,0
	.long   04f27b8dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_D:
	.word   10,13,0,0
	.long   04f27d61H
	.word   04000H
	.long   SGMD8GLD
osgmd10_E:
	.word   9,13,0,0
	.long   04f27f69H
	.word   04000H
	.long   SGMD8GLD
osgmd10_F:
	.word   9,13,0,0
	.long   04f2813dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_G:
	.word   10,13,0,0
	.long   04f28311H
	.word   04000H
	.long   SGMD8GLD
osgmd10_H:
	.word   10,13,0,0
	.long   04f28519H
	.word   04000H
	.long   SGMD8GLD
osgmd10_I:
	.word   5,13,0,0
	.long   04f28721H
	.word   04000H
	.long   SGMD8GLD
osgmd10_J:
	.word   9,13,0,0
	.long   04f28825H
	.word   04000H
	.long   SGMD8GLD
osgmd10_K:
	.word   10,13,0,0
	.long   04f289f9H
	.word   04000H
	.long   SGMD8GLD
osgmd10_L:
	.word   9,13,0,0
	.long   04f28c01H
	.word   04000H
	.long   SGMD8GLD
osgmd10_M:
	.word   15,13,0,0
	.long   04f28dd5H
	.word   04000H
	.long   SGMD8GLD
osgmd10_N:
	.word   10,13,0,0
	.long   04f290e1H
	.word   04000H
	.long   SGMD8GLD
osgmd10_O:
	.word   10,13,0,0
	.long   04f292e9H
	.word   04000H
	.long   SGMD8GLD
osgmd10_P:
	.word   10,13,0,0
	.long   04f294f1H
	.word   04000H
	.long   SGMD8GLD
osgmd10_Q:
	.word   10,15,0,0
	.long   04f296f9H
	.word   04000H
	.long   SGMD8GLD
osgmd10_R:
	.word   10,13,0,0
	.long   04f29951H
	.word   04000H
	.long   SGMD8GLD
osgmd10_S:
	.word   10,13,0,0
	.long   04f29b59H
	.word   04000H
	.long   SGMD8GLD
osgmd10_T:
	.word   9,13,0,0
	.long   04f29d61H
	.word   04000H
	.long   SGMD8GLD
osgmd10_U:
	.word   10,13,0,0
	.long   04f29f35H
	.word   04000H
	.long   SGMD8GLD
osgmd10_V:
	.word   10,13,0,0
	.long   04f2a13dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_W:
	.word   15,13,0,0
	.long   04f2a345H
	.word   04000H
	.long   SGMD8GLD
osgmd10_X:
	.word   10,13,0,0
	.long   04f2a651H
	.word   04000H
	.long   SGMD8GLD
osgmd10_Y:
	.word   11,13,0,0
	.long   04f2a859H
	.word   04000H
	.long   SGMD8GLD
osgmd10_Z:
	.word   10,13,0,0
	.long   04f2aa95H
	.word   04000H
	.long   SGMD8GLD
osgmd10_0:
	.word   10,13,0,0
	.long   04f2ac9dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_1:
	.word   6,13,0,0
	.long   04f2aea5H
	.word   04000H
	.long   SGMD8GLD
osgmd10_2:
	.word   10,13,0,0
	.long   04f2afddH
	.word   04000H
	.long   SGMD8GLD
osgmd10_3:
	.word   10,13,0,0
	.long   04f2b1e5H
	.word   04000H
	.long   SGMD8GLD
osgmd10_4:
	.word   12,13,0,0
	.long   04f2b3edH
	.word   04000H
	.long   SGMD8GLD
osgmd10_5:
	.word   10,13,0,0
	.long   04f2b65dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_6:
	.word   10,13,0,0
	.long   04f2b865H
	.word   04000H
	.long   SGMD8GLD
osgmd10_7:
	.word   10,13,0,0
	.long   04f2ba6dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_8:
	.word   10,13,0,0
	.long   04f2bc75H
	.word   04000H
	.long   SGMD8GLD
osgmd10_9:
	.word   10,13,0,0
	.long   04f2be7dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_PCT:
	.word   14,13,0,0
	.long   04f2c085H
	.word   04000H
	.long   SGMD8GLD
osgmd10_EXP:
	.word   5,13,0,0
	.long   04f2c35dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_OBR:
	.word   6,13,0,0
	.long   04f2c461H
	.word   04000H
	.long   SGMD8GLD
osgmd10_CBR:
	.word   6,13,0,0
	.long   04f2c599H
	.word   04000H
	.long   SGMD8GLD
osgmd10_QUE:
	.word   10,13,0,0
	.long   04f2c6d1H
	.word   04000H
	.long   SGMD8GLD
osgmd10_COM:
	.word   5,7,0,-8
	.long   04f2c8d9H
	.word   04000H
	.long   SGMD8GLD
osgmd10_DOT:
	.word   5,5,0,-8
	.long   04f2c965H
	.word   04000H
	.long   SGMD8GLD
osgmd10_COL:
	.word   5,9,0,-2
	.long   04f2c9c9H
	.word   04000H
	.long   SGMD8GLD
osgmd10_DAS:
	.word   8,5,0,-4
	.long   04f2ca7dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_NUM:
	.word   12,13,0,0
	.long   04f2cb1dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_AND:
	.word   13,13,0,0
	.long   04f2cd8dH
	.word   04000H
	.long   SGMD8GLD
osgmd10_SLS:
	.word   14,13,0,0
	.long   04f2d031H
	.word   04000H
	.long   SGMD8GLD
osgmd10_DOL:
	.word   10,13,0,0
	.long   04f2d309H
	.word   04000H
	.long   SGMD8GLD
osgmd10_APO:
	.word   5,7,0,0
	.long   04f2d511H
	.word   04000H
	.long   SGMD8GLD
dronetxt:
	.word   87,71,-7,-16
	.long   04f2d59dH
	.word   04000H
	.long   textp
firstwin:
	.word   101,107,0,0
	.long   04f33621H
	.word   05000H
	.long   GROWBOXb
colormessage:
	.word   80,22,-10,-45
	.long   04f40934H
	.word   04000H
	.long   textp
joycontrol:
	.word   80,14,-10,-17
	.long   04f424b4H
	.word   04000H
	.long   textp
red:
	.word   17,6,-40,-69
	.long   04f43634H
	.word   04000H
	.long   textp
blue:
	.word   23,6,-39,-69
	.long   04f437ccH
	.word   04000H
	.long   textp
green:
	.word   29,6,-34,-69
	.long   04f439f4H
	.word   04000H
	.long   textp
yellow:
	.word   37,6,-31,-69
	.long   04f43cacH
	.word   04000H
	.long   textp
message1:
	.word   71,29,-15,-22
	.long   04f44024H
	.word   04000H
	.long   textp
message2:
	.word   77,30,-12,-10
	.long   04f46050H
	.word   04000H
	.long   textp
message3:
	.word   64,29,-18,-21
	.long   04f48468H
	.word   04000H
	.long   textp
message4:
	.word   89,38,-6,-10
	.long   04f4a168H
	.word   04000H
	.long   textp
message5:
	.word   86,38,-7,-19
	.long   04f4d640H
	.word   04000H
	.long   textp
message6:
	.word   80,30,-10,-22
	.long   04f50950H
	.word   04000H
	.long   textp
message7:
	.word   78,38,-11,-56
	.long   04f52ed0H
	.word   04000H
	.long   textp
message9:
	.word   85,32,-8,-57
	.long   04f55d20H
	.word   04000H
	.long   textp
message2a:
	.word   77,30,-13,-23
	.long   04f46050H
	.word   04000H
	.long   textp
infobox:
	.word   101,64,0,0
	.long   04f587a0H
	.word   05000H
	.long   GROWBOXg
infoboxy:
	.word   101,64,0,0
	.long   04f587a0H
	.word   05000H
	.long   GROWBOXy
infoboxr:
	.word   101,64,0,0
	.long   04f587a0H
	.word   05000H
	.long   GROWBOXr
SUBLOGO:
	.word   212,196,0,0
	.long   04f8eb9fH
	.word   00H
	.long   SUBLOGO_p
nbalogo:
	.word   94,187,46,0
	.long   04fdfe1fH
	.word   07000H
	.long   nbalgo_P
stay:
	.word   199,131,99,-26
	.long   04ffdec5H
	.word   00H
	.long   stay_p
scobars:
	.word   100,68,0,0
	.long   05030d6dH
	.word   04000H
	.long   COBARS_p
JAMSESS:
	.word   307,196,0,0
	.long   050377adH
	.word   06000H
	.long   JAMSES_p
bkbd1:
	.word   24,20,11,48
	.long   0508f9f5H
	.word   07000H
	.long   viewp
bkbd2:
	.word   88,52,43,28
	.long   05090715H
	.word   07000H
	.long   viewp
bkbd3:
	.word   39,105,19,-24
	.long   05098435H
	.word   07000H
	.long   viewp
TROPHYD1:
	.word   136,201,0,0
	.long   0509f42eH
	.word   0a80H
	.long   TROPHY_P
bigbull:
	.word   185,183,91,91
	.long   050c5436H
	.word   00H
	.long   bigbull_p
wil1:
	.word   25,31,12,27
	.long   0510762eH
	.word   06000H
	.long   Will_p
wil2:
	.word   27,31,12,25
	.long   05108858H
	.word   06000H
	.long   Will_p
wil3:
	.word   31,31,13,28
	.long   05109bf6H
	.word   06000H
	.long   Will_p
wil4:
	.word   27,31,12,27
	.long   0510b27cH
	.word   06000H
	.long   Will_p
wil5:
	.word   25,30,13,28
	.long   0510c61aH
	.word   06000H
	.long   Will_p
steve1:
	.word   27,33,13,29
	.long   0510d7aeH
	.word   06000H
	.long   Steve_p
steve2:
	.word   28,31,14,27
	.long   0510ec90H
	.word   06000H
	.long   Steve_p
steve3:
	.word   33,30,16,26
	.long   051100e8H
	.word   06000H
	.long   Steve_p
steve4:
	.word   28,30,14,27
	.long   0511181cH
	.word   06000H
	.long   Steve_p
steve5:
	.word   27,31,12,29
	.long   05112bccH
	.word   06000H
	.long   Steve_p
tonysc1:
	.word   23,29,10,27
	.long   05113f6aH
	.word   06000H
	.long   TonyS_p
tonysc2:
	.word   26,28,11,25
	.long   05114f0cH
	.word   06000H
	.long   TonyS_p
tonysc3:
	.word   30,29,13,26
	.long   0511601cH
	.word   06000H
	.long   TonyS_p
tonysc4:
	.word   24,31,12,27
	.long   05117480H
	.word   06000H
	.long   TonyS_p
tonysc5:
	.word   23,30,12,27
	.long   051185f0H
	.word   06000H
	.long   TonyS_p
jamie1:
	.word   29,33,15,32
	.long   0511961cH
	.word   06000H
	.long   jamie_P
jamie2:
	.word   32,31,16,30
	.long   0511ac8aH
	.word   06000H
	.long   jamie_P
jamie3:
	.word   34,33,15,32
	.long   0511c3caH
	.word   06000H
	.long   jamie_P
jamie4:
	.word   31,34,11,33
	.long   0511de16H
	.word   06000H
	.long   jamie_P
jamie5:
	.word   27,35,13,34
	.long   0511f6caH
	.word   06000H
	.long   jamie_P
jamie6:
	.word   34,30,24,26
	.long   05120cf0H
	.word   06000H
	.long   jamie_P
jamie7:
	.word   35,34,10,27
	.long   051224d8H
	.word   06000H
	.long   jamie_P
jamie8:
	.word   37,34,6,29
	.long   051240bcH
	.word   06000H
	.long   jamie_P
jamie9:
	.word   35,33,7,28
	.long   05125e38H
	.word   06000H
	.long   jamie_P
jamie10:
	.word   28,33,13,27
	.long   0512794aH
	.word   06000H
	.long   jamie_P
jamie11:
	.word   30,36,13,26
	.long   05128ef2H
	.word   06000H
	.long   jamie_P
jamie12:
	.word   33,32,16,31
	.long   0512a842H
	.word   06000H
	.long   jamie_P
jamie13:
	.word   37,32,18,31
	.long   0512c102H
	.word   06000H
	.long   jamie_P
jamie14:
	.word   29,33,14,32
	.long   0512dcc2H
	.word   06000H
	.long   jamie_P
jamie15:
	.word   28,32,13,31
	.long   0512f330H
	.word   06000H
	.long   jamie_P
jamie16:
	.word   35,30,33,23
	.long   05130830H
	.word   06000H
	.long   jamie_P
TG01:
	.word   24,51,12,32
	.long   051320ccH
	.word   06000H
	.long   TG_p
TG02:
	.word   34,56,20,32
	.long   05133d7cH
	.word   06000H
	.long   TG_p
TG03:
	.word   35,53,18,32
	.long   05136a1cH
	.word   06000H
	.long   TG_p
TG04:
	.word   29,36,14,32
	.long   05139596H
	.word   06000H
	.long   TG_p
TG05:
	.word   24,38,12,32
	.long   0513ae0eH
	.word   06000H
	.long   TG_p
TG06:
	.word   30,48,20,27
	.long   0513c36eH
	.word   06000H
	.long   TG_p
TG07:
	.word   46,48,25,31
	.long   0513e52eH
	.word   06000H
	.long   TG_p
TG08:
	.word   44,37,17,30
	.long   051418eeH
	.word   06000H
	.long   TG_p
TG09:
	.word   31,37,11,34
	.long   05143f16H
	.word   06000H
	.long   TG_p
TG10:
	.word   23,37,12,34
	.long   051459f8H
	.word   06000H
	.long   TG_p
TG11:
	.word   25,34,12,26
	.long   05146deaH
	.word   06000H
	.long   TG_p
TG12:
	.word   33,54,23,30
	.long   051481d6H
	.word   06000H
	.long   TG_p
TG13:
	.word   34,48,20,29
	.long   0514ab9aH
	.word   06000H
	.long   TG_p
TG14:
	.word   26,39,14,30
	.long   0514d1daH
	.word   06000H
	.long   TG_p
TG15:
	.word   24,34,11,28
	.long   0514e99eH
	.word   06000H
	.long   TG_p
TG16:
	.word   34,32,29,23
	.long   0514fcbeH
	.word   06000H
	.long   TG_p
JC1:
	.word   24,38,11,34
	.long   0515163eH
	.word   06000H
	.long   JC_p
JC10:
	.word   24,41,12,38
	.long   05152b9eH
	.word   06000H
	.long   JC_p
JC11:
	.word   24,36,13,31
	.long   051542aeH
	.word   06000H
	.long   JC_p
JC12:
	.word   31,37,19,32
	.long   051556eeH
	.word   06000H
	.long   JC_p
JC13:
	.word   34,37,21,32
	.long   051571d0H
	.word   06000H
	.long   JC_p
JC14:
	.word   29,37,15,33
	.long   05158f4cH
	.word   06000H
	.long   JC_p
JC15:
	.word   24,37,11,33
	.long   0515a872H
	.word   06000H
	.long   JC_p
JC16:
	.word   37,32,18,31
	.long   0515bd42H
	.word   06000H
	.long   JC_p
JC2:
	.word   30,38,14,33
	.long   0515d902H
	.word   06000H
	.long   JC_p
JC3:
	.word   31,39,15,34
	.long   0515f3baH
	.word   06000H
	.long   JC_p
JC4:
	.word   29,40,13,35
	.long   05161010H
	.word   06000H
	.long   JC_p
JC5:
	.word   24,39,12,35
	.long   05162b40H
	.word   06000H
	.long   JC_p
JC6:
	.word   31,35,24,31
	.long   05164130H
	.word   06000H
	.long   JC_p
JC7:
	.word   30,39,13,32
	.long   05165a9eH
	.word   06000H
	.long   JC_p
JC8:
	.word   33,40,11,33
	.long   0516760aH
	.word   06000H
	.long   JC_p
JC9:
	.word   29,40,7,35
	.long   051694faH
	.word   06000H
	.long   JC_p
MT01:
	.word   36,44,18,31
	.long   0516b02aH
	.word   06000H
	.long   MT_p
MT02:
	.word   36,41,17,30
	.long   0516d54aH
	.word   06000H
	.long   MT_p
MT03:
	.word   39,43,24,34
	.long   0516f7e2H
	.word   06000H
	.long   MT_p
MT04:
	.word   39,39,21,32
	.long   05171f30H
	.word   06000H
	.long   MT_p
MT05:
	.word   38,41,19,32
	.long   051742d6H
	.word   06000H
	.long   MT_p
MT06:
	.word   42,34,19,24
	.long   0517675aH
	.word   06000H
	.long   MT_p
MT07:
	.word   41,38,20,28
	.long   051788d2H
	.word   06000H
	.long   MT_p
MT08:
	.word   43,38,17,32
	.long   0517ad56H
	.word   06000H
	.long   MT_p
MT09:
	.word   42,38,20,33
	.long   0517d3a2H
	.word   06000H
	.long   MT_p
MT10:
	.word   37,42,19,33
	.long   0517f90aH
	.word   06000H
	.long   MT_p
MT11:
	.word   38,39,20,29
	.long   05181d76H
	.word   06000H
	.long   MT_p
MT12:
	.word   34,45,20,28
	.long   05184032H
	.word   06000H
	.long   MT_p
MT13:
	.word   34,45,20,28
	.long   0518640eH
	.word   06000H
	.long   MT_p
MT14:
	.word   33,44,18,27
	.long   051887eaH
	.word   06000H
	.long   MT_p
MT15:
	.word   41,47,20,25
	.long   0518a9f2H
	.word   06000H
	.long   MT_p
MT16:
	.word   39,38,34,20
	.long   0518d71cH
	.word   06000H
	.long   MT_p
SAL1:
	.word   28,46,12,34
	.long   0518f9d8H
	.word   06000H
	.long   SAL_P
SAL2:
	.word   37,46,20,35
	.long   05191808H
	.word   06000H
	.long   SAL_P
SAL3:
	.word   36,46,16,36
	.long   05193fecH
	.word   06000H
	.long   SAL_P
SAL4:
	.word   30,36,14,35
	.long   051966bcH
	.word   06000H
	.long   SAL_P
SAL5:
	.word   28,40,14,35
	.long   0519800cH
	.word   06000H
	.long   SAL_P
SAL6:
	.word   35,46,22,31
	.long   05199a4cH
	.word   06000H
	.long   SAL_P
SAL7:
	.word   40,38,15,33
	.long   0519c008H
	.word   06000H
	.long   SAL_P
SAL8:
	.word   40,39,14,34
	.long   0519e3a8H
	.word   06000H
	.long   SAL_P
SAL9:
	.word   33,39,13,36
	.long   051a0838H
	.word   06000H
	.long   SAL_P
SAL10:
	.word   27,38,14,34
	.long   051a2662H
	.word   06000H
	.long   SAL_P
SAL11:
	.word   27,36,14,27
	.long   051a3e6eH
	.word   06000H
	.long   SAL_P
SAL12:
	.word   32,52,21,33
	.long   051a5536H
	.word   06000H
	.long   SAL_P
SAL13:
	.word   34,46,20,33
	.long   051a7c36H
	.word   06000H
	.long   SAL_P
SAL14:
	.word   29,42,17,33
	.long   051aa0deH
	.word   06000H
	.long   SAL_P
SAL15:
	.word   27,33,13,32
	.long   051abd6aH
	.word   06000H
	.long   SAL_P
SAL16:
	.word   35,39,34,26
	.long   051ad24cH
	.word   06000H
	.long   SAL_P
SHAW1:
	.word   23,31,11,30
	.long   051af24aH
	.word   06000H
	.long   SHAW_P
SHAW2:
	.word   27,36,13,33
	.long   051b0300H
	.word   06000H
	.long   SHAW_P
SHAW3:
	.word   31,36,14,34
	.long   051b19c8H
	.word   06000H
	.long   SHAW_P
SHAW4:
	.word   27,34,13,33
	.long   051b33f0H
	.word   06000H
	.long   SHAW_P
SHAW5:
	.word   23,34,11,33
	.long   051b4974H
	.word   06000H
	.long   SHAW_P
SHAW6:
	.word   26,30,19,28
	.long   051b5bc8H
	.word   06000H
	.long   SHAW_P
SHAW7:
	.word   26,39,9,33
	.long   051b6e10H
	.word   06000H
	.long   SHAW_P
SHAW8:
	.word   31,38,7,34
	.long   051b85d4H
	.word   06000H
	.long   SHAW_P
SHAW9:
	.word   26,38,8,36
	.long   051ba170H
	.word   06000H
	.long   SHAW_P
SHAW10:
	.word   22,39,11,35
	.long   051bb898H
	.word   06000H
	.long   SHAW_P
SHAW11:
	.word   23,38,11,27
	.long   051bccb4H
	.word   06000H
	.long   SHAW_P
SHAW12:
	.word   30,31,20,29
	.long   051be130H
	.word   06000H
	.long   SHAW_P
SHAW13:
	.word   33,32,21,30
	.long   051bf6fcH
	.word   06000H
	.long   SHAW_P
SHAW14:
	.word   29,33,17,31
	.long   051c0fbcH
	.word   06000H
	.long   SHAW_P
SHAW15:
	.word   22,32,10,31
	.long   051c262aH
	.word   06000H
	.long   SHAW_P
SHAW16:
	.word   34,32,33,21
	.long   051c36aaH
	.word   06000H
	.long   SHAW_P
JONH1:
	.word   24,33,14,32
	.long   051c502aH
	.word   06000H
	.long   JONH_P
JONH2:
	.word   28,35,17,34
	.long   051c62baH
	.word   06000H
	.long   JONH_P
JONH3:
	.word   30,36,14,35
	.long   051c79b2H
	.word   06000H
	.long   JONH_P
JONH4:
	.word   29,36,14,35
	.long   051c9302H
	.word   06000H
	.long   JONH_P
JONH5:
	.word   25,35,12,34
	.long   051cab7aH
	.word   06000H
	.long   JONH_P
JONH6:
	.word   28,29,24,26
	.long   051cbffcH
	.word   06000H
	.long   JONH_P
JONH7:
	.word   29,38,10,33
	.long   051cd304H
	.word   06000H
	.long   JONH_P
JONH8:
	.word   32,38,7,34
	.long   051cecd8H
	.word   06000H
	.long   JONH_P
JONH9:
	.word   29,39,7,35
	.long   051d0958H
	.word   06000H
	.long   JONH_P
JONH10:
	.word   23,38,11,34
	.long   051d23daH
	.word   06000H
	.long   JONH_P
JONH11:
	.word   24,36,11,27
	.long   051d3856H
	.word   06000H
	.long   JONH_P
JONH12:
	.word   31,33,20,32
	.long   051d4c96H
	.word   06000H
	.long   JONH_P
JONH13:
	.word   34,34,21,33
	.long   051d6490H
	.word   06000H
	.long   JONH_P
JONH14:
	.word   28,33,17,32
	.long   051d7fa8H
	.word   06000H
	.long   JONH_P
JONH15:
	.word   24,31,11,30
	.long   051d9550H
	.word   06000H
	.long   JONH_P
JONH16:
	.word   36,33,32,22
	.long   051da6c0H
	.word   06000H
	.long   JONH_P
GEOR1:
	.word   23,31,11,30
	.long   051dc298H
	.word   06000H
	.long   GEOR_P
GEOR2:
	.word   31,34,16,32
	.long   051dd34eH
	.word   06000H
	.long   GEOR_P
GEOR3:
	.word   33,35,17,33
	.long   051dec02H
	.word   06000H
	.long   GEOR_P
GEOR4:
	.word   27,34,14,32
	.long   051e0714H
	.word   06000H
	.long   GEOR_P
GEOR5:
	.word   23,36,11,33
	.long   051e1c98H
	.word   06000H
	.long   GEOR_P
GEOR6:
	.word   29,29,21,25
	.long   051e3000H
	.word   06000H
	.long   GEOR_P
GEOR7:
	.word   30,35,9,29
	.long   051e43b6H
	.word   06000H
	.long   GEOR_P
GEOR8:
	.word   33,37,6,32
	.long   051e5c52H
	.word   06000H
	.long   GEOR_P
GEOR9:
	.word   28,37,5,34
	.long   051e78f0H
	.word   06000H
	.long   GEOR_P
GEOR10:
	.word   24,39,12,35
	.long   051e9138H
	.word   06000H
	.long   GEOR_P
GEOR11:
	.word   25,37,13,28
	.long   051ea728H
	.word   06000H
	.long   GEOR_P
GEOR12:
	.word   33,37,22,30
	.long   051ebcd6H
	.word   06000H
	.long   GEOR_P
GEOR13:
	.word   37,35,24,30
	.long   051ed974H
	.word   06000H
	.long   GEOR_P
GEOR14:
	.word   29,33,18,31
	.long   051ef7ceH
	.word   06000H
	.long   GEOR_P
GEOR15:
	.word   23,31,11,30
	.long   051f0e3cH
	.word   06000H
	.long   GEOR_P
GEOR16:
	.word   37,35,36,26
	.long   051f1ef2H
	.word   06000H
	.long   GEOR_P
SHER1:
	.word   27,32,12,31
	.long   051f3d4cH
	.word   06000H
	.long   SHER_P
SHER2:
	.word   33,38,16,34
	.long   051f518cH
	.word   06000H
	.long   SHER_P
SHER3:
	.word   35,41,14,36
	.long   051f6ef0H
	.word   06000H
	.long   SHER_P
SHER4:
	.word   32,40,15,37
	.long   051f9092H
	.word   06000H
	.long   SHER_P
SHER5:
	.word   28,41,15,37
	.long   051fae92H
	.word   06000H
	.long   SHER_P
SHER6:
	.word   30,32,21,28
	.long   051fc97aH
	.word   06000H
	.long   SHER_P
SHER7:
	.word   32,39,11,32
	.long   051fdffaH
	.word   06000H
	.long   SHER_P
SHER8:
	.word   33,40,6,34
	.long   051ffd3aH
	.word   06000H
	.long   SHER_P
SHER9:
	.word   33,43,13,38
	.long   05201c2aH
	.word   06000H
	.long   SHER_P
SHER10:
	.word   29,45,16,38
	.long   05203d6cH
	.word   06000H
	.long   SHER_P
SHER11:
	.word   27,39,15,30
	.long   05205c02H
	.word   06000H
	.long   SHER_P
SHER12:
	.word   33,35,23,31
	.long   052074b0H
	.word   06000H
	.long   SHER_P
SHER13:
	.word   34,34,22,33
	.long   05208fc2H
	.word   06000H
	.long   SHER_P
SHER14:
	.word   31,35,20,34
	.long   0520aadaH
	.word   06000H
	.long   SHER_P
SHER15:
	.word   28,32,15,31
	.long   0520c448H
	.word   06000H
	.long   SHER_P
SHER16:
	.word   37,34,36,24
	.long   0520d948H
	.word   06000H
	.long   SHER_P
JOHNN01:
	.word   34,28,16,27
	.long   0520f6c4H
	.word   06000H
	.long   JOHNN
JOHNN02:
	.word   35,35,17,29
	.long   05210d14H
	.word   06000H
	.long   JOHNN
JOHNN03:
	.word   36,35,15,30
	.long   052129caH
	.word   06000H
	.long   JOHNN
JOHNN04:
	.word   35,37,16,32
	.long   05214752H
	.word   06000H
	.long   JOHNN
JOHNN05:
	.word   32,35,18,32
	.long   052165acH
	.word   06000H
	.long   JOHNN
JOHNN06:
	.word   34,27,24,23
	.long   05217fecH
	.word   06000H
	.long   JOHNN
JOHNN07:
	.word   34,33,12,28
	.long   05219570H
	.word   06000H
	.long   JOHNN
JOHNN08:
	.word   38,39,12,32
	.long   0521afbcH
	.word   06000H
	.long   JOHNN
JOHNN09:
	.word   34,39,11,33
	.long   0521d278H
	.word   06000H
	.long   JOHNN
JOHNN10:
	.word   35,38,19,32
	.long   0521f18cH
	.word   06000H
	.long   JOHNN
JOHNN11:
	.word   34,39,17,34
	.long   052210b8H
	.word   06000H
	.long   JOHNN
JOHNN12:
	.word   37,32,24,28
	.long   05222fccH
	.word   06000H
	.long   JOHNN
JOHNN13:
	.word   41,32,23,28
	.long   05224b8cH
	.word   06000H
	.long   JOHNN
JOHNN14:
	.word   35,31,18,29
	.long   05226a4cH
	.word   06000H
	.long   JOHNN
JOHNN15:
	.word   32,33,18,30
	.long   052283baH
	.word   06000H
	.long   JOHNN
JOHNN16:
	.word   37,33,36,19
	.long   05229c7aH
	.word   06000H
	.long   JOHNN
TON_GOS:
	.word   73,62,0,0
	.long   0522b918H
	.word   00H
	.long   TONYG_p
SHA_LIP:
	.word   85,92,0,0
	.long   05234688H
	.word   00H
	.long   SHA_LIP_p
MRK_TUR:
	.word   77,57,0,0
	.long   05243ae8H
	.word   00H
	.long   MAR_TUR_p
JAM_RIV:
	.word   76,62,0,0
	.long   0524c410H
	.word   00H
	.long   RJR_p
JON_CAR:
	.word   83,63,0,0
	.long   05255750H
	.word   00H
	.long   JOHNC_p
JON_HEY:
	.word   84,61,0,0
	.long   0525fab8H
	.word   00H
	.long   JON_HEY_p
SAL_DIV:
	.word   76,60,0,0
	.long   05269ad8H
	.word   00H
	.long   SAL_DIV_p
CLD1A:
	.word   9,9,4,4
	.long   05272958H
	.word   06000H
	.long   GREYPAL
CLDB1:
	.word   12,11,5,5
	.long   05272b3eH
	.word   06000H
	.long   BLUBOOM
CLDB1YELL:
	.word   12,11,6,20
	.long   05272b3eH
	.word   06000H
	.long   YELLPAL
CLDB1WHT:
	.word   12,11,6,20
	.long   05272b3eH
	.word   06000H
	.long   WHTPAL
CLDB1ORNG:
	.word   12,11,6,20
	.long   05272b3eH
	.word   06000H
	.long   ORNGPAL
CLDB1LGRY:
	.word   12,11,6,20
	.long   05272b3eH
	.word   06000H
	.long   LGRYPAL
CLDB1GRN:
	.word   12,11,6,20
	.long   05272b3eH
	.word   06000H
	.long   GRNPAL
CLDB1PURP:
	.word   12,11,6,20
	.long   05272b3eH
	.word   06000H
	.long   PURPPAL
CLD2:
	.word   25,29,12,15
	.long   05272e56H
	.word   06000H
CLD3:
	.word   29,32,15,17
	.long   05273f54H
	.word   06000H
CLD4:
	.word   25,31,13,18
	.long   05275514H
	.word   06000H
CLD4A:
	.word   28,37,14,26
	.long   0527673eH
	.word   06000H
CLD4B:
	.word   32,38,17,29
	.long   05277f86H
	.word   06000H
CLD5:
	.word   36,34,17,17
	.long   05279c06H
	.word   06000H
CLD6:
	.word   36,36,18,19
	.long   0527b8b6H
	.word   06000H
CLD7:
	.word   36,36,18,19
	.long   0527d716H
	.word   06000H
CLD8:
	.word   32,32,16,18
	.long   0527f576H
	.word   06000H
CLD9:
	.word   30,29,16,15
	.long   05280d76H
	.word   06000H
CLD10:
	.word   29,30,14,15
	.long   052821daH
	.word   06000H
CLD11:
	.word   29,30,14,15
	.long   0528363eH
	.word   06000H
CLDB2:
	.word   22,22,11,11
	.long   05284aa2H
	.word   06000H
CLDB3:
	.word   28,30,13,14
	.long   052855faH
	.word   06000H
CLDB4:
	.word   32,31,15,15
	.long   052869aaH
	.word   06000H
flash1:
	.word   3,3,1,1
	.long   052a8a51H
	.word   00H
	.long   CROWD_p
flash4:
	.word   22,23,11,11
	.long   052a8a99H
	.word   00H
	.long   CROWD_p
flash2:
	.word   9,9,4,4
	.long   052a9a69H
	.word   00H
flash3:
	.word   20,19,10,9
	.long   052a9cf1H
	.word   00H
flash3a:
	.word   35,37,17,18
	.long   052aa8d1H
	.word   00H
flash5:
	.word   50,44,24,22
	.long   052ad149H
	.word   00H
flash6:
	.word   61,51,30,25
	.long   052b1609H
	.word   00H
	.include BGNDTBL.GLO

slogo2:
	.word   64,65,0,0
	.long   0542cdddH
	.word   06000H
	.long   SLOGO_p