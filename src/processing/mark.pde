/* @pjs preload="save.png,clear.png"; */

var gridSize = 128; // number of squares in the grid
var boxSize = 512; // size of the box holding the grid
float startSelectX = 0; // layer start x co-ordinates
float startSelectY = 0; // layer start y co-ordinates
float endSelectX = 0; // layer end x co-ordinates
float endSelectY = 0; // layer start y co-ordinates
int pageSize = 1080; // size of canvas
float offset = floor((pageSize - boxSize)/2); // centers grid and related elements

// building an array to control selectState

int [] selectState = {0,1,2}; // 0= layer select off, 1= layer select start point, 2= layer select completed
var layerSelect = selectState[0]; // default, layer select is off

Slot s1, s2, s3, s4, s5, s6, s7, s8, s9, s10; // layer save slots

void setup() {
    size(pageSize, pageSize);
    frameRate(30)
    setupControls();
}

void draw() {
    
    background(100);
    mainGrid();
    layers(); 
    drawSlots();
    boxOver(); 
}

class Slot 

{
    // display slots
    String num;
    color sC;
    int sX, sY, sW, sH;
    boolean state;
    
    // store layer values in slots
    int lX,lY,lW,lH;
    boolean lset; 
    
    Slot(String slotnum,color slotcol,int slotx,int sloty,int slotw, int sloth,boolean slotstate,int layerX,int layerY,int layerW,int layerH,boolean layerSet) {
        
        num = slotnum;
        sC = slotcol;
        sX = slotx;
        sY = sloty;
        sW = slotw;
        sH = sloth;
        state = slotstate;
        lX = layerX;
        lY = layerY;
        lW = layerW;
        lH = layerH;
        lset = layerSet;
            
    }

    void gradientRect(int x, int y, int w, int h, color gradC1, color gradC2) {
        beginShape();
        fill(gradC1);
        vertex(x,y);
        vertex(x,y+h);
        fill(gradC2);
        vertex(x+w,y+h);
        vertex(x+w,y);
        endShape();
}
    
