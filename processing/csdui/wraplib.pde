/////////////// keycode map (fullscreen) ///////////
final int PGUP=33;
final int PGDN=34;
final int E=39;
final int W=37;
final int N=38;
final int S=40;
final int SHF=16;
final int CTL=17;
final int LF=10;

///////////////////// osc funx /////////////////////
void csdsend(int inum, float dur, float p4, float p5, float p6) {
  if (!safemode) {
    OscMessage om = new OscMessage("/processing/csdui");
    om.add(inum);
    om.add(dur);
    om.add(p4);
    om.add(p5);
    om.add(p6);
    op5.send(om, csd);
  }
}

void csdsend(int inum, float dur, float p4, int p5, int p6) {
  if (!safemode) {
    OscMessage om = new OscMessage("/processing/csdui");
    om.add(inum);
    om.add(dur);
    om.add(p4);
    om.add(p5);
    om.add(p6);
    op5.send(om, csd);
  }
}
