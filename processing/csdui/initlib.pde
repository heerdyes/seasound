void initnw() {
  if (!safemode) {
    // n/w
    op5 = new OscP5(this, 12000);
    csd = new NetAddress("127.0.0.1", 7770);
  }
}

void initguivars() {
  marginw=36f;
  margint=20f;
  trkgap=22f;
  float totgap=(m-1)*trkgap;
  trkwidth=(width-2*marginw-totgap)/m;
  tmpkc=0;
}

void initcounters() {
  // machinery initialization
  pc=new int[m];      // 1 vm per trak
  ec=new int[m];      // 1 curparam per trak
  steps=new int[m];   // steps per trak
  resns=new int[m];   // resolution per trak
  for (int i=0; i<m; i++) {
    pc[i]=0;
    ec[i]=0;
    steps[i]=n/4;     // default to max_steps/4
    resns[i]=4;       // set default resolution
  }
  curtrk=0;
}

void inittrx() {
  trx=new char[m][n][w];
  for (int k=0; k<m; k++) { // for each trak
    for (int i=0; i<n; i++) { // for each step
      for (int j=0; j<w; j++) { // for each parameter
        trx[k][i][j]='0';
      }
    }
  }
  initcounters();
}