    void display() { // display slots

        if (state == true) 
        
        {
            // fill(59,70,84);
            gradC1 = (59,70,84);
            gradC2 = (73,87,105);
            gradientRect(sX,sY,sW,sH,gradC1,gradC2);
            textSize(20);
            textAlign(CENTER);
            fill(#f2f2f2);
            text(num, sX, (sY + 13), sW, sH);
            stroke(150,164,181);
            line(sX+1,sY+39,sX+39,sY+39);
            line(sX+39,sY+1,sX+39,sY+39);
            stroke(27,30,33);
            line(sX+1,sY+1,sX+1,sY+39);
            line(sX+1,sY+1,sX+39,sY+1);
            stroke(96);


        } 
        
        if (state == false) 
        
        {
            fill(sC);   
            rect(sX,sY,sW,sH);
            textSize(20);
            textAlign(CENTER);
            fill(#575757);
            text(num, sX, (sY + 13), sW, sH);
        }

        if (mouseX > sX && mouseX < sX+40 && mouseY > sY && mouseY < sY+40 && state == false) {
        fill(125)
        rect(sX,sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#f2f2f2);
        text(num, sX, (sY + 13), sW, sH);


        
        if (mousePressed == true && state == false)
        
        {
            gradC1 = (59,70,84);
            gradC2 = (73,87,105);
            gradientRect(sX,sY,sW,sH,gradC1,gradC2);
            textSize(20);
            textAlign(CENTER);
            fill(#f2f2f2);
            text(num, sX, (sY + 13), sW, sH);
            stroke(150,164,181);
            line(sX+1,sY+39,sX+39,sY+39);
            line(sX+39,sY+1,sX+39,sY+39);
            stroke(27,30,33);
            line(sX+1,sY+1,sX+1,sY+39);
            line(sX+1,sY+1,sX+39,sY+1);
            stroke(96);
        }
        

        
        
        else {
        }
        
    }
        



    }
    
}

class ControlPanel 

{

    int cX,cY,cW,cH;

    ControlPanel(int controlX, int controlY,int controlW,int controlH) {
        cX = controlX;
        cY = controlY;
        cW = controlW;
        cH = controlH;
    }

    void display()  { // display controlPanel buttons
        translate(0,0);        
        fill(255);   
        rect(cX,cY,cW,cH);
        
    }


}

void setupControls() 

{ // sits in Setup()
    s1 = new Slot("1",255,(offset+55),(offset+572),40,40,true,0,0,0,0,false);
    s2 = new Slot("2",255,(offset+95),(offset+572),40,40,false,0,0,0,0,false);
    s3 = new Slot("3",255,(offset+135),(offset+572),40,40,false,0,0,0,0,false);
    s4 = new Slot("4",255,(offset+175),(offset+572),40,40,false,0,0,0,0,false);
    s5 = new Slot("5",255,(offset+215),(offset+572),40,40,false,0,0,0,0,false);
    s6 = new Slot("6",255,(offset+255),(offset+572),40,40,false,0,0,0,0,false);
    s7 = new Slot("7",255,(offset+295),(offset+572),40,40,false,0,0,0,0,false);
    s8 = new Slot("8",255,(offset+335),(offset+572),40,40,false,0,0,0,0,false);
    s9 = new Slot("9",255,(offset+375),(offset+572),40,40,false,0,0,0,0,false);
    s10 = new Slot("10",255,(offset+415),(offset+572),40,40,false,0,0,0,0,false);
    cSave = new ControlPanel((offset+55),(offset+617),40,40);
    cClear = new ControlPanel((offset+95),(offset+617),40,40);
    
}

void drawSlots()

{ // sits in draw
    s1.display();
    s2.display();
    s3.display();
    s4.display();
    s5.display();
    s6.display();
    s7.display();
    s8.display();
    s9.display();
    s10.display();
    cSave.display();
    cClear.display();
    PImage save = loadImage("save.png");
    image(save,offset+60,offset+623,30,30);
    PImage clear = loadImage("clear.png");
    image(clear,offset+100,offset+623,30,30);


    
}
 
void layers() 

{
 offset = floor((pageSize - boxSize)/2);
    switch (layerSelect) {
        case selectState[0]: // no select
            startSelectX = 0;
            startSelectY = 0;
            break;
        case selectState[1]: // get 1st x,y co-ordinates 
            fill(#ffc899);
            rectMode(Processing.CORNER);
            rect(offset + (floor((startSelectX - offset) / gridSize) * gridSize),offset + (floor((startSelectY - offset) / gridSize) * gridSize),gridSize,gridSize);
            break;
        case selectState[2]: // get 2nd x,y co-ordinates and calculate layer size
            if (startSelectX < endSelectX && startSelectY < endSelectY) { // select box moving SE
                fill(#ffc899, 128);
                rectMode(Processing.CORNER);
                rect((floor((startSelectX - offset) / gridSize) * gridSize) + offset,(floor((startSelectY - offset) / gridSize) * gridSize) + offset,((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize)),((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize)));
                break;
            }
    }
}

void mouseClicked() 

{
    // CHANGE GRID SIZE
    if (mouseY < 64) { 
        if (mouseX < 64) {
            if (gridSize > 1) {
                gridSize = gridSize / 2;
                println("new grid = " + gridSize);
            }
        } else if (mouseX > (width-64)) {
            if (gridSize < boxSize / 2) {
                gridSize = gridSize * 2;
                println("new grid = " + gridSize);
            }
        }
    }
    
    // CONSOLE LOG REPORTING
    if (mouseX < width/2+(offset/2) && mouseX > width/2-(offset/2) && mouseY < (offset/2)) {
        println("Console log.");
        println("left/right offset: " + offset);
        println("sX: " + s1.sX + ". sY: " + s1.sY + ". Status: " + s1.stat + ". sW: " + s1.sW + ". sH: " + s1.sH +  ". C: " + s1.c);
    }

    // SELECT LAYER 
    if (mouseX > offset && mouseX < (offset)+512 && mouseY > offset && mouseY < (offset)+512 ) { 
        offset = floor((pageSize - boxSize)/2);
        switch (layerSelect) {
            case selectState[0]: 
                startSelectX = mouseX;
                startSelectY = mouseY;
                layerSelect = selectState[1];
                println("Mouse click. First (x,y) values captured");
                println("Layers - selection is started; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
            case selectState[1]:
                endSelectX = mouseX;
                endSelectY = mouseY;
                swap = 0;
                println("Mouse click. Second (x,y) values captured");
                if (endSelectX < startSelectX){
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
                    println("X values swapped");
                }
                if (endSelectY < startSelectY){
                    swap = endSelectY;
                    endSelectY = startSelectY;
                    startSelectY = swap;
                    println("Y values swapped");
                }
                layerSelect = selectState[2];
                println("Layers - layer selection is completed");
                println("Layer co-ordinates are startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
            case selectState[2]:
                layerSelect = selectState[0];
                startSelectX = 0;
                endSelectX = 0;
                startSelectY = 0;
                endSelectY = 0; 
                println("Mouse click. Layer select set to off");
                println("Layers - selection switched off; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
        }
    }


    if (mouseX < offset || mouseX > 512+offset || mouseY < offset || mouseY > 512+offset ) {
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0; 
               
    }

    //SLOT SELECTION
    if (mouseX > s1.sX && mouseX < s1.sX+40 && mouseY > s1.sY && mouseY < s1.sY+40){ // slots

        
        fill(190);
        rect(s1.sX,s1.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s1.num, s1.sX, (s1.sY + 13), s1.sW, s1.sH);
        if (s1.state == false) {
                s1.state = true;
                s2.state = false;
                s3.state = false;
                s4.state = false;
                s5.state = false;
                s6.state = false;
                s7.state = false;
                s8.state = false;
                s9.state = false;
                s10.state = false;
        }
        
       
    }
    if (mouseX > s2.sX && mouseX < s2.sX+40 && mouseY > s2.sY && mouseY < s2.sY+40){ // slots
        
        fill(190);
        rect(s2.sX,s2.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s2.num, s2.sX, (s2.sY + 13), s2.sW, s2.sH);
        if (s2.state == false) {
                s1.state = false;
                s2.state = true;
                s3.state = false;
                s4.state = false;
                s5.state = false;
                s6.state = false;
                s7.state = false;
                s8.state = false;
                s9.state = false;
                s10.state = false;
        }
    }    
    if (mouseX > s3.sX && mouseX < s3.sX+40 && mouseY > s3.sY && mouseY < s3.sY+40){ // slots
        
        fill(190);
        rect(s3.sX,s3.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s3.num, s3.sX, (s3.sY + 13), s3.sW, s3.sH);
        if (s3.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = true;
                s4.state = false;
                s5.state = false;
                s6.state = false;
                s7.state = false;
                s8.state = false;
                s9.state = false;
                s10.state = false;
        }
    }    
    if (mouseX > s4.sX && mouseX < s4.sX+40 && mouseY > s4.sY && mouseY < s4.sY+40){ // slots
        
        fill(190);
        rect(s4.sX,s4.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s4.num, s4.sX, (s4.sY + 13), s4.sW, s4.sH);
        if (s4.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = false;
                s4.state = true;
                s5.state = false;
                s6.state = false;
                s7.state = false;
                s8.state = false;
                s9.state = false;
                s10.state = false;
        }
    }
    if (mouseX > s5.sX && mouseX < s5.sX+40 && mouseY > s5.sY && mouseY < s5.sY+40){ // slots
        
        fill(190);
        rect(s5.sX,s5.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s5.num, s5.sX, (s5.sY + 13), s5.sW, s5.sH);
        if (s5.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = false;
                s4.state = false;
                s5.state = true;
                s6.state = false;
                s7.state = false;
                s8.state = false;
                s9.state = false;
                s10.state = false;
        }
    }
    if (mouseX > s6.sX && mouseX < s6.sX+40 && mouseY > s6.sY && mouseY < s6.sY+40){ // slots
        
        fill(190);
        rect(s6.sX,s6.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s6.num, s6.sX, (s6.sY + 13), s6.sW, s6.sH);
        if (s6.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = false;
                s4.state = false;
                s5.state = false;
                s6.state = true;
                s7.state = false;
                s8.state = false;
                s9.state = false;
                s10.state = false;
        }
    }
    if (mouseX > s7.sX && mouseX < s7.sX+40 && mouseY > s7.sY && mouseY < s7.sY+40){ // slots
        
        fill(190);
        rect(s7.sX,s7.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s7.num, s7.sX, (s7.sY + 13), s7.sW, s7.sH);
        if (s7.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = false;
                s4.state = false;
                s5.state = false;
                s6.state = false;
                s7.state = true;
                s8.state = false;
                s9.state = false;
                s10.state = false;
        }
    }
    if (mouseX > s8.sX && mouseX < s8.sX+40 && mouseY > s8.sY && mouseY < s8.sY+40){ // slots
        
        fill(190);
        rect(s8.sX,s8.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s8.num, s8.sX, (s8.sY + 13), s8.sW, s8.sH);
        if (s8.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = false;
                s4.state = false;
                s5.state = false;
                s6.state = false;
                s7.state = false;
                s8.state = true;
                s9.state = false;
                s10.state = false;
        }
    }
    if (mouseX > s9.sX && mouseX < s9.sX+40 && mouseY > s9.sY && mouseY < s9.sY+40){ // slots
        
        fill(190);
        rect(s9.sX,s9.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s9.num, s9.sX, (s9.sY + 13), s9.sW, s9.sH);
        if (s9.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = false;
                s4.state = false;
                s5.state = false;
                s6.state = false;
                s7.state = false;
                s8.state = false;
                s9.state = true;
                s10.state = false;
        }
    }
    if (mouseX > s10.sX && mouseX < s10.sX+40 && mouseY > s10.sY && mouseY < s10.sY+40){ // slots
        
        fill(190);
        rect(s10.sX,s10.sY,40,40);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(s10.num, s10.sX, (s10.sY + 13), s10.sW, s10.sH);
        if (s10.state == false) {
                s1.state = false;
                s2.state = false;
                s3.state = false;
                s4.state = false;
                s5.state = false;
                s6.state = false;
                s7.state = false;
                s8.state = false;
                s9.state = false;
                s10.state = true;
        }
    }  
    

}

void boxOver() 

{
    
    fill(250,150,0);
    rectMode(Processing.CORNER);
    translate(offset,offset);
    if (mouseX > offset && mouseX < 512+offset && mouseY > offset && mouseY < 512+offset ){
        rect((floor((mouseX - offset) / gridSize) * gridSize),(floor((mouseY - offset) / gridSize) * gridSize),gridSize,gridSize);
    }
        c = 140;    
    if (mouseX > 183 && mouseX < 223 && mouseY > 690 && mouseY < 730) { // slot1
    }
    else {
        c = 190;
    }
}

void mainGrid() 

{
    
    fill(255,0,0);
    rect(0,0,64,64);
    fill(0,255,0);
    rect(width-64, 0, 64, 64);
    fill(255);
    rect(width/2-64, 0, 128, 64);
    textSize(32);
    fill(255);
    rect(width/2-64, 0, 128, 64);
    fill(0)
    textAlign(CENTER);
    text((boxSize/gridSize)*(boxSize/gridSize), width/2, 42);
    
    
    // grid
    fill(255);
    rectMode(Processing.CENTER);
    var min = offset;
    var max = (min + boxSize);
    var x = min;
    var y = min;
    stroke(96);
    rect(offset,offset,boxSize,boxSize);
    while (y < max) {
        x = min;
        line(x, y, max, y);
        while (x < max) {
            line(x, y, x, max);
            x += gridSize;
        }
        y += gridSize;
    }
    textSize(24);
    fill(246, 150, 0);
    textAlign(CENTER);
    text("Layers", offset+92, offset+562);
}




/* create layer from rectangle
  values for rect need to be stored. 
variable to hold each layer needs to be stored
number of layers? Set number of layers? Button for adding layers?
Button for calling a layer into view
*/