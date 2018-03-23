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
