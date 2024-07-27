void kontrol() {
  //////////// keyboard-fu ////////////
  if (ctlmode && !shfmode) {
    // n steps
    int v=ab.indexOf(key);
    if (v!=-1) {
      steps[curtrk]=v>n?n:v;
      stat=String.format("steps[%d]=%d", curtrk, steps[curtrk]);
    }
  } else if (shfmode && !ctlmode) {
    // resolution
    int v=ab.indexOf(key);
    if (v!=-1) {
      resns[curtrk]=v<1?1:v>n?n:v;
      stat=String.format("resns[%d]=%d", curtrk, resns[curtrk]);
    }
  } else if (!ctlmode && !shfmode) {
    // edit if neither in control mode nor in shift mode
    trx[curtrk][pc[curtrk]][ec[curtrk]]=key;
  } else {
    // ctlmode and shfmode //
    if (key==' ') {
      paused=!paused;
      stat="paused: "+paused;
      return;
    }
    if (state==0) {
      tmparg=ab.indexOf(key);
      if (tmparg!=-1) {
        state=1;
        stat="state=1, tmparg="+tmparg;
      }
    } else if (state==1) {
      int arg2=ab.indexOf(key);
      if (arg2!=-1 && tmparg<w) {
        for (int i=0; i<n; i++) {
          trx[curtrk][i][tmparg]=key;
        }
        stat=String.format("T_%d[col:%d]=%c", curtrk, tmparg, key);
      }
      state=0;
      stat="state reset.";
    }
  }
}
