class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);
    
    cp5.addColorWheel("editc" , 20 , 10 , 200 )
        .plugTo(parent)
        //.plugTo(ef)
        .setRGB(color(128,0,255,255));
       
  }

  void draw() {
    background(120);
  }
}

class EditFrame extends PApplet {

  int w, h;
  PApplet parent;

  public EditFrame(PApplet _parent, int _w, int _h, byte[][] canv) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(600, 600);
       
  }
  
  
  color editc= color(100);
  
  void draw() {
    background(editc);
  }
}
