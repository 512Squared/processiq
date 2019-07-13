var gridSize = 128; // number of squares in the grid
var boxSize = 512; // size of the box holding the grid
float startSelectX = 0;
float startSelectY = 0;
float endSelectX = 0;
float endSelectY = 0;
int pageSize = 1000;
float offset = floor((pageSize - boxSize)/2);

// building an array to control selectState

int [] selectState = {0,1,2}; // 0= layer select off, 1= layer select start point, 2= layer select completed
var layerSelect = selectState[0]; // default, layer select is off

// building objects for the layer slots

Slot s1, s2, s3, s4, s5, s6, s7, s8, s9, s10;


void setup() {
    size(pageSize, pageSize);
    frameRate(30);
    s1 = new Slot("1",255,(offset+55),(offset+572),40,40,false);
    s2 = new Slot("2",255,(offset+95),(offset+572),40,40,false);
    s3 = new Slot("3",255,(offset+135),(offset+572),40,40,false);
    s4 = new Slot("4",255,(offset+175),(offset+572),40,40,false);
    s5 = new Slot("5",190,(offset+215),(offset+572),40,40,false);
    s6 = new Slot("6",255,(offset+255),(offset+572),40,40,false);
    s7 = new Slot("7",255,(offset+295),(offset+572),40,40,false);
    s8 = new Slot("8",255,(offset+335),(offset+572),40,40,false);
    s9 = new Slot("9",255,(offset+375),(offset+572),40,40,false);
    s10 = new Slot("10",255,(offset+415),(offset+572),40,40,false);

}

void draw() {
    
    background(100);
    mainGrid();
    
    // function for selecting layers
    layers(); 
    
    // draw layer slots. 
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
    
    // rollover to prompt layer select
    boxOver(); 

}

class Slot {
    String num;
    int c;
    int sX, sY, sW, sH;
    boolean stat;
    
    Slot(String slotnum,int slotcol,int slotx,int sloty,int slotw, int sloth,boolean slotstat) {
        num = slotnum;
        c = slotcol;
        sX = slotx;
        sY = sloty;
        sW = slotw;
        sH = sloth;
        stat = slotstat;        
    }
    void display() {    
        translate(0,0);        
        fill(c);   
        rect(sX,sY,sW,sH);
        textSize(20);
        textAlign(CENTER);
        fill(#575757);
        text(num, sX, (sY + 13), sW, sH);
    }
}
 
void layers() {
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
                println(offset);
                break;
            }
    }
}
void mouseClicked() {
    
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
    if (mouseX < width/2+(offset/2) && mouseX > width/2-(offset/2) && mouseY < (offset/2)) {
        println("Console log.");
        println("left/right offset: " + offset);
        println("sX: " + s1.sX + ". sY: " + s1.sY + ". Status: " + s1.stat + ". sW: " + s1.sW + ". sH: " + s1.sH +  ". C: " + s1.c);
    }
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
    if (mouseX > 223 && mouseX < 263 && mouseY >688 && mouseY < 728) { 
        // fill(190);
        // rect(0, 0, 440, 440);
        println("Layers box click activated");
    }
}
void boxOver() {
    
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
void mainGrid() {
    
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
void slotSelectFormat(){
    line(183, 690, 223, 690);
    stroke(20);
    line(223, 690, 223, 730);
    stroke(255);
    line(223, 730, 183, 730);
}


/* create layer from rectangle
  values for rect need to be stored. 
variable to hold each layer needs to be stored
number of layers? Set number of layers? Button for adding layers?
Button for calling a layer into view
*/