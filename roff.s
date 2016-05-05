   jms main
   sys exit
main: 0
   lac o_pl
   cma
   tad o_m1
   tad o_m2
   tad o_m3
   tad o_m4
   tad d2
   cma
   dac TXTLEN
   dzm assylen
   dzm .temp1
   lac assyline
   dac .ptr
   lac .temp1
   dac .ptr i
   jms readfile
   dac .temp1
   jms writebreak
   dac .temp2
   jms endpage
   dac .temp3
   jms .exit
   dac .temp4
   jmp main i
readfile: 0
LL1:
   jms readline
   sna
   jmp LL2
   lac isrequest
   sna
   jmp LL3
   jmp LL1
LL3:
   jmp LL1
LL2:
   jmp readfile i
readline: 0
   dzm isrequest
   lac d1
   dac readline.startline
   dzm readline.doingword
   jms suck
   dac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL5
   lac d1
   dac o_sp
   jms writebreak
   dac .temp1
   jmp out
   jmp LL6
LL5:
   lac c
   dac isspace.c
   jms isspace
   sna
   jmp LL8
   jms writebreak
   dac .temp1
LL8:
LL6:
LL10:
   lac d1
   sna
   jmp LL11
   lac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL12
   lac readline.doingword
   sna
   jmp LL15
   jms bumpword
   dac .temp1
LL15:
   jmp LL11
LL12:
   lac c
   dac isspace.c
   jms isspace
   sna
   jmp LL17
   lac readline.doingword
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL19
   dzm readline.startline
   lac c
   sad d32
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL22
   lac d32
   dac .temp1
   lac assyline
   tad assylen
   dac .ptr
   lac .temp1
   dac .ptr i
   isz assylen
   nop
LL22:
   lac c
   sad d9
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL25
   jms tabulate
   dac .temp1
LL25:
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL28
   jmp out
LL28:
   jms suck
   dac c
   jmp LL10
LL19:
LL17:
   lac c
   dac isspace.c
   jms isspace
   sna
   jmp LL31
   lac readline.doingword
   sna
   jmp LL33
   jms bumpword
   dac .temp1
   lac c
   sad d9
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL35
   jms tabulate
   dac .temp1
   jmp LL36
LL35:
   lac assylen
   sna
   jmp LL38
   lac d32
   dac .temp1
   lac assyline
   tad assylen
   dac .ptr
   lac .temp1
   dac .ptr i
   isz assylen
   nop
LL38:
LL36:
   dzm readline.doingword
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL40
   jmp LL11
LL40:
LL33:
LL31:
   lac c
   dac isspace.c
   jms isspace
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL43
   lac readline.doingword
   sna
   jmp LL46
   lac o_ul
   sna
   jmp LL48
   lac UNDERL
   lmq
   lac c
   omq
   dac holdp i
   jmp LL49
LL48:
   lac c
   dac holdp i
LL49:
   isz holdp
   nop
   jmp readline1
LL46:
   lac readline.startline
   sna
   jmp LL50
   lac c
   sad o_cc
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL52
   lac d1
   dac isrequest
   jms readreq
   jmp readline i
LL52:
LL50:
   lac d1
   dac readline.doingword
   lac holdword
   dac holdp
   lac o_ul
   sna
   jmp LL55
   lac UNDERL
   lmq
   lac c
   omq
   dac holdp i
   jmp LL56
LL55:
   lac c
   dac holdp i
LL56:
   isz holdp
   nop
LL43:
readline1:
   dzm readline.startline
   jms suck
   dac c
   jmp LL10
LL11:
out:
   lac o_ul
   sna
   jmp LL57
   -1 ; tad o_ul 
   dac o_ul 
LL57:
   lac c
   sad d4
   jmp 1f
   lac .d1
   jmp 2f
1: cla
2:
   sna
   jmp LL59
   lac d1
   jmp readline i
   jmp LL60
LL59:
   lac d0
   jmp readline i
LL60:
   jmp readline i
