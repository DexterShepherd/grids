class Grid{
  int x, y, wolfram_tick;
  float h, w, padding;

  Cell cells[][];

  Grid(int _x, int _y, float _padding){
    x = _x;
    y = _y;
    padding = _padding;
    w = (width/x) - (padding*2);
    h = (height/y) - (padding*2);

    wolfram_tick = 0;
    cells = new Cell[x][y];

    float xoff = (width/x)/2 - (w/2);
    float yoff = (height/y)/2 - (h/2);

    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        cells[i][j] = new Cell( xoff + (width/x) * i,
                                yoff + (height/y) * j,
                                w, h, 
                                color(230));
      }
    }

    //initWolfram();
    initConway();
  }

  void update(){
    //wave();
    //rand(0.2);
    randFill(0.1);
    int[] r = {1,0,0,1,1,0,1,0};
    //wolfram(r);
    //conway();
    


    wolfram_tick++;
    if(wolfram_tick == x-1){
      noLoop();
      wolfram_tick = 0;
    }
  }

  void display(){
    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        cells[i][j].display();
      }
    }
  }

  void rand(float chance){
    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        if(random(1) < chance){
          cells[i][j].setColor(color(100, 100, 100));
        }else{
          cells[i][j].setColor(color(255, 255, 255));
        }
      }
    }
  }

  void randFill(float chance){
    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        if(random(1) < chance){
          cells[i][j].setState(1);
        }
      }
    }
  }

  void wave(){
    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        cells[i][j].setColor(color(sin(map((i+frameCount)%x, 0, x, 0, TWO_PI))*255));
      }
    }
  }

  void wolfram(int[] rule){    
    int i = wolfram_tick;
    for(int j = 1; j < y-1; j++){
      int[] neighbors = {cells[i][j-1].getState(), cells[i][j].getState(), cells[i][j+1].getState()};
      cells[i+1][j].setState(nextCell( neighbors, rule ));
    }
  }


  int nextCell(int[] n, int[] rule){
    int[][] rules = {{0,0,0}, {0,0,1}, {0,1,0}, {0,1,1}, {1,0,0}, {1,0,1}, {1,1,0}, {1,1,1}};
    for(int i = 0; i < rules.length; i++){
      if(arrayComp(n, rules[i])){
        return rule[i];
      }
    }
    return -1; //this would be an error
  }

  boolean arrayComp(int[] a, int[] b){
    if(a.length == b.length){
      for(int i = 0; i < a.length; i++){
        if(a[i] != b[i]){
          return false; 
        } }
      return true;
    }
    return false;
  }
  


  int[] calcRow(int[] row, int[] rule){ //this doesn't work
    int[] output = new int[x];
    int[][] rules = {{0,0,0}, {0,0,1}, {0,1,0}, {0,1,1}, {1,0,0}, {1,0,1}, {1,1,0}, {1,1,1}};
    for(int i = 1; i < x-1; i++){
      int[] temp = {row[i-1], row[i], row[i+1]};
      println(temp[0] + " : " + temp[1] + " : " + temp[2]);
      for(int j = 0; j < 8; j++){
        if(arrayComp(temp, rules[j])){
          output[i] = rule[j];
        }
      }
    } return output;
  }

  void initWolfram(){
    for(int i = 0; i < y; i++){
      if(random(1) > 0.5){
        cells[0][i].setState(1);
      }else{
        cells[0][i].setState(0);
      }
    }
  }

  void conway(){
    int lastBoard[][];
    int nextBoard[][];
    lastBoard = new int[x][y];
    nextBoard = new int[x][y];

    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        lastBoard[i][j] = cells[i][j].getState();
      }
    }

    for(int i = 1; i < x-1; i++){
      for(int j = 1; j < y-1; j++){
        int[] n = { lastBoard[i-1][j-1], lastBoard[i][j-1], lastBoard[i+1][j-1],
                   lastBoard[i-1][j],                    lastBoard[i+1][j],
                    lastBoard[i-1][j+1], lastBoard[i][j+1],lastBoard[i+1][j+1]};
        
        int s = sum(n);
        if(lastBoard[i][j] == 1){
          if(s < 2 || s > 3){
            nextBoard[i][j] = 0;
          }else{
            nextBoard[i][j] = lastBoard[i][j];
          }
        }else{
          if(s == 3){
            nextBoard[i][j] = 1;
          }else{
            nextBoard[i][j] = lastBoard[i][j];
          }
        }
      }
    }
    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        cells[i][j].setState(nextBoard[i][j]);
      }
    }
  }

  void initConway(){
    for(int i = 0; i < x; i++){
      for(int j = 0; j < y; j++){
        if(random(1) > 0.7){
          cells[i][j].setState(1);
        }
      }
    }
  }

  int sum(int[] a){
    int s = 0;
    for(int i = 0; i < a.length; i++){
      s += a[i];
    }
    return s;
  }
}
