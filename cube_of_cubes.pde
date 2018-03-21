
//steeldef  t,x,y,z


public void settings() {
  size(800, 600, P3D);
}

Clip a;

void setup(){
  //strokeWeight(3);
  //stroke(0, 255, 0);
  noStroke();
  
  a = new Clip(100, 100, 10, 10, 3);
  a.edit();
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
  
  void edit(){
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
  a.display(cframe++);
 } 
}

float rotX=0, rotY=0, rotZ=0;
int posX=0, posY=0, posZ=0;
byte rotZb=0;
byte VX,VY,VZ;
void mouseDragged(){
 rotY+=float(mouseX-pmouseX)/100;
 rotX-=float(mouseY-pmouseY)/100;
}

void keyPressed(){
  switch(key){
    case 'q':
      rotZb=1;
      break;
    case 'e':
      rotZb=-1;
      break;
    case 'w':
      VZ=1;
      break;
    case 's':
      VZ=-1;
      break;
    case 'a':
      VX=1;
      break;
    case 'd':
      VX=-1;
      break;
    case 'f':
      VY=1;
      break;
    case 'c':
      VY=-1;
      break;
  }
}

void up(){
  println(scroll);
  
  if(rotZb==1){
    rotZ+=0.01;
  }else if(rotZb==-1){
    rotZ-=0.01;
  }
  
  if(VX==1){
    posX+=1;
  }else if(VX==-1){
    posX-=1;
  }
  
  if(VY==1){
    posY+=1;
  }else if(VY==-1){
    posY-=1;
  }
  
  if(VZ==1){
    posZ+=1;
  }else if(VZ==-1){
    posZ-=1;
  }
}

void keyReleased(){
  switch(key){
    case 'q':
    case 'e':
      rotZb=0;
      break;
    case 'w':
    case 's':
      VZ=0;
      break;
    case 'a':
    case 'd':
      VX=0;
      break;
    case 'f':
    case 'c':
      VY=0;
      break;
  }
}

int scroll=0;
void mouseWheel(MouseEvent e){
  scroll+=e.getCount();
  
}
