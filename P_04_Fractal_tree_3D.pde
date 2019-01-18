import peasy.*;  //library for smooth camera movement

int ang=20;  //standard angle between brench, and line of parrent brench
int lim=27;  //minimal length of brench
float sc=0.75; //scaling of new brench (new/parrent)
int colD = 4; //mapping colors

//[ < > ] - ANGLE
//[ ^ v ] - DIFFERENCE
//[ <- -> ] - LIMIT
//[ [ ] ] - COLOR MAPPING

PeasyCam cam;

void setup()
{
  fullScreen(P3D);
  //size(800,650,P3D);
  cam=new PeasyCam(this,500);
  background(0);
  colorMode(HSB,100);
  frameRate(20);
}

void draw()
{
  background(0);
  //brench2D(ang,120,100);
  brench3D(ang,120,100);
  write();
}

//recursive functoin generating bracnches of tree
void brench3D(int delta, int len,int col)
{
  if(len > lim)
  {
    float r=radians(delta);
    stroke(col,100,50+len);
    line(0,0,0,0,-len,0);  //drawing a brench
    translate(0,-len,0);  //moving "cursor" to end of drawn brench
    //calling functoins for children brenches, all rotatd by some angles 
    rotateZ(r);
    brench3D(delta,int(len*sc),col-colD);
    rotateZ(-2*r);
    brench3D(delta,int(len*sc),col-colD);
    rotateZ(r);
    
    rotateX(r);
    brench3D(delta,int(len*sc),col-colD);
    rotateX(-2*r);
    brench3D(delta,int(len*sc),col-colD);
    rotateX(r);
    
    //changing angle for diagonal brenches *cos(45)
    //so they have same angle to parrent as orthogonal ones
    r*=sqrt(2)/2;
    
    rotateX(r);
    rotateZ(r);
    brench3D(delta,int(len*sc),col-colD);
    rotateZ(-r);
    rotateX(-r);
    rotateX(-r);
    rotateZ(-r);
    brench3D(delta,int(len*sc),col-colD);
    rotateZ(r);
    rotateX(r);
    
    rotateX(-r);
    rotateZ(r);
    brench3D(delta,int(len*sc),col-colD);
    rotateZ(-r);
    rotateX(r);
    rotateX(r);
    rotateZ(-r);
    brench3D(delta,int(len*sc),col-colD);
    rotateZ(r);
    rotateX(-r);
    
    //return to earlier positon, so siblings can be drawn properly
    translate(0,len,0);
  }
}


//alternative function for 2D trees, works exactly the same
void brench2D(int delta, int len,int col)
{
  if(len > lim)
  {
    float r=radians(delta);
    stroke(col,100,120-col);
    line(0,0,0,-len);
    translate(0,-len);
    rotate(r);
    brench2D(delta,int(len*sc),col-colD);
    rotate(-2*r);
    brench2D(delta,int(len*sc),col-colD);
    rotate(r);
    translate(0,len);
  }
}

void keyPressed()
{
  //println(keyCode);
  switch(keyCode)
  {
    case 38: sc+=0.01; break;
    case 40: sc-=0.01; break;
    case 37: lim+=1; break;
    case 39: if(lim>1) lim-=1; break;
    case 44: ang-=1; break;
    case 46: ang+=1; break;
    case 91: colD-=1; break;
    case 93: colD+=1; break;
    case 32: saveFrame("pic.jpg"); break;
  }
  println("DIFF: " + sc + " | LIMIT: " + lim + " | ANGLE: " + ang + "| COL_DIF: " + colD);
}

void write()
{
  //fill(255);
  //stroke(255);
  textSize(10);
  String txt= "ANGLE = " + ang;
  txt+= "\nLIMIT = " + lim;
  txt+= "\nDIFFERENCE = " + sc;
  text(txt,0,0);
}