bumpword: 0
   dzm holdp i
   lac holdword
   dac strlen.s
   jms strlen
   dac .temp1
   lac assylen
   tad .temp1
   dac .temp1
   lac o_ll
   cma
   tad o_in
   tad .temp1
   cma
   sma
   cla
   sna
   jmp LL61
   lac o_ad
   dac writeline.adflag
   dzm writeline.flushflag
   jms writeline
   dac .temp1
LL61:
   lac assyline
   tad assylen
   dac bumpword.x
   dac strcpy.dst
   lac holdword
   dac strcpy.src
   jms strcpy
   dac .temp1
   lac holdword
   dac strlen.s
   jms strlen
   dac .temp2
   lac assylen
   tad .temp2
   dac assylen
   lac holdword
   dac holdp
   jmp bumpword i
tabulate: 0
   dzm tabulate.j
LL63:
   lac tabulate.j
   cma
   tad n_ta
   cma
   sma
   cla
   sna
   jmp LL64
   lac o_ta
   tad tabulate.j
   dac .ptr
   lac .ptr i
   cma
   tad d1
   cma
   dac .temp1
   lac assylen
   tad o_in
   cma
   tad .temp1
   cma
   sma
   cla
   sna
   jmp LL65
LL67:
   lac assylen
   tad o_in
   dac .temp1
   lac o_ta
   tad tabulate.j
   dac .ptr
   lac .ptr i
   cma
   tad d1
   cma
   dac .temp2
   lac .temp1
   cma
   tad .temp2
   cma
   sma
   cla
   sna
   jmp LL68
   lac o_tc
   dac .temp2
   lac assyline
   tad assylen
   dac .ptr
   lac .temp2
   dac .ptr i
   isz assylen
   nop
   jmp LL67
LL68:
   jmp tabulate i
LL65:
   isz tabulate.j
   nop
   jmp LL63
LL64:
   lac o_tc
   dac .temp1
   lac assyline
   tad assylen
   dac .ptr
   lac .temp1
   dac .ptr i
   isz assylen
   nop
   jmp tabulate i
readreq: 0
   jms skipsp
   sna
   jmp LL69
   jmp readend
LL69:
   jms suck
   dac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL71
   jmp readend
LL71:
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL74
   jmp readend
LL74:
   lac c
   sad d46
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL77
LL80:
   lac d1
   sna
   jmp LL81
   jms suck
   dac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL82
   jmp LL81
LL82:
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL85
   jmp LL81
LL85:
   jmp LL80
LL81:
   jmp readend
LL77:
   lac c
   lls 9
   dac readreq.r
   jms suck
   dac c
   sad d4
   jmp 1f
   lac .d1
   jmp 2f
1: cla
2:
   sna
   jmp LL88
   lac c
   sad d10
   jmp 1f
   lac .d1
   jmp 2f
1: cla
2:
   sna
   jmp LL90
   lac c
   lmq
   lac readreq.r
   omq
   dac readreq.r
LL90:
LL88:
   lac readreq.r
   sad d56936
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL92
   lac ohead
   dac tread.s
   jms tread
   dac c
LL92:
   lac readreq.r
   sad d58992
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL95
   jms nread
   dac o_sp
   jms writebreak
   dac .temp1
LL95:
   lac readreq.r
   sad d59489
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL98
   jms do_ta
   dac .temp1
LL98:
   lac readreq.r
   sad d60012
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL101
   jms nread
   dac o_ul
LL101:
LL104:
   lac d1
   sna
   jmp LL105
   lac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL106
   jmp LL105
LL106:
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL109
   jmp LL105
LL109:
   jms suck
   dac c
   jmp LL104
LL105:
readend:
   lac c
   sad d4
   jmp 1f
   lac .d1
   jmp 2f
1: cla
2:
   sna
   jmp LL112
   lac d1
   jmp readreq i
   jmp LL113
LL112:
   lac d0
   jmp readreq i
LL113:
   jmp readreq i
tread: 0
   dzm tread.leadbl
LL114:
   lac d1
   sna
   jmp LL115
   jms suck
   dac c
   sad d32
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL116
   lac tread.leadbl
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL119
   jmp LL114
