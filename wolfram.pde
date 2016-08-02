Grid grid;

boolean light = true;
boolean recording = false;
color bg;
color[] colors;


int number = 9;



void setup(){
  size(1920, 1080);
  colors = new color[8];
  if(light){
    bg = #F4ECCE;
    colors[0] = #93BBBF;
    colors[1] = #16786D;
    colors[2] = #8C1832;
    colors[3] = #D9BFA3;
    colors[4] = #C02F2F;
    colors[5] = #DA8B49;
    colors[6] = #AD2425;
    colors[7] = #193059;
  }else{
    bg = #193059;
    colors[0] = #F4ECCE;
    colors[1] = #16786D;
    colors[2] = #8C1832;
    colors[3] = #D9BFA3;
    colors[4] = #C02F2F;
    colors[5] = #DA8B49;
    colors[6] = #AD2425;
    colors[7] = #93BBBF;
  }
  grid = new Grid((32)*2, (18)*2, 8);
  background(bg);
}

void draw(){
  if(frameCount % 10 == 0){
    background(bg);
    grid.update();
    grid.display();
    if(recording){
      if(light){
        saveFrame("hires/light/" + number + "/####.png");
      }
      else{
        saveFrame("hires/dark/" + number + "/####.png");
      }
    }
  }
}

void mouseClicked(){
  setup(); 
}
