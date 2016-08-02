class Cell{
  float x, y, w, h;
  int col;

  int state;
  Cell(float _x, float _y, float _w, float _h, color _col){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    col = _col;
    state = 0;
    col = int(random(colors.length));
    
  }

  void update(){
  
  }

  void display(){
    noStroke();
    if(state == 1){
      fill(colors[col]);
      rect(x, y, w, h);
    }else{
      noFill();
    }
  }

  void setColor(color _col){
    col = _col;
  }

  void setState(int _state){
     state = _state; 
  }
  
  int getState(){
    return state; 
  }
}