LL119:
LL116:
   lac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL122
   dzm tread.s i
   lac c
   jmp tread i
LL122:
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL125
   dzm tread.s i
   lac c
   jmp tread i
LL125:
   lac c
   dac tread.s i
   isz tread.s
   nop
   isz tread.leadbl
   nop
   jmp LL114
LL115:
   jmp tread i
nread: 0
   dzm nread.i
   dzm nread.f
   jms skipsp
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL128
LL131:
   lac d1
   sna
   jmp LL132
   jms suck
   dac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL133
   jmp LL132
LL133:
   lac c
   dac isspace.c
   jms isspace
   sna
   jmp LL136
   jmp LL132
LL136:
   lac c
   dac isdigit.c
   jms isdigit
   sna
   jmp LL138
   isz nread.f
   nop
   lac d10
   dac .+4
   lac nread.i
   cll; mul; ..; lacq
   tad c
   cma
   tad d48
   cma
   dac nread.i
   jmp LL139
LL138:
   jmp LL132
LL139:
   jmp LL131
LL132:
LL128:
   lac nread.f
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL140
   lac d1
   dac nread.i
LL140:
   lac nread.i
   jmp nread i
do_ta: 0
   dzm n_ta
LL143:
   lac d1
   sna
   jmp LL144
   lac do_ta.v
   dac nread.i
   jms nread
   dac do_ta.v
   sad d1
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL145
   jmp do_ta i
   jmp LL146
LL145:
   lac do_ta.v
   dac .temp1
   lac o_ta
   tad n_ta
   dac .ptr
   lac .temp1
   dac .ptr i
   isz n_ta
   nop
LL146:
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL148
   jmp LL144
LL148:
   lac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL151
   jmp LL144
LL151:
   jmp LL143
LL144:
   jmp do_ta i
skipsp: 0
LL154:
   lac d1
   sna
   jmp LL155
   jms suck
   dac c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL156
   lac d1
   jmp skipsp i
LL156:
   lac c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL159
   lac d1
   jmp skipsp i
LL159:
   lac c
   sad d32
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL162
   jmp LL154
LL162:
   lac c
   sad d9
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL165
   jmp LL154
LL165:
   lac c
   dac cachec
   lac d0
   jmp skipsp i
   jmp LL154
LL155:
   jmp skipsp i
writebreak: 0
   lac assylen
   sna
   jmp LL168
   dzm writeline.adflag
   lac d1
   dac writeline.flushflag
   jms writeline
   dac .temp1
LL168:
   lac TXTLEN
   dac writebreak.q
   lac o_sp
   sna
   jmp LL170
   lac o_sp
   tad line_no
   dac .temp1
   lac writebreak.q
   cma
   tad .temp1
   cma
   sma
   cla
   sna
   jmp LL172
   jms newpage
   dac .temp1
   jmp LL173
LL172:
   lac line_no
   sna
   jmp LL174
LL176:
   lac o_sp
   sna
   jmp LL177
   jms blankline
   dac .temp1
   -1 ; tad o_sp 
   dac o_sp 
   jmp LL176
LL177:
LL174:
LL173:
LL170:
   jmp writebreak i
blankline: 0
   lac line_no
   cma
   tad TXTLEN
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL178
   jms newpage
   dac .temp1
LL178:
   lac d10
   dac spit.c
   jms spit
   dac .temp2
   isz line_no
   nop
   jmp blankline i
writeline: 0
   lac assylen
   cma
   tad d1
   cma
   dac writeline.j
LL180:
   lac writeline.j
   sna
   jmp LL181
   lac assyline
   tad writeline.j
   dac .ptr
   lac .ptr i
   sad d32
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL182
   -1 ; tad assylen 
   dac assylen 
   jmp LL183
LL182:
   jmp LL181
LL183:
   -1 ; tad writeline.j 
   dac writeline.j 
   jmp LL180
LL181:
   lac TXTLEN
   dac writeline.q
   lac line_no
   cma
   tad writeline.q
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL185
   jms newpage
   dac .temp1
LL185:
   dzm writeline.j
