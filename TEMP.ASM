;Turmell
	.ref	team_nums

	movk	1,a0			;Atlanta
	move	a0,@team_nums		;Team controlled by plyrs 1 & 2
	movk	2,a0			;Boston
	move	a0,@team_nums+16	;Team controlled by plyrs 3 & 4
	RETP

