//////////////// step actions //////////////////
void steptrx() {
  for (int i=0; i<m; i++) {
    if (clk%resns[i]==0) {
      char[] reg=trx[i][pc[i]];
      if (reg[0]!='0' && reg[1]!='0') { // ensure +ve dur and amp
        float dur=map(ab.indexOf(reg[0]), 0, ab.length(), 0f, 1f);
        float p4=map(ab.indexOf(reg[1]), 0, ab.length(), 0f, 1f); // amp
        int p5=32+ab.indexOf(reg[2]);  // midi note 1
        int p6=32+ab.indexOf(reg[3]);  // midi note 2
        csdsend(i, dur, p4, p5, p6);
      }
      pc[i]=(pc[i]+1)%steps[i];
    }
  }
  clk++;
}