LL187:
   lac writeline.j
   cma
   tad assylen
   cma
   sma
   cla
   sna
   jmp LL188
   lac assyline
   tad writeline.j
   dac .ptr
   lac .ptr i
   dac spit.c
   jms spit
   dac .temp1
   isz writeline.j
   nop
   jmp LL187
LL188:
   lac d10
   dac spit.c
   jms spit
   dac .temp2
   dzm assylen
   dzm .temp1
   lac assyline
   dac .ptr
   lac .temp1
   dac .ptr i
   isz line_no
   nop
   lac writeline.flushflag
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL189
   lac assyline
   dac strcpy.dst
   lac holdword
   dac strcpy.src
   jms strcpy
   dac .temp1
   lac holdword
   dac strlen.s
   jms strlen
   dac assylen
   dzm holdword i
   lac holdword
   dac holdp
LL189:
   jmp writeline i
newpage: 0
   lac page_no
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL192
   jms endpage
   dac .temp1
   jmp LL193
LL192:
   lac d1
   dac page_no
LL193:
   jms beginpage
   dac .temp1
   jmp newpage i
beginpage: 0
   dzm beginpage.i
LL194:
   lac beginpage.i
   cma
   tad o_m1
   cma
   sma
   cla
   sna
   jmp LL195
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   isz beginpage.i
   nop
   jmp LL194
LL195:
   lac ohead
   dac writetitle.t
   jms writetitle
   dac .temp2
   dzm beginpage.i
LL196:
   lac beginpage.i
   cma
   tad o_m2
   cma
   sma
   cla
   sna
   jmp LL197
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   isz beginpage.i
   nop
   jmp LL196
LL197:
   dzm line_no
   jmp beginpage i
endpage: 0
   lac line_no
   dac endpage.i
LL198:
   lac endpage.i
   cma
   tad TXTLEN
   cma
   sma
   cla
   sna
   jmp LL199
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   isz line_no
   nop
   isz endpage.i
   nop
   jmp LL198
LL199:
   dzm endpage.i
LL200:
   lac endpage.i
   cma
   tad o_m3
   cma
   sma
   cla
   sna
   jmp LL201
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   isz endpage.i
   nop
   jmp LL200
LL201:
   lac ofoot
   dac writetitle.t
   jms writetitle
   dac .temp2
   dzm endpage.i
LL202:
   lac endpage.i
   cma
   tad o_m4
   cma
   sma
   cla
   sna
   jmp LL203
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   isz endpage.i
   nop
   jmp LL202
LL203:
   isz page_no
   nop
   jmp endpage i
writetitle: 0
   lac writetitle.t i
   dac writetitle.d
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL204
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   jmp writetitle i
LL204:
   jms pgform
   dac writetitle.pst
   dac strlen.s
   jms strlen
   dac writetitle.pstlen
   isz writetitle.t
   nop
   lac writetitle.t
   dac titlen.t
   lac writetitle.d
   dac titlen.c
   lac writetitle.pstlen
   dac titlen.k
   jms titlen
   dac writetitle.l
LL207:
   lac d1
   sna
   jmp LL208
   lac writetitle.t i
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL209
   jmp LL208
LL209:
   lac writetitle.t i
   sad writetitle.d
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL212
   jmp LL208
LL212:
   lac writetitle.t i
   sad d37
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL215
   lac writetitle.pst
   dac spits.s
   jms spits
   dac .temp1
   jmp LL216
LL215:
   lac writetitle.t i
   dac spit.c
   jms spit
   dac .temp2
LL216:
   isz writetitle.t
   nop
   jmp LL207
LL208:
   lac writetitle.t i
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL218
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   jmp writetitle i
LL218:
   isz writetitle.t
   nop
   lac writetitle.t
   dac titlen.t
   lac writetitle.d
   dac titlen.c
   lac writetitle.pstlen
   dac titlen.k
   jms titlen
   dac writetitle.m
   lac writetitle.l
   dac writetitle.j
