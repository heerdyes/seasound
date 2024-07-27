import oscP5.*;
import netP5.*;

boolean safemode=false; // true => disable n/w osc
boolean paused=false;
// n/w osc
OscP5 op5;
NetAddress csd;
//
int T=5;          // tick gap
String ab="0123456789abcdefghijklmnopqrstuvwxyz,./;'[]-=\\` )!@#$%^&*(ABCDEFGHIJKLMNOPQRSTUVWXYZ<>?:\"{}_+|~";
int clk=0;        // clock
// coloring
color tb=color(23, 202, 232);
color db=color(12, 101, 116);
color gr=color(0, 248, 0);
color dg=color(0, 124, 0);
color og=color(248, 124, 0);
// tracks
int m=8;          // number of tracks
int n=32;         // maximum number of steps in sequencer
int w=4;          // number of params
char[][][] trx;   // the tracker
// gui vars
float trkwidth;   // width of a track
float trkgap;     // gap between tracks
float marginw;    // left and right margin
float margint;    // margin top
// machinery
int[] pc;         // 1 program counter per trak
int curtrk=0;     // current track index
int[] ec;         // m parameters being edited at time t
int tmpkc=0;      // temporary keycode
int[] steps;      // steps per trak
int[] resns;      // resolutions per trak
// gui behavior globals
boolean ctlmode=false;
boolean shfmode=false;
String stat="ready";
int state=0;
int tmparg=0;

///////////////////////////////////////////////////////////

void setup() {
  fullScreen();
  textFont(createFont("OCRA", 16));
  initnw();
  inittrx();
  initguivars();
}

void draw() {
  background(0);
  float sx=2, sy=height-24;
  float seplo=height-18, sephi=height-42;
  float rx=width-150-6, ry=height-24;
  stroke(dg);
  line(rx, seplo, rx, sephi);
  rx+=4;
  tbox("keycode="+tmpkc, rx, ry);
  tbox(ctlmode, "[CTRL]", sx, sy);
  sx+=12*6;
  tbox(shfmode, "[SHIFT]", sx, sy);
  sx+=12*7;
  stroke(dg);
  line(sx, seplo, sx, sephi);
  sx+=6;
  tbox(stat, sx, height-24);
  rndrtrx(marginw, margint);
  if (frameCount%T==0 && !paused) {
    steptrx();
  }
}

////////////////////// event handlings ///////////////////////

void oscEvent(OscMessage m) {
  System.out.printf("[osc] addrpattern:%s, typetag:%s\n", m.addrPattern(), m.typetag());
}

void keyPressed() {
  tmpkc=keyCode;
  if (keyCode==SHF) {
    shfmode=!shfmode;
    return;
  }
  if (keyCode==CTL) {
    ctlmode=!ctlmode;
    return;
  }
  if (keyCode==E) {
    ec[curtrk]=(ec[curtrk]+1)%w;
    return;
  }
  if (keyCode==W) {
    ec[curtrk]=ec[curtrk]==0?w-1:ec[curtrk]-1;
    return;
  }
  if (keyCode==N) {
    curtrk=curtrk==0?m-1:curtrk-1;
    return;
  }
  if (keyCode==S) {
    curtrk=(curtrk+1)%m;
    return;
  }
  if (keyCode==LF) {
    clk=0;
    for (int i=0; i<m; i++) {
      pc[i]=0;
    }
    return;
  }
  if (ab.indexOf(key)==-1) {
    println("non-alphabet char");
    return;
  }
  ////////// keyboard fsm and control //////
  kontrol();
}
