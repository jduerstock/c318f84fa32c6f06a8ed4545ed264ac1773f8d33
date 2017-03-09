
	.include "interfaces.s"

sub_10000000:
	lea	%a5@(-400),%sp
	btst	#5,0x1efc
	bnes	.L1000002c
	subql	#4,%sp
	moveal	%sp,%a0
	movel	#65674,%d0
	_ReadXPRAM
	orib	#32,%a0@
	movel	#65674,%d0
	_WriteXPRAM
	addql	#4,%sp
	movew	#2,%sp@-
	_ShutDown

.L1000002c:
	clrw	%a5@(50)
	clrl	%a5@(52)
	clrw	%a5@(56)
	clrl	%a5@(58)
	movew	#-1,%a5@(50)
	subaw	#80,%sp
	moveal	%sp,%a0
	clrl	%a0@(12)
	clrl	%a0@(18)
	clrw	%a0@(28)
	clrw	%a0@(22)
	movew	SysMap,%a0@(24)
	moveq	#8,%d0
	_HFSDispatch
	cmpiw	#0,%d0
	bnes	.L10000074
	movew	%a0@(52),%a5@(50)
	movel	%a0@(58),%a5@(52)

.L10000074:
	movew	SysMap,%d0
	cmpw	CurMap,%d0
	beqw	.L100000de
	movew	CurMap,%a0@(24)
	moveq	#8,%d0
	_HFSDispatch
	cmpiw	#0,%d0
	bnes	.L100000a6
	movel	%a0@(58),%a5@(58)
	movew	%a0@(52),%d0
	cmpw	%a5@(50),%d0
	beqs	.L100000a6
	movew	%a0@(52),%a5@(56)

.L100000a6:
	addaw	#80,%sp
	movew	SysMap,%d0
	cmpw	CurMap,%d0
	beqw	.L100000de
	moveal	0xa54,%a0
	moveal	%a0@,%a0
	moveal	%a0@(16),%a0
	movel	%a0,TopMapHndl
	moveal	%a0@,%a0
	movel	%a0@(16),%d0
	movel	0xa54,%a0@(16)
	moveal	0xa54,%a0
	moveal	%a0@,%a0
	movel	%d0,%a0@(16)
	jsr	%pc@(sub_10002568)

.L100000de:
	moveal	%a3,%a0
	_GetHandleSize
	movel	%d0,%a5@(62)
	lea	%pc@(sub_100000fa),%a0
	lea	%pc@(sub_10000000),%a1
	subal	%a0,%a1
	addl	%a1,%d0
	subal	%d0,%sp
	moveal	%sp,%a1
	_BlockMove
	jmp	%a1@

sub_100000fa:
	movel	%a3,%sp@-
	_ReleaseResource
	moveal	0x2ae,%a0
	addal	#65536,%a0
	movel	%a0,0x0
	movel	%sp,0x908
	moveal	%sp,%a0
	subal	0x322,%a0
	_SetApplLimit
	beqs	.L10000120
	movew	#25,%d0
	_SysError

.L10000120:
	cmpiw	#17218,%a5@(632)
	bnes	.L10000196
	bclr	#2,0xb21
	bsrw	sub_10002296
	movel	%d0,%sp@-
	moveb	0xbff,%d0
	cmpib	#0xff,%d0
	beqs	.L1000015e
	andib	#0xe0,%d0
	cmpib	#96,%d0
	bnes	.L1000015e
	movel	0x120,%d0
	tstl	%d0
	beqs	.L1000015e
	cmpil	#-1,%d0
	beqs	.L1000015e
	pea	%pc@(str_10000162)
	_DebugStr

.L1000015e:
	movel	%sp@+,%d0
	bras	.L10000196

str_10000162:
	.byte	0x32
	.ascii	"MacsBug was loaded at start of boot 3 as requested"
	.byte	0x00

.L10000196:
	moveal	0x2b6,%a0
	movel	%a0@(2),%d0
	cmpil	#0x34a,%d0
	bccs	.L100001d2
	moveal	%a0,%a1
	movel	#842,%d0
	_NewPtrSysClear
	bnew	.L100001d0
	movel	%a1@(2),%d0
	exg	%a0,%a1
	_BlockMoveData
	movew	#363,%a1@
	movel	#842,%a1@(2)
	movel	%a1,0x2b6
	_DisposePtr
	beqs	.L100001d2

.L100001d0:
	_SysError

.L100001d2:
	movew	CurMap,%d0
	cmpw	SysMap,%d0
	beqs	.L100001e4
	moveal	0x2b6,%a0
	movew	%d0,%a0@(674)

.L100001e4:
	moveal	0x2b6,%a0
	tstl	%a0@(738)
	bnes	.L100001fc
	moveq	#8,%d0
	_NewPtrSysClear
	bnes	.L100001fc
	moveal	0x2b6,%a1
	movel	%a0,%a1@(738)

.L100001fc:
	moveq	#20,%d0
	_NewPtrSysClear
	bnes	.L10000270
	moveal	0x2b6,%a1
	movel	%a0,%a1@(772)
	moveal	%a0,%a1
	moveal	0x2a6,%a0
	movel	%a0@,%d1
	_FreeMemSys
	subl	%d0,%d1
	movel	%d1,%a1@
	moveml	%a1,%sp@-
	subqw	#4,%sp
	movel	#1835954797,%sp@-
	clrw	%sp@-
	_GetResource
	movel	%sp@+,%d1
	moveml	%sp@+,%a1
	beqs	.L1000024e
	moveal	%d1,%a0
	_GetHandleSize
	beqs	.L1000024e
	cmpil	#12,%d0
	bcss	.L1000024e
	moveal	%a0@,%a0
	movel	%a0@(4),%a5@(66)
	movel	%a0@(8),%a5@(70)
	bras	.L1000025e

.L1000024e:
	movel	#9961472,%a5@(66)
	movel	#4325376,%a5@(70)

.L1000025e:
	movel	%a1@,%d0
	addl	%a5@(66),%d0
	addl	%a5@(70),%d0
	movel	0x108,%d1
	cmpl	%d1,%d0
	blss	.L10000274

.L10000270:
	_SysError 105

.L10000274:
	movel	#1869637239,%d0
	_Gestalt
	tstw	%d0
	bnew	.L100003a4
	movel	0x108,%d0
	lsrl	#1,%d0
	movel	%a5@(16),%d1
	addil	#1048576,%d1
	cmpl	%d1,%d0
	bcsw	.L100003a4
	pea	%a5@(112)
	clrl	%sp@-
	movel	0xd66,%sp@-
	movel	#2,%sp@-
	pea	%sp@(12)
	movel	#4,%sp@-
	pea	%pc@(.L100002c6)
	clrl	%sp@-
	_Munger
	movel	%sp@+,%d0
	bmis	.L100002c6
	moveal	0xd66,%a0
	moveal	%a0@,%a0
	subqw	#1,%a0@

.L100002c6:
	addqw	#4,%sp
	movel	0x108,%d0
	lsrl	#1,%d0
	moveal	%d0,%a1
	lea	%pc@(sub_10000000),%a0
	bsrl	sub_10002b8e
	moveal	%sp@+,%a2
	movel	%a0,%d2
	movel	%a2,%d3
	subal	%a0,%a2
	movel	%a2,%d0
	subil	#2572,%d2
	addl	%d0,%d3
	cmpl	%a1,%d2
	bges	.L100002f6
	cmpl	%a1,%d3
	bles	.L100002f6
	moveal	%d2,%a1

.L100002f6:
	moveal	%a1,%sp
	lea	%a5@(-400),%a0
	movel	#2572,%d0
	_BlockMoveData
	lea	%a1@(400),%a5
	lea	%a5@(624),%fp
	movel	%a5,0x904
	lea	%a5@(-4),%a0
	movel	%a0,%a5@
	moveal	0xd66,%a0
	_GetHandleSize
	movel	%d0,%d3
	addql	#4,%d0
	_SetHandleSize
	moveal	%a0@,%a0
	movew	%a0@,%d0
	moveal	%a0,%a1
	addal	%d3,%a1
	lea	%a5@(112),%a3
	movel	%a3,%a1@
	addqw	#1,%d0
	movew	%d0,%a0@
	pea	%a5@(112)
	_SetPort
	lea	%a5@(-138),%a1
	movel	%a1,%a5@(-134)
	lea	%a5@(-148),%a0
	movel	%a0,%a1@
	moveal	0x2b6,%a0
	movel	%a0@(800),%d0
	beqs	.L10000358
	lea	%pc@(.L1000038a),%a0
	bras	.L1000035c

.L10000358:
	lea	%pc@(.L100003a4),%a0

.L1000035c:
	bsrl	sub_10002b8e
	moveal	%sp@+,%a1
	subal	%a0,%a1
	movel	%a1,%d0
	subal	%d0,%sp
	moveal	%sp,%a1
	_BlockMove
	movel	%sp,0x908
	moveal	%sp,%a0
	subal	0x322,%a0
	_SetApplLimit
	lea	%a5@(1648),%a0
	cmpal	%a5@(16),%a0
	blss	.L10000388
	movel	%a0,%a5@(16)

.L10000388:
	jmp	%sp@

.L1000038a:
	jsr	%pc@(sub_1000780a)
	moveal	0x2b6,%a0
	moveal	%a0@(800),%a0
	moveal	%a0@,%a0
	movel	%a0,%a5@(16)
	moveal	0x108,%a0
	movel	%a0,%a5@(8)

.L100003a4:
	moveal	0xbb8,%a0
	tstb	%a0@(175)
	bnes	.L100003ba
	lea	%a5@(-400),%a0
	movew	0x210,%a0@(22)
	_MountVol

.L100003ba:
	movew	#-21623,%d0
	bsrw	sub_10002366
	moveal	0x2b6,%a0
	movel	%a0@(746),%d0
	beqw	.L100003d2
	moveal	%d0,%a0
	jsr	%a0@

.L100003d2:
	bsrw	sub_100052c6
	btst	#2,0xb20
	beqs	.L100003e2
	_SysError 102

.L100003e2:
	jsr	%pc@(sub_10007914)
	movel	#_fcc_bbox,%d0
	_Gestalt
	beqs	.L1000040a
	clrb	%sp@-
	jsr	%pc@(sub_10007910)
	tstb	%sp@+
	bnes	.L1000040a
	movew	#156,%d0
	bsrw	sub_10002366
	movew	#911,%d0
	bsrw	sub_10002366

.L1000040a:
	movew	CurMap,%sp@-
	clrw	%sp@-
	jsr	%pc@(sub_10007f70)
	movew	%sp@+,%d1
	beqs	.L1000041c
	_SysError 99

.L1000041c:
	moveal	0xbb8,%a0
	st	%a0@(2927)
	movew	%sp@+,CurMap
	bsrw	sub_10002acc
	jsr	%pc@(sub_1000790c)
	movel	#_fcc_bbox,%d0
	_Gestalt
	beqs	.L10000452
	lea	%pc@(dword_1000250c),%a1
	lea	0x174,%a0
	moveq	#3,%d0

.L10000444:
	cmpml	%a0@+,%a1@+
	dbne	%d0,.L10000444
	beqs	.L10000452
	bsrl	sub_1000935e

.L10000452:
	bsrw	sub_100052ea
	moveq	#40,%d0
	bsrw	sub_1000539a
	moveal	0x2ae,%a0
	moveb	%a0@(18),%d0
	cmpib	#66,%d0
	beqw	.L10000514
	cmpib	#64,%d0
	beqw	.L10000514
	cmpib	#69,%d0
	beqw	.L10000514
	cmpib	#51,%d0
	beqw	.L10000514
	movel	0x30a,%d0
	braw	.L1000050e

.L1000048c:
	movew	%a0@(8),%d0
	notw	%d0
	moveal	@(0x11c)@(%d0:w:4),%a1
	moveal	%a1@,%a1
	btst	#6,%a1@(5)
	moveal	%a1@,%a1
	beqs	.L100004a6
	moveal	%a1@,%a1

.L100004a6:
	movel	%a1@(18),%d0
	movel	#-256,%d1
	andl	%a1@(22),%d1
	cmpil	#103695684,%d0
	bnes	.L1000050c
	cmpil	#1769171712,%d1
	bnes	.L1000050c
	moveq	#0,%d3
	.short	0x2030,0x81f2,0x68ff,0xefd8,0x0010	/* movel	@(0x68ffefd8)@(0x10),%d0 */
	bfffo	%d0,15,15,%d3
	eorib	#31,%d3
	movel	%a0@(-40),%d2
	bnew	.L100004ee
	movel	%a0@(-32),%d2
	subl	%a0@(-36),%d2
	movel	%a0@(-36),%d0
	bras	.L100004fa

.L100004ee:
	movel	%a0@(-32),%d2
	subl	%a0@(-40),%d2
	movel	%a0@(-40),%d0

.L100004fa:
	lsrl	%d3,%d2
	lsrl	%d3,%d0
	moveal	%d0,%a0

.L10000500:
	_nkMakePageWriteThrough
	addqw	#1,%a0
	subql	#1,%d2
	bnes	.L10000500
	bras	.L10000514

.L1000050c:
	movel	%a0@,%d0

.L1000050e:
	moveal	%d0,%a0
	bnew	.L1000048c

.L10000514:
	jsr	%pc@(sub_10003708)
	clrb	0xa5e
	subqw	#4,%sp
	movel	#1684170104,%sp@-
	movew	#-16385,%sp@-
	_GetResource
	st	0xa5e
	movel	%sp@+,%d0
	beqs	.L10000574
	movel	%d0,%sp@-
	_ReleaseResource
	movew	0x17a,%d0
	cmpiw	#-30715,%d0
	beqs	.L10000574
	moveml	0x174,%d0-%d3
	bclr	#7,%d3
	bclr	#1,%d1
	bclr	#0,%d1
	beqs	.L10000574
	bclr	#2,%d1
	bnes	.L10000568
	orl	%d1,%d0
	orl	%d2,%d0
	orl	%d3,%d0
	bnes	.L10000574
	bclr	#3,0xb21

.L10000568:
	bclr	#5,0xb20
	moveq	#-13,%d0
	bsrw	sub_1000539a

.L10000574:
	bsrw	sub_10002a64
	movel	0x108,%a5@(4)
	clrw	%sp@-
	movel	#2019716975,%sp@-
	_CountResources
	movew	%sp@+,%d0
	beqs	.L10000598
	bsrl	sub_1000718a
	bsrl	sub_100071ea

.L10000598:
	bsrl	sub_100083e8
	movew	#-20483,%d0
	bsrw	sub_10002366

.L100005a6:
	bsrw	sub_100025b4
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnew	.L10000696
	movel	%a0,%d0
	btst	#0,%d0
	beqw	.L10000696
	moveal	0x2b6,%a0
	movew	#1,%d0
	moveb	%d0,%a0@(827)
	bsrl	sub_100020d6
	bsrl	sub_10002270
	moveq	#-1,%d0
	_FSM
	subql	#2,%sp
	movel	#1986359923,%d0
	_Gestalt
	cmpaw	#5,%a0
	bcsw	.L1000068c
	movel	#1835884912,%sp@-
	clrl	%sp@-
	movew	#1028,%d0
	_GestaltValueDispatch
	addql	#2,%sp
	pea	%sp@(-4)
	pea	%sp@(-4)
	movel	#131078,%d0
	_BlueBoxDispatch
	moveal	%sp@+,%a0
	movel	%sp@+,%d1
	tstl	%d0
	bnes	.L1000068c
	movel	%a0,%sp@-
	movel	%a0,%a0@-
	movel	%d1,%a0@-
	movel	0x108,%a0@-
	movel	0x10c,%a0@-
	movel	%a0,0x10c
	moveal	%sp@,%a0
	movel	%a0,0x108
	subql	#2,%sp
	movel	#1819435373,%sp@-
	movel	%a0,%sp@-
	movew	#1028,%d0
	_GestaltValueDispatch
	movel	#1835884912,%sp@-
	moveq	#0,%d0
	bset	#0,%d0
	movel	%d0,%sp@-
	movew	#1028,%d0
	_GestaltValueDispatch
	movel	#1986881902,%sp@-
	movel	#3,%sp@-
	movew	#1028,%d0
	_GestaltValueDispatch
	addql	#2,%sp
	bsrl	sub_10002296
	bsrl	sub_10008ff4
	moveal	%sp@+,%a0
	moveal	0x10c,%a1
	movel	%a0@(-16),0x10c
	movel	%a1,%a0@(-16)
	movel	%a0@(-12),0x108
	braw	.L1000072a

.L1000068c:
	bsrl	sub_10002296
	braw	.L1000072a

.L10000696:
	cmpiw	#19010,%a5@(632)
	beqs	.L100006b8
	bsrw	sub_100020d6
	bsrw	sub_100020e0
	_nkMMUFinalInit
	bsrw	sub_10002270
	moveq	#-1,%d0
	_FSM
	bsrw	sub_10002296
	bras	.L1000072a

.L100006b8:
	bsrw	sub_10002296
	movel	%d0,%sp@-
	moveb	0xbff,%d0
	cmpib	#0xff,%d0
	beqs	.L100006e8
	andib	#0xe0,%d0
	cmpib	#96,%d0
	bnes	.L100006e8
	movel	0x120,%d0
	tstl	%d0
	beqs	.L100006e8
	cmpil	#-1,%d0
	beqs	.L100006e8
	pea	%pc@(str_10000700)
	_DebugStr

.L100006e8:
	movel	%sp@+,%d0
	bsrw	sub_100020d6
	bsrw	sub_100020e0
	_nkMMUFinalInit
	bsrw	sub_10002270
	moveq	#-1,%d0
	_FSM
	bras	.L1000072a

str_10000700:
	.byte	0x29
	.ascii	"MacsBug was loaded before VM as requested"

.L1000072a:
	movew	#0xab34,%d0
	bsrw	sub_10002366
	jsr	%pc@(sub_10007bda)
	jsr	%pc@(sub_10005e0a)
	movel	0xcc0,%d0
	notl	%d0
	bnes	.L10000748
	movel	0x2ae,0xcc0

.L10000748:
	bsrw	sub_100024d6
	movel	0x108,%a5@(8)
	moveal	0x2b6,%a0
	movel	%a0@(800),%d0
	beqs	.L10000760
	braw	.L100008aa

.L10000760:
	pea	%a5@(112)
	clrl	%sp@-
	movel	0xd66,%sp@-
	movel	#2,%sp@-
	pea	%sp@(12)
	movel	#4,%sp@-
	pea	%pc@(.L1000078e)
	clrl	%sp@-
	_Munger
	movel	%sp@+,%d0
	bmis	.L1000078e
	moveal	0xd66,%a0
	moveal	%a0@,%a0
	subqw	#1,%a0@

.L1000078e:
	addqw	#4,%sp
	movel	%a5@(8),%d0
	movel	%d0,%d1
	lsrl	#2,%d1
	subl	%d1,%d0
	moveal	%d0,%a1
	lea	%pc@(sub_10000000),%a0
	bsrl	sub_10002b8e
	moveal	%sp@+,%a2
	movel	%a0,%d2
	movel	%a2,%d3
	subal	%a0,%a2
	movel	%a2,%d0
	subil	#2572,%d2
	addl	%d0,%d3
	cmpl	%a1,%d2
	bges	.L100007c2
	cmpl	%a1,%d3
	bles	.L100007c2
	moveal	%d2,%a1

.L100007c2:
	tstl	0xb78
	bmis	.L100007f8
	movel	#1885827962,%d0
	_Gestalt
	bnew	.L1000087c
	bsrl	sub_10002b8e
	moveal	%sp@+,%fp
	movel	%fp,%d1
	lea	%pc@(.L1000087c),%fp
	subl	%fp,%d1
	addil	#8192,%d1
	movew	%a0,%d0
	divuw	%d0,%d1
	moveal	%a1,%a0

.L100007f0:
	tstb	%a0@
	subaw	%d0,%a0
	dbf	%d1,.L100007f0

.L100007f8:
	moveal	%a1,%sp
	lea	%a5@(-400),%a0
	movel	#2572,%d0
	_BlockMoveData
	lea	%a1@(400),%a5
	lea	%a5@(624),%fp
	movel	%a5,0x904
	lea	%a5@(-4),%a0
	movel	%a0,%a5@
	moveal	0xd66,%a0
	_GetHandleSize
	movel	%d0,%d3
	addql	#4,%d0
	_SetHandleSize
	moveal	%a0@,%a0
	movew	%a0@,%d0
	moveal	%a0,%a1
	addal	%d3,%a1
	lea	%a5@(112),%a3
	movel	%a3,%a1@
	addqw	#1,%d0
	movew	%d0,%a0@
	pea	%a5@(112)
	_SetPort
	lea	%a5@(-138),%a1
	movel	%a1,%a5@(-134)
	lea	%a5@(-148),%a0
	movel	%a0,%a1@
	lea	%pc@(.L1000087c),%a0
	bsrl	sub_10002b8e
	moveal	%sp@+,%a1
	subal	%a0,%a1
	movel	%a1,%d0
	subal	%d0,%sp
	moveal	%sp,%a1
	_BlockMove
	movel	%sp,0x908
	moveal	%sp,%a0
	subal	0x322,%a0
	_SetApplLimit
	lea	%a5@(1648),%a0
	cmpal	%a5@(16),%a0
	blss	.L1000087a
	movel	%a0,%a5@(16)

.L1000087a:
	jmp	%sp@

.L1000087c:
	tstl	0xb78
	bmis	.L100008aa
	bsrl	sub_10002b8e
	moveal	%sp@+,%a1
	lea	%pc@(.L100005a6),%a0
	subal	%a0,%a1
	moveq	#1,%d0
	_MemoryDispatch
	movel	0x322,%d0
	addl	%d0,%d0
	addl	0x322,%d0
	lea	%pc@(.L1000087c),%a0
	subal	%d0,%a0
	moveal	%d0,%a1
	moveq	#0,%d0
	_MemoryDispatch

.L100008aa:
	moveq	#2,%d0
	bsrw	sub_10001922
	movel	%d0,%sp@-
	_DetachResource
	movel	%d6,%sp@-
	_ReleaseResource
	movel	#1835884912,%d0
	_Gestalt
	bnes	.L100008ea
	movel	%a0,%d0
	btst	#0,%d0
	beqs	.L100008ea
	movel	#1819435373,%d0
	_Gestalt
	movel	%a0@(-4),0x108
	movel	%a0@(-4),%a5@(8)
	movel	%a0@(-8),%a5@(16)
	movel	%a0@(-16),0x10c

.L100008ea:
	movew	#156,%d0
	lea	%pc@(sub_10002434),%a0
	_SetOSTrapAddress
	lea	%pc@(sub_10002478),%a1
	lea	%pc@(sub_10002484),%a2
	subal	%a1,%a2
	movel	%a2,%d0
	_NewPtrSys
	bnew	sub_1000193a
	exg	%a0,%a1
	movel	%a2,%d0
	_BlockMove
	movel	%a1,%a5@(12)
	lea	%a5@(-400),%a0
	clrl	%a0@(18)
	_GetVol
	movew	%a0@(22),0x210
	movew	#-5,%a0@(24)
	movew	#9,%a0@(26)
	movew	#-255,%a0@(28)
	_Control
	moveb	0x1fb,%d0
	andib	#15,%d0
	beqs	.L1000094e
	cmpib	#1,%d0
	beqs	.L1000094e
	moveal	0x2b6,%a0
	movew	#-1,%a0@(488)

.L1000094e:
	moveal	TopMapHndl,%a0

.L10000952:
	movel	%a0,%d0
	beqs	.L10000964
	moveal	%a0@,%a0
	bclr	#0,%a0@(23)
	moveal	%a0@(16),%a0
	bras	.L10000952

.L10000964:
	moveal	0xa54,%a0
	moveal	%a0@,%a0
	bset	#0,%a0@(23)
	bset	#2,%a0@(23)
	bset	#3,%a0@(23)
	movew	CurMap,%sp@-
	moveal	TopMapHndl,%a0
	moveal	%a0@,%a0
	movew	%a0@(20),CurMap
	moveml	%d2/%a1-%a3,%sp@-
	subqw	#4,%sp
	bsrl	sub_1000970e
	movel	%sp@+,%d1
	bnes	.L100009a0
	_SysError 98

.L100009a0:
	moveml	%sp@+,%d2/%a1-%a3
	swap	%d1
	movew	%d1,0x15a
	movew	%sp@,CurMap
	bsrw	sub_100024d6
	btst	#5,0xb20
	bnes	.L100009d4
	movel	0x10c,%d2
	subil	#180800,%d2
	movel	%a5@(16),%d0
	addil	#409600,%d0
	cmpl	%d0,%d2
	bcss	.L100009f6
	bras	.L100009de

.L100009d4:
	movel	%a5@(16),%d2
	addil	#409600,%d2

.L100009de:
	subqw	#2,%sp
	movel	%d2,%sp@-
	movew	#535,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d0
	cmpiw	#-50,%d0
	bnes	.L100009f6
	moveq	#41,%d0
	bsrw	sub_10002366

.L100009f6:
	moveal	0x2b6,%a0
	movel	#65536,%d0
	movel	%d0,%a0@(430)
	movew	SysMap,%d0
	.short	0x2070,0x81e2,0x2058,0x0068	/* moveal	@(0x2058)@(0x68),%a0 */
	jsr	%a0@
	clrl	%a0@+
	movel	#1,%a0@
	clrw	%sp@-
	_UseResFile
	movel	0xa54,%sp@-
	moveq	#4,%d0
	_ResourceDispatch
	movew	%sp@,CurMap
	bsrw	sub_100023ac
	movew	%sp@,CurMap
	bsrl	sub_10007bde
	bsrw	sub_100025da
	movew	%sp@+,CurMap
	bsrl	sub_10008a2e
	movew	%a5@(50),%sp@-
	movel	%a5@(52),%sp@-
	pea	0xad8
	bsrl	sub_10008a9a
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	bnew	.L10000a68
	jsr	%pc@(sub_10005ff8)

.L10000a68:
	movel	#1886876278,%d0
	_Gestalt
	tstw	%d0
	bnes	.L10000a88
	movel	%a0,%d0
	cmpil	#512,%d0
	blts	.L10000a88
	clrw	%d0
	swap	%d0
	movew	#99,%d0
	_PowerDispatch

.L10000a88:
	bsrw	sub_10002a1c
	jsr	%pc@(sub_100069d2)
	bsrl	sub_1000c5ea
	jsr	%pc@(sub_10007f6c)
	jsr	%pc@(sub_10007f68)
	bsrw	sub_100035be
	bsrw	sub_10005506
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000ac0),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000ad4

str_10000ac0:
	.byte	0x12
	.ascii	"MakeGibblyResident"
	.byte	0x00

.L10000ad4:
	movew	CurMap,%d0
	cmpiw	#3,%d0
	beqs	.L10000afa
	cmpw	SysMap,%d0
	beqs	.L10000afa
	lea	%pc@(dword_10002562),%a0
	moveal	%a0@,%a0
	clrb	%a0@(68)
	movel	TopMapHndl,%sp@-
	movel	0xa54,%sp@-
	moveq	#5,%d0
	_ResourceDispatch

.L10000afa:
	movel	0x33c,%d0
	bles	.L10000b04
	moveal	%d0,%a0
	jsr	%a0@

.L10000b04:
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnes	.L10000b1a
	movel	%a0,%d0
	btst	#0,%d0
	beqs	.L10000b1a
	jsr	%pc@(sub_10007d2c)

.L10000b1a:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000b34),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000b4a

str_10000b34:
	.byte	0x15
	.ascii	"RegisterROMComponents"

.L10000b4a:
	moveq	#42,%d0
	_ComponentDispatch
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000b68),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000b76

str_10000b68:
	.byte	0x0c
	.ascii	"LoadGoNative"
	.byte	0x00

.L10000b76:
	lea	%pc@(dword_100024fa),%a1
	lea	0x174,%a0
	moveq	#3,%d0

.L10000b80:
	cmpml	%a0@+,%a1@+
	dbne	%d0,.L10000b80
	beqs	.L10000b90
	clrw	%sp@-
	jsr	%pc@(sub_10007f64)
	addqw	#2,%sp

.L10000b90:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000baa),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000bbc

str_10000baa:
	.byte	0x11
	.ascii	"LoadEmulatorAccel"

.L10000bbc:
	moveq	#1,%d6
	movel	#1195463257,%d5
	moveq	#0,%d3
	bsrw	sub_1000193e
	bsrw	sub_100024a4
	movel	#-1,0x914
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000bf0),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000c04

str_10000bf0:
	.byte	0x13
	.ascii	"TurnOnDynamicRecomp"

.L10000c04:
	moveaw	#7,%a0
	moveq	#18,%d0
	_MoveToECR
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000c26),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000c3a

str_10000c26:
	.byte	0x12
	.ascii	"TestForNeedToReset"
	.byte	0x00

.L10000c3a:
	tstw	%a5@(20)
	beqs	.L10000c46
	movew	#2,%sp@-
	_ShutDown

.L10000c46:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000c60),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000c78

str_10000c60:
	.byte	0x16
	.ascii	"IncreaseEventQueueSize"
	.byte	0x00

.L10000c78:
	jsr	%pc@(sub_100070ee)
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000c96),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000caa

str_10000c96:
	.byte	0x13
	.ascii	"LoadStartupDispatch"

.L10000caa:
	movew	#-20641,%d0
	bsrw	sub_10002366
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000ccc),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000ce2

str_10000ccc:
	.byte	0x15
	.ascii	"SetupProcessMgrLaunch"

.L10000ce2:
	lea	%pc@(sub_1000188e),%a0
	movew	#0xa9f2,%d0
	_SetTrapAddress
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000d06),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000d1c

str_10000d06:
	.byte	0x15
	.ascii	"CreateApplicationHeap"

.L10000d1c:
	bsrw	sub_10002396
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000d3a),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000d50

str_10000d3a:
	.byte	0x15
	.ascii	"ClearSysHeapTooBigBit"

.L10000d50:
	bclr	#4,0xb21
	movel	#409600,%a5@(22)
	movel	#819200,%a5@(26)
	movel	#1935897449,%d0
	_Gestalt
	tstw	%d0
	bnes	.L10000d8c
	movel	%a0,%d0
	btst	#1,%d0
	beqs	.L10000d8c
	bset	#7,0xc2f
	bsrw	sub_1000643e
	bles	.L10000d8c
	moveaw	#5,%a0
	_InternalWait

.L10000d8c:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000da6),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000db2

str_10000da6:
	.byte	0x0a
	.ascii	"InstallITT"
	.byte	0x00

.L10000db2:
	moveq	#-1,%d4
	movel	#131072,%d5
	bsrw	sub_10001f4e
	tstl	0xb78
	bmis	.L10000dc8
	moveq	#-2,%d0
	_MemoryDispatch

.L10000dc8:
	bsrw	sub_1000619a
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000de6),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000dfa

str_10000de6:
	.byte	0x12
	.ascii	"PreInitMemoryCheck"
	.byte	0x00

.L10000dfa:
	moveal	0x2b6,%a1
	moveal	%a1@(772),%a1
	moveal	0x2a6,%a0
	movel	%a0@,%d1
	_FreeMemSys
	subl	%d0,%d1
	subl	%a1@,%d1
	movel	%d1,%a1@(4)
	movel	0x1ef4,%d1
	subl	0x10c,%d1
	movel	%d1,%a1@(8)
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000e38),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000e4a

str_10000e38:
	.byte	0x11
	.ascii	"LoadScriptSystems"

.L10000e4a:
	subqw	#2,%sp
	movel	#-2113863718,%sp@-
	_ScriptUtil
	addqw	#2,%sp
	btst	#5,0xb20
	beqs	.L10000e76
	bsrl	sub_10009278
	movel	#1702392942,%sp@-
	movel	#1935897193,%sp@-
	bsrw	sub_10001a3e
	bras	.L10000ec0

.L10000e76:
	subqw	#4,%sp
	movel	#1769237603,%sp@-
	clrw	%sp@-
	_GetResource
	movel	%sp@+,%d0
	beqs	.L10000ec0
	moveal	%d0,%a0
	moveal	%a0@,%a0
	movew	%a0@,%d0
	beqs	.L10000ec0
	subqw	#4,%sp
	movel	#1769237602,%sp@-
	movew	%d0,%sp@-
	_GetResource
	movel	%sp@+,%d0
	beqs	.L10000ec0
	moveal	%d0,%a0
	moveal	%a0@,%a0
	movel	%a0@(6),%d0
	btst	#1,%d0
	beqs	.L10000eb2
	btst	#7,%d0
	beqs	.L10000ec0

.L10000eb2:
	movew	#-20699,%d0
	movel	#1702392942,%d7
	bsrw	sub_10001974

.L10000ec0:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000eda),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000ee8

str_10000eda:
	.byte	0x0d
	.ascii	"ReInitScripts"

.L10000ee8:
	subqw	#2,%sp
	movel	#-2113863734,%sp@-
	_ScriptUtil
	addqw	#2,%sp
	moveq	#24,%d0

.L10000ef6:
	clrw	%sp@-
	dbf	%d0,.L10000ef6
	moveal	%sp,%a0
	lea	%pc@(str_10000f38),%a2
	movel	%a2,%a0@(18)
	clrb	%a0@(27)
	_Open
	bnes	.L10000f32
	moveal	%a0,%a2
	subqw	#4,%sp
	movew	#4,%sp@-
	movel	#-2080243704,%sp@-
	_ScriptUtil
	movel	%sp@+,%d0
	cmpiw	#1,%d0
	blew	.L10000f32
	moveal	%a2,%a0
	movew	#126,%a0@(26)
	_PBControlImmed

.L10000f32:
	lea	%sp@(50),%sp
	bras	.L10000f42

str_10000f38:
	.byte	0x08
	.ascii	".swmdrvr"
	.byte	0x00

.L10000f42:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000f5c),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000f76

str_10000f5c:
	.byte	0x19
	.ascii	"CheckForMinimumLogicalRAM"

.L10000f76:
	btst	#5,0xb20
	beqs	.L10000fc6
	subqw	#4,%sp
	movel	#1835823725,%sp@-
	movew	#1,%sp@-
	_GetIndResource
	movel	#25165824,%d0
	movel	%sp@+,%d1
	moveal	%d1,%a0
	beqs	.L10000f9c
	moveal	%a0@,%a1
	movel	%a1@,%d0

.L10000f9c:
	movel	%d0,%sp@-
	tstl	%a0
	beqs	.L10000fa6
	movel	%a0,%sp@-
	_ReleaseResource

.L10000fa6:
	movel	#1819435373,%d0
	_Gestalt
	tstw	%d0
	bnes	.L10000fb8
	moveal	%sp@+,%a1
	cmpal	%a0,%a1
	blss	.L10000fc6

.L10000fb8:
	movew	#-16506,%d5
	bsrw	sub_10005aa0
	bclr	#5,0xb20

.L10000fc6:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10000fe0),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10000ff4

str_10000fe0:
	.byte	0x12
	.ascii	"CheckForBadRestart"
	.byte	0x00

.L10000ff4:
	btst	#5,0xb20
	beqs	.L10001068
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	beqs	.L1000101a
	lea	0xaa0,%a0
	clrl	%a0@
	clrl	%a0@(4)
	clrl	%a0@(8)
	clrl	%a0@(12)
	bras	.L10001068

.L1000101a:
	clrw	%sp@-
	bsrl	sub_1000b80c
	tstw	%sp@+
	beqs	.L10001068
	clrw	%sp@-
	_SetResLoad
	subqw	#4,%sp
	movel	#1684431136,%sp@-
	movew	#-20886,%sp@-
	_GetResource
	movew	#1,%sp@-
	_SetResLoad
	movel	%sp@+,%d0
	beqs	.L10001068
	subqw	#4,%sp
	movel	%d0,%sp@-
	_GetResourceSizeOnDisk
	movel	%sp@+,%d5
	tstw	0xa60
	bnes	.L10001068
	addil	#98304,%d5
	moveq	#-1,%d4
	bsrw	sub_10001f4e
	bsrl	sub_1000b5b2
	clrw	%sp@-
	bsrw	sub_10005682

.L10001068:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001082),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100010a0

str_10001082:
	.byte	0x1d
	.ascii	"LoadINITResourcesInSystemFile"

.L100010a0:
	moveq	#-1,%d4
	bsrw	sub_10002028
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100010c0),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100010d4

str_100010c0:
	.byte	0x12
	.ascii	"GoInstallSerialDMA"
	.byte	0x00

.L100010d4:
	moveq	#-1,%d4
	movel	#32768,%d5
	bsrw	sub_10001f4e
	bsrw	sub_10006296
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100010fe),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001116

str_100010fe:
	.byte	0x16
	.ascii	"InstallOFDiskNameMaker"
	.byte	0x00

.L10001116:
	jsr	%pc@(sub_10008c08)
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001134),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001144

str_10001134:
	.byte	0x0f
	.ascii	"InstallPCSerial"

.L10001144:
	moveq	#-1,%d4
	movel	#16384,%d5
	bsrw	sub_10001f4e
	movel	#1702391924,%d5
	movew	#-20216,%d6
	clrw	%d3
	bsrw	sub_1000193e
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_1000117a),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001194

str_1000117a:
	.byte	0x19
	.ascii	"LoadExtensionsManagerINIT"

.L10001194:
	bsrw	sub_10001a16
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100011b2),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100011ca

str_100011b2:
	.byte	0x16
	.ascii	"MakeSystemHeapGrowable"
	.byte	0x00

.L100011ca:
	bsrw	sub_100023ac
	lea	%pc@(dword_1000250c),%a1
	lea	0x174,%a0
	moveq	#3,%d0

.L100011d8:
	cmpml	%a0@+,%a1@+
	dbne	%d0,.L100011d8
	beqw	.L1000128a
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	bnew	.L10001244
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001208),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L1000122e

str_10001208:
	.byte	0x24
	.ascii	"LoadNativeDriversFromExtensionFolder"
	.byte	0x00

.L1000122e:
	moveq	#-1,%d4
	movel	#262144,%d5
	bsrw	sub_10001f4e
	subqw	#2,%sp
	clrw	%sp@-
	jsr	%pc@(sub_10005f4c)
	addqw	#2,%sp

.L10001244:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_1000125e),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001284

str_1000125e:
	.byte	0x24
	.ascii	"LoadNativeExpertsFromExtensionFolder"
	.byte	0x00

.L10001284:
	movew	#29,%d0
	_ExpansionBusDispatch

.L1000128a:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100012a4),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100012c8

str_100012a4:
	.byte	0x23
	.ascii	"RestorePropertiesFromPreferenceFile"

.L100012c8:
	movew	#44,%d0
	_ExpansionBusDispatch
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100012e8),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100012f6

str_100012e8:
	.byte	0x0c
	.ascii	"USBDiskCheck"
	.byte	0x00

.L100012f6:
	jsr	%pc@(sub_100060e4)
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	bnew	.L1000133e
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001320),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L1000133a

str_10001320:
	.byte	0x18
	.ascii	"FireWirePerformLateInits"
	.byte	0x00

.L1000133a:
	jsr	%pc@(sub_100060a2)

.L1000133e:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001358),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001372

str_10001358:
	.byte	0x18
	.ascii	"FinishInitDisplayManager"
	.byte	0x00

.L10001372:
	bsrw	sub_1000632a
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	bnew	.L100013b0
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_1000139c),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100013ac

str_1000139c:
	.byte	0x0e
	.ascii	"CheckForBadRam"
	.byte	0x00

.L100013ac:
	bsrw	sub_1000294a

.L100013b0:
	moveq	#-1,%d4
	movel	#262144,%d5
	bsrw	sub_10001f4e
	btst	#4,0xb21
	bnew	.L100014b6
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100013e0),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100013f0

str_100013e0:
	.byte	0x0e
	.ascii	"LoadNetworking"
	.byte	0x00

.L100013f0:
	bsrl	sub_1000cc4e
	movel	#_fcc_ptch,%d5
	movew	#-20917,%d6
	bsrw	sub_1000193e
	clrw	%sp@-
	bsrw	sub_10005682
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnew	.L10001442
	movel	%a0,%d0
	btst	#0,%d0
	beqw	.L10001442
	btst	#1,%d0
	bnew	.L10001442
	moveal	0xb18,%a0
	movel	%a0,%d0
	bles	.L10001442
	movew	#17,%d0
	moveb	#2,%d1
	jsr	%a0@(2)
	bsrl	sub_10007634

.L10001442:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_1000145c),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L1000146e

str_1000145c:
	.byte	0x10
	.ascii	"PCINetworkLoader"
	.byte	0x00

.L1000146e:
	movel	#1886284908,%d5
	movew	#-20168,%d6
	clrw	%d3
	bsrw	sub_1000193e
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001498),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100014a6

str_10001498:
	.byte	0x0c
	.ascii	"IRTalkLoader"
	.byte	0x00

.L100014a6:
	movel	#2002874996,%d5
	movew	#2,%d6
	clrw	%d3
	bsrw	sub_1000193e

.L100014b6:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100014d0),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100014e6

str_100014d0:
	.byte	0x14
	.ascii	"LoadSystemComponents"
	.byte	0x00

.L100014e6:
	bsrw	sub_10002a08
	movel	#1935897449,%d0
	_Gestalt
	tstw	%d0
	bnes	.L10001524
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001510),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001520

str_10001510:
	.byte	0x0e
	.ascii	"DoSCSILateLoad"
	.byte	0x00

.L10001520:
	bsrw	sub_100061e6

.L10001524:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_1000153e),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001552

str_1000153e:
	.byte	0x12
	.ascii	"CheckForMinSysLate"
	.byte	0x00

.L10001552:
	bsrw	sub_10002a22
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001570),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001586

str_10001570:
	.byte	0x15
	.ascii	"CreateApplicationHeap"

.L10001586:
	bsrw	sub_10002396
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100015a4),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100015b0

str_100015a4:
	.byte	0x0a
	.ascii	"LOOP_SNOOP"
	.byte	0x00

.L100015b0:
	bsrw	sub_10002bae
	bsrw	sub_10003892
	clrb	%a5@(44)
	subql	#2,%sp
	moveq	#-1,%d0
	_StartupDispatch
	movew	%sp@+,%d0
	beqs	.L100015cc
	movew	#25,%d0
	_SysError

.L100015cc:
	subql	#2,%sp
	clrl	%sp@-
	moveq	#-6,%d0
	_StartupDispatch
	movew	%sp@+,%d0
	btst	#5,0xb20
	bnes	.L10001608
	moveq	#-1,%d4
	movel	#262144,%d5
	bsrw	sub_10001f4e
	btst	#4,0xb21
	bnew	.L100016de
	movel	#1702392942,%sp@-
	movel	#1229867348,%sp@-
	bsrw	sub_10001a3e
	braw	.L10001656

.L10001608:
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	bnes	.L1000163a
	movew	#-1,%sp@-
	_SetResLoad
	clrl	%sp@-
	movel	#1718907755,%sp@-
	movew	#1,%sp@-
	_Get1Resource
	moveal	%sp@+,%a0
	tstl	%a0
	beqs	.L1000163a
	tstl	%a0@
	beqs	.L1000163a
	moveal	%a0@,%a1
	clrw	%a1@(12)
	moveq	#14,%d0
	_SetHandleSize

.L1000163a:
	movel	#1702392942,%sp@-
	movel	#1953001063,%sp@-
	bsrw	sub_10001a3e
	movel	#1702126188,%sp@-
	clrl	%sp@-
	bsrw	sub_10001a3e

.L10001656:
	subql	#2,%sp
	clrl	%sp@-
	moveq	#-5,%d0
	_StartupDispatch
	movew	%sp@+,%d0
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	beqw	.L10001676
	pea	%a5@(74)
	bsrl	sub_100095a6

.L10001676:
	clrl	%sp@-
	movel	#1718907755,%sp@-
	movew	#1,%sp@-
	_Get1Resource
	moveal	%sp@+,%a0
	tstl	%a0
	beqs	.L1000168e
	movel	%a0,%sp@-
	_ReleaseResource

.L1000168e:
	btst	#5,0xb20
	beqs	.L100016de
	moveq	#-1,%d4
	movel	#1048576,%d5
	bsrw	sub_10001f4e
	btst	#4,0xb21
	bnes	.L100016de
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100016c4),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100016d4

str_100016c4:
	.byte	0x0f
	.ascii	"ComponentSearch"

.L100016d4:
	moveq	#34,%d0
	_ComponentDispatch
	bsrl	sub_10009790

.L100016de:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100016f8),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L10001716

str_100016f8:
	.byte	0x1d
	.ascii	"RemoveAlisToUninitializedPAPA"

.L10001716:
	bsrl	sub_10008af4
	movel	#1886876278,%d0
	_Gestalt
	tstw	%d0
	bnes	.L1000177c
	movel	%a0,%d0
	cmpil	#512,%d0
	blts	.L1000177c
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_1000174c),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L1000175c

str_1000174c:
	.byte	0x0f
	.ascii	"PMSecondaryInit"

.L1000175c:
	btst	#5,0xb20
	bnes	.L10001770
	movew	#1,%d0
	swap	%d0
	movew	#19,%d0
	_PowerMgrDispatch

.L10001770:
	movew	#1,%d0
	swap	%d0
	movew	#99,%d0
	_PowerDispatch

.L1000177c:
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10001796),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100017b8

str_10001796:
	.byte	0x20
	.string	"MakeObjectSupportLibResidentHack"

.L100017b8:
	bsrw	sub_10006232
	moveml	%a0-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_100017d6),%a1
	movel	%a1,%a0@(804)
	bsrw	sub_10003988
	moveml	%sp@+,%a0-%a1
	bras	.L100017ec

str_100017d6:
	.byte	0x15
	.ascii	"PatchComponentManager"

.L100017ec:
	moveq	#1,%d3
	movel	#1886677095,%d5
	movew	#-16500,%d6
	bsrl	sub_1000193e
	bsrw	sub_10003938
	bsrw	sub_1000566e
	btst	#4,0xb21
	beqs	.L1000181c
	bclr	#5,0xb20
	movew	#-16504,%d5
	bsrw	sub_10005aa0

.L1000181c:
	subqw	#2,%sp
	movel	#-2113863722,%sp@-
	_ScriptUtil
	addqw	#2,%sp
	bsrw	sub_10001fe6
	moveal	%a5@(12),%a0
	movew	#0x9c,%d0
	_SetOSTrapAddress
	_RsrcZoneInit
	clrl	%a5@(26)
	clrl	%a5@(22)
	moveq	#-1,%d4
	movel	#409600,%d5
	bsrw	sub_10001f4e
	moveal	0x2b6,%a1
	moveal	%a1@(772),%a1
	moveal	0x2a6,%a0
	movel	%a0@,%d1
	_FreeMemSys
	subl	%d0,%d1
	subl	%a1@,%d1
	subl	%a1@(4),%d1
	movel	%d1,%a1@(12)
	movel	0x1ef4,%d1
	subl	0x10c,%d1
	subl	%a1@(8),%d1
	movel	%d1,%a1@(16)
	moveal	0x2b6,%a0
	movew	#28523,%a0@(616)
	clrw	%sp@-
	clrl	%sp@-
	pea	%pc@(str_10002ba2)
	moveal	%sp,%a0
	_Launch

sub_1000188e:
	clrl	0x110
	moveal	0x10c,%sp
	clrl	0x964
	_InitApplZone
	subaw	#40,%sp
	moveal	%sp,%a5
	movel	%a5,0x904
	movel	%sp,0x908
	movel	%sp,0x110
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnes	.L10001902
	movel	%a0,%d0
	btst	#0,%d0
	beqs	.L10001902
	movel	#1835884912,%d0
	_Gestalt
	bnes	.L10001914
	movel	%a0,%d0
	btst	#0,%d0
	beqs	.L10001914
	movel	%sp,0x10c
	movel	0x322,%d0
	subl	%d0,0x10c
	movel	0x10c,%sp@-
	movel	0x2aa,%sp@-
	movel	#131080,%d0
	_BlueBoxDispatch
	addqw	#8,%sp
	moveal	0x68ffeff0,%a0
	moveal	%a0@(4),%a0
	subal	#32768,%a0
	bras	.L1000191a

.L10001902:
	moveal	0x2b6,%a0
	movel	%a0@(800),%d0
	beqs	.L10001914
	movel	%sp,0x10c
	jsr	%pc@(sub_10008d62)

.L10001914:
	moveal	%sp,%a0
	subal	0x322,%a0

.L1000191a:
	_SetApplLimit
	bral	sub_10008472

sub_10001922:
	subqw	#4,%sp
	movel	#1146306900,%sp@-
	movew	%d0,%sp@-
	_GetResource
	movel	%sp@+,%d0
	beqs	sub_1000193a
	moveal	%d0,%a0
	movel	%a0@,0x2ba
	rts

sub_1000193a:
	_SysError 99

sub_1000193e:
	moveq	#-1,%d4
	bsrl	sub_10001948
	rts

sub_10001948:
	movew	#-1,0xb9e
	subqw	#4,%sp
	movel	%d5,%sp@-
	movew	%d6,%sp@-
	_GetResource
	movel	%sp@+,%d1
	beqs	.L1000196e
	movel	%d1,%sp@-
	bsrw	sub_100020a2
	tstw	%d3
	beqs	.L1000196c
	tstw	%d0
	beqs	.L1000196c
	addqw	#4,%sp
	rts

.L1000196c:
	_ReleaseResource

.L1000196e:
	bsrw	sub_10001f38
	rts

sub_10001974:
	linkw	%fp,#-4
	movel	%d7,%fp@(-4)
	tstw	%a5@(56)
	beqs	.L10001998
	movew	%a5@(56),%d1
	clrw	%sp@-
	movew	%d1,%sp@-
	movel	%fp@(-4),%sp@-
	movew	%d0,%sp@-
	bsrw	sub_100019ba
	movew	%sp@+,%d1
	beqs	.L100019ae

.L10001998:
	movew	%a5@(56),%d1
	clrw	%sp@-
	movew	%d1,%sp@-
	movel	%fp@(-4),%sp@-
	movew	%d0,%sp@-
	bsrw	sub_100019ba
	movew	%sp@+,%d0
	bnes	.L100019b6

.L100019ae:
	movel	%fp@(-4),%d7
	bsrw	sub_10001e8e

.L100019b6:
	unlk	%fp
	rts

sub_100019ba:
	linkw	%fp,#0
	moveq	#0,%d7
	subqw	#4,%sp
	movew	%fp@(8),%sp@-
	_GetString
	movel	%sp@+,%d0
	beqs	.L100019ea
	moveal	%d0,%a0
	moveq	#0,%d0
	moveal	%a0@,%a0
	moveb	%a0@,%d0
	addqb	#1,%d0
	lea	%a5@(220),%a1
	_BlockMoveData
	movew	%fp@(14),%d1
	movel	%fp@(10),%d7
	bsrw	sub_100019fa
	bras	.L100019ee

.L100019ea:
	movew	#-192,%d0

.L100019ee:
	movew	%d0,%fp@(16)
	unlk	%fp
	moveal	%sp@+,%a0
	addql	#8,%sp
	jmp	%a0@

sub_100019fa:
	subqw	#2,%sp
	movew	%d1,%sp@-
	movel	%d7,%sp@-
	clrb	%sp@-
	pea	%a5@(476)
	pea	%a5@(478)
	moveq	#0,%d0
	_AliasDispatch
	movel	%a5@(478),%d7
	movew	%sp@+,%d0
	rts

sub_10001a16:
	btst	#5,0xb20
	beqs	.L10001a3a
	movel	#1702392942,%sp@-
	movel	#1229867348,%sp@-
	lea	%pc@(byte_10001a3c),%a0
	st	%a0@
	bsrw	sub_10001a3e
	lea	%pc@(byte_10001a3c),%a0
	sf	%a0@

.L10001a3a:
	rts

byte_10001a3c:
	.byte	0x00

byte_10001a3d:
	.byte	0x00

sub_10001a3e:
	linkw	%fp,#0
	moveml	%d2-%d7/%a2-%a4,%sp@-
	tstw	%a5@(56)
	beqs	.L10001a5c
	movel	%fp@(12),%d7
	moveal	%fp@(8),%a2
	movew	%a5@(56),%d1
	bsrw	sub_10001a7a

.L10001a5c:
	movel	%fp@(12),%d7
	moveal	%fp@(8),%a2
	movew	%a5@(50),%d1
	bsrw	sub_10001a7a
	moveml	%sp@+,%d2-%d7/%a2-%a4
	unlk	%fp
	moveal	%sp@,%a0
	addaw	#12,%sp
	jmp	%a0@

sub_10001a7a:
	movel	%a4,%sp@-
	cmpaw	#0,%a2
	beqs	.L10001aa4
	bsrw	sub_100019fa
	beqs	.L10001aa4
	cmpal	#1935897193,%a2
	bnew	.L10001dfc
	movew	%a5@(50),%d1
	movel	#1835098995,%d7
	bsrw	sub_100019fa
	beqs	.L10001aa4
	moveq	#0,%d7

.L10001aa4:
	lea	%a5@(220),%a0
	movel	%a0,%a5@(-382)
	movew	%a5@(476),%a5@(-378)
	clrw	%a5@(-374)
	moveq	#0,%d3

.L10001ab8:
	addqw	#1,%d3

.L10001aba:
	bsrw	sub_10001e02
	bnew	.L10001dfc
	movel	%a0@(32),%d0
	moveal	%a0@(36),%a4
	btst	#5,0xb20
	beqs	.L10001b42
	movel	%a0,%sp@-
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	moveal	%sp@+,%a0
	beqw	.L10001b0c
	moveml	%d0-%d1/%a0-%a1,%sp@-
	clrb	%sp@-
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	movew	%a5@(476),%sp@-
	movel	%a5@(478),%sp@-
	movel	%a5@(-382),%sp@-
	pea	%a5@(74)
	bsrl	sub_100095d4
	tstb	%sp@+
	moveml	%sp@+,%d0-%d1/%a0-%a1
	beqw	.L10001e52

.L10001b0c:
	movel	%a0,%sp@-
	lea	%pc@(byte_10001a3c),%a0
	tstb	%a0@
	moveal	%sp@+,%a0
	beqs	.L10001b38
	cmpal	#1702392901,%a4
	bnew	.L10001e52
	bsrw	sub_10001e8e
	bnew	.L10001dfc
	movel	%a0,%sp@-
	lea	%pc@(byte_10001a3d),%a0
	st	%a0@
	moveal	%sp@+,%a0
	braw	.L10001cb8

.L10001b38:
	movel	%a2,%d1
	beqs	.L10001b74
	cmpl	%d1,%d0
	braw	.L10001c82

.L10001b42:
	cmpal	#1633776996,%a4
	beqw	.L10001c86
	cmpal	#1667395438,%a4
	beqw	.L10001c86
	cmpal	#1953788789,%a4
	bnew	.L10001e52
	movel	%a0,%sp@-
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	moveal	%sp@+,%a0
	beqw	.L10001c86
	braw	.L10001e52

.L10001b74:
	cmpil	#1229867348,%d0
	bnes	.L10001bd0
	cmpal	#1802859113,%a4
	beqw	.L10001d7e
	cmpal	#1802252344,%a4
	beqw	.L10001dba
	cmpal	#1751672679,%a4
	beqw	.L10001cf8
	cmpal	#1836348978,%a4
	beqw	.L10001d0a
	cmpal	#1667330163,%a4
	beqw	.L10001d84
	cmpal	#1096042784,%a4
	beqw	.L10001d32
	cmpal	#1635148150,%a4
	beqw	.L10001d5c
	cmpal	#1702392901,%a4
	beqw	.L10001e52
	braw	.L10001c86

.L10001bd0:
	cmpil	#1885698164,%d0
	beqw	.L10001c86
	cmpil	#1667523958,%d0
	bnes	.L10001bf0
	cmpal	#1802252343,%a4
	bnew	.L10001c86
	braw	.L10001dba

.L10001bf0:
	cmpil	#1380205910,%d0
	bnes	.L10001c06
	cmpal	#1634103411,%a4
	bnew	.L10001c86
	braw	.L10001cf8

.L10001c06:
	cmpil	#1667395172,%d0
	beqs	.L10001c86
	cmpil	#1717726820,%d0
	beqs	.L10001c86
	cmpil	#1952607844,%d0
	beqs	.L10001c86
	cmpil	#1986162276,%d0
	beqs	.L10001c86
	cmpil	#1633969526,%d0
	beqs	.L10001c86
	cmpil	#1684301174,%d0
	beqs	.L10001c86
	cmpil	#1634758757,%d0
	bnes	.L10001c4a
	cmpal	#1802252338,%a4
	bnes	.L10001c86
	braw	.L10001dba

.L10001c4a:
	cmpil	#1852076662,%d0
	bnes	.L10001c6c
	movel	%a0,%sp@-
	moveal	0x2b6,%a0
	tstb	%a0@(827)
	moveal	%sp@+,%a0
	beqs	.L10001c86
	cmpal	#1970496100,%a4
	beqs	.L10001c86
	braw	.L10001e52

.L10001c6c:
	cmpil	#1717926004,%d0
	beqs	.L10001c86
	cmpil	#1095782467,%d0
	beqs	.L10001c86
	cmpil	#1179534418,%d0

.L10001c82:
	bnew	.L10001e52

.L10001c86:
	btst	#4,0xb21
	bnew	.L10001e52
	btst	#7,%a0@(41)
	bnew	.L10001e52
	btst	#6,%a0@(40)
	bnew	.L10001e52
	movel	%a4,%d0
	cmpil	#1835955314,%d0
	beqw	.L10001e52
	bsrw	sub_10001e8e
	bnew	.L10001e52

.L10001cb8:
	cmpiw	#1,%d6
	bnes	.L10001cd8
	tstw	%d1
	beqs	.L10001cc8
	cmpiw	#-192,%d1
	bnes	.L10001cd8

.L10001cc8:
	lea	%a5@(-400),%a0
	bset	#7,%a0@(41)
	movel	%d7,%a0@(48)
	_PBHSetFInfoSync

.L10001cd8:
	movel	%a0,%sp@-
	lea	%pc@(byte_10001a3c),%a0
	tstb	%a0@
	moveal	%sp@+,%a0
	beqw	.L10001e52
	movel	%a0,%sp@-
	lea	%pc@(byte_10001a3d),%a0
	tstb	%a0@
	moveal	%sp@+,%a0
	beqw	.L10001e52
	braw	.L10001dfc

.L10001cf8:
	movel	%a0,%sp@-
	moveal	0x2b6,%a0
	tstw	%a0@(488)
	moveal	%sp@+,%a0
	beqs	.L10001c86
	braw	.L10001e52

.L10001d0a:
	btst	#4,0xb21
	bnew	.L10001e52
	bsrw	sub_10001e8e
	bnew	.L10001e52
	moveml	%d1/%d6-%d7,%sp@-
	clrb	%sp@-
	bsrw	sub_100067b0
	tstb	%sp@+
	beqs	.L10001d2c
	_ADBReInit

.L10001d2c:
	moveml	%sp@+,%d1/%d6-%d7
	bras	.L10001cb8

.L10001d32:
	btst	#4,0xb21
	bnew	.L10001e52
	moveml	%d1/%d6-%d7,%sp@-
	clrb	%sp@-
	bsrw	sub_100068bc
	tstb	%sp@+
	moveml	%sp@+,%d1/%d6-%d7
	beqw	.L10001e52
	bsrw	sub_10001e8e
	bnew	.L10001e52
	braw	.L10001cb8

.L10001d5c:
	btst	#4,0xb21
	bnew	.L10001e52
	bsrw	sub_10001e8e
	bnew	.L10001e52
	moveml	%d1/%d6-%d7,%sp@-
	bsrw	sub_100063c6
	moveml	%sp@+,%d1/%d6-%d7
	braw	.L10001cb8

.L10001d7e:
	movew	#-20983,%d0
	bras	.L10001d86

.L10001d84:
	clrw	%d0

.L10001d86:
	moveml	%d1-%d3/%a0-%a3,%sp@-
	movew	%d0,%sp@-
	clrw	%sp@-
	lea	%a5@(-400),%a0
	movel	%d7,%a0@(48)
	movel	%a0,%sp@-
	jsr	%pc@(sub_1000663e)
	movew	%sp@+,%d0
	cmpiw	#0,%d0
	bnes	.L10001db0
	jsr	%pc@(sub_100065b4)
	moveml	%sp@+,%d1-%d3/%a0-%a3
	braw	.L10001e70

.L10001db0:
	addql	#2,%sp
	moveml	%sp@+,%d1-%d3/%a0-%a3
	braw	.L10001e52

.L10001dba:
	moveml	%d0-%d3/%a0-%a3,%sp@-
	clrw	%sp@-
	lea	%a5@(-400),%a0
	movel	%d7,%a0@(48)
	movel	%a0,%sp@-
	jsr	%pc@(sub_10006798)
	movew	%sp@+,%d0
	cmpiw	#0,%d0
	bnes	.L10001df4
	moveb	%a5@(44),%d0
	cmpib	#0,%d0
	bnes	.L10001dec
	jsr	%pc@(sub_10006780)
	moveb	#1,%d0
	moveb	%d0,%a5@(44)

.L10001dec:
	moveml	%sp@+,%d0-%d3/%a0-%a3
	braw	.L10001e70

.L10001df4:
	moveml	%sp@+,%d0-%d3/%a0-%a3
	braw	.L10001e52

.L10001dfc:
	moveml	%sp@+,%a4
	rts

sub_10001e02:
	lea	%a5@(-400),%a0
	cmpaw	#0,%a2
	beqs	.L10001e18
	movew	%d3,%a0@(28)
	movel	%d7,%a0@(48)
	_PBHGetFInfoSync
	bras	.L10001e50

.L10001e18:
	moveml	%d1-%d2/%a0-%a1,%sp@-
	subql	#2,%sp
	movel	%a0,%sp@-
	moveq	#-2,%d0
	_StartupDispatch
	movew	%sp@+,%d0
	bnes	.L10001e36
	movew	%d0,%sp@-
	subql	#2,%sp
	clrl	%sp@-
	moveq	#-4,%d0
	_StartupDispatch
	addql	#2,%sp
	movew	%sp@+,%d0

.L10001e36:
	moveml	%sp@+,%d1-%d2/%a0-%a1
	movel	%a0@(48),%d7
	movew	%a0@(22),%a5@(476)
	movel	%d7,%a5@(478)
	movew	%d3,%a0@(28)
	extl	%d0
	tstw	%d0

.L10001e50:
	rts

.L10001e52:
	cmpaw	#0,%a2
	bnew	.L10001ab8
	moveml	%d0-%d2/%a0-%a1,%sp@-
	subql	#2,%sp
	clrl	%sp@-
	moveq	#-3,%d0
	_StartupDispatch
	addql	#2,%sp
	moveml	%sp@+,%d0-%d2/%a0-%a1
	braw	.L10001ab8

.L10001e70:
	cmpaw	#0,%a2
	bnew	.L10001aba
	moveml	%d0-%d2/%a0-%a1,%sp@-
	subql	#2,%sp
	clrl	%sp@-
	moveq	#-3,%d0
	_StartupDispatch
	addql	#2,%sp
	moveml	%sp@+,%d0-%d2/%a0-%a1
	braw	.L10001aba

sub_10001e8e:
	movel	#262144,%d5
	bsrw	sub_10001f4e
	bsrw	sub_10001f08
	bnew	.L10001f02
	subqw	#4,%sp
	movel	#1937339258,%sp@-
	clrw	%sp@-
	_Get1Resource
	movel	%sp@+,%d0
	beqs	.L10001eba
	moveal	%d0,%a0
	moveal	%a0@,%a0
	movel	%a0@,%d5
	bsrw	sub_10001f4e

.L10001eba:
	btst	#4,0xb21
	bnes	.L10001f02
	cmpal	#-1938922443,%a4
	bnes	.L10001ed8
	clrl	%sp@-
	movew	%d4,%sp@-
	movew	#1,%sp@-
	moveq	#20,%d0
	_ComponentDispatch
	addqw	#4,%sp

.L10001ed8:
	btst	#2,0xb21
	bnes	.L10001ee4
	st	0x8f2

.L10001ee4:
	bsrw	sub_10002028
	bsrs	sub_10001f38
	moveq	#22,%d0
	_ComponentDispatch
	andib	#0xfe,0x10f
	clrw	%sp@-
	bsrw	sub_10005682
	tstw	0x8d0
	beqs	.L10001f02
	_ShowCursor

.L10001f02:
	movew	0xa60,%d0
	rts

sub_10001f08:
	movel	%a1,%sp@-
	subqw	#2,%sp
	movew	%a5@(476),%sp@-
	movel	%a5@(478),%sp@-
	pea	%a5@(220)
	clrb	%sp@-
	clrb	0xa5e
	_HOpenResFile
	st	0xa5e
	movew	%sp@+,%d4
	bmis	.L10001f30
	lea	%a5@(220),%a0
	movel	%a0,0x914

.L10001f30:
	moveal	%sp@+,%a1
	movew	0xa60,%d0
	rts

sub_10001f38:
	cmpiw	#-1,%d4
	beqs	.L10001f4c
	movel	#-1,0x914
	movew	%d4,%sp@-
	_CloseResFile
	moveq	#-1,%d4

.L10001f4c:
	rts

sub_10001f4e:
	bsrw	sub_1000238c
	beqs	.L10001fa0
	movew	%d4,%d1
	cmpil	#2147483647,%d5
	bnes	.L10001f64
	bsrw	sub_10001fa2
	bras	.L10001f6e

.L10001f64:
	movel	%d5,%d0
	_CompactMemSys
	subl	%d5,%d0
	bges	.L10001f90
	movel	%d5,%d2

.L10001f6e:
	addql	#1,%d2
	andiw	#-2,%d2
	tstw	%d4
	bmis	.L10001f7a
	bsrs	sub_10001f38

.L10001f7a:
	moveal	0x2a6,%a0

.L10001f7e:
	moveal	%a0@,%a0
	addal	%d2,%a0
	lea	%a0@(16384),%a0
	bsrw	sub_100023e2
	_SetAppBase
	movel	%d5,%d0
	_CompactMemSys

.L10001f90:
	tstw	%d1
	bmis	.L10001f9c
	tstw	%d4
	bpls	.L10001f9c
	bsrw	sub_10001f08

.L10001f9c:
	bsrw	sub_100024a4

.L10001fa0:
	rts

sub_10001fa2:
	moveml	%d0-%d1/%a0,%sp@-
	movel	%sp,%d1
	subl	0x322,%d1
	subil	#262144,%d1
	subil	#262144,%d1
	subl	%a5@(22),%d1
	moveal	0x2a6,%a0
	subl	%a0@,%d1
	tstl	0xb78
	bmis	.L10001fde
	moveq	#-3,%d0
	_MemoryDispatch
	subl	%a5@(26),%d0
	bmis	.L10001fde
	cmpl	%d1,%d0
	bges	.L10001fde
	subil	#262144,%d0
	movel	%d0,%d1

.L10001fde:
	movel	%d1,%d2
	moveml	%sp@+,%d0-%d1/%a0
	rts

sub_10001fe6:
	moveml	%d3,%sp@-
	subqw	#4,%sp
	movew	#18,%sp@-
	movel	#-2080243704,%sp@-
	_ScriptUtil
	movel	%sp@+,%d3
	subqw	#4,%sp
	movew	%d3,%sp@-
	swap	%d3
	movew	#28,%sp@-
	movel	#-2080112628,%sp@-
	_ScriptUtil
	addqw	#2,%sp
	movew	%sp@+,%d3
	subqw	#4,%sp
	moveal	%sp,%a0
	movel	%d3,%a0@
	clrw	%sp@-
	movel	%a0,%sp@-
	moveq	#14,%d0
	_TextServicesDispatch
	addqw	#6,%sp
	moveml	%sp@+,%d3
	rts

	nop

sub_10002028:
	moveq	#1,%d6

.L1000202a:
	movew	#-256,0xb9e
	bsrw	sub_100020be
	bnes	.L1000203c
	tstw	%d4
	bpls	.L10002098
	bras	.L1000208c

.L1000203c:
	subqw	#4,%sp
	movel	%d1,%sp@-
	_GetResourceSizeOnDisk
	movel	%sp@+,%d5
	addil	#262144,%d5
	bsrw	sub_10001f4e
	movew	#-1,0xb9e
	bsrl	sub_100020be
	beqs	.L1000208c
	tstw	%d4
	bpls	.L10002064
	movel	%d1,%sp@-
	_DetachResource

.L10002064:
	lea	%pc@(dword_1000209e),%a0
	movel	0x7c,%a0@
	bsrw	sub_10002490
	bsrs	sub_100020a2
	movel	%a5@(8),0x108
	moveal	0x7c,%a0
	cmpiw	#20083,%a0@
	bnew	.L1000208c
	lea	%pc@(dword_1000209e),%a0
	movel	%a0@,0x7c

.L1000208c:
	addqw	#1,%d6
	tstw	%d4
	bpls	.L1000202a
	cmpiw	#36,%d6
	bcss	.L1000202a

.L10002098:
	movew	0xa60,%d1
	rts

dword_1000209e:
	.short	0x0000
	.short	0x0000

sub_100020a2:
	moveal	%d1,%a0
	_HLock
	moveal	%a0@,%a1
	movel	%a1,%d0
	movel	%a5@,%sp@-
	moveml	%d3-%d7/%a2-%fp,%sp@-
	jsr	%a1@
	moveml	%sp@+,%d3-%d7/%a2-%fp
	movel	%sp@+,%a5@
	bsrw	sub_100024a4
	rts

sub_100020be:
	subqw	#4,%sp
	movel	#1229867348,%sp@-
	movew	%d6,%sp@-
	tstw	%d4
	bmis	.L100020d0
	_Get1IndResource
	bras	.L100020d2

.L100020d0:
	_GetResource

.L100020d2:
	movel	%sp@+,%d1
	rts

sub_100020d6:
	movew	#419,%d0
	bsrw	sub_10002366
	rts

sub_100020e0:
	btst	#5,0xb20
	beqw	.L100021da
	movel	#420,%d0
	movel	0x108,%sp@-
	movel	0x10c,%sp@-
	lea	%pc@(str_100054b6),%a0
	movel	%a0,0x914
	bsrw	sub_10002366
	movel	#-1,0x914
	tstl	0xb78
	bmiw	.L100021d8
	bsrl	sub_10002b8e
	moveal	%sp@+,%a1
	lea	%pc@(.L100005a6),%a0
	subal	%a0,%a1
	moveq	#0,%d0
	_MemoryDispatch
	movel	0x120,%d0
	beqs	.L10002194
	cmpil	#-1,%d0
	beqs	.L10002194
	movel	0x108,%d0
	movel	%d0,%d1
	lsrl	#2,%d1
	subl	%d1,%d0
	addil	#1048576,%d0
	cmpl	%sp@,%d0
	bhis	.L10002160
	moveal	%sp@(4),%a1
	moveal	%sp@,%a0
	subal	%a0,%a1
	subql	#1,%a1
	moveq	#0,%d0
	_MemoryDispatch
	tstw	%d0
	bnes	.L10002160
	movel	%sp@,0x10c
	bras	.L10002194

.L10002160:
	addql	#8,%sp
	movel	%d0,%sp@-
	moveb	0xbff,%d0
	cmpib	#0xff,%d0
	beqs	.L1000218e
	andib	#0xe0,%d0
	cmpib	#96,%d0
	bnes	.L1000218e
	movel	0x120,%d0
	tstl	%d0
	beqs	.L1000218e
	cmpil	#-1,%d0
	beqs	.L1000218e
	pea	%pc@(str_100021dc)
	_DebugStr

.L1000218e:
	movel	%sp@+,%d0
	_SysError 12

.L10002194:
	movel	#1986863136,%d0
	_Gestalt
	tstw	%d0
	bnes	.L100021d6
	movel	%a0,%d0
	btst	#4,%d0
	beqs	.L100021d6
	bsrl	sub_10002b8e
	moveal	0x10c,%a1
	subal	%sp@,%a1
	subaw	#4097,%a1
	moveal	%sp@+,%a0
	addaw	#4096,%a0
	moveml	%a0-%a1,%sp@-
	moveq	#12,%d0
	_MemoryDispatch
	moveml	%sp@,%a0-%a1
	moveq	#13,%d0
	_MemoryDispatch
	moveml	%sp@+,%a0-%a1
	moveq	#12,%d0
	_MemoryDispatch

.L100021d6:
	bsrs	sub_1000223a

.L100021d8:
	addql	#8,%sp

.L100021da:
	rts

str_100021dc:
	.byte	0x5b
	.ascii	"Stopping now because MacsBug was loaded before VM and we were about to make it non-resident"

	nop

sub_1000223a:
	moveq	#-6,%d0
	_MemoryDispatch
	movel	%d0,%d4
	moveal	0x68ffeff0,%a0
	movel	%a0@,%d3
	subl	%a0@(4),%d3
	addl	%d3,%d4
	movel	#1986359923,%d0
	_Gestalt
	cmpaw	#5,%a0
	bcss	.L1000226e
	subqw	#2,%sp
	movel	#1819435373,%sp@-
	movel	%d4,%sp@-
	movew	#1028,%d0
	_GestaltValueDispatch
	addqw	#2,%sp

.L1000226e:
	rts

sub_10002270:
	clrl	%a5@(46)
	tstl	0xb78
	bges	.L10002294
	movel	#44783,%d0
	lea	%pc@(str_100054c6),%a0
	movel	%a0,0x914
	bsrw	sub_10002366
	movel	#-1,0x914

.L10002294:
	rts

sub_10002296:
	btst	#3,0xb21
	beqs	.L1000230a
	bclr	#3,0xb21
	moveb	0xb21,%sp@-
	subql	#4,0x10c
	clrb	%sp@-
	lea	%a5@(666),%a1
	pea	%a1@
	bsrw	sub_1000725a
	tstb	%sp@+
	beqs	.L100022c6
	lea	%a5@(666),%a1
	bsrw	sub_10002314
	beqs	.L100022cc

.L100022c6:
	addql	#4,0x10c
	bras	.L100022f6

.L100022cc:
	lea	%pc@(str_100054e0),%a0
	movel	%a0,0x914
	jsr	%a2@
	moveq	#-10,%d0
	bsrw	sub_1000539a
	lea	%a5@(682),%a1
	bsrw	sub_10002314
	bnes	.L100022f6
	lea	%pc@(str_100054ea),%a0
	movel	%a0,0x914
	jsr	%a2@
	moveq	#-11,%d0
	bsrw	sub_1000539a

.L100022f6:
	moveb	0xb21,%d0
	moveb	%sp@+,0xb21
	btst	#3,%d0
	beqs	.L1000230a
	bset	#3,0xb21

.L1000230a:
	movel	#-1,0x914
	rts

sub_10002314:
	moveq	#64,%d1
	lslw	#3,%d1
	bras	.L1000231c

sub_1000231a:
	moveq	#0,%d1

.L1000231c:
	lea	%a5@(-400),%a0
	moveq	#-1,%d3
	lea	%a0@(18),%a2
	movel	%a1,%a2@+
	clrl	%a2@+
	clrb	%a2@+
	moveb	#1,%a2@+
	lea	%a5@(1648),%a1
	movel	%a1,%a2@
	_Open
	bnes	.L10002362
	_GetEOF
	bnes	.L10002360
	movel	%a2@+,%d2
	subl	%d1,%d2
	moveal	0x10c,%a2
	subal	%d2,%a2
	movel	%a2,%a2@
	lea	%a0@(32),%a1
	movel	%a2,%a1@+
	movel	%d2,%a1@+
	addqw	#4,%a1
	movew	#1,%a1@+
	movel	%d1,%a1@
	_Read
	bnes	.L10002360
	moveq	#0,%d3

.L10002360:
	_Close

.L10002362:
	tstb	%d3
	rts

sub_10002366:
	movel	#_fcc_ptch,%d1

sub_1000236c:
	subqw	#4,%sp
	movel	%d1,%sp@-
	movew	%d0,%sp@-
	_GetResource
	movel	%sp@+,%d1
	beqs	.L1000238a
	movel	%d1,%sp@-
	_DetachResource
	moveal	%d1,%a0
	moveal	%a0@,%a0
	moveml	%a3-%fp,%sp@-
	jsr	%a0@
	moveml	%sp@+,%a3-%fp

.L1000238a:
	rts

sub_1000238c:
	movel	0x2aa,%d0
	cmpl	0x2a6,%d0
	rts

sub_10002396:
	bsrs	sub_1000238c
	bnes	.L100023a0
	movel	0x10c,0x2aa

.L100023a0:
	_InitApplZone
	moveal	%sp,%a0
	subal	0x322,%a0
	_SetApplLimit
	rts

sub_100023ac:
	bsrs	sub_1000238c
	beqs	.L100023b2
	_InitApplZone

.L100023b2:
	moveal	0x2a6,%a0
	addal	#10485760,%a0
	bsrw	sub_100023e2
	_SetAppBase
	moveal	0x2a6,%a0
	movel	%a0,0x2aa
	movel	%a0,0x118
	movel	%a0@,0x114
	moveal	%sp,%a0
	subal	0x322,%a0
	subal	#262144,%a0
	_SetApplLimit
	rts

sub_100023e2:
	moveal	%sp,%a1
	subal	0x322,%a1
	subal	#262144,%a1
	subal	%a5@(22),%a1
	cmpal	%a0,%a1
	bhis	.L100023fe
	moveal	%a1,%a0
	bset	#4,0xb21

.L100023fe:
	movel	%d1,%sp@-
	tstl	0xb78
	bmis	.L10002430
	movel	%a0,%d1
	moveal	0x2a6,%a1
	subl	%a1@,%d1
	moveq	#-3,%d0
	_MemoryDispatch
	subl	%a5@(26),%d0
	bpls	.L10002422
	moveal	%a1@,%a0
	bset	#4,0xb21
	bras	.L10002430

.L10002422:
	cmpl	%d1,%d0
	bges	.L10002430
	moveal	%a1@,%a0
	addal	%d0,%a0
	bset	#4,0xb21

.L10002430:
	movel	%sp@+,%d1
	rts

sub_10002434:
	moveml	%d2-%d3,%sp@-
	movew	%d1,%d3
	addql	#3,%d0
	andib	#0xfc,%d0
	movel	%d0,%d2
	movel	0x10c,%d1
	subl	%d0,%d1
	bcss	.L10002474
	bsrl	sub_100024b4
	bnes	.L10002474
	andib	#0xfc,%d1
	moveal	%d1,%a0
	movel	%a0,0x10c
	btst	#9,%d3
	beqs	.L10002468
	movel	%d2,%d1
	moveal	%a0,%a1
	bsrs	sub_10002484

.L10002468:
	moveml	%sp@+,%d2-%d3
	moveq	#0,%d0
	movew	%d0,0x220
	rts

.L10002474:
	moveml	%sp@+,%d2-%d3

sub_10002478:
	subal	%a0,%a0
	movew	#-108,%d0
	movew	%d0,0x220
	rts

sub_10002484:
	lsrw	#2,%d1
	subqw	#1,%d1

.L10002488:
	clrl	%a1@+
	dbf	%d1,.L10002488
	rts

sub_10002490:
	bsrw	sub_100024d6
	moveal	%a5@(16),%a0
	subaw	#1024,%a0
	addal	%a0,%a0
	movel	%a0,0x108
	rts

sub_100024a4:
	movel	0x10c,%d1
	bsrs	sub_100024b4
	beqs	.L100024b2
	movew	#25,%d0
	_SysError

.L100024b2:
	rts

sub_100024b4:
	moveal	%a5@(16),%a0
	cmpl	%a0,%d1
	bcss	.L100024d4
	moveal	0x2a6,%a0
	moveal	%a0@,%a0
	subl	%a0,%d1
	bcss	.L100024d4
	cmpl	%a5@(70),%d1
	bgts	.L100024d2
	bset	#4,0xb21

.L100024d2:
	moveq	#0,%d1

.L100024d4:
	rts

sub_100024d6:
	moveal	0x2a6,%a0
	movel	%a0,%d0
	moveal	%a0@,%a0
	addil	#10485760,%d0
	cmpal	%d0,%a0
	bccs	.L100024ea
	moveal	%d0,%a0

.L100024ea:
	addal	%a5@(70),%a0
	cmpal	%a5@(16),%a0
	blss	.L100024f8
	movel	%a0,%a5@(16)

.L100024f8:
	rts

dword_100024fa:
	.short	0x0300,0x0000,0x0000
	.short	0x8001,0x0000,0x0000,0x0000,0x0000,0x0000

dword_1000250c:
	.short	0x0400,0x0000
	.short	0x0020,0x8001,0x0000,0x0000,0x0000,0x0000

sub_1000251c:
	moveml	%d0/%a0,%sp@-
	moveb	%pc@(word_10002560),%d0
	bnes	.L10002530
	moveml	%sp@+,%d0/%a0
	movel	%pc@(word_10002558),%sp@-
	rts

.L10002530:
	movel	0xa54,%sp@-
	movew	SysMap,%sp@-
	movel	%pc@(word_1000255c),0xa54
	movew	CurMap,SysMap
	moveal	%pc@(word_10002558),%a0
	jsr	%a0@
	movew	%sp@+,SysMap
	movel	%sp@+,0xa54
	moveml	%sp@+,%d0/%a0
	rts

word_10002558:
	.short	0x0000,0x0000

word_1000255c:
	.short	0x0000,0x0000

word_10002560:
	.short	0x0101

dword_10002562:
	.short	0x50FF,0x8001,0x0000

sub_10002568:
	moveml	%d0/%a0-%a1,%sp@-
	moveq	#74,%d0
	_NewPtrSysClear
	moveal	%a0,%a1
	lea	%pc@(sub_1000251c),%a0
	moveq	#74,%d0
	_BlockMove
	moveal	TopMapHndl,%a0
	movel	%a0,%a1@(64)
	moveal	%a0@,%a0
	andib	#1,%a0@(23)
	movew	#0xa996,%d0	/* RsrcZoneInit */
	_GetTrapAddress
	movel	%a0,%a1@(60)
	movew	#0xa996,%d0
	moveal	%a1,%a0
	_SetTrapAddress
	lea	%pc@(dword_10002562),%a0
	movel	%a1,%a0@
	moveml	%sp@+,%d0/%a0-%a1
	rts

sub_100025a8:
	_InitApplZone

.L100025aa:
	jsr	0x50ff8001
	_InitApplZone
	rts

sub_100025b4:
	movew	#-24489,%d0
	_GetOSTrapAddress
	lea	%pc@(.L100025aa),%a1
	movel	%a0,%a1@(2)
	moveq	#12,%d0
	_NewPtrSysClear
	moveal	%a0,%a1
	lea	%pc@(sub_100025a8),%a0
	moveq	#12,%d0
	_BlockMove
	moveal	%a1,%a0
	movew	#-24489,%d0
	_SetOSTrapAddress
	rts

sub_100025da:
	moveml	%d0-%d6/%a0-%a4,%sp@-
	subqw	#4,%sp
	movel	#1735750500,%sp@-
	movew	#1,%sp@-
	_GetResource
	movel	%sp@+,%d0
	moveal	%d0,%a4
	bnew	.L100025f8
	_SysError 98

.L100025f8:
	movel	%a4,%sp@-
	_DetachResource
	moveal	%a4,%a0
	_HLock
	moveal	%a4@,%a0
	addqw	#6,%a0
	movew	%a0@+,%d0
	moveq	#0,%d1
	moveml	%d0/%a0,%sp@-
	movel	#1835098984,%d0
	_Gestalt
	movel	%a0,%d1
	moveml	%sp@+,%d0/%a0

.L1000261a:
	cmpw	%a0@,%d1
	lea	%a0@(4),%a0
	dbeq	%d0,.L1000261a
	cmpiw	#-1,%d0
	bnew	.L10002644
	movel	0x2ba,%sp@-
	moveq	#0,%d0
	bsrw	sub_10001922
	movel	%d0,%d6
	_SysError 102
	movel	%sp@+,0x2ba
	movel	%d6,%sp@-
	_ReleaseResource

.L10002644:
	lea	%a0@(-2),%a0
	movew	%a0@,%d1
	moveal	%a4,%a0
	_HUnlock
	_DisposeHandle
	subaw	#24,%sp
	moveal	%sp,%a4
	subqw	#4,%sp
	movel	#1819239538,%sp@-
	movew	#-16385,%sp@-
	_GetResource
	movel	%sp@+,%d0
	bnew	.L1000266e
	moveq	#98,%d0
	_SysError

.L1000266e:
	movel	%d0,%a4@(20)
	moveal	%d0,%a0
	_HLock
	subqw	#4,%sp
	movel	#1735680620,%sp@-
	movew	%d1,%sp@-
	_GetResource
	movel	%sp@+,%d0
	bnew	.L1000268c
	moveq	#98,%d0
	_SysError

.L1000268c:
	movel	%d0,%a4@(16)
	moveal	%d0,%a0
	_HLock
	moveal	%a4@(16),%a2
	moveal	%a2@,%a2
	addqw	#6,%a2
	movew	%a2@+,%a4@(6)

.L100026a0:
	clrw	%a4@(10)
	movew	%a2@,%d0
	cmpw	%pc@(word_100026bc),%d0
	bhis	.L100026b8
	movew	%d0,%d1
	addw	%d1,%d1
	movew	%pc@(off_100026be,%d1:w),%d1
	jmp	%pc@(off_100026be,%d1:w)

.L100026b8:
	moveq	#99,%d0
	_SysError

word_100026bc:
	.short	0x0015

off_100026be:
	.short	.L1000274c-off_100026be
	.short	.L100027ec-off_100026be
	.short	.L10002800-off_100026be
	.short	.L10002746-off_100026be
	.short	.L10002816-off_100026be
	.short	.L1000291e-off_100026be
	.short	.L100026ea-off_100026be
	.short	.L1000291e-off_100026be
	.short	.L10002822-off_100026be
	.short	.L10002822-off_100026be
	.short	.L10002822-off_100026be
	.short	.L10002822-off_100026be
	.short	.L10002822-off_100026be
	.short	.L100028d4-off_100026be
	.short	.L10002846-off_100026be
	.short	.L100028a0-off_100026be
	.short	.L100028b6-off_100026be
	.short	.L10002846-off_100026be
	.short	.L100028bc-off_100026be
	.short	.L100028d8-off_100026be
	.short	.L100028e8-off_100026be
	.short	.L100028f0-off_100026be

.L100026ea:
	movew	%a2@(6),%d0
	movel	%a2,%sp@-
	subqw	#4,%sp
	movel	#_fcc_ptch,%sp@-
	movew	%d0,%sp@-
	_GetResource
	tstl	%sp@
	bnes	.L10002704
	addqw	#4,%sp
	bras	.L10002738

.L10002704:
	movel	%sp@,%sp@-
	_DetachResource
	moveal	%sp@,%a0
	moveal	%a0@,%a0
	movel	%a0,%sp@-
	jsr	%a0@
	movel	%a0,%d1
	moveal	%a0,%a1
	movel	%sp@+,%d2

.L10002716:
	movel	%a1@+,%d0
	beqs	.L1000272e
	addl	%d2,%d0
	moveal	%d0,%a0
	movew	%a1@+,%d0
	cmpiw	#-22528,%d0
	bcss	.L1000272a
	_SetToolTrapAddress
	bras	.L10002716

.L1000272a:
	_SetOSTrapAddress
	bras	.L10002716

.L1000272e:
	movel	%d1,%d0
	subl	%d2,%d0
	moveal	%sp@+,%a0
	_SetHandleSize
	bras	.L10002740

.L10002738:
	clrl	RestProc
	moveq	#99,%d0
	_SysError

.L10002740:
	moveal	%sp@+,%a2
	braw	.L1000291e

.L10002746:
	bset	#1,%a4@(10)

.L1000274c:
	moveal	%a2,%a1
	clrw	%a4@(8)
	movew	%a2@(6),%a4@(4)
	subqw	#1,%a4@(6)
	bmiw	.L1000277e

.L10002760:
	addql	#8,%a2
	tstw	%a2@
	bnes	.L1000277e

.L10002766:
	movew	%a2@(6),%d0
	cmpw	%a4@(4),%d0
	bnes	.L1000277e
	addqw	#1,%a4@(8)
	subqw	#1,%a4@(6)
	bmiw	.L1000277e
	bras	.L10002760

.L1000277e:
	moveq	#0,%d0
	movew	%a4@(8),%d0
	addql	#1,%d0
	lsll	#2,%d0
	addql	#4,%d0
	subal	%d0,%sp
	moveal	%sp,%a0
	movel	%d0,%sp@-
	moveal	%a0,%a3
	movew	#1,%a0@+
	movew	%a4@(8),%a0@+

.L1000279a:
	addql	#2,%a1
	movel	%a1@+,%a0@+
	addql	#2,%a1
	subqw	#1,%a4@(8)
	bpls	.L1000279a
	movew	%a4@(4),%d0
	beqs	.L100027cc
	subqw	#4,%sp
	movel	#1735418728,%sp@-
	movew	%a4@(4),%sp@-
	_GetResource
	movel	%sp@+,%d0
	bnes	.L100027cc
	btst	#1,%a4@(10)
	bnes	.L100027e4
	moveq	#98,%d0
	_SysError
	bras	.L100027e4

.L100027cc:
	lea	%pc@(str_100054f8),%a0
	movel	%a0,0x914
	movew	%a4@(4),%d6
	moveal	%a4@(20),%a0
	moveal	%a0@,%a0
	movew	%a4@(4),%d0
	jsr	%a0@

.L100027e4:
	movel	%sp@+,%d0
	addal	%d0,%sp
	braw	.L10002924

.L100027ec:
	movel	%a2@(2),%d1
	movew	%a2@(6),%d0
	movel	%a2,%sp@-
	bsrw	sub_1000236c
	moveal	%sp@+,%a2
	braw	.L1000291e

.L10002800:
	movel	%a2@(2),%d6
	movew	%a2@(6),%d5
	clrw	%d3
	movel	%a2,%sp@-
	bsrw	sub_1000193e
	moveal	%sp@+,%a2
	braw	.L1000291e

.L10002816:
	movel	%a2,%sp@-
	bsrw	sub_10002c24
	moveal	%sp@+,%a2
	braw	.L1000291e

.L10002822:
	movew	%d0,%d1
	movel	%a2,%sp@-
	clrw	%sp@-
	movew	%d1,%sp@-
	movew	%a2@(6),%sp@-
	movew	%a2@(2),%sp@-
	bsrl	sub_1000a740
	movew	%sp@+,%d0
	beqs	.L10002840
	moveq	#98,%d0
	_SysError

.L10002840:
	moveal	%sp@+,%a2
	braw	.L1000291e

.L10002846:
	subqw	#4,%sp
	movel	#1667658343,%sp@-
	movew	%a2@(6),%sp@-
	_GetResource
	movel	%sp@+,%d0
	beqw	.L1000291e
	subqw	#2,%sp
	movel	%d0,%sp@-
	_HomeResFile
	movew	%sp@+,%d0
	bmiw	.L1000291e
	bnes	.L1000286c
	movew	SysMap,%d0

.L1000286c:
	movew	CurMap,%sp@-
	movew	%d0,%sp@-
	movew	%d0,%sp@-
	_UseResFile
	movew	%sp@+,%d0
	movel	%a2,%sp@-
	subqw	#2,%sp
	movew	%a2@(6),%sp@-
	movew	%d0,%sp@-
	movew	%a2@(2),%sp@-
	movew	%a2@(4),%sp@-
	jsr	%pc@(sub_10009ca6)
	movew	%sp@+,%d0
	beqs	.L10002896
	moveq	#98,%d0
	_SysError

.L10002896:
	moveal	%sp@+,%a2
	movew	%sp@+,CurMap
	braw	.L1000291e

.L100028a0:
	movel	%a2,%sp@-
	subqw	#2,%sp
	movew	%a2@(6),%sp@-
	jsr	%pc@(sub_10009ca2)
	addqw	#2,%sp
	moveal	%sp@+,%a2
	bral	.L1000291e

.L100028b6:
	bral	.L1000291e

.L100028bc:
	movel	%a2,%sp@-
	subqw	#2,%sp
	jsr	%pc@(sub_100073b4)
	movew	%sp@+,%d0
	moveal	%sp@+,%a2
	beqw	.L1000291e
	moveq	#98,%d0
	_SysError
	braw	.L1000291e

.L100028d4:
	moveq	#12,%d0
	_SysError

.L100028d8:
	movel	%a2,%sp@-
	movew	%a2@(6),%sp@-
	jsr	%pc@(sub_10007424)
	moveal	%sp@+,%a2
	braw	.L1000291e

.L100028e8:
	jsr	%pc@(sub_10007598)
	braw	.L1000291e

.L100028f0:
	movel	%d0,%sp@-
	moveb	0xbff,%d0
	cmpib	#0xff,%d0
	beqs	.L10002918
	andib	#0xe0,%d0
	cmpib	#96,%d0
	bnes	.L10002918
	movel	0x120,%d0
	tstl	%d0
	beqs	.L10002918
	cmpil	#-1,%d0
	beqs	.L10002918
	_Debugger

.L10002918:
	movel	%sp@+,%d0
	braw	.L1000291e

.L1000291e:
	addql	#8,%a2
	subqw	#1,%a4@(6)

.L10002924:
	tstw	%a4@(6)
	bgew	.L100026a0
	moveal	%a4@(16),%a0
	_HUnlock
	movel	%a0,%sp@-
	_ReleaseResource
	moveal	%a4@(20),%a0
	_HUnlock
	movel	%a0,%sp@-
	_ReleaseResource
	lea	%sp@(24),%sp
	moveml	%sp@+,%d0-%d6/%a0-%a4
	rts

sub_1000294a:
	moveml	%d2-%d3,%sp@-
	moveq	#3,%d2
	moveq	#0,%d3
	btst	#6,0x2400
	beqs	.L100029b8
	jsr	%pc@(sub_100085a4)
	tstl	%d0
	beqs	.L1000296a
	movew	#-21210,%d5
	bsrw	sub_10005aa0

.L1000296a:
	clrl	%sp@-
	pea	%sp@
	jsr	%pc@(sub_1000851c)
	addql	#4,%sp
	movel	%sp@+,%d3
	tstw	%d0
	beqs	.L100029ce
	movel	#1852990823,%d0
	_Gestalt
	tstw	%d0
	bnes	.L100029ce
	cmpal	#16842752,%a0
	blts	.L100029ce
	bras	.L10002992

.L10002990:
	lsll	#8,%d3

.L10002992:
	movel	%d2,%sp@-
	subqw	#2,%sp
	moveb	#95,%sp@-
	pea	%pc@(str_100029fc)
	movel	#27,%sp@-
	subl	%d2,%sp@
	movew	#1328,%d0
	_ExpansionBusDispatch
	moveb	%sp@+,%d3
	movel	%sp@+,%d2
	dbf	%d2,.L10002990
	bras	.L100029ce

.L100029b6:
	lsll	#8,%d3

.L100029b8:
	subqw	#2,%sp
	movel	#4379,%sp@-
	subl	%d2,%sp@
	movew	#558,%d0
	_ExpansionBusDispatch
	moveb	%sp@+,%d3
	dbf	%d2,.L100029b6

.L100029ce:
	movel	%d3,%d0
	movel	%d0,%d1
	moveml	%sp@+,%d2-%d3
	andil	#2119,%d0
	beqs	.L100029fa
	movel	%d1,%d0
	andil	#2055,%d0
	beqs	.L100029f2
	movew	#-16503,%d5
	bsrw	sub_10005aa0
	bras	.L100029fa

.L100029f2:
	movew	#-16505,%d5
	bsrw	sub_10005aa0

.L100029fa:
	rts

str_100029fc:
	.ascii	"diagnostics"
	.byte	0x00

sub_10002a08:
	clrl	%sp@-
	clrw	%sp@-
	movew	#1,%sp@-
	moveq	#20,%d0
	_ComponentDispatch
	addqw	#4,%sp
	moveq	#22,%d0
	_ComponentDispatch
	rts

sub_10002a1c:
	movel	%d2,%sp@-
	moveq	#0,%d2
	bras	.L10002a26

sub_10002a22:
	movel	%d2,%sp@-
	moveq	#-1,%d2

.L10002a26:
	sf	0xa5e
	subqw	#4,%sp
	movel	#1836284275,%sp@-
	movew	#-16385,%sp@-
	_GetResource
	st	0xa5e
	tstl	%sp@
	beqs	.L10002a5e
	bset	#1,0xb21
	moveal	0x358,%a0
	cmpiw	#-5,%a0@(74)
	beqs	.L10002a5e
	tstl	%d2
	beqs	.L10002a5e
	movew	#-16761,%d5
	bsrw	sub_10005aa0

.L10002a5e:
	_ReleaseResource
	movel	%sp@+,%d2
	rts

sub_10002a64:
	clrw	%a5@(20)
	moveml	0x174,%d0-%d3
	bclr	#7,%d3
	bclr	#1,%d1
	eoril	#134250500,%d1
	bnew	.L10002aca
	bchg	#23,%d0
	orl	%d2,%d0
	orl	%d3,%d0
	bnew	.L10002aca
	lea	%pc@(word_10002ac2),%a1
	subqw	#4,%sp
	moveal	%sp,%a0
	movel	#262328,%d0
	_ReadXPRAM
	moveal	%a1,%a0
	movel	%a0@+,%d0
	_WriteXPRAM
	lea	0x1f8,%a0
	moveq	#-1,%d0
	moveb	%d0,%a0@
	_WriteParam
	_InitUtil
	moveal	%sp,%a0
	movel	#262328,%d0
	_WriteXPRAM
	addqw	#4,%sp
	movew	#-1,%a5@(20)
	bras	.L10002aca

word_10002ac2:
	.short	0x0004,0x000C,0x476F,0x6E65

.L10002aca:
	rts

sub_10002acc:
	movel	#1852990823,%d0
	_Gestalt
	tstw	%d0
	bnew	.L10002b84
	moveal	%a0,%a3
	movew	#-21527,%d0
	_GetToolTrapAddress
	movel	%a0,%d3
	movew	#159,%d0
	_GetToolTrapAddress
	cmpl	%a0,%d3
	bnew	.L10002b84
	subqw	#4,%sp
	movel	#1718580850,%sp@-
	movew	#-16400,%sp@-
	_GetResource
	movel	%sp@+,%d0
	cmpal	#16973824,%a3
	bges	.L10002b38
	tstl	%d0
	beqs	.L10002b5e
	clrw	%sp@-
	movew	#9,%sp@-
	movew	#-16400,%sp@-
	clrw	%sp@-
	bsrl	sub_1000a740
	movew	%sp@+,%d0
	bnes	.L10002b5e
	subqw	#2,%sp
	movel	#1852990823,%sp@-
	movel	#16973824,%sp@-
	movew	#1026,%d0
	_GestaltValueDispatch
	movew	%sp@+,%d0

.L10002b38:
	clrw	%sp@-
	movew	#11,%sp@-
	movew	#-16400,%sp@-
	clrw	%sp@-
	bsrl	sub_1000a740
	movew	%sp@+,%d0
	movew	#-21527,%d0
	_GetToolTrapAddress
	movel	%a0,%d3
	movew	#159,%d0
	_GetToolTrapAddress
	cmpl	%a0,%d3
	bnes	.L10002b84

.L10002b5e:
	lea	%pc@(sub_10002b86),%a2
	lea	%pc@(sub_10002b8e),%a3
	subal	%a2,%a3
	movel	%a3,%d0
	_NewPtrSys
	movel	%a0,%d0
	beqs	.L10002b84
	movel	%a3,%d0
	moveal	%a0,%a3
	moveal	%a0,%a1
	moveal	%a2,%a0
	_BlockMove
	moveal	%a3,%a0
	clrw	%d0
	movew	#-21527,%d0
	_SetToolTrapAddress

.L10002b84:
	rts

sub_10002b86:
	movel	#-2557,%d0
	rts

sub_10002b8e:
	movel	%sp@,%sp@-
	movel	%a0,%sp@-
	lea	%pc@(sub_10000000),%a0
	addal	%a5@(62),%a0
	movel	%a0,%sp@(8)
	moveal	%sp@+,%a0
	rts

str_10002ba2:
	.ascii	"MultiFinder"
	.byte	0x00

sub_10002bae:
	movel	#1835098984,%d0
	_Gestalt
	bnes	.L10002bf6
	cmpaw	#312,%a0
	beqs	.L10002bc4
	cmpaw	#314,%a0
	bnes	.L10002bf6

.L10002bc4:
	moveal	#0xfec00000,%a0
	movel	#0xa8000080,%a0@
	nop
	moveal	#0xfee00000,%a0
	movel	%a0@,%d0
	moveal	#-20971520,%a0
	movel	#-1476394880,%a0@
	moveal	#-18874368,%a0
	oril	#268435456,%d0
	movel	%d0,%a0@
	nop

.L10002bf6:
	rts

sub_10002bf8:
	movel	%d0,%sp@-
	movel	%d0,%sp@-
	movel	%sp@(24),%d0
	moveml	%d1-%fp,%sp@-
	clrl	%sp@-
	movel	%d0,%sp@-
	bsrl	sub_10008e90
	movel	%sp@+,%d0
	moveml	%sp@+,%d1-%fp
	bnes	.L10002c1c
	addqw	#4,%sp
	movel	%sp@+,%d0
	rte

.L10002c1c:
	movel	%d0,%sp@(4)
	movel	%sp@+,%d0
	rts

sub_10002c24:
	movel	%a0,%sp@-
	movew	CurMap,%sp@-
	_InitAllPacks
	_TEInit
	movel	%a1,%sp@-
	.short	0x2070,0x81e2,0x2010,0x006c	/* moveal @(2010)@(6c),%a0 */
	lea	%pc@(sub_10002cda),%a1
	cmpml	%a0@+,%a1@+
	bnes	.L10002c44
	cmpml	%a0@+,%a1@+
	beqs	.L10002c48

.L10002c44:
	jsr	%pc@(sub_1000a0b6)

.L10002c48:
	moveal	%sp@+,%a1
	jsr	%pc@(sub_1000a0b2)
	jsr	%pc@(sub_1000a0ae)
	jsr	%pc@(sub_1000a0aa)
	jsr	%pc@(sub_1000a0a6)
	moveal	0x2b6,%a0
	movel	#2147450879,%a0@(344)
	movel	#-2147450880,%a0@(348)
	jsr	%pc@(sub_1000a0a2)
	jsr	%pc@(sub_1000a09e)
	subqw	#2,%sp
	moveq	#-1,%d0
	_DisplayDispatch
	addqw	#2,%sp
	jsr	%pc@(sub_1000a09a)
	_InitFonts
	movew	0x17a,%d0
	cmpiw	#-30715,%d0
	beqs	.L10002c9e
	movel	#1935897449,%d0
	_Gestalt
	tstw	%d0
	beqs	.L10002c9e
	jsr	%pc@(sub_1000a096)

.L10002c9e:
	tstl	0xb78
	bmis	.L10002cc0
	movel	0x322,%d0
	addl	%d0,%d0
	addl	0x322,%d0
	lea	%pc@(.L1000087c),%a0
	subal	%d0,%a0
	moveal	%d0,%a1
	moveq	#1,%d0
	_MemoryDispatch
	moveq	#-1,%d0
	_MemoryDispatch
	bras	.L10002cd2

.L10002cc0:
	movel	%a5@(46),%d0
	beqs	.L10002cd2
	moveal	%d0,%a0
	moveml	%a3-%fp,%sp@-
	jsr	%a0@
	moveml	%sp@+,%a3-%fp

.L10002cd2:
	movew	%sp@+,CurMap
	moveal	%sp@+,%a0
	rts

sub_10002cda:
	CallVector 0x2010 47

sub_10002ce2:
	clrb	0x8f3
	moveml	%a0-%a2,%sp@-
	movew	CurMap,%sp@-
	bsrw	sub_10002d1e
	movel	#1651861368,%d0
	_Gestalt
	bnes	.L10002d04
	movel	%a0,%d0
	btst	#19,%d0
	bnes	.L10002d0a

.L10002d04:
	jsr	%pc@(sub_10002daa)
	bras	.L10002d0e

.L10002d0a:
	jsr	%pc@(sub_1000a0ba)

.L10002d0e:
	movel	%a5@,%sp@-
	_InitGraf
	_InitPalettes
	movew	%sp@+,CurMap
	moveml	%sp@+,%a0-%a2
	rts

sub_10002d1e:
	movel	0x8a4,%d0
	beqw	.L10002da8
	moveal	%d0,%a0
	moveal	%a0@,%a0
	movew	%a0@(20),%d0
	btst	#0,%d0
	bnes	.L10002da8
	cmpiw	#0,%a0@(4)
	bnes	.L10002da8
	linkw	%fp,#-330
	movel	%a5,%fp@(-4)
	lea	%fp@(-8),%a5
	pea	%fp@(-12)
	_InitGraf
	pea	%fp@(-330)
	_OpenPort
	moveal	%a5@,%a2
	lea	%a2@(-116),%a0
	movel	%a0,%sp@-
	tstb	0xb3e
	bnes	.L10002d6a
	pea	%a2@(-24)
	_FillRect
	bras	.L10002d9c

.L10002d6a:
	lea	%fp@(-222),%a1
	movel	%a1,%sp@-
	movel	%a1,%sp@-
	movel	%a0@+,%a1@+
	movel	%a0@,%a1@
	movel	#-131075,%sp@-
	_InsetRect
	movel	#196611,%sp@-
	_PenSize
	movel	#1441814,%sp@-
	_FrameRoundRect
	_PenNormal
	movel	#1048592,%sp@-
	pea	%a2@(-24)
	_FillRoundRect

.L10002d9c:
	pea	%fp@(-330)
	_ClosePort
	moveal	%fp@(-4),%a5
	unlk	%fp

.L10002da8:
	rts

sub_10002daa:
	braw	sub_10002e6c

sub_10002dae:
	linkw	%fp,#-180
	movel	%a2,%sp@-
	moveal	%a0@,%a2
	cmpiw	#0,%a2@(4)
	bnes	.L10002e04
	cmpaw	#-1,%a1
	beqs	.L10002dc8
	moveal	%a1,%a0
	bras	.L10002dd2

.L10002dc8:
	moveal	%a2@(22),%a0
	moveal	%a0@,%a0
	moveal	%a0@(42),%a0

.L10002dd2:
	_HLock
	movel	%a0,%sp@-
	moveal	%a0@,%a0
	lea	%fp@(-132),%a1
	clrw	%a1@(4)
	movew	%a0@(6),%a1@(6)
	lea	%a0@(8),%a0
	movel	%a0,%a1@
	lea	%fp@(-64),%a0
	movew	%a2@,%a0@(24)
	movew	#3,%a0@(26)
	movel	%a1,%a0@(28)
	_PBControlImmed
	moveal	%sp@+,%a0
	_HUnlock

.L10002e04:
	moveal	%sp@+,%a2
	unlk	%fp
	rts

sub_10002e0a:
	linkw	%fp,#-180
	moveml	%a2-%a3,%sp@-
	moveal	%a0@,%a2
	moveal	%a1,%a3
	lea	%fp@(-132),%a1
	movel	%a3,%a1@
	lea	%fp@(-64),%a0
	movew	%a2@,%a0@(24)
	movew	#4,%a0@(26)
	movel	%a1,%a0@(28)
	_PBControlImmed
	moveml	%sp@+,%a2-%a3
	unlk	%fp
	rts

sub_10002e38:
	linkw	%fp,#-180
	movel	%a2,%sp@-
	moveal	%a0@,%a2
	lea	%fp@(-148),%a1
	movel	#-2,%a1@
	lea	%fp@(-180),%a0
	movel	%a0,%a1@(12)
	lea	%fp@(-64),%a0
	movew	%a2@,%a0@(24)
	movew	#20,%a0@(26)
	movel	%a1,%a0@(28)
	_PBStatusImmed
	moveal	%sp@+,%a2
	unlk	%fp
	rts

sub_10002e6c:
	linkw	%fp,#-140
	moveml	%d0-%a4,%sp@-
	moveal	0x8a8,%a0
	moveaw	#-1,%a1
	bsrw	sub_10002dae
	braw	.L10002e84

.L10002e84:
	clrl	%sp@-
	movel	#1734438241,%sp@-
	clrw	%sp@-
	_rGetResource
	movel	%sp@,%sp@-
	_DetachResource
	moveal	%sp@+,%a0
	_HNoPurge
	moveal	%a0,%a2
	moveal	0x8a8,%a3

.L10002e9e:
	moveal	%a3,%a4
	moveal	%a4@,%a4
	movew	%a4@,%d0
	notw	%d0
	moveal	0x11c,%a0
	moveal	%a0@(%d0:w:4),%a0
	moveal	%a0@,%a0
	moveb	%a0@(40),%d0
	cmpib	#15,%d0
	bcss	.L10002ec4
	moveal	%a3,%a0
	bsrw	sub_10002e38
	bnes	.L10002f0a
	bras	.L10002f24

.L10002ec4:
	lea	%fp@(-120),%a0
	moveb	%d0,%a0@(49)
	clrw	%a0@(50)
	clrw	%a0@(51)
	moveb	#1,%a0@(48)
	movew	#3,%a0@(40)
	movew	#1,%a0@(42)
	movew	#1,%a0@(44)
	clrw	%a0@(52)
	moveq	#21,%d0
	_SlotManager
	bnes	.L10002f24
	cmpiw	#1,%a0@(46)
	beqs	.L10002f24
	moveb	#64,%a0@(50)
	moveq	#6,%d0
	_SlotManager
	beqs	.L10002f24

.L10002f0a:
	moveal	%a2,%a0
	_HLock
	moveal	%a0@,%a1
	moveal	%a3,%a0
	bsrw	sub_10002e0a
	moveal	%a2,%a0
	_HUnlock
	moveal	%a3,%a0
	moveaw	#-1,%a1
	bsrw	sub_10002dae

.L10002f24:
	movel	%a4@(30),%d0
	moveal	%d0,%a3
	bnew	.L10002e9e
	moveal	%a2,%a0
	_DisposeHandle
	braw	.L10002fce

.L10002f36:
	subqw	#2,%sp
	movel	%sp@(2),%sp@
	movew	%sr,%sp@(4)
	movel	%d0,%sp@-
	moveq	#7,%d0
	andb	%sp@(8),%d0
	subqb	#2,%d0
	bges	.L10002f54
	oriw	#512,%sr
	andiw	#-1281,%sr

.L10002f54:
	movel	%sp@+,%d0
	rts

sub_10002f58:
	cmpw	%a1@(%d0:w),%d6
	bnes	.L10002f72
	cmpl	%a1@(2,%d0:w),%d7
	bnes	.L10002f72
	movew	%fp@,%a1@(%d0:w)
	lea	%pc@(.L10002f36),%a5
	movel	%a5,%a1@(2,%d0:w)
	rts

.L10002f72:
	addqw	#4,%sp
	braw	.L100030bc

sub_10002f78:
	movel	%a0,%sp@-
	lea	%pc@(.L10002fba),%a0
	movel	%a0@+,%d1
	cmpl	%a1@(2490),%d1
	bnes	.L10002fac
	movel	%a0@+,%d1
	cmpl	%a1@(2494),%d1
	bnes	.L10002fac
	movew	%a0@+,%d1
	cmpw	%a1@(2498),%d1
	bnes	.L10002fac
	movew	%fp@,%a1@(2490)
	lea	%pc@(.L10002f36),%a5
	movel	%a5,%a1@(2492)
	movel	%fp@(6),%a1@(2496)
	moveal	%sp@+,%a0
	rts

.L10002fac:
	moveal	%sp@+,%a0
	addqw	#4,%sp
	braw	.L100030bc

.L10002fb4:
	movew	%sr,%sp@-
	oriw	#1792,%sr

.L10002fba:
	movew	%sr,%d0
	movew	%d0,%sp@-
	oriw	#1792,%d0
	movew	%d0,%sr

.L10002fc4:
	jsr	0x7fffffff
	nop
	nop

.L10002fce:
	moveml	%a5-%fp,%sp@-
	moveal	0x11c,%a2
	subaw	#56,%sp
	lea	%pc@(.L10002fb4),%a0
	movew	%a0@,%d6
	movel	%a0@(2),%d7
	moveq	#0,%d5
	lea	%pc@(.L10002fc4),%fp
	moveal	0x8a8,%a3
	moveal	%a3@,%a3

.L10002ff0:
	movew	%a3@,%d0
	notw	%d0
	moveal	%a2@(%d0:w:4),%a1
	moveal	%a1@,%a1
	moveal	%a1@,%a4
	movew	%a1@(4),%d0
	btst	#6,%d0
	beqs	.L10003008
	moveal	%a4@,%a4

.L10003008:
	moveal	%sp,%a0
	moveb	%a1@(40),%a0@(49)
	moveb	%a1@(41),%a0@(50)
	moveb	%a1@(50),%a0@(51)
	moveq	#22,%d0
	_SlotManager
	bnew	.L100030ca
	moveb	#7,%a0@(50)
	moveq	#1,%d0
	_SlotManager
	bnes	.L1000303e
	movel	%a0@,%d0
	btst	#2,%d0
	beqs	.L1000303e
	bset	#8,%a3@(20)

.L1000303e:
	moveal	%a4,%a1
	movel	%a1@(20),%d0
	cmpil	#1148344150,%d0
	beqs	.L1000306c
	cmpil	#1148342358,%d0
	beqs	.L1000306c
	cmpil	#1147761520,%d0
	bnew	.L100030bc
	movel	%a1@(38),%d0
	cmpil	#1700743250,%d0
	beqs	.L10003096
	bras	.L100030bc

.L1000306c:
	movew	#730,%d0
	bsrw	sub_10002f58
	movew	#904,%d0
	bsrw	sub_10002f58
	movew	#1240,%d0
	bsrw	sub_10002f58
	movew	#1584,%d0
	bsrw	sub_10002f58
	movew	#2252,%d0
	bsrw	sub_10002f58
	bras	.L100030ba

.L10003096:
	movew	#1114,%d0
	bsrw	sub_10002f58
	movew	#1418,%d0
	bsrw	sub_10002f58
	movew	#1778,%d0
	bsrw	sub_10002f58
	bsrw	sub_10002f78
	movew	#2590,%d0
	bsrw	sub_10002f58

.L100030ba:
	addqw	#1,%d5

.L100030bc:
	movel	%a3@(30),%d0
	beqs	.L100030ca
	moveal	%d0,%a3
	moveal	%a3@,%a3
	braw	.L10002ff0

.L100030ca:
	lea	%sp@(56),%sp
	moveml	%sp@+,%a5-%fp
	moveml	%sp@+,%d0-%a4
	unlk	%fp
	rts

sub_100030da:
	subql	#6,%sp
	pea	%sp@(2)
	movew	#515,%d0
	_DialogDispatch
	tstw	%sp@+
	bnes	.L100030ee
	moveal	%sp@+,%a0
	jmp	%a0@

.L100030ee:
	moveal	%sp@+,%a0
	addaw	#12,%sp
	clrw	%sp@
	jmp	%a0@

sub_100030f8:
	moveal	%sp@+,%a1
	moveal	%sp@+,%a0
	_GetPtrSize
	movel	%d0,%sp@
	bpls	.L10003104
	clrl	%sp@

.L10003104:
	jmp	%a1@

sub_10003106:
	moveal	%sp@+,%a1
	moveal	%sp@+,%a0
	_GetHandleSize
	movel	%d0,%sp@
	bpls	.L10003112
	clrl	%sp@

.L10003112:
	jmp	%a1@

sub_10003114:
	moveq	#24,%d0

.L10003116:
	clrw	%sp@-
	dbf	%d0,.L10003116
	movel	%sp@(58),%sp@(18)
	moveal	%sp,%a0
	_Open
	moveal	%sp@(54),%a0
	movew	%sp@(24),%a0@
	moveal	%sp@(50),%a0
	lea	%sp@(62),%sp
	movew	%d0,%sp@
	jmp	%a0@

sub_1000313a:
	moveal	%sp@+,%a1
	moveb	%sp@+,%d1
	movew	%sp@+,%d0
	tstb	%d1
	beqs	.L10003148
	_GetToolTrapAddress
	bras	.L1000314a

.L10003148:
	_GetOSTrapAddress

.L1000314a:
	movel	%a0,%sp@
	jmp	%a1@

sub_1000314e:
	moveal	%sp@+,%a1
	moveb	%sp@+,%d1
	movew	%sp@+,%d0
	moveal	%sp@+,%a0
	tstb	%d1
	beqs	.L1000315e
	_SetToolTrapAddress
	bras	.L10003160

.L1000315e:
	_SetOSTrapAddress

.L10003160:
	jmp	%a1@

sub_10003162:
	moveal	%sp@(12),%a0
	moveal	%sp@(8),%a1
	moveq	#0,%d0
	moveb	%a0@+,%d0
	swap	%d0
	moveb	%a1@+,%d0
	tstb	%sp@(4)
	beqs	.L10003186
	tstb	%sp@(6)
	beqs	.L10003182
	_CaseSensitiveEqualString
	bras	.L10003192

.L10003182:
	_CmpString
	bras	.L10003192

.L10003186:
	tstb	%sp@(6)
	beqs	.L10003190
	_CaseAndMarkSensitiveEqualString
	bras	.L10003192

.L10003190:
	_MarkSensitiveEqualString

.L10003192:
	eorib	#1,%d0
	moveb	%d0,%sp@(16)
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

sub_100031a2:
	linkw	%fp,#-50
	moveal	%sp,%a0
	movew	%fp@(8),%a0@(24)
	_Close
	movew	%d0,%fp@(10)
	unlk	%fp
	moveal	%sp@+,%a0
	addql	#2,%sp
	jmp	%a0@

sub_100031bc:
	sf	%d1
	bras	.L100031c2

sub_100031c0:
	st	%d1

.L100031c2:
	linkw	%fp,#-50
	moveal	%sp,%a0
	movel	%fp@(8),%a0@(32)
	movew	%fp@(16),%a0@(24)
	moveal	%fp@(12),%a1
	movel	%a1@,%a0@(36)
	clrw	%a0@(44)
	clrl	%a0@(46)
	tstb	%d1
	bnes	.L100031ec
	_Read
	bras	.L100031ee

.L100031ec:
	_Write

.L100031ee:
	movew	%d0,%fp@(18)
	moveal	%fp@(12),%a1
	movel	%a0@(40),%a1@
	unlk	%fp
	moveal	%sp@+,%a1
	lea	%sp@(10),%sp
	jmp	%a1@

sub_10003204:
	linkw	%fp,#-50
	moveal	%sp,%a0
	movew	%fp@(12),%a0@(24)
	movel	%fp@(8),%a0@(28)
	_SetEOF
	movew	%d0,%fp@(14)
	unlk	%fp
	moveal	%sp@+,%a1
	addql	#6,%sp
	jmp	%a1@

sub_10003224:
	linkw	%fp,#-50
	moveal	%sp,%a0
	movew	%fp@(14),%a0@(24)
	movew	%fp@(12),%a0@(44)
	movel	%fp@(8),%a0@(46)
	_SetFPos
	movew	%d0,%fp@(16)
	unlk	%fp
	moveal	%sp@+,%a1
	addql	#8,%sp
	jmp	%a1@

sub_1000324a:
	linkw	%fp,#0
	moveal	%fp@(16),%a0
	moveal	%fp@(12),%a1
	moveq	#0,%d0
	moveb	%a0@+,%d0
	swap	%d0
	moveb	%a1@+,%d0
	tstb	%fp@(8)
	beqs	.L10003272
	tstb	%fp@(10)
	beqs	.L1000326e
	_CaseSensitiveRelString
	bras	.L1000327e

.L1000326e:
	_RelString
	bras	.L1000327e

.L10003272:
	tstb	%fp@(10)
	beqs	.L1000327c
	_CaseAndMarkSensitiveRelString
	bras	.L1000327e

.L1000327c:
	_MarkSensitiveRelString

.L1000327e:
	movew	%d0,%fp@(20)
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

sub_1000328c:
	moveal	%sp@(4),%a0
	movel	%sp@(8),%d0
	clrw	%sp@-
	_Pack7
	moveal	%sp@+,%a0
	addqw	#8,%sp
	jmp	%a0@

sub_1000329e:
	moveal	%sp@(4),%a0
	moveal	%a0@,%a0
	_HandToHand
	moveal	%sp@(4),%a1
	movel	%a0,%a1@
	movew	%d0,%sp@(8)
	movel	%sp@+,%sp@
	rts

sub_100032b4:
	linkw	%fp,#0
	subqw	#4,%sp
	movel	#1398034979,%sp@-
	movew	%fp@(10),%sp@-
	_GetResource
	moveal	%fp@(12),%a1
	clrb	%a1@
	movel	%sp@+,%d0
	beqs	.L100032f2
	moveal	%d0,%a0
	moveal	%a0@,%a0
	movew	%a0@+,%d0
	movew	%fp@(8),%d1
	beqs	.L100032f2
	cmpw	%d0,%d1
	bhis	.L100032f2
	moveq	#0,%d0

.L100032e2:
	subqw	#1,%d1
	beqs	.L100032ec
	moveb	%a0@+,%d0
	addal	%d0,%a0
	bras	.L100032e2

.L100032ec:
	moveb	%a0@,%d0
	addqw	#1,%d0
	_BlockMove

.L100032f2:
	unlk	%fp
	moveal	%sp@+,%a0
	addql	#8,%sp
	jmp	%a0@

sub_100032fa:
	linkw	%fp,#-124
	movew	%fp@(16),%fp@(-102)
	movel	%fp@(12),%fp@(-76)
	movel	%fp@(8),%fp@(-106)
	clrb	%fp@(-98)
	lea	%fp@(-124),%a0
	_PBHDeleteSync
	movew	%d0,%fp@(18)
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(10),%sp
	jmp	%a0@

sub_10003328:
	linkw	%fp,#-124
	movew	%fp@(20),%fp@(-102)
	movel	%fp@(16),%fp@(-76)
	movel	%fp@(12),%fp@(-106)
	clrb	%fp@(-98)
	movel	%fp@(8),%fp@(-96)
	lea	%fp@(-124),%a0
	_PBHRenameSync
	movew	%d0,%fp@(22)
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(14),%sp
	jmp	%a0@

sub_1000335c:
	linkw	%fp,#-52
	movel	%fp@(16),%fp@(-34)
	movew	%fp@(24),%fp@(-30)
	movel	%fp@(20),%fp@(-4)
	movel	%fp@(12),%fp@(-16)
	movel	%fp@(8),%fp@(-24)
	lea	%fp@(-52),%a0
	_PBCatMoveSync
	movew	%d0,%fp@(26)
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(18),%sp
	jmp	%a0@

sub_10003394:
	movel	%sp@+,%d0
	moveal	%sp@+,%a1
	moveal	%sp@+,%a0
	movel	%d0,%sp@-
	moveq	#0,%d0
	moveq	#0,%d1
	moveb	%a0@+,%d0
	moveb	%a1@+,%d1
	subw	%d1,%d0
	bges	.L100033aa
	addw	%d0,%d1

.L100033aa:
	cmpb	%d0,%d0
	bras	.L100033b0

.L100033ae:
	cmpmb	%a1@+,%a0@+

.L100033b0:
	dbne	%d1,.L100033ae
	beqs	.L100033c0
	blts	.L100033bc
	moveq	#1,%d0
	bras	.L100033c0

.L100033bc:
	moveq	#1,%d0
	negw	%d0

.L100033c0:
	movew	%d0,%sp@(4)
	rts

	.byte	0x88
	.ascii	"PLStrCmp"
	.byte	0x00
	.short	0x0000

sub_100033d2:
	movel	%sp@+,%d0
	moveal	%sp@+,%a1
	moveal	%sp@+,%a0
	movel	%a0,%sp@
	movel	%d0,%sp@-
	moveq	#0,%d0
	moveb	%a1@+,%d0
	moveb	%d0,%a0@+
	bras	.L100033e6

.L100033e4:
	moveb	%a1@+,%a0@+

.L100033e6:
	dbf	%d0,.L100033e4
	rts

	.byte	0x88
	.ascii	"PLStrCpy"
	.byte	0x00
	.short	0x0000

sub_100033f8:
	moveml	%sp@(4),%a0-%a1
	moveq	#0,%d0
	cmpal	%a0,%a1
	beqs	.L1000340e

.L10003404:
	moveb	%a0@+,%d0
	cmpb	%a1@+,%d0
	bnes	.L10003412
	tstb	%d0
	bnes	.L10003404

.L1000340e:
	moveq	#0,%d0
	rts

.L10003412:
	moveq	#0,%d1
	moveb	%a1@-,%d1
	subl	%d1,%d0
	rts

	.byte	0x86
	.ascii	"strcmp"
	.byte	0x00
	.short	0x0000

sub_10003424:
	moveml	%d2-%d3,%sp@-
	moveml	%sp@(12),%d0-%d1

.L1000342e:
	moveal	%d0,%a0
	moveal	%d1,%a1

.L10003432:
	moveb	%a1@+,%d3
	beqs	.L10003444
	moveb	%a0@+,%d2
	beqs	.L10003442
	cmpb	%d2,%d3
	beqs	.L10003432
	addql	#1,%d0
	bras	.L1000342e

.L10003442:
	moveq	#0,%d0

.L10003444:
	moveml	%sp@+,%d2-%d3
	rts

	.byte	0x86
	.ascii	"strstr"
	.byte	0x00
	.short	0x0000

sub_10003454:
	linkw	%fp,#0
	moveal	%fp@(8),%a1
	movew	#1,%a1@
	clrw	%a1@(2)
	moveq	#0,%d0
	movel	%d0,%a1@(4)
	movel	%d0,%a1@(8)
	movel	%d0,%a1@(12)
	unlk	%fp
	rts

sub_10003476:
	linkw	%fp,#-50
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(12),%a4
	movel	%a4,%sp@-
	jsr	%pc@(sub_10003454)
	moveq	#0,%d0
	movel	%d0,%fp@(-32)
	moveal	%fp@(8),%a0
	moveal	%a0@,%a0
	movew	%a0@,%fp@(-26)
	movew	#12,%fp@(-24)
	movel	%a4,%fp@(-22)
	lea	%fp@(-50),%a0
	_Status
	movew	%d0,%d7
	moveml	%fp@(-58),%d7/%a4
	unlk	%fp
	rts

sub_100034b4:
	linkw	%fp,#-50
	moveml	%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	moveal	%fp@(12),%a4
	moveq	#-50,%d7
	movel	%a3,%d0
	beqs	.L1000350a
	movel	%a4,%d0
	beqs	.L1000350a
	clrw	%a4@(4)
	clrw	%a4@(6)
	moveq	#0,%d0
	movel	%d0,%a4@(8)
	movel	%d0,%a4@(12)
	movel	%d0,%a4@(16)
	movel	%d0,%fp@(-32)
	moveal	%a3@,%a0
	movew	%a0@,%fp@(-26)
	movew	#28,%fp@(-24)
	movel	%a4,%fp@(-22)
	lea	%fp@(-50),%a0
	_Status
	movew	%d0,%d7
	bnes	.L1000350a
	moveq	#-1,%d0
	cmpl	%a4@,%d0
	bnes	.L1000350a
	moveq	#-18,%d7

.L1000350a:
	movew	%d7,%d0
	moveml	%fp@(-62),%d7/%a3-%a4
	unlk	%fp
	rts

sub_10003516:
	linkw	%fp,#-20
	moveml	%d6-%d7/%a2-%a4,%sp@-
	moveal	%fp@(16),%a2
	moveal	%fp@(12),%a3
	moveal	%fp@(8),%a4
	clrb	%d7
	moveq	#-1,%d0
	movel	%d0,%fp@(-20)
	pea	%fp@(-20)
	movel	%a4,%sp@-
	jsr	%pc@(sub_100034b4)
	tstw	%d0
	addqw	#8,%sp
	bnes	.L100035b2
	movel	%fp@(-20),%d6
	bras	.L100035aa

.L10003548:
	movel	%d6,%d0
	subql	#1,%d6
	movel	%d0,%fp@(-20)
	pea	%fp@(-20)
	movel	%a4,%sp@-
	jsr	%pc@(sub_100034b4)
	tstw	%d0
	addqw	#8,%sp
	bnes	.L100035aa
	moveq	#0,%d0
	movew	%fp@(-16),%d0
	moveq	#2,%d1
	cmpl	%d0,%d1
	beqs	.L10003584
	moveq	#0,%d0
	movew	%fp@(-16),%d0
	moveq	#14,%d1
	cmpl	%d0,%d1
	beqs	.L10003584
	moveq	#0,%d0
	movew	%fp@(-16),%d0
	moveq	#20,%d1
	cmpl	%d0,%d1
	bnes	.L100035aa

.L10003584:
	moveq	#1,%d7
	moveq	#0,%d0
	moveb	%fp@(-14),%d0
	movew	%d0,%a3@
	moveq	#0,%d0
	moveb	%fp@(-13),%d0
	movew	%d0,%a2@
	movel	#512,%d0
	andl	%fp@(-12),%d0
	bnes	.L100035aa
	moveal	%fp@(20),%a0
	moveb	#1,%a0@

.L100035aa:
	tstl	%d6
	blss	.L100035b2
	tstb	%d7
	beqs	.L10003548

.L100035b2:
	moveb	%d7,%d0
	moveml	%fp@(-40),%d6-%d7/%a2-%a4
	unlk	%fp
	rts

sub_100035be:
	linkw	%fp,#-78
	moveml	%d7/%a3-%a4,%sp@-
	moveq	#0,%d0
	moveal	%d0,%a3
	clrl	%fp@(-6)
	subql	#2,%sp
	pea	%pc@(str_100036fc)
	pea	%fp@(-8)
	jsr	%pc@(sub_10003114)
	tstw	%sp@+
	bnew	.L100036f2
	movel	#1835098984,%d0
	lea	%fp@(-28),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	subql	#4,%sp
	_GetDeviceList
	moveal	%sp@+,%a4
	braw	.L100036e8

.L100035fc:
	pea	%fp@(-24)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10003476)
	movew	%d0,%d7
	addqw	#8,%sp
	bnes	.L10003678
	moveq	#0,%d0
	movew	%fp@(-24),%d0
	moveq	#2,%d1
	cmpl	%d0,%d1
	beqs	.L10003630
	moveq	#0,%d0
	movew	%fp@(-24),%d0
	moveq	#14,%d1
	cmpl	%d0,%d1
	beqs	.L10003630
	moveq	#0,%d0
	movew	%fp@(-24),%d0
	moveq	#20,%d1
	cmpl	%d0,%d1
	bnes	.L10003658

.L10003630:
	movel	#2048,%d0
	andl	%fp@(-20),%d0
	beqs	.L10003658
	moveal	%a4,%a3
	moveb	#1,%fp@(-1)
	moveq	#0,%d0
	moveb	%fp@(-22),%d0
	movew	%d0,%fp@(-6)
	moveq	#0,%d0
	moveb	%fp@(-21),%d0
	movew	%d0,%fp@(-4)

.L10003658:
	movel	%a3,%d0
	bnes	.L10003678
	pea	%fp@(-1)
	pea	%fp@(-4)
	pea	%fp@(-6)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10003516)
	tstb	%d0
	lea	%sp@(16),%sp
	beqs	.L10003678
	moveal	%a4,%a3

.L10003678:
	movel	%a3,%d0
	beqs	.L100036e0
	cmpil	#314,%fp@(-28)

	bnes	.L1000368c
	movew	#255,%fp@(-4)

.L1000368c:
	moveq	#0,%d0
	movel	%d0,%fp@(-60)
	movew	%fp@(-8),%fp@(-54)
	movew	#17163,%fp@(-52)
	movew	%fp@(-6),%fp@(-50)
	movew	%fp@(-4),%fp@(-48)
	movel	%fp@(-28),%fp@(-46)
	lea	%fp@(-78),%a0
	_Control
	movew	%d0,%d7
	tstb	%fp@(-1)
	beqs	.L100036f2
	moveq	#0,%d0
	movel	%d0,%fp@(-60)
	movew	%fp@(-8),%fp@(-54)
	movew	#17162,%fp@(-52)
	movew	#7,%fp@(-50)
	lea	%fp@(-78),%a0
	_Control
	movew	%d0,%d7
	bras	.L100036f2

.L100036e0:
	subql	#4,%sp
	movel	%a4,%sp@-
	_GetNextDevice
	moveal	%sp@+,%a4

.L100036e8:
	movel	%a4,%d0
	beqs	.L100036f2
	movel	%a3,%d0
	beqw	.L100035fc

.L100036f2:
	moveml	%fp@(-90),%d7/%a3-%a4
	unlk	%fp
	rts

str_100036fc:
	.byte	0x0a
	.string	".Backlight"

sub_10003708:
	bsrw	sub_10003712
	braw	.L10003770
	rts

sub_10003712:
	moveq	#0,%d1
	lea	%pc@(word_1000376a),%a0
	movew	%a0@,%d0
	_GetTrapAddress
	moveal	%a0,%a1
	lea	%pc@(off_1000376c),%a0
	movel	%a1,%a0@
	lea	%pc@(word_10003766),%a0
	movew	%a0@,%d0
	_GetOSTrapAddress
	moveal	%a0,%a1
	lea	%pc@(off_1000376c),%a0
	cmpal	%a0@,%a1
	beqs	.L10003764
	moveal	0xdd8,%a0
	movel	%a0@(36),%d0
	moveq	#14,%d1
	andl	%d0,%d1
	cmpil	#6,%d1
	beqs	.L10003764
	moveq	#112,%d1
	andl	%d0,%d1
	cmpil	#32,%d1
	beqs	.L10003764
	lea	%pc@(word_10003766),%a0
	movew	%a0@,%d0
	lea	%pc@(off_1000376c),%a0
	moveal	%a0@,%a0
	_SetOSTrapAddress

.L10003764:
	rts

word_10003766:
	_Egret

word_10003768:
	_ExpansionBusDispatch

word_1000376a:
	_UnimplTrap

off_1000376c:
	.short	0x0000,0x0000

.L10003770:
	btst	#6,0x240b
	bnes	.L100037aa
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnes	.L1000378a
	movel	%a0,%d0
	btst	#0,%d0
	bnes	.L100037aa

.L1000378a:
	lea	%pc@(word_10003768),%a0
	movew	%a0@,%d0
	_GetToolTrapAddress
	moveal	%a0,%a1
	lea	%pc@(off_1000376c),%a0
	cmpal	%a0@,%a1
	beqs	.L100037aa
	lea	%pc@(word_10003768),%a0
	movew	%a0@,%d0
	lea	%pc@(off_1000376c),%a0
	moveal	%a0@,%a0
	_SetToolTrapAddress

.L100037aa:
	rts

sub_100037ac:
	clrw	%a5@(40)
	clrw	%a5@(38)
	movel	#1651861367,%d0
	_Gestalt
	beqs	.L100037c0
	subal	%a0,%a0

.L100037c0:
	movel	%a0,%d0
	bset	#0,%d0
	subqw	#2,%sp
	movel	#1651861367,%sp@-
	movel	%d0,%sp@-
	movew	#1028,%d0
	_GestaltValueDispatch
	addqw	#2,%sp
	btst	#1,0xb21
	beqs	.L100037e2
	rts

.L100037e2:
	jsr	%pc@(sub_100049fa)
	jsr	%pc@(sub_100037f0)
	jsr	%pc@(sub_10003ed8)
	rts

sub_100037f0:
	btst	#2,0xb21
	beqs	.L10003806
	movel	0x3f8,%a5@(30)
	movel	0x3fc,%a5@(34)
	bras	.L10003818

.L10003806:
	movel	%a0,%d0
	lea	%pc@(word_100058ce),%a0
	movel	%a0@,%a5@(30)
	movel	%a0@(4),%a5@(34)
	moveal	%d0,%a0

.L10003818:
	movew	%a5@(34),%d0
	subiw	#20,%d0
	movew	%d0,%a5@(34)
	subiw	#12,%d0
	movew	%d0,%a5@(30)
	btst	#2,0xb21
	beqs	.L10003842
	subiw	#50,%a5@(36)
	addiw	#50,%a5@(32)
	bras	.L10003864

.L10003842:
	movew	%a5@(36),%d0
	subw	%a5@(32),%d0
	lsrw	#1,%d0
	addw	%a5@(32),%d0
	movew	%d0,%a5@(36)
	movew	%d0,%a5@(32)
	addiw	#80,%a5@(36)

.L1000385e:
	subiw	#80,%a5@(32)

.L10003864:
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnes	.L1000388e
	movel	%a0,%d0
	btst	#0,%d0
	beqs	.L1000388e
	pea	%a5@(40)
	pea	%a5@(38)
	pea	%a5@(30)
	movel	#198425,%d0
	_BlueBoxDispatch
	addqw	#8,%sp
	addqw	#4,%sp

.L1000388e:
	jmp	%pc@(sub_10003988)

sub_10003892:
	btst	#1,0xb21
	beqs	sub_1000389c
	rts

sub_1000389c:
	jsr	%pc@(sub_10004b2e)
	st	%sp@-
	jsr	%pc@(sub_10003ea8)
	rts

sub_100038a8:
	movew	%a5@(38),%a5@(42)
	clrw	%a5@(38)
	movew	#1,%a5@(40)
	movew	%sp@(4),%d0
	moveml	%d7-%a1,%sp@-
	moveal	0x2b6,%a0
	lea	%pc@(str_10003918),%a1
	movel	%a1,%a0@(804)
	btst	#5,0xb20
	beqs	.L10003906
	addqw	#8,%d0
	movew	%d0,%a5@(40)
	lea	%pc@(word_10003986),%a0
	movew	%a5@(40),%a0@
	lea	%pc@(dword_10003914),%a0
	pea	%a0@
	jsr	%pc@(sub_10003db8)
	lea	%pc@(dword_10003914),%a0
	tstl	%a0@
	beqs	.L10003906
	moveal	%a0@,%a0
	moveal	%a0@,%a0
	movew	%a0@,%d0
	cmpw	%a5@(40),%d0
	bnes	.L10003906
	movew	%a0@(2),%a5@(40)

.L10003906:
	moveml	%sp@+,%d7-%a1
	movel	%sp@+,%d0
	addqw	#2,%sp
	movel	%d0,%sp@-
	jmp	%pc@(sub_10003988)

dword_10003914:
	.short	0x0000,0x0000

str_10003918:
	.byte	0x0a
	.string	"Extensions"

sub_10003924:
	moveal	%sp@+,%a0
	movew	%sp@+,%d0
	addqw	#1,%d0
	movew	%d0,%a5@(38)
	movew	%sp@+,%d0
	addqw	#8,%d0
	movew	%d0,%a5@(40)
	jmp	%a0@

sub_10003938:
	btst	#1,0xb21
	beqs	.L10003942
	rts

.L10003942:
	lea	%pc@(word_10003ac6),%a0
	st	%a0@
	moveal	0x2b6,%a0
	clrl	%a0@(804)
	btst	#5,0xb20
	beqs	.L10003978
	lea	%pc@(dword_10003982),%a0
	lea	%pc@(word_10003986),%a1
	movew	%a1@,%a0@
	movew	%a5@(38),%a0@(2)
	addqw	#2,%a0@(2)
	pea	%a0@
	jsr	%pc@(sub_10003de8)
	sf	%sp@-
	jsr	%pc@(sub_10003ea8)

.L10003978:
	movew	%a5@(40),%a5@(38)
	jmp	%pc@(sub_10003988)

dword_10003982:
	.short	0x0000,0x0000

word_10003986:
	.short	0x0000

sub_10003988:
	btst	#1,0xb21
	beqs	.L10003992
	rts

.L10003992:
	linkw	%fp,#-42
	moveml	%d0-%d2/%a0-%a1,%sp@-
	clrb	%sp@-
	jsr	%pc@(sub_10004cce)
	tstb	%sp@+
	bset	#7,0x15d
	bnes	.L100039b6
	bsrw	sub_10003ac8
	movew	#1,%sp@-
	bsrw	sub_10005682

.L100039b6:
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnes	.L100039d0
	movel	%a0,%d0
	btst	#0,%d0
	beqs	.L100039d0
	movel	#1818,%d0
	_BlueBoxDispatch

.L100039d0:
	addqw	#1,%a5@(38)
	movew	%a5@(40),%d0
	beqs	.L100039e4
	cmpw	%a5@(38),%d0
	bges	.L100039e4
	movew	%d0,%a5@(38)

.L100039e4:
	movel	%a5@(30),%fp@(-42)
	movel	%a5@(34),%fp@(-38)
	movel	0x118,%sp@-
	movel	0x2a6,0x118
	moveal	%a5@,%a0
	movel	%a0@,%fp@(-34)
	pea	%a5@(112)
	_SetPort
	pea	%fp@(-30)
	_GetPenState
	_PenNormal
	pea	%fp@(-12)
	_GetForeColor
	pea	%fp@(-6)
	_GetBackColor
	pea	%fp@(-42)
	jsr	%pc@(sub_10003f4c)
	pea	%fp@(-42)
	movel	#65537,%sp@-
	_InsetRect
	tstw	%a5@(40)
	beqs	.L10003a52
	movew	%fp@(-36),%d0
	subw	%fp@(-40),%d0
	subw	%a5@(42),%d0
	muluw	%a5@(38),%d0
	divuw	%a5@(40),%d0
	addw	%fp@(-40),%d0
	addw	%a5@(42),%d0
	bras	.L10003a5a

.L10003a52:
	movew	%a5@(38),%d0
	addw	%fp@(-40),%d0

.L10003a5a:
	movew	%fp@(-36),%sp@-
	movew	%d0,%fp@(-36)
	pea	%fp@(-42)
	jsr	%pc@(sub_10004028)
	movew	%fp@(-36),%fp@(-40)
	movew	%sp@+,%fp@(-36)
	pea	%fp@(-42)
	jsr	%pc@(sub_10004380)
	lea	%pc@(word_10003ac6),%a0
	tstb	%a0@
	beqs	.L10003a8a
	moveaw	#2,%a0
	_Delay

.L10003a8a:
	pea	%fp@(-12)
	_RGBForeColor
	pea	%fp@(-6)
	_RGBBackColor
	pea	%fp@(-30)
	_SetPenState
	moveq	#0,%d0
	movew	%a5@(40),%d0
	moveq	#0,%d1
	movew	%a5@(38),%d1
	pea	%a5@(30)
	movel	%d0,%sp@-
	movel	%d1,%sp@-
	jsr	%pc@(sub_10004668)
	movel	%fp@(-34),%sp@-
	_SetPort
	movel	%sp@+,0x118
	moveml	%sp@+,%d0-%d2/%a0-%a1
	unlk	%fp
	rts

word_10003ac6:
	.short	0x0000

sub_10003ac8:
	movel	%a3,%sp@-
	subqw	#4,%sp
	movel	%sp,%sp@-
	_GetPort
	movel	0x9de,%sp@-
	_SetPort
	subqw	#4,%sp
	_FrontWindow
	subqw	#4,%sp
	_NewRgn
	moveal	%sp@,%a3
	pea	0x3f8
	_RectRgn
	movel	%a3,%sp@-
	_PaintBehind
	movel	%a3,%sp@-
	_DisposeRgn
	_SetPort
	moveal	%sp@+,%a3
	jmp	%pc@(sub_10004d70)

sub_10003af6:
	lea	%pc@(word_10003b00),%a0
	movel	%a0,%sp@(4)
	rts

word_10003b00:
	.rept	300
		.short	0x0000
	.endr

	.short	0x0000,0x01CA,0x0230,0x0202
	.short	0x0208,0x0780,0x1FE0,0x1F20,0x3F90,0x3FF0,0x3FF0,0x3FF0
	.short	0x1FE0,0x1FE0,0x0780,0x0000,0x0000,0x01CA,0x0230,0x0202
	.short	0x0208,0x0780,0x1FE0,0x1FE0,0x3FF0,0x3FF0,0x3FF0,0x3FF0
	.short	0x1FE0,0x1FE0,0x0780,0x0000,0x0009,0x0007

sub_10003d9c:
	linkw	%fp,#0
	movel	%d3,%sp@-
	moveal	%fp@(8),%a0
	tstw	%a0@(6)
	slt	%d3
	negb	%d3
	moveb	%d3,%d0
	movel	%fp@(-4),%d3
	unlk	%fp
	rts

sub_10003db8:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveal	%fp@(8),%a4
	subql	#4,%sp
	movel	#1885495666,%sp@-
	movew	#-20034,%sp@-
	_GetResource
	movel	%sp@+,%a4@
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	beqs	.L10003dde
	moveq	#0,%d0
	movel	%d0,%a4@

.L10003dde:
	moveal	%fp@(-4),%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_10003de8:
	linkw	%fp,#-4
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	movel	%a4,%d0
	beqw	.L10003e96
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	pea	%fp@(-4)
	jsr	%pc@(sub_10003db8)
	tstl	%fp@(-4)
	bnes	.L10003e4e
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d7
	moveq	#0,%d0
	movew	%d0,%sp@-
	_UseResFile
	moveq	#4,%d0
	_NewHandleSysClear
	movel	%a0,%fp@(-4)
	beqs	.L10003e4a
	movel	%a0,%sp@-
	movel	#1885495666,%sp@-
	movew	#-20034,%sp@-
	pea	%pc@(word_10003ea2)
	_AddResource
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	beqs	.L10003e4a
	moveal	%fp@(-4),%a0
	_DisposeHandle
	moveq	#0,%d0
	movel	%d0,%fp@(-4)

.L10003e4a:
	movew	%d7,%sp@-
	_UseResFile

.L10003e4e:
	tstl	%fp@(-4)
	beqs	.L10003e96
	moveal	%fp@(-4),%a0
	moveal	%a0@,%a0
	movew	%a4@,%d0
	cmpw	%a0@,%d0
	bnes	.L10003e70
	moveal	%fp@(-4),%a0
	moveal	%a0@,%a0
	movew	%a4@(2),%d0
	cmpw	%a0@(2),%d0
	beqs	.L10003e90

.L10003e70:
	moveal	%fp@(-4),%a0
	moveal	%a0@,%a0
	movew	%a4@,%a0@
	moveal	%fp@(-4),%a0
	moveal	%a0@,%a0
	movew	%a4@(2),%a0@(2)
	movel	%fp@(-4),%sp@-
	_ChangedResource
	moveq	#0,%d0
	movew	%d0,%sp@-
	_UpdateResFile

.L10003e90:
	movel	%fp@(-4),%sp@-
	_ReleaseResource

.L10003e96:
	moveml	%fp@(-12),%d7/%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

word_10003ea2:
	.short	0x0000

sub_10003ea4:
	braw	sub_1000324a

sub_10003ea8:
	linkw	%fp,#0
	tstb	%fp@(8)
	beqs	.L10003ec0
	subql	#2,%sp
	pea	%pc@(sub_10004964)
	moveq	#0,%d0
	_StartupDispatch
	addqw	#2,%sp
	bras	.L10003ecc

.L10003ec0:
	subql	#2,%sp
	pea	%pc@(sub_10004964)
	moveq	#1,%d0
	_StartupDispatch
	addqw	#2,%sp

.L10003ecc:
	unlk	%fp
	moveal	%sp@+,%a0
	addqw	#2,%sp
	jmp	%a0@

sub_10003ed4:
	braw	sub_10003106

sub_10003ed8:
	linkw	%fp,#-332
	movel	%a4,%sp@-
	lea	%fp@(-332),%a4
	clrw	%fp@(-6)
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1886545254,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	tstw	%sp@+
	bnes	.L10003f44
	movel	%a4,%sp@-
	movew	#-20601,%sp@-
	moveq	#3,%d0
	movew	%d0,%sp@-
	jsr	%pc@(sub_100032b4)
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	beqs	.L10003f44
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	%a4,%sp@-
	pea	%fp@(-76)
	moveq	#1,%d0
	_HighLevelFSDispatch
	tstw	%sp@+
	bnes	.L10003f44
	moveal	0x2b6,%a0
	moveb	#1,%a0@(763)

.L10003f44:
	moveal	%fp@(-336),%a4
	unlk	%fp
	rts

sub_10003f4c:
	linkw	%fp,#-14
	moveal	%fp@(8),%a0
	lea	%fp@(-8),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	pea	%fp@(-8)
	moveq	#-1,%d0
	movew	%d0,%sp@-
	movew	%d0,%sp@-
	_InsetRect
	jsr	%pc@(sub_1000519e)
	tstb	%d0
	beqw	.L1000400a
	movew	#-21846,%fp@(-10)
	movew	#-21846,%fp@(-12)
	movew	#-21846,%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	movew	%fp@(-6),%sp@-
	movew	%fp@(-4),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	_MoveTo
	movel	%fp@(-8),%sp@-
	_LineTo
	movew	%fp@(-2),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	movew	%fp@(-8),%sp@-
	_LineTo
	movew	#-1,%fp@(-10)
	movew	#-1,%fp@(-12)
	movew	#-1,%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	movew	%fp@(-6),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%fp@(-4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%fp@(-2),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%fp@(-4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%fp@(-2),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%fp@(-8),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	clrl	%fp@(-12)
	clrw	%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	bras	.L10004010

.L1000400a:
	moveq	#33,%d0
	movel	%d0,%sp@-
	_ForeColor

.L10004010:
	pea	%fp@(-8)
	moveq	#1,%d0
	movew	%d0,%sp@-
	movew	%d0,%sp@-
	_InsetRect
	pea	%fp@(-8)
	_FrameRect
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_10004028:
	linkw	%fp,#-4
	moveml	%d6-%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	jsr	%pc@(sub_1000519e)
	tstb	%d0
	beqw	.L1000436c
	pea	%fp@(-4)
	jsr	%pc@(sub_10004ff2)
	moveb	%d0,%d6
	movew	%a4@(6),%d0
	extl	%d0
	movew	%a4@(2),%d1
	extl	%d1
	movel	%d0,%d7
	subl	%d1,%d7
	cmpiw	#6,%d7
	addqw	#4,%sp
	bltw	.L1000434e
	moveq	#3,%d0
	movel	%d0,%sp@-
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_1000514c)
	movew	%a4@(2),%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%sp@-
	movew	%a4@,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	_LineTo
	moveq	#4,%d0
	movel	%d0,%sp@-
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_1000514c)
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(6),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	_LineTo
	moveq	#6,%d0
	movel	%d0,%sp@-
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_1000514c)
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	moveq	#2,%d0
	movel	%d0,%sp@-
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_1000514c)
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#4,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#4,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	_LineTo
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_1000514c)
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(6),%d0
	subqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#5,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#5,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#4,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#4,%d0
	movew	%d0,%sp@-
	_LineTo
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_1000514c)
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#4,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#4,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#4,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#4,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#5,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#5,%d0
	movew	%d0,%sp@-
	_LineTo
	lea	%sp@(48),%sp
	bras	.L10004360

.L1000434e:
	moveq	#4,%d0
	movel	%d0,%sp@-
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_1000514c)
	movel	%a4,%sp@-
	_PaintRect
	addqw	#8,%sp

.L10004360:
	tstb	%d6
	beqs	.L10004370
	moveal	%fp@(-4),%a0
	_DisposeHandle
	bras	.L10004370

.L1000436c:
	movel	%a4,%sp@-
	_PaintRect

.L10004370:
	moveml	%fp@(-16),%d6-%d7/%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_1000437c:
	braw	sub_100032b4

sub_10004380:
	linkw	%fp,#-20
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	jsr	%pc@(sub_1000519e)
	tstb	%d0
	beqw	.L10004640
	movew	%a4@(6),%d0
	extl	%d0
	movew	%a4@(2),%d1
	extl	%d1
	movel	%d0,%d7
	subl	%d1,%d7
	cmpiw	#5,%d7
	bltw	.L10004512
	lea	%fp@(-8),%a0
	moveal	%a4,%a1
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	pea	%fp@(-8)
	moveq	#1,%d0
	movew	%d0,%sp@-
	movew	%d0,%sp@-
	_InsetRect
	addqw	#2,%fp@(-6)
	movew	#-17477,%fp@(-10)
	movew	#-17477,%fp@(-12)
	movew	#-17477,%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	pea	%fp@(-8)
	_PaintRect
	pea	%fp@(-8)
	moveq	#-1,%d0
	movew	%d0,%sp@-
	movew	%d0,%sp@-
	_InsetRect
	subqw	#2,%fp@(-6)
	clrl	%fp@(-12)
	clrw	%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	movew	%a4@(2),%sp@-
	movew	%a4@,%sp@-
	_MoveTo
	movew	%a4@(2),%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	#21845,%fp@(-10)
	movew	#21845,%fp@(-12)
	movew	#21845,%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	#-30584,%fp@(-10)
	movew	#-30584,%fp@(-12)
	movew	#-30584,%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_LineTo
	movew	%a4@(6),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_LineTo
	movew	#-8739,%fp@(-10)
	movew	#-8739,%fp@(-12)
	movew	#-8739,%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	movew	%a4@(2),%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	#-17477,%fp@(-10)
	movew	#-17477,%fp@(-12)
	movew	#-17477,%fp@(-14)
	pea	%fp@(-14)
	_RGBForeColor
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_MoveTo
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_LineTo
	braw	.L1000465c

.L10004512:
	cmpiw	#1,%d7
	blts	.L1000453c
	clrl	%fp@(-18)
	clrw	%fp@(-20)
	pea	%fp@(-20)
	_RGBForeColor
	movew	%a4@(2),%sp@-
	movew	%a4@,%sp@-
	_MoveTo
	movew	%a4@(2),%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo

.L1000453c:
	cmpiw	#2,%d7
	blts	.L10004578
	movew	#21845,%fp@(-16)
	movew	#21845,%fp@(-18)
	movew	#21845,%fp@(-20)
	pea	%fp@(-20)
	_RGBForeColor
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo

.L10004578:
	cmpiw	#3,%d7
	blts	.L100045c0
	movew	#-30584,%fp@(-16)
	movew	#-30584,%fp@(-18)
	movew	#-30584,%fp@(-20)
	pea	%fp@(-20)
	_RGBForeColor
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#2,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_LineTo
	movew	%a4@(6),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	movew	%a4@,%sp@-
	_LineTo

.L100045c0:
	cmpiw	#4,%d7
	bltw	.L1000465c
	movew	#-17477,%fp@(-16)
	movew	#-17477,%fp@(-18)
	movew	#-17477,%fp@(-20)
	pea	%fp@(-20)
	_RGBForeColor
	movew	%a4@(2),%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@,%d0
	addqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#2,%d0
	movew	%d0,%sp@-
	_LineTo
	movew	#-8739,%fp@(-16)
	movew	#-8739,%fp@(-18)
	movew	#-8739,%fp@(-20)
	pea	%fp@(-20)
	_RGBForeColor
	movew	%a4@(2),%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_MoveTo
	movew	%a4@(2),%d0
	addqw	#3,%d0
	movew	%d0,%sp@-
	movew	%a4@(4),%d0
	subqw	#1,%d0
	movew	%d0,%sp@-
	_LineTo
	bras	.L1000465c

.L10004640:
	movew	#-1,%fp@(-2)
	movew	#-1,%fp@(-4)
	movew	#-1,%fp@(-6)
	pea	%fp@(-6)
	_RGBBackColor
	movel	%a4,%sp@-
	_EraseRect

.L1000465c:
	moveml	%fp@(-28),%d7/%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_10004668:
	linkw	%fp,#-618
	moveml	%d3-%d7/%a3-%a4,%sp@-
	lea	%fp@(-260),%a4
	subql	#4,%sp
	jsr	%pc@(sub_10003af6)
	moveal	%sp@+,%a3
	addql	#1,%a3@(518)
	moveal	0x2b6,%a0
	tstb	%a0@(763)
	beqw	.L1000493c
	moveal	0x2b6,%a0
	movel	%a0@(804),%fp@(-4)
	beqw	.L1000493c
	jsr	%pc@(sub_1000519e)
	moveb	%d0,%fp@(-611)
	moveal	%fp@(16),%a0
	lea	%fp@(-532),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%fp@(-4),%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000521e)
	subql	#2,%sp
	movel	%fp@(-4),%sp@-
	movel	%a3,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	moveb	%d0,%sp@-
	jsr	%pc@(sub_10003162)
	tstb	%sp@+
	addqw	#8,%sp
	beqs	.L10004706
	addql	#1,%a3@(514)
	movel	%a3@(514),%d0
	addql	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-516)
	jsr	%pc@(sub_1000328c)
	pea	%fp@(-516)
	jsr	%pc@(sub_10005284)
	pea	%pc@(str_1000495c)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	pea	%fp@(-516)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	lea	%sp@(20),%sp
	bras	.L1000470c

.L10004706:
	moveq	#0,%d0
	movel	%d0,%a3@(514)

.L1000470c:
	moveq	#0,%d0
	moveb	%fp@(-611),%d0
	movel	%d0,%sp@-
	pea	%fp@(-610)
	jsr	%pc@(sub_10004dfc)
	pea	%fp@(-548)
	jsr	%pc@(sub_10004d92)
	pea	%pc@(str_10004954)
	pea	%fp@(-518)
	_GetFNum
	movew	%fp@(-518),%sp@-
	_TextFont
	moveq	#9,%d0
	movew	%d0,%sp@-
	_TextSize
	moveq	#1,%d0
	movew	%d0,%sp@-
	_TextMode
	pea	%fp@(-540)
	_GetFontInfo
	moveq	#0,%d0
	moveb	%a3@,%d0
	tstl	%d0
	lea	%sp@(12),%sp
	bnes	.L10004756
	clrw	%d7
	bras	.L10004778

.L10004756:
	subql	#2,%sp
	movel	%a4,%sp@-
	_StringWidth
	movew	%a3@(256),%d0
	cmpw	%sp@+,%d0
	sgt	%d3
	negb	%d3
	beqs	.L1000476e
	movew	%a3@(256),%d0
	bras	.L10004776

.L1000476e:
	subql	#2,%sp
	movel	%a4,%sp@-
	_StringWidth
	movew	%sp@+,%d0

.L10004776:
	movew	%d0,%d7

.L10004778:
	extl	%d7
	movew	%fp@(-526),%d0
	extl	%d0
	movew	%fp@(-530),%d1
	extl	%d1
	subl	%d1,%d0
	moveq	#0,%d1
	movew	%d0,%d1
	cmpl	%d7,%d1
	bges	.L1000479a
	movew	%d7,%d0
	addw	%fp@(-530),%d0
	movew	%d0,%fp@(-526)

.L1000479a:
	moveal	%fp@(16),%a0
	movew	%a0@(4),%d0
	addqw	#2,%d0
	movew	%d0,%fp@(-532)
	movew	%fp@(-538),%d6
	addw	%fp@(-540),%d6
	movew	%d6,%d0
	addw	%fp@(-532),%d0
	movew	%d0,%fp@(-528)
	extl	%d0
	movew	%fp@(-532),%d1
	extl	%d1
	subl	%d1,%d0
	moveq	#0,%d1
	movew	%d0,%d1
	extl	%d6
	subl	%d6,%d1
	asrl	#1,%d1
	movew	%d1,%d4
	addw	%fp@(-532),%d4
	movew	%fp@(-540),%d5
	addw	%d4,%d5
	movel	%fp@(-532),%sp@-
	pea	%fp@(-524)
	_GetCPixel
	clrl	%fp@(-616)
	clrw	%fp@(-618)
	pea	%fp@(-618)
	_RGBForeColor
	pea	%fp@(-524)
	_RGBBackColor
	pea	%fp@(-532)
	_EraseRect
	movew	%fp@(-530),%sp@-
	movew	%d5,%sp@-
	_MoveTo
	movel	%a4,%sp@-
	_DrawString
	movel	%fp@(-4),%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000521e)
	subql	#2,%sp
	movel	%a4,%sp@-
	_StringWidth
	movew	%sp@+,%a3@(256)
	movel	%fp@(8),%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000328c)
	tstl	%fp@(12)
	addqw	#8,%sp
	beqs	.L10004854
	movel	%fp@(12),%sp@-
	pea	%fp@(-516)
	jsr	%pc@(sub_1000328c)
	pea	%pc@(str_10004950)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	pea	%fp@(-516)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	lea	%sp@(16),%sp

.L10004854:
	movel	%a3@(518),%sp@-
	pea	%fp@(-516)
	jsr	%pc@(sub_1000328c)
	pea	%pc@(str_1000494c)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	pea	%fp@(-516)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	tstl	%a3@(518)
	lea	%sp@(16),%sp
	bnes	.L10004888
	subql	#2,%sp
	movel	%a4,%sp@-
	_StringWidth
	movew	%sp@+,%d7
	bras	.L100048b6

.L10004888:
	subql	#2,%sp
	pea	%a3@(258)
	_StringWidth
	subql	#2,%sp
	movel	%a4,%sp@-
	_StringWidth
	movew	%sp@+,%d0
	cmpw	%sp@+,%d0
	slt	%d3
	negb	%d3
	beqs	.L100048ac
	subql	#2,%sp
	pea	%a3@(258)
	_StringWidth
	movew	%sp@+,%d0
	bras	.L100048b4

.L100048ac:
	subql	#2,%sp
	movel	%a4,%sp@-
	_StringWidth
	movew	%sp@+,%d0

.L100048b4:
	movew	%d0,%d7

.L100048b6:
	moveal	%fp@(16),%a0
	lea	%fp@(-532),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveal	%fp@(16),%a0
	movew	%a0@(6),%d0
	addqw	#4,%d0
	movew	%d0,%fp@(-530)
	movew	%d7,%d0
	addw	%fp@(-530),%d0
	movew	%d0,%fp@(-526)
	movew	%d6,%d0
	addw	%fp@(-532),%d0
	movew	%d0,%fp@(-528)
	extl	%d0
	movew	%fp@(-532),%d1
	extl	%d1
	subl	%d1,%d0
	moveq	#0,%d1
	movew	%d0,%d1
	extl	%d6
	subl	%d6,%d1
	asrl	#1,%d1
	movew	%d1,%d4
	addw	%fp@(-532),%d4
	movew	%fp@(-540),%d5
	addw	%d4,%d5
	pea	%fp@(-532)
	_EraseRect
	movew	%fp@(-530),%sp@-
	movew	%d5,%sp@-
	_MoveTo
	movel	%a4,%sp@-
	_DrawString
	movel	%a4,%sp@-
	pea	%a3@(258)
	jsr	%pc@(sub_1000521e)
	pea	%fp@(-548)
	jsr	%pc@(sub_10004dd4)
	moveq	#0,%d0
	moveb	%fp@(-611),%d0
	movel	%d0,%sp@-
	pea	%fp@(-610)
	jsr	%pc@(sub_10004f5c)
	lea	%sp@(20),%sp

.L1000493c:
	moveml	%fp@(-646),%d3-%d7/%a3-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

str_1000494c:
	.byte	0x02
	.string	", "

str_10004950:
	.byte	0x01
	.string	"/"
	.align	2

str_10004954:
	.byte	0x06
	.string	"Geneva"

str_1000495c:
	.byte	0x01
	.string	" "
	.align	2

sub_10004960:
	braw	sub_100030da

sub_10004964:
	linkw	%fp,#0
	moveml	%d6-%d7/%a3-%a4,%sp@-
	movel	%fp@(16),%d6
	beqs	.L10004978
	moveq	#2,%d0
	cmpl	%d6,%d0
	bnes	.L100049ea

.L10004978:
	subql	#4,%sp
	jsr	%pc@(sub_10003af6)
	moveal	%sp@+,%a4
	moveal	0x2b6,%a0
	moveal	%a0@(710),%a3
	moveal	%a3@,%a0
	moveal	%a0@,%a0
	movew	%a0@(18),%d7
	movel	%d6,%d0
	beqs	.L1000499a
	subql	#2,%d0
	beqs	.L100049a6
	bras	.L100049ea

.L1000499a:
	movew	%d7,%sp@-
	jsr	%pc@(sub_100038a8)
	movew	%d7,%a4@(554)
	bras	.L100049ea

.L100049a6:
	cmpw	%a4@(554),%d7
	beqs	.L100049c0
	moveal	%a3@,%a0
	moveal	%a0@,%a0
	movew	%a0@(10),%d6
	movew	%d7,%sp@-
	movew	%d6,%sp@-
	jsr	%pc@(sub_10003924)
	movew	%d7,%a4@(554)

.L100049c0:
	moveal	0x2b6,%a0
	tstb	%a0@(763)
	beqs	.L100049e6
	moveal	%fp@(8),%a0
	movel	%a0,%sp@-
	pea	%a4@(522)
	jsr	%pc@(sub_1000521e)
	lea	%a4@(522),%a0
	moveal	0x2b6,%a1
	movel	%a0,%a1@(804)
	addqw	#8,%sp

.L100049e6:
	jsr	%pc@(sub_10003988)

.L100049ea:
	moveml	%fp@(-16),%d6-%d7/%a3-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

sub_100049fa:
	linkw	%fp,#-12
	moveml	%d3/%d5-%d7/%a3-%a4,%sp@-
	subql	#4,%sp
	movel	#1633908082,%sp@-
	movew	#-20701,%sp@-
	_GetResource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqw	.L10004b20
	moveal	%a3@,%a0
	tstw	%a0@
	beqw	.L10004b20
	subql	#4,%sp
	jsr	%pc@(sub_10003af6)
	movel	%sp@+,%fp@(-12)
	_GetZone
	movel	%a0,%fp@(-8)
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	moveal	%a3@,%a0
	moveq	#68,%d0
	mulsw	%a0@,%d0
	_NewPtrSys
	movel	%a0,%fp@(-4)
	beqw	.L10004b16
	clrb	%d6
	moveal	%a3@,%a0
	movew	%a0@,%d5
	clrw	%d7
	bras	.L10004a94

.L10004a54:
	subql	#4,%sp
	extl	%d7
	moveal	%a3@,%a0
	movel	%d7,%d0
	asll	#2,%d0
	movew	%a0@(4,%d0:l),%sp@-
	_GetCursor
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10004a8e
	moveal	%a4@,%a0
	extl	%d7
	moveal	%fp@(-4),%a1
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#68,%d0
	swap	%d1
	muluw	#68,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	addal	%d0,%a1
	moveq	#68,%d0
	_BlockMoveData
	bras	.L10004a90

.L10004a8e:
	moveq	#1,%d6

.L10004a90:
	movew	%d7,%d0
	addqw	#1,%d7

.L10004a94:
	cmpw	%d7,%d5
	bles	.L10004a9c
	tstb	%d6
	beqs	.L10004a54

.L10004a9c:
	tstb	%d6
	bnes	.L10004b10
	moveal	%fp@(-12),%a0
	movew	%d5,%a0@(558)
	moveal	%fp@(-12),%a0
	movel	%fp@(-4),%a0@(562)
	movew	#1000,%d0
	extl	%d0
	divsw	%d5,%d0
	cmpiw	#17,%d0
	sgt	%d3
	negb	%d3
	beqs	.L10004ace
	movew	#1000,%d0
	extl	%d0
	divsw	%d5,%d0
	bras	.L10004ad0

.L10004ace:
	moveq	#17,%d0

.L10004ad0:
	extl	%d0
	moveal	%fp@(-12),%a0
	movel	%d0,%a0@(566)
	movel	%a5,%d0
	moveal	0x904,%a5
	moveal	%fp@(-12),%a0
	movel	%d0,%a0@(574)
	lea	%pc@(sub_10004b60),%a0
	moveal	%fp@(-12),%a1
	movel	%a0,%a1@(584)
	moveal	%fp@(-12),%a0
	lea	%a0@(578),%a0
	_InsXTime
	moveal	%fp@(-12),%a0
	lea	%a0@(578),%a0
	movel	#2000,%d0
	_PrimeTime
	bras	.L10004b16

.L10004b10:
	moveal	%fp@(-4),%a0
	_DisposePtr

.L10004b16:
	moveal	%fp@(-8),%a0
	_SetZone
	movel	%a3,%sp@-
	_ReleaseResource

.L10004b20:
	moveml	%fp@(-36),%d3/%d5-%d7/%a3-%a4
	unlk	%fp
	rts

sub_10004b2a:
	braw	sub_10003ed4

sub_10004b2e:
	linkw	%fp,#0
	movel	%a4,%sp@-
	subql	#2,%sp
	jsr	%pc@(sub_10004cce)
	tstb	%sp@+
	beqs	.L10004b58
	subql	#4,%sp
	jsr	%pc@(sub_10003af6)
	moveal	%sp@+,%a4
	lea	%a4@(578),%a0
	_RmvTime
	moveal	%a4@(562),%a0
	_DisposePtr
	moveq	#0,%d0
	movel	%d0,%a4@(562)

.L10004b58:
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_10004b60:
	linkw	%fp,#0
	moveml	%d3/%d5-%d7/%a4,%sp@-
	subql	#4,%sp
	jsr	%pc@(sub_10003af6)
	moveal	%sp@+,%a4
	tstb	%a4@(556)
	beqw	.L10004c5e
	moveq	#0,%d0
	moveb	0x8cd,%d0
	tstl	%d0
	bnew	.L10004c5e
	tstw	0x8d0
	bnew	.L10004c5e
	moveq	#0,%d0
	moveb	0x8d2,%d0
	tstl	%d0
	bnew	.L10004c5e
	tstb	0x8f2
	beqw	.L10004c5e
	jsr	%pc@(sub_10004d36)
	tstb	%d0
	bnew	.L10004c5e
	movel	%a4@(574),%d0
	exg	%d0,%a5
	movel	%d0,%d7
	movew	%a4@(560),%d6
	movel	0x16a,%d5
	extl	%d6
	moveal	%a4@(562),%a0
	movel	%d6,%d0
	movel	%d0,%d1
	muluw	#68,%d0
	swap	%d1
	muluw	#68,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	pea	%a0@(%d0:l)
	_SetCursor
	movel	%d7,%d0
	exg	%d0,%a5
	extl	%d6
	movel	%d6,%d0
	addql	#1,%d0
	movew	%a4@(558),%d1
	extl	%d1
	jsr	%pc@(sub_1000c128)
	movew	%d0,%a4@(560)
	tstl	%a4@(570)
	bnes	.L10004bfe
	movel	%d5,%a4@(570)
	bras	.L10004c58

.L10004bfe:
	movel	%d5,%d6
	subl	%a4@(570),%d6
	cmpil	#6300,%d6
	blss	.L10004c24
	movel	%a4@(574),%d0
	exg	%d0,%a5
	movel	%d0,%d7
	pea	%a4@(600)
	_SetCursor
	movel	%d7,%d0
	exg	%d0,%a5
	clrb	%a4@(556)
	bras	.L10004c58

.L10004c24:
	moveq	#0,%d0
	moveb	%a4@(557),%d0
	cmpiw	#1,%d0
	bnes	.L10004c38
	cmpil	#5400,%d6
	bhis	.L10004c4a

.L10004c38:
	moveq	#0,%d0
	moveb	%a4@(557),%d0
	tstl	%d0
	bnes	.L10004c58
	cmpil	#3600,%d6
	blss	.L10004c58

.L10004c4a:
	movel	%a4@(566),%d0
	addl	%d0,%d0
	movel	%d0,%a4@(566)
	addqb	#1,%a4@(557)

.L10004c58:
	movel	%a4@(566),%d6
	bras	.L10004cae

.L10004c5e:
	tstb	%a4@(556)
	beqs	.L10004c6c
	subql	#2,%sp
	jsr	%pc@(sub_10004cce)
	addqw	#2,%sp

.L10004c6c:
	moveb	#1,%a4@(556)
	clrw	%a4@(560)
	moveq	#0,%d0
	movel	%d0,%a4@(570)
	movew	#1000,%d1
	extl	%d1
	divsw	%a4@(558),%d1
	cmpiw	#17,%d1
	sgt	%d3
	negb	%d3
	beqs	.L10004c9c
	movew	#1000,%d1
	extl	%d1
	divsw	%a4@(558),%d1
	bras	.L10004c9e

.L10004c9c:
	moveq	#17,%d1

.L10004c9e:
	extl	%d1
	movel	%d1,%a4@(566)
	clrb	%a4@(557)
	movel	#2000,%d6

.L10004cae:
	tstb	%a4@(556)
	beqs	.L10004cbc
	lea	%a4@(578),%a0
	movel	%d6,%d0
	_PrimeTime

.L10004cbc:
	moveml	%fp@(-20),%d3/%d5-%d7/%a4
	unlk	%fp
	rts

sub_10004cc6:
	braw	sub_100033d2

sub_10004cca:
	braw	sub_10003162

sub_10004cce:
	linkw	%fp,#0
	moveml	%d6-%d7/%a3-%a4,%sp@-
	subql	#4,%sp
	jsr	%pc@(sub_10003af6)
	moveal	%sp@+,%a4
	clrb	%d7
	tstl	%a4@(562)
	beqs	.L10004d28
	moveb	%a4@(556),%d6
	clrb	%a4@(556)
	tstb	%d6
	beqs	.L10004d26
	moveq	#0,%d0
	moveb	0x8cd,%d0
	tstl	%d0
	bnes	.L10004d26
	tstw	0x8d0
	bnes	.L10004d26
	moveq	#0,%d0
	moveb	0x8d2,%d0
	tstl	%d0
	bnes	.L10004d26
	moveal	%a4@(574),%a0
	moveal	%a0@,%a3
	lea	%a3@(-202),%a3
	movel	%a0,%d0
	exg	%d0,%a5
	movel	%d0,%d6
	pea	%a3@(94)
	_SetCursor
	movel	%d6,%d0
	exg	%d0,%a5

.L10004d26:
	moveq	#1,%d7

.L10004d28:
	moveb	%d7,%fp@(8)
	moveml	%fp@(-16),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_10004d36:
	linkw	%fp,#-8
	clrb	%d1
	lea	%fp@(-8),%a0
	lea	0x3f8,%a1
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	moveq	#-1,%d0
	cmpw	%fp@(-8),%d0
	beqs	.L10004d6a
	moveq	#-1,%d0
	cmpw	%fp@(-6),%d0
	beqs	.L10004d6a
	moveq	#-1,%d0
	cmpw	%fp@(-4),%d0
	beqs	.L10004d6a
	moveq	#-1,%d0
	cmpw	%fp@(-2),%d0
	beqs	.L10004d6a
	moveq	#1,%d1

.L10004d6a:
	moveb	%d1,%d0
	unlk	%fp
	rts

sub_10004d70:
	linkw	%fp,#-8
	clrl	%fp@(-4)
	clrw	%fp@(-6)
	movew	#-1,%fp@(-8)
	lea	0x3f8,%a0
	lea	%fp@(-8),%a1
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	unlk	%fp
	rts

sub_10004d92:
	linkw	%fp,#-4
	movel	%a4,%sp@-
	moveal	%fp@(8),%a4
	pea	%fp@(-4)
	_GetPort
	moveal	%fp@(-4),%a0
	movew	%a0@(68),%a4@
	moveal	%fp@(-4),%a0
	movew	%a0@(74),%a4@(2)
	moveal	%fp@(-4),%a0
	moveq	#0,%d0
	moveb	%a0@(70),%d0
	movew	%d0,%a4@(4)
	moveal	%fp@(-4),%a0
	movew	%a0@(72),%a4@(6)
	moveal	%fp@(-8),%a4
	unlk	%fp
	rts

sub_10004dd4:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveal	%fp@(8),%a4
	movew	%a4@,%sp@-
	_TextFont
	movew	%a4@(2),%sp@-
	_TextSize
	movew	%a4@(4),%sp@-
	_TextFace
	movew	%a4@(6),%sp@-
	_TextMode
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_10004dfc:
	linkw	%fp,#-8
	moveml	%a2-%a4,%sp@-
	moveal	%fp@(8),%a4
	pea	%fp@(-4)
	_GetPort
	moveq	#0,%d0
	movel	%d0,%a4@(34)
	movel	%d0,%a4@(38)
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_10003d9c)
	moveb	%d0,%a4@
	moveb	#1,%a4@(1)
	moveal	%fp@(-4),%a0
	lea	%a4@(42),%a1
	lea	%a0@(32),%a0
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveal	%fp@(-4),%a0
	movel	%a0@(84),%a4@(54)
	moveal	%fp@(-4),%a0
	movel	%a0@(80),%a4@(50)
	tstb	%a4@
	addqw	#4,%sp
	beqs	.L10004ea4
	pea	%a4@(2)
	_GetForeColor
	pea	%a4@(8)
	_GetBackColor
	moveal	%fp@(-4),%a0
	moveal	%a0@(58),%a2
	moveal	%a0@(32),%a3
	movel	%a2,%d0
	beqs	.L10004e78
	moveal	%a2@,%a0
	tstw	%a0@
	beqs	.L10004e78
	movel	%a2,%a4@(34)

.L10004e78:
	movel	%a3,%d0
	beqs	.L10004ea0
	moveal	%a3@,%a0
	tstw	%a0@
	beqs	.L10004e88
	movel	%a3,%a4@(38)
	bras	.L10004e98

.L10004e88:
	moveal	%a3@,%a0
	moveal	%a0@(6),%a0
	moveal	%a0@,%a0
	lea	%a4@(42),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+

.L10004e98:
	moveb	#1,%a4@(1)
	bras	.L10004ea4

.L10004ea0:
	clrb	%a4@(1)

.L10004ea4:
	pea	%a4@(14)
	_GetPenState
	moveal	%fp@(-4),%a0
	movew	%a0@(72),%a4@(32)
	moveml	%fp@(-20),%a2-%a4
	unlk	%fp
	rts

sub_10004ebe:
	linkw	%fp,#-8
	moveml	%d7/%a4,%sp@-
	moveb	%fp@(15),%d7
	beqs	.L10004ef0
	pea	%fp@(-8)
	_GetPort
	pea	%fp@(-4)
	_GetCWMgrPort
	movel	%fp@(-8),%d0
	cmpl	%fp@(-4),%d0
	bnes	.L10004ef0
	_GetZone
	moveal	%a0,%a4
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone

.L10004ef0:
	movel	%fp@(8),%sp@-
	_SetPenState
	tstb	%d7
	beqs	.L10004f08
	movel	%fp@(-8),%d0
	cmpl	%fp@(-4),%d0
	bnes	.L10004f08
	moveal	%a4,%a0
	_SetZone

.L10004f08:
	moveml	%fp@(-16),%d7/%a4
	unlk	%fp
	rts

sub_10004f12:
	braw	sub_100030f8

sub_10004f16:
	linkw	%fp,#-8
	movel	%a4,%sp@-
	pea	%fp@(-8)
	_GetPort
	pea	%fp@(-4)
	_GetCWMgrPort
	movel	%fp@(-8),%d0
	cmpl	%fp@(-4),%d0
	bnes	.L10004f40
	_GetZone
	moveal	%a0,%a4
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone

.L10004f40:
	movel	%fp@(8),%sp@-
	_BackPat
	movel	%fp@(-8),%d0
	cmpl	%fp@(-4),%d0
	bnes	.L10004f54
	moveal	%a4,%a0
	_SetZone

.L10004f54:
	moveal	%fp@(-12),%a4
	unlk	%fp
	rts

sub_10004f5c:
	linkw	%fp,#-4
	movel	%a4,%sp@-
	moveal	%fp@(8),%a4
	pea	%fp@(-4)
	_GetPort
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_10003d9c)
	moveq	#0,%d1
	moveb	%d0,%d1
	tstl	%d1
	addql	#4,%sp
	movel	%d1,%sp@-
	pea	%a4@(14)
	jsr	%pc@(sub_10004ebe)
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_10003d9c)
	tstb	%d0
	lea	%sp@(12),%sp
	beqs	.L10004fd2
	tstb	%a4@
	beqs	.L10004fd2
	pea	%a4@(2)
	_RGBForeColor
	pea	%a4@(8)
	_RGBBackColor
	tstl	%a4@(34)
	beqs	.L10004fb2
	movel	%a4@(34),%sp@-
	_PenPixPat

.L10004fb2:
	tstb	%a4@(1)
	beqs	.L10004fe4
	tstl	%a4@(38)
	beqs	.L10004fc6
	movel	%a4@(38),%sp@-
	_BackPixPat
	bras	.L10004fe4

.L10004fc6:
	pea	%a4@(42)
	jsr	%pc@(sub_10004f16)
	addqw	#4,%sp
	bras	.L10004fe4

.L10004fd2:
	pea	%a4@(42)
	_BackPat
	movel	%a4@(50),%sp@-
	_ForeColor
	movel	%a4@(54),%sp@-
	_BackColor

.L10004fe4:
	movew	%a4@(32),%sp@-
	_TextMode
	moveal	%fp@(-8),%a4
	unlk	%fp
	rts

sub_10004ff2:
	linkw	%fp,#-4
	moveml	%d7/%a2-%a4,%sp@-
	moveal	%fp@(8),%a3
	clrb	%d7
	movel	%a3,%d0
	beqw	.L10005140
	moveq	#0,%d0
	movel	%d0,%a3@
	moveal	0x2b6,%a0
	tstl	%a0@(680)
	beqw	.L10005140
	moveal	0x2b6,%a0
	moveal	%a0@(680),%a0
	movel	%a0@,%a3@
	bnew	.L10005140
	_GetZone
	moveal	%a0,%a2
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#4,%sp
	movel	#1668052340,%sp@-
	movew	#-20233,%sp@-
	_GetResource
	movel	%sp@+,%a3@
	beqs	.L1000504c
	movel	%a3@,%sp@-
	_DetachResource
	braw	.L10005136

.L1000504c:
	moveq	#72,%d0
	_NewHandleSysClear
	movel	%a0,%a3@
	beqw	.L10005136
	moveal	%a0,%a4
	moveal	%a4@,%a0
	movew	#7,%a0@(6)
	moveal	%a4@,%a0
	clrw	%a0@(8)
	moveal	%a4@,%a0
	movew	#-4370,%a0@(10)
	moveal	%a4@,%a0
	movew	#-4370,%a0@(12)
	moveal	%a4@,%a0
	movew	#-4370,%a0@(14)
	moveal	%a4@,%a0
	movew	#1,%a0@(16)
	moveal	%a4@,%a0
	movew	#-13108,%a0@(18)
	moveal	%a4@,%a0
	movew	#-13108,%a0@(20)
	moveal	%a4@,%a0
	movew	#-1,%a0@(22)
	moveal	%a4@,%a0
	movew	#2,%a0@(24)
	moveal	%a4@,%a0
	movew	#-26215,%a0@(26)
	moveal	%a4@,%a0
	movew	#-26215,%a0@(28)
	moveal	%a4@,%a0
	movew	#-1,%a0@(30)
	moveal	%a4@,%a0
	movew	#3,%a0@(32)
	moveal	%a4@,%a0
	movew	#26214,%a0@(34)
	moveal	%a4@,%a0
	movew	#26214,%a0@(36)
	moveal	%a4@,%a0
	movew	#-13108,%a0@(38)
	moveal	%a4@,%a0
	movew	#4,%a0@(40)
	moveal	%a4@,%a0
	movew	#13107,%a0@(42)
	moveal	%a4@,%a0
	movew	#13107,%a0@(44)
	moveal	%a4@,%a0
	movew	#-26215,%a0@(46)
	moveal	%a4@,%a0
	movew	#5,%a0@(48)
	moveal	%a4@,%a0
	clrw	%a0@(50)
	moveal	%a4@,%a0
	clrw	%a0@(52)
	moveal	%a4@,%a0
	movew	#-30584,%a0@(54)
	moveal	%a4@,%a0
	movew	#6,%a0@(56)
	moveal	%a4@,%a0
	clrw	%a0@(58)
	moveal	%a4@,%a0
	clrw	%a0@(60)
	moveal	%a4@,%a0
	movew	#21845,%a0@(62)

.L10005136:
	tstl	%a3@
	beqs	.L1000513c
	moveq	#1,%d7

.L1000513c:
	moveal	%a2,%a0
	_SetZone

.L10005140:
	moveb	%d7,%d0
	moveml	%fp@(-20),%d7/%a2-%a4
	unlk	%fp
	rts

sub_1000514c:
	linkw	%fp,#0
	moveml	%d5-%d7/%a4,%sp@-
	movew	%fp@(14),%d5
	moveal	%fp@(8),%a4
	movel	%a4,%d0
	beqs	.L10005194
	moveal	%a4@,%a0
	movew	%a0@(6),%d0
	extl	%d0
	movel	%d0,%d6
	addql	#1,%d6
	moveq	#0,%d7
	bras	.L1000518e

.L10005170:
	moveal	%a4@,%a0
	movel	%d7,%d0
	asll	#3,%d0
	cmpw	%a0@(8,%d0:l),%d5
	bnes	.L1000518a
	moveal	%a4@,%a0
	movel	%d7,%d0
	asll	#3,%d0
	pea	%a0@(10,%d0:l)
	_RGBForeColor
	bras	.L10005194

.L1000518a:
	movel	%d7,%d0
	addql	#1,%d7

.L1000518e:
	extl	%d6
	cmpl	%d7,%d6
	bgts	.L10005170

.L10005194:
	moveml	%fp@(-16),%d5-%d7/%a4
	unlk	%fp
	rts

sub_1000519e:
	linkw	%fp,#-4
	moveml	%d3-%d7/%a4,%sp@-
	clrb	%d6
	pea	%fp@(-4)
	_GetPort
	movel	%fp@(-4),%sp@-
	jsr	%pc@(sub_10003d9c)
	tstb	%d0
	addqw	#4,%sp
	beqs	.L100051cc
	moveal	%fp@(-4),%a0
	moveal	%a0@(2),%a0
	moveal	%a0@,%a0
	moveaw	%a0@(32),%a0
	bras	.L100051d0

.L100051cc:
	moveaw	#1,%a0

.L100051d0:
	movew	%a0,%d7
	cmpiw	#4,%d7
	blts	.L10005212
	subql	#4,%sp
	_GetMainDevice
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10005212
	moveal	%a4@,%a0
	movew	%a0@(20),%d4
	moveq	#1,%d0
	andw	%d4,%d0
	moveq	#0,%d1
	movew	%d0,%d1
	tstl	%d1
	sne	%d3
	negb	%d3
	moveb	%d3,%d5
	moveq	#1,%d3
	tstb	%d5
	beqs	.L10005204
	cmpiw	#8,%d7
	bges	.L10005210

.L10005204:
	tstb	%d5
	bnes	.L1000520e
	cmpiw	#4,%d7
	bges	.L10005210

.L1000520e:
	moveq	#0,%d3

.L10005210:
	moveb	%d3,%d6

.L10005212:
	moveb	%d6,%d0
	moveml	%fp@(-28),%d3-%d7/%a4
	unlk	%fp
	rts

sub_1000521e:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveal	%fp@(12),%a4
	moveal	%a4,%a0
	moveal	%fp@(8),%a1
	moveb	%a4@,%d0
	extw	%d0
	addqw	#1,%d0
	extl	%d0
	_BlockMoveData
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_10005240:
	linkw	%fp,#0
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(12),%a3
	moveal	%fp@(8),%a4
	moveb	%a3@,%d0
	extw	%d0
	extl	%d0
	movel	%d0,%d6
	moveb	%a4@,%d0
	extw	%d0
	extl	%d0
	movel	%d0,%d7
	moveal	%a3,%a0
	addql	#1,%a0
	movel	%d7,%d0
	addql	#1,%d0
	lea	%a4@(%d0:l),%a1
	movel	%d6,%d0
	_BlockMoveData
	movel	%d7,%d0
	addl	%d6,%d0
	moveb	%d0,%a4@
	moveml	%fp@(-16),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_10005280:
	braw	sub_10003394

sub_10005284:
	linkw	%fp,#-256
	moveml	%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	lea	%fp@(-256),%a4
	moveb	#1,%a4@
	moveb	#40,%a4@(1)
	movel	%a3,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	pea	%pc@(str_100052c2)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005240)
	movel	%a4,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000521e)
	moveml	%fp@(-264),%a3-%a4
	unlk	%fp
	rts

str_100052c2:
	.byte	0x01
	.string	")"
	.align	2

sub_100052c6:
	moveal	TopMapHndl,%a0
	moveal	%a0@,%a0
	movew	%a0@(20),CurMap
	moveq	#0,%d0
	bsrw	sub_10001922
	movel	%d0,%d6
	lea	%pc@(word_100058de),%a1
	tstw	%a1@
	bnew	.L100052e8
	bsrw	sub_10005b8a

.L100052e8:
	rts

sub_100052ea:
	bclr	#2,0xb21
	bclr	#1,0xb21
	subqw	#2,%sp
	pea	%a5@(698)
	_OpenResFile
	movew	%sp@+,%d0
	bmis	.L10005336
	movew	%d0,%sp@-
	subqw	#4,%sp
	clrw	%sp@-
	_GetPicture
	movel	%sp@+,%d0
	beqs	.L10005334
	moveal	%d0,%a2
	moveal	%a2@,%a0
	movel	%a0@(6),%sp@-
	movel	%a0@(2),%sp@-
	bsrw	sub_10005c9c
	movel	%a2,%sp@-
	pea	%sp@(4)
	_DrawPicture
	addqw	#8,%sp
	bset	#2,0xb21
	bset	#1,0xb21

.L10005334:
	_CloseResFile

.L10005336:
	btst	#2,0xb21
	bnes	.L10005398
	lea	%a5@(698),%a1
	bsrw	sub_1000231a
	bnes	.L10005386
	cmpil	#21888,%d2
	bcss	.L10005386
	movel	#22413824,%sp@-
	clrl	%sp@-
	bsrw	sub_10005c9c
	movew	#64,%sp@-
	movel	%a2,%sp@-
	movel	%sp,%sp@-
	pea	%a5@(114)
	pea	%sp@(14)
	movel	%sp@,%sp@-
	clrw	%sp@-
	clrl	%sp@-
	_CopyBits
	lea	%sp@(14),%sp
	bset	#2,0xb21
	bset	#1,0xb21
	bras	.L10005398

.L10005386:
	moveb	0xb21,%sp@-
	bset	#1,0xb21
	bsrw	sub_100056ae
	moveb	%sp@+,0xb21

.L10005398:
	rts

sub_1000539a:
	moveml	%d0-%d4/%a0-%a4,%sp@-
	lea	%pc@(word_100058de),%a1
	cmpiw	#0,%a1@
	beqw	.L10005442
	lea	%pc@(word_1000544a),%a0
	movew	%a1@,%d1
	cmpiw	#-16501,%d1
	beqs	.L100053c2
	cmpiw	#-16504,%d1
	beqs	.L100053c2
	movew	#2,%d1
	bras	.L100053d0

.L100053c2:
	movew	#4,%d1
	bras	.L100053d0

.L100053c8:
	addql	#8,%a0
	tstw	%a0@
	beqw	.L10005442

.L100053d0:
	cmpw	%a0@,%d0
	bnes	.L100053c8
	movew	%a0@(6),%d4
	subqw	#4,%sp
	movew	%a0@(%d1:w),%sp@-
	_GetPicture
	movel	%sp@+,%d0
	beqs	.L10005442
	moveal	%d0,%a2
	moveal	%a2@,%a0
	lea	%pc@(word_100058d6),%a4
	lea	%pc@(word_100058ce),%a3
	movew	%a0@(8),%d0
	movew	%a3@(6),%d1
	movew	%a3@(2),%d2
	subw	%d2,%d1
	subw	%d0,%d1
	lsrw	#1,%d1
	addw	%d1,%d2
	movew	%d2,%a4@(2)
	addw	%d2,%d0
	movew	%d0,%a4@(6)
	movew	%a3@(4),%d0
	subw	%d4,%d0
	movew	%d0,%a4@(4)
	movew	%a0@(6),%d1
	subw	%d1,%d0
	movew	%d0,%a4@
	bsrw	sub_10005644
	clrl	%sp@-
	movel	%sp,%sp@-
	_GetPort
	pea	%a5@(112)
	_SetPort
	movel	%a2,%sp@-
	movel	%a4,%sp@-
	_DrawPicture
	movel	%a2,%sp@-
	_ReleaseResource
	_SetPort
	moveml	%sp@+,%d0-%d4/%a0-%a4
	rts

.L10005442:
	moveml	%sp@+,%d0-%d4/%a0-%a4
	braw	.L10005478

word_1000544a:
	.short	0xFFF6,0xB0F1,0xB0F0
	.short	0x000F,0x0028,0xB0EF,0xB0EE,0x0024,0xFFF3,0xB0F3,0xB0F2
	.short	0x000F,0xFFF2,0xB0F5,0xB0F4,0x0024,0x0000,0x0C40,0xFFF6
	.short	0x6606,0x08F8,0x0003,0x0B21

.L10005478:
	.short	0x0838,0x0005,0x0B20,0x6616
	.short	0x0C40,0xFFF6,0x6606,0x303C,0xFFFF,0x600A,0x0C40,0xFFF5
	.short	0x6604,0x303C,0xFFFE,0x41FA,0x0068,0x3080,0x1F38,0x0B21
	.short	0x08F8,0x0001,0x0B21,0x6100,0x0206,0x11DF,0x0B21,0x41FA
	.short	0x0050,0x4250,0x4E75

str_100054b6:
	.byte	0x0e
	.ascii	"Virtual Memory"
	.byte	0x00

str_100054c6:
	.byte	0x18
	.ascii	"User Mode Initialization"
	.byte	0x00

str_100054e0:
	.byte	0x08
	.ascii	"Debugger"
	.byte	0x00

str_100054ea:
	.byte	0x0c
	.ascii	"Disassembler"
	.byte	0x00

str_100054f8:
	.byte	0x06
	.ascii	"System"
	.byte	0x00

word_10005500:
	.short	0x0000

sub_10005502:
	braw	sub_100033f8

sub_10005506:
	btst	#2,0xb21
	bnew	.L100055a6
	jsr	%pc@(sub_10002ce2)
	_InitWindows
	pea	%a5@(112)
	movew	%a5@(118),%d0
	andiw	#-16384,%d0
	beqs	.L10005528
	_InitCPort
	bras	.L1000552a

.L10005528:
	_InitPort

.L1000552a:
	bsrw	sub_100056ae
	btst	#2,0xb21
	beqs	.L1000559a
	moveb	0xbff,%sp@-
	clrb	0xbff
	movel	0x120,%sp@-
	clrl	0x120
	movel	0x2ba,%sp@-
	bsrw	sub_100059a4
	moveq	#0,%d0
	bsrw	sub_10001922
	movew	SysMap,%sp@-
	moveal	TopMapHndl,%a0
	moveal	%a0@,%a0
	movew	%a0@(20),SysMap
	moveq	#40,%d0
	_SysError
	movew	%sp@+,SysMap
	btst	#5,0xb20
	bnes	.L1000557c
	moveq	#-13,%d0
	bsrw	sub_1000539a
	bras	.L1000558a

.L1000557c:
	btst	#3,0xb21
	beqs	.L1000558a
	moveq	#-10,%d0
	bsrw	sub_1000539a

.L1000558a:
	movel	%sp@+,0x2ba
	movel	%sp@+,0x120
	moveb	%sp@+,0xbff
	bsrw	sub_10005984

.L1000559a:
	bsrw	sub_100037ac
	movew	#1,%sp@-
	bsrw	sub_100055a8

.L100055a6:
	rts

sub_100055a8:
	moveal	%sp@+,%a0
	movew	%sp@+,%d0
	movel	%a0,%sp@-
	tstw	%d0
	bnes	.L100055ca
	subqw	#2,%sp
	pea	%pc@(.L100055e2)
	movel	%a5,%sp@-
	clrl	%sp@-
	clrw	%sp@-
	movew	#1830,%d0
	_DisplayDispatch
	addqw	#2,%sp
	braw	.L10005642

.L100055ca:
	subqw	#2,%sp
	pea	%pc@(.L100055e2)
	movel	%a5,%sp@-
	clrw	%sp@-
	clrl	%sp@-
	movew	#2031,%d0
	_DisplayDispatch
	addqw	#2,%sp
	braw	.L10005642

.L100055e2:
	linkw	%fp,#0
	movel	%a5,%sp@-
	movew	%fp@(12),%d0
	cmpiw	#2,%d0
	bnes	.L10005636
	moveal	%fp@(14),%a5
	movel	%a5@,%sp@-
	_InitGraf
	lea	%a5@(112),%a0
	movel	%a0,%sp@-
	movel	%a0,%sp@-
	movew	%a0@(6),%d0
	andiw	#-16384,%d0
	beqs	.L10005612
	_CloseCPort
	_OpenCPort
	bras	.L10005616

.L10005612:
	_ClosePort
	_OpenPort

.L10005616:
	bsrw	sub_10005644
	movew	#1,%sp@-
	bsrw	sub_10005682
	tstw	%a5@(40)
	beqs	.L1000562c
	addqw	#1,%a5@(40)

.L1000562c:
	bsrw	sub_100037f0
	bsrl	sub_1000ceb6

.L10005636:
	moveal	%sp@+,%a5
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(10),%sp
	jmp	%a0@

.L10005642:
	rts

sub_10005644:
	moveml	%d0-%d2/%a0-%a1,%sp@-
	clrl	%sp@-
	_GetMainDevice
	moveal	%sp@+,%a0
	moveal	%a0@,%a0
	moveal	%a0@(22),%a0
	moveal	%a0@,%a0
	lea	%a5@(-126),%a1
	movel	%a0@+,%a1@+
	movew	%a0@+,%d0
	andiw	#16383,%d0
	movew	%d0,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveml	%sp@+,%d0-%d2/%a0-%a1
	rts

sub_1000566e:
	pea	%a5@(112)
	_ClosePort
	clrw	%sp@-
	bsrw	sub_100055a8
	bset	#2,0xb21
	rts

sub_10005682:
	btst	#2,0xb21
	bnes	.L100056a8
	tstl	0x9d6
	beqs	.L10005694
	_InitWindows
	bras	.L100056a0

.L10005694:
	tstw	%sp@(4)
	bnes	.L100056a0
	tstb	0x8f2
	bnes	.L100056a8

.L100056a0:
	bsrw	sub_100056ae
	st	0x8f2

.L100056a8:
	moveal	%sp@+,%a0
	addqw	#2,%sp
	jmp	%a0@

sub_100056ae:
	btst	#2,0xb21
	beqs	.L100056b8
	rts

.L100056b8:
	moveml	%d0-%d4/%a0-%a3,%sp@-
	movel	0x118,%sp@-
	movel	0x2a6,0x118
	bsrw	sub_10005644
	movew	#1,%d3
	movew	%a5@(-116),%d0
	cmpiw	#400,%d0
	blss	.L100056de
	lea	%pc@(word_100058b8),%a2
	bras	.L100056e2

.L100056de:
	lea	%pc@(word_100058a6),%a2

.L100056e2:
	movew	%a5@(118),%d0
	andiw	#-16384,%d0
	bnes	.L100056f0
	moveq	#1,%d0
	bras	.L10005704

.L100056f0:
	moveal	%a5@(114),%a0
	moveal	%a0@,%a0
	movew	%a0@(32),%d0
	cmpiw	#8,%d0
	blss	.L10005704
	movew	#8,%d0

.L10005704:
	aslw	#1,%d0
	lea	%a2@(2,%d0:w),%a2

.L1000570a:
	movew	%a2@-,%d0
	beqw	.L1000588a
	cmpiw	#-1,%d0
	beqs	.L1000570a
	subqw	#4,%sp
	movew	%d0,%d1
	movew	%d0,%sp@-
	_GetPicture
	movel	%sp@+,%d0
	beqs	.L1000570a
	movel	%a2,%sp@-
	lea	%pc@(word_100058de),%a2
	movew	%d1,%a2@
	moveal	%sp@+,%a2
	moveal	%d0,%a2
	moveal	%a2@,%a0
	movel	%a0@(6),%sp@-
	movel	%a0@(2),%sp@-
	bsrw	sub_10005c9c
	lea	%pc@(word_100058ce),%a3
	movel	%sp@+,%a3@
	movel	%sp@+,%a3@(4)
	moveq	#0,%d0
	movew	%a3@,%d0
	aslw	#1,%d0
	divuw	#5,%d0
	subw	%d0,%a3@
	subw	%d0,%a3@(4)
	clrl	%sp@-
	movel	%sp,%sp@-
	_GetPort
	pea	%a5@(112)
	_SetPort
	subqw	#4,%sp
	movew	#-20235,%sp@-
	_GetPicture
	movel	%sp@+,%d0
	beqs	.L1000579c
	movel	%a2,%sp@-
	movel	%a3,%sp@-
	_DrawPicture
	movel	%a2,%sp@-
	_ReleaseResource
	moveml	%d0-%d2/%a0-%a3,%sp@-
	movel	%a3,%sp@-
	bsrl	sub_10005cc2
	moveml	%sp@+,%d0-%d2/%a0-%a3
	btst	#1,0xb21
	bnew	.L10005886
	moveq	#-14,%d0
	bsrw	sub_1000539a
	braw	.L10005886

.L1000579c:
	movew	#-16502,%d0
	movew	#-1,%d1
	moveq	#0,%d4
	btst	#1,0xb21
	beqs	.L10005806
	lea	%pc@(word_10005500),%a0
	movew	%a0@,%d1
	lea	%pc@(word_100057ce),%a0

.L100057b8:
	cmpw	%a0@+,%d1
	beqs	.L100057c6
	tstw	%a0@+
	beqw	.L10005886
	addqw	#4,%a0
	bras	.L100057b8

.L100057c6:
	movew	%a0@+,%d0
	movew	%a0@+,%d1
	movew	%a0@,%d4
	bras	.L10005806

word_100057ce:
	.short	0x0000
	.short	0xB0DC,0xFFFF,0x0000,0xFFF3,0xB0DF,0x0000,0x0012,0xFFF6
	.short	0xB0DA,0xFFFF,0x0000,0xFFF5,0xB0D9,0x0000,0x0012,0xFFFF
	.short	0xB0DA,0x0000,0x0022,0xFFFE,0xB0DA,0x0000,0xFFFF,0x0000
	.short	0x0000,0x0000,0x0000

.L10005806:
	movew	%d0,%sp@-
	tstw	%d1
	beqs	.L10005816
	movel	%a2,%sp@-
	movel	%a3,%sp@-
	_DrawPicture
	movel	%a2,%sp@-
	_ReleaseResource

.L10005816:
	movew	%sp@+,%d0
	cmpiw	#-1,%d4
	beqs	.L10005886
	subqw	#4,%sp
	movew	%d0,%sp@-
	_GetString
	movel	%sp@+,%d0
	beqs	.L10005886
	moveal	%d0,%a2
	clrw	%sp@-
	_TextFace
	clrw	%sp@-
	movel	%a2@,%sp@-
	_StringWidth
	movew	%sp@+,%d0
	btst	#1,0xb21
	bnes	.L10005854
	cmpiw	#162,%d0
	blsw	.L10005854
	movew	#32,%sp@-
	_TextFace
	clrw	%sp@-
	movel	%a2@,%sp@-
	_StringWidth
	movew	%sp@+,%d0

.L10005854:
	lsrw	#1,%d0
	movew	%a3@(6),%d1
	subw	%a3@(2),%d1
	lsrw	#1,%d1
	addw	%a3@(2),%d1
	subw	%d0,%d1
	movew	%d1,%sp@-
	movew	%a3@(4),%d0
	subiw	#44,%d0
	btst	#1,0xb21
	beqs	.L1000587a
	addw	%d4,%d0

.L1000587a:
	movew	%d0,%sp@-
	_MoveTo
	movel	%a2@,%sp@-
	_DrawString
	movel	%a2,%sp@-
	_ReleaseResource

.L10005886:
	_SetPort
	bras	.L1000589c

.L1000588a:
	cmpiw	#2,%d3
	beqs	.L10005896
	addqw	#1,%d3
	braw	.L100056de

.L10005896:
	bset	#2,0xb21

.L1000589c:
	movel	%sp@+,0x118
	moveml	%sp@+,%d0-%d4/%a0-%a3
	rts

word_100058a6:
	.short	0x0000,0xBF8B,0xFFFF,0xFFFF,0xBF8A
	.short	0xFFFF,0xFFFF,0xFFFF,0xBF89

word_100058b8:
	.short	0x0000,0xBF88,0xFFFF,0xFFFF
	.short	0xBF87,0xFFFF,0xFFFF,0xFFFF
	.short	0xBF86

sub_100058ca:
	braw	sub_10003988

word_100058ce:
	.short	0x0000
	.short	0x0000,0x0000,0x0000

word_100058d6:
	.short	0x0000,0x0000,0x0000,0x0000

word_100058de:
	.short	0x0000

off_100058e0:
	.short	0x0000,0x0000

off_100058e4:
	.short	0x0000,0x0000

off_100058e8:
	.short	0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000

sub_10005984:
	lea	%pc@(off_100058e0),%a0
	movel	%a0@,%d0
	beqs	.L10005992
	movel	%d0,0x334
	clrl	%a0@

.L10005992:
	rts

sub_10005994:
	lea	%pc@(off_100058e4),%a0
	movel	%a0@,%d0
	beqs	.L100059a2
	clrl	%a0@
	movel	%d0,%sp@-
	_CloseWindow

.L100059a2:
	rts

sub_100059a4:
	lea	%pc@(off_100058e0),%a0
	movel	0x334,%a0@

.L100059ac:
	lea	%pc@(sub_100059b6),%a0
	movel	%a0,0x334
	rts

sub_100059b6:
	lea	0x3f8,%a0
	tstb	%a0@
	bpls	.L10005a0c
	moveml	%d1/%a1,%sp@-
	moveal	%a5@,%a1
	lea	%a1@(-112),%a1
	moveq	#100,%d0
	muluw	%a1@+,%d0
	divuw	#534,%d0
	movew	%d0,%a0@
	moveq	#-64,%d1
	addw	%d0,%d1
	movew	%d1,0xda8
	addiw	#126,%d0
	movew	%d0,%a0@(4)
	movew	%a1@,%d0
	lsrw	#1,%d0
	subiw	#224,%d0
	movew	%d0,%a0@(2)
	moveq	#-32,%d1
	addw	%d0,%d1
	movew	%d1,0xdaa
	addiw	#448,%d0
	movew	%d0,%a0@(6)
	bsrs	sub_10005a16
	bset	#7,0x3f8
	moveml	%sp@+,%d1/%a1
	bras	.L100059ac

.L10005a0c:
	bsrs	sub_10005a16
	movel	0x3f8,%sp@-
	_MovePortTo
	bras	.L100059ac

sub_10005a16:
	lea	0x9fa,%a1
	movel	%a0@+,%a1@+
	movel	%a0@,%a1@
	lea	%pc@(off_100058e4),%a0
	movel	%a0@,%d0
	beqs	.L10005a2c
	clrl	%a0@
	movel	%d0,%sp@-
	_CloseWindow

.L10005a2c:
	pea	0x9fa
	movel	#524296,%sp@-
	_InsetRect
	clrl	%sp@-
	pea	%pc@(off_100058e8)
	pea	0x9fa
	clrl	%sp@-
	moveb	#1,%sp@-
	movew	#1,%sp@-
	movel	#-1,%sp@-
	clrb	%sp@-
	clrl	%sp@-
	_NewCWindow
	movel	%sp@+,%d0
	beqs	.L10005a64
	lea	%pc@(off_100058e4),%a0
	movel	%d0,%a0@
	rts

.L10005a64:
	pea	0x9fa
	movel	#-458760,%sp@-
	_InsetRect
	lea	0x9fa,%a0
	movel	%a0,%sp@-
	movel	%a0,%sp@-
	movel	%a0,%sp@-
	movel	%a0,%sp@-
	movel	%a0,%sp@-
	_EraseRect
	_FrameRect
	movel	#131074,%sp@-
	_PenSize
	movel	#196611,%sp@-
	_InsetRect
	_FrameRect
	movel	#-131075,%sp@-
	_InsetRect
	_PenNormal
	rts

sub_10005aa0:
	linkw	%fp,#-218
	movel	%a5,%fp@(-8)
	lea	%fp@(-12),%a5
	moveb	0x8f3,%fp@(-2)
	moveb	0x8f2,%fp@(-4)
	pea	%fp@(-16)
	_InitGraf
	_InitWindows
	_InitMenus
	_TEInit
	clrl	%sp@-
	_InitDialogs
	subqw	#2,%sp
	movew	%d5,%sp@-
	pea	%pc@(sub_10005af0)
	_Alert
	addqw	#2,%sp
	moveb	%fp@(-4),0x8f2
	moveb	%fp@(-2),0x8f3
	moveal	%fp@(-8),%a5
	unlk	%fp
	movew	#1,%sp@-
	bsrw	sub_10005682
	rts

sub_10005af0:
	moveml	%d0-%d1/%a0/%fp,%sp@-
	subaw	#12,%sp
	moveal	%sp,%fp
	clrb	%fp@(44)
	moveal	%fp@(36),%a0
	movew	%a0@,%d0
	cmpiw	#3,%d0
	bnes	.L10005b56
	movel	%a0@(2),%d0
	cmpib	#3,%d0
	beqs	.L10005b1a
	cmpib	#13,%d0
	bnes	.L10005b78

.L10005b1a:
	moveal	%fp@(32),%a0
	movew	#1,%a0@
	moveb	#1,%fp@(44)
	movel	%fp@(40),%sp@-
	movew	#1,%sp@-
	pea	%fp@
	pea	%fp@(4)
	pea	%fp@(8)
	_GetDialogItem
	movel	%fp@(4),%sp@-
	movew	#1,%sp@-
	_HiliteControl
	moveaw	#8,%a0
	_Delay
	movel	%fp@(4),%sp@-
	clrw	%sp@-
	_HiliteControl
	bras	.L10005b78

.L10005b56:
	moveal	%fp@(40),%a0
	tstl	%a0@(152)
	bnes	.L10005b6e
	movel	0x20c,%d0
	addil	#120,%d0
	movel	%d0,%a0@(152)

.L10005b6e:
	movel	0x20c,%d0
	subl	%a0@(152),%d0
	bccs	.L10005b1a

.L10005b78:
	lea	%sp@(12),%sp
	moveml	%sp@+,%d0-%d1/%a0/%fp
	movel	%sp@,%sp@(12)
	lea	%sp@(12),%sp
	rts

sub_10005b8a:
	clrl	%sp@-
	movel	#1667851118,%sp@-
	movew	#-20023,%sp@-
	movew	#-1,0xb9e
	_GetResource
	movel	%sp@+,%d0
	bnes	.L10005baa
	lea	%pc@(word_10005bf0),%a0
	movew	#-1,%a0@

.L10005baa:
	clrl	%sp@-
	movel	#1634296686,%sp@-
	clrw	%sp@-
	_GetResource
	movel	%sp@+,%d0
	beqs	.L10005be4
	moveml	%d2-%d3/%a3,%sp@-
	moveal	%d0,%a0
	_HLock
	movel	%a0,%sp@-
	moveal	%a0@,%a3
	movew	%a3@+,%d3
	beqs	.L10005bdc
	subqw	#1,%d3

.L10005bcc:
	movew	%a3@+,%d0
	bsrs	sub_10005bf2
	moveq	#0,%d0
	movew	%a3@+,%d0
	moveal	%d0,%a0
	_Delay
	dbf	%d3,.L10005bcc

.L10005bdc:
	moveal	%sp@+,%a0
	_HUnlock
	moveml	%sp@+,%d2-%d3/%a3

.L10005be4:
	moveal	0x2ae,%a0
	addal	%a0@(68),%a0
	jsr	%a0@
	rts

word_10005bf0:
	.short	0x0000

sub_10005bf2:
	lea	%pc@(word_10005bf0),%a0
	tstw	%a0@
	bnes	.L10005c14
	subqw	#4,%sp
	movew	%d0,%sp@-
	_GetCIcon
	movel	%sp@+,%d2
	beqs	.L10005c12
	movel	%d2,%sp@-
	bsrs	sub_10005c68
	movel	%sp,%sp@-
	movel	%d2,%sp@-
	_PlotCIcon
	addqw	#8,%sp
	_DisposeCIcon

.L10005c12:
	rts

.L10005c14:
	subqw	#4,%sp
	movel	#1229147683,%sp@-
	movew	%d0,%sp@-
	_GetResource
	movel	%sp@+,%d2
	beqs	.L10005c12
	moveal	%d2,%a0
	_HLock
	movel	%a0,%sp@-
	moveal	%a0@,%a0
	movel	%a0,%d2
	bsrs	sub_10005c68
	movew	#4,%sp@-
	movel	%d2,%sp@-
	lea	%sp@(14),%a0
	movel	%a0@-,%sp@-
	movel	%a0@-,%sp@-
	movew	%a0@-,%sp@-
	moveal	%a0@-,%a1
	pea	%a1@(128)
	movel	%a0,%sp@-
	pea	%sp@(4)
	moveal	%a5@,%a1
	moveal	%a1@,%a1
	pea	%a1@(2)
	pea	%a0@(6)
	movel	%sp@,%sp@-
	movel	%sp@,%sp@-
	_CopyMask
	lea	%sp@(28),%sp
	moveal	%sp@+,%a0
	_HUnlock
	rts

sub_10005c68:
	moveal	%sp@+,%a0
	movel	#2097184,%sp@-
	clrl	%sp@-
	moveal	%sp,%a1
	movel	%a0,%sp@-
	moveal	%a5@,%a0
	lea	%a0@(-116),%a0
	bsrs	sub_10005c80
	nop

sub_10005c80:
	movew	%a0@(4),%d0
	subw	%a0@,%d0
	movew	%a1@(4),%d1
	subw	%a1@,%d1
	subw	%d1,%d0
	asrw	#1,%d0
	addw	%a0@+,%d0
	movew	%d0,%a1@+
	addw	%d1,%d0
	movew	%d0,%a1@(2)
	rts

sub_10005c9c:
	lea	%sp@(4),%a0
	movel	%a0,%sp@-
	moveq	#2,%d0
	bsrs	sub_10005cae
	moveq	#0,%d0
	bsrs	sub_10005cae
	_OffsetRect
	rts

sub_10005cae:
	moveal	%sp@+,%a1
	movew	%a5@(-116,%d0:w),%d1
	subw	%a0@(4,%d0:w),%d1
	subw	%a0@(%d0:w),%d1
	asrw	#1,%d1
	movew	%d1,%sp@-
	jmp	%a1@

sub_10005cc2:
	linkw	%fp,#-16
	moveml	%d5-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	moveal	0x2b6,%a0
	movew	%a0@(674),%d7
	moveq	#1,%d6
	tstw	%d7
	beqs	.L10005ce6
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d5
	movew	%d7,%sp@-
	_UseResFile

.L10005ce6:
	subql	#4,%sp
	movel	#1346978644,%sp@-
	movew	#-16500,%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	tstw	%d7
	beqs	.L10005d0a
	movel	%a4,%d0
	beqs	.L10005d0a
	subql	#2,%sp
	movel	%a4,%sp@-
	_HomeResFile
	tstw	%sp@+
	bnes	.L10005d0a
	clrb	%d6

.L10005d0a:
	movel	%a4,%d0
	beqw	.L10005df6
	tstb	%d6
	beqw	.L10005df2
	tstl	%a4@
	beqw	.L10005df2
	moveal	%a4@,%a0
	lea	%fp@(-16),%a1
	addql	#2,%a0
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	tstw	%fp@(-14)
	blts	.L10005d52
	movew	%fp@(-14),%d0
	addw	%a3@(2),%d0
	movew	%d0,%fp@(-6)
	movew	%fp@(-10),%d0
	extl	%d0
	movew	%fp@(-14),%d1
	extl	%d1
	subl	%d1,%d0
	addw	%fp@(-6),%d0
	movew	%d0,%fp@(-2)
	bras	.L10005d8a

.L10005d52:
	movew	%a3@(6),%d0
	extl	%d0
	movew	%fp@(-14),%d1
	extl	%d1
	addl	%d0,%d1
	movew	%fp@(-10),%d0
	extl	%d0
	movew	%fp@(-14),%d2
	extl	%d2
	subl	%d2,%d0
	subw	%d0,%d1
	movew	%d1,%fp@(-6)
	movew	%fp@(-10),%d0
	extl	%d0
	movew	%fp@(-14),%d1
	extl	%d1
	subl	%d1,%d0
	addw	%fp@(-6),%d0
	movew	%d0,%fp@(-2)

.L10005d8a:
	tstw	%fp@(-16)
	blts	.L10005db2
	movew	%fp@(-16),%d0
	addw	%a3@,%d0
	movew	%d0,%fp@(-8)
	movew	%fp@(-12),%d0
	extl	%d0
	movew	%fp@(-16),%d1
	extl	%d1
	subl	%d1,%d0
	addw	%fp@(-8),%d0
	movew	%d0,%fp@(-4)
	bras	.L10005dea

.L10005db2:
	movew	%a3@(4),%d0
	extl	%d0
	movew	%fp@(-16),%d1
	extl	%d1
	addl	%d0,%d1
	movew	%fp@(-12),%d0
	extl	%d0
	movew	%fp@(-16),%d2
	extl	%d2
	subl	%d2,%d0
	subw	%d0,%d1
	movew	%d1,%fp@(-8)
	movew	%fp@(-12),%d0
	extl	%d0
	movew	%fp@(-16),%d1
	extl	%d1
	subl	%d1,%d0
	addw	%fp@(-8),%d0
	movew	%d0,%fp@(-4)

.L10005dea:
	movel	%a4,%sp@-
	pea	%fp@(-8)
	_DrawPicture

.L10005df2:
	movel	%a4,%sp@-
	_ReleaseResource

.L10005df6:
	tstw	%d7
	beqs	.L10005dfe
	movew	%d5,%sp@-
	_UseResFile

.L10005dfe:
	moveml	%fp@(-36),%d5-%d7/%a3-%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_10005e0a:
	moveml	%d0/%a0-%a3,%sp@-
	jsr	%pc@(sub_10005eba)
	lea	0x4e,%a3
	movel	%a3,%d0
	_NewPtrSys
	bnes	.L10005e2c
	moveal	%a0,%a2
	lea	%pc@(.L10005e66),%a0
	moveal	%a2,%a1
	movel	%a3,%d0
	_BlockMove
	movel	%a2,0x5c

.L10005e2c:
	tstl	0x6c
	bpls	.L10005e60
	subql	#8,0x10c
	moveal	0x10c,%a0
	tstl	0xb78
	bmis	.L10005e48
	lea	0x6,%a1
	moveq	#0,%d0
	_MemoryDispatch

.L10005e48:
	movew	#20217,%a0@
	movel	0x6c,%a0@(2)
	movel	%a0,%sp@-
	lea	0x6,%a1
	_FlushCodeCacheRange
	movel	%sp@+,0x6c

.L10005e60:
	moveml	%sp@+,%d0/%a0-%a3
	rts

.L10005e66:
	_HandleMixedModeFault
	bnes	.L10005e6c
	rte

.L10005e6c:
	cmpiw	#-8100,%sp@(6)
	bnes	.L10005e94
	cmpiw	#4864,%sp@(20)
	bnes	.L10005e94
	clrw	%d0
	moveb	%sp@(24),%d0
	cmpib	#23,%d0
	bhis	.L10005e94
	lea	%pc@(byte_10005e9c),%a0
	moveb	%a0@(%d0:w),%d0
	_SysError
	rte

.L10005e94:
	movew	#11,%d0
	_SysError
	rte

byte_10005e9c:
	.byte	0x0B,0x09,0x0A,0x10,0x03,0x07,0x0B,0x0B
	.byte	0x08,0x0B,0x02,0x01,0x01,0x0B,0x07,0x0B
	.byte	0x08,0x0B,0x02,0x01,0x01,0x01,0x01,0x01

sub_10005eb4:
	moveq	#12,%d0
	_SysError
	rts

sub_10005eba:
	movew	%sr,%sp@-
	moveml	%a0-%a1,%sp@-
	movel	#_fcc_bugx,%d0
	_Gestalt
	bnes	.L10005ed4
	movel	%a0,%d0
	btst	#25,%d0
	bnew	.L10005f44

.L10005ed4:
	moveq	#-1,%d0
	cmpb	0xbff,%d0
	sne	%d3
	negb	%d3
	beqs	.L10005ee8
	moveq	#64,%d0
	andb	0xbff,%d0
	bras	.L10005eee

.L10005ee8:
	moveq	#64,%d0
	andb	0x120,%d0

.L10005eee:
	tstb	%d0
	bnes	.L10005f44
	movew	#UnimplTrap,%d0
	_GetToolTrapAddress
	movel	%a0,%d1
	beqs	.L10005f44
	lea	0x6,%a3
	movel	%a3,%d0
	_NewPtrSys
	bnes	.L10005f44
	moveal	%a0,%a2
	lea	%pc@(sub_10005eb4),%a0
	moveal	%a2,%a1
	movel	%a3,%d0
	_BlockMove
	moveal	%a2,%a1
	oriw	#1792,%sr
	lea	0x400,%a0
	movel	#255,%d0

.L10005f22:
	cmpl	%a0@,%d1
	bnes	.L10005f28
	movel	%a1,%a0@

.L10005f28:
	addql	#4,%a0
	dbf	%d0,.L10005f22
	lea	0xe00,%a0
	movel	#1023,%d0

.L10005f38:
	cmpl	%a0@,%d1
	bnes	.L10005f3e
	movel	%a1,%a0@

.L10005f3e:
	addql	#4,%a0
	dbf	%d0,.L10005f38

.L10005f44:
	moveml	%sp@+,%a0-%a1
	movew	%sp@+,%sr
	rts

sub_10005f4c:
	linkw	%fp,#-270
	moveml	%d7/%a4,%sp@-
	lea	%fp@(-260),%a4
	subql	#2,%sp
	pea	%pc@(str_10005fe0)
	movel	#1886875747,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-266)
	pea	%fp@(-270)
	movel	%a4,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10005fba
	subql	#2,%sp
	movel	%fp@(-266),%sp@-
	pea	%pc@(str_10005fcc)
	pea	%fp@(-4)
	pea	%fp@(-261)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10005fba
	moveq	#0,%d0
	moveb	%fp@(-261),%d0
	cmpiw	#1,%d0
	bnes	.L10005fba
	moveal	%fp@(-4),%a0
	jsr	%a0@
	movew	%d0,%d7
	subql	#2,%sp
	pea	%fp@(-266)
	movew	#4,%sp@-
	_CodeFragmentDispatch
	addqw	#2,%sp

.L10005fba:
	movew	%d7,%fp@(10)
	moveml	%fp@(-278),%d7/%a4
	unlk	%fp
	moveal	%sp@+,%a0
	addqw	#2,%sp
	jmp	%a0@

str_10005fcc:
	.byte	0x11
	.string	"LoadNativeDrivers"
	.align	2

str_10005fe0:
	.byte	0x15
	.string	"NativeDriverLoaderLib"
	.align	2

sub_10005ff8:
	linkw	%fp,#-270
	moveml	%d7/%a3-%a4,%sp@-
	lea	%fp@(-256),%a3
	subql	#2,%sp
	pea	%pc@(str_1000609a)
	movel	#1886875747,%sp@-
	moveq	#2,%d0
	movel	%d0,%sp@-
	pea	%fp@(-262)
	pea	%fp@(-270)
	movel	%a3,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d0
	extl	%d0
	movel	%d0,%d7
	bnes	.L1000607e
	moveq	#0,%d0
	moveal	%d0,%a4
	subql	#2,%sp
	movel	%fp@(-262),%sp@-
	pea	%pc@(str_10006088)
	pea	%fp@(-266)
	pea	%fp@(-257)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d0
	extl	%d0
	movel	%d0,%d7
	bnes	.L10006070
	moveq	#0,%d0
	moveb	%fp@(-257),%d0
	cmpiw	#2,%d0
	bnes	.L10006070
	subql	#4,%sp
	movel	%fp@(-266),%sp@-
	moveq	#49,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	moveal	%sp@+,%a4

.L10006070:
	movel	%a4,%d0
	beqs	.L1000607e
	moveal	%a4,%a0
	jsr	%a0@
	movel	%a4,%sp@-
	moveq	#1,%d0
	_MixedModeDispatch

.L1000607e:
	moveml	%fp@(-282),%d7/%a3-%a4
	unlk	%fp
	rts

str_10006088:
	.byte	0x10
	.ascii	"DiskBasedCheckUp"
	.byte	0x00

str_1000609a:
	.byte	0x06
	.ascii	"PCCard"
	.byte	0x00

sub_100060a2:
	linkw	%fp,#-4
	moveml	%d7/%a4,%sp@-
	movel	#1719105125,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	bnes	.L100060da
	cmpil	#513,%fp@(-4)
	blts	.L100060da
	moveal	0x2b6,%a0
	movel	%a0@(780),%d7
	movel	%d7,%d0
	addql	#4,%d0
	moveal	%d0,%a0
	moveal	%a0@,%a4
	jsr	%a4@

.L100060da:
	moveml	%fp@(-12),%d7/%a4
	unlk	%fp
	rts

sub_100060e4:	
	linkw	%fp,#-270
	moveml	%d7/%a3-%a4,%sp@-
	lea	%fp@(-256),%a3
	subql	#2,%sp
	pea	%pc@(str_10006186)
	movel	#1886875747,%sp@-
	moveq	#2,%d0
	movel	%d0,%sp@-
	pea	%fp@(-262)
	pea	%fp@(-270)
	movel	%a3,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d0
	extl	%d0
	movel	%d0,%d7
	bnes	.L1000616a
	moveq	#0,%d0
	moveal	%d0,%a4
	subql	#2,%sp
	movel	%fp@(-262),%sp@-
	pea	%pc@(str_10006174)
	pea	%fp@(-266)
	pea	%fp@(-257)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d0
	extl	%d0
	movel	%d0,%d7
	bnes	.L1000615c
	moveq	#0,%d0
	moveb	%fp@(-257),%d0
	cmpiw	#2,%d0
	bnes	.L1000615c
	subql	#4,%sp
	movel	%fp@(-266),%sp@-
	moveq	#49,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	moveal	%sp@+,%a4

.L1000615c:
	movel	%a4,%d0
	beqs	.L1000616a
	moveal	%a4,%a0
	jsr	%a0@
	movel	%a4,%sp@-
	moveq	#1,%d0
	_MixedModeDispatch

.L1000616a:
	moveml	%fp@(-282),%d7/%a3-%a4
	unlk	%fp
	rts

str_10006174:
	.byte	0x10
	.ascii	"DiskBasedCheckUp"
	.byte	0x00

str_10006186:
	.byte	0x12
	.ascii	"USBFamilyExpertLib"
	.byte	0x00

sub_1000619a:
	linkw	%fp,#-4
	moveml	%a3-%a4,%sp@-
	_GetZone
	moveal	%a0,%a3
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#4,%sp
	movel	#1667855476,%sp@-
	moveq	#45,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L100061d8
	tstl	%a4@
	beqs	.L100061d8
	moveal	%a4,%a0
	_HLock
	moveal	%a4@,%a0
	movel	%a0,%fp@(-4)
	jsr	%a0@
	movel	%a4,%sp@-
	_ReleaseResource

.L100061d8:
	moveal	%a3,%a0
	_SetZone
	moveml	%fp@(-12),%a3-%a4
	unlk	%fp
	rts

sub_100061e6:
	linkw	%fp,#-4
	moveml	%a3-%a4,%sp@-
	_GetZone
	moveal	%a0,%a3
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#4,%sp
	movel	#1667855476,%sp@-
	moveq	#46,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10006224
	tstl	%a4@
	beqs	.L10006224
	moveal	%a4,%a0
	_HLock
	moveal	%a4@,%a0
	movel	%a0,%fp@(-4)
	jsr	%a0@
	movel	%a4,%sp@-
	_ReleaseResource

.L10006224:
	moveal	%a3,%a0
	_SetZone
	moveml	%fp@(-12),%a3-%a4
	unlk	%fp
	rts

sub_10006232:
	linkw	%fp,#-268
	movel	%a4,%sp@-
	lea	%fp@(-256),%a4
	movel	#1667658343,%d0
	lea	%fp@(-264),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L1000627c
	movel	%fp@(-264),%d0
	btst	#0,%d0
	beqs	.L1000627c
	subql	#2,%sp
	pea	%pc@(str_10006284)
	movel	#1886875747,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-268)
	pea	%fp@(-260)
	movel	%a4,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	addqw	#2,%sp

.L1000627c:
	moveal	%fp@(-272),%a4
	unlk	%fp
	rts

str_10006284:
	.byte	0x10
	.ascii	"ObjectSupportLib"
	.byte	0x00

sub_10006296:
	linkw	%fp,#-4
	moveml	%a3-%a4,%sp@-
	movel	0xdd0,%d0
	.short	0xc0bc,0x0800,0x0000	/* andl	#134217728,%d0 */
	beqs	.L100062c0
	moveal	0xdd8,%a0
	movel	%a0@,%d0
	addl	0xdd8,%d0
	moveal	%d0,%a0
	moveal	%a0@(108),%a0
	moveb	#0x88,%a0@(324)

.L100062c0:
	movel	0x2400,%d0
	.short	0xc0bc,0x0000,0x0800	/* andl	#2048,%d0 */
	bnes	.L100062d8
	movel	0x2400,%d0
	.short	0xc0bc,0x1000,0x0000	/* andl	#268435456,%d0 */
	beqs	.L100062ec

.L100062d8:
	subql	#2,%sp
	movel	#1936220524,%sp@-
	moveq	#3,%d0
	movel	%d0,%sp@-
	movew	#1026,%d0
	_GestaltValueDispatch
	addqw	#2,%sp

.L100062ec:
	movel	#1936220524,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L10006320
	subql	#4,%sp
	movel	#1853059684,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10006320
	movel	%a4,%sp@-
	_DetachResource
	moveal	%a4,%a0
	_HLock
	moveal	%a4@,%a3
	jsr	%a3@

.L10006320:
	moveml	%fp@(-12),%a3-%a4
	unlk	%fp
	rts

sub_1000632a:
	linkw	%fp,#-4
	moveml	%d3/%d6-%d7,%sp@-
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	movel	#1685089401,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L1000637e
	movel	%fp@(-4),%d0
	.short	0xc0bc,0x0000,0x0001	/* andl	#1,%d0 */
	beqs	.L1000637e
	moveq	#32,%d0
	andb	0xb20,%d0
	moveq	#0,%d1
	moveb	%d0,%d1
	tstl	%d1
	sne	%d3
	negb	%d3
	moveb	%d3,%d6
	clrb	%d7
	tstb	%d6
	beqs	.L10006372
	moveq	#1,%d7

.L10006372:
	subql	#2,%sp
	moveb	%d7,%sp@-
	movew	#493,%d0
	_DisplayDispatch
	addqw	#2,%sp

.L1000637e:
	moveml	%fp@(-16),%d3/%d6-%d7
	unlk	%fp
	rts

sub_10006388:
	linkw	%fp,#-4
	movel	%d7,%sp@-
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	clrb	%d7
	movel	#1886353266,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L100063bc
	moveq	#1,%d0
	andl	%fp@(-4),%d0
	beqs	.L100063bc
	moveq	#26,%d0
	_PowerMgrDispatch
	tstw	%d0
	beqs	.L100063bc
	moveq	#1,%d7

.L100063bc:
	moveb	%d7,%d0
	movel	%fp@(-8),%d7
	unlk	%fp
	rts

sub_100063c6:
	linkw	%fp,#0
	movel	%d7,%sp@-
	jsr	%pc@(sub_10006388)
	tstb	%d0
	beqs	.L1000641a
	moveal	0x2b6,%a0
	moveb	#1,%a0@(57)
	moveal	0x2b6,%a0
	clrb	%a0@(63)
	moveq	#1,%d0
	moveb	%d0,%sp@-
	jsr	%pc@(sub_1000d69c)
	moveal	0x2b6,%a0
	moveq	#0,%d0
	moveb	%a0@(63),%d0
	tstl	%d0
	beqs	.L1000640a
	moveq	#3,%d7
	subql	#2,%sp
	moveb	%d7,%sp@-
	movew	#493,%d0
	_DisplayDispatch
	addqw	#2,%sp

.L1000640a:
	moveal	0x2b6,%a0
	clrb	%a0@(57)
	moveal	0x2b6,%a0
	clrb	%a0@(63)

.L1000641a:
	movel	%fp@(-4),%d7
	unlk	%fp
	rts

sub_10006422:
	linkw	%fp,#0
	moveal	%fp@(8),%a1
	movew	%fp@(14),%d0
	subqw	#1,%d0
	tstw	%d0
	blts	.L1000643a

.L10006434:
	clrb	%a1@+
	dbf	%d0,.L10006434

.L1000643a:
	unlk	%fp
	rts

sub_1000643e:
	linkw	%fp,#-180
	moveml	%d4-%d7/%a3-%a4,%sp@-
	lea	%fp@(-4),%a0
	_GetDefaultStartup
	pea	0xac
	pea	%fp@(-180)
	jsr	%pc@(sub_10006422)
	moveb	#3,%fp@(-172)
	movew	#172,%fp@(-174)
	moveb	#0xff,%fp@(-167)
	lea	%fp@(-180),%a0
	_SCSIAction
	tstw	%fp@(-170)
	addqw	#8,%sp
	beqs	.L10006480
	moveq	#-1,%d0
	braw	.L100065aa

.L10006480:
	moveq	#0,%d0
	moveb	%fp@(-112),%d0
	cmpiw	#255,%d0
	bnes	.L10006492
	moveq	#-1,%d0
	braw	.L100065aa

.L10006492:
	moveb	%fp@(-112),%d4
	movew	%fp@(-134),%d6
	clrb	%d5
	moveq	#0,%d0
	movew	%d6,%d0
	tstl	%d0
	_NewPtrSysClear
	moveal	%a0,%a4
	movel	%a4,%d0
	bnes	.L100064b0
	moveq	#-1,%d0
	braw	.L100065aa

.L100064b0:
	movew	%d6,%a4@(6)
	moveb	%fp@(-2),%d0
	extw	%d0
	movew	#240,%d1
	andb	%d0,%d1
	moveq	#0,%d0
	moveb	%d1,%d0
	tstl	%d0
	bnes	.L10006532
	clrb	%d7
	bras	.L1000652e

.L100064cc:
	moveb	%d7,%fp@(-167)
	lea	%fp@(-180),%a0
	_SCSIAction
	tstw	%fp@(-170)
	bnes	.L1000652c
	moveq	#0,%d0
	moveb	%fp@(-15),%d0
	moveb	%fp@(-2),%d1
	extw	%d1
	cmpw	%d0,%d1
	bnes	.L1000652c
	moveq	#0,%d0
	movew	%fp@(-14),%d0
	moveb	%fp@(-1),%d1
	extw	%d1
	extl	%d1
	cmpl	%d0,%d1
	bnes	.L1000652c
	clrb	%fp@(-8)
	moveb	%d7,%fp@(-7)
	moveb	%fp@(-4),%d0
	asrb	#3,%d0
	moveq	#31,%d1
	andb	%d0,%d1
	moveb	%d1,%fp@(-6)
	moveq	#7,%d0
	andb	%fp@(-4),%d0
	moveb	%d0,%fp@(-5)
	beqs	.L10006526
	moveq	#1,%d6
	bras	.L10006528

.L10006526:
	clrb	%d6

.L10006528:
	moveq	#1,%d5
	bras	.L10006532

.L1000652c:
	addqb	#1,%d7

.L1000652e:
	cmpb	%d7,%d4
	bccs	.L100064cc

.L10006532:
	tstb	%d5
	beqs	.L1000659e
	lea	%a4@(68),%a3
	clrw	%a3@
	clrw	%a3@(2)
	clrw	%a3@(4)
	moveb	#6,%a4@(53)
	moveq	#0,%d0
	movel	%d0,%a4@(40)
	movel	%d0,%a4@(44)
	movel	#-536608768,%a4@(20)
	movew	#2,%a4@(94)
	moveq	#0,%d1
	moveb	%d6,%d1
	tstl	%d1
	bnes	.L10006570
	oriw	#4,%a4@(94)

.L10006570:
	movel	%fp@(-8),%a4@(12)
	moveb	#1,%a4@(8)
	moveq	#0,%d0
	movel	%d0,%a4@(16)
	moveb	#1,%a4@(103)
	moveal	%a4,%a0
	_SCSIAction
	cmpiw	#-7926,%a4@(10)
	beqs	.L1000659a
	moveq	#1,%d6
	bras	.L100065a0

.L1000659a:
	clrb	%d6
	bras	.L100065a0

.L1000659e:
	moveq	#-1,%d6

.L100065a0:
	movel	%a4,%d0
	beqs	.L100065a8
	moveal	%a4,%a0
	_DisposePtr

.L100065a8:
	moveb	%d6,%d0

.L100065aa:
	moveml	%fp@(-204),%d4-%d7/%a3-%a4
	unlk	%fp
	rts

sub_100065b4:
	linkw	%fp,#0
	moveml	%d7/%a2-%a4,%sp@-
	movew	%fp@(8),%d7
	beqs	.L10006630
	subql	#4,%sp
	movew	%d7,%sp@-
	_GetString
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqs	.L10006630
	tstl	%a3@
	beqs	.L10006630
	moveq	#0,%d0
	moveal	%d0,%a4
	moveal	%a3,%a0
	_HLock
	moveal	%a3@,%a0
	moveq	#0,%d0
	moveb	%a0@,%d0
	.short	0xd07c,0x0025	/* addw	#37,%d0 */
	extl	%d0
	_NewPtrSysClear
	moveal	%a0,%a4
	movel	%a4,%d0
	beqs	.L1000662c
	movew	#8,%a4@(4)
	clrw	%a4@(14)
	moveq	#0,%d0
	movel	%d0,%a4@(16)
	moveq	#-1,%d1
	movel	%d1,%a4@(20)
	movel	%a4,%d2
	moveq	#36,%d0
	addl	%d0,%d2
	movel	%d2,%a4@(24)
	movel	%d1,%a4@(28)
	moveal	%a3@,%a0
	movel	%a4,%d0
	moveq	#36,%d1
	addl	%d1,%d0
	moveal	%d0,%a1
	moveal	%a0,%a2
	moveq	#0,%d0
	moveb	%a2@,%d0
	addqw	#1,%d0
	extl	%d0
	_BlockMoveData
	moveal	%a4,%a0
	_NMInstall

.L1000662c:
	movel	%a3,%sp@-
	_ReleaseResource

.L10006630:
	moveml	%fp@(-16),%d7/%a2-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	addqw	#2,%sp
	jmp	%a0@

sub_1000663e:
	linkw	%fp,#-506
	moveml	%d4-%d7/%a2-%a4,%sp@-
	moveal	%fp@(8),%a3
	lea	%fp@(-262),%a4
	subql	#2,%sp
	movew	%a3@(22),%sp@-
	movel	#1702392900,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d6
	bnew	.L10006770
	clrb	%d4
	moveq	#48,%d5
	braw	.L10006700

.L10006678:
	moveal	%a3@(18),%a0
	moveal	%a4,%a1
	moveal	%a0,%a2
	moveq	#0,%d0
	moveb	%a2@,%d0
	addqw	#1,%d0
	extl	%d0
	_BlockMoveData
	moveq	#0,%d0
	movew	%d5,%d0
	cmpiw	#48,%d0
	blss	.L100066c8
	moveb	%a4@,%d7
	moveq	#0,%d0
	moveb	%d7,%d0
	cmpib	#27,%d0
	blss	.L100066a2
	moveq	#27,%d7

.L100066a2:
	addqb	#1,%d7
	moveq	#0,%d0
	moveb	%d7,%d0
	moveb	#32,%a4@(%d0:w)
	addqb	#1,%d7
	moveq	#0,%d0
	moveb	%d7,%d0
	moveb	#35,%a4@(%d0:w)
	addqb	#1,%d7
	moveq	#0,%d0
	moveb	%d7,%d0
	moveb	%d5,%a4@(%d0:w)
	moveb	%d7,%a4@
	moveq	#1,%d4

.L100066c8:
	movel	%a4,%fp@(-366)
	movew	%fp@(-6),%fp@(-362)
	movel	%fp@(-4),%fp@(-336)
	clrw	%fp@(-356)
	lea	%fp@(-384),%a0
	_PBHGetFInfoSync
	movew	%d0,%d6
	beqs	.L100066fc
	tstb	%d4
	beqs	.L100066f8
	movel	%a3@(48),%fp@(-336)
	lea	%fp@(-384),%a0
	_PBHGetFInfoSync
	movew	%d0,%d6

.L100066f8:
	tstw	%d6
	bnes	.L1000670c

.L100066fc:
	movew	%d5,%d0
	addqw	#1,%d5

.L10006700:
	moveq	#0,%d0
	movew	%d5,%d0
	cmpiw	#57,%d0
	bcsw	.L10006678

.L1000670c:
	cmpiw	#-43,%d6
	bnes	.L10006764
	tstb	%d4
	beqs	.L10006736
	movel	%a3@(18),%fp@(-488)
	movew	%a3@(22),%fp@(-484)
	movel	%a3@(48),%fp@(-458)
	movel	%a4,%fp@(-478)
	lea	%fp@(-506),%a0
	_PBHRenameSync
	movew	%d0,%d6
	bras	.L10006738

.L10006736:
	clrw	%d6

.L10006738:
	tstw	%d6
	bnes	.L10006770
	movel	%a4,%fp@(-418)
	movew	%a3@(22),%fp@(-414)
	movel	%a3@(48),%fp@(-388)
	moveq	#0,%d0
	movel	%d0,%fp@(-408)
	movel	%fp@(-4),%fp@(-400)
	lea	%fp@(-436),%a0
	moveq	#5,%d0
	_HFSDispatch
	movew	%d0,%d6
	bras	.L10006770

.L10006764:
	tstw	%d6
	bnes	.L10006770
	movew	#-43,%fp@(12)
	bras	.L10006774

.L10006770:
	movew	%d6,%fp@(12)

.L10006774:
	moveml	%fp@(-534),%d4-%d7/%a2-%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_10006780:
	linkw	%fp,#0
	movel	%d7,%sp@-
	movew	#-20261,%d7
	movew	%d7,%sp@-
	jsr	%pc@(sub_100065b4)
	movel	%fp@(-4),%d7
	unlk	%fp
	rts

sub_10006798:
	linkw	%fp,#0
	subql	#2,%sp
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000663e)
	movew	%sp@+,%fp@(12)
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_100067b0:
	linkw	%fp,#-10
	moveml	%d5-%d7,%sp@-
	clrb	%d6
	_CountADBs
	movew	%d0,%d7
	bras	.L100067e4

.L100067c0:
	lea	%fp@(-10),%a0
	movew	%d7,%d0
	_GetIndADB
	extw	%d0
	movew	%d0,%d5
	moveq	#7,%d0
	cmpb	%fp@(-9),%d0
	bnes	.L100067e2
	moveq	#0,%d0
	moveb	%fp@(-10),%d0
	cmpib	#6,%d0
	bccs	.L100067e2
	moveq	#1,%d6

.L100067e2:
	subqw	#1,%d7

.L100067e4:
	tstw	%d7
	beqs	.L100067ec
	tstb	%d6
	beqs	.L100067c0

.L100067ec:
	moveb	%d6,%fp@(8)
	moveml	%fp@(-22),%d5-%d7
	unlk	%fp
	rts

sub_100067fa:
	linkw	%fp,#-4
	movel	%d7,%sp@-
	clrb	%d7
	movel	#1852990823,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L1000681e
	tstl	%fp@(-4)
	blts	.L1000681e
	moveq	#1,%d7

.L1000681e:
	moveb	%d7,%d0
	movel	%fp@(-8),%d7
	unlk	%fp
	rts

sub_10006828:
	linkw	%fp,#-86
	moveml	%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	lea	%fp@(-86),%a4
	clrb	%d7
	pea	%fp@(-4)
	moveq	#7,%d0
	_NameRegistryDispatch
	tstl	%d0
	addqw	#4,%sp
	bnes	.L100068b0
	clrb	%fp@(-6)
	bras	.L100068a0

.L1000684e:
	pea	%fp@(-6)
	pea	%fp@(-22)
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-4)
	moveq	#10,%d0
	_NameRegistryDispatch
	tstl	%d0
	lea	%sp@(16),%sp
	bnes	.L100068a0
	tstb	%fp@(-6)
	bnes	.L100068a0
	clrb	%a4@
	pea	%fp@(-5)
	movel	%a4,%sp@-
	pea	%fp@(-38)
	pea	%fp@(-22)
	moveq	#15,%d0
	_NameRegistryDispatch
	tstl	%d0
	lea	%sp@(16),%sp
	bnes	.L100068a0
	movel	%a3,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_10003424)
	tstl	%d0
	addqw	#8,%sp
	beqs	.L100068a0
	moveq	#1,%d7
	moveb	%d7,%fp@(-6)

.L100068a0:
	tstb	%fp@(-6)
	beqs	.L1000684e
	pea	%fp@(-4)
	moveq	#8,%d0
	_NameRegistryDispatch
	addqw	#4,%sp

.L100068b0:
	moveb	%d7,%d0
	moveml	%fp@(-98),%d7/%a3-%a4
	unlk	%fp
	rts

sub_100068bc:
	linkw	%fp,#0
	movel	%d7,%sp@-
	clrb	%d7
	jsr	%pc@(sub_100067fa)
	tstb	%d0
	beqs	.L100068dc
	pea	%pc@(str_100068e8)
	jsr	%pc@(sub_10006828)
	tstb	%d0
	addqw	#4,%sp
	beqs	.L100068dc
	moveq	#1,%d7

.L100068dc:
	moveb	%d7,%fp@(8)
	movel	%fp@(-4),%d7
	unlk	%fp
	rts

str_100068e8:
	.string	"ATY,"
	.align	2

sub_100068ee:
	linkw	%fp,#-10
	moveml	%d6-%d7,%sp@-
	_CountADBs
	movew	%d0,%d7

.L100068fa:
	lea	%fp@(-10),%a0
	movew	%d7,%d0
	_GetIndADB
	extw	%d0
	movew	%d0,%d6
	moveq	#0,%d0
	moveb	%fp@(-10),%d0
	cmpiw	#192,%d0
	bnes	.L10006916
	moveq	#1,%d0
	bras	.L1000691e

.L10006916:
	subqw	#1,%d7
	tstw	%d7
	bnes	.L100068fa
	moveq	#0,%d0

.L1000691e:
	moveml	%fp@(-18),%d6-%d7
	unlk	%fp
	rts

sub_10006928:
	linkw	%fp,#-4
	movel	%d7,%sp@-
	movel	#1633968754,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	bnew	.L100069ca
	moveal	%fp@(-4),%a0
	tstw	%a0@(4)
	beqs	.L100069ca
	clrw	%d7

.L10006950:
	extl	%d7
	moveal	%fp@(-4),%a0
	movel	%d7,%d0
	addl	%d0,%d0
	movel	%d0,%d1
	addl	%d1,%d1
	addl	%d1,%d0
	tstb	%a0@(6,%d0:l)
	beqs	.L1000697c
	extl	%d7
	moveal	%fp@(-4),%a0
	movel	%d7,%d0
	addl	%d0,%d0
	movel	%d0,%d1
	addl	%d1,%d1
	addl	%d1,%d0
	moveal	%a0@(8,%d0:l),%a1
	jsr	%a1@

.L1000697c:
	movew	%d7,%d0
	addqw	#1,%d7
	moveal	%fp@(-4),%a0
	cmpw	%a0@(4),%d7
	blts	.L10006950
	moveal	%a0@,%a1
	jsr	%a1@
	clrw	%d7

.L10006990:
	extl	%d7
	moveal	%fp@(-4),%a0
	movel	%d7,%d0
	addl	%d0,%d0
	movel	%d0,%d1
	addl	%d1,%d1
	addl	%d1,%d0
	tstb	%a0@(6,%d0:l)
	bnes	.L100069bc
	extl	%d7
	moveal	%fp@(-4),%a0
	movel	%d7,%d0
	addl	%d0,%d0
	movel	%d0,%d1
	addl	%d1,%d1
	addl	%d1,%d0
	moveal	%a0@(8,%d0:l),%a1
	jsr	%a1@

.L100069bc:
	movew	%d7,%d0
	addqw	#1,%d7
	moveal	%fp@(-4),%a0
	cmpw	%a0@(4),%d7
	blts	.L10006990

.L100069ca:
	movel	%fp@(-8),%d7
	unlk	%fp
	rts

sub_100069d2:
	linkw	%fp,#0
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveq	#18,%d0
	_NewPtrSysClear
	moveal	%a0,%a4
	movel	%a4,%d0
	beqw	.L10006a9c
	subql	#2,%sp
	movel	#1633968754,%sp@-
	movel	%a4,%sp@-
	movew	#1025,%d0
	_GestaltValueDispatch
	movew	%sp@+,%d6
	bnew	.L10006a9c
	jsr	%pc@(sub_100068ee)
	tstb	%d0
	beqs	.L10006a50
	jsr	%pc@(sub_10006aa6)
	lea	%pc@(sub_100070e6),%a0
	lea	%pc@(sub_10006aa6),%a1
	movel	%a0,%d7
	subl	%a1,%d7
	movel	%d7,%d0
	_NewPtrSys
	moveal	%a0,%a3
	movel	%a3,%d0
	beqs	.L10006a50
	lea	%pc@(sub_10006aa6),%a0
	moveal	%a3,%a1
	movel	%d7,%d0
	_BlockMove
	movew	%a4@(4),%d0
	extl	%d0
	addl	%d0,%d0
	movel	%d0,%d1
	addl	%d1,%d1
	addl	%d1,%d0
	movel	%a3,%a4@(8,%d0:l)
	movew	%a4@(4),%d0
	extl	%d0
	addl	%d0,%d0
	movel	%d0,%d1
	addl	%d1,%d1
	addl	%d1,%d0
	clrb	%a4@(6,%d0:l)
	addqw	#1,%a4@(4)

.L10006a50:
	tstw	%a4@(4)
	beqs	.L10006a88
	movew	#ADBReInit,%d0
	_GetOSTrapAddress
	movel	%a0,%a4@
	lea	%pc@(sub_100069d2),%a0
	lea	%pc@(sub_10006928),%a1
	movel	%a0,%d7
	subl	%a1,%d7
	movel	%d7,%d0
	_NewPtrSys
	moveal	%a0,%a3
	movel	%a3,%d0
	beqs	.L10006a9c
	lea	%pc@(sub_10006928),%a0
	moveal	%a3,%a1
	movel	%d7,%d0
	_BlockMove
	moveal	%a3,%a0
	movew	#ADBReInit,%d0
	_SetOSTrapAddress
	bras	.L10006a9c

.L10006a88:
	moveal	%a4,%a0
	_DisposePtr
	subql	#2,%sp
	movel	#1633968754,%sp@-
	movew	#515,%d0
	_GestaltValueDispatch
	movew	%sp@+,%d6

.L10006a9c:
	moveml	%fp@(-16),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_10006aa6:
	linkw	%fp,#-60
	moveml	%d5-%d7/%a4,%sp@-
	lea	%fp@(-50),%a4
	_CountADBs
	movew	%d0,%d6
	clrw	%fp@(-34)
	clrw	%d7

.L10006abc:
	extl	%d7
	movel	%d7,%d0
	addl	%d0,%d0
	clrb	%fp@(-32,%d0:l)
	extl	%d7
	movel	%d7,%d0
	addl	%d0,%d0
	clrb	%fp@(-31,%d0:l)
	movew	%d7,%d0
	addqw	#1,%d7
	cmpiw	#16,%d7
	blts	.L10006abc

.L10006ada:
	lea	%fp@(-60),%a0
	movew	%d6,%d0
	_GetIndADB
	moveb	%d0,%d5
	moveq	#0,%d0
	moveb	%fp@(-60),%d0
	cmpiw	#192,%d0
	bnes	.L10006b10
	movew	%fp@(-34),%d0
	extl	%d0
	addl	%d0,%d0
	moveb	%d5,%fp@(-32,%d0:l)
	movew	%fp@(-34),%d0
	extl	%d0
	addl	%d0,%d0
	clrb	%fp@(-31,%d0:l)
	movew	%fp@(-34),%d0
	addqw	#1,%fp@(-34)

.L10006b10:
	subqw	#1,%d6
	tstw	%d6
	bnes	.L10006ada
	clrw	%d5
	tstw	%fp@(-34)
	beqs	.L10006b5e
	movel	%a4,%sp@-
	jsr	%pc@(sub_10006b68)
	clrw	%d7
	addqw	#4,%sp

.L10006b28:
	movel	%a4,%sp@-
	extl	%d7
	movel	%d7,%sp@-
	pea	%fp@(-34)
	jsr	%pc@(sub_10006fa2)
	lea	%sp@(12),%sp
	extl	%d7
	movel	%d7,%d0
	addl	%d0,%d0
	moveq	#0,%d1
	moveb	%fp@(-31,%d0:l),%d1
	cmpib	#16,%d1
	bccs	.L10006b50
	tstb	%a4@
	bnes	.L10006b28

.L10006b50:
	movew	%d7,%d0
	addqw	#1,%d7
	cmpw	%fp@(-34),%d7
	blts	.L10006b28
	jsr	%pc@(sub_10006c78)

.L10006b5e:
	moveml	%fp@(-76),%d5-%d7/%a4
	unlk	%fp
	rts

sub_10006b68:
	linkw	%fp,#0
	moveml	%d5-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	moveal	0xcf8,%a4
	clrb	%a3@
	moveq	#4,%d5

.L10006b7c:
	_CountADBs
	movew	%d0,%d7
	clrb	%d6

.L10006b82:
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	moveq	#0,%d1
	moveb	%a4@(2,%d0:l),%d1
	cmpw	%d5,%d1
	bnes	.L10006ba4
	moveq	#1,%d6

.L10006ba4:
	subqw	#1,%d7
	cmpiw	#-1,%d7
	bles	.L10006bb0
	tstb	%d6
	beqs	.L10006b82

.L10006bb0:
	tstb	%d6
	bnes	.L10006bc2
	moveb	%a3@,%d0
	addqb	#1,%d0
	moveb	%d0,%a3@
	moveq	#0,%d0
	moveb	%a3@,%d0
	moveb	%d5,%a3@(%d0:w)

.L10006bc2:
	movew	%d5,%d0
	addqw	#1,%d5
	cmpiw	#16,%d5
	blts	.L10006b7c
	moveml	%fp@(-20),%d5-%d7/%a3-%a4
	unlk	%fp
	rts

sub_10006bd6:
	linkw	%fp,#0
	moveml	%d4-%d7/%a4,%sp@-
	moveb	%fp@(11),%d5
	moveal	%fp@(12),%a4
	clrb	%d6
	clrb	%d7
	clrb	%d4
	tstb	%d5
	beqs	.L10006c4e
	moveq	#0,%d0
	moveb	%a4@,%d0
	cmpb	%a4@(%d0:w),%d5
	blss	.L10006c06
	addqb	#1,%a4@
	moveq	#0,%d0
	moveb	%a4@,%d0
	moveb	%d5,%a4@(%d0:w)
	bras	.L10006c4e

.L10006c06:
	moveb	%a4@,%d6

.L10006c08:
	moveq	#0,%d0
	moveb	%d6,%d0
	cmpb	%a4@(%d0:w),%d5
	blss	.L10006c44
	moveb	%a4@,%d0
	addqb	#1,%d0
	moveb	%d0,%d7

.L10006c18:
	moveq	#0,%d0
	moveb	%d7,%d0
	subqw	#1,%d0
	moveq	#0,%d1
	moveb	%d7,%d1
	moveb	%a4@(%d0:w),%a4@(%d1:w)
	subqb	#1,%d7
	moveq	#0,%d0
	moveb	%d7,%d0
	moveq	#0,%d1
	moveb	%d6,%d1
	addqw	#1,%d1
	cmpw	%d0,%d1
	bcss	.L10006c18
	addqb	#1,%a4@
	moveq	#0,%d0
	moveb	%d7,%d0
	moveb	%d5,%a4@(%d0:w)
	moveq	#1,%d4

.L10006c44:
	subqb	#1,%d6
	tstb	%d6
	beqs	.L10006c4e
	tstb	%d4
	beqs	.L10006c08

.L10006c4e:
	moveml	%fp@(-20),%d4-%d7/%a4
	unlk	%fp
	rts

sub_10006c58:
	linkw	%fp,#0
	moveal	%fp@(8),%a1
	tstb	%a1@
	beqs	.L10006c72
	subqb	#1,%a1@
	moveq	#0,%d0
	moveb	%a1@,%d0
	addqw	#1,%d0
	moveb	%a1@(%d0:w),%d0
	bras	.L10006c74

.L10006c72:
	moveq	#0,%d0

.L10006c74:
	unlk	%fp
	rts

sub_10006c78:
	linkw	%fp,#-4
	moveml	%d6-%d7/%a4,%sp@-
	clrw	%d7
	moveal	0xcf8,%a4
	clrw	%a4@(334)

.L10006c8a:
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	tstb	%a4@(%d0:l)
	beqs	.L10006ce2
	clrw	%d6
	subql	#4,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	extl	%d7
	movel	%d7,%d1
	movel	%d1,%d2
	muluw	#12,%d1
	swap	%d2
	muluw	#12,%d2
	swap	%d2
	clrw	%d2
	addl	%d2,%d1
	moveq	#0,%d2
	moveb	%a4@(2,%d1:l),%d2
	movew	%d2,%sp@-
	_BitShift
	movel	%sp@+,%d0
	movew	%d0,%d6
	moveq	#0,%d0
	movew	%a4@(334),%d0
	extl	%d6
	movel	%d6,%d1
	orl	%d0,%d1
	movew	%d1,%a4@(334)

.L10006ce2:
	movew	%d7,%d0
	addqw	#1,%d7
	cmpiw	#16,%d7
	blts	.L10006c8a
	movel	#1668637793,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d6
	bnes	.L10006d40
	moveml	%a0-%a1,%sp@-
	linkw	%fp,#-20
	moveal	0xcf8,%a1
	moveb	#1,%fp@(-20)
	moveb	#25,%fp@(-19)
	movew	%a1@(334),%fp@(-18)
	movew	#2,%fp@(-14)
	clrl	%fp@(-12)
	clrw	%fp@(-8)
	clrw	%fp@(-6)
	clrl	%fp@(-4)
	lea	%fp@(-20),%a0
	_Egret
	unlk	%fp
	moveml	%sp@+,%a0-%a1

.L10006d40:
	moveml	%fp@(-16),%d6-%d7/%a4
	unlk	%fp
	rts

sub_10006d4a:
	linkw	%fp,#0
	moveml	%d4-%d7/%a4,%sp@-
	moveb	%fp@(15),%d4
	_CountADBs
	movew	%d0,%d7
	clrw	%d6
	clrb	%d5
	moveal	0xcf8,%a4
	tstb	%fp@(11)
	beqw	.L10006dfe

.L10006d6a:
	extl	%d6
	movel	%d6,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	cmpb	%a4@(2,%d0:l),%d4
	bnes	.L10006df2
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	moveb	%fp@(19),%a4@(2,%d0:l)
	extl	%d6
	movel	%d6,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	extl	%d7
	movel	%d7,%d1
	movel	%d1,%d2
	muluw	#12,%d1
	swap	%d2
	muluw	#12,%d2
	swap	%d2
	clrw	%d2
	addl	%d2,%d1
	moveb	%a4@(1,%d0:l),%a4@(1,%d1:l)
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	moveb	#0xc0,%a4@(%d0:l)
	movew	%d7,%d6

.L10006df2:
	movew	%d6,%d0
	addqw	#1,%d6
	cmpw	%d6,%d7
	bgew	.L10006d6a
	bras	.L10006e42

.L10006dfe:
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	cmpb	%a4@(2,%d0:l),%d4
	bnes	.L10006e38
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#12,%d0
	swap	%d1
	muluw	#12,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	moveb	%fp@(19),%a4@(2,%d0:l)
	moveq	#1,%d5

.L10006e38:
	subqw	#1,%d7
	tstw	%d7
	beqs	.L10006e42
	tstb	%d5
	beqs	.L10006dfe

.L10006e42:
	moveml	%fp@(-20),%d4-%d7/%a4
	unlk	%fp
	rts

sub_10006e4c:
	linkw	%fp,#-26
	moveml	%d3-%d7/%a4,%sp@-
	moveb	%fp@(19),%d3
	lea	%fp@(-22),%a4
	clrw	%d4
	clrw	%d4
	clrw	%d6
	moveq	#0,%d7
	moveq	#0,%d0
	movel	%d0,%fp@(-26)
	tstb	%d3
	beqw	.L10006f96
	moveq	#0,%d0
	moveb	%fp@(15),%d0
	moveal	%fp@(8),%a0
	addl	%d0,%d0
	moveq	#0,%d6
	moveb	%a0@(2,%d0:l),%d6
	movew	%d6,%d0
	extl	%d0
	asll	#4,%d0
	movew	%d0,%d6
	.short	0xd07c,0x000f	/* addw #15,%d0 */
	movew	%d0,%d6
	clrb	%a4@
	movel	%a4,%fp@(-12)
	moveq	#0,%d0
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	pea	%fp@(-12)
	movew	%d6,%sp@-
	movew	%sp@+,%d0
	moveal	%sp@+,%a0
	_ADBOp
	movew	%d0,%sp@
	movew	%sp@+,%d4
	subql	#4,%sp
	_TickCount
	movel	%sp@+,%d7

.L10006eb8:
	tstb	%a4@
	bnes	.L10006ec8
	subql	#4,%sp
	_TickCount
	movel	%d7,%d0
	addql	#2,%d0
	cmpl	%sp@+,%d0
	bhis	.L10006eb8

.L10006ec8:
	tstb	%a4@
	beqw	.L10006f92
	moveaw	#1,%a0
	lea	%fp@(-26),%a1
	_Delay
	movel	%d0,%a1@
	moveb	#2,%a4@
	moveq	#0,%d0
	moveb	%a4@(1),%d0
	movew	#240,%d1
	andb	%d0,%d1
	moveb	%d1,%a4@(1)
	moveb	%d3,%d0
	addb	%a4@(1),%d0
	moveb	%d0,%a4@(1)
	moveb	#0xfe,%a4@(2)
	movew	%d6,%d0
	subqw	#4,%d0
	movew	%d0,%d6
	movel	%a4,%fp@(-12)
	moveq	#0,%d0
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	pea	%fp@(-12)
	movew	%d6,%sp@-
	movew	%sp@+,%d0
	moveal	%sp@+,%a0
	_ADBOp
	movew	%d0,%sp@
	movew	%sp@+,%d4
	clrw	%d5

.L10006f26:
	moveaw	#1,%a0
	lea	%fp@(-26),%a1
	_Delay
	movel	%d0,%a1@
	clrb	%a4@
	moveq	#0,%d6
	moveb	%d3,%d6
	movew	%d6,%d0
	extl	%d0
	asll	#4,%d0
	movew	%d0,%d6
	.short	0xd07c,0x000f	/* addw #15,%d0 */
	movew	%d0,%d6
	movel	%a4,%fp@(-12)
	moveq	#0,%d0
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	pea	%fp@(-12)
	movew	%d6,%sp@-
	movew	%sp@+,%d0
	moveal	%sp@+,%a0
	_ADBOp
	movew	%d0,%sp@
	movew	%sp@+,%d4
	subql	#4,%sp
	_TickCount
	movel	%sp@+,%d7

.L10006f6c:
	tstb	%a4@
	bnes	.L10006f7c
	subql	#4,%sp
	_TickCount
	movel	%d7,%d0
	addql	#2,%d0
	cmpl	%sp@+,%d0
	bhis	.L10006f6c

.L10006f7c:
	tstb	%a4@
	beqs	.L10006f84
	moveq	#1,%d0
	bras	.L10006f98

.L10006f84:
	movew	%d5,%d0
	addqw	#1,%d5
	cmpiw	#4,%d5
	bnes	.L10006f26
	moveq	#0,%d0
	bras	.L10006f98

.L10006f92:
	moveq	#0,%d0
	bras	.L10006f98

.L10006f96:
	moveq	#0,%d0

.L10006f98:
	moveml	%fp@(-50),%d3-%d7/%a4
	unlk	%fp
	rts

sub_10006fa2:
	linkw	%fp,#-28
	moveml	%d3-%d7/%a2-%a4,%sp@-
	moveal	%fp@(16),%a2
	moveb	%fp@(15),%d6
	lea	%fp@(-22),%a3
	moveal	%fp@(8),%a4
	clrw	%d5
	clrw	%d3
	clrw	%d5
	moveq	#0,%d7
	moveq	#0,%d0
	movel	%d0,%fp@(-26)
	movel	%a2,%sp@-
	jsr	%pc@(sub_10006c58)
	moveb	%d0,%d4
	moveq	#0,%d0
	moveb	%d4,%d0
	movel	%d0,%sp@-
	moveq	#0,%d0
	moveb	%d6,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_10006e4c)
	tstb	%d0
	lea	%sp@(16),%sp
	beqw	.L100070dc
	moveaw	#1,%a0
	lea	%fp@(-26),%a1
	_Delay
	movel	%d0,%a1@
	moveq	#0,%d0
	moveb	%d6,%d0
	addl	%d0,%d0
	moveq	#0,%d5
	moveb	%a4@(2,%d0:l),%d5
	movew	%d5,%d0
	extl	%d0
	asll	#4,%d0
	movew	%d0,%d5
	.short	0xd07c,0x000f	/* addw #15,%d0 */
	movew	%d0,%d5
	clrb	%a3@
	movel	%a3,%fp@(-12)
	moveq	#0,%d0
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	pea	%fp@(-12)
	movew	%d5,%sp@-
	movew	%sp@+,%d0
	moveal	%sp@+,%a0
	_ADBOp
	movew	%d0,%sp@
	movew	%sp@+,%d3
	subql	#4,%sp
	_TickCount
	movel	%sp@+,%d7

.L1000703a:
	tstb	%a3@
	bnes	.L1000704a
	subql	#4,%sp
	_TickCount
	movel	%d7,%d0
	addql	#2,%d0
	cmpl	%sp@+,%d0
	bhis	.L1000703a

.L1000704a:
	tstb	%a3@
	beqs	.L10007090
	moveq	#0,%d0
	moveb	%d4,%d0
	movel	%d0,%sp@-
	moveq	#0,%d0
	moveb	%d6,%d0
	addl	%d0,%d0
	moveq	#0,%d1
	moveb	%a4@(2,%d0:l),%d1
	movel	%d1,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_10006d4a)
	movew	%a4@,%d0
	extl	%d0
	addl	%d0,%d0
	moveb	%d4,%a4@(2,%d0:l)
	movew	%a4@,%d0
	extl	%d0
	addl	%d0,%d0
	clrb	%a4@(3,%d0:l)
	moveq	#0,%d0
	moveb	%d6,%d0
	addl	%d0,%d0
	clrb	%a4@(3,%d0:l)
	addqw	#1,%a4@
	lea	%sp@(12),%sp
	bras	.L100070dc

.L10007090:
	moveq	#0,%d0
	moveb	%d4,%d0
	movel	%d0,%sp@-
	moveq	#0,%d0
	moveb	%d6,%d0
	addl	%d0,%d0
	moveq	#0,%d1
	moveb	%a4@(2,%d0:l),%d1
	movel	%d1,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_10006d4a)
	movel	%a2,%sp@-
	moveq	#0,%d0
	moveb	%d6,%d0
	addl	%d0,%d0
	moveq	#0,%d1
	moveb	%a4@(2,%d0:l),%d1
	movel	%d1,%sp@-
	jsr	%pc@(sub_10006bd6)
	moveq	#0,%d0
	moveb	%d6,%d0
	addl	%d0,%d0
	moveb	%d4,%a4@(2,%d0:l)
	moveq	#0,%d0
	moveb	%d6,%d0
	addl	%d0,%d0
	moveb	%a4@(3,%d0:l),%d1
	addqb	#1,%a4@(3,%d0:l)
	lea	%sp@(20),%sp

.L100070dc:
	moveml	%fp@(-60),%d3-%d7/%a2-%a4
	unlk	%fp
	rts

sub_100070e6:
	linkw	%fp,#0
	unlk	%fp
	rts

sub_100070ee:
	linkw	%fp,#-8
	moveml	%d3/%d6-%d7/%a3-%a4,%sp@-
	moveq	#48,%d7
	movew	0x154,%d6
	moveq	#0,%d0
	movew	%d6,%d0
	cmpl	%d0,%d7
	blss	.L10007180
	moveal	0x146,%a3
	moveq	#0,%d0
	moveal	%d0,%a4
	moveal	0x14c,%a4
	movew	#-1,0x14a
	movew	%d7,%d0
	_InitEvents
	bras	.L1000715e

.L1000711c:
	moveq	#0,%d0
	movew	%a4@(6),%d0
	moveq	#-1,%d1
	cmpl	%d0,%d1
	beqs	.L1000715c
	moveaw	%a4@(6),%a0
	movel	%a4@(8),%d0
	lea	%fp@(-4),%a1
	_PostEvent
	movel	%a0,%a1@
	tstl	%fp@(-4)
	beqs	.L1000715c
	moveal	%fp@(-4),%a0
	movel	%a4@(12),%a0@(12)
	moveal	%fp@(-4),%a0
	movel	%a4@(16),%a0@(16)
	moveal	%fp@(-4),%a0
	movew	%a4@(20),%a0@(20)

.L1000715c:
	moveal	%a4@,%a4

.L1000715e:
	movel	%a4,%d0
	bnes	.L1000711c
	movel	%a3,%d0
	beqs	.L10007180
	moveal	%a3,%a0
	_PtrZone
	movel	%a0,%fp@(-8)
	subql	#4,%sp
	movel	0x2a6,%sp@
	movel	%fp@(-8),%d0
	cmpl	%sp@+,%d0
	bnes	.L10007180
	moveal	%a3,%a0
	_DisposePtr

.L10007180:
	moveml	%fp@(-28),%d3/%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000718a:
	linkw	%fp,#0
	moveml	%d3/%d7/%a3-%a4,%sp@-
	moveq	#1,%d7
	moveq	#0,%d0
	moveal	%d0,%a4
	subql	#4,%sp
	movel	#2019716975,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L100071d2
	tstl	%a4@
	beqs	.L100071d2
	subql	#4,%sp
	movel	#854,%sp@
	moveal	%sp@+,%a4
	moveal	%a4@(2),%a3
	moveq	#0,%d3
	movel	%a3,%d0
	beqs	.L100071d0
	movew	#128,%d0
	andw	%a3@(18),%d0
	beqs	.L100071d0
	moveq	#1,%d3

.L100071d0:
	moveb	%d3,%d7

.L100071d2:
	tstb	%d7
	bnes	.L100071e0
	_SysError 118

	movew	#2,%sp@-
	_ShutDown

.L100071e0:
	moveml	%fp@(-16),%d3/%d7/%a3-%a4
	unlk	%fp
	rts

sub_100071ea:
	linkw	%fp,#-4
	moveml	%d7/%a4,%sp@-
	subql	#4,%sp
	movel	#2019716975,%sp@-
	moveq	#2,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10007250
	movel	%a4,%sp@-
	_ReleaseResource
	subql	#4,%sp
	movel	#1835823725,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10007250
	tstl	%a4@
	beqs	.L10007250
	movel	#1918987552,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	bnes	.L1000724c
	moveal	%a4@,%a0
	movel	%fp@(-4),%d0
	cmpl	%a0@,%d0
	bges	.L1000724c
	movew	0xb20,%d7
	andiw	#-8193,%d7
	movew	%d7,0xb20

.L1000724c:
	movel	%a4,%sp@-
	_ReleaseResource

.L10007250:
	moveml	%fp@(-12),%d7/%a4
	unlk	%fp
	rts

sub_1000725a:
	linkw	%fp,#-298
	moveml	%d6-%d7/%a2-%a4,%sp@-
	moveal	%fp@(8),%a2
	lea	%fp@(-294),%a4
	lea	%pc@(str_100073aa),%a0
	lea	%a4@,%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveb	%a0@,%a1@
	clrw	%fp@(-262)
	moveq	#1,%d6
	subql	#2,%sp
	movel	%a2,%sp@-
	movel	%a4,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	jsr	%pc@(sub_10003162)
	tstb	%sp@+
	beqw	.L1000739a
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1835098995,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	tstw	%sp@+
	bnew	.L1000739a
	moveq	#0,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	%a2,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d7
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	cmpiw	#-1,%d7
	beqw	.L1000739a
	subql	#4,%sp
	movel	#1836606055,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqw	.L10007396
	subql	#4,%sp
	movel	%a3,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%a4@(1)
	moveq	#0,%d1
	moveb	%a4@,%d1
	movel	%d1,%sp@-
	moveq	#0,%d1
	movel	%d1,%sp@-
	movel	%d1,%sp@-
	_Munger
	tstl	%sp@+
	bltw	.L10007396
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqs	.L10007396
	moveal	%a3@,%a0
	movel	%a0@,%fp@(-298)
	cmpil	#106184711,%fp@(-298)
	bccs	.L10007396
	clrb	%d6
	pea	%fp@(-262)
	movew	#-20601,%sp@-
	moveq	#2,%d0
	movew	%d0,%sp@-
	jsr	%pc@(sub_100032b4)
	moveq	#0,%d0
	moveb	%fp@(-262),%d0
	tstl	%d0
	beqs	.L10007396
	moveq	#0,%d0
	moveb	%a4@,%d0
	moveq	#0,%d1
	moveb	%fp@(-262),%d1
	addw	%d0,%d1
	cmpiw	#32,%d1
	bges	.L10007396
	lea	%fp@(-261),%a0
	moveq	#0,%d0
	moveb	%a4@,%d0
	addqw	#1,%d0
	lea	%a4@(%d0:w),%a1
	moveq	#0,%d0
	moveb	%fp@(-262),%d0
	_BlockMoveData
	moveb	%fp@(-262),%d0
	addb	%d0,%a4@
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	%a2,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_10003328)
	addqw	#2,%sp

.L10007396:
	movew	%d7,%sp@-
	_CloseResFile

.L1000739a:
	moveb	%d6,%fp@(12)
	moveml	%fp@(-318),%d6-%d7/%a2-%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

str_100073aa:
	.byte	0x07
	.string	"MacsBug"
	.align	2

sub_100073b4:
	linkw	%fp,#-264
	moveml	%d7/%a3-%a4,%sp@-
	lea	%fp@(-264),%a3
	_GetZone
	moveal	%a0,%a4
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#2,%sp
	pea	%pc@(str_10007412)
	movel	#1886875747,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-8)
	pea	%fp@(-4)
	movel	%a3,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10007400
	subql	#2,%sp
	pea	%fp@(-8)
	movew	#4,%sp@-
	_CodeFragmentDispatch
	addqw	#2,%sp

.L10007400:
	moveal	%a4,%a0
	_SetZone
	movew	%d7,%fp@(8)
	moveml	%fp@(-276),%d7/%a3-%a4
	unlk	%fp
	rts

str_10007412:
	.byte	0x10
	.string	"ToolboxBootstrap"

sub_10007424:
	linkw	%fp,#-158
	moveml	%d4-%d7/%a2-%a4,%sp@-
	movew	%fp@(8),%d5
	lea	%fp@(-86),%a4
	_GetZone
	movel	%a0,%fp@(-8)
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	movel	#1937339233,%d0
	lea	%fp@(-158),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d6
	bnew	.L10007522
	moveq	#2,%d0
	cmpl	%fp@(-158),%d0
	bnew	.L10007522
	subql	#4,%sp
	movel	#1651733618,%sp@-
	movew	%d5,%sp@-
	_GetResource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqw	.L10007522
	subql	#4,%sp
	movel	#1886413684,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a2
	movel	%a2,%d0
	beqw	.L1000751e
	moveal	%a3,%a0
	_HLock
	moveal	%a2,%a0
	_HLock
	subql	#2,%sp
	movel	%a2@,%sp@-
	subql	#4,%sp
	movel	%a2,%sp@-
	jsr	%pc@(sub_10003106)
	pea	%pc@(str_10007536)
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-18)
	pea	%fp@(-22)
	pea	%fp@(-150)
	movew	#3,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d6
	bnes	.L1000751a
	moveal	%a3@,%a0
	movew	%a0@,%d4
	moveq	#1,%d7
	bras	.L10007508

.L100074c8:
	extl	%d7
	movel	%d7,%sp@-
	movel	%a3,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_10007542)
	subql	#2,%sp
	movel	%fp@(-18),%sp@-
	movel	%a4,%sp@-
	pea	%fp@(-12)
	pea	%fp@(-13)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d6
	lea	%sp@(12),%sp
	bnes	.L10007504
	pea	%fp@(-4)
	extl	%d5
	movel	%d5,%sp@-
	moveal	%fp@(-12),%a0
	jsr	%a0@
	movew	%d0,%d6
	addqw	#8,%sp

.L10007504:
	movew	%d7,%d0
	addqw	#1,%d7

.L10007508:
	cmpw	%d7,%d4
	bges	.L100074c8
	subql	#2,%sp
	pea	%fp@(-18)
	movew	#4,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d6

.L1000751a:
	movel	%a2,%sp@-
	_ReleaseResource

.L1000751e:
	movel	%a3,%sp@-
	_ReleaseResource

.L10007522:
	moveal	%fp@(-8),%a0
	_SetZone
	moveml	%fp@(-186),%d4-%d7/%a2-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	addqw	#2,%sp
	jmp	%a0@

str_10007536:
	.byte	0x0a
	.ascii	"PPCTidbits"
	.byte	0x00

sub_10007542:
	linkw	%fp,#0
	moveml	%d7/%a2-%a4,%sp@-
	moveal	%fp@(12),%a2
	moveal	%fp@(8),%a3
	movew	%fp@(18),%d7
	subqw	#1,%d7
	movel	%a2,%d0
	beqs	.L1000758e
	tstl	%a2@
	beqs	.L1000758e
	movel	%a3,%d0
	beqs	.L1000758e
	moveal	%a2@,%a4
	addqw	#2,%a4
	bras	.L10007572

.L1000756a:
	moveq	#0,%d0
	moveb	%a4@,%d0
	addqw	#1,%d0
	addaw	%d0,%a4

.L10007572:
	movew	%d7,%d0
	subqw	#1,%d7
	tstw	%d0
	bnes	.L1000756a
	movel	%a4,%d0
	addql	#1,%d0
	moveal	%d0,%a0
	movel	%a3,%d0
	addql	#1,%d0
	moveal	%d0,%a1
	moveq	#0,%d0
	moveb	%a4@,%d0
	_BlockMoveData
	moveb	%a4@,%a3@

.L1000758e:
	moveml	%fp@(-16),%d7/%a2-%a4
	unlk	%fp
	rts

sub_10007598:
	linkw	%fp,#-88
	moveml	%d6-%d7/%a4,%sp@-
	lea	%fp@(-8),%a4
	moveq	#0,%d0
	movel	%d0,%a4@(4)
	movel	#1634956656,%a4@
	movel	#1667658343,%d0
	lea	%fp@(-12),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L1000762a
	moveq	#1,%d0
	andl	%fp@(-12),%d0
	beqs	.L1000762a
	moveq	#0,%d6

.L100075ce:
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	%d6,%d0
	aslw	#2,%d0
	movel	%a4@(%d0:w),%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-18)
	pea	%fp@(-16)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d7
	bnes	.L1000761c
	subql	#2,%sp
	movew	%fp@(-18),%sp@-
	movel	%fp@(-16),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-88)
	moveq	#1,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnes	.L1000761c
	subql	#2,%sp
	pea	%fp@(-88)
	moveq	#0,%d0
	moveb	%d0,%sp@-
	movew	#-20,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7

.L1000761c:
	movel	%d6,%d0
	addql	#1,%d6
	movel	%d6,%d0
	aslw	#2,%d0
	tstl	%a4@(%d0:w)
	bnes	.L100075ce

.L1000762a:
	moveml	%fp@(-100),%d6-%d7/%a4
	unlk	%fp
	rts

sub_10007634:
	linkw	%fp,#-574
	moveml	%a2-%a4,%sp@-
	moveq	#0,%d0
	movel	%d0,%fp@(-570)
	moveal	%d0,%a4
	moveal	%d0,%a3
	_GetZone
	moveal	%a0,%a2
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#2,%sp
	pea	%pc@(str_100077d0)
	movel	#1886875747,%sp@-
	moveq	#5,%d0
	movel	%d0,%sp@-
	pea	%fp@(-570)
	pea	%fp@(-566)
	pea	%fp@(-562)
	movew	#1,%sp@-
	_CodeFragmentDispatch
	tstw	%sp@+
	bnew	.L1000775a
	subql	#2,%sp
	movel	%fp@(-570),%sp@-
	pea	%pc@(str_100077be)
	pea	%fp@(-304)
	pea	%fp@(-305)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	tstw	%sp@+
	bnew	.L1000775a
	subql	#4,%sp
	movel	%fp@(-304),%sp@-
	pea	0x3f1
	moveq	#1,%d0
	moveb	%d0,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqw	.L1000775a
	subql	#2,%sp
	movel	%fp@(-570),%sp@-
	pea	%pc@(str_100077b2)
	pea	%fp@(-300)
	pea	%fp@(-305)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	tstw	%sp@+
	bnew	.L1000775a
	subql	#4,%sp
	movel	%fp@(-300),%sp@-
	pea	0x3f1
	moveq	#1,%d0
	moveb	%d0,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqs	.L1000775a
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%pc@(str_100077aa)
	moveal	%a4,%a0
	jsr	%a0@
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%pc@(str_100077a2)
	moveal	%a4,%a0
	jsr	%a0@
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%pc@(str_1000779c)
	moveal	%a4,%a0
	jsr	%a0@
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%pc@(str_10007796)
	moveal	%a4,%a0
	jsr	%a0@
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%pc@(str_10007790)
	moveal	%a4,%a0
	jsr	%a0@
	pea	%pc@(str_10007780)
	pea	%fp@(-296)
	moveal	%a3,%a0
	jsr	%a0@
	tstl	%d0
	lea	%sp@(48),%sp
	beqs	.L1000775a
	pea	%pc@(str_10007786)
	pea	%fp@(-236)
	jsr	%pc@(sub_100033f8)
	tstl	%d0
	addqw	#8,%sp
	beqs	.L1000775a
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%pc@(str_10007780)
	moveal	%a4,%a0
	jsr	%a0@
	addqw	#8,%sp

.L1000775a:
	tstl	%fp@(-570)
	beqs	.L1000776e
	subql	#2,%sp
	pea	%fp@(-570)
	movew	#4,%sp@-
	_CodeFragmentDispatch
	addqw	#2,%sp

.L1000776e:
	movel	%a4,%d0
	movel	%a3,%d0
	moveal	%a2,%a0
	_SetZone
	moveml	%fp@(-586),%a2-%a4
	unlk	%fp
	rts

str_10007780:
	.string	"enet0"

str_10007786:
	.string	"blueshim"
	.align	2

str_10007790:
	.string	"ltlkB"

str_10007796:
	.string	"ltlkA"

str_1000779c:
	.string	"ltlk"
	.align	2

str_100077a2:
	.string	"serialB"

str_100077aa:
	.string	"serialA"

str_100077b2:
	.byte	0x0a
	.string	"OTFindPort"

str_100077be:
	.byte	0x10
	.string	"OTUnregisterPort"

str_100077d0:
	.byte	0x0f
	.string	"OTClientUtilLib"
	.align	2

sub_100077e2:
	linkw	%fp,#0
	movel	%a4,%sp@-
	subql	#4,%sp
	movel	%fp@(8),%sp@-
	movew	%fp@(14),%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10007802
	movel	%a4,%sp@-
	_RemoveResource
	moveal	%a4,%a0
	_DisposeHandle

.L10007802:
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_1000780a:
	braw	sub_10008c54

sub_1000780e:
	linkw	%fp,#-8
	moveml	%d5-%d7,%sp@-
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d5
	movew	%fp@(10),%sp@-
	_UseResFile
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	movel	%sp@+,%fp@(-8)
	bnes	.L1000783e
	movew	#-192,%d7
	braw	.L100078fa

.L1000783e:
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#2,%d0
	movew	%d0,%sp@-
	_Get1Resource
	movel	%sp@+,%fp@(-4)
	subql	#2,%sp
	pea	%fp@(-8)
	jsr	%pc@(sub_1000329e)
	movew	%sp@+,%d7
	bnew	.L100078fa
	tstl	%fp@(-4)
	beqs	.L1000787a
	subql	#2,%sp
	pea	%fp@(-4)
	jsr	%pc@(sub_1000329e)
	tstw	%sp@+
	beqs	.L1000787a
	moveq	#0,%d0
	movel	%d0,%fp@(-4)

.L1000787a:
	subql	#2,%sp
	movel	%fp@(12),%sp@-
	moveq	#3,%d0
	moveb	%d0,%sp@-
	moveq	#13,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d6
	cmpiw	#-1,%d6
	bnes	.L10007894
	moveq	#-43,%d7
	bras	.L100078fa

.L10007894:
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	#1986359923,%sp@-
	jsr	%pc@(sub_100077e2)
	moveq	#2,%d0
	movel	%d0,%sp@-
	movel	#1986359923,%sp@-
	jsr	%pc@(sub_100077e2)
	movel	%fp@(-8),%sp@-
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	pea	%pc@(word_1000790a)
	_AddResource
	subql	#2,%sp
	_ResError
	movew	%sp@+,%d7
	lea	%sp@(16),%sp
	tstw	%d7
	bnes	.L100078f6
	tstl	%fp@(-4)
	beqs	.L100078ec
	movel	%fp@(-4),%sp@-
	movel	#1986359923,%sp@-
	moveq	#2,%d0
	movew	%d0,%sp@-
	pea	%pc@(word_1000790a)
	_AddResource

.L100078ec:
	movew	%d6,%sp@-
	_UpdateResFile
	subql	#2,%sp
	_ResError
	movew	%sp@+,%d7

.L100078f6:
	movew	%d6,%sp@-
	_CloseResFile

.L100078fa:
	movew	%d5,%sp@-
	_UseResFile
	movew	%d7,%d0
	moveml	%fp@(-20),%d5-%d7
	unlk	%fp
	rts

word_1000790a:
	.short	0x0000

sub_1000790c:
	braw	sub_1000c80e

sub_10007910:
	braw	sub_100089ea

sub_10007914:
	braw	sub_10009a38

sub_10007918:
	linkw	%fp,#-8
	moveml	%d3-%d7/%a2-%a4,%sp@-
	clrb	%d5
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%fp@(-4)
	moveq	#0,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	subql	#2,%sp
	movel	%fp@(8),%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	moveq	#13,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	cmpiw	#-1,%d7
	beqs	.L100079c6
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a2
	movel	%a2,%d0
	beqs	.L100079bc
	moveal	%a2@,%a0
	movew	%a0@,%d3
	subql	#4,%sp
	movel	#2054388082,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L100079b8
	subql	#2,%sp
	movel	%a4,%sp@-
	_HomeResFile
	movew	%sp@+,%d6
	cmpiw	#-1,%d7
	beqs	.L100079b4
	tstw	%d6
	bnes	.L1000798e
	movew	SysMap,%d6

.L1000798e:
	movew	%d6,%sp@-
	_UseResFile
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqs	.L100079b4
	moveal	%a3@,%a0
	movew	%a0@,%d4
	cmpw	%d4,%d3
	bnes	.L100079b0
	moveq	#1,%d5

.L100079b0:
	movel	%a3,%sp@-
	_ReleaseResource

.L100079b4:
	movel	%a4,%sp@-
	_ReleaseResource

.L100079b8:
	movel	%a2,%sp@-
	_ReleaseResource

.L100079bc:
	movew	%d7,%sp@-
	_CloseResFile
	movew	%fp@(-4),%sp@-
	_UseResFile

.L100079c6:
	moveb	%d5,%d0
	moveml	%fp@(-40),%d3-%d7/%a2-%a4
	unlk	%fp
	rts

sub_100079d2:
	linkw	%fp,#-62
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(12),%a4
	moveal	%a4,%a0
	addql	#6,%a0
	movel	%a0,%fp@(-44)
	clrw	%fp@(-40)
	movew	%fp@(10),%fp@(-38)
	clrw	%fp@(-34)
	lea	%fp@(-62),%a0
	moveq	#8,%d0
	_HFSDispatch
	movew	%d0,%d7
	movew	%fp@(-10),%a4@
	movel	%fp@(-4),%a4@(2)
	movew	%d7,%d0
	moveml	%fp@(-70),%d7/%a4
	unlk	%fp
	rts

sub_10007a14:
	linkw	%fp,#-98
	moveml	%d3-%d7/%a2-%a4,%sp@-
	moveal	%fp@(8),%a2
	subql	#4,%sp
	movel	#2054388082,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	bnes	.L10007a3c
	movew	#-192,%d7
	braw	.L10007bce

.L10007a3c:
	moveal	%a3@,%a0
	movel	%a0@,%d3
	movel	%a0@(4),%d4
	subql	#2,%sp
	movel	%a3,%sp@-
	_HomeResFile
	movew	%sp@+,%d5
	cmpiw	#-1,%d5
	bnes	.L10007a5a
	movew	#-192,%d7
	braw	.L10007bca

.L10007a5a:
	tstw	%d5
	bnes	.L10007a62
	movew	SysMap,%d5

.L10007a62:
	pea	%fp@(-94)
	extl	%d5
	movel	%d5,%sp@-
	jsr	%pc@(sub_100079d2)
	movew	%d0,%d7
	addqw	#8,%sp
	tstw	%d7
	bnew	.L10007bca
	subql	#2,%sp
	pea	%fp@(-94)
	moveq	#1,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-8)
	moveq	#2,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnew	.L10007bca
	subql	#2,%sp
	movew	%fp@(-8),%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	movel	%d3,%sp@-
	jsr	%pc@(sub_10003224)
	movew	%sp@+,%d7
	bnew	.L10007bbe
	subql	#2,%sp
	movel	%a2,%sp@-
	movel	#1296122707,%sp@-
	movel	#2054388082,%sp@-
	moveq	#-1,%d0
	movew	%d0,%sp@-
	moveq	#4,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnew	.L10007bbe
	subql	#2,%sp
	movel	%a2,%sp@-
	pea	%fp@(-24)
	moveq	#7,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnew	.L10007bb0
	oriw	#4096,%fp@(-16)
	subql	#2,%sp
	movel	%a2,%sp@-
	pea	%fp@(-24)
	moveq	#8,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnew	.L10007bb0
	subql	#2,%sp
	movel	%a2,%sp@-
	moveq	#3,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	moveq	#3,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnew	.L10007bb0
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	movel	%d4,%sp@-
	jsr	%pc@(sub_10003204)
	movew	%sp@+,%d7
	bnes	.L10007b92
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	moveq	#0,%d1
	movel	%d1,%sp@-
	jsr	%pc@(sub_10003224)
	movew	%sp@+,%d7
	bnes	.L10007b92
	movel	#65536,%d0
	_NewHandle
	moveal	%a0,%a4
	movel	%a4,%d0
	bnes	.L10007b3c
	moveq	#-108,%d7
	bras	.L10007b92

.L10007b3c:
	moveal	%a4,%a0
	_HLock
	movel	#65536,%fp@(-4)
	moveq	#0,%d6
	bras	.L10007b8a

.L10007b4c:
	subql	#2,%sp
	movew	%fp@(-8),%sp@-
	pea	%fp@(-4)
	movel	%a4@,%sp@-
	jsr	%pc@(sub_100031bc)
	movew	%sp@+,%d7
	cmpiw	#-39,%d7
	beqs	.L10007b68
	tstw	%d7
	bnes	.L10007b8e

.L10007b68:
	cmpiw	#-39,%d7
	bnes	.L10007b70
	clrw	%d7

.L10007b70:
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	pea	%fp@(-4)
	movel	%a4@,%sp@-
	jsr	%pc@(sub_100031c0)
	addqw	#2,%sp
	tstw	%d7
	bnes	.L10007b8e
	addl	%fp@(-4),%d6

.L10007b8a:
	cmpl	%d6,%d4
	bhis	.L10007b4c

.L10007b8e:
	moveal	%a4,%a0
	_DisposeHandle

.L10007b92:
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	jsr	%pc@(sub_100031a2)
	tstw	%d7
	addqw	#2,%sp
	bnes	.L10007bb0
	movel	%a2,%sp@-
	extl	%d5
	movel	%d5,%sp@-
	jsr	%pc@(sub_1000780e)
	movew	%d0,%d7
	addqw	#8,%sp

.L10007bb0:
	tstw	%d7
	beqs	.L10007bbe
	subql	#2,%sp
	movel	%a2,%sp@-
	moveq	#6,%d0
	_HighLevelFSDispatch
	addqw	#2,%sp

.L10007bbe:
	subql	#2,%sp
	movew	%fp@(-8),%sp@-
	jsr	%pc@(sub_100031a2)
	addqw	#2,%sp

.L10007bca:
	movel	%a3,%sp@-
	_ReleaseResource

.L10007bce:
	movew	%d7,%d0
	moveml	%fp@(-130),%d3-%d7/%a2-%a4
	unlk	%fp
	rts

sub_10007bda:
	braw	sub_1000943a

sub_10007bde:
	linkw	%fp,#-280
	moveml	%d5-%d7/%a3-%a4,%sp@-
	lea	%fp@(-134),%a3
	lea	%fp@(-198),%a4
	clrw	%a4@
	lea	%pc@(str_10007d1a),%a0
	lea	%a3@,%a1
	moveq	#3,%d0

.L10007bf8:
	movel	%a0@+,%a1@+
	dbf	%d0,.L10007bf8
	movew	%a0@+,%a1@+
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1835098995,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-204)
	pea	%fp@(-202)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d7
	bnew	.L10007d0c
	movel	%a4,%sp@-
	movew	#-20601,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	jsr	%pc@(sub_100032b4)
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	bnes	.L10007c46
	moveal	%a3,%a0
	moveal	%a4,%a1
	moveq	#0,%d0
	moveb	%a3@,%d0
	addqw	#1,%d0
	extl	%d0
	_BlockMoveData

.L10007c46:
	clrb	%d5
	subql	#2,%sp
	movew	%fp@(-204),%sp@-
	movel	%fp@(-202),%sp@-
	movel	%a4,%sp@-
	pea	%fp@(-70)
	moveq	#1,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnes	.L10007cd0
	pea	%fp@(-70)
	jsr	%pc@(sub_10007918)
	moveq	#0,%d1
	moveb	%d0,%d1
	tstl	%d1
	addqw	#4,%sp
	bnes	.L10007cd0
	moveq	#1,%d5
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1953657704,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-280)
	pea	%fp@(-278)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d7
	bnes	.L10007cbe
	subql	#2,%sp
	movew	%fp@(-280),%sp@-
	movel	%fp@(-278),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-274)
	moveq	#1,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnes	.L10007cbe
	subql	#2,%sp
	pea	%fp@(-70)
	pea	%fp@(-274)
	moveq	#12,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7

.L10007cbe:
	tstw	%d7
	beqs	.L10007cd0
	subql	#2,%sp
	pea	%fp@(-70)
	moveq	#6,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	bnes	.L10007d0c

.L10007cd0:
	cmpiw	#-43,%d7
	beqs	.L10007cda
	tstb	%d5
	beqs	.L10007cea

.L10007cda:
	pea	%fp@(-70)
	jsr	%pc@(sub_10007a14)
	movew	%d0,%d7
	addqw	#4,%sp
	tstw	%d7
	bnes	.L10007d0c

.L10007cea:
	subql	#2,%sp
	pea	%fp@(-70)
	moveq	#1,%d0
	moveb	%d0,%sp@-
	moveq	#-2,%d0
	_ResourceDispatch
	movew	%sp@+,%d6
	cmpiw	#-1,%d6
	beqs	.L10007d0c
	subql	#2,%sp
	movew	%d6,%sp@-
	moveq	#-3,%d0
	_ResourceDispatch
	addqw	#2,%sp
	bras	.L10007d10

.L10007d0c:
	_SysError 27

.L10007d10:
	moveml	%fp@(-300),%d5-%d7/%a3-%a4
	unlk	%fp
	rts

str_10007d1a:
	.byte	0x10
	.string	"System Resources"

sub_10007d2c:
	linkw	%fp,#-8
	moveml	%d6-%d7,%sp@-
	moveq	#1,%d7
	movel	#1937339254,%d0
	lea	%fp@(-8),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d6
	bnes	.L10007d98
	movel	#1937339253,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d6
	bnes	.L10007d84
	tstl	%fp@(-8)
	bnes	.L10007d6e
	movew	0x15a,%d0
	extl	%d0
	movel	%d0,%fp@(-8)

.L10007d6e:
	pea	%fp@(-4)
	movel	%fp@(-8),%sp@-
	movel	#134147,%d0
	_BlueBoxDispatch
	movel	%d0,%d7
	addqw	#8,%sp
	bras	.L10007d98

.L10007d84:
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%fp@(-8),%sp@-
	movel	#134147,%d0
	_BlueBoxDispatch
	movel	%d0,%d7
	addqw	#8,%sp

.L10007d98:
	cmpil	#-1754,%d7
	bnes	.L10007da4
	moveq	#102,%d0
	_SysError

.L10007da4:
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%d0,%sp@-
	movel	#1919181156,%sp@-
	movel	#202285,%d0
	_BlueBoxDispatch
	lea	%sp@(12),%sp
	moveml	%fp@(-16),%d6-%d7
	unlk	%fp
	rts

sub_10007dc6:
	linkw	%fp,#-8
	movel	%d7,%sp@-
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	pea	%pc@(str_10007e50)
	movel	#1886875747,%sp@-
	moveq	#2,%d0
	movel	%d0,%sp@-
	pea	%fp@(-8)
	moveq	#0,%d1
	movel	%d1,%sp@-
	movel	%d1,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10007e2e
	subql	#2,%sp
	movel	%fp@(-8),%sp@-
	pea	%pc@(str_10007e36)
	pea	%fp@(-4)
	moveq	#0,%d0
	movel	%d0,%sp@-
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10007e2e
	subql	#4,%sp
	moveq	#3,%d0
	moveb	%d0,%sp@-
	moveb	#0x83,%sp@-
	movel	%fp@(-8),%sp@-
	moveq	#0,%d1
	movel	%d1,%sp@-
	moveal	%fp@(-4),%a0
	jsr	%a0@
	movel	%sp@+,%d0
	movew	%d0,%d7

.L10007e2e:
	movel	%fp@(-12),%d7
	unlk	%fp
	rts

str_10007e36:
	.byte	0x18
	.string	"CFragInitializationRDesc"

str_10007e50:
	.byte	0x0f
	.string	"CodeFragmentMgr"
	.align	2

sub_10007e62:
	linkw	%fp,#-270
	moveml	%d7/%a3-%a4,%sp@-
	lea	%fp@(-270),%a3
	subql	#2,%sp
	pea	%pc@(str_10007f02)
	movel	#1886875747,%sp@-
	moveq	#2,%d0
	movel	%d0,%sp@-
	pea	%fp@(-14)
	pea	%fp@(-10)
	movel	%a3,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10007edc
	subql	#2,%sp
	movel	%fp@(-14),%sp@-
	pea	%pc@(str_10007ee8)
	pea	%fp@(-6)
	pea	%fp@(-1)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10007edc
	moveq	#0,%d0
	moveb	%fp@(-1),%d0
	cmpiw	#2,%d0
	bnes	.L10007edc
	subql	#4,%sp
	movel	%fp@(-6),%sp@-
	moveq	#33,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10007edc
	moveal	%a4,%a0
	jsr	%a0@
	movel	%a4,%sp@-
	moveq	#1,%d0
	_MixedModeDispatch

.L10007edc:
	movew	%d7,%d0
	moveml	%fp@(-282),%d7/%a3-%a4
	unlk	%fp
	rts

str_10007ee8:
	.byte	0x18
	.string	"MPSecondaryInitializeAPI"

str_10007f02:
	.byte	0x09
	.string	"MPLibrary"
	.byte	0x00

sub_10007f0e:
	linkw	%fp,#0
	movel	%fp@(8),%d0
	subil	#1718580850,%d0
	beqs	.L10007f4a
	subil	#133429490,%d0
	beqs	.L10007f56
	subil	#588286,%d0
	beqs	.L10007f4e
	subil	#526592,%d0
	beqs	.L10007f52
	subil	#16250624,%d0
	beqs	.L10007f5a
	subil	#66718992,%d0
	bnes	.L10007f5e
	moveq	#8,%d0
	bras	.L10007f60

.L10007f4a:
	moveq	#9,%d0
	bras	.L10007f60

.L10007f4e:
	moveq	#10,%d0
	bras	.L10007f60

.L10007f52:
	moveq	#11,%d0
	bras	.L10007f60

.L10007f56:
	moveq	#12,%d0
	bras	.L10007f60

.L10007f5a:
	moveq	#17,%d0
	bras	.L10007f60

.L10007f5e:
	moveq	#0,%d0

.L10007f60:
	unlk	%fp
	rts

sub_10007f64:
	braw	sub_1000b03c

sub_10007f68:
	braw	sub_100099bc

sub_10007f6c:
	braw	sub_1000c686

sub_10007f70:
	linkw	%fp,#-1274
	moveml	%d3/%d5-%d7/%a3-%a4,%sp@-
	lea	%fp@(-1274),%a3
	movew	#-32768,%fp@(-218)
	movew	#6,%fp@(-220)
	movel	#1718580850,%fp@(-224)
	lea	%pc@(str_10008368),%a0
	lea	%fp@(-288),%a1
	moveq	#4,%d0

.L10007f9a:
	movel	%a0@+,%a1@+
	dbf	%d0,.L10007f9a
	moveb	%a0@,%a1@
	movew	#-32768,%fp@(-290)
	movew	#8,%fp@(-292)
	movel	#1936094834,%fp@(-296)
	lea	%pc@(str_100083d4),%a0
	lea	%fp@(-360),%a1
	moveq	#3,%d0

.L10007fc0:
	movel	%a0@+,%a1@+
	dbf	%d0,.L10007fc0
	movew	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movew	#-32768,%fp@(-362)
	clrw	%fp@(-364)
	movel	#1936094834,%fp@(-368)
	lea	%pc@(str_100083c2),%a0
	lea	%fp@(-432),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movew	#-32768,%fp@(-434)
	movew	#50,%fp@(-436)
	movel	#1718580850,%fp@(-440)
	lea	%pc@(str_1000835a),%a0
	lea	%fp@(-504),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	movew	#-32768,%fp@(-506)
	movew	#1,%fp@(-508)
	movel	#1936094834,%fp@(-512)
	lea	%pc@(str_100083b6),%a0
	lea	%fp@(-576),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movew	#16384,%fp@(-578)
	movew	#2,%fp@(-580)
	movel	#1852598626,%fp@(-584)
	lea	%pc@(str_100083aa),%a0
	lea	%fp@(-648),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movew	#16384,%fp@(-650)
	movew	#3,%fp@(-652)
	movel	#1852598626,%fp@(-656)
	lea	%pc@(str_10008398),%a0
	lea	%fp@(-720),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movew	#-32768,%fp@(-722)
	movew	#51,%fp@(-724)
	movel	#1718580850,%fp@(-728)
	lea	%pc@(str_1000835a),%a0
	lea	%fp@(-792),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	movew	#-32767,%fp@(-794)
	movew	#7,%fp@(-796)
	movel	#1852598626,%fp@(-800)
	lea	%pc@(str_1000838a),%a0
	lea	%fp@(-864),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movew	#-32767,%fp@(-866)
	movew	#-16420,%fp@(-868)
	movel	#1852598626,%fp@(-872)
	lea	%pc@(str_1000837e),%a0
	lea	%fp@(-936),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movew	#16384,%fp@(-938)
	movew	#-16399,%fp@(-940)
	movel	#1852598626,%fp@(-944)
	lea	%pc@(str_10008350),%a0
	lea	%fp@(-1008),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	movew	#-32768,%fp@(-2)
	movew	#6,%fp@(-4)
	movel	#1718580850,%fp@(-8)
	lea	%pc@(str_10008368),%a0
	lea	%fp@(-72),%a1
	moveq	#4,%d0

.L1000812c:
	movel	%a0@+,%a1@+
	dbf	%d0,.L1000812c
	moveb	%a0@,%a1@
	movew	#-32768,%fp@(-74)
	movew	#50,%fp@(-76)
	movel	#1718580850,%fp@(-80)
	lea	%pc@(str_1000835a),%a0
	lea	%fp@(-144),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	movew	#16385,%fp@(-146)
	movew	#-16399,%fp@(-148)
	movel	#1852598626,%fp@(-152)
	lea	%pc@(str_10008350),%a0
	lea	%fp@(-216),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movew	%a0@+,%a1@+
	clrw	%d6
	subql	#2,%sp
	jsr	%pc@(sub_100089ea)
	moveb	%sp@+,%d5
	beqs	.L10008192
	lea	%fp@(-216),%a4
	moveq	#3,%d5
	jsr	%pc@(sub_10007dc6)
	bras	.L10008198

.L10008192:
	lea	%fp@(-1008),%a4
	moveq	#11,%d5

.L10008198:
	clrw	%d7
	braw	.L10008332

.L1000819e:
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	moveq	#0,%d1
	movew	%a4@(0x46,%d0:l),%d1
	tstl	%d1
	btst	#0,%d1
	beqs	.L1000820a
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	moveq	#0,%d1
	movel	%d1,%sp@-
	extl	%d7
	movel	%d7,%d2
	movel	%d2,%d3
	muluw	#72,%d2
	swap	%d3
	muluw	#72,%d3
	swap	%d3
	clrw	%d3
	addl	%d3,%d2
	pea	%a4@(%d2:l)
	moveq	#2,%d0
	movel	%d0,%sp@-
	movel	#1886875747,%sp@-
	pea	%fp@(-1018)
	pea	%fp@(-1014)
	pea	%fp@(-1009)
	movel	%a3,%sp@-
	movew	#-2,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d6
	beqw	.L1000832e

.L1000820a:
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	moveq	#0,%d1
	movew	%a4@(0x46,%d0:l),%d1
	movew	#-32768,%d0
	andw	%d1,%d0
	beqs	.L10008278
	subql	#2,%sp
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	movel	%a4@(0x40,%d0:l),%sp@-
	jsr	%pc@(sub_10007f0e)
	addql	#4,%sp
	movew	%d0,%sp@-
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	movew	%a4@(0x44,%d0:l),%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	jsr	%pc@(sub_1000a740)
	movew	%sp@+,%d6
	bras	.L100082dc

.L10008278:
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	moveq	#0,%d1
	movew	%a4@(0x46,%d0:l),%d1
	movew	#16384,%d0
	andw	%d1,%d0
	beqs	.L100082dc
	subql	#2,%sp
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	movel	%a4@(0x40,%d0:l),%sp@-
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	movew	%a4@(0x44,%d0:l),%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	jsr	%pc@(sub_1000a66e)
	movew	%sp@+,%d6

.L100082dc:
	tstw	%d6
	beqs	.L1000832e
	moveq	#0,%d0
	moveb	0xbff,%d0
	cmpiw	#255,%d0
	beqs	.L10008338
	moveq	#0,%d0
	moveb	0xbff,%d0
	movew	#224,%d1
	andb	%d0,%d1
	moveq	#0,%d0
	moveb	%d1,%d0
	cmpiw	#96,%d0
	bnes	.L10008338
	tstl	0x120
	beqs	.L10008338
	moveq	#-1,%d0
	cmpl	0x120,%d0
	beqs	.L10008338
	extl	%d7
	movel	%d7,%d0
	movel	%d0,%d1
	muluw	#72,%d0
	swap	%d1
	muluw	#72,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	pea	%a4@(%d0:l)
	_DebugStr
	bras	.L10008338

.L1000832e:
	movew	%d7,%d0
	addqw	#1,%d7

.L10008332:
	cmpw	%d7,%d5
	bgtw	.L1000819e

.L10008338:
	tstw	%d6
	bnes	.L10008342
	jsr	%pc@(sub_10007e62)
	movew	%d0,%d6

.L10008342:
	movew	%d6,%fp@(8)
	moveml	%fp@(-1298),%d3/%d5-%d7/%a3-%a4
	unlk	%fp
	rts

str_10008350:
	.short	0x0844,0x6562,0x7567,0x4C69,0x6200

str_1000835a:
	.short	0x0C49,0x6E74,0x6572
	.short	0x6661,0x6365,0x4C69,0x6200

str_10008368:
	.short	0x1350,0x7269,0x7661,0x7465
	.short	0x496E,0x7465,0x7266,0x6163,0x654C,0x6962,0x0000

str_1000837e:
	.short	0x094D
	.short	0x6174,0x6836,0x344C,0x6962,0x0000

str_1000838a:
	.short	0x0B42,0x6F6F,0x7453
	.short	0x7464,0x434C,0x6962,0x0000

str_10008398:
	.short	0x0F4D,0x5053,0x6861,0x7265
	.short	0x6447,0x6C6F,0x6261,0x6C73,0x0000

str_100083aa:
	.short	0x094D,0x504C,0x6962
	.short	0x7261,0x7279,0x0000

str_100083b6:
	.short	0x094D,0x6978,0x6564,0x4D6F,0x6465
	.short	0x0000

str_100083c2:
	.short	0x0F43,0x6F64,0x6546,0x7261,0x676D,0x656E,0x744D
	.short	0x6772,0x0000

str_100083d4:
	.short	0x1150,0x726F,0x6365,0x7373,0x4D67,0x7253
	.short	0x7570,0x706F,0x7274,0x0000

sub_100083e8:
	linkw	%fp,#-264
	moveml	%d7/%a3-%a4,%sp@-
	moveq	#0,%d0
	movel	%d0,%fp@(-260)
	_GetZone
	moveal	%a0,%a3
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#2,%sp
	pea	%pc@(str_10008462)
	movel	#1886875747,%sp@-
	moveq	#2,%d0
	movel	%d0,%sp@-
	pea	%fp@(-264)
	pea	%fp@(-260)
	pea	%fp@(-256)
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	moveal	%a3,%a0
	_SetZone
	tstw	%d7
	bnes	.L10008458
	tstl	%fp@(-260)
	beqs	.L10008458
	subql	#4,%sp
	movel	%fp@(-260),%sp@-
	moveq	#49,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10008458
	moveal	%a4,%a0
	jsr	%a0@
	movel	%a4,%sp@-
	moveq	#1,%d0
	_MixedModeDispatch

.L10008458:
	moveml	%fp@(-276),%d7/%a3-%a4
	unlk	%fp
	rts

str_10008462:
	.byte	0x0e
	.string	"TimeManagerLib"

sub_10008472:
	linkw	%fp,#-296
	moveml	%d7/%a4,%sp@-
	lea	%fp@(-288),%a4
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-12)
	movew	#4,%fp@(-14)
	clrw	%fp@(-16)
	movel	%d0,%fp@(-20)
	clrw	%fp@(-22)
	clrw	%fp@(-24)
	movel	%d0,%fp@(-28)
	clrb	%fp@(-29)
	moveb	#7,%fp@(-30)
	movew	#-21762,%fp@(-32)
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#2,%sp
	pea	%pc@(str_1000850c)
	movel	#1886875747,%sp@-
	pea	0x101
	pea	%fp@(-296)
	pea	%fp@(-292)
	movel	%a4,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L100084fe
	tstl	%fp@(-292)
	beqs	.L100084fe
	moveb	#1,%fp@(-15)
	movel	%fp@(-292),%fp@(-12)
	lea	%fp@(-32),%a0
	jsr	%a0@
	bras	.L10008502

.L100084fe:
	moveq	#15,%d0
	_SysError

.L10008502:
	moveml	%fp@(-304),%d7/%a4
	unlk	%fp
	rts

str_1000850c:
	.short	0x0D50,0x726F
	.short	0x6365,0x7373,0x4D67,0x724C,0x6962,0x0000

sub_1000851c:
	linkw	%fp,#-20
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	moveq	#0,%d0
	movel	%d0,%a4@
	pea	%fp@(-20)
	pea	%pc@(str_10008584)
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#12,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	lea	%sp@(12),%sp
	bnes	.L1000856a
	moveq	#4,%d0
	movel	%d0,%fp@(-4)
	pea	%fp@(-4)
	movel	%a4,%sp@-
	pea	%pc@(str_10008576)
	pea	%fp@(-20)
	moveq	#23,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	pea	%fp@(-20)
	moveq	#3,%d0
	_NameRegistryDispatch
	lea	%sp@(20),%sp

.L1000856a:
	movew	%d7,%d0
	moveml	%fp@(-28),%d7/%a4
	unlk	%fp
	rts

str_10008576:
	.short	0x706F,0x7374,0x2D72,0x6573,0x756C
	.short	0x7473,0x0000

str_10008584:
	.short	0x4465,0x7669,0x6365,0x733A,0x6465,0x7669
	.short	0x6365,0x2D74,0x7265,0x653A,0x6469,0x6167,0x6E6F,0x7374
	.short	0x6963,0x7300

sub_100085a4:
	linkw	%fp,#-24
	moveml	%d6-%d7,%sp@-
	moveq	#0,%d0
	movel	%d0,%fp@(-8)
	moveq	#0,%d7
	moveq	#0,%d6
	movel	%d0,%fp@(-4)
	pea	%fp@(-24)
	moveq	#0,%d0
	_NameRegistryDispatch
	pea	%fp@(-24)
	pea	%pc@(str_10008624)
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#12,%d0
	_NameRegistryDispatch
	movel	%d0,%d7
	lea	%sp@(16),%sp
	bnes	.L10008608
	moveq	#4,%d0
	movel	%d0,%fp@(-8)
	pea	%fp@(-8)
	pea	%fp@(-4)
	pea	%pc@(str_1000861e)
	pea	%fp@(-24)
	moveq	#23,%d0
	_NameRegistryDispatch
	movel	%d0,%d7
	lea	%sp@(16),%sp
	bnes	.L10008608
	cmpil	#1684365668,%fp@(-4)
	bnes	.L10008608
	moveq	#1,%d6

.L10008608:
	pea	%fp@(-24)
	moveq	#3,%d0
	_NameRegistryDispatch
	movel	%d6,%d0
	addqw	#4,%sp
	moveml	%fp@(-32),%d6-%d7
	unlk	%fp
	rts

str_1000861e:
	.string	"state"

str_10008624:
	.string	"Devices:device-tree:cpus:dead"

sub_10008642:
	.short	0x4E56,0x0000,0x48E7,0x1138,0x246E,0x0008,0x266E
	.short	0x000C,0x286E,0x0010,0x7E00,0x4A12,0x6778,0x7600,0x1014
	.short	0xB013,0x6222,0x7000,0x1014,0x7200,0x1233,0x0000,0x0C01
	.short	0x0030,0x6512,0x7000,0x1014,0x7200,0x1233,0x0000,0x0C01
	.short	0x0039,0x6202,0x7601,0x1483,0x6020,0x2207,0xD281,0x2001
	.short	0xE589,0xD280,0x7000,0x1014,0x7400,0x1433,0x0000,0x947C
	.short	0x0030,0x48C2,0xD481,0x2E02,0x5214,0x4A12,0x6726,0x1014
	.short	0xB013,0x6220,0x7000,0x1014,0x7200,0x1233,0x0000,0x0C01
	.short	0x0030,0x6510,0x7000,0x1014,0x7200,0x1233,0x0000,0x0C01
	.short	0x0039,0x63B6,0x2007,0x4CEE,0x1C88,0xFFEC,0x4E5E,0x4E75

sub_100086e0:
	linkw	%fp,#-300
	moveml	%d3-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	lea	%fp@(-286),%a4
	clrb	%fp@(-5)
	movel	#1852990823,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnew	.L100089a8
	movew	#-21527,%d0
	_GetToolTrapAddress
	movel	%a0,%fp@(-300)
	movew	#-22369,%d0
	_GetToolTrapAddress
	movel	%fp@(-300),%d0
	cmpal	%d0,%a0
	beqw	.L100089a8
	pea	%fp@(-22)
	moveq	#0,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	addqw	#4,%sp
	bnew	.L1000899e
	lea	%pc@(str_100089cc),%a0
	movel	%a0,%fp@(-26)
	pea	%fp@(-22)
	movel	%a0,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#12,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	lea	%sp@(12),%sp
	bnew	.L1000899e
	lea	%pc@(str_100089b6),%a0
	movel	%a0,%fp@(-30)
	movel	#255,%fp@(-290)
	pea	%fp@(-290)
	pea	%a4@(1)
	movel	%fp@(-30),%sp@-
	pea	%fp@(-22)
	moveq	#23,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	cmpiw	#-2539,%d7
	lea	%sp@(16),%sp
	bnes	.L10008794
	moveb	#1,%fp@(-5)
	movel	#33554431,%a3@
	braw	.L1000899e

.L10008794:
	tstw	%d7
	bnew	.L1000899e
	tstl	%fp@(-290)
	blsw	.L1000899e
	moveb	#1,%fp@(-295)
	moveq	#0,%d5
	movel	#128,%d7

.L100087b0:
	moveq	#1,%d6
	bras	.L100087bc

.L100087b4:
	movel	%fp@(-290),%d0
	subql	#1,%fp@(-290)

.L100087bc:
	tstl	%fp@(-290)
	blss	.L100087d0
	movew	%fp@(-288),%d0
	moveq	#0,%d1
	moveb	%a4@(%d0:w),%d1
	tstl	%d1
	beqs	.L100087b4

.L100087d0:
	moveb	%fp@(-287),%a4@
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	shi	%d3
	negb	%d3
	moveb	%d3,%fp@(-5)
	pea	%fp@(-295)
	movel	%a4,%sp@-
	pea	%fp@(-5)
	jsr	%pc@(sub_10008642)
	movel	%d0,%fp@(-294)
	tstb	%fp@(-5)
	lea	%sp@(12),%sp
	beqs	.L10008824
	moveb	%fp@(-295),%d0
	cmpb	%a4@,%d0
	bhis	.L10008824
	moveb	%fp@(-295),%d0
	addqb	#1,%fp@(-295)
	moveq	#0,%d1
	moveb	%d0,%d1
	moveq	#0,%d0
	moveb	%a4@(%d1:w),%d0
	cmpiw	#46,%d0
	seq	%d3
	negb	%d3
	moveb	%d3,%fp@(-5)

.L10008824:
	tstb	%fp@(-5)
	beqs	.L10008846
	moveb	%fp@(-295),%d0
	cmpb	%a4@,%d0
	bhis	.L10008846
	pea	%fp@(-295)
	movel	%a4,%sp@-
	pea	%fp@(-5)
	jsr	%pc@(sub_10008642)
	movel	%d0,%d4
	lea	%sp@(12),%sp

.L10008846:
	tstb	%fp@(-5)
	beqs	.L1000887a
	moveq	#0,%d0
	moveb	%fp@(-295),%d0
	moveq	#0,%d1
	moveb	%a4@(%d0:w),%d1
	cmpiw	#46,%d1
	bnes	.L1000887a
	moveb	%fp@(-295),%d0
	addqb	#1,%fp@(-295)
	pea	%fp@(-295)
	movel	%a4,%sp@-
	pea	%fp@(-5)
	jsr	%pc@(sub_10008642)
	movel	%d0,%d5
	lea	%sp@(12),%sp

.L1000887a:
	tstb	%fp@(-5)
	beqw	.L1000899e
	moveb	%fp@(-295),%d0
	cmpb	%a4@,%d0
	bccw	.L1000899e
	moveq	#0,%d0
	moveb	%fp@(-295),%d0
	moveb	%a4@(%d0:w),%d0
	subib	#65,%d0
	beqs	.L100088c4
	subqb	#1,%d0
	beqs	.L100088c8
	subqb	#2,%d0
	beqs	.L100088cc
	subqb	#2,%d0
	beqs	.L100088d0
	subqb	#1,%d0
	beqs	.L100088d8
	subib	#26,%d0
	beqs	.L100088c4
	subqb	#1,%d0
	beqs	.L100088c8
	subqb	#2,%d0
	beqs	.L100088cc
	subqb	#2,%d0
	beqs	.L100088d0
	subqb	#1,%d0
	beqs	.L100088d8
	bras	.L10008922

.L100088c4:
	moveq	#64,%d7
	bras	.L10008926

.L100088c8:
	moveq	#96,%d7
	bras	.L10008926

.L100088cc:
	moveq	#32,%d7
	bras	.L10008926

.L100088d0:
	movel	#128,%d7
	bras	.L10008926

.L100088d8:
	movel	#128,%d7
	bras	.L100088e8

.L100088e0:
	moveb	%fp@(-295),%d0
	addqb	#1,%fp@(-295)

.L100088e8:
	moveb	%fp@(-295),%d0
	cmpb	%a4@,%d0
	bccs	.L10008926
	moveq	#0,%d3
	moveq	#0,%d0
	moveb	%fp@(-295),%d0
	addqw	#1,%d0
	moveq	#0,%d1
	moveb	%a4@(%d0:w),%d1
	cmpib	#48,%d1
	bcss	.L1000891c
	moveq	#0,%d0
	moveb	%fp@(-295),%d0
	addqw	#1,%d0
	moveq	#0,%d1
	moveb	%a4@(%d0:w),%d1
	cmpib	#57,%d1
	bhis	.L1000891c
	moveq	#1,%d3

.L1000891c:
	tstb	%d3
	beqs	.L100088e0
	bras	.L10008926

.L10008922:
	clrb	%fp@(-5)

.L10008926:
	tstb	%fp@(-5)
	beqs	.L10008948
	moveb	%fp@(-295),%d0
	addqb	#1,%fp@(-295)
	pea	%fp@(-295)
	movel	%a4,%sp@-
	pea	%fp@(-5)
	jsr	%pc@(sub_10008642)
	movel	%d0,%d6
	lea	%sp@(12),%sp

.L10008948:
	moveq	#0,%d3
	tstb	%fp@(-5)
	beqs	.L10008970
	cmpil	#256,%fp@(-294)
	bges	.L10008970
	moveq	#16,%d0
	cmpl	%d4,%d0
	bles	.L10008970
	moveq	#16,%d0
	cmpl	%d5,%d0
	bles	.L10008970
	cmpil	#256,%d6
	bges	.L10008970
	moveq	#1,%d3

.L10008970:
	moveb	%d3,%fp@(-5)
	beqs	.L1000899e
	movel	%fp@(-294),%d0
	lslw	#8,%d0
	swap	%d0
	clrw	%d0
	movel	%d4,%d1
	lslw	#4,%d1
	swap	%d1
	clrw	%d1
	orl	%d0,%d1
	movel	%d5,%d0
	swap	%d0
	clrw	%d0
	orl	%d1,%d0
	movel	%d7,%d1
	lsll	#8,%d1
	orl	%d0,%d1
	movel	%d6,%d0
	orl	%d1,%d0
	movel	%d0,%a3@

.L1000899e:
	pea	%fp@(-22)
	moveq	#3,%d0
	_NameRegistryDispatch
	addqw	#4,%sp

.L100089a8:
	moveb	%fp@(-5),%d0
	moveml	%fp@(-328),%d3-%d7/%a3-%a4
	unlk	%fp
	rts

str_100089b6:
	.string	"MacOSROMFile-version"
	.align	2

str_100089cc:
	.string	"Devices:device-tree:rom:macos"

sub_100089ea:
	linkw	%fp,#-4
	movel	#1835098984,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L10008a26
	cmpil	#406,%fp@(-4)
	bnes	.L10008a14
	moveb	#1,%fp@(8)
	bras	.L10008a2a

.L10008a14:
	cmpil	#1206,%fp@(-4)
	bnes	.L10008a26
	moveb	#1,%fp@(8)
	bras	.L10008a2a

.L10008a26:
	clrb	%fp@(8)

.L10008a2a:
	unlk	%fp
	rts

sub_10008a2e:
	linkw	%fp,#-4
	movel	%a4,%sp@-
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	jsr	%pc@(sub_100089ea)
	tstb	%sp@+
	beqs	.L10008a92
	pea	%fp@(-4)
	jsr	%pc@(sub_100086e0)
	tstb	%d0
	addqw	#4,%sp
	beqs	.L10008a92
	tstl	%fp@(-4)
	blss	.L10008a92
	subql	#4,%sp
	movel	#1836217971,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10008a74
	tstl	%a4@
	bnes	.L10008a74
	movel	%a4,%sp@-
	_LoadResource

.L10008a74:
	movel	%a4,%d0
	beqs	.L10008a92
	tstl	%a4@
	beqs	.L10008a92
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L10008a92
	moveal	%a4@,%a0
	movel	%fp@(-4),%d0
	cmpl	%a0@,%d0
	bccs	.L10008a92
	moveq	#120,%d0
	_SysError

.L10008a92:
	moveal	%fp@(-8),%a4
	unlk	%fp
	rts

sub_10008a9a:
	linkw	%fp,#-122
	moveml	%d6-%d7,%sp@-
	movel	%fp@(12),%d7
	movew	%fp@(16),%fp@(-100)
	movel	%fp@(8),%fp@(-104)
	movel	%d7,%fp@(-74)
	clrw	%fp@(-94)
	lea	%fp@(-122),%a0
	_PBHGetFInfoSync
	tstw	%d0
	bnes	.L10008ae4
	movew	%fp@(-82),%d6
	oriw	#12288,%fp@(-82)
	extl	%d6
	moveq	#0,%d0
	movew	%fp@(-82),%d0
	cmpl	%d6,%d0
	beqs	.L10008ae4
	movel	%d7,%fp@(-74)
	lea	%fp@(-122),%a0
	_PBHSetFInfoSync

.L10008ae4:
	moveml	%fp@(-130),%d6-%d7
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(10),%sp
	jmp	%a0@

sub_10008af4:
	linkw	%fp,#-76
	moveml	%d4-%d7/%a2-%a4,%sp@-
	moveq	#0,%d0
	moveal	%d0,%a3
	moveal	%d0,%a4
	moveal	%d0,%a2
	clrw	%d6
	moveq	#-1,%d5
	clrw	%d7
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d4
	moveq	#0,%d0
	movew	%d0,%sp@-
	_UseResFile
	subql	#4,%sp
	movel	#1634494835,%sp@-
	movew	#-8192,%sp@-
	_Get1Resource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqw	.L10008bfa
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnew	.L10008bfa
	movel	%a3,%sp@-
	_LoadResource
	subql	#2,%sp
	_ResError
	movew	%sp@+,%d6
	bnes	.L10008b58
	subql	#2,%sp
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%fp@(-72)
	pea	%fp@(-1)
	moveq	#3,%d0
	_AliasDispatch
	movew	%sp@+,%d6

.L10008b58:
	tstw	%d6
	bnew	.L10008bfa
	subql	#2,%sp
	pea	%fp@(-72)
	moveq	#3,%d0
	moveb	%d0,%sp@-
	moveq	#13,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d5
	cmpiw	#-1,%d5
	beqw	.L10008bfa
	subql	#4,%sp
	movel	#1346457665,%sp@-
	movew	#-8192,%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10008bf6
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L10008bf6
	moveal	%a4,%a0
	_HLock
	moveal	%a4@,%a0
	moveb	%a0@,%d0
	extw	%d0
	movew	%d0,%d7
	addqw	#1,%d7
	extl	%d7
	moveb	%a0@(%d7:w),%d0
	extw	%d0
	extl	%d0
	addl	%d7,%d0
	addqw	#1,%d0
	movew	%d0,%d7
	extl	%d7
	moveal	%a4@,%a0
	moveb	%a0@(%d7:w),%d0
	extw	%d0
	extl	%d0
	addl	%d7,%d0
	addqw	#1,%d0
	movew	%d0,%d7
	moveal	%a4@,%a2
	addaw	%d7,%a2
	cmpiw	#26,%d7
	bnes	.L10008bee
	tstl	%a2@
	bnes	.L10008bee
	moveq	#0,%d0
	movew	%d0,%sp@-
	_UseResFile
	movel	%a3,%sp@-
	_RemoveResource
	subql	#2,%sp
	_ResError
	movew	%sp@+,%d6
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L10008bee
	moveq	#0,%d0
	movew	%d0,%sp@-
	_UpdateResFile

.L10008bee:
	moveal	%a4,%a0
	_HUnlock
	movel	%a4,%sp@-
	_ReleaseResource

.L10008bf6:
	movew	%d5,%sp@-
	_CloseResFile

.L10008bfa:
	movew	%d4,%sp@-
	_UseResFile
	moveml	%fp@(-104),%d4-%d7/%a2-%a4
	unlk	%fp
	rts

sub_10008c08:
	linkw	%fp,#0
	moveml	%a3-%a4,%sp@-
	_GetZone
	moveal	%a0,%a3
	moveal	0x2a6,%a0
	_SetZone
	subql	#4,%sp
	movel	#1935896420,%sp@-
	movew	#-21240,%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10008c46
	movel	%a4,%sp@-
	_DetachResource
	moveal	%a4,%a0
	_MoveHHi
	moveal	%a4,%a0
	_HLock
	movel	%a4@,%sp@-
	moveq	#8,%d0
	movew	%d0,%sp@-
	movew	#3,%sp@-
	_ShutDown

.L10008c46:
	moveal	%a3,%a0
	_SetZone
	moveml	%fp@(-8),%a3-%a4
	unlk	%fp
	rts

sub_10008c54:
	linkw	%fp,#0
	moveml	%d5-%d7/%a3-%a4,%sp@-
	moveal	0x2b6,%a0
	moveal	%a0@(800),%a3
	moveal	0x2a6,%a4
	bras	.L10008c6e

.L10008c6a:
	moveal	%a4@(32),%a4

.L10008c6e:
	tstl	%a4@(32)
	bnes	.L10008c6a
	moveal	%a4@,%a0
	movel	%a0@(4),%d7
	addl	%a4@,%d7
	movel	%d7,%d0
	.short	0xd0bc,0x0000,0x1000	/* addl	#4096,%d0 */
	movel	#-4096,%d1
	andl	%d0,%d1
	movel	%d1,%d7
	cmpl	%a3@(16),%d7
	bhiw	.L10008d54
	movel	%a3@(16),%d6
	subl	%d7,%d6
	movel	#-4096,%d0
	andl	%d6,%d0
	movel	%d0,%d6
	cmpil	#1048576,%d6
	blss	.L10008cba
	subil	#1048576,%d6
	addil	#1048576,%d7

.L10008cba:
	subql	#4,%sp
	movel	%a3@(32),%sp@-
	movel	%d7,%sp@-
	movel	%d6,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movew	#-13,%sp@-
	_MPDispatch
	movel	%sp@+,%d5
	bnew	.L10008d54
	subql	#4,%sp
	movel	%a3@(32),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%d7,%sp@-
	movew	#-10,%sp@-
	_MPDispatch
	movel	%sp@+,%d5
	bnes	.L10008d54
	movel	%d7,%a3@(16)
	addl	%d6,%a3@(24)
	moveal	%d7,%a0
	_SetApplLimit
	cmpil	#67108864,%a3@(28)
	blss	.L10008d24
	subql	#4,%sp
	movel	%a3@(32),%sp@-
	moveq	#64,%d0
	movel	%d0,%sp@-
	movel	#67108864,%sp@-
	movew	#-24,%sp@-
	_MPDispatch
	movel	%sp@+,%d5
	bnes	.L10008d54
	movel	#67108864,%a3@(20)
	bras	.L10008d2a

.L10008d24:
	movel	%a3@(28),%a3@(20)

.L10008d2a:
	movel	0x8,%a3@(56)
	lea	%pc@(sub_10002bf8),%a0
	movel	%a0,%a3@(52)
	lea	%a3@(50),%a0
	movel	%a0,0x8
	movel	%d7,0x1e10
	movel	%a3@(4),%d0
	.short	0x90bc,0x0000,0x0200	/* subl	#512,%d0 */
	movel	%d0,0xddc
	bras	.L10008d58

.L10008d54:
	moveq	#105,%d0
	_SysError

.L10008d58:
	moveml	%fp@(-20),%d5-%d7/%a3-%a4
	unlk	%fp
	rts

sub_10008d62:
	linkw	%fp,#-12
	moveml	%d3-%d7/%a3-%a4,%sp@-
	moveq	#0,%d5
	movel	0x322,%d0
	addl	%d0,%d0
	movel	%d0,%fp@(-8)
	moveal	0x2b6,%a0
	moveal	%a0@(800),%a3
	movel	0x10c,%d0
	subl	%fp@(-8),%d0
	movel	#-4096,%d6
	andl	%d0,%d6
	cmpl	%a3@,%d6
	bcsw	.L10008e7e
	movel	%d6,%d0
	.short	0x90bc,0x0010,0x0000	/* subl	#1048576,%d0 */
	movel	#-4096,%d1
	andl	%d0,%d1
	movel	%d1,%d6
	cmpl	%a3@,%d6
	bccs	.L10008dac
	movel	%a3@,%d6

.L10008dac:
	cmpl	%a3@(8),%d6
	bhis	.L10008db8
	moveal	%d6,%a0
	clrb	%a0@
	bras	.L10008dea

.L10008db8:
	movel	%d6,%d0
	subl	%a3@(8),%d0
	movel	#-4096,%d3
	andl	%d0,%d3
	tstl	%d3
	blss	.L10008dea
	subql	#4,%sp
	movel	%a3@(12),%sp@-
	movel	%a3@(8),%sp@-
	movel	%d3,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movew	#-13,%sp@-
	_MPDispatch
	movel	%sp@+,%d5
	bnew	.L10008e7e
	addl	%d3,%a3@(8)

.L10008dea:
	moveal	0x2a6,%a4
	bras	.L10008df4

.L10008df0:
	moveal	%a4@(32),%a4

.L10008df4:
	tstl	%a4@(32)
	bnes	.L10008df0
	moveal	%a4@,%a0
	movel	%a0@(4),%d2
	addl	%a4@,%d2
	movel	%d2,%d0
	.short	0xd0bc,0x0000,0x1060	/* addl	#4192,%d0 */
	movel	#-4096,%d7
	andl	%d0,%d7
	cmpl	%a3@(20),%d7
	bhis	.L10008e7e
	movel	%d7,%d0
	.short	0xd0bc,0x0020,0x1000	/* addl	#2101248,%d0 */
	movel	#-4096,%d1
	andl	%d0,%d1
	movel	%d1,%d7
	cmpl	%a3@(20),%d7
	blss	.L10008e34
	movel	%a3@(20),%d7

.L10008e34:
	cmpl	%a3@(16),%d7
	bcss	.L10008e44
	movel	%d7,%d0
	subql	#1,%d0
	moveal	%d0,%a0
	clrb	%a0@
	bras	.L10008e86

.L10008e44:
	movel	%a3@(16),%d0
	subl	%d7,%d0
	movel	#-4096,%d4
	andl	%d0,%d4
	tstl	%d4
	blss	.L10008e86
	movel	%d2,%sp@-
	subql	#4,%sp
	movel	%a3@(32),%sp@-
	movel	%d7,%sp@-
	movel	%d4,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movew	#-13,%sp@-
	_MPDispatch
	movel	%sp@+,%d0
	movel	%sp@+,%d2
	movel	%d0,%d5
	bnes	.L10008e7e
	movel	%d7,%a3@(16)
	addl	%d4,%a3@(24)
	bras	.L10008e86

.L10008e7e:
	movel	%d2,%sp@-
	moveq	#105,%d0
	_SysError

.L10008e84:
	movel	%sp@+,%d2

.L10008e86:
	moveml	%fp@(-40),%d3-%d7/%a3-%a4
	unlk	%fp
	rts

sub_10008e90:
	linkw	%fp,#-20
	moveml	%d3-%d7/%a2-%a4,%sp@-
	moveq	#0,%d7
	moveal	0x2b6,%a0
	movel	%a0@(800),%fp@(-4)
	movel	#-4096,%d0
	andl	%fp@(8),%d0
	movel	%d0,%fp@(-8)
	moveal	%fp@(-4),%a0
	movel	%a0@,%fp@(-12)
	movel	%a0@(8),%d4
	moveal	%a0@(12),%a2
	movel	%fp@(-8),%d0
	cmpl	%fp@(-12),%d0
	bcss	.L10008ed2
	cmpl	%fp@(-8),%d4
	bhis	.L10008f12

.L10008ed2:
	movel	%fp@(8),%d0
	.short	0xd0bc,0x0000,0x1000	/* addl	#4096,%d0 */
	movel	#-4096,%d1
	andl	%d0,%d1
	movel	%d1,%fp@(-8)
	moveal	%fp@(-4),%a0
	movel	%a0@(16),%d4
	moveal	%a0@(32),%a2
	cmpl	%fp@(-8),%d4
	bhis	.L10008f04
	movel	%fp@(-8),%d0
	cmpl	%a0@(20),%d0
	bcss	.L10008f78

.L10008f04:
	moveal	%fp@(-4),%a0
	movel	%a0@(56),%fp@(12)
	braw	.L10008fe8

.L10008f12:
	movel	%d4,%d0
	subl	%fp@(-8),%d0
	.short	0xd0bc,0x0000,0x1000	/* addl	#4096,%d0 */
	movel	#-4096,%d3
	andl	%d0,%d3
	subl	%d3,%d4
	moveq	#12,%d0
	movel	%d3,%d1
	lsrl	%d0,%d1
	movel	%d1,%d3
	subql	#4,%sp
	movew	#-52,%sp@-
	_MPDispatch
	cmpl	%sp@+,%d3
	bhiw	.L10008fcc
	movel	%d3,%d5
	moveal	%d4,%a3
	bras	.L10008f6a

.L10008f44:
	subql	#4,%sp
	movel	%a2,%sp@-
	movel	%a3,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	movel	%d1,%sp@-
	movew	#-14,%sp@-
	_MPDispatch
	movel	%sp@+,%d7
	bnes	.L10008fcc
	movel	%a3,%d0
	.short	0xd0bc,0x0000,0x1000	/* addl	#4096,%d0 */
	moveal	%d0,%a3
	movel	%d5,%d0
	subql	#1,%d5

.L10008f6a:
	tstl	%d5
	bhis	.L10008f44
	moveal	%fp@(-4),%a0
	movel	%d4,%a0@(8)
	bras	.L10008fe2

.L10008f78:
	movel	%fp@(-8),%d0
	subl	%d4,%d0
	moveq	#12,%d1
	movel	%d0,%d3
	lsrl	%d1,%d3
	subql	#4,%sp
	movew	#-52,%sp@-
	_MPDispatch
	cmpl	%sp@+,%d3
	bhis	.L10008fcc
	movel	%d3,%d6
	moveal	%d4,%a4
	bras	.L10008fbc

.L10008f96:
	subql	#4,%sp
	movel	%a2,%sp@-
	movel	%a4,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	movel	%d1,%sp@-
	movew	#-14,%sp@-
	_MPDispatch
	movel	%sp@+,%d7
	bnes	.L10008fcc
	movel	%a4,%d0
	.short	0xd0bc,0x0000,0x1000	/* addl	#4096,%d0 */
	moveal	%d0,%a4
	movel	%d6,%d0
	subql	#1,%d6

.L10008fbc:
	tstl	%d6
	bhis	.L10008f96
	movel	%a4,%d4
	moveal	%fp@(-4),%a0
	movel	%d4,%a0@(16)
	bras	.L10008fe2

.L10008fcc:
	moveq	#105,%d0
	_SysError
	movel	#-620,%d7
	moveal	%fp@(-4),%a0
	movel	%a0@(56),%fp@(12)
	bras	.L10008fe8

.L10008fe2:
	moveq	#0,%d0
	movel	%d0,%fp@(12)

.L10008fe8:
	moveml	%fp@(-52),%d3-%d7/%a2-%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_10008ff4:
	linkw	%fp,#-4
	movel	%a4,%sp@-
	subql	#4,%sp
	movel	#1986863136,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10009052
	subql	#4,%sp
	movel	%a4,%sp@-
	jsr	%pc@(sub_10003106)
	moveq	#12,%d0
	cmpl	%sp@+,%d0
	bnes	.L10009052
	moveq	#11,%d0
	movel	%d0,%sp@-
	moveal	%a4@,%a0
	movel	%a0@,%sp@-
	pea	%fp@(-4)
	movel	#196610,%d0
	_BlueBoxDispatch
	tstl	%d0
	lea	%sp@(12),%sp
	bnes	.L1000904e
	moveal	%fp@(-4),%a0
	moveal	0x2b6,%a1
	movel	%a0@,%a1@(722)
	moveal	%a4@,%a0
	moveal	0x2b6,%a1
	movel	%a0@,%a1@(726)

.L1000904e:
	movel	%a4,%sp@-
	_ReleaseResource

.L10009052:
	moveal	%fp@(-8),%a4
	unlk	%fp
	rts

sub_1000905a:
	linkw	%fp,#-152
	moveml	%d3-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a0
	_HLock
	lea	%fp@(-34),%a0
	movel	%a0,%fp@(-124)
	movew	%fp@(20),%fp@(-120)
	movew	#1,%fp@(-114)

.L1000907c:
	movel	%fp@(16),%fp@(-94)
	lea	%fp@(-142),%a0
	moveq	#9,%d0
	_HFSDispatch
	movew	%d0,%fp@(-2)
	bnew	.L10009252
	moveq	#16,%d0
	andb	%fp@(-112),%d0
	moveq	#0,%d1
	moveb	%d0,%d1
	tstl	%d1
	bnew	.L10009252
	clrw	%d5
	braw	.L10009240

.L100090a8:
	moveq	#0,%d0
	movew	%d5,%d0
	moveal	%fp@(8),%a0
	moveal	%a0@,%a0
	movel	%d0,%d1
	muluw	#46,%d0
	swap	%d1
	muluw	#46,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	lea	%a0@(4,%d0:l),%a4
	moveq	#1,%d6
	tstl	%a4@
	beqs	.L100090d6
	movel	%a4@,%d0
	cmpl	%fp@(-110),%d0
	bnes	.L10009108

.L100090d6:
	tstl	%a4@(4)
	beqs	.L100090e6
	movel	%a4@(4),%d0
	cmpl	%fp@(-106),%d0
	bnes	.L10009108

.L100090e6:
	moveq	#0,%d0
	moveb	%a4@(14),%d0
	tstl	%d0
	blss	.L1000910a
	subql	#2,%sp
	pea	%a4@(14)
	movel	%fp@(-124),%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	moveb	%d0,%sp@-
	jsr	%pc@(sub_10003162)
	tstb	%sp@+
	bnes	.L1000910a

.L10009108:
	clrb	%d6

.L1000910a:
	tstb	%d6
	beqs	.L10009174
	tstl	%a4@(8)
	beqs	.L10009174
	clrb	%d6
	moveq	#0,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	subql	#2,%sp
	movew	%fp@(-120),%sp@-
	movel	%fp@(-42),%sp@-
	movel	%fp@(-124),%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d4
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	tstw	%d4
	bles	.L10009174
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a3
	moveq	#0,%d0
	movel	%d0,%fp@(-152)
	movel	%a3,%d1
	beqs	.L10009170
	tstl	%a3@
	bnes	.L1000915e
	movel	%a3,%sp@-
	_LoadResource

.L1000915e:
	tstl	%a3@
	beqs	.L10009170
	moveal	%a3@,%a0
	movel	%a0@,%d0
	cmpl	%a4@(8),%d0
	sls	%d3
	negb	%d3
	moveb	%d3,%d6

.L10009170:
	movew	%d4,%sp@-
	_CloseResFile

.L10009174:
	tstb	%d6
	beqw	.L1000923c
	tstw	%a4@(12)
	beqs	.L10009188
	movew	%a4@(12),%sp@-
	jsr	%pc@(sub_100065b4)

.L10009188:
	subql	#2,%sp
	movew	%fp@(-120),%sp@-
	movel	%fp@(12),%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-148)
	pea	%fp@(-146)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d7
	bnes	.L100091cc
	movew	%fp@(-120),%d0
	cmpw	%fp@(-148),%d0
	bnes	.L100091cc
	subql	#2,%sp
	movew	%fp@(-120),%sp@-
	movel	%fp@(-42),%sp@-
	movel	%fp@(-124),%sp@-
	movel	%fp@(-146),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000335c)
	movew	%sp@+,%d7

.L100091cc:
	tstw	%d7
	beqs	.L10009216
	subql	#2,%sp
	movew	%fp@(-120),%sp@-
	movel	#1953657704,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-148)
	pea	%fp@(-146)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d7
	bnes	.L10009216
	movew	%fp@(-120),%d0
	cmpw	%fp@(-148),%d0
	bnes	.L10009216
	subql	#2,%sp
	movew	%fp@(-120),%sp@-
	movel	%fp@(-42),%sp@-
	movel	%fp@(-124),%sp@-
	movel	%fp@(-146),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000335c)
	movew	%sp@+,%d7

.L10009216:
	tstw	%d7
	beqs	.L1000922e
	subql	#2,%sp
	movew	%fp@(-120),%sp@-
	movel	%fp@(-42),%sp@-
	movel	%fp@(-124),%sp@-
	jsr	%pc@(sub_100032fa)
	movew	%sp@+,%d7

.L1000922e:
	tstw	%d7
	bnes	.L10009252
	movew	%fp@(-114),%d0
	subqw	#1,%fp@(-114)
	bras	.L10009252

.L1000923c:
	movew	%d5,%d0
	addqw	#1,%d5

.L10009240:
	moveq	#0,%d0
	movew	%d5,%d0
	tstl	%d0
	moveal	%fp@(8),%a0
	moveal	%a0@,%a0
	cmpl	%a0@,%d0
	bcsw	.L100090a8

.L10009252:
	movew	%fp@(-114),%d0
	addqw	#1,%fp@(-114)
	tstw	%fp@(-2)
	beqw	.L1000907c
	moveal	%fp@(8),%a0
	_HUnlock
	moveml	%fp@(-180),%d3-%d7/%a3-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(14),%sp
	jmp	%a0@

sub_10009278:
	linkw	%fp,#-6
	moveml	%d7/%a4,%sp@-
	moveq	#1,%d7
	braw	.L10009344

.L10009286:
	subql	#4,%sp
	movel	#1684632422,%sp@-
	movew	%d7,%sp@-
	_GetIndResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqw	.L10009340
	tstl	%a4@
	beqw	.L10009340
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1702392942,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	tstw	%sp@+
	bnes	.L100092d4
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	#1702392900,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000905a)

.L100092d4:
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1668575852,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	tstw	%sp@+
	bnes	.L10009308
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	#1668575812,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000905a)

.L10009308:
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1835098995,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	tstw	%sp@+
	bnes	.L1000933c
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	#1835098948,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000905a)

.L1000933c:
	movel	%a4,%sp@-
	_ReleaseResource

.L10009340:
	movew	%d7,%d0
	addqw	#1,%d7

.L10009344:
	subql	#2,%sp
	movel	#1684632422,%sp@-
	_CountResources
	cmpw	%sp@+,%d7
	blew	.L10009286
	moveml	%fp@(-14),%d7/%a4
	unlk	%fp
	rts

sub_1000935e:
	linkw	%fp,#-266
	moveml	%d7/%a3-%a4,%sp@-
	subql	#4,%sp
	movel	#1668245090,%sp@-
	movew	#-20034,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L100093f8
	subql	#4,%sp
	movel	%a4,%sp@-
	_GetResourceSizeOnDisk
	movel	%sp@+,%d7
	movel	%a4,%sp@-
	_DetachResource
	moveal	%a4,%a0
	_HLock
	_GetZone
	moveal	%a0,%a3
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	subql	#2,%sp
	movel	%a4@,%sp@-
	movel	%d7,%sp@-
	pea	%pc@(str_1000941c)
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-260)
	moveq	#0,%d1
	movel	%d1,%sp@-
	pea	%fp@(-256)
	movew	#3,%sp@-
	_CodeFragmentDispatch
	tstw	%sp@+
	bnes	.L100093ec
	subql	#2,%sp
	movel	%fp@(-260),%sp@-
	pea	%pc@(str_10009402)
	pea	%fp@(-266)
	pea	%fp@(-261)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	tstw	%sp@+
	bnes	.L100093de
	moveal	%fp@(-266),%a0
	jsr	%a0@

.L100093de:
	subql	#2,%sp
	pea	%fp@(-260)
	movew	#4,%sp@-
	_CodeFragmentDispatch
	addqw	#2,%sp

.L100093ec:
	moveal	%a4,%a0
	_HUnlock
	moveal	%a4,%a0
	_DisposeHandle
	moveal	%a3,%a0
	_SetZone

.L100093f8:
	moveml	%fp@(-278),%d7/%a3-%a4
	unlk	%fp
	rts

str_10009402:
	.byte	0x18
	.ascii	"ReplaceBridgeVideoDriver"
	.byte	0x00

str_1000941c:
	.byte	0x1b
	.string	"ReplaceBridgeVideoDriverLib"
	.align	2

sub_1000943a:
	linkw	%fp,#-14
	moveml	%d7/%a3-%a4,%sp@-
	moveq	#0,%d0
	moveal	%d0,%a4
	movel	#1918987552,%d0
	lea	%fp@(-10),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	bnew	.L10009534
	lea	%fp@(-1),%a0
	movel	#65711,%d0
	_ReadXPRAM
	movew	%d0,%d7
	bnew	.L10009534
	moveq	#0,%d0
	moveb	%fp@(-1),%d0
	tstl	%d0
	beqw	.L10009534
	moveq	#0,%d0
	moveb	%fp@(-1),%d0
	movel	%fp@(-10),%d1
	asrl	#8,%d1
	jsr	%pc@(sub_1000d786)
	subl	%d0,%fp@(-10)
	movel	#1920102509,%d0
	lea	%fp@(-14),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	beqs	.L100094ce
	moveq	#0,%d0
	movel	%d0,%fp@(-14)
	movel	#1835098984,%d0
	lea	%fp@(-6),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L100094ce
	cmpil	#406,%fp@(-6)
	bnes	.L100094ce
	movel	#4194304,%fp@(-14)

.L100094ce:
	subql	#4,%sp
	movel	#1835954797,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10009534
	moveal	%a4@,%a3
	movel	#1986863136,%d0
	lea	%fp@(-6),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	bnes	.L10009508
	moveq	#1,%d0
	andl	%fp@(-6),%d0
	beqs	.L10009508
	movel	%a3@,%d0
	addl	%d0,%fp@(-14)
	bras	.L10009510

.L10009508:
	movel	%a3@(12),%d0
	addl	%d0,%fp@(-14)

.L10009510:
	movel	%a4,%sp@-
	_ReleaseResource
	moveq	#0,%d0
	moveal	%d0,%a4
	movel	%fp@(-14),%d1
	cmpl	%fp@(-10),%d1
	bles	.L10009534
	lea	%fp@(-1),%a0
	clrb	%a0@
	movel	#65711,%d0
	_WriteXPRAM
	moveq	#122,%d0
	_SysError

.L10009534:
	moveml	%fp@(-26),%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000953e:
	linkw	%fp,#0
	moveml	%d7/%a4,%sp@-
	moveq	#0,%d0
	moveal	%d0,%a4
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d7
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	moveq	#0,%d0
	movew	%d0,%sp@-
	_UseResFile
	subql	#4,%sp
	movel	#1718907755,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L10009598
	tstl	%a4@
	beqs	.L10009586
	moveal	%a4@,%a0
	moveq	#1,%d0
	cmpl	%a0@,%d0
	bnes	.L10009586
	moveq	#0,%d0
	movew	%a0@(12),%d0
	tstl	%d0
	bnes	.L10009590

.L10009586:
	movel	%a4,%sp@-
	_ReleaseResource
	moveq	#0,%d0
	moveal	%d0,%a4
	bras	.L10009598

.L10009590:
	movel	%a4,%sp@-
	_DetachResource
	moveal	%a4,%a0
	_HLock

.L10009598:
	movel	%a4,%fp@(8)
	moveml	%fp@(-8),%d7/%a4
	unlk	%fp
	rts

sub_100095a6:
	linkw	%fp,#0
	moveml	%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	moveal	%a3@,%a4
	movel	%a4,%d0
	beqs	.L100095c8
	cmpal	#-1,%a4
	beqs	.L100095c8
	moveal	%a4,%a0
	_DisposeHandle
	moveq	#0,%d0
	movel	%d0,%a3@

.L100095c8:
	moveml	%fp@(-8),%a3-%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_100095d4:
	linkw	%fp,#-6
	moveml	%d3-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	movel	%a3@,%fp@(-6)
	moveq	#0,%d0
	moveal	%d0,%a4
	clrb	%d6
	clrb	%d7
	tstl	%fp@(-6)
	beqs	.L100095fa
	moveq	#-1,%d0
	cmpl	%fp@(-6),%d0
	bnes	.L10009626

.L100095fa:
	subql	#4,%sp
	jsr	%pc@(sub_1000953e)
	movel	%sp@+,%fp@(-6)
	bnes	.L10009610
	moveb	#1,%fp@(30)
	braw	.L100096fe

.L10009610:
	moveal	%fp@(-6),%a0
	tstl	%a0@
	bnes	.L10009622
	moveb	#1,%fp@(30)
	braw	.L100096fe

.L10009622:
	movel	%fp@(-6),%a3@

.L10009626:
	moveal	%fp@(-6),%a0
	moveal	%a0@,%a0
	movew	%a0@(12),%fp@(-2)
	moveq	#0,%d0
	movew	%fp@(-2),%d0
	tstl	%d0
	bnes	.L10009646
	moveb	#1,%fp@(30)
	braw	.L100096fe

.L10009646:
	clrw	%d5
	moveal	%fp@(-6),%a0
	moveal	%a0@,%a0
	lea	%a0@(14),%a4
	braw	.L100096e6

.L10009656:
	tstl	%a4@
	beqs	.L10009676
	movel	%a4@,%d0
	cmpl	%fp@(26),%d0
	bnes	.L10009676
	tstl	%a4@(4)
	beqs	.L10009676
	movel	%a4@(4),%d0
	cmpl	%fp@(22),%d0
	bnes	.L10009676
	moveq	#1,%d6
	moveq	#1,%d7

.L10009676:
	tstb	%d6
	beqs	.L100096da
	tstl	%a4@(12)
	beqs	.L100096da
	clrb	%d7
	moveq	#0,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	subql	#2,%sp
	movew	%fp@(20),%sp@-
	movel	%fp@(16),%sp@-
	movel	%fp@(12),%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d4
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_SetResLoad
	tstw	%d4
	bles	.L100096da
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqs	.L100096d6
	tstl	%a3@
	bnes	.L100096c4
	movel	%a3,%sp@-
	_LoadResource

.L100096c4:
	tstl	%a3@
	beqs	.L100096d6
	moveal	%a3@,%a0
	movel	%a0@,%d0
	cmpl	%a4@(12),%d0
	sls	%d3
	negb	%d3
	moveb	%d3,%d7

.L100096d6:
	movew	%d4,%sp@-
	_CloseResFile

.L100096da:
	tstb	%d6
	bnes	.L100096ee
	movew	%d5,%d0
	addqw	#1,%d5
	lea	%a4@(50),%a4

.L100096e6:
	cmpw	%fp@(-2),%d5
	bcsw	.L10009656

.L100096ee:
	tstb	%d7
	beqs	.L100096f8
	clrb	%fp@(30)
	bras	.L100096fe

.L100096f8:
	moveb	#1,%fp@(30)

.L100096fe:
	moveml	%fp@(-34),%d3-%d7/%a3-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(22),%sp
	jmp	%a0@

sub_1000970e:
	linkw	%fp,#-8
	moveml	%d7/%a4,%sp@-
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	bnes	.L10009732
	moveq	#0,%d0
	movel	%d0,%fp@(8)
	bras	.L10009786

.L10009732:
	moveal	%a4@,%a0
	movel	%a0@,%fp@(-8)
	movel	%a4,%sp@-
	_ReleaseResource
	movel	#_fcc_bbox,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L10009780
	moveq	#1,%d0
	andl	%fp@(-4),%d0
	beqs	.L10009780
	movew	CurMap,%d7
	movew	SysMap,CurMap
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L1000977c
	moveal	%a4@,%a0
	movel	%a0@,%fp@(-8)

.L1000977c:
	movew	%d7,CurMap

.L10009780:
	movel	%fp@(-8),%fp@(8)

.L10009786:
	moveml	%fp@(-16),%d7/%a4
	unlk	%fp
	rts

sub_10009790:
	linkw	%fp,#-4
	moveml	%a3-%a4,%sp@-
	movel	#_fcc_bbox,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L100097da
	moveq	#1,%d0
	andl	%fp@(-4),%d0
	beqs	.L100097da
	subql	#4,%sp
	movel	#1735288948,%sp@-
	movew	#-28673,%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L100097da
	subql	#4,%sp
	movel	%a4,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	moveq	#18,%d0
	_ComponentDispatch
	moveal	%sp@+,%a3
	movel	%a4,%sp@-
	_ReleaseResource

.L100097da:
	moveml	%fp@(-12),%a3-%a4
	unlk	%fp
	rts

sub_100097e4:
	linkw	%fp,#0
	moveml	%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	subql	#4,%sp
	movew	#-16413,%sp@-
	_GetString
	moveal	%sp@+,%a4
	moveq	#0,%d7
	movel	%a4,%d0
	beqs	.L10009840
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L10009840
	movel	%a4,%d0
	bnes	.L10009810
	movel	%a4,%sp@-
	_LoadResource

.L10009810:
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L10009840
	movel	%a4,%d0
	beqs	.L10009840
	tstl	%a4@
	beqs	.L10009840
	subql	#2,%sp
	movel	%a3,%sp@-
	movel	%a4@,%sp@-
	jsr	%pc@(sub_10003394)
	tstw	%sp@+
	beqs	.L1000983e
	subql	#4,%sp
	movel	%a4@,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_100033d2)
	movel	%a4,%sp@-
	_ChangedResource
	addqw	#4,%sp

.L1000983e:
	moveq	#1,%d7

.L10009840:
	movel	%d7,%fp@(12)
	moveml	%fp@(-12),%d7/%a3-%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_10009850:
	linkw	%fp,#-362
	moveml	%d6-%d7/%a2-%a4,%sp@-
	moveal	%fp@(8),%a4
	moveq	#-1,%d6
	movel	%a4,%d0
	bnes	.L10009868
	moveq	#-50,%d0
	braw	.L1000998a

.L10009868:
	clrb	%a4@
	movel	#1852990823,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d6
	bnew	.L10009988
	lea	%pc@(str_100099aa),%a0
	lea	%fp@(-352),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveb	%a0@,%a1@
	lea	%pc@(str_10009994),%a3
	moveq	#0,%d0
	moveal	%d0,%a2
	movel	#1667658343,%d0
	lea	%fp@(-8),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnew	.L10009988
	moveq	#1,%d0
	andl	%fp@(-8),%d0
	beqw	.L10009988
	subql	#2,%sp
	pea	%fp@(-352)
	movel	#1886875747,%sp@-
	moveq	#2,%d0
	movel	%d0,%sp@-
	movel	%a2,%sp@-
	pea	%fp@(-284)
	pea	%fp@(-280)
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d6
	bnew	.L10009988
	moveq	#31,%d0
	movel	%d0,%fp@(-362)
	clrb	%fp@(-353)
	pea	%fp@(-24)
	moveq	#0,%d0
	_NameRegistryDispatch
	pea	%fp@(-358)
	moveq	#7,%d0
	_NameRegistryDispatch
	movew	%d0,%d6
	addqw	#8,%sp
	bnes	.L1000992a
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%fp@(-353)
	pea	%fp@(-24)
	moveq	#5,%d0
	movel	%d0,%sp@-
	pea	%fp@(-358)
	moveq	#11,%d0
	_NameRegistryDispatch
	movew	%d0,%d6
	pea	%fp@(-358)
	moveq	#8,%d0
	_NameRegistryDispatch
	lea	%sp@(32),%sp

.L1000992a:
	tstb	%fp@(-353)
	bnes	.L1000997e
	tstw	%d6
	bnes	.L1000997e
	pea	%fp@(-362)
	pea	%a4@(1)
	movel	%a3,%sp@-
	pea	%fp@(-24)
	moveq	#23,%d0
	_NameRegistryDispatch
	movew	%d0,%d6
	lea	%sp@(16),%sp
	bnes	.L1000997e
	tstl	%fp@(-362)
	blss	.L1000997e
	moveq	#31,%d0
	cmpl	%fp@(-362),%d0
	bccs	.L10009962
	moveq	#31,%d0
	movel	%d0,%fp@(-362)

.L10009962:
	movew	%fp@(-360),%d7
	subqw	#1,%d7
	bras	.L1000996e

.L1000996a:
	movew	%d7,%d0
	subqw	#1,%d7

.L1000996e:
	tstw	%d7
	bles	.L1000997c
	moveq	#0,%d0
	moveb	%a4@(%d7:w),%d0
	tstl	%d0
	beqs	.L1000996a

.L1000997c:
	moveb	%d7,%a4@

.L1000997e:
	pea	%fp@(-24)
	moveq	#3,%d0
	_NameRegistryDispatch
	addqw	#4,%sp

.L10009988:
	movew	%d6,%d0

.L1000998a:
	moveml	%fp@(-382),%d6-%d7/%a2-%a4
	unlk	%fp
	rts

str_10009994:
	.string	"AAPL,MacOSMachineName"

str_100099aa:
	.byte	0x0f
	.string	"NameRegistryLib"
	.align	2

sub_100099bc:
	linkw	%fp,#-36
	movel	%a4,%sp@-
	lea	%fp@(-32),%a4
	movel	%a4,%sp@-
	jsr	%pc@(sub_10009850)
	tstw	%d0
	addqw	#4,%sp
	bnes	.L10009a30
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	blss	.L10009a30
	subql	#4,%sp
	movel	%a4,%sp@-
	jsr	%pc@(sub_100097e4)
	tstl	%sp@+
	beqs	.L10009a30
	moveq	#0,%d0
	movel	%d0,%fp@(-36)
	movel	#1936748403,%d0
	lea	%fp@(-36),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	beqs	.L10009a14
	subql	#2,%sp
	movel	#1936748403,%sp@-
	movel	%fp@(-36),%sp@-
	movew	#1025,%d0
	_GestaltValueDispatch
	addqw	#2,%sp

.L10009a14:
	oril	#8,%fp@(-36)
	subql	#2,%sp
	movel	#1936748403,%sp@-
	movel	%fp@(-36),%sp@-
	movew	#1026,%d0
	_GestaltValueDispatch
	addqw	#2,%sp

.L10009a30:
	moveal	%fp@(-40),%a4
	unlk	%fp
	rts

sub_10009a38:
	linkw	%fp,#0
	moveml	%d0-%a3,%sp@-
	movel	#_fcc_bbox,%d0
	_Gestalt
	bnew	.L10009a56
	movel	%a0,%d0
	btst	#0,%d0
	bnew	.L10009bb6

.L10009a56:
	subqw	#4,%sp
	movel	#_fcc_krnl,%sp@-
	clrw	%sp@-
	_GetResource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqw	.L10009bb6
	moveal	#1761599488,%a0
	movew	%a0@(4068),%d0
	moveal	%a3@,%a0
	cmpw	%a0@(4),%d0
	bgew	.L10009bb2
	moveal	%a3,%a0
	_GetHandleSize
	movel	%d0,%d7
	addil	#4095,%d7
	andil	#-4096,%d7
	moveal	%a3@,%a0
	movew	%a0@(6),%d6
	extl	%d6
	lsll	#8,%d6
	lsll	#4,%d6
	addl	%d7,%d6
	movew	%a0@(8),%d5
	cmpiw	#16384,%d5
	blts	.L10009aaa
	clrw	%d5

.L10009aaa:
	extl	%d5
	movel	0x108,%d0
	lsrl	#8,%d0
	lsrl	#8,%d0
	lsrl	#4,%d0
	.short	0x4c00,0x5005	/* mulul %d0,%d5 */
	addl	%d5,%d6
	movel	%a3,%sp@-
	_ReleaseResource
	movel	%d6,%d0
	addil	#4096,%d0
	_NewPtrSysClear
	movel	%a0,%d0
	beqw	.L10009be2
	addil	#4095,%d0
	andil	#-4096,%d0
	moveal	%d0,%a2
	moveal	%a2,%a0
	moveal	%d6,%a1
	_LockMemoryContiguous
	tstw	%d0
	bnew	.L10009bd6
	subqw	#4,%sp
	movel	#_fcc_krnl,%sp@-
	clrw	%sp@-
	_GetResource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqw	.L10009bdc
	movel	%d7,%d0
	moveal	%a3@,%a0
	moveal	%a2,%a1
	_BlockMoveData
	moveal	%a2,%a0
	movel	%d7,%d0
	.short	0xfe0c
	nop
	moveal	%a2,%a0
	movel	%d7,%d0
	.short	0xfe0b
	nop
	moveal	%sp,%a0
	movel	%sp,%d0
	andiw	#-1024,%d0
	moveal	%d0,%sp
	movew	#191,%d0

.L10009b26:
	clrl	%sp@-
	dbf	%d0,.L10009b26
	movel	%a0,%sp@(8)
	movel	%a2,%d0
	movel	%a2,%sp@(252)
	lsrl	#8,%d0
	lsrl	#4,%d0
	moveal	%d0,%a0
	_nkMMUGetPhysicalPage
	lsll	#8,%d0
	lsll	#4,%d0
	movel	%d0,%sp@(284)
	movel	%a2,%d0
	addl	%d7,%d0
	lsrl	#8,%d0
	lsrl	#4,%d0
	moveal	%d0,%a0
	_nkMMUGetPhysicalPage
	lsll	#8,%d0
	lsll	#4,%d0
	movel	%d0,%sp@(292)
	movel	%a2,%d0
	addl	%d6,%d0
	lsrl	#8,%d0
	lsrl	#4,%d0
	subql	#1,%d0
	moveal	%d0,%a0
	_nkMMUGetPhysicalPage
	lsll	#8,%d0
	lsll	#4,%d0
	movel	%d0,%sp@(308)
	moveal	0x2ae,%a0
	moveq	#0,%d0
	movew	%a0@(18),%d0
	movel	%d0,%sp@(316)
	movel	0x1d8,%d0
	movel	%d0,%sp@(300)
	moveml	0x174,%d0-%d3
	orl	%d2,%d0
	orl	%d3,%d0
	bnes	.L10009ba0
	cmpil	#2048,%d1
	beqs	.L10009bae

.L10009ba0:
	jsr	%pc@(sub_10009c28)
	bnew	.L10009bae
	movel	%sp,%sp@-
	_ExecuteRiscContext
	addql	#4,%sp

.L10009bae:
	moveal	%sp@(8),%sp

.L10009bb2:
	movel	%a3,%sp@-
	_ReleaseResource

.L10009bb6:
	moveal	#1761603584,%a0
	movel	%a0@(472),%d1
	beqs	.L10009bce
	clrl	%a0@(472)
	moveq	#5,%d0
	_MoveFromECR
	movel	%d1,%a0@(216)

.L10009bce:
	moveml	%sp@+,%d0-%a3
	unlk	%fp
	rts

.L10009bd6:
	_SysError 666

.L10009bdc:
	_SysError 667

.L10009be2:
	_SysError 668

	.int	0x3C604761
	.int	0x60637279
	.int	0x3C800505
	.int	0x60841956
	.int	0x6005C000
	.int	0x3CE068FF
	.int	0x60E7E648
	.int	0x80E70000
	.int	0x38E70008
	.int	0x7CE803A6
	.int	0x38E00000
	.int	0x4E800021
	.int	0x63C36084
	.int	0x7C6903A6
	.int	0x4E800420
	.int	0x00000000

sub_10009c28:
	movel	0x68fff998,%d0
	cmpl	0x68fff994,%d0
	bnes	.L10009ca0
	moveal	%sp,%a2
	movel	%sp,%d0
	andil	#-4,%d0
	moveal	%d0,%sp
	lea	%pc@(sub_10009c28),%a0
	movew	#15,%d0

.L10009c4a:
	movel	%a0@-,%sp@-
	dbf	%d0,.L10009c4a
	moveal	%sp,%a0
	moveq	#64,%d0
	.short	0xfe0d
	nop
	movel	#1835098984,%d0
	_Gestalt
	movel	%a0,%d0
	cmpiw	#41,%d0
	beqw	.L10009c72
	cmpiw	#42,%d0
	bnew	.L10009c82

.L10009c72:
	moveal	0x2ae,%a0
	movel	#1048576,%d0

.L10009c7c:
	movel	%a0@+,%d1
	subql	#4,%d0
	bnes	.L10009c7c

.L10009c82:
	moveal	%sp,%a0
	moveq	#64,%d0
	.short	0xfe0b
	nop
	movel	%sp,0x68fff994
	.short	0xfc1e
	movel	0x68fff998,0x68fff994
	moveal	%a2,%sp
	cmpl	%d0,%d0

.L10009ca0:
	rts

sub_10009ca2:
	braw	sub_1000b1c0

sub_10009ca6:
	braw	sub_1000b50a

sub_10009caa:
	linkw	%fp,#-34
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_10009ebe)
	pea	%fp@(-33)
	pea	%fp@(-32)
	pea	%fp@(-28)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnew	.L10009e18
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_10009eae)
	pea	%fp@(-33)
	pea	%fp@(-32)
	pea	%fp@(-24)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnew	.L10009e18
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_10009e9a)
	pea	%fp@(-33)
	pea	%fp@(-32)
	pea	%fp@(-16)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnew	.L10009e18
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_10009e8a)
	pea	%fp@(-33)
	pea	%fp@(-32)
	pea	%fp@(-12)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnew	.L10009e18
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_10009e6a)
	pea	%fp@(-33)
	pea	%fp@(-32)
	pea	%fp@(-8)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnew	.L10009e18
	moveq	#0,%d0
	movel	%d0,%fp@(-20)
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_10009e4e)
	pea	%fp@(-33)
	pea	%fp@(-32)
	pea	%fp@(-20)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L10009d98
	moveq	#0,%d0
	movel	%d0,%fp@(-20)

.L10009d98:
	moveal	%fp@(-28),%a0
	moveal	%a0@,%a0
	moveq	#1,%d0
	_MoveToECR
	moveal	%fp@(-28),%a0
	moveal	%a0@(4),%a0
	moveq	#2,%d0
	_MoveToECR
	moveal	%fp@(-24),%a0
	moveal	%a0@,%a0
	moveq	#13,%d0
	_MoveToECR
	moveq	#3,%d0
	_MoveFromECR
	moveal	%fp@(-16),%a1
	movel	%a0,%a1@
	moveq	#4,%d0
	_MoveFromECR
	moveal	%fp@(-12),%a1
	movel	%a0,%a1@
	tstl	%fp@(-20)
	beqs	.L10009de0
	moveq	#15,%d0
	_MoveFromECR
	beqs	.L10009dda
	subal	%a0,%a0

.L10009dda:
	moveal	%fp@(-20),%a1
	movel	%a0,%a1@

.L10009de0:
	moveal	%fp@(-8),%a0
	movew	#-21927,%d0
	_SetToolTrapAddress
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_10009e24)
	pea	%fp@(-33)
	pea	%fp@(-32)
	pea	%fp@(-4)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10009e18
	subql	#4,%sp
	moveal	%fp@(-4),%a0
	jsr	%a0@
	movel	%sp@+,%d0
	movew	%d0,%d7

.L10009e18:
	movew	%d7,%d0
	moveml	%fp@(-42),%d7/%a4
	unlk	%fp
	rts

str_10009e24:
	.byte	0x28
	.string	"gMixedModeSecondaryInitRoutineDescriptor"

str_10009e4e:
	.byte	0x19
	.string	"MMFlushEmulatorCacheRange"
	.align	2

str_10009e6a:
	.byte	0x1e
	.string	"_MixedModeDispatchTrapHandler_"

str_10009e8a:
	.byte	0x0e
	.string	"EmulatorReturn"

str_10009e9a:
	.byte	0x12
	.string	"Emulated68KContext"

str_10009eae:
	.byte	0x0e
	.string	"ReturnFromM68k"

str_10009ebe:
	.byte	0x12
	.string	"M68kToPowerPCEntry"

sub_10009ed2:
	linkw	%fp,#-14
	moveml	%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	moveq	#5,%d0
	_MoveFromECR
	moveal	%a0,%a4
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_10009f66)
	pea	%fp@(-13)
	pea	%fp@(-12)
	pea	%fp@(-8)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10009f3e
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_10009f4a)
	pea	%fp@(-13)
	pea	%fp@(-12)
	pea	%fp@(-4)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10009f3e
	moveal	%fp@(-8),%a0
	movel	%a0@,%a4@(76)
	movel	%fp@(-4),%a4@(84)
	movel	#2113074944,%a4@(4)

.L10009f3e:
	movew	%d7,%d0
	moveml	%fp@(-26),%d7/%a3-%a4
	unlk	%fp
	rts

str_10009f4a:
	.byte	0x19
	.ascii	"SystemExceptionDispatcher"
	.short	0x0000

str_10009f66:
	.byte	0x18
	.ascii	"LowLevelExceptionHandler"
	.byte	0x00

sub_10009f80:
	linkw	%fp,#-10
	moveml	%d7/%a4,%sp@-
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%fp@(8),%sp@-
	pea	%pc@(str_10009fda)
	pea	%fp@(-9)
	pea	%fp@(-8)
	pea	%fp@(-4)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L10009fce
	subql	#4,%sp
	movel	%fp@(-4),%sp@-
	moveq	#33,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	moveal	%sp@+,%a4
	movel	%a4,%d0
	bnes	.L10009fc8
	moveq	#-108,%d7
	bras	.L10009fce

.L10009fc8:
	moveal	%a4,%a0
	jsr	%a0@
	movew	%d0,%d7

.L10009fce:
	movew	%d7,%d0
	moveml	%fp@(-18),%d7/%a4
	unlk	%fp
	rts

str_10009fda:
	.byte	0x08
	.ascii	"DSL_Init"
	.byte	0x00

sub_10009fe4:
	linkw	%fp,#-4
	movel	%d7,%sp@-
	movel	#1667657063,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	beqs	.L1000a004
	moveq	#0,%d0
	movel	%d0,%fp@(-4)

.L1000a004:
	movel	%fp@(-4),%d0
	movel	%fp@(-8),%d7
	unlk	%fp
	rts

sub_1000a010:
	linkw	%fp,#-266
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	lea	%fp@(-266),%a4
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	moveq	#0,%d1
	movel	%d1,%sp@-
	pea	%a3@(10)
	movel	%d0,%sp@-
	movel	#1886875747,%sp@-
	pea	%fp@(-10)
	pea	%fp@(-6)
	pea	%fp@(-1)
	movel	%a4,%sp@-
	movew	#-2,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000a054
	lea	%pc@(str_1000a088),%a0
	bras	.L1000a07c

.L1000a054:
	movew	%sr,%d0
	oriw	#1792,%sr
	movew	%d0,%d6
	movew	%a3@(4),%d0
	subiw	#50,%d0
	bnes	.L1000a078
	movel	%fp@(-6),%sp@-
	movel	%fp@(-10),%sp@-
	jsr	%pc@(sub_1000acda)
	movew	%d0,%d7
	addqw	#8,%sp
	tstw	%d7

.L1000a078:
	movew	%d6,%sp@-
	movew	%sp@+,%sr

.L1000a07c:
	movew	%d7,%d0
	moveml	%fp@(-282),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

str_1000a088:
	.byte	0x0c
	.ascii	"ncod library"
	.byte	0x00

sub_1000a096:
	braw	sub_1000d774

sub_1000a09a:
	braw	sub_1000d738

sub_1000a09e:
	braw	sub_1000d71a

sub_1000a0a2:
	braw	sub_1000d756

sub_1000a0a6:
	braw	sub_1000d76a

sub_1000a0aa:
	braw	sub_1000d760

sub_1000a0ae:
	braw	sub_1000d742

sub_1000a0b2:
	braw	sub_1000d74c

sub_1000a0b6:
	braw	sub_1000d72e

sub_1000a0ba:
	braw	sub_1000d724

sub_1000a0be:
	linkw	%fp,#-274
	moveml	%d4-%d7/%a2-%a4,%sp@-
	moveb	%fp@(15),%d4
	lea	%fp@(-256),%a3
	moveal	%fp@(8),%a4
	moveq	#1,%d5
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	moveq	#0,%d1
	movel	%d1,%sp@-
	pea	%a4@(10)
	tstb	%d4
	beqs	.L1000a0ea
	moveq	#2,%d0
	bras	.L1000a0ec

.L1000a0ea:
	moveq	#3,%d0

.L1000a0ec:
	extbl	%d0
	movel	%d0,%sp@-
	movel	#1886875747,%sp@-
	pea	%fp@(-270)
	pea	%fp@(-266)
	pea	%fp@(-261)
	movel	%a3,%sp@-
	movew	#-2,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000a122
	tstb	%d4
	beqw	.L1000a246
	cmpiw	#-2817,%d7
	bnew	.L1000a246
	clrw	%d7
	braw	.L1000a246

.L1000a122:
	cmpil	#1936094834,%a4@
	bnes	.L1000a138
	tstw	%a4@(4)
	bnes	.L1000a138
	tstl	%fp@(-266)
	beqw	.L1000a246

.L1000a138:
	lea	%a4@(266),%a2
	tstl	%a2@
	bnes	.L1000a15a
	moveal	%a4@(6),%a0
	movel	%a0@,%a2@(4)
	subql	#4,%sp
	movel	%a4@(6),%sp@-
	jsr	%pc@(sub_10003106)
	movel	%sp@+,%a2@(8)
	clrb	%a2@(12)

.L1000a15a:
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a2,%sp@-
	pea	%a4@(10)
	movel	%d0,%sp@-
	movel	#1886875747,%sp@-
	pea	%fp@(-274)
	pea	%fp@(-266)
	pea	%fp@(-261)
	movel	%a3,%sp@-
	movew	#-2,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000a18e
	lea	%pc@(str_1000a268),%a0
	braw	.L1000a246

.L1000a18e:
	cmpil	#1936094834,%a4@
	bnes	.L1000a19c
	tstw	%a4@(4)
	beqs	.L1000a1a4

.L1000a19c:
	movew	%sr,%d0
	oriw	#1792,%sr
	movew	%d0,%d6

.L1000a1a4:
	cmpil	#1936094834,%a4@
	bnes	.L1000a202
	movew	%a4@(4),%d0
	subiw	#-16401,%d0
	beqs	.L1000a202
	subiw	#16401,%d0
	beqs	.L1000a1c6
	subqw	#1,%d0
	beqs	.L1000a1e8
	subqw	#7,%d0
	beqs	.L1000a1f6
	bras	.L1000a202

.L1000a1c6:
	clrb	%d5
	movel	%fp@(-266),%sp@-
	movel	%fp@(-274),%sp@-
	movel	%fp@(-270),%sp@-
	jsr	%pc@(sub_1000a85e)
	movew	%d0,%d7
	movew	%sr,%d0
	oriw	#1792,%sr
	movew	%d0,%d6
	lea	%sp@(12),%sp
	bras	.L1000a202

.L1000a1e8:
	movel	%fp@(-274),%sp@-
	jsr	%pc@(sub_10009caa)
	movew	%d0,%d7
	addqw	#4,%sp
	bras	.L1000a202

.L1000a1f6:
	movel	%fp@(-274),%sp@-
	jsr	%pc@(sub_10009ed2)
	movew	%d0,%d7
	addqw	#4,%sp

.L1000a202:
	tstw	%d7
	bnes	.L1000a220
	tstb	%d5
	beqs	.L1000a220
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%fp@(-270),%sp@-
	movel	%fp@(-274),%sp@-
	movew	#-17,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7

.L1000a220:
	cmpil	#1936094834,%a4@
	bnes	.L1000a242
	tstw	%d7
	bnes	.L1000a242
	movew	%a4@(4),%d0
	subiw	#-16401,%d0
	bnes	.L1000a242
	movel	%fp@(-274),%sp@-
	jsr	%pc@(sub_10009f80)
	tstw	%d0
	addqw	#4,%sp

.L1000a242:
	movew	%d6,%sp@-
	movew	%sp@+,%sr

.L1000a246:
	tstw	%d7
	beqs	.L1000a254
	tstl	%a2@
	bnes	.L1000a254
	moveal	%a4@(6),%a0
	_DisposeHandle

.L1000a254:
	cmpiw	#-2821,%d7
	bnes	.L1000a25c
	clrw	%d7

.L1000a25c:
	movew	%d7,%d0
	moveml	%fp@(-302),%d4-%d7/%a2-%a4
	unlk	%fp
	rts

str_1000a268:
	.byte	0x10
	.ascii	"override library"
	.byte	0x00

sub_1000a27a:
	linkw	%fp,#-8
	moveml	%d3/%d6-%d7/%a3-%a4,%sp@-
	moveb	%fp@(15),%d6
	moveal	%fp@(8),%a3
	subql	#4,%sp
	movew	%a3@(2),%sp@-
	movew	#2048,%d0
	andw	%a3@(2),%d0
	moveq	#0,%d1
	movew	%d0,%d1
	cmpil	#2048,%d1
	seq	%d3
	negb	%d3
	moveb	%d3,%sp@-
	jsr	%pc@(sub_1000313a)
	movel	%sp@+,%fp@(-8)
	moveal	%a3,%a0
	addql	#4,%a0
	movel	%a0,%fp@(-4)
	moveq	#0,%d7
	bras	.L1000a314

.L1000a2bc:
	moveal	%fp@(-4),%a0
	movel	%d7,%d0
	lsll	#2,%d0
	movel	%d0,%d1
	lsll	#2,%d0
	addl	%d1,%d0
	lea	%a0@(12,%d0:l),%a4
	moveq	#0,%d0
	movew	%a4@(6),%d0
	moveq	#4,%d1
	andw	%d0,%d1
	moveq	#0,%d0
	movew	%d1,%d0
	tstl	%d0
	bnes	.L1000a310
	tstb	%a4@(5)
	bnes	.L1000a2f2
	tstl	%a4@(8)
	bnes	.L1000a2f2
	movel	%fp@(-8),%a4@(8)

.L1000a2f2:
	tstb	%d6
	beqs	.L1000a310
	moveq	#0,%d0
	movew	%a4@(6),%d0
	moveq	#64,%d1
	andw	%d0,%d1
	beqs	.L1000a310
	moveq	#0,%d0
	movew	%a4@(6),%d0
	moveq	#4,%d1
	orw	%d0,%d1
	movew	%d1,%a4@(6)

.L1000a310:
	movel	%d7,%d0
	addql	#1,%d7

.L1000a314:
	moveq	#0,%d0
	movew	%a3@(14),%d0
	cmpl	%d7,%d0
	bges	.L1000a2bc
	moveml	%fp@(-28),%d3/%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000a328:
	linkw	%fp,#-4
	moveml	%d3/%d5-%d7/%a3-%a4,%sp@-
	moveb	%fp@(15),%d5
	clrw	%d7
	moveal	%fp@(8),%a0
	movel	%a0,%fp@(-4)
	lea	%a0@(56),%a4
	clrw	%d6
	bras	.L1000a3ac

.L1000a346:
	moveq	#0,%d0
	movew	%a4@(4),%d0
	cmpil	#43774,%d0
	beqs	.L1000a358
	moveq	#-50,%d7
	bras	.L1000a3b8

.L1000a358:
	moveq	#0,%d0
	moveb	%d5,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000a27a)
	pea	%a4@(4)
	movew	%a4@(2),%sp@-
	movew	#2048,%d0
	andw	%a4@(2),%d0
	moveq	#0,%d1
	movew	%d0,%d1
	cmpil	#2048,%d1
	seq	%d3
	negb	%d3
	moveb	%d3,%sp@-
	jsr	%pc@(sub_1000314e)
	moveal	%a4,%a3
	lea	0xc,%a0
	addqw	#4,%a0
	moveq	#0,%d0
	movew	%a4@(14),%d0
	addql	#1,%d0
	lsll	#2,%d0
	movel	%d0,%d1
	lsll	#2,%d0
	addl	%d1,%d0
	addl	%a0,%d0
	addal	%d0,%a3
	moveal	%a3,%a4
	addqw	#8,%sp
	movew	%d6,%d0
	addqw	#1,%d6

.L1000a3ac:
	extl	%d6
	moveal	%fp@(-4),%a0
	cmpl	%a0@(52),%d6
	blts	.L1000a346

.L1000a3b8:
	movew	%d7,%d0
	moveml	%fp@(-28),%d3/%d5-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000a3c4:
	linkw	%fp,#-282
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a4
	moveq	#0,%d0
	moveal	%d0,%a3
	moveq	#1,%d6
	cmpiw	#1000,%a4@(4)
	bgts	.L1000a44c
	moveq	#0,%d0
	movel	%d0,%fp@(-282)
	moveal	%a4@(6),%a0
	movel	%a0@,%fp@(-278)
	subql	#4,%sp
	movel	%a4@(6),%sp@-
	jsr	%pc@(sub_10003106)
	movel	%sp@+,%fp@(-274)
	clrb	%fp@(-270)
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-282)
	pea	%a4@(10)
	movel	%d0,%sp@-
	movel	#1886875747,%sp@-
	pea	%fp@(-266)
	pea	%fp@(-4)
	pea	%fp@(-5)
	pea	%fp@(-262)
	movew	#-2,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000a434
	tstl	%fp@(-4)
	bnes	.L1000a444

.L1000a434:
	clrb	%d6
	tstw	%d7
	beqs	.L1000a444
	cmpiw	#-2821,%d7
	beqs	.L1000a444
	lea	%pc@(str_1000a458),%a0

.L1000a444:
	tstb	%d6
	beqs	.L1000a44c
	moveal	%fp@(-4),%a3

.L1000a44c:
	movel	%a3,%d0
	moveml	%fp@(-298),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

str_1000a458:
	.byte	0x0d
	.ascii	"ntrb resource"
	.short	0x0000

sub_1000a468:
	linkw	%fp,#-16
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	moveq	#0,%d0
	movel	%d0,%fp@(-16)
	moveal	%a4@(6),%a0
	movel	%a0@,%fp@(-12)
	subql	#4,%sp
	movel	%a4@(6),%sp@-
	jsr	%pc@(sub_10003106)
	movel	%sp@+,%fp@(-8)
	clrb	%fp@(-4)
	pea	%a4@(10)
	jsr	%pc@(sub_1000b34e)
	tstb	%fp@(15)
	addqw	#4,%sp
	bnes	.L1000a4b0
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000b3b6)
	movew	%d0,%d7
	addqw	#4,%sp
	bras	.L1000a4b2

.L1000a4b0:
	clrw	%d7

.L1000a4b2:
	tstw	%d7
	bnes	.L1000a4d0
	subql	#2,%sp
	pea	%fp@(-16)
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%a4@(10)
	moveq	#0,%d1
	moveb	%d1,%sp@-
	movew	#-4,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7

.L1000a4d0:
	movew	%d7,%d0
	moveml	%fp@(-24),%d7/%a4
	unlk	%fp
	rts

sub_1000a4dc:
	linkw	%fp,#-16
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	moveq	#0,%d0
	movel	%d0,%fp@(-16)
	moveal	%a4@(6),%a0
	movel	%a0@,%fp@(-12)
	subql	#4,%sp
	movel	%a4@(6),%sp@-
	jsr	%pc@(sub_10003106)
	movel	%sp@+,%fp@(-8)
	clrb	%fp@(-4)
	subql	#2,%sp
	pea	%fp@(-16)
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%a4@(10)
	moveq	#0,%d1
	moveb	%d1,%sp@-
	movew	#-4,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000a568
	moveq	#50,%d0
	cmpw	%a4@(4),%d0
	bnes	.L1000a568
	cmpiw	#-2805,%d7
	bnes	.L1000a568
	subql	#2,%sp
	pea	%fp@(-16)
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%a4@(10)
	moveq	#1,%d1
	moveb	%d1,%sp@-
	movew	#-4,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000a568
	subql	#2,%sp
	pea	%fp@(-16)
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%a4@(10)
	moveq	#0,%d1
	moveb	%d1,%sp@-
	movew	#-4,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7

.L1000a568:
	movew	%d7,%d0
	moveml	%fp@(-24),%d7/%a4
	unlk	%fp
	rts

sub_1000a574:
	linkw	%fp,#0
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000a4dc)
	movew	%d0,%d7
	addqw	#4,%sp
	tstw	%d7
	bnes	.L1000a59a
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000a010)
	movew	%d0,%d7
	addqw	#4,%sp
	tstw	%d7

.L1000a59a:
	movew	%d7,%d0
	moveml	%fp@(-8),%d7/%a4
	unlk	%fp
	rts

sub_1000a5a6:
	linkw	%fp,#0
	moveml	%d5-%d7/%a4,%sp@-
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000a3c4)
	moveal	%d0,%a4
	movel	%a4,%d0
	addqw	#4,%sp
	bnes	.L1000a5c2
	moveq	#0,%d0
	bras	.L1000a5e2

.L1000a5c2:
	clrb	%d6
	movew	%sr,%d0
	oriw	#1792,%sr
	movew	%d0,%d7
	moveq	#0,%d0
	moveb	%d6,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000a328)
	movew	%d0,%d5
	movew	%d7,%sp@-
	movew	%sp@+,%sr
	movew	%d5,%d0
	addqw	#8,%sp

.L1000a5e2:
	moveml	%fp@(-16),%d5-%d7/%a4
	unlk	%fp
	rts

sub_1000a5ec:
	linkw	%fp,#-6
	moveml	%d6-%d7/%a3-%a4,%sp@-
	movew	%fp@(18),%d6
	movel	%fp@(12),%d7
	moveal	%fp@(8),%a4
	subql	#4,%sp
	movel	%d7,%sp@-
	movew	%d6,%sp@-
	_GetResource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqs	.L1000a650
	movel	%a3,%sp@-
	pea	%fp@(-2)
	pea	%fp@(-6)
	pea	%a4@(10)
	_GetResInfo
	moveq	#0,%d0
	moveb	%a4@(10),%d0
	cmpib	#63,%d0
	blss	.L1000a630
	moveb	#63,%a4@(10)

.L1000a630:
	moveal	%a3,%a0
	_MoveHHi
	moveal	%a3,%a0
	_HLock
	movel	%a3,%sp@-
	_DetachResource
	movel	%d7,%a4@
	movew	%d6,%a4@(4)
	movel	%a3,%a4@(6)
	moveq	#0,%d0
	movel	%d0,%a4@(266)
	moveq	#0,%d0
	bras	.L1000a664

.L1000a650:
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L1000a65e
	movew	#-192,%d0
	bras	.L1000a664

.L1000a65e:
	subql	#2,%sp
	_ResError
	movew	%sp@+,%d0

.L1000a664:
	moveml	%fp@(-22),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000a66e:
	linkw	%fp,#-546
	moveml	%d6-%d7/%a2-%a4,%sp@-
	lea	%fp@(-262),%a3
	subql	#4,%sp
	movel	%fp@(12),%sp@-
	movew	%fp@(10),%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	bnes	.L1000a694
	movew	#-192,%d7
	braw	.L1000a730

.L1000a694:
	_GetZone
	moveal	%a0,%a2
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	movel	%a4,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	movel	%a3,%sp@-
	_GetResInfo
	moveq	#0,%d0
	moveb	%a3@,%d0
	cmpib	#63,%d0
	blss	.L1000a6be
	moveb	#63,%a3@

.L1000a6be:
	movel	%a4,%sp@-
	_DetachResource
	moveal	%a4,%a0
	_MoveHHi
	moveal	%a4,%a0
	_HLock
	subql	#4,%sp
	movel	%a4,%sp@-
	jsr	%pc@(sub_10003106)
	movel	%sp@+,%d6
	subql	#2,%sp
	movel	%a4@,%sp@-
	movel	%d6,%sp@-
	movel	%a3,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-526)
	pea	%fp@(-522)
	pea	%fp@(-518)
	movew	#3,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000a724
	moveq	#0,%d0
	movel	%d0,%fp@(-546)
	movel	%a4@,%fp@(-542)
	movel	%d6,%fp@(-538)
	clrb	%fp@(-534)
	subql	#2,%sp
	pea	%fp@(-546)
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	movew	#-4,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000a72c
	bras	.L1000a72c

.L1000a724:
	tstb	%fp@(8)
	moveal	%a4,%a0
	_DisposeHandle

.L1000a72c:
	moveal	%a2,%a0
	_SetZone

.L1000a730:
	movew	%d7,%fp@(16)
	moveml	%fp@(-566),%d6-%d7/%a2-%a4
	unlk	%fp
	rtd	#8

sub_1000a740:
	linkw	%fp,#-282
	moveml	%d4-%d7,%sp@-
	movew	%fp@(8),%d4
	movew	%fp@(12),%d5
	clrw	%d7
	cmpiw	#8,%d5
	blts	.L1000a75e
	cmpiw	#12,%d5
	bles	.L1000a768

.L1000a75e:
	movew	#-50,%fp@(14)
	braw	.L1000a852

.L1000a768:
	movew	%d5,%d0
	subqw	#8,%d0
	bmis	.L1000a7ae
	cmpiw	#4,%d0
	bgts	.L1000a7ae
	addw	%d0,%d0
	movew	%pc@(off_1000a77e,%d0:w),%d0
	jmp	%pc@(%d0:w)

off_1000a77e:
	.short	.L1000a788-off_1000a77e+2
	.short	.L1000a790-off_1000a77e+2
	.short	0x001C,0x002C,0x0024

.L1000a788:
	.short	0x2C3C,0x7366,0x7672,0x601E

.L1000a790:
	.short	0x2C3C,0x666F,0x7672,0x6016,0x2C3C,0x6E6C,0x6962,0x600E
	.short	0x2C3C,0x6E63,0x6F64,0x6006,0x2C3C,0x6E74,0x7262

.L1000a7ae:
	.short	0x302E
	.short	0x000A,0x48C0,0x2F00,0x2F06,0x486E,0xFEE6,0x4EBA,0xFE2E
	.short	0x3E00,0x4FEF,0x000C,0x6600,0x0086,0x3005,0x5140,0x6B7E
	.short	0x0C40,0x0004,0x6E78,0xD040,0x303B,0x0006,0x4EFB,0x0000
	.short	0x000C,0x001E,0x003A,0x0064,0x0056,0x7000,0x2F00,0x486E
	.short	0xFEE6,0x4EBA,0xF8CA,0x3E00,0x504F,0x6052,0x7000,0x3004
	.short	0x7201,0xC240,0x7000,0x3001,0x2F00,0x486E,0xFEE6,0x4EBA
	.short	0xF8AE,0x3E00,0x504F,0x6036,0x7000,0x3004,0x7201,0xC240
	.short	0x7000,0x3001,0x2F00,0x486E,0xFEE6,0x4EBA,0xFC3C,0x3E00
	.short	0x504F,0x601A,0x486E,0xFEE6,0x4EBA,0xFD3A,0x3E00,0x584F
	.short	0x600C,0x486E,0xFEE6,0x4EBA,0xFD5E,0x3E00,0x584F,0x3D47
	.short	0x000E

.L1000a852:
	moveml	%fp@(-298),%d4-%d7
	unlk	%fp
	rtd	#6

sub_1000a85e:
	linkw	%fp,#-14
	moveml	%d7/%a2-%a4,%sp@-
	moveal	%fp@(16),%a2
	moveal	%fp@(12),%a3
	moveal	%fp@(8),%a4
	clrw	%d7
	moveq	#0,%d0
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-4)
	movel	%a4,%d0
	bnes	.L1000a888
	moveq	#-50,%d7
	braw	.L1000a90e

.L1000a888:
	movel	%a2,%d0
	bnes	.L1000a8ca
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_1000a930)
	pea	%fp@(-13)
	pea	%fp@(-12)
	pea	%fp@(-8)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000a90e
	subql	#4,%sp
	moveq	#3,%d0
	moveb	%d0,%sp@-
	moveb	#0x82,%sp@-
	movel	%a4,%sp@-
	movel	%a3,%sp@-
	moveal	%fp@(-8),%a0
	jsr	%a0@
	movel	%sp@+,%d0
	movew	%d0,%d7
	bnes	.L1000a90e
	bras	.L1000a90e

.L1000a8ca:
	jsr	%pc@(sub_10009fe4)
	movel	%d0,%a2@
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_1000a91a)
	pea	%fp@(-13)
	pea	%fp@(-12)
	pea	%fp@(-4)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000a90e
	moveal	%fp@(-4),%a0
	movew	#-21926,%d0
	_SetToolTrapAddress
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	movel	%a3,%sp@-
	movew	#-17,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7

.L1000a90e:
	movew	%d7,%d0
	moveml	%fp@(-30),%d7/%a2-%a4
	unlk	%fp
	rts

str_1000a91a:
	.byte	0x13
	.string	"_CFM68KTrapHandler_"
	.align	2

str_1000a930:
	.byte	0x18
	.string	"CFragInitializationRDesc"

sub_1000a94a:
	linkw	%fp,#-92
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d6
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1886545254,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-90)
	pea	%fp@(-84)
	moveq	#0,%d0
	_AliasDispatch
	tstw	%sp@+
	bnew	.L1000aaca
	subql	#2,%sp
	movew	%fp@(-90),%sp@-
	movel	%fp@(-84),%sp@-
	pea	%pc@(str_1000aaf0)
	moveq	#3,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d7
	cmpiw	#-1,%d7
	bnes	.L1000a9d2
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1835098995,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-92)
	pea	%fp@(-88)
	moveq	#0,%d0
	_AliasDispatch
	tstw	%sp@+
	bnew	.L1000aaca
	subql	#2,%sp
	movew	%fp@(-92),%sp@-
	movel	%fp@(-88),%sp@-
	pea	%pc@(str_1000aaf0)
	moveq	#3,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d7

.L1000a9d2:
	cmpiw	#-1,%d7
	bnew	.L1000aa8e
	movew	%fp@(-90),%sp@-
	movel	%fp@(-84),%sp@-
	pea	%pc@(str_1000aaf0)
	_HCreateResFile
	subql	#2,%sp
	movew	%fp@(-90),%sp@-
	movel	%fp@(-84),%sp@-
	pea	%pc@(str_1000aaf0)
	moveq	#3,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d7
	cmpiw	#-1,%d7
	beqw	.L1000aaca
	lea	%pc@(str_1000aaf0),%a0
	movel	%a0,%fp@(-62)
	movew	%fp@(-90),%fp@(-58)
	clrw	%fp@(-52)
	movel	%fp@(-84),%fp@(-32)
	lea	%fp@(-80),%a0
	_PBHGetFInfoSync
	tstw	%d0
	bnes	.L1000aa5a
	lea	%pc@(str_1000aaf0),%a0
	movel	%a0,%fp@(-62)
	movew	%fp@(-90),%fp@(-58)
	clrw	%fp@(-52)
	movel	%fp@(-84),%fp@(-32)
	movel	#1314210371,%fp@(-48)
	movel	#1853186659,%fp@(-44)
	clrw	%fp@(-40)
	lea	%fp@(-80),%a0
	_PBHSetFInfoSync

.L1000aa5a:
	moveq	#16,%d0
	_NewHandle
	moveal	%a0,%a4
	movel	%a4,%d0
	bnes	.L1000aa6e
	movew	%d7,%sp@-
	_CloseResFile
	movew	%d6,%sp@-
	_UseResFile
	bras	.L1000aaca

.L1000aa6e:
	moveal	%a4@,%a0
	moveal	%a3,%a1
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a4,%sp@-
	movel	#1851941734,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	pea	%pc@(str_1000aad4)
	_AddResource
	bras	.L1000aac2

.L1000aa8e:
	subql	#4,%sp
	movel	#1851941734,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	tstb	%fp@(15)
	beqs	.L1000aab6
	moveal	%a4@,%a0
	moveal	%a3,%a1
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a4,%sp@-
	_ChangedResource
	bras	.L1000aac2

.L1000aab6:
	moveal	%a4@,%a0
	moveal	%a3,%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+

.L1000aac2:
	movew	%d7,%sp@-
	_CloseResFile
	movew	%d6,%sp@-
	_UseResFile

.L1000aaca:
	moveml	%fp@(-108),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

str_1000aad4:
	.byte	0x1a
	.string	"Debugger Nub Configuration"

str_1000aaf0:	
	.byte	0x18
	.string	"Debugger Nub Preferences"

sub_1000ab0a:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveal	%fp@(12),%a4
	clrb	%a4@
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000a94a)
	movew	%fp@(10),%d0
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_1000ab2c:
	linkw	%fp,#-30
	moveml	%d7/%a3-%a4,%sp@-
	movel	%fp@(8),%d7
	lea	%fp@(-26),%a3
	movew	#0x4ed0,%a3@(24)	/* jmp		%a0@ */
	movew	#0x504f,%a3@(22)	/* addqw	#8,%sp */
	movew	#0x205f,%a3@(20)	/* moveal	%sp@+,%a0 */
	movew	#0x4e5e,%a3@(18)	/* unlk		%fp */
	movew	#0x0010,%a3@(16)
	movew	#0x426e,%a3@(14)	/* clrw		%fp@(16) */
	movew	#0xffff,%a3@(12)
	movew	#0x1111,%a3@(10)
	movew	#0x20bc,%a3@(8)		/* movel	#0x1111ffff,%a0@ */
	movew	#0x0008,%a3@(6)
	movew	#0x206e,%a3@(4)		/* moveal	%fp@(8),%a0 */
	clrw	%a3@(2)
	movew	#0x4e56,%a3@		/* linkw	%fp,#0 */
	moveq	#26,%d0
	_NewPtrSys
	moveal	%a0,%a4
	movel	%a4,%d0
	bnes	.L1000ab94
	moveq	#-108,%d0
	bras	.L1000abde

.L1000ab94:
	moveq	#16,%d0
	movel	%d7,%d1
	lsrl	%d0,%d1
	movew	%d1,%a3@(10)
	movew	%d7,%a3@(12)
	moveal	%a3,%a0
	moveal	%a4,%a1
	moveq	#26,%d0
	_BlockMove
	movel	#_fcc_cnfn,%d0
	moveal	%a4,%a0
	lea	%fp@(-30),%a1
	movel	%a1,%sp@-
	_ReplaceGestalt
	moveal	%sp@+,%a1
	movel	%a0,%a1@
	movew	%d0,%d7
	bnes	.L1000abca
	moveal	%fp@(-30),%a0
	_DisposePtr
	bras	.L1000abdc

.L1000abca:
	cmpiw	#-5551,%d7
	bnes	.L1000abdc
	movel	#_fcc_cnfn,%d0
	moveal	%a4,%a0
	_NewGestalt
	movew	%d0,%d7

.L1000abdc:
	movew	%d7,%d0

.L1000abde:
	moveml	%fp@(-42),%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000abe8:
	linkw	%fp,#-30
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	movel	%d0,%fp@(-8)
	clrw	%fp@(-10)
	clrw	%fp@(-12)
	moveb	#1,%fp@(-13)
	clrb	%fp@(-14)
	clrb	%fp@(-15)
	moveb	#1,%fp@(-16)
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-16)
	jsr	%pc@(sub_1000a94a)
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_1000acc6)
	pea	%fp@(-29)
	pea	%fp@(-28)
	pea	%fp@(-24)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	addqw	#8,%sp
	bnes	.L1000ac5c
	moveal	%fp@(-24),%a0
	lea	%fp@(-16),%a1
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	movel	%a1@+,%a0@+
	bras	.L1000ac6c

.L1000ac5c:
	pea	%fp@(-16)
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000ab0a)
	addqw	#8,%sp
	bras	.L1000acac

.L1000ac6c:
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%pc@(str_1000acb6)
	pea	%fp@(-29)
	pea	%fp@(-28)
	pea	%fp@(-20)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000ac9a
	movel	%fp@(-20),%sp@-
	jsr	%pc@(sub_1000ab2c)
	addqw	#4,%sp
	bras	.L1000acac

.L1000ac9a:
	pea	%fp@(-16)
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000ab0a)
	addqw	#8,%sp
	bras	.L1000acac

.L1000acaa:
	movew	%d7,%d0

.L1000acac:
	moveml	%fp@(-38),%d7/%a4
	unlk	%fp
	rts

str_1000acb6:
	.byte	0x0d
	.string	"llNubConfigFn"
	.align	2

str_1000acc6:
	.byte	0x12
	.string	"llNubStartupConfig"

sub_1000acda:
	linkw	%fp,#-30
	moveml	%d5-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	moveq	#5,%d0
	_MoveFromECR
	moveal	%a0,%a4
	tstl	%fp@(12)
	bnes	.L1000acf8
	moveq	#-1,%d0
	braw	.L1000ae1c

.L1000acf8:
	movel	%a4@(76),%d5
	movel	%fp@(12),%a4@(76)
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_1000ae6e)
	pea	%fp@(-29)
	pea	%fp@(-28)
	pea	%fp@(-24)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000ad30
	movel	%a4@(84),%d6
	movel	%fp@(-24),%a4@(84)
	bras	.L1000ad3c

.L1000ad30:
	moveq	#0,%d0
	movel	%d0,%a4@(76)
	movew	%d7,%d0
	braw	.L1000ae1c

.L1000ad3c:
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_1000ae56)
	pea	%fp@(-29)
	pea	%fp@(-28)
	pea	%fp@(-16)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000ad66
	moveal	%fp@(-16),%a0
	movel	%d5,%a0@
	bras	.L1000ad6e

.L1000ad66:
	moveal	%fp@(-16),%a0
	moveq	#0,%d0
	movel	%d0,%a0@

.L1000ad6e:
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_1000ae3e)
	pea	%fp@(-29)
	pea	%fp@(-28)
	pea	%fp@(-12)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000ad98
	moveal	%fp@(-12),%a0
	movel	%d6,%a0@
	bras	.L1000ada0

.L1000ad98:
	moveal	%fp@(-12),%a0
	moveq	#0,%d0
	movel	%d0,%a0@

.L1000ada0:
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_1000ae32)
	pea	%fp@(-29)
	pea	%fp@(-28)
	pea	%fp@(-20)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000adcc
	moveal	%fp@(-20),%a0
	movel	%a0@,%a4@(4)
	bras	.L1000add6

.L1000adcc:
	moveq	#0,%d0
	movel	%d0,%a4@(76)
	movew	%d7,%d0
	bras	.L1000ae1c

.L1000add6:
	movel	#1668314484,%d0
	lea	%fp@(-8),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L1000ae14
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	pea	%pc@(str_1000ae26)
	pea	%fp@(-29)
	pea	%fp@(-28)
	pea	%fp@(-4)
	movew	#-10,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000ae14
	moveal	%fp@(-4),%a0
	movel	%fp@(-8),%a0@

.L1000ae14:
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000abe8)
	addqw	#4,%sp

.L1000ae1c:
	moveml	%fp@(-50),%d5-%d7/%a3-%a4
	unlk	%fp
	rts

str_1000ae26:
	.byte	0x0a
	.string	"nubCPUType"

str_1000ae32:
	.byte	0x0a
	.string	"nubEnables"

str_1000ae3e:
	.byte	0x16
	.string	"processMgrHandlerParam"

str_1000ae56:
	.byte	0x15
	.string	"processMgrHandlerAddr"
	.align	2

str_1000ae6e:
	.byte	0x05
	.string	"nubPB"
	.align	2

sub_1000ae76:	
	linkw	%fp,#-4
	moveml	%d4-%d5/%a2-%a4,%sp@-
	moveal	%fp@(8),%a3
	movel	%fp@(16),%d4
	movel	%fp@(12),%d5
	movel	%a3,%d0
	beqs	.L1000ae92
	tstl	%a3@
	bnes	.L1000ae96

.L1000ae92:
	moveq	#0,%d0
	bras	.L1000aec4

.L1000ae96:
	moveal	%a3@,%a2
	movel	%a2@,%d2
	lea	%a2@(4),%a4
	bras	.L1000aebe

.L1000aea0:
	cmpl	%a4@,%d5
	bnes	.L1000aeb8
	movel	%a4@(4),%d1
	cmpl	%d1,%d4
	beqs	.L1000aeb4
	cmpil	#1061109567,%d1
	bnes	.L1000aeb8

.L1000aeb4:
	moveq	#1,%d0
	bras	.L1000aec4

.L1000aeb8:
	movel	%d2,%d0
	subql	#1,%d2
	addqw	#8,%a4

.L1000aebe:
	tstl	%d2
	bhis	.L1000aea0
	moveq	#0,%d0

.L1000aec4:
	moveml	%fp@(-24),%d4-%d5/%a2-%a4
	unlk	%fp
	rts

sub_1000aece:
	linkw	%fp,#-290
	moveml	%d3-%d7/%a4,%sp@-
	movew	%fp@(14),%d4
	clrw	%d7
	movew	%d4,%d0
	subqw	#8,%d0
	bmis	.L1000af34
	cmpiw	#9,%d0
	bgts	.L1000af34
	addw	%d0,%d0
	movew	%pc@(off_1000aef2,%d0:w),%d0
	jmp	%pc@(%d0:w)

off_1000aef2:
	.short	.L1000af06-off_1000aef2+2
	.short	.L1000af0e-off_1000aef2+2
	.short	.L1000af16-off_1000aef2+2
	.short	.L1000af2e-off_1000aef2+2
	.short	.L1000af26-off_1000aef2+2
	.short	.L1000af34-off_1000aef2+2
	.short	.L1000af34-off_1000aef2+2
	.short	.L1000af34-off_1000aef2+2
	.short	.L1000af34-off_1000aef2+2
	.short	.L1000af1e-off_1000aef2+2

.L1000af06:
	movel	#0x73667672,%d5
	bras	.L1000af34

.L1000af0e:
	movel	#1718580850,%d5
	bras	.L1000af34

.L1000af16:
	movel	#1852598626,%d5
	bras	.L1000af34

.L1000af1e:
	movel	#1869375842,%d5
	bras	.L1000af34

.L1000af26:
	movel	#1852010340,%d5
	bras	.L1000af34

.L1000af2e:
	movel	#1853125218,%d5

.L1000af34:
	movew	%fp@(10),%sp@-
	_UseResFile
	subql	#2,%sp
	movel	%d5,%sp@-
	_Count1Resources
	movew	%sp@+,%d3
	moveq	#1,%d6
	braw	.L1000b02a

.L1000af48:
	subql	#4,%sp
	movel	%d5,%sp@-
	movew	%d6,%sp@-
	_Get1IndResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqw	.L1000b026
	movel	%a4,%sp@-
	pea	%fp@(-284)
	pea	%fp@(-288)
	pea	%fp@(-272)
	_GetResInfo
	moveq	#0,%d0
	moveb	%fp@(-272),%d0
	cmpib	#63,%d0
	blss	.L1000af7a
	moveb	#63,%fp@(-272)

.L1000af7a:
	movel	%d5,%fp@(-282)
	movew	%fp@(-284),%fp@(-278)
	movel	%a4,%fp@(-276)
	moveq	#0,%d0
	movel	%d0,%fp@(-16)
	moveal	%a4,%a0
	_HLock
	movel	%a4,%sp@-
	_DetachResource
	movew	%d4,%d0
	subqw	#8,%d0
	bmiw	.L1000b026
	cmpiw	#9,%d0
	bgtw	.L1000b026
	addw	%d0,%d0
	movew	%pc@(off_1000afb0,%d0:w),%d0
	jmp	%pc@(%d0:w)

off_1000afb0:
	.short	.L1000afc4-off_1000afb0+2
	.short	.L1000afd6-off_1000afb0+2
	.short	.L1000afe8-off_1000afb0+2
	.short	.L1000b01a-off_1000afb0+2
	.short	.L1000b00c-off_1000afb0+2
	.short	.L1000b026-off_1000afb0+2
	.short	.L1000b026-off_1000afb0+2
	.short	.L1000b026-off_1000afb0+2
	.short	.L1000b026-off_1000afb0+2
	.short	.L1000affa-off_1000afb0+2

.L1000afc4:
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-282)
	jsr	%pc@(sub_1000a0be)
	movew	%d0,%d7
	addqw	#8,%sp
	bras	.L1000b026

.L1000afd6:
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-282)
	jsr	%pc@(sub_1000a0be)
	movew	%d0,%d7
	addqw	#8,%sp
	bras	.L1000b026

.L1000afe8:
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-282)
	jsr	%pc@(sub_1000a468)
	movew	%d0,%d7
	addqw	#8,%sp
	bras	.L1000b026

.L1000affa:
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-282)
	jsr	%pc@(sub_1000a468)
	movew	%d0,%d7
	addqw	#8,%sp
	bras	.L1000b026

.L1000b00c:
	pea	%fp@(-282)
	jsr	%pc@(sub_1000a574)
	movew	%d0,%d7
	addqw	#4,%sp
	bras	.L1000b026

.L1000b01a:
	pea	%fp@(-282)
	jsr	%pc@(sub_1000a5a6)
	movew	%d0,%d7
	addqw	#4,%sp

.L1000b026:
	movew	%d6,%d0
	addqw	#1,%d6

.L1000b02a:
	cmpw	%d6,%d3
	bgew	.L1000af48
	movew	%d7,%d0
	moveml	%fp@(-314),%d3-%d7/%a4
	unlk	%fp
	rts

sub_1000b03c:
	linkw	%fp,#-370
	moveml	%d5-%d7/%a3-%a4,%sp@-
	lea	%fp@(-256),%a3
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1702392942,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-262)
	pea	%fp@(-260)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d6
	bnew	.L1000b158
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d5
	subql	#4,%sp
	movel	#1735293044,%sp@-
	movew	#-16384,%sp@-
	_Get1Resource
	moveal	%sp@+,%a4
	movel	%a3,%fp@(-352)
	movew	%fp@(-262),%fp@(-348)
	movel	%fp@(-260),%fp@(-322)
	movew	#1,%fp@(-342)
	braw	.L1000b146

.L1000b09a:
	lea	%fp@(-370),%a0
	moveq	#9,%d0
	_HFSDispatch
	movew	%d0,%d6
	bnew	.L1000b146
	moveq	#16,%d0
	andb	%fp@(-340),%d0
	moveq	#0,%d1
	moveb	%d0,%d1
	tstl	%d1
	bnew	.L1000b138
	movel	%fp@(-334),%sp@-
	movel	%fp@(-338),%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000ae76)
	tstb	%d0
	lea	%sp@(12),%sp
	beqs	.L1000b138
	subql	#2,%sp
	movew	%fp@(-262),%sp@-
	movel	%fp@(-260),%sp@-
	movel	%fp@(-352),%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d7
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L1000b138
	moveq	#8,%d0
	movel	%d0,%sp@-
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000aece)
	moveq	#9,%d0
	movel	%d0,%sp@-
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000aece)
	moveq	#10,%d0
	movel	%d0,%sp@-
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000aece)
	moveq	#17,%d0
	movel	%d0,%sp@-
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000aece)
	moveq	#12,%d0
	movel	%d0,%sp@-
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000aece)
	moveq	#11,%d0
	movel	%d0,%sp@-
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000aece)
	lea	%sp@(48),%sp

.L1000b138:
	movew	%fp@(-342),%d0
	addqw	#1,%fp@(-342)
	movel	%fp@(-260),%fp@(-322)

.L1000b146:
	tstw	%d6
	beqw	.L1000b09a
	movel	%a4,%d0
	beqs	.L1000b154
	movel	%a4,%sp@-
	_ReleaseResource

.L1000b154:
	movew	%d5,%sp@-
	_UseResFile

.L1000b158:
	movew	%d6,%fp@(8)
	moveml	%fp@(-390),%d5-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000b166:
	linkw	%fp,#-62
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(12),%a4
	subql	#2,%sp
	movel	%fp@(8),%sp@-
	_HomeResFile
	movew	%sp@+,%d7
	bnes	.L1000b182
	moveq	#2,%d7
	bras	.L1000b18c

.L1000b182:
	cmpiw	#1,%d7
	bnes	.L1000b18c
	moveq	#-50,%d0
	bras	.L1000b1b6

.L1000b18c:
	moveal	%a4,%a0
	addql	#6,%a0
	movel	%a0,%fp@(-44)
	clrw	%fp@(-40)
	movew	%d7,%fp@(-38)
	clrw	%fp@(-34)
	lea	%fp@(-62),%a0
	moveq	#8,%d0
	_HFSDispatch
	movew	%d0,%d7
	movew	%fp@(-10),%a4@
	movel	%fp@(-4),%a4@(2)
	movew	%d7,%d0

.L1000b1b6:
	moveml	%fp@(-70),%d7/%a4
	unlk	%fp
	rts

sub_1000b1c0:
	linkw	%fp,#-356
	moveml	%d5-%d7/%a2-%a4,%sp@-
	subql	#4,%sp
	movel	#1667658343,%sp@-
	movew	%fp@(8),%sp@-
	_Get1Resource
	moveal	%sp@+,%a2
	movel	%a2,%d0
	bnes	.L1000b1e4
	movew	#-192,%d7
	braw	.L1000b27a

.L1000b1e4:
	pea	%fp@(-356)
	movel	%a2,%sp@-
	jsr	%pc@(sub_1000b166)
	movew	%d0,%d7
	addqw	#8,%sp
	tstw	%d7
	bnew	.L1000b27a
	moveal	%a2,%a0
	_HGetState
	moveb	%d0,%d5
	moveal	%a2,%a0
	_HLock
	moveal	%a2@,%a0
	moveq	#0,%d6
	movew	%a0@(30),%d6
	tstl	%d6
	lea	%a0@(32),%a4
	bras	.L1000b270

.L1000b212:
	moveq	#0,%d0
	moveb	%a4@(23),%d0
	cmpiw	#1,%d0
	bnes	.L1000b262
	lea	%fp@(-20),%a3
	moveq	#1,%d0
	movel	%d0,%a3@
	lea	%fp@(-356),%a0
	movel	%a0,%a3@(4)
	movel	%a4@(24),%a3@(8)
	movel	%a4@(28),%a3@(12)
	lea	%a4@(42),%a0
	lea	%fp@(-276),%a1
	moveq	#0,%d0
	moveb	%a4@(42),%d0
	addqw	#1,%d0
	extl	%d0
	_BlockMoveData
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-286)
	jsr	%pc@(sub_1000a0be)
	movew	%d0,%d7
	addqw	#8,%sp
	tstw	%d7
	bnes	.L1000b27a

.L1000b262:
	movel	%d6,%d0
	subql	#1,%d6
	moveq	#0,%d0
	movew	%a4@(40),%d0
	addl	%a4,%d0
	moveal	%d0,%a4

.L1000b270:
	tstl	%d6
	bgts	.L1000b212
	moveal	%a2,%a0
	moveb	%d5,%d0
	_HSetState

.L1000b27a:
	movew	%d7,%fp@(10)
	moveml	%fp@(-380),%d5-%d7/%a2-%a4
	unlk	%fp
	rtd	#2

sub_1000b28a:
	linkw	%fp,#-356
	moveml	%d4-%d7/%a2-%a4,%sp@-
	subql	#4,%sp
	movel	#1667658343,%sp@-
	movew	%fp@(10),%sp@-
	_Get1Resource
	moveal	%sp@+,%a2
	movel	%a2,%d0
	bnes	.L1000b2ae
	movew	#-192,%d6
	braw	.L1000b342

.L1000b2ae:
	pea	%fp@(-352)
	movel	%a2,%sp@-
	jsr	%pc@(sub_1000b166)
	movew	%d0,%d6
	addqw	#8,%sp
	bnew	.L1000b342
	moveal	%a2,%a0
	_HGetState
	moveb	%d0,%d4
	moveal	%a2,%a0
	_HLock
	moveal	%a2@,%a0
	moveq	#0,%d5
	movew	%a0@(30),%d5
	tstl	%d5
	lea	%a0@(32),%a4
	bras	.L1000b338

.L1000b2da:
	moveq	#0,%d0
	moveb	%a4@(23),%d0
	cmpiw	#1,%d0
	bnes	.L1000b32a
	lea	%fp@(-16),%a3
	moveq	#1,%d0
	movel	%d0,%a3@
	lea	%fp@(-352),%a0
	movel	%a0,%a3@(4)
	movel	%a4@(24),%a3@(8)
	movel	%a4@(28),%a3@(12)
	lea	%a4@(42),%a0
	lea	%fp@(-272),%a1
	moveq	#0,%d0
	moveb	%a4@(42),%d0
	addqw	#1,%d0
	extl	%d0
	_BlockMoveData
	pea	%fp@(-282)
	jsr	%pc@(sub_1000b3b6)
	movew	%d0,%d7
	addqw	#4,%sp
	beqs	.L1000b32a
	tstw	%d6
	bnes	.L1000b32a
	movew	%d7,%d6

.L1000b32a:
	movel	%d5,%d0
	subql	#1,%d5
	moveq	#0,%d0
	movew	%a4@(40),%d0
	addl	%a4,%d0
	moveal	%d0,%a4

.L1000b338:
	tstl	%d5
	bgts	.L1000b2da
	moveal	%a2,%a0
	moveb	%d4,%d0
	_HSetState

.L1000b342:
	movew	%d6,%d0
	moveml	%fp@(-384),%d4-%d7/%a2-%a4
	unlk	%fp
	rts

sub_1000b34e:
	linkw	%fp,#-80
	moveml	%d6-%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	moveq	#0,%d6
	bras	.L1000b398

.L1000b35e:
	subql	#2,%sp
	pea	%fp@(-80)
	movel	%a4,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	moveb	%d0,%sp@-
	jsr	%pc@(sub_10003ea4)
	tstw	%sp@+
	bnes	.L1000b394
	subql	#2,%sp
	pea	%fp@(-16)
	moveq	#0,%d0
	movel	%d0,%sp@-
	pea	%fp@(-80)
	moveq	#1,%d1
	moveb	%d1,%sp@-
	movew	#-4,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000b3aa
	movew	%d7,%d0
	bras	.L1000b3ac

.L1000b394:
	movel	%d6,%d0
	addql	#1,%d6

.L1000b398:
	subql	#2,%sp
	movel	%d6,%sp@-
	pea	%fp@(-80)
	movew	#-9,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000b35e

.L1000b3aa:
	moveq	#0,%d0

.L1000b3ac:
	moveml	%fp@(-92),%d6-%d7/%a4
	unlk	%fp
	rts

sub_1000b3b6:
	linkw	%fp,#-270
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	lea	%a3@(266),%a4
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	moveq	#0,%d1
	movel	%d1,%sp@-
	pea	%a3@(10)
	moveq	#2,%d0
	movel	%d0,%sp@-
	movel	#1886875747,%sp@-
	pea	%fp@(-266)
	pea	%fp@(-6)
	pea	%fp@(-1)
	pea	%fp@(-262)
	movew	#-2,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000b3fc
	clrw	%d7
	bras	.L1000b47a

.L1000b3fc:
	tstl	%a4@
	bnes	.L1000b41a
	moveal	%a3@(6),%a0
	movel	%a0@,%a4@(4)
	subql	#4,%sp
	movel	%a3@(6),%sp@-
	jsr	%pc@(sub_10004b2a)
	movel	%sp@+,%a4@(8)
	clrb	%a4@(12)

.L1000b41a:
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%a3@(10)
	movel	%d0,%sp@-
	movel	#1886875747,%sp@-
	pea	%fp@(-270)
	pea	%fp@(-6)
	pea	%fp@(-1)
	pea	%fp@(-262)
	movew	#-2,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000b456
	cmpiw	#-2804,%d7
	beqs	.L1000b47a
	cmpiw	#-2821,%d7
	beqs	.L1000b47a
	bras	.L1000b47a

.L1000b456:
	movew	%sr,%d0
	oriw	#1792,%sr
	movew	%d0,%d6
	subql	#2,%sp
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%fp@(-266),%sp@-
	movel	%fp@(-270),%sp@-
	movew	#-17,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	movew	%d6,%sp@-
	movew	%sp@+,%sr
	tstw	%d7

.L1000b47a:
	tstw	%d7
	beqs	.L1000b488
	tstl	%a4@
	bnes	.L1000b488
	moveal	%a3@(6),%a0
	_DisposeHandle

.L1000b488:
	movew	%d7,%d0
	moveml	%fp@(-286),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000b494:
	linkw	%fp,#0
	moveml	%d4-%d7/%a3-%a4,%sp@-
	clrw	%d6
	subql	#4,%sp
	movel	#1667658343,%sp@-
	movew	%fp@(10),%sp@-
	_Get1Resource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	bnes	.L1000b4b8
	movew	#-192,%d6
	bras	.L1000b4fe

.L1000b4b8:
	moveal	%a3,%a0
	_HGetState
	moveb	%d0,%d4
	moveal	%a3,%a0
	_HLock
	moveal	%a3@,%a0
	moveq	#0,%d5
	movew	%a0@(30),%d5
	tstl	%d5
	lea	%a0@(32),%a4
	bras	.L1000b4f4

.L1000b4d2:
	pea	%a4@(42)
	jsr	%pc@(sub_1000b34e)
	movew	%d0,%d7
	addqw	#4,%sp
	beqs	.L1000b4e6
	tstw	%d6
	bnes	.L1000b4e6
	movew	%d7,%d6

.L1000b4e6:
	movel	%d5,%d0
	subql	#1,%d5
	moveq	#0,%d0
	movew	%a4@(40),%d0
	addl	%a4,%d0
	moveal	%d0,%a4

.L1000b4f4:
	tstl	%d5
	bgts	.L1000b4d2
	moveal	%a3,%a0
	moveb	%d4,%d0
	_HSetState

.L1000b4fe:
	movew	%d6,%d0
	moveml	%fp@(-24),%d4-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000b50a:
	linkw	%fp,#-136
	moveml	%d6-%d7,%sp@-
	movew	%fp@(14),%d6
	clrw	%d7
	movew	#-21926,%d0
	_GetToolTrapAddress
	movel	%a0,%fp@(-136)
	movew	#-22369,%d0
	_GetToolTrapAddress
	movel	%fp@(-136),%d0
	cmpal	%d0,%a0
	beqs	.L1000b5a2
	extl	%d6
	movel	%d6,%sp@-
	jsr	%pc@(sub_1000b494)
	movew	%d0,%d7
	addqw	#4,%sp
	tstw	%d7
	bnes	.L1000b5a2
	moveq	#0,%d0
	movew	%fp@(10),%d0
	moveq	#1,%d1
	andw	%d0,%d1
	moveq	#0,%d0
	movew	%d1,%d0
	tstl	%d0
	bnes	.L1000b55e
	extl	%d6
	movel	%d6,%sp@-
	jsr	%pc@(sub_1000b28a)
	movew	%d0,%d7
	addqw	#4,%sp

.L1000b55e:
	moveq	#0,%d0
	movel	%d0,%fp@(-120)
	clrw	%fp@(-104)
	movew	%fp@(12),%fp@(-108)
	lea	%fp@(-64),%a0
	movel	%a0,%fp@(-114)
	lea	%fp@(-132),%a0
	moveq	#8,%d0
	_HFSDispatch
	movew	%d0,%d7
	bnes	.L1000b5a2
	movew	%fp@(-80),%fp@(-70)
	movel	%fp@(-74),%fp@(-68)
	subql	#2,%sp
	pea	%fp@(-70)
	movew	%d6,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	movew	#-22,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7

.L1000b5a2:
	movew	%d7,%fp@(16)
	moveml	%fp@(-144),%d6-%d7
	unlk	%fp
	rtd	#8

sub_1000b5b2:
	linkw	%fp,#-58
	moveml	%d3/%d6-%d7/%a3-%a4,%sp@-
	clrw	%fp@(-6)
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d6
	jsr	%pc@(sub_1000b958)
	movel	%d0,%d7
	moveq	#64,%d0
	andl	%d7,%d0
	beqw	.L1000b802
	subql	#4,%sp
	movel	#1684431136,%sp@-
	movew	#-20886,%sp@-
	_GetResource
	movel	%sp@+,%fp@(-46)
	_InitFonts
	_InitWindows
	_InitMenus
	_TEInit
	moveq	#0,%d0
	movel	%d0,%sp@-
	_InitDialogs
	_InitCursor
	pea	%fp@(-54)
	_GetPort
	subql	#4,%sp
	movew	#-20886,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#-1,%d1
	movel	%d1,%sp@-
	_GetNewDialog
	moveal	%sp@+,%a3
	moveq	#18,%d0
	_NewHandle
	moveal	%a0,%a4
	movel	%a3,%d0
	beqw	.L1000b7d2
	tstl	%fp@(-46)
	beqw	.L1000b7d2
	movel	%a4,%d0
	beqw	.L1000b7d2
	movel	%fp@(-46),%sp@-
	_DetachResource
	moveal	%fp@(-46),%a0
	_HLock
	moveal	%fp@(-46),%a0
	movel	%a0@,%fp@(-4)
	moveal	%a4,%a0
	_HLock
	movel	%a3,%sp@-
	movel	%a4@,%sp@-
	_SetWRefCon
	movel	#65536,%d0
	andl	%d7,%d0
	sne	%d3
	negb	%d3
	moveal	%a4@,%a0
	moveb	%d3,%a0@(8)
	subql	#2,%sp
	pea	%fp@(-58)
	jsr	%pc@(sub_1000b87e)
	moveal	%a4@,%a0
	moveb	%sp@+,%a0@(12)
	moveal	%a4@,%a0
	movel	%fp@(-58),%a0@(14)
	moveq	#2,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000ba1e)
	movel	%a3,%sp@-
	_SetPort
	movel	%a3,%sp@-
	_SelectWindow
	subql	#2,%sp
	movel	%a3,%sp@-
	movew	#525,%d0
	_DialogDispatch
	movel	%a3,%sp@-
	_ShowWindow
	_InitCursor
	movel	#-6078,%sp@-
	jsr	%pc@(sub_1000bc04)
	moveal	%a4@,%a0
	movel	%d0,%a0@
	movel	%a3,%sp@-
	movel	%a4@,%sp@-
	_SetWRefCon
	moveq	#1,%d0
	movew	%d0,%sp@-
	_SysBeep
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000bab0)
	movel	%a3,%sp@-
	movel	%a3@(24),%sp@-
	_UpdateDialog
	subql	#2,%sp
	moveq	#-1,%d0
	movew	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-50)
	pea	%pc@(sub_1000bde0)
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	moveal	%fp@(-4),%a0
	jsr	%a0@
	movew	%sp@+,%d7
	subql	#4,%sp
	_TickCount
	moveal	%a4@,%a0
	movel	%sp@+,%a0@(4)
	movew	%d7,%d0
	subiw	#-1326,%d0
	lea	%sp@(22),%sp
	beqs	.L1000b728
	subqw	#5,%d0
	beqs	.L1000b750
	subqw	#1,%d0
	beqs	.L1000b74c
	subqw	#1,%d0
	beqs	.L1000b740
	subqw	#1,%d0
	beqs	.L1000b73c
	subqw	#1,%d0
	beqs	.L1000b738
	subqw	#2,%d0
	beqs	.L1000b734
	subqw	#1,%d0
	beqs	.L1000b730
	subqw	#2,%d0
	beqs	.L1000b72c
	subiw	#1312,%d0
	bnes	.L1000b754
	moveal	%a4@,%a0
	moveb	#1,%a0@(8)
	moveq	#5,%d7
	bras	.L1000b756

.L1000b728:
	moveq	#9,%d7
	bras	.L1000b756

.L1000b72c:
	moveq	#10,%d7
	bras	.L1000b756

.L1000b730:
	moveq	#11,%d7
	bras	.L1000b756

.L1000b734:
	moveq	#12,%d7
	bras	.L1000b756

.L1000b738:
	moveq	#13,%d7
	bras	.L1000b756

.L1000b73c:
	moveq	#14,%d7
	bras	.L1000b756

.L1000b740:
	moveal	%a4@,%a0
	moveb	#1,%a0@(8)
	moveq	#15,%d7
	bras	.L1000b756

.L1000b74c:
	moveq	#16,%d7
	bras	.L1000b756

.L1000b750:
	moveq	#17,%d7
	bras	.L1000b756

.L1000b754:
	moveq	#18,%d7

.L1000b756:
	extl	%d7
	movel	%d7,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000ba1e)
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000b9fc)
	movel	%d0,%fp@(-42)
	pea	%fp@(-38)
	movew	#-20886,%sp@-
	moveq	#8,%d0
	movew	%d0,%sp@-
	jsr	%pc@(sub_1000437c)
	movel	%fp@(-42),%sp@-
	pea	%fp@(-38)
	_SetControlTitle
	subql	#2,%sp
	movel	%a3,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	movew	#772,%d0
	_DialogDispatch
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000bad8)
	_InitCursor
	lea	%sp@(22),%sp

.L1000b7a2:
	pea	%pc@(sub_1000baf8)
	pea	%fp@(-6)
	_ModalDialog
	moveq	#1,%d0
	cmpw	%fp@(-6),%d0
	bnes	.L1000b7a2
	moveal	%a4@,%a0
	tstl	%a0@
	beqs	.L1000b7c2
	movel	%a0@,%sp@-
	jsr	%pc@(sub_1000bc96)
	addqw	#4,%sp

.L1000b7c2:
	moveal	%a4@,%a0
	tstl	%a0@(14)
	beqs	.L1000b7d2
	movel	%a0@(14),%sp@-
	moveq	#1,%d0
	_MixedModeDispatch

.L1000b7d2:
	movel	%fp@(-54),%sp@-
	_SetPort
	movel	%a3,%d0
	beqs	.L1000b7e0
	movel	%a3,%sp@-
	_DisposeDialog

.L1000b7e0:
	tstl	%fp@(-46)
	beqs	.L1000b7f2
	moveal	%fp@(-46),%a0
	_HUnlock
	moveal	%fp@(-46),%a0
	_DisposeHandle

.L1000b7f2:
	movel	%a4,%d0
	beqs	.L1000b7fe
	moveal	%a4,%a0
	_HUnlock
	moveal	%a4,%a0
	_DisposeHandle

.L1000b7fe:
	movew	%d6,%sp@-
	_UseResFile

.L1000b802:
	moveml	%fp@(-78),%d3/%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000b80c:
	linkw	%fp,#-108
	moveml	%d7/%a4,%sp@-
	lea	%fp@(-32),%a4
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1835098995,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-34)
	pea	%fp@(-38)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d7
	bnes	.L1000b86e
	moveq	#2,%d0
	movel	%d0,%fp@(-38)
	movel	%a4,%sp@-
	movew	#-20886,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	jsr	%pc@(sub_1000437c)
	subql	#2,%sp
	movew	%fp@(-34),%sp@-
	movel	%fp@(-38),%sp@-
	movel	%a4,%sp@-
	pea	%fp@(-108)
	moveq	#1,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7
	cmpiw	#-43,%d7
	bnes	.L1000b86e
	clrb	%fp@(8)
	bras	.L1000b874

.L1000b86e:
	moveb	#1,%fp@(8)

.L1000b874:
	moveml	%fp@(-116),%d7/%a4
	unlk	%fp
	rts

sub_1000b87e:
	linkw	%fp,#-270
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a4
	clrb	%d6
	moveq	#0,%d0
	movel	%d0,%a4@
	_GetZone
	moveal	%a0,%a3
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	movel	#1970496032,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L1000b920
	moveq	#1,%d0
	andl	%fp@(-4),%d0
	beqs	.L1000b920
	subql	#2,%sp
	pea	%pc@(str_1000b944)
	movel	#1886875747,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-270)
	pea	%fp@(-266)
	pea	%fp@(-260)
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000b920
	subql	#2,%sp
	movel	%fp@(-270),%sp@-
	pea	%pc@(str_1000b934)
	pea	%fp@(-266)
	pea	%fp@(-261)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnes	.L1000b912
	subql	#4,%sp
	movel	%fp@(-266),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	movel	%sp@+,%a4@
	moveq	#1,%d6

.L1000b912:
	subql	#2,%sp
	pea	%fp@(-270)
	movew	#4,%sp@-
	_CodeFragmentDispatch
	addqw	#2,%sp

.L1000b920:
	moveal	%a3,%a0
	_SetZone
	moveb	%d6,%fp@(12)
	moveml	%fp@(-286),%d6-%d7/%a3-%a4
	unlk	%fp
	movel	%sp@+,%sp@
	rts

str_1000b934:
	.byte	0x0e
	.string	"ExpertIdleTask"

str_1000b944:
	.byte	0x12
	.string	"USBFamilyExpertLib"

sub_1000b958:
	linkw	%fp,#-38
	moveml	%d4-%d7/%a3-%a4,%sp@-
	lea	%fp@(-38),%a3
	moveq	#0,%d7
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%d5
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1886545254,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d6
	bnes	.L1000b9ec
	movel	%a3,%sp@-
	movew	#-20886,%sp@-
	moveq	#19,%d0
	movew	%d0,%sp@-
	jsr	%pc@(sub_1000437c)
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	%a3,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	_HOpenResFile
	movew	%sp@+,%d6
	cmpiw	#-1,%d6
	beqs	.L1000b9ec
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L1000b9ec
	subql	#4,%sp
	movel	#1399681652,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_Get1IndResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L1000b9e8
	moveal	%a4,%a0
	_HLock
	moveal	%a4@,%a0
	movel	%a0@,%d4
	movel	#65600,%d7
	andl	%d4,%d7
	moveal	%a4,%a0
	_HUnlock
	movel	%a4,%sp@-
	_ReleaseResource

.L1000b9e8:
	movew	%d6,%sp@-
	_CloseResFile

.L1000b9ec:
	movew	%d5,%sp@-
	_UseResFile
	movel	%d7,%d0
	moveml	%fp@(-62),%d4-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000b9fc:
	linkw	%fp,#-14
	movel	%fp@(8),%sp@-
	movew	%fp@(14),%sp@-
	pea	%fp@(-14)
	pea	%fp@(-4)
	pea	%fp@(-12)
	_GetDialogItem
	movel	%fp@(-4),%d0
	unlk	%fp
	rts

sub_1000ba1e:
	linkw	%fp,#-292
	moveml	%d7/%a2-%a4,%sp@-
	moveal	%fp@(8),%a3
	lea	%fp@(-288),%a4
	movew	%fp@(14),%d7
	moveq	#2,%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000b9fc)
	moveal	%d0,%a2
	movel	%a4,%sp@-
	movew	#-20886,%sp@-
	movew	%d7,%sp@-
	jsr	%pc@(sub_1000437c)
	cmpiw	#2,%d7
	addqw	#8,%sp
	beqs	.L1000ba58
	cmpiw	#3,%d7
	bnes	.L1000ba72

.L1000ba58:
	pea	%fp@(-32)
	moveq	#-1,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000ba86)
	pea	%fp@(-32)
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000bd54)
	lea	%sp@(16),%sp

.L1000ba72:
	movel	%a2,%sp@-
	movel	%a4,%sp@-
	_SetDialogItemText
	movel	%a3,%sp@-
	_DrawDialog
	moveml	%fp@(-308),%d7/%a2-%a4
	unlk	%fp
	rts

sub_1000ba86:
	linkw	%fp,#-122
	movel	%d7,%sp@-
	movew	%fp@(10),%fp@(-100)
	moveal	%fp@(12),%a0
	movel	%a0,%fp@(-104)
	clrb	%a0@
	clrw	%fp@(-94)
	lea	%fp@(-122),%a0
	_PBHGetVInfoSync
	movew	%d0,%d7
	movel	%fp@(-126),%d7
	unlk	%fp
	rts

sub_1000bab0:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveq	#3,%d0
	movel	%d0,%sp@-
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000b9fc)
	moveal	%d0,%a4
	movel	%a4,%sp@-
	_ShowControl
	movel	%a4,%sp@-
	movew	%fp@(14),%sp@-
	_SetControlValue
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_1000bad8:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveq	#3,%d0
	movel	%d0,%sp@-
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000b9fc)
	moveal	%d0,%a4
	movel	%a4,%sp@-
	_HideControl
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_1000baf8:
	linkw	%fp,#-8
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(16),%a3
	moveal	%fp@(8),%a4
	moveq	#1,%d7
	subql	#4,%sp
	movel	%a3,%sp@-
	_GetWRefCon
	movel	%sp@+,%fp@(-8)
	subql	#4,%sp
	_TickCount
	moveal	%fp@(-8),%a0
	movel	%sp@+,%d6
	subl	%a0@(4),%d6
	moveal	%fp@(-8),%a0
	tstb	%a0@(12)
	beqs	.L1000bb36
	moveal	%a0@(14),%a0
	movel	%a0,%fp@(-4)
	jsr	%a0@

.L1000bb36:
	clrw	%a4@
	moveq	#15,%d0
	cmpl	%d6,%d0
	bgew	.L1000bbd4
	moveal	%fp@(-8),%a0
	moveq	#0,%d0
	moveb	%a0@(8),%d0
	cmpiw	#1,%d0
	bnes	.L1000bb6e
	cmpil	#7200,%d6
	bles	.L1000bb6e
	movew	#1,%a4@
	movew	%a4@,%d0
	extl	%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000bd06)
	moveb	%d0,%d7
	addqw	#8,%sp
	bras	.L1000bbd4

.L1000bb6e:
	moveal	%fp@(12),%a0
	movew	%a0@,%d0
	subqw	#1,%d0
	beqs	.L1000bbd2
	subqw	#2,%d0
	beqs	.L1000bb82
	subqw	#3,%d0
	beqs	.L1000bbce
	bras	.L1000bbd4

.L1000bb82:
	moveal	%fp@(12),%a0
	movel	#255,%d0
	andl	%a0@(2),%d0
	subil	#27,%d0
	beqs	.L1000bbb8
	subil	#19,%d0
	bnes	.L1000bbbc
	moveal	%fp@(12),%a0
	moveq	#0,%d0
	movew	%a0@(14),%d0
	movew	#256,%d1
	andw	%d0,%d1
	moveq	#0,%d0
	movew	%d1,%d0
	tstl	%d0
	beqs	.L1000bbbc

.L1000bbb8:
	movew	#1,%a4@

.L1000bbbc:
	movew	%a4@,%d0
	extl	%d0
	movel	%d0,%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000bd06)
	moveb	%d0,%d7
	addqw	#8,%sp
	bras	.L1000bbd4

.L1000bbce:
	movel	%a3,%sp@-
	_DrawControls

.L1000bbd2:
	clrb	%d7

.L1000bbd4:
	tstb	%d7
	beqs	.L1000bbdc
	moveq	#1,%d0
	bras	.L1000bbf0

.L1000bbdc:
	subql	#2,%sp
	movel	%a3,%sp@-
	movel	%fp@(12),%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_10004960)
	moveq	#0,%d0
	moveb	%sp@+,%d0
	tstl	%d0

.L1000bbf0:
	moveb	%d0,%fp@(20)
	moveml	%fp@(-24),%d6-%d7/%a3-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

sub_1000bc04:
	linkw	%fp,#0
	moveml	%d3/%d6-%d7/%a4,%sp@-
	subql	#4,%sp
	movel	#1633908082,%sp@-
	movew	%fp@(10),%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L1000bc8a
	moveal	%a4@,%a0
	clrw	%a0@(2)
	clrw	%d7
	bras	.L1000bc80

.L1000bc2a:
	extl	%d7
	moveal	%a4@,%a0
	movel	%d7,%d0
	asll	#2,%d0
	movel	%a0@(4,%d0:l),%d6
	swap	%d6
	extl	%d6
	subql	#4,%sp
	movew	%d6,%sp@-
	_GetCursor
	extl	%d7
	moveal	%a4@,%a0
	movel	%d7,%d0
	asll	#2,%d0
	movel	%sp@+,%a0@(4,%d0:l)
	extl	%d7
	moveal	%a4@,%a0
	movel	%d7,%d0
	asll	#2,%d0
	tstl	%a0@(4,%d0:l)
	bnes	.L1000bc7c
	bras	.L1000bc70

.L1000bc5c:
	extl	%d7
	movel	%d7,%d0
	subql	#1,%d0
	moveal	%a4@,%a0
	asll	#2,%d0
	movel	%a0@(4,%d0:l),%sp@-
	_ReleaseResource
	movew	%d7,%d0
	subqw	#1,%d7

.L1000bc70:
	tstw	%d7
	bgts	.L1000bc5c
	movel	%a4,%sp@-
	_ReleaseResource
	moveq	#0,%d0
	moveal	%d0,%a4

.L1000bc7c:
	movew	%d7,%d0
	addqw	#1,%d7

.L1000bc80:
	moveal	%a4@,%a0
	cmpw	%a0@,%d7
	bges	.L1000bc8a
	movel	%a4,%d0
	bnes	.L1000bc2a

.L1000bc8a:
	movel	%a4,%d0
	moveml	%fp@(-16),%d3/%d6-%d7/%a4
	unlk	%fp
	rts

sub_1000bc96:
	linkw	%fp,#0
	moveml	%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	clrw	%d7
	bras	.L1000bcb8

.L1000bca6:
	extl	%d7
	moveal	%a4@,%a0
	movel	%d7,%d0
	asll	#2,%d0
	movel	%a0@(4,%d0:l),%sp@-
	_ReleaseResource
	movew	%d7,%d0
	addqw	#1,%d7

.L1000bcb8:
	moveal	%a4@,%a0
	cmpw	%a0@,%d7
	blts	.L1000bca6
	movel	%a4,%sp@-
	_ReleaseResource
	moveml	%fp@(-8),%d7/%a4
	unlk	%fp
	rts

sub_1000bccc:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveal	%fp@(8),%a4
	moveal	%a4@,%a0
	movew	%a0@(2),%d0
	addqw	#1,%a0@(2)
	extl	%d0
	moveal	%a4@,%a0
	asll	#2,%d0
	moveal	%a0@(4,%d0:l),%a0
	movel	%a0@,%sp@-
	_SetCursor
	moveal	%a4@,%a0
	moveal	%a0,%a1
	movew	%a0@(2),%d0
	cmpw	%a1@,%d0
	bnes	.L1000bcfe
	clrw	%a0@(2)

.L1000bcfe:
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_1000bd06:
	linkw	%fp,#-4
	moveml	%d7/%a4,%sp@-
	movew	%fp@(14),%d7
	cmpiw	#1,%d7
	bnes	.L1000bd48
	extl	%d7
	movel	%d7,%sp@-
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000b9fc)
	moveal	%d0,%a4
	movel	%a4,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_HiliteControl
	moveaw	#10,%a0
	lea	%fp@(-4),%a1
	_Delay
	movel	%d0,%a1@
	movel	%a4,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	_HiliteControl
	moveq	#1,%d0
	addqw	#8,%sp
	bras	.L1000bd4a

.L1000bd48:
	moveq	#0,%d0

.L1000bd4a:
	moveml	%fp@(-12),%d7/%a4
	unlk	%fp
	rts

sub_1000bd54:
	linkw	%fp,#0
	moveml	%d6-%d7/%a3-%a4,%sp@-
	moveal	%fp@(12),%a3
	moveal	%fp@(8),%a4
	moveq	#1,%d7
	bras	.L1000bd8a

.L1000bd68:
	moveq	#0,%d0
	moveb	%a4@(%d7:w),%d0
	cmpiw	#94,%d0
	bnes	.L1000bd86
	extl	%d7
	movel	%d7,%d0
	addql	#1,%d0
	moveq	#0,%d1
	moveb	%a4@(%d0:l),%d1
	cmpiw	#49,%d1
	beqs	.L1000bd92

.L1000bd86:
	movew	%d7,%d0
	addqw	#1,%d7

.L1000bd8a:
	moveq	#0,%d0
	moveb	%a4@,%d0
	cmpw	%d7,%d0
	bgts	.L1000bd68

.L1000bd92:
	moveq	#0,%d0
	moveb	%a4@,%d0
	cmpw	%d7,%d0
	bles	.L1000bdd6
	moveq	#0,%d0
	moveb	%a3@,%d0
	movew	%d0,%d6
	subqw	#2,%d6
	extl	%d7
	movel	%d7,%d0
	addql	#2,%d0
	lea	%a4@(%d0:l),%a0
	extl	%d7
	movel	%d7,%d0
	addql	#2,%d0
	extl	%d6
	addl	%d6,%d0
	lea	%a4@(%d0:l),%a1
	moveq	#0,%d0
	moveb	%a4@,%d0
	extl	%d7
	subl	%d7,%d0
	subql	#1,%d0
	_BlockMoveData
	moveal	%a3,%a0
	addql	#1,%a0
	lea	%a4@(%d7:w),%a1
	moveq	#0,%d0
	moveb	%a3@,%d0
	_BlockMoveData
	addb	%d6,%a4@

.L1000bdd6:
	moveml	%fp@(-16),%d6-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000bde0:
	linkw	%fp,#-4
	moveml	%d7/%a2-%a4,%sp@-
	clrw	%d7
	moveal	%fp@(8),%a4
	subql	#4,%sp
	movel	%a4,%sp@-
	_GetWRefCon
	moveal	%sp@+,%a3
	movew	%fp@(12),%d0
	cmpiw	#3,%d0
	bhis	.L1000be54
	addw	%d0,%d0
	movew	%pc@(off_1000be0a,%d0:w),%d0
	jmp	%pc@(%d0:w)

off_1000be0a:
	.word	0x4c,0x0a,0x4c,0x14

.L1000be12:
	movel	%a4,%sp@-
	movew	#12,%d0
	_ControlDispatch
	bras	.L1000be78

.L1000be1c:
	moveq	#3,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000ba1e)
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000bf60)
	moveq	#100,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000bab0)
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000b9fc)
	moveal	%d0,%a2
	movel	%a2,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	_SetControlValue
	lea	%sp@(32),%sp
	bras	.L1000be78

.L1000be54:
	tstb	%fp@(14)
	beqs	.L1000be6a
	moveq	#0,%d0
	movew	%fp@(18),%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000bab0)
	addqw	#8,%sp

.L1000be6a:
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000be98)
	moveq	#0,%d7
	moveb	%d0,%d7
	tstl	%d7
	addqw	#4,%sp

.L1000be78:
	tstl	%a3@
	beqs	.L1000be84
	movel	%a3@,%sp@-
	jsr	%pc@(sub_1000bccc)
	addqw	#4,%sp

.L1000be84:
	moveb	%d7,%fp@(20)
	moveml	%fp@(-20),%d7/%a2-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

sub_1000be98:
	linkw	%fp,#-28
	moveml	%d6-%d7/%a2-%a4,%sp@-
	moveal	%fp@(8),%a4
	clrb	%d7
	subql	#4,%sp
	movel	%a4,%sp@-
	_GetWRefCon
	moveal	%sp@+,%a3
	tstb	%a3@(12)
	beqs	.L1000beba
	moveal	%a3@(14),%a2
	jsr	%a2@

.L1000beba:
	moveq	#10,%d0
	lea	%fp@(-20),%a0
	_GetOSEvent
	addqw	#1,%d0
	tstb	%d0
	beqw	.L1000bf54
	movew	%fp@(-20),%d0
	subqw	#1,%d0
	beqs	.L1000bed8
	subqw	#2,%d0
	beqs	.L1000bf26
	bras	.L1000bf54

.L1000bed8:
	moveq	#0,%d0
	movel	%d0,%fp@(-28)
	movel	%fp@(-10),%fp@(-24)
	pea	%fp@(-24)
	_GlobalToLocal
	subql	#2,%sp
	movel	%fp@(-24),%sp@-
	movel	%a4,%sp@-
	pea	%fp@(-28)
	_FindControl
	movew	%sp@+,%d6
	tstl	%fp@(-28)
	beqs	.L1000bf12
	subql	#2,%sp
	movel	%fp@(-28),%sp@-
	movel	%fp@(-24),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	_TrackControl
	movew	%sp@+,%d6

.L1000bf12:
	tstw	%d6
	beqs	.L1000bf54
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000bd06)
	moveb	%d0,%d7
	addqw	#8,%sp
	bras	.L1000bf54

.L1000bf26:
	movel	#255,%d6
	andl	%fp@(-18),%d6
	cmpib	#46,%d6
	bnes	.L1000bf40
	movew	%fp@(-6),%d0
	.short	0xc07c,0x0100	/* andw #256,%d0 */
	bnes	.L1000bf46

.L1000bf40:
	cmpib	#27,%d6
	bnes	.L1000bf54

.L1000bf46:
	moveq	#1,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000bd06)
	moveb	%d0,%d7
	addqw	#8,%sp

.L1000bf54:
	moveb	%d7,%d0
	moveml	%fp@(-48),%d6-%d7/%a2-%a4
	unlk	%fp
	rts

sub_1000bf60:
	linkw	%fp,#-2
	moveml	%d3/%d7/%a4,%sp@-
	moveq	#3,%d0
	movel	%d0,%sp@-
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000b9fc)
	moveal	%d0,%a4
	movel	%a4,%d0
	addqw	#8,%sp
	bnes	.L1000bf80
	moveq	#-50,%d0
	bras	.L1000bfac

.L1000bf80:
	tstb	%fp@(15)
	seq	%d3
	negb	%d3
	moveb	%d3,%fp@(-1)
	subql	#2,%sp
	movel	%a4,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	movel	#1768842341,%sp@-
	moveq	#1,%d1
	movel	%d1,%sp@-
	pea	%fp@(-1)
	movew	#18,%d0
	_ControlDispatch
	movew	%sp@+,%d7
	movew	%d7,%d0

.L1000bfac:
	moveml	%fp@(-14),%d3/%d7/%a4
	unlk	%fp
	rts

sub_1000bfb6:
	linkw	%fp,#0
	movel	%a4,%sp@-
	subql	#4,%sp
	movel	%fp@(8),%sp@-
	movew	%fp@(14),%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L1000bfde
	tstl	%a4@
	bnes	.L1000bfde
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L1000bfde
	movel	%a4,%sp@-
	_LoadResource

.L1000bfde:
	movel	%a4,%d0
	beqs	.L1000c010
	tstl	%a4@
	beqs	.L1000c010
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L1000c010
	subql	#4,%sp
	movel	%a4,%sp@-
	jsr	%pc@(sub_10004b2a)
	lea	0xc,%a0
	addqw	#2,%a0
	cmpal	%sp@+,%a0
	bhis	.L1000c010
	moveal	%a4@,%a0
	moveq	#1,%d0
	cmpl	%a0@,%d0
	bnes	.L1000c010
	movel	%a4,%sp@-
	_DetachResource
	movel	%a4,%d0
	bras	.L1000c01a

.L1000c010:
	movel	%a4,%d0
	beqs	.L1000c018
	movel	%a4,%sp@-
	_ReleaseResource

.L1000c018:
	moveq	#0,%d0

.L1000c01a:
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_1000c022:
	linkw	%fp,#0
	movel	%a4,%sp@-
	moveal	%fp@(8),%a4
	movel	%a4,%d0
	beqs	.L1000c034
	moveal	%a4,%a0
	_DisposeHandle

.L1000c034:
	moveal	%fp@(-4),%a4
	unlk	%fp
	rts

sub_1000c03c:
	linkw	%fp,#0
	moveml	%d5-%d7/%a3-%a4,%sp@-
	clrb	%d6
	tstl	%fp@(16)
	beqs	.L1000c052
	moveal	%fp@(16),%a0
	clrb	%a0@

.L1000c052:
	tstl	%fp@(8)
	beqw	.L1000c11c
	moveal	%fp@(8),%a0
	tstl	%a0@
	beqw	.L1000c11c
	moveal	%a0@,%a0
	moveq	#1,%d0
	cmpl	%a0@,%d0
	bnew	.L1000c11c
	moveal	%fp@(12),%a0
	moveq	#0,%d0
	moveb	%a0@,%d0
	tstl	%d0
	blsw	.L1000c11c
	moveal	%fp@(8),%a0
	_HGetState
	extw	%d0
	movew	%d0,%d5
	moveal	%fp@(8),%a0
	_HLock
	moveal	%fp@(8),%a0
	moveal	%a0@,%a0
	lea	%a0@(12),%a4
	moveal	%fp@(8),%a0
	moveal	%a0@,%a0
	movel	%a0@(8),%d7
	bras	.L1000c110

.L1000c0a2:
	subql	#2,%sp
	movel	%fp@(12),%sp@-
	movel	%a4,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	moveq	#1,%d1
	moveb	%d1,%sp@-
	jsr	%pc@(sub_10004cca)
	tstb	%sp@+
	beqs	.L1000c0f4
	moveq	#0,%d0
	moveb	%a4@,%d0
	addl	%a4,%d0
	moveal	%d0,%a3
	addqw	#1,%a3
	tstl	%fp@(16)
	beqs	.L1000c0d8
	subql	#4,%sp
	movel	%fp@(16),%sp@-
	movel	%a3,%sp@-
	jsr	%pc@(sub_10004cc6)
	addqw	#4,%sp

.L1000c0d8:
	tstl	%fp@(20)
	beqs	.L1000c0f0
	moveq	#0,%d0
	moveb	%a3@,%d0
	addl	%a3,%d0
	addql	#1,%d0
	moveal	%d0,%a0
	moveal	%fp@(20),%a1
	moveq	#4,%d0
	_BlockMoveData

.L1000c0f0:
	moveq	#1,%d6
	bras	.L1000c114

.L1000c0f4:
	moveq	#0,%d0
	moveb	%a4@,%d0
	addl	%a4,%d0
	addql	#1,%d0
	moveal	%d0,%a4
	moveq	#0,%d0
	moveb	%a4@,%d0
	addl	%a4,%d0
	addql	#1,%d0
	movel	%d0,%d0
	addql	#4,%d0
	moveal	%d0,%a4
	movel	%d7,%d0
	subql	#1,%d7

.L1000c110:
	tstl	%d7
	bhis	.L1000c0a2

.L1000c114:
	moveal	%fp@(8),%a0
	moveb	%d5,%d0
	_HSetState

.L1000c11c:
	moveb	%d6,%d0
	moveml	%fp@(-20),%d5-%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000c128:
	braw	sub_1000d7e4

sub_1000c12c:
	linkw	%fp,#-6
	movel	%d7,%sp@-
	clrw	%d7
	subql	#2,%sp
	movel	%fp@(8),%sp@-
	movel	%fp@(12),%sp@-
	pea	%fp@(-4)
	pea	%fp@(-5)
	movew	#5,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	beqs	.L1000c154
	moveq	#0,%d0
	bras	.L1000c168

.L1000c154:
	subql	#4,%sp
	movel	%fp@(-4),%sp@-
	movel	%fp@(16),%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	moveq	#0,%d0
	_MixedModeDispatch
	movel	%sp@+,%d0

.L1000c168:
	movel	%fp@(-10),%d7
	unlk	%fp
	rts

sub_1000c170:
	linkw	%fp,#0
	moveml	%d7/%a4,%sp@-
	pea	0xff1
	pea	%pc@(str_1000c1b6)
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000c12c)
	moveal	%d0,%a4
	movel	%a4,%d0
	lea	%sp@(12),%sp
	bnes	.L1000c196
	moveq	#-108,%d0
	bras	.L1000c1ac

.L1000c196:
	movel	%fp@(20),%sp@-
	movel	%fp@(16),%sp@-
	movel	%fp@(12),%sp@-
	moveal	%a4,%a0
	jsr	%a0@
	movel	%d0,%d7
	lea	%sp@(12),%sp

.L1000c1ac:
	moveml	%fp@(-8),%d7/%a4
	unlk	%fp
	rts

str_1000c1b6:
	.byte	0x17
	.string	"RegistryCStrEntryLookup"
	.align	2

sub_1000c1d0:
	linkw	%fp,#0
	moveml	%d7/%a4,%sp@-
	pea	0x3ff1
	pea	%pc@(str_1000c21a)
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000c12c)
	moveal	%d0,%a4
	movel	%a4,%d0
	lea	%sp@(12),%sp
	bnes	.L1000c1f6
	moveq	#-108,%d0
	bras	.L1000c210

.L1000c1f6:
	movel	%fp@(24),%sp@-
	movel	%fp@(20),%sp@-
	movel	%fp@(16),%sp@-
	movel	%fp@(12),%sp@-
	moveal	%a4,%a0
	jsr	%a0@
	movel	%d0,%d7
	lea	%sp@(16),%sp

.L1000c210:
	moveml	%fp@(-8),%d7/%a4
	unlk	%fp
	rts

str_1000c21a:
	.byte	0x13
	.string	"RegistryPropertyGet"
	.align	2

sub_1000c230:
	linkw	%fp,#0
	moveml	%d7/%a4,%sp@-
	pea	0xff1
	pea	%pc@(str_1000c276)
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000c12c)
	moveal	%d0,%a4
	movel	%a4,%d0
	lea	%sp@(12),%sp
	bnes	.L1000c256
	moveq	#-108,%d0
	bras	.L1000c26c

.L1000c256:
	movel	%fp@(20),%sp@-
	movel	%fp@(16),%sp@-
	movel	%fp@(12),%sp@-
	moveal	%a4,%a0
	jsr	%a0@
	movel	%d0,%d7
	lea	%sp@(12),%sp

.L1000c26c:
	moveml	%fp@(-8),%d7/%a4
	unlk	%fp
	rts

str_1000c276:
	.byte	0x17
	.string	"RegistryPropertyGetSize"
	.align	2

sub_1000c290:
	linkw	%fp,#0
	moveml	%d7/%a4,%sp@-
	pea	0xf1
	pea	%pc@(str_1000c2cc)
	movel	%fp@(8),%sp@-
	jsr	%pc@(sub_1000c12c)
	moveal	%d0,%a4
	movel	%a4,%d0
	lea	%sp@(12),%sp
	bnes	.L1000c2b6
	moveq	#-108,%d0
	bras	.L1000c2c2

.L1000c2b6:
	movel	%fp@(12),%sp@-
	moveal	%a4,%a0
	jsr	%a0@
	movel	%d0,%d7
	addqw	#4,%sp

.L1000c2c2:
	moveml	%fp@(-8),%d7/%a4
	unlk	%fp
	rts

str_1000c2cc:
	.short	0x1652,0x6567
	.short	0x6973,0x7472,0x7945,0x6E74,0x7279,0x4944,0x4469,0x7370
	.short	0x6F73,0x6500

sub_1000c2e4:
	linkw	%fp,#-356
	moveml	%d7/%a3-%a4,%sp@-
	moveal	%fp@(12),%a3
	moveq	#-1,%d7
	moveq	#0,%d0
	moveal	%d0,%a4
	movel	#1852990823,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	bnew	.L1000c3f4
	lea	%pc@(str_1000c400),%a0
	lea	%fp@(-88),%a1
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	movel	%a0@+,%a1@+
	moveb	%a0@,%a1@
	movel	#1667658343,%d0
	lea	%fp@(-8),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnew	.L1000c3f4
	moveq	#1,%d0
	andl	%fp@(-8),%d0
	beqw	.L1000c3f4
	moveq	#0,%d0
	movel	%d0,%fp@(-352)
	subql	#2,%sp
	pea	%fp@(-88)
	movel	#1886875747,%sp@-
	moveq	#2,%d0
	movel	%d0,%sp@-
	pea	%fp@(-352)
	pea	%fp@(-348)
	pea	%fp@(-344)
	movew	#1,%sp@-
	_CodeFragmentDispatch
	movew	%sp@+,%d7
	bnew	.L1000c3f4
	pea	%fp@(-24)
	movel	%fp@(8),%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%fp@(-352),%sp@-
	jsr	%pc@(sub_1000c170)
	movew	%d0,%d7
	lea	%sp@(16),%sp
	bnes	.L1000c3e6
	moveq	#0,%d0
	movel	%d0,%fp@(-356)
	pea	%fp@(-356)
	movel	%a3,%sp@-
	pea	%fp@(-24)
	movel	%fp@(-352),%sp@-
	jsr	%pc@(sub_1000c230)
	movew	%d0,%d7
	lea	%sp@(16),%sp
	bnes	.L1000c3d8
	movel	%fp@(-356),%d0
	_NewPtrSys
	moveal	%a0,%a4
	movel	%a4,%d0
	beqs	.L1000c3d8
	subql	#2,%sp
	movew	0x220,%sp@
	tstw	%sp@+
	bnes	.L1000c3d8
	pea	%fp@(-356)
	movel	%a4,%sp@-
	movel	%a3,%sp@-
	pea	%fp@(-24)
	movel	%fp@(-352),%sp@-
	jsr	%pc@(sub_1000c1d0)
	movew	%d0,%d7
	lea	%sp@(20),%sp

.L1000c3d8:
	pea	%fp@(-24)
	movel	%fp@(-352),%sp@-
	jsr	%pc@(sub_1000c290)
	addqw	#8,%sp

.L1000c3e6:
	subql	#2,%sp
	pea	%fp@(-352)
	movew	#4,%sp@-
	_CodeFragmentDispatch
	addqw	#2,%sp

.L1000c3f4:
	movel	%a4,%d0
	moveml	%fp@(-368),%d7/%a3-%a4
	unlk	%fp
	rts

str_1000c400:
	.short	0x0F4E,0x616D,0x6552,0x6567,0x6973,0x7472,0x794C,0x6962
	.short	0x0000

sub_1000c412:
	.short	0x4E56,0x0000,0x48E7,0x1318,0x3C2E,0x000E,0x266E
	.short	0x0008,0x284B,0x598F,0x2F0B,0x4EBA,0x8AE8,0x2E1F,0x601C
	.short	0x524C,0x7000,0x3006,0x4A80,0x630C,0x200C,0x908B,0xBE80
	.short	0x6304,0x4A14,0x66EA,0x524C,0x3006,0x5346,0x7000,0x3006
	.short	0x4A80,0x6308,0x200C,0x908B,0xBE80,0x62D6,0x206E,0x0010
	.short	0x4210,0x6014,0x206E,0x0010,0x5210,0x7000,0x1010,0x206E
	.short	0x0010,0x1194,0x0000,0x524C,0x200C,0x908B,0xBE80,0x6304
	.short	0x4A14,0x66E0,0x7601,0x206E,0x0010,0x7000,0x1010,0x4A80
	.short	0x620A,0x200C,0x908B,0xBE80,0x6202,0x7600,0x1003,0x4CEE
	.short	0x18C8,0xFFEC,0x4E5E,0x4E75

sub_1000c4a8:
	linkw	%fp,#-8
	moveml	%d3/%d7/%a3-%a4,%sp@-
	moveal	%fp@(8),%a4
	lea	%pc@(str_1000c530),%a0
	movel	%a0,%fp@(-8)
	lea	%pc@(str_1000c52a),%a0
	movel	%a0,%fp@(-4)
	clrb	%d7
	movel	%fp@(-4),%sp@-
	movel	%fp@(-8),%sp@-
	jsr	%pc@(sub_1000c2e4)
	moveal	%d0,%a3
	movel	%a3,%d0
	addqw	#8,%sp
	beqs	.L1000c51e
	subql	#4,%sp
	movel	%a3,%sp@-
	jsr	%pc@(sub_10004f12)
	movel	%sp@+,%d0
	moveb	%d0,%a4@
	moveal	%a3,%a0
	moveal	%a4,%a1
	addql	#1,%a1
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	_BlockMoveData
	bras	.L1000c4f8

.L1000c4f6:
	subqb	#1,%a4@

.L1000c4f8:
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	blss	.L1000c50e
	moveq	#0,%d0
	moveb	%a4@,%d0
	moveq	#0,%d1
	moveb	%a4@(%d0:w),%d1
	tstl	%d1
	beqs	.L1000c4f6

.L1000c50e:
	moveal	%a3,%a0
	_DisposePtr
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	shi	%d3
	negb	%d3
	moveb	%d3,%d7

.L1000c51e:
	moveb	%d7,%d0
	moveml	%fp@(-24),%d3/%d7/%a3-%a4
	unlk	%fp
	rts

str_1000c52a:
	.short	0x6D6F,0x6465,0x6C00

str_1000c530:
	.short	0x4465,0x7669,0x6365,0x733A,0x6465,0x7669,0x6365,0x2D74
	.short	0x7265,0x6500

sub_1000c544:
	linkw	%fp,#0
	moveml	%a3-%a4,%sp@-
	moveal	%fp@(8),%a3
	moveq	#0,%d0
	moveb	%a3@,%d0
	addqw	#1,%d0
	extl	%d0
	_NewPtrSys
	moveal	%a0,%a4
	movel	%a4,%d0
	beqs	.L1000c56e
	moveal	%a3,%a0
	moveal	%a4,%a1
	moveq	#0,%d0
	moveb	%a3@,%d0
	addqw	#1,%d0
	extl	%d0
	_BlockMoveData

.L1000c56e:
	movel	%a4,%d0
	moveml	%fp@(-8),%a3-%a4
	unlk	%fp
	rts

sub_1000c57a:
	.short	0x4E56,0xFF00,0x48E7
	.short	0x0018,0x286E,0x000C,0x4214,0x598F,0x486E,0xFF00,0x2F2E
	.short	0x0008,0x4EBA,0x8732,0x7000,0x2F00,0x2F3C,0x9674,0x626C
	.short	0x4EBA,0xFA14,0x2640,0x200B,0x4FEF,0x000C,0x6714,0x2F2E
	.short	0x0010,0x2F0C,0x486E,0xFF00,0x2F0B,0x4EBA,0xFA80,0x4FEF
	.short	0x0010,0x2F0B,0x4EBA,0xFA5C,0x7000,0x1014,0x4A80,0x584F
	.short	0x660E,0x598F,0x2F0C,0x486E,0xFF00,0x4EBA,0x86EA,0x584F
	.short	0x4CEE,0x1800,0xFEF8,0x4E5E,0x4E75

sub_1000c5ea:
	linkw	%fp,#-516
	moveml	%a3-%a4,%sp@-
	moveal	0x2b6,%a0
	moveal	%a0@(758),%a4
	movel	%a4,%d0
	bnes	.L1000c628
	pea	%fp@(-516)
	jsr	%pc@(sub_1000c4a8)
	tstb	%d0
	addqw	#4,%sp
	beqs	.L1000c628
	pea	%fp@(-516)
	jsr	%pc@(sub_1000c544)
	moveal	%d0,%a4
	lea	%fp@(-516),%a0
	movel	%a0,%d0
	addqw	#4,%sp
	beqs	.L1000c628
	moveal	0x2b6,%a0
	movel	%a4,%a0@(758)

.L1000c628:
	movel	%a4,%d0
	beqs	.L1000c67c
	pea	%fp@(-4)
	pea	%fp@(-260)
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000c57a)
	moveq	#0,%d0
	moveb	%fp@(-260),%d0
	tstl	%d0
	lea	%sp@(12),%sp
	blss	.L1000c67c
	pea	%fp@(-260)
	jsr	%pc@(sub_1000c544)
	moveal	%d0,%a3
	movel	%a3,%d0
	addqw	#4,%sp
	beqs	.L1000c67c
	subql	#2,%sp
	movew	0x220,%sp@
	tstw	%sp@+
	bnes	.L1000c67c
	moveal	0x2b6,%a0
	movel	%a3,%a0@(754)
	subql	#2,%sp
	movel	#1835950445,%sp@-
	movel	%a3,%sp@-
	movew	#1025,%d0
	_GestaltValueDispatch
	addqw	#2,%sp

.L1000c67c:
	moveml	%fp@(-524),%a3-%a4
	unlk	%fp
	rts

sub_1000c686:
	linkw	%fp,#-532
	moveml	%d6-%d7/%a2-%a4,%sp@-
	lea	%fp@(-268),%a3
	lea	%fp@(-532),%a4
	clrb	%d6
	lea	%pc@(str_1000c7fa),%a0
	movel	%a0,%fp@(-8)
	lea	%pc@(str_1000c7ee),%a0
	movel	%a0,%fp@(-4)
	subql	#2,%sp
	jsr	%pc@(sub_100089ea)
	tstb	%sp@+
	beqw	.L1000c7d2
	moveq	#0,%d0
	moveal	%d0,%a2
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	#1651794540,%sp@-
	jsr	%pc@(sub_1000bfb6)
	movel	%d0,%fp@(-272)
	movel	%fp@(-4),%sp@-
	movel	%fp@(-8),%sp@-
	jsr	%pc@(sub_1000c2e4)
	moveal	%d0,%a2
	movel	%a2,%d0
	lea	%sp@(16),%sp
	beqs	.L1000c758
	tstl	%fp@(-272)
	beqs	.L1000c758
	clrw	%d7
	bras	.L1000c73e

.L1000c6ea:
	clrb	%a4@
	pea	%fp@(-276)
	movel	%a4,%sp@-
	movel	%a3,%sp@-
	movel	%fp@(-272),%sp@-
	jsr	%pc@(sub_1000c03c)
	tstb	%d0
	lea	%sp@(16),%sp
	beqs	.L1000c73a
	movel	%fp@(-276),%d0
	btst	#0,%d0
	beqs	.L1000c710
	moveq	#1,%d6

.L1000c710:
	moveq	#0,%d0
	moveb	%a4@,%d0
	tstl	%d0
	blss	.L1000c72a
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000c544)
	moveal	0x2b6,%a0
	movel	%d0,%a0@(758)
	addqw	#4,%sp
	bras	.L1000c73a

.L1000c72a:
	movel	%a3,%sp@-
	jsr	%pc@(sub_1000c544)
	moveal	0x2b6,%a0
	movel	%d0,%a0@(758)
	addqw	#4,%sp

.L1000c73a:
	movew	%d7,%d0
	addqw	#1,%d7

.L1000c73e:
	tstb	%d6
	bnes	.L1000c758
	movel	%a3,%sp@-
	moveq	#0,%d0
	movew	%d7,%d0
	movel	%d0,%sp@-
	movel	%a2,%sp@-
	jsr	%pc@(sub_1000c412)
	tstb	%d0
	lea	%sp@(12),%sp
	bnes	.L1000c6ea

.L1000c758:
	movel	%fp@(-272),%sp@-
	jsr	%pc@(sub_1000c022)
	movel	%a2,%d0
	addqw	#4,%sp
	beqs	.L1000c76a
	moveal	%a2,%a0
	_DisposePtr

.L1000c76a:
	tstb	%d6
	bnes	.L1000c790
	moveal	0x2b6,%a0
	tstl	%a0@(758)
	beqs	.L1000c790
	subql	#2,%sp
	moveal	0x2b6,%a0
	movel	%a0@(758),%sp@-
	pea	%pc@(str_1000c7e6)
	jsr	%pc@(sub_10005280)
	tstw	%sp@+
	bnes	.L1000c790
	moveq	#1,%d6

.L1000c790:
	tstb	%d6
	bnes	.L1000c7d4
	subql	#4,%sp
	movel	#1986359923,%sp@-
	moveq	#1,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a3
	movel	%a3,%d0
	beqs	.L1000c7b0
	tstl	%a3@
	bnes	.L1000c7b0
	movel	%a3,%sp@-
	_LoadResource

.L1000c7b0:
	movel	%a3,%d0
	beqs	.L1000c7d4
	tstl	%a3@
	beqs	.L1000c7d4
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L1000c7d4
	moveal	%a3@,%a0
	moveq	#0,%d0
	moveb	%a0@(2),%d0
	cmpib	#64,%d0
	bhis	.L1000c7d4
	moveq	#1,%d6
	bras	.L1000c7d4

.L1000c7d2:
	moveq	#1,%d6

.L1000c7d4:
	tstb	%d6
	bnes	.L1000c7dc
	_SysError 102

.L1000c7dc:
	moveml	%fp@(-552),%d6-%d7/%a2-%a4
	unlk	%fp
	rts

str_1000c7e6:
	.short	0x0669,0x4D61,0x632C,0x3100

str_1000c7ee:
	.short	0x636F
	.short	0x6D70,0x6174,0x6962,0x6C65,0x0000

str_1000c7fa:
	.string	"Devices:device-tree"

sub_1000c80e:
	linkw	%fp,#-58
	moveml	%d6-%d7/%a4,%sp@-
	lea	%fp@(-32),%a4
	clrw	%d7
	moveq	#0,%d0
	movel	%d0,%fp@(-58)
	moveq	#0,%d6
	clrw	%fp@(-54)
	movel	#1852990823,%d0
	lea	%fp@(-58),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	movew	%d0,%d7
	bnew	.L1000c924
	pea	%fp@(-52)
	moveq	#0,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	addqw	#4,%sp
	bnew	.L1000c924
	pea	%fp@(-52)
	pea	%pc@(str_1000c976)
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#12,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	lea	%sp@(12),%sp
	bnew	.L1000c91a
	moveq	#32,%d0
	movel	%d0,%fp@(-36)
	pea	%fp@(-36)
	movel	%a4,%sp@-
	pea	%pc@(str_1000c970)
	pea	%fp@(-52)
	moveq	#23,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	lea	%sp@(16),%sp
	bnew	.L1000c91a
	pea	%pc@(str_1000c964)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005502)
	tstl	%d0
	addqw	#8,%sp
	bnes	.L1000c8a2
	movew	#-250,%fp@(-54)
	bras	.L1000c8c4

.L1000c8a2:
	moveq	#2,%d0
	movel	%d0,%fp@(-36)
	pea	%fp@(-36)
	pea	%fp@(-54)
	pea	%pc@(str_1000c958)
	pea	%fp@(-52)
	moveq	#23,%d0
	_NameRegistryDispatch
	movew	%d0,%d7
	lea	%sp@(16),%sp
	bnes	.L1000c91a

.L1000c8c4:
	subql	#4,%sp
	movew	%fp@(-54),%sp@-
	jsr	%pc@(sub_1000c98a)
	movel	%sp@+,%d6
	beqs	.L1000c91a
	pea	%pc@(str_1000c94a)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005502)
	tstl	%d0
	addqw	#8,%sp
	beqs	.L1000c902
	pea	%pc@(str_1000c93c)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005502)
	tstl	%d0
	addqw	#8,%sp
	beqs	.L1000c902
	pea	%pc@(str_1000c92e)
	movel	%a4,%sp@-
	jsr	%pc@(sub_10005502)
	tstl	%d0
	addqw	#8,%sp
	bnes	.L1000c908

.L1000c902:
	oril	#65536,%d6

.L1000c908:
	subql	#2,%sp
	movel	#2037738784,%sp@-
	movel	%d6,%sp@-
	movew	#1025,%d0
	_GestaltValueDispatch
	addqw	#2,%sp

.L1000c91a:
	pea	%fp@(-52)
	moveq	#3,%d0
	_NameRegistryDispatch
	addqw	#4,%sp

.L1000c924:
	moveml	%fp@(-70),%d6-%d7/%a4
	unlk	%fp
	rts

str_1000c92e:
	.short	0x506F
	.short	0x7765,0x7242,0x6F6F,0x6B34,0x2C31,0x0000

str_1000c93c:
	.short	0x506F,0x7765
	.short	0x7242,0x6F6F,0x6B33,0x2C32,0x0000

str_1000c94a:
	.short	0x506F,0x7765,0x7242
	.short	0x6F6F,0x6B33,0x2C31,0x0000

str_1000c958:
	.short	0x636F,0x6C6F,0x722D,0x636F
	.short	0x6465,0x0000

str_1000c964:
	.short	0x506F,0x7765,0x724D,0x6163,0x312C,0x3200

str_1000c970:
	.short	0x6D6F,0x6465,0x6C00

str_1000c976:
	.short	0x4465,0x7669,0x6365,0x733A,0x6465
	.short	0x7669,0x6365,0x2D74,0x7265,0x6500

sub_1000c98a:
	linkw	%fp,#0
	moveq	#0,%d1
	movew	%fp@(8),%d0
	subiw	#-256,%d0
	bcsw	.L1000ca42
	cmpiw	#18,%d0
	bhiw	.L1000ca42
	addw	%d0,%d0
	movew	%pc@(off_1000c9ae,%d0:w),%d0
	jmp	%pc@(%d0:w)

off_1000c9ae:
	.short	.L1000c9d4-off_1000c9ae+2
	.short	.L1000c9d4-off_1000c9ae+2
	.short	.L1000c9dc-off_1000c9ae+2
	.short	.L1000c9e4-off_1000c9ae+2
	.short	.L1000c9ec-off_1000c9ae+2
	.short	.L1000c9f4-off_1000c9ae+2
	.short	.L1000c9fc-off_1000c9ae+2
	.short	.L1000c9fc-off_1000c9ae+2
	.short	.L1000c9fc-off_1000c9ae+2
	.short	.L1000ca04-off_1000c9ae+2
	.short	.L1000ca0c-off_1000c9ae+2
	.short	.L1000ca14-off_1000c9ae+2
	.short	.L1000ca1c-off_1000c9ae+2
	.short	.L1000ca24-off_1000c9ae+2
	.short	.L1000ca2c-off_1000c9ae+2
	.short	.L1000ca34-off_1000c9ae+2
	.short	.L1000ca3c-off_1000c9ae+2
	.short	.L1000ca24-off_1000c9ae+2
	.short	.L1000c9fc-off_1000c9ae+2

.L1000c9d4:
	movel	#2101,%d1
	bras	.L1000ca42

.L1000c9dc:
	movel	#2107,%d1
	bras	.L1000ca42

.L1000c9e4:
	movel	#2103,%d1
	bras	.L1000ca42

.L1000c9ec:
	movel	#2104,%d1
	bras	.L1000ca42

.L1000c9f4:
	movel	#2108,%d1
	bras	.L1000ca42

.L1000c9fc:
	movel	#2110,%d1
	bras	.L1000ca42

.L1000ca04:
	movel	#2111,%d1
	bras	.L1000ca42

.L1000ca0c:
	movel	#2113,%d1
	bras	.L1000ca42

.L1000ca14:
	movel	#2112,%d1
	bras	.L1000ca42

.L1000ca1c:
	movel	#2114,%d1
	bras	.L1000ca42

.L1000ca24:
	movel	#2119,%d1
	bras	.L1000ca42

.L1000ca2c:
	movel	#2120,%d1
	bras	.L1000ca42

.L1000ca34:
	movel	#2121,%d1
	bras	.L1000ca42

.L1000ca3c:
	movel	#2122,%d1

.L1000ca42:
	movel	%d1,%fp@(10)
	unlk	%fp
	moveal	%sp@+,%a0
	addqw	#2,%sp
	jmp	%a0@

sub_1000ca4e:
	.short	0x4E56
	.short	0x0000,0x2F06,0x1C38,0x01FB,0x7000,0x1006,0x740F,0xC400
	.short	0x7000,0x1002,0x0C40,0x000F,0x6708,0x7000,0x1002,0x4A80
	.short	0x6616,0x7000,0x1006,0x323C,0x00F0,0xC200,0x7000,0x1001
	.short	0x7201,0x8200,0x11C1,0x01FB,0x2C2E,0xFFFC,0x4E5E,0x4E75

sub_1000ca90:
	.short	0x4E56,0x0000,0x48E7,0x0118,0x266E,0x0008,0x2E0B,0x2047
	.short	0x3028,0x0008,0x48C0,0xD087,0x2840,0x554C,0x3014,0x48C0
	.short	0xD087,0x2840,0x21CC,0x0B18,0x4CEE,0x1880,0xFFF4,0x4E5E
	.short	0x4E75

sub_1000cac2:
	linkw	%fp,#0
	moveml	%d6-%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	movew	CurMap,%d6
	movel	%a4,%sp@-
	_DetachResource
	movel	%a4@,%sp@-
	jsr	%pc@(sub_1000ca90)
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	movel	%d1,%sp@-
	jsr	%pc@(sub_1000ccd8)
	movew	%d0,%d7
	lea	%sp@(12),%sp
	bnes	.L1000caf6
	jsr	%pc@(sub_1000cd14)
	movew	%d0,%d7

.L1000caf6:
	movew	%d6,CurMap
	movew	%d7,%d0
	moveml	%fp@(-12),%d6-%d7/%a4
	unlk	%fp
	rts

sub_1000cb06:
	linkw	%fp,#-252
	moveml	%d3-%d7/%a4,%sp@-
	movel	%fp@(12),%d5
	moveb	%fp@(11),%d6
	lea	%fp@(-74),%a4
	clrw	%d4
	subql	#2,%sp
	movew	#-32768,%sp@-
	movel	#1702392942,%sp@-
	moveq	#0,%d0
	moveb	%d0,%sp@-
	pea	%fp@(-6)
	pea	%fp@(-4)
	moveq	#0,%d0
	_AliasDispatch
	movew	%sp@+,%d7
	bnes	.L1000cbb0
	moveq	#0,%d3
	movew	%fp@(-6),%fp@(-160)

.L1000cb44:
	clrb	%a4@
	movel	%a4,%fp@(-164)
	addql	#1,%d3
	movew	%d3,%fp@(-154)
	movel	%fp@(-4),%fp@(-134)
	lea	%fp@(-182),%a0
	_PBHGetFInfoSync
	movew	%d0,%d7
	bnes	.L1000cbb0
	tstb	%d6
	beqs	.L1000cb6a
	cmpl	%fp@(-146),%d5
	bnes	.L1000cb44

.L1000cb6a:
	tstb	%d6
	bnes	.L1000cb74
	cmpl	%fp@(-146),%d5
	beqs	.L1000cb44

.L1000cb74:
	cmpil	#1869902700,%fp@(-150)
	bnes	.L1000cb44
	subql	#2,%sp
	movew	%fp@(-6),%sp@-
	movel	%fp@(-4),%sp@-
	movel	%a4,%sp@-
	pea	%fp@(-252)
	moveq	#1,%d0
	_HighLevelFSDispatch
	tstw	%sp@+
	bnes	.L1000cb44
	subql	#2,%sp
	pea	%fp@(-252)
	moveq	#0,%d0
	moveb	%d0,%sp@-
	movew	#-20,%sp@-
	_CodeFragmentDispatch
	tstw	%sp@+
	bnes	.L1000cb44
	movew	%d4,%d0
	addqw	#1,%d4
	bras	.L1000cb44

.L1000cbb0:
	movew	%d4,%d0
	moveml	%fp@(-276),%d3-%d7/%a4
	unlk	%fp
	rts

sub_1000cbbc:
	linkw	%fp,#-264
	moveml	%d7/%a4,%sp@-
	lea	%fp@(-256),%a4
	clrb	%d7
	moveq	#32,%d0
	andb	0xb20,%d0
	moveq	#0,%d1
	moveb	%d0,%d1
	tstl	%d1
	beqs	.L1000cc36
	movel	#1869898094,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000cb06)
	moveq	#0,%d1
	movew	%d0,%d1
	tstl	%d1
	addqw	#8,%sp
	blss	.L1000cc36
	movew	#-20500,%sp@-
	moveq	#1,%d0
	moveb	%d0,%sp@-
	jsr	%pc@(sub_1000cda2)
	subql	#2,%sp
	pea	%pc@(str_1000cc42)
	movel	#1886875747,%sp@-
	moveq	#1,%d0
	movel	%d0,%sp@-
	pea	%fp@(-264)
	pea	%fp@(-260)
	movel	%a4,%sp@-
	movew	#1,%sp@-
	_CodeFragmentDispatch
	tstw	%sp@+
	bnes	.L1000cc32
	movel	#1869898094,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000cb06)
	moveq	#1,%d7
	addqw	#8,%sp

.L1000cc32:
	jsr	%pc@(sub_100058ca)

.L1000cc36:
	moveb	%d7,%d0
	moveml	%fp@(-272),%d7/%a4
	unlk	%fp
	rts

str_1000cc42:
	.byte	0x09
	.string	"OTBootLib"
	.align	2

sub_1000cc4e:
	linkw	%fp,#-4
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000ca4e)
	jsr	%pc@(sub_1000cbbc)
	tstb	%d0
	bnes	.L1000cc9a
	subql	#4,%sp
	movel	#1869900909,%sp@-
	moveq	#9,%d0
	movew	%d0,%sp@-
	_GetResource
	moveal	%sp@+,%a4
	movel	%a4,%d0
	beqs	.L1000cc7c
	tstl	%a4@
	bnes	.L1000cc7c
	movel	%a4,%sp@-
	_LoadResource

.L1000cc7c:
	movel	%a4,%d0
	beqs	.L1000cc96
	tstl	%a4@
	beqs	.L1000cc96
	subql	#2,%sp
	_ResError
	tstw	%sp@+
	bnes	.L1000cc96
	movel	%a4,%sp@-
	jsr	%pc@(sub_1000cac2)
	addqw	#4,%sp
	bras	.L1000cc9a

.L1000cc96:
	_SysError 15

.L1000cc9a:
	movel	#_fcc_bbox,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnes	.L1000ccd0
	moveq	#4,%d0
	andl	%fp@(-4),%d0
	beqs	.L1000ccd0
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#1,%d1
	movel	%d1,%sp@-
	movel	#1919181156,%sp@-
	movel	#202285,%d0
	_BlueBoxDispatch
	lea	%sp@(12),%sp

.L1000ccd0:
	moveal	%fp@(-8),%a4
	unlk	%fp
	rts

sub_1000ccd8:
	linkw	%fp,#0
	moveml	%a2-%a3,%sp@-
	moveq	#16,%d0
	moveq	#32,%d2
	muluw	%d2,%d0
	addiw	#650,%d0
	_NewPtrSysClear
	bnes	.L1000cd0a
	movew	%d2,%a0@
	moveal	0x2b6,%a1
	lea	%a1@(116),%a1
	movel	%fp@(12),%a0@(494)
	movel	%a0,%a1@
	moveal	0xb18,%a3
	moveq	#16,%d0
	jsr	%a3@(2)

.L1000cd0a:
	extl	%d0
	moveml	%sp@+,%a2-%a3
	unlk	%fp
	rts

sub_1000cd14:
	moveq	#0,%d0
	moveal	0xd1c,%a0
	cmpaw	#-1,%a0
	bnes	.L1000cd30
	moveq	#28,%d0
	_ReserveMemSys
	moveq	#28,%d0
	_NewHandleSysClear
	bnes	.L1000cd9e
	movel	%a0,0xd1c
	bras	.L1000cd5c

.L1000cd30:
	_HUnlock
	moveq	#28,%d0
	_ReserveMemSys
	bnes	.L1000cd9e
	moveq	#28,%d0
	_NewHandleSysClear
	bnes	.L1000cd9e
	movel	%a0,%d1
	moveal	%a0@,%a1
	moveal	0xd1c,%a0
	movel	%a0@,%d0
	moveal	%d0,%a0
	moveq	#16,%d0
	_BlockMoveData
	moveal	0xd1c,%a0
	movel	%d1,0xd1c
	bras	.L1000cd5a

.L1000cd58:
	moveal	%d1,%a0

.L1000cd5a:
	_DisposeHandle

.L1000cd5c:
	moveal	0xd1c,%a0
	_HLock
	moveq	#0,%d0
	moveal	0x2b6,%a0
	_GetPtrSize
	cmpil	#490,%d0
	bges	.L1000cd96
	moveal	%a0,%a1
	movel	%d0,%d1
	movel	#490,%d0
	_NewPtr
	bnes	.L1000cd9e
	movew	%sr,%sp@-
	oriw	#9728,%sr
	exg	%a0,%a1
	movel	%d1,%d0
	_BlockMoveData
	movel	%a1,0x2b6
	movew	%sp@+,%sr
	_DisposePtr
	moveal	%a1,%a0

.L1000cd96:
	clrw	%a0@(488)
	moveq	#0,%d0
	rts

.L1000cd9e:
	moveq	#-108,%d0
	rts

sub_1000cda2:
	linkw	%fp,#-404
	moveml	%d5-%d7,%sp@-
	movew	%fp@(10),%d6
	movel	#1937339254,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	bnew	.L1000ceaa
	cmpil	#1792,%fp@(-4)
	bltw	.L1000ceaa
	clrb	%d7
	lea	%fp@(-124),%a0
	movel	%a0,%d0
	exg	%d0,%a5
	movel	%d0,%d5
	pea	%fp@(-128)
	_InitGraf
	pea	%fp@(-244)
	pea	%fp@(-12)
	jsr	%pc@(sub_1000cf0e)
	pea	%fp@(-120)
	_OpenCPort
	movel	#1768124270,%d0
	lea	%fp@(-4),%a0
	moveal	%a0,%a1
	_Gestalt
	movel	%a0,%a1@
	tstw	%d0
	addqw	#8,%sp
	bnes	.L1000ce74
	moveq	#4,%d0
	andl	%fp@(-4),%d0
	beqs	.L1000ce74
	pea	%fp@(-400)
	jsr	%pc@(sub_1000cff2)
	tstw	%d0
	addqw	#4,%sp
	bnes	.L1000ce74
	subql	#2,%sp
	movel	#1936224119,%sp@-
	movel	#1768843636,%sp@-
	pea	%fp@(-400)
	movew	%d6,%sp@-
	pea	%fp@(-404)
	moveq	#35,%d0
	_IconServicesDispatch
	tstw	%sp@+
	bnes	.L1000ce74
	subql	#2,%sp
	pea	%fp@(-12)
	moveq	#5,%d0
	movew	%d0,%sp@-
	moveq	#0,%d1
	movew	%d1,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%fp@(-404),%sp@-
	moveq	#14,%d0
	_IconServicesDispatch
	tstw	%sp@+
	bnes	.L1000ce60
	moveq	#1,%d7

.L1000ce60:
	subql	#2,%sp
	movel	#1936224119,%sp@-
	movel	#1768843636,%sp@-
	moveq	#8,%d0
	_IconServicesDispatch
	addqw	#2,%sp

.L1000ce74:
	tstb	%d7
	bnes	.L1000ce92
	subql	#2,%sp
	pea	%fp@(-12)
	moveq	#0,%d0
	movew	%d0,%sp@-
	movew	%d0,%sp@-
	movew	%d6,%sp@-
	movew	#1280,%d0
	_IconDispatch
	tstw	%sp@+
	bnes	.L1000ce92
	moveq	#1,%d7

.L1000ce92:
	pea	%fp@(-120)
	_CloseCPort
	tstb	%d7
	beqs	.L1000cea6
	tstb	%fp@(8)
	beqs	.L1000cea6
	jsr	%pc@(sub_1000cfc6)

.L1000cea6:
	movel	%d5,%d0
	exg	%d0,%a5

.L1000ceaa:
	moveml	%fp@(-416),%d5-%d7
	unlk	%fp
	movel	%sp@+,%sp@
	rts

sub_1000ceb6:
	linkw	%fp,#0
	moveal	#2348,%a0
	movew	#-1,%a0@
	moveal	#2348,%a0
	movew	#-1,%a0@(2)
	unlk	%fp
	rts

sub_1000ced4:
	linkw	%fp,#0
	movew	%fp@(10),%d2
	moveq	#0,%d0
	movew	%d2,%d0
	movew	#-32768,%d1
	andw	%d0,%d1
	beqs	.L1000cefc
	moveq	#0,%d0
	movew	%d2,%d0
	lsll	#1,%d0
	movel	#4129,%d1
	eorl	%d1,%d0
	moveq	#1,%d1
	eorl	%d1,%d0
	bras	.L1000cf0a

.L1000cefc:
	moveq	#0,%d0
	movew	%d2,%d0
	lsll	#1,%d0
	movel	#4129,%d1
	eorl	%d1,%d0

.L1000cf0a:
	unlk	%fp
	rts

sub_1000cf0e:
	linkw	%fp,#0
	moveml	%d7/%a3-%a4,%sp@-
	moveal	%fp@(12),%a3
	moveal	%fp@(8),%a4
	movew	%a3@(6),%d7
	subw	%a3@(2),%d7
	movew	%d7,%d0
	extl	%d0
	divsw	#40,%d0
	swap	%d0
	extw	%d0
	subw	%d0,%d7
	moveal	#2348,%a0
	moveq	#0,%d0
	movew	%a0@,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000ced4)
	extl	%d0
	moveal	#2348,%a0
	moveq	#0,%d1
	movew	%a0@(2),%d1
	cmpl	%d0,%d1
	addqw	#4,%sp
	beqs	.L1000cf62
	moveal	#2348,%a0
	movew	#8,%a0@

.L1000cf62:
	moveal	#2348,%a0
	moveq	#0,%d0
	movew	%a0@,%d0
	extl	%d7
	movel	%d7,%d1
	jsr	%pc@(sub_1000d7e4)
	movew	%d0,%a4@(2)
	moveal	#2348,%a0
	moveq	#0,%d0
	movew	%a0@,%d0
	extl	%d7
	movel	%d7,%d1
	jsr	%pc@(sub_1000d7b6)
	addql	#1,%d0
	movel	%d0,%d1
	muluw	#40,%d0
	swap	%d1
	muluw	#40,%d1
	swap	%d1
	clrw	%d1
	addl	%d1,%d0
	movew	%a3@(4),%d1
	subw	%d0,%d1
	movew	%d1,%a4@
	movew	%a4@(2),%d0
	.short	0xd07c,0x0020	/* addw	#32,%d0 */
	movew	%d0,%a4@(6)
	movew	%a4@,%d0
	.short	0xd07c,0x0020	/* addw	#32,%d0 */
	movew	%d0,%a4@(4)
	moveml	%fp@(-12),%d7/%a3-%a4
	unlk	%fp
	rts

sub_1000cfc6:
	linkw	%fp,#0
	moveal	#2348,%a0
	addiw	#40,%a0@
	moveal	#2348,%a0
	moveq	#0,%d0
	movew	%a0@,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000ced4)
	moveal	#2348,%a0
	movew	%d0,%a0@(2)
	unlk	%fp
	rts

sub_1000cff2:
	linkw	%fp,#-318
	moveml	%d7/%a4,%sp@-
	lea	%fp@(-318),%a4
	movel	%a4,%fp@(-44)
	clrw	%fp@(-40)
	subql	#2,%sp
	_CurResFile
	movew	%sp@+,%fp@(-38)
	clrw	%fp@(-34)
	lea	%fp@(-62),%a0
	moveq	#8,%d0
	_HFSDispatch
	movew	%d0,%d7
	bnes	.L1000d034
	subql	#2,%sp
	movew	%fp@(-40),%sp@-
	movel	%fp@(-4),%sp@-
	movel	%a4,%sp@-
	movel	%fp@(8),%sp@-
	moveq	#1,%d0
	_HighLevelFSDispatch
	movew	%sp@+,%d7

.L1000d034:
	movew	%d7,%d0
	moveml	%fp@(-326),%d7/%a4
	unlk	%fp
	rts

sub_1000d040:
	linkw	%fp,#0
	moveml	%a3-%a4,%sp@-
	moveal	%fp@(16),%a3
	moveal	%fp@(8),%a4
	moveq	#0,%d0
	movel	%d0,%a3@
	movel	%a4,%d1
	beqs	.L1000d074
	tstl	%a4@
	beqs	.L1000d074
	moveal	%a4@,%a0
	moveal	%a0@,%a0
	tstw	%a0@
	bnes	.L1000d072
	subql	#2,%sp
	movel	%a4@,%sp@-
	moveq	#14,%d0
	movew	%d0,%sp@-
	_TestDeviceAttribute
	tstb	%sp@+
	bnes	.L1000d074

.L1000d072:
	movel	%a4@,%a3@

.L1000d074:
	moveml	%fp@(-8),%a3-%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

sub_1000d084:
	linkw	%fp,#0
	moveq	#2,%d0
	cmpw	%fp@(12),%d0
	bnes	.L1000d09a
	moveq	#0,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000d2d6)
	addqw	#4,%sp

.L1000d09a:
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(10),%sp
	jmp	%a0@

sub_1000d0a4:
	linkw	%fp,#-8
	moveml	%d5-%d7/%a2-%a4,%sp@-
	movew	%fp@(10),%d5
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	moveq	#1,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000d2d6)
	moveal	%d0,%a4
	movel	%a4,%d0
	addqw	#4,%sp
	beqs	.L1000d0d2
	moveal	0x2b6,%a2
	moveal	%a2@(818),%a3
	movel	%a2@(822),%d6

.L1000d0d2:
	movel	%a4,%d0
	beqs	.L1000d114
	movel	%a3,%d0
	beqs	.L1000d114
	moveq	#0,%d7
	bras	.L1000d110

.L1000d0de:
	subql	#2,%sp
	movel	%a3,%sp@-
	movel	%d7,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%fp@(-4)
	movew	#2773,%d0
	_DisplayDispatch
	tstl	%fp@(-4)
	addqw	#2,%sp
	beqs	.L1000d106
	moveal	%fp@(-4),%a0
	moveal	%a0@,%a0
	cmpw	%a0@,%d5
	beqs	.L1000d114

.L1000d106:
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	movel	%d7,%d0
	addql	#1,%d7

.L1000d110:
	cmpl	%d7,%d6
	bhis	.L1000d0de

.L1000d114:
	movel	%fp@(-4),%d0
	moveml	%fp@(-32),%d5-%d7/%a2-%a4
	unlk	%fp
	rts

sub_1000d122:
	linkw	%fp,#-8
	moveml	%d7/%a4,%sp@-
	movew	%fp@(10),%d0
	extl	%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000d0a4)
	moveal	%d0,%a4
	clrb	%d7
	movel	%a4,%d0
	addqw	#4,%sp
	beqs	.L1000d18c
	moveq	#0,%d0
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-4)
	subql	#2,%sp
	movel	%a4,%sp@-
	pea	%fp@(-8)
	moveq	#0,%d0
	moveb	%d0,%sp@-
	movew	#1311,%d0
	_DisplayDispatch
	tstw	%sp@+
	bnes	.L1000d18c
	subql	#2,%sp
	movel	%fp@(-8),%sp@-
	movel	#1668246893,%sp@-
	pea	%fp@(-4)
	movew	#1747,%d0
	_DisplayDispatch
	tstw	%sp@+
	bnes	.L1000d18c
	moveq	#1,%d0
	andl	%fp@(-4),%d0
	bnes	.L1000d18c
	moveq	#2,%d0
	andl	%fp@(-4),%d0
	beqs	.L1000d18c
	moveq	#1,%d7

.L1000d18c:
	moveb	%d7,%d0
	moveml	%fp@(-16),%d7/%a4
	unlk	%fp
	rts

sub_1000d198:
	linkw	%fp,#-98
	moveml	%d3/%d6-%d7/%a4,%sp@-
	moveal	%fp@(12),%a4
	clrb	%d6
	moveq	#0,%d7
	clrl	%fp@(-52)
	clrl	%fp@(-56)
	clrl	%fp@(-60)
	clrl	%fp@(-64)
	clrl	%fp@(-68)
	clrl	%fp@(-72)
	clrl	%fp@(-76)
	moveq	#0,%d0
	movel	%d0,%fp@(-80)
	clrw	%fp@(-82)
	movel	%d0,%fp@(-86)
	movel	%d0,%fp@(-90)
	clrl	%fp@(-94)
	movel	%d0,%fp@(-98)
	movel	%d0,%fp@(-4)
	movel	%d0,%fp@(-8)
	movel	%d0,%fp@(-12)
	movel	%d0,%fp@(-16)
	movel	%d0,%fp@(-20)
	movel	%d0,%fp@(-24)
	movel	%d0,%fp@(-28)
	movel	%d0,%fp@(-32)
	movel	%d0,%fp@(-36)
	movel	%d0,%fp@(-40)
	movel	%d0,%fp@(-44)
	movel	%d0,%fp@(-48)
	movew	%fp@(10),%fp@(-74)
	movew	#32,%fp@(-72)
	lea	%fp@(-48),%a0
	movel	%a0,%fp@(-70)
	lea	%fp@(-98),%a0
	_Status
	tstw	%d0
	bnes	.L1000d240
	moveq	#7,%d0
	andl	%fp@(-32),%d0
	moveq	#7,%d1
	cmpl	%d0,%d1
	seq	%d3
	negb	%d3
	moveb	%d3,%d6
	movel	%fp@(-28),%d7

.L1000d240:
	movel	%a4,%d0
	beqs	.L1000d246
	movel	%d7,%a4@

.L1000d246:
	moveb	%d6,%d0
	moveml	%fp@(-114),%d3/%d6-%d7/%a4
	unlk	%fp
	rts

sub_1000d252:
	linkw	%fp,#0
	moveml	%d6-%d7/%a4,%sp@-
	moveal	%fp@(8),%a4
	movel	%a4,%d0
	beqs	.L1000d2c6
	tstl	%a4@
	beqs	.L1000d2c6
	moveal	%a4@,%a0
	moveal	%a0@,%a0
	movew	%a0@,%d7
	bnes	.L1000d27c
	subql	#2,%sp
	movel	%a4@,%sp@-
	moveq	#14,%d0
	movew	%d0,%sp@-
	_TestDeviceAttribute
	tstb	%sp@+
	bnes	.L1000d2c6

.L1000d27c:
	moveal	%fp@(16),%a0
	moveb	%a0@,%d6
	extl	%d7
	movel	%d7,%sp@-
	tstb	%d6
	beqs	.L1000d28e
	moveq	#1,%d0
	bras	.L1000d290

.L1000d28e:
	moveq	#0,%d0

.L1000d290:
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000d3bc)
	tstb	%d0
	addqw	#8,%sp
	beqs	.L1000d2c6
	tstb	%d6
	beqs	.L1000d2c6
	moveal	0x2b6,%a0
	tstb	%a0@(57)
	beqs	.L1000d2c6
	moveal	0x2b6,%a0
	moveq	#0,%d0
	moveb	%a0@(63),%d0
	movel	%fp@(12),%d1
	moveq	#1,%d2
	lsll	%d1,%d2
	orl	%d0,%d2
	moveal	0x2b6,%a0
	moveb	%d2,%a0@(63)

.L1000d2c6:
	moveml	%fp@(-12),%d6-%d7/%a4
	unlk	%fp
	moveal	%sp@+,%a0
	lea	%sp@(12),%sp
	jmp	%a0@

sub_1000d2d6:
	linkw	%fp,#-12
	moveml	%d6-%d7/%a2-%a4,%sp@-
	moveb	%fp@(11),%d7
	moveq	#0,%d0
	moveal	%d0,%a4
	_GetZone
	moveal	%a0,%a2
	subql	#4,%sp
	movel	0x2a6,%sp@
	moveal	%sp@+,%a0
	_SetZone
	lea	%pc@(sub_1000d040),%a4
	moveal	0x2b6,%a0
	movel	%a0@(818),%fp@(-8)
	beqs	.L1000d332
	moveq	#0,%d0
	moveb	%d7,%d0
	tstl	%d0
	bnes	.L1000d332
	subql	#2,%sp
	movel	%fp@(-8),%sp@-
	movew	#556,%d0
	_DisplayDispatch
	tstw	%sp@+
	bnes	.L1000d332
	moveal	0x2b6,%a0
	moveq	#0,%d0
	movel	%d0,%a0@(818)
	moveal	0x2b6,%a0
	movel	%d0,%a0@(822)
	movel	%d0,%fp@(-8)

.L1000d332:
	tstl	%fp@(-8)
	bnes	.L1000d36a
	moveq	#23,%d6
	subql	#2,%sp
	movel	%d6,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%d0,%sp@-
	pea	%fp@(-12)
	pea	%fp@(-8)
	movew	#2774,%d0
	_DisplayDispatch
	tstw	%sp@+
	bnes	.L1000d36a
	moveal	0x2b6,%a0
	movel	%fp@(-8),%a0@(818)
	moveal	0x2b6,%a0
	movel	%fp@(-12),%a0@(822)

.L1000d36a:
	moveq	#0,%d0
	moveb	%d7,%d0
	cmpiw	#2,%d0
	bnes	.L1000d3ac
	moveal	0x2b6,%a0
	moveq	#0,%d0
	moveb	%a0@(826),%d0
	tstl	%d0
	bnes	.L1000d3ac
	lea	%pc@(sub_1000d084),%a3
	movel	%a3,%d0
	beqs	.L1000d3ac
	subql	#2,%sp
	movel	%a3,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	moveq	#0,%d0
	movew	%d0,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movew	#2031,%d0
	_DisplayDispatch
	moveal	0x2b6,%a0
	moveb	#1,%a0@(826)
	addqw	#2,%sp

.L1000d3ac:
	moveal	%a2,%a0
	_SetZone
	movel	%a4,%d0
	moveml	%fp@(-32),%d6-%d7/%a2-%a4
	unlk	%fp
	rts

sub_1000d3bc:
	linkw	%fp,#-190
	moveml	%d3-%d7/%a3-%a4,%sp@-
	movew	%fp@(14),%d7
	lea	%fp@(-68),%a3
	lea	%fp@(-76),%a4
	moveq	#0,%d0
	movel	%d0,%fp@(-4)
	clrb	%d6
	pea	%fp@(-4)
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000d198)
	tstb	%d0
	addqw	#8,%sp
	beqw	.L1000d650
	extl	%d7
	movel	%d7,%sp@-
	jsr	%pc@(sub_1000d122)
	tstb	%d0
	addqw	#4,%sp
	beqw	.L1000d650
	clrl	%fp@(-144)
	clrl	%fp@(-148)
	clrl	%fp@(-152)
	clrl	%fp@(-156)
	clrl	%fp@(-160)
	clrl	%fp@(-164)
	clrl	%fp@(-168)
	moveq	#0,%d0
	movel	%d0,%fp@(-172)
	clrw	%fp@(-174)
	movel	%d0,%fp@(-178)
	movel	%d0,%fp@(-182)
	clrl	%fp@(-186)
	movel	%d0,%fp@(-190)
	movel	%d0,%fp@(-80)
	movel	%d0,%fp@(-84)
	movel	%d0,%fp@(-88)
	movel	%d0,%fp@(-92)
	movel	%d0,%fp@(-96)
	movel	%d0,%fp@(-100)
	movel	%d0,%fp@(-104)
	movel	%d0,%fp@(-108)
	movel	%d0,%fp@(-112)
	movel	%d0,%fp@(-116)
	movel	%d0,%fp@(-120)
	movel	%d0,%fp@(-124)
	movel	%d0,%fp@(-128)
	movel	%d0,%fp@(-132)
	movel	%d0,%fp@(-136)
	movel	%d0,%fp@(-140)
	lea	%pc@(byte_1000d65c),%a0
	lea	%a3@(1),%a1
	moveq	#62,%d1

.L1000d47c:
	moveb	%a0@+,%a1@+
	dbf	%d1,.L1000d47c
	clrb	%a3@
	moveq	#1,%d5
	moveb	#81,%a4@
	moveb	#0x82,%a4@(1)
	moveb	#1,%a4@(2)
	moveb	#0xd6,%a4@(3)
	moveb	%a4@,%d1
	moveq	#110,%d2
	eorb	%d1,%d2
	moveb	%a4@(1),%d1
	eorb	%d1,%d2
	moveb	%a4@(2),%d1
	eorb	%d1,%d2
	moveb	%a4@(3),%d1
	eorb	%d1,%d2
	moveb	%d2,%a4@(4)
	movel	%d0,%fp@(-140)
	moveq	#1,%d1
	movel	%d1,%fp@(-120)
	moveq	#110,%d0
	movel	%d0,%fp@(-124)
	movel	%a4,%fp@(-116)
	moveq	#7,%d0
	movel	%d0,%fp@(-112)
	moveq	#2,%d0
	movel	%d0,%fp@(-104)
	moveq	#111,%d0
	movel	%d0,%fp@(-108)
	movel	%a3,%fp@(-100)
	moveq	#64,%d0
	movel	%d0,%fp@(-96)
	movel	%fp@(-4),%d2
	btst	#0,%d2
	beqs	.L1000d502
	oril	#1,%fp@(-136)
	movel	#50000,%fp@(-132)

.L1000d502:
	movew	%d7,%fp@(-166)
	movew	#33,%fp@(-164)
	lea	%fp@(-140),%a0
	movel	%a0,%fp@(-162)
	lea	%fp@(-190),%a0
	_Control
	tstw	%d0
	bnes	.L1000d590
	moveq	#0,%d0
	moveb	%a3@,%d0
	cmpiw	#110,%d0
	bnes	.L1000d590
	moveq	#0,%d0
	moveb	%a3@(1),%d0
	cmpiw	#136,%d0
	bnes	.L1000d590
	moveq	#0,%d0
	moveb	%a3@(2),%d0
	cmpiw	#2,%d0
	bnes	.L1000d590
	moveb	%a3@,%d0
	moveq	#80,%d1
	eorb	%d0,%d1
	moveb	%a3@(1),%d0
	eorb	%d0,%d1
	moveb	%a3@(2),%d0
	eorb	%d0,%d1
	moveb	%a3@(3),%d0
	eorb	%d0,%d1
	moveb	%a3@(4),%d0
	eorb	%d0,%d1
	moveb	%a3@(5),%d0
	eorb	%d0,%d1
	moveb	%a3@(6),%d0
	eorb	%d0,%d1
	moveb	%a3@(7),%d0
	eorb	%d0,%d1
	moveb	%a3@(8),%d0
	eorb	%d0,%d1
	moveb	%a3@(9),%d0
	eorb	%d0,%d1
	moveb	%d1,%d4
	cmpb	%a3@(10),%d4
	bnes	.L1000d590
	moveq	#0,%d0
	moveb	%a3@(3),%d0
	tstl	%d0
	beqs	.L1000d590
	clrb	%d5

.L1000d590:
	tstb	%d5
	beqw	.L1000d650
	moveb	#81,%a4@
	moveb	#0x84,%a4@(1)
	moveb	#3,%a4@(2)
	moveb	#0xd6,%a4@(3)
	clrb	%a4@(4)
	tstb	%fp@(11)
	beqs	.L1000d5ba
	moveq	#1,%d0
	bras	.L1000d5bc

.L1000d5ba:
	moveq	#4,%d0

.L1000d5bc:
	moveb	%d0,%a4@(5)
	moveb	%a4@,%d0
	moveq	#110,%d1
	eorb	%d0,%d1
	moveb	%a4@(1),%d0
	eorb	%d0,%d1
	moveb	%a4@(2),%d0
	eorb	%d0,%d1
	moveb	%a4@(3),%d0
	eorb	%d0,%d1
	moveb	%a4@(4),%d0
	eorb	%d0,%d1
	moveb	%a4@(5),%d0
	eorb	%d0,%d1
	moveb	%d1,%a4@(6)
	moveq	#0,%d0
	movel	%d0,%fp@(-140)
	moveq	#110,%d1
	movel	%d1,%fp@(-124)
	moveq	#1,%d0
	movel	%d0,%fp@(-120)
	movel	%a4,%fp@(-116)
	moveq	#7,%d0
	movel	%d0,%fp@(-112)
	moveq	#0,%d0
	movel	%d0,%fp@(-104)
	movel	%d0,%fp@(-108)
	movel	%d0,%fp@(-100)
	movel	%d0,%fp@(-96)
	movel	%fp@(-4),%d2
	btst	#0,%d2
	beqs	.L1000d630
	oril	#1,%fp@(-136)
	movel	#50000,%fp@(-132)

.L1000d630:
	movew	%d7,%fp@(-166)
	movew	#33,%fp@(-164)
	lea	%fp@(-140),%a0
	movel	%a0,%fp@(-162)
	lea	%fp@(-190),%a0
	_Control
	tstw	%d0
	seq	%d3
	negb	%d3
	moveb	%d3,%d6

.L1000d650:
	moveb	%d6,%d0
	moveml	%fp@(-218),%d3-%d7/%a3-%a4
	unlk	%fp
	rts

byte_1000d65c:
	.short	0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.short	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

sub_1000d69c:
	linkw	%fp,#-8
	moveml	%d7/%a4,%sp@-
	lea	%pc@(sub_1000d252),%a4
	moveq	#23,%d7
	moveq	#0,%d0
	movel	%d0,%sp@-
	jsr	%pc@(sub_1000d2d6)
	movel	%a4,%d0
	addqw	#4,%sp
	beqs	.L1000d70a
	subql	#2,%sp
	movel	%d7,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%d0,%sp@-
	pea	%fp@(-4)
	pea	%fp@(-8)
	movew	#2774,%d0
	_DisplayDispatch
	tstw	%sp@+
	bnes	.L1000d70a
	moveq	#0,%d7
	bras	.L1000d6f6

.L1000d6d8:
	subql	#2,%sp
	movel	%fp@(-8),%sp@-
	movel	%d7,%sp@-
	moveq	#0,%d0
	movel	%d0,%sp@-
	movel	%a4,%sp@-
	pea	%fp@(8)
	movew	#2773,%d0
	_DisplayDispatch
	addqw	#2,%sp
	movel	%d7,%d0
	addql	#1,%d7

.L1000d6f6:
	cmpl	%fp@(-4),%d7
	bcss	.L1000d6d8
	subql	#2,%sp
	movel	%fp@(-8),%sp@-
	movew	#556,%d0
	_DisplayDispatch
	addqw	#2,%sp

.L1000d70a:
	movel	%a4,%d0
	moveml	%fp@(-16),%d7/%a4
	unlk	%fp
	moveal	%sp@+,%a0
	addqw	#2,%sp
	jmp	%a0@

sub_1000d71a:
	CallVector 0x2010 1
	rts

sub_1000d724:
	CallVector 0x2010 12
	rts

sub_1000d72e:
	CallVector 0x2010 27
	rts

sub_1000d738:
	CallVector 0x2010 44
	rts

sub_1000d742:
	CallVector 0x2024 2
	rts

sub_1000d74c:
	CallVector 0x2028 27
	rts

sub_1000d756:
	CallVector 0x202c 96
	rts

sub_1000d760:
	CallVector 0x2044 16
	rts

sub_1000d76a:
	CallVector 0x2044 28
	rts

sub_1000d774:
	CallVector 0x205c 117
	rts

sub_1000d77e:
	movel	%sp@(4),%d0
	movel	%sp@(8),%d1

sub_1000d786:
	movel	%d0,%sp@-
	muluw	%d1,%d0
	moveal	%d0,%a0
	movel	%d1,%d0
	muluw	%sp@+,%d1
	clrw	%d0
	swap	%d0
	beqs	.L1000d798
	muluw	%sp@,%d0

.L1000d798:
	addql	#2,%sp
	addw	%d1,%d0
	swap	%d0
	clrw	%d0
	addl	%a0,%d0
	rts

	.byte	0x86
	.byte	0x06
	.string	"ULMULT"
	.align	2

	movel	%sp@(4),%d1
	movel	%sp@(8),%d0

sub_1000d7b6:
	lea	%pc@(.L1000d7c2),%a0
	moveaw	#2,%a1
	jmp	%a0@(-2,%a1:w:2)

.L1000d7c2:
	bras	.L1000d7ca
	divsll	%d1,%d1,%d0
	rts

.L1000d7ca:
	jsr	%pc@(sub_1000d7fa)
	movel	%d1,%d0
	rts

	.byte	0x85
	.byte	0x05
	.string	"LDIVT"
	.align	4

	movel	%sp@(4),%d1

.L1000d7e0:
	movel	%sp@(8),%d0

sub_1000d7e4:
	lea	%pc@(.L1000d7f0),%a0
	moveaw	#2,%a1
	jmp	%a0@(-2,%a1:w:2)

.L1000d7f0:
	bras	sub_1000d7fa

	divsll	%d1,%d1,%d0
	exg	%d1,%d0
	rts

sub_1000d7fa:
	tstl	%d0
	bmis	.L1000d812
	tstl	%d1
	bmis	.L1000d808
	jsr	%pc@(sub_1000d854)
	rts

.L1000d808:
	negl	%d1
	jsr	%pc@(sub_1000d854)
	negl	%d1
	rts

.L1000d812:
	negl	%d0
	tstl	%d1
	bmis	.L1000d822
	jsr	%pc@(sub_1000d854)
	negl	%d0
	negl	%d1
	rts

.L1000d822:
	negl	%d1
	jsr	%pc@(sub_1000d854)
	negl	%d0
	rts

	.byte	0x85
	.byte	0x05
	.ascii	"LMODT"
	.byte	0x00,0x00,0x00

	movel	%sp@(4),%d1
	movel	%sp@(8),%d0
	lea	%pc@(.L1000d84a),%a0
	moveaw	#2,%a1
	jmp	%a0@(-2,%a1:w:2)

.L1000d84a:
	.short	0x6008,0x4C41,0x0001
	.short	0xC340,0x4E75

sub_1000d854:
	.short	0x3F01,0x4841,0x4A41,0x661C,0x2200,0x4241
	.short	0x4841,0x670A,0x82D7,0x4841,0x4840,0x3001,0x4840,0x80DF
	.short	0x3200,0x4240,0x4840,0x4E75,0x4841,0x3E82,0x2F03,0x3400
	.short	0x2601,0x7201,0x4240,0x4840,0x660C,0x4840,0x3002,0x7200
	.short	0x6016,0xD241,0x6512,0xD442,0xD180,0xB083,0x65F4,0x9083
	.short	0xD241,0x08C1,0x0000,0x64EE,0x261F,0x341F,0x4E75

	.byte	0x86
	.byte	0x06
	.ascii	"ULMODT"
	.short	0x0000