LL221:
   lac o_ll
   cma
   tad writetitle.m
   cma
   dac .temp1
   lac d2
   dac .+4
   lac .temp1
   cll; idiv; ..; lacq
   dac .temp1
   lac writetitle.j
   cma
   tad .temp1
   cma
   sma
   cla
   sna
   jmp LL222
   lac d32
   dac spit.c
   jms spit
   dac .temp1
   isz writetitle.j
   nop
   jmp LL221
LL222:
LL223:
   lac d1
   sna
   jmp LL224
   lac writetitle.t i
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL225
   jmp LL224
LL225:
   lac writetitle.t i
   sad writetitle.d
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL228
   jmp LL224
LL228:
   lac writetitle.t i
   sad d37
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL231
   lac writetitle.pst
   dac spits.s
   jms spits
   dac .temp1
   jmp LL232
LL231:
   lac writetitle.t i
   dac spit.c
   jms spit
   dac .temp2
LL232:
   isz writetitle.t
   nop
   jmp LL223
LL224:
   lac writetitle.t i
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL234
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   jmp writetitle i
LL234:
   lac o_ll
   cma
   tad writetitle.m
   cma
   dac .temp2
   lac d2
   dac .+4
   lac .temp2
   cll; idiv; ..; lacq
   dac .temp2
   lac writetitle.l
   cma
   tad .temp2
   cma
   sma
   cla
   sna
   jmp LL237
   lac o_ll
   cma
   tad writetitle.m
   cma
   dac .temp1
   lac d2
   dac .+4
   lac .temp1
   cll; idiv; ..; lacq
   dac .temp1
   lac writetitle.m
   tad .temp1
   dac writetitle.m
   jmp LL238
LL237:
   lac writetitle.m
   tad writetitle.l
   dac writetitle.m
LL238:
   isz writetitle.t
   nop
   lac writetitle.t
   dac titlen.t
   lac writetitle.d
   dac titlen.c
   lac writetitle.pstlen
   dac titlen.k
   jms titlen
   dac writetitle.n
   lac writetitle.m
   dac writetitle.j
LL239:
   lac o_ll
   cma
   tad writetitle.n
   cma
   dac .temp1
   lac writetitle.j
   cma
   tad .temp1
   cma
   sma
   cla
   sna
   jmp LL240
   lac d32
   dac spit.c
   jms spit
   dac .temp1
   isz writetitle.j
   nop
   jmp LL239
LL240:
LL241:
   lac d1
   sna
   jmp LL242
   lac writetitle.t i
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL243
   jmp LL242
LL243:
   lac writetitle.t i
   sad writetitle.d
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL246
   jmp LL242
LL246:
   lac writetitle.t i
   sad d37
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL249
   lac writetitle.pst
   dac spits.s
   jms spits
   dac .temp1
   jmp LL250
LL249:
   lac writetitle.t i
   dac spit.c
   jms spit
   dac .temp2
LL250:
   isz writetitle.t
   nop
   jmp LL241
LL242:
   lac d10
   dac spit.c
   jms spit
   dac .temp1
   jmp writetitle i
pgform: 0
   lac page_no
   dac itoa.n
   jms itoa
   dac pgform.pst
   jmp pgform i
titlen: 0
   dzm titlen.q
LL252:
   lac d1
   sna
   jmp LL253
   lac titlen.t i
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL254
   jmp LL253
LL254:
   lac titlen.t i
   sad titlen.c
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL257
   jmp LL253
LL257:
   lac titlen.t i
   sad d37
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL260
   lac titlen.q
   tad titlen.k
   dac titlen.q
   jmp LL261
LL260:
   isz titlen.q
   nop
LL261:
   isz titlen.t
   nop
   jmp LL252
LL253:
   lac titlen.q
   jmp titlen i
spits: 0
LL263:
   lac spits.s i
   sna
   jmp LL264
   lac spits.s i
   dac spit.c
   jms spit
   dac .temp1
   isz spits.s
   nop
   jmp LL263
LL264:
   jmp spits i
spit: 0
   lac spit.c
   and UNDERL
   dac spit.ulflag
   lac UNDERL
   xor m1
   dac .temp1
   lac spit.c
   and .temp1
   dac spit.c
   sad d32
   jmp 1f
   lac .d1
   jmp 2f
