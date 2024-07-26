void rndrtrak(char[][] tr, int tidx, float x, float y) {
  float xx, yy=y+20;
  float gy=24, gx=32;
  float z1=12, z2=8;
  stroke(dg);
  line(x+4, yy+2, x+gx*tr[0].length-z1, yy+2);
  noStroke();
  fill(gr);
  text("I_"+tidx, x+8, yy);
  yy+=gy;
  for (int i=0; i<tr.length; i++) { // for each step
    xx=x+6;
    noStroke();
    fill(i<steps[tidx]?tb:db);
    for (int j=0; j<tr[i].length; j++) { // for each param
      text(tr[i][j], xx, yy);
      xx+=gx;
    }
    // highlight current step
    if (i==pc[tidx]) {
      noFill();
      stroke(tidx==curtrk?gr:dg);
      rect(x+0, yy-gy+5, gx*tr[i].length-z2, gy-2);
      stroke(og);
      rect(x+0+gx*ec[tidx], yy-gy+5, gx-z2, gy-2);
    }
    yy+=gy;
  }
}

void rndrtrx(float x, float y) {
  float tx, ty;
  tx=x+3;
  for (int k=0; k<trx.length; k++) {
    ty=y+3;
    rndrtrak(trx[k], k, tx, ty);
    tx+=trkwidth+trkgap;
  }
}

void tbox(String s, float x, float y) {
  noStroke();
  fill(gr);
  text(s, x, y);
}

void tbox(boolean cond, String s, float x, float y) {
  if (cond) {
    tbox(s, x, y);
  }
}
