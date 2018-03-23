import controlP5.*;
ControlFrame cf;
EditFrame ef;

//steeldef  t,x,y,z


public void settings() {
  size(800, 600, P3D);
}

Clip a;

void setup(){
  //strokeWeight(3);
  //stroke(0, 255, 0);
  cf = new ControlFrame(this, 400, 800, "Controls");
  //ef = new EditFrame(this, 200, 200, "Controls");        //this is mad, cuz it needs a cut clip to create,  don't launch it at boot, only after a spawn button has been pressed;
  noStroke();
  
  a = new Clip(100, 100, 10, 10, 3);
  a.initRainbow();
}

class Clip{
  byte[][][][][] data;
  int fr;
  int dimt, dimx, dimy, dimz;
  
  Clip(int dt, int dx, int dy, int dz, int fr){
    int[] dim = {dt,dx,dy,dz,fr};
    init(dim);
  }
  
  Clip(int[] dim){
    init(dim);
  }
  
  void init(int[] dim){
    data = new byte[dim[0]][dim[1]][dim[2]][dim[3]][4];
    fr = dim[4];
    dimt=dim[0];
    dimx=dim[1];
    dimy=dim[2];
    dimz=dim[3];
  }
  
  void display(int t){
    displayframe(data[t]);
  }
  
  void displayframe(byte data[][][][]){
    pushMatrix();
    for(int i=0; i<dimx; i++){
     translate(10,0,0);
     displaySlice(data[i]);
    }
    popMatrix();
  }
  
  void displaySlice(byte[][][] data){
    pushMatrix();
    for(int i=0; i<dimy; i++){
     translate(0,10,0);
     displayRow(data[i]);
    }
    
    popMatrix();
  }
  
  void displayRow(byte[][] data){
    pushMatrix();
    for(int i=0; i<dimz; i++){
     translate(0,0,10);
     displayPoint(data[i]);
    }
    popMatrix();
    
  }
  
  void displayPoint(byte[] data){
    fill(data[0]+128, data[1]+128, data[2]+128, data[3]+128);
    box(10);
  }
  void initRainbow(){
    for(int i1=0; i1<dimt; i1++){
      for(int i2=0; i2<dimx; i2++){
        for(int i3=0; i3<dimy; i3++){
          for(int i4=0; i4<dimz; i4++){
            
            data[i1][i2][i3][i4][0] = byte((i1*2.5)-128);
            data[i1][i2][i3][i4][1] = byte((i2*2.5)-128);
            data[i1][i2][i3][i4][2] = byte((i3*25)-128);
            data[i1][i2][i3][i4][3] = 100-128;
          }
        }
      }
    } 
  }
  
  void initEmpty(){
    for(int i1=0; i1<dimt; i1++){
      for(int i2=0; i2<dimx; i2++){
        for(int i3=0; i3<dimy; i3++){
          for(int i4=0; i4<dimz; i4++){
            
            data[i1][i2][i3][i4][0] = -128;
            data[i1][i2][i3][i4][1] = -128;
            data[i1][i2][i3][i4][2] = -128;
            data[i1][i2][i3][i4][3] = -128;
          }
        }
      }
    } 
  }
  
  void edit(int t, int x, int y, int z, color c){
    data[t][x][y][z][0] = byte(red(c)-128);
    data[t][x][y][z][1] = byte(green(c)-128);
    data[t][x][y][z][2] = byte(blue(c)-128);
    data[t][x][y][z][3] = byte(alpha(c)-128);
  }
  
  byte[][][] Access2D(byte cut1, byte cut2, int val1, int val2){
    byte[][][] out = new byte[0][0][0];
    if(cut1!=cut2){
      byte in[][][][] = Access3D(cut1, val1);
      
      if(cut2==0){
        out = in[val2];
      }
      else{
        if(cut2==1){
          out = new byte[in.length][in[0][0].length][4];
          for(int i=0; i>in.length;i++){
            out[i] = in[i][val2];
          }
        }
        
        if(cut2==2){
          out = new byte[in.length][in[0].length][4];
          for(int i1=0; i1>in.length;i1++){
            for(int i2=0; i2>in[0].length;i2++){
              out[i1][i2] = in[i1][i2][val2];
            }
          }
        }
      }
    }
    return out;
  }
  
  byte[][][][] Access3D(byte cut, int val){
    byte[][][][] out = new byte[0][0][0][0];
    
    if(cut == 0){
      out = data[val];
    }
    
    if(cut == 1){
      out = new byte[data.length][data[0][0].length][data[0][0][0].length][4];
      for(int i = 0; i<data.length; i++){
        out[i] = data[i][val];
      }
    }
    
    if(cut == 2){
      out = new byte[data.length][data[0].length][data[0][0][0].length][4];
      for(int i1 = 0; i1<data.length; i1++){
        for(int i2 = 0; i2<data[0].length; i2++){
          out[i1][i2] = data[i1][i2][val];
        }
      }
    }
    
    if(cut == 3){
      out = new byte[data.length][data[0].length][data[0][0].length][4];
      for(int i1 = 0; i1<data.length; i1++){
        for(int i2 = 0; i2<data[0].length; i2++){
          for(int i3 = 0; i3<data[0][0].length; i3++){  
            out[i1][i2][i3] = data[i1][i2][i3][val];
          }
        }
      }
    }
    
    
      
    return out;
  }
}

int cframe =0;
int drawCount=0;
void draw(){
up();
 drawCount++;
 if(drawCount>0){
   drawCount = 0;
  
  background(255);
  
  translate(width/2, height/2, 0);
  translate(0,0,scroll);
  rotateZ(rotZ);
  rotateX(rotX);
  rotateY(rotY);
  translate(posX, posY, posZ);
  
  
  translate(-a.dimx*5, -a.dimy*5, -a.dimz*5);
  
  if(cframe==a.dimt)cframe = 0;
  a.display(cframe);
 } 
}