1: cla
2:
   sna
   jmp LL265
   lac spit.c
   sad d10
   jmp 1f
   lac .d1
   jmp 2f
1: cla
2:
   sna
   jmp LL267
   lac n_blanks
   sna
   jmp LL269
LL271:
   lac n_blanks
   sna
   jmp LL272
   lac d32
   dac putchar.c
   jms putchar
   dac .temp1
   isz col_no
   nop
   -1 ; tad n_blanks 
   dac n_blanks 
   jmp LL271
LL272:
LL269:
LL267:
LL265:
   lac spit.ulflag
   sna
   jmp LL273
   lac spit.c
   dac isalnum.c
   jms isalnum
   sna
   jmp LL275
   lac d95
   dac putchar.c
   jms putchar
   dac .temp1
   lac d8
   dac putchar.c
   jms putchar
   dac .temp2
LL275:
LL273:
   lac spit.c
   sad d32
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL277
   isz n_blanks
   nop
   jmp LL278
LL277:
   lac spit.c
   dac putchar.c
   jms putchar
   dac .temp1
   isz col_no
   nop
LL278:
   lac spit.c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL280
   dzm col_no
   dzm n_blanks
LL280:
   jmp spit i
suck: 0
LL283:
   lac d1
   sna
   jmp LL284
   lac cachec
   dac c
   dzm cachec
   lac c
   sad d0
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL285
   jms getchar
   dac c
LL285:
   lac c
   dac islegal.c
   jms islegal
   sna
   jmp LL288
   lac c
   jmp suck i
LL288:
   jmp LL283
LL284:
   jmp suck i
isspace: 0
   lac isspace.c
   sad d32
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL290
   lac d1
   jmp isspace i
LL290:
   lac isspace.c
   sad d9
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL293
   lac d1
   jmp isspace i
LL293:
   lac isspace.c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL296
   lac d1
   jmp isspace i
LL296:
   lac d0
   jmp isspace i
isalnum: 0
   lac isalnum.c
   cma
   tad d65
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL299
   lac d90
   cma
   tad isalnum.c
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL301
   lac d1
   jmp isalnum i
LL301:
LL299:
   lac isalnum.c
   cma
   tad d97
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL303
   lac d122
   cma
   tad isalnum.c
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL305
   lac d1
   jmp isalnum i
LL305:
LL303:
   lac isalnum.c
   cma
   tad d48
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL307
   lac d57
   cma
   tad isalnum.c
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL309
   lac d1
   jmp isalnum i
LL309:
LL307:
   lac d0
   jmp isalnum i
isdigit: 0
   lac isdigit.c
   cma
   tad d48
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL311
   lac d57
   cma
   tad isdigit.c
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL313
   lac d1
   jmp isdigit i
LL313:
LL311:
   lac d0
   jmp isdigit i
islegal: 0
   lac islegal.c
   cma
   tad d32
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL315
   lac d126
   cma
   tad islegal.c
   cma
   spa
   jmp 1f
   lac .d1
   jmp 2f
   cla
1: cla
2:
   sna
   jmp LL317
   lac d1
   jmp islegal i
LL317:
LL315:
   lac islegal.c
   sad d32
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL319
   lac d1
   jmp islegal i
LL319:
   lac islegal.c
   sad d9
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL322
   lac d1
   jmp islegal i
LL322:
   lac islegal.c
   sad d10
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL325
   lac d1
   jmp islegal i
LL325:
   lac islegal.c
   sad d4
   jmp 1f
   cla
   jmp 2f
1: lac .d1
2:
   sna
   jmp LL328
   lac d1
   jmp islegal i
LL328:
   lac d0
   jmp islegal i
itoa: 0
   lac tempbuf
   tad d9
   dac itoa.digitptr
   dzm itoa.digitptr i
   -1 ; tad itoa.digitptr 
   dac itoa.digitptr 
