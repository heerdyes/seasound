<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>
sr=44100
0dbfs=1
ksmps=32
nchnls=2

gih     OSCinit     7770
        turnon      1

;-------------------- osc listener --------------------;
        instr       1
kamp    init        0
kinst   init        0
kdur    init        0
kp4     init        0
kp5     init        0
kp6     init        0
        nxtmsg:
kk      OSClisten   gih, "/processing/csdui", "iffff", kinst, kdur, kp4, kp5, kp6
kinst   =           kinst + 100
        if (kk==0)  then
        goto        done
        endif
        event       "i", kinst, 0, kdur, kp4, kp5, kp6
        kgoto       nxtmsg
        done:
endin

;----------------- lofi kick drum --------------------;
        instr       100
iamp    =           p4
imhi    =           p5
imlo    =           p6
ifhi    mtof        imhi
iflo    mtof        imlo
iwfn    =           3
k1      line        ifhi, p3, iflo
k2      line        ifhi+22, p3, iflo
a1      oscil       iamp, k1, iwfn
a2      oscil       iamp, k2, iwfn
knv     linen       1, p3/10, p3, p3/10
        outs        a1*knv, a2*knv
        endin

;---------------- bass synth ----------------------;
        instr       101
idur    =           p3
iamp    =           p4
imd1    =           p5
imd2    =           p6
ifrq    mtof        imd1
iwfn    =           3
a1      oscil       iamp, ifrq, iwfn
a2      oscil       iamp, ifrq+5, iwfn
knv     linen       1, idur/10, idur, idur/10
        outs        a1*knv, a2*knv
        endin

;------------ simple flute ------------;
        instr           102
idur    =               p3
iamp    =               p4
imd1    =               p5
imd2    =               p6
iar     =               imd2/128
iatk    =               iar*idur
irel    =               (1-iar)*idur
kjet    =               0.3
ifrq1   mtof            imd1
iatt    =               0.1
idetk   =               0.1
kngain  =               0.15
kvibf   expseg          1.0, idur, 5.11
kvamp   =               0.06
ifn     =               1
asig    wgflute         iamp, ifrq1, kjet, iatt, idetk, kngain, kvibf, kvamp, ifn
knv     linen           1, iatk, idur, irel
aout    =               asig*knv
        outs            aout, aout
        endin

</CsInstruments>
<CsScore>
f 1 0 16384 10 1                  ; hifi sine wave
f 2 0  256  10 1                  ; lofi sine wave
f 3 0  256   7 0 64 1 128 -1 64 0 ; triangle wave

f 0 3600                          ; wait for 1 hour doing nothing
e
</CsScore>
</CsoundSynthesizer>