LL331:
   lac d0
   cma
   tad itoa.n
   cma
   sma
   cla
   sna
   jmp LL332
   lac d10
   dac .+4
   lac itoa.n
   cll; idiv; ..
   tad d48
   dac itoa.digitptr i
   -1 ; tad itoa.digitptr 
   dac itoa.digitptr 
   lac d10
   dac .+4
   lac itoa.n
   cll; idiv; ..; lacq
   dac itoa.n
   jmp LL331
LL332:
   lac itoa.digitptr
   tad d1
   jmp itoa i
strcpy: 0
LL333:
   lac strcpy.src i
   sna
   jmp LL334
   lac strcpy.src i
   dac strcpy.dst i
   isz strcpy.dst
   nop
   isz strcpy.src
   nop
   jmp LL333
LL334:
   dzm strcpy.dst i
   jmp strcpy i
strlen: 0
   dzm strlen.n
LL335:
   lac strlen.s i
   sna
   jmp LL336
   isz strlen.s
   nop
   isz strlen.n
   nop
   jmp LL335
LL336:
   lac strlen.n
   jmp strlen i
.temp1:
   0
.temp2:
   0
.temp3:
   0
.temp4:
   0
.temp5:
   0
.temp6:
   0
.temp7:
   0
.temp8:
   0
.temp9:
   0
.temp10:
   0
.temp11:
   0
.temp12:
   0
.temp13:
   0
.temp14:
   0
.temp15:
   0
.temp16:
   0
.temp17:
   0
.temp18:
   0
.temp19:
   0
.temp20:
   0
.ptr:
   0
UNDERL:
   128
tempbuf: tempbuf.base
tempbuf.base:
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
sflag:
   0
hflag:
   0
holdword: holdword.base
holdword.base:
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
holdp:
   0
assyline: assyline.base
assyline.base:
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
assylen:
   0
ohead: ohead.base
ohead.base:
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
ofoot: ofoot.base
ofoot.base:
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
depth:
   0
adjtoggle:
   0
isrequest:
   0
o_cc:
   46
o_tc:
   32
o_in:
   0
o_ta: o_ta.base
o_ta.base:
   9
   17
   25
   33
   41
   49
   57
   65
   73
   81
   89
   97
   105
   113
   121
   129
   137
   145
   153
   161
n_ta:
   20
o_ll:
   65
o_ad:
   1
o_pl:
   66
o_sp:
   0
o_m1:
   2
o_m2:
   2
o_m3:
   1
o_m4:
   3
o_ul:
   0
page_no:
   -1
line_no:
   9999
n_outwords:
   0
TXTLEN:
   0
c:
   0
cachec:
   0
col_no:
   0
n_blanks:
   0
d90: 90
d0: 0
d8: 8
d95: 95
d60012: 60012
d10: 10
d57: 57
d58992: 58992
d32: 32
d48: 48
d37: 37
d56936: 56936
d65: 65
d1: 1
m1: -1
d97: 97
d46: 46
d2: 2
d122: 122
d126: 126
d59489: 59489
d4: 4
d9: 9
itoa.n: 0
itoa.digitptr: 0
writebreak.q: 0
spits.s: 0
do_ta.v: 0
tabulate.j: 0
titlen.q: 0
titlen.k: 0
titlen.t: 0
titlen.c: 0
bumpword.x: 0
isspace.c: 0
readreq.r: 0
beginpage.i: 0
writetitle.m: 0
writetitle.t: 0
writetitle.pstlen: 0
writetitle.n: 0
writetitle.d: 0
writetitle.l: 0
writetitle.j: 0
writetitle.pst: 0
isalnum.c: 0
spit.t: 0
spit.c: 0
spit.ulflag: 0
strcpy.src: 0
strcpy.dst: 0
islegal.c: 0
isdigit.c: 0
nread.i: 0
nread.f: 0
readline.doingword: 0
readline.startline: 0
endpage.i: 0
strlen.s: 0
strlen.n: 0
writeline.adflag: 0
writeline.q: 0
writeline.flushflag: 0
writeline.j: 0
pgform.pst: 0
tread.s: 0
tread.leadbl: 0
