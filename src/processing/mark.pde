/* @pjs preload="images/save.png,images/clear.png,images/saveHide.png,images/clearOn.png,images/saveShow.png"; */

/* @pjs font="Arial Black.ttf"; */
        

var gridSize = 64; // number of squares in the grid; 64 is 8 x 8
var boxSize = 512; // size of the box holding the grid
float startSelectX = 0; // layer start x co-ordinates
float startSelectY = 0; // layer start y co-ordinates
float endSelectX = 0; // layer end x co-ordinates
float endSelectY = 0; // layer start y co-ordinates
int pageSize = 1080; // size of canvas
float offset = floor((pageSize - boxSize)/2); // centers grid and related elements
boolean readyToSave = false;  // switch for controlling when to pull new layer values

// building an array to control selectState

int [] selectState = {0,1,2}; // 0= layer select off, 1= start point, 2= end point
var layerSelect = selectState[0]; // layerSelect switch controls layer select phases

Slot s1, s2, s3, s4, s5, s6, s7, s8, s9, s10; // slots to save layers

ControlPanel c1,c2; // command buttons: save, clear

PlayControls play; // command buttons: run visualisation - in progress

PImage save = loadImage("images/save.png");
PImage saveHide = loadImage("images/saveHide.png");
PImage saveShow = loadImage("images/saveShow.png");
PImage clearOn = loadImage("images/clearOn.png");
PImage clear = loadImage("images/clear.png"); // hover image


void setup() {
    size(pageSize, pageSize);
    frameRate(30)
    setupControls();
    //colorMode(RGB,255,255,255,100);
    //ps = new ParticleSystem(1,new Vector3D(width/2,height/2,0));
    //8smooth();
}

void draw() {
    
    background(100);
    mainGrid();
    layers(); 
    drawSlots();
    //drawControls();
    boxOver(); 

}

class Slot 

{
    // display slots
    String slotNum;
    color sC;
    int sX, sY, sW, sH;
    boolean layerVisible;
    boolean slotOn;
    
    // store layer values in slots
    int layX,layY,layW,layH;
    boolean layerSet; 
    
    Slot(String slotnum,color slotcol,int slotx,int sloty,int slotw, int sloth,boolean slotlayervisible,boolean slotstate,int layerX,int layerY,int layerW,int layerH,boolean slotLayerSet) 
    
    {
        
        slotNum = slotnum;
        sC = slotcol;
        sX = slotx;
        sY = sloty;
        sW = slotw;
        sH = sloth;
        layerVisible = slotlayervisible;
        slotOn = slotstate;
        layX = layerX;
        layY = layerY;
        layW = layerW;
        layH = layerH;
        layerSet = slotLayerSet;
            
    }

    
    void display() 
    
    { // display slots

        if (slotOn == true) // draw active slot (no data, so class level)
        
        {

            textSize(20);
            textAlign(CENTER);
            fill(#fefefe);
            text(slotNum, sX, (sY + 13), sW, sH);
            
            stroke(150,164,181);
            line(sX+1,sY+39,sX+39,sY+39);
            line(sX+39,sY+1,sX+39,sY+39);

            stroke(120);
            line(sX+2,sY+38,sX+38,sY+38);
            line(sX+38,sY+2,sX+38,sY+38);
            
            stroke(15);
            line(sX+1,sY+1,sX+1,sY+39);
            line(sX+1,sY+1,sX+39,sY+1);
            
            stroke(27,30,33);
            line(sX+2,sY+2,sX+2,sY+38);
            line(sX+2,sY+2,sX+38,sY+2);
            stroke(96);

            if (layerSet == true)

            {
                stroke(96);
                textSize(20);
                textAlign(CENTER);
                fill(#fa38fc); //dark background
                text(slotNum, sX, (sY + 13), sW, sH);
            }            

        } 
        
        if (slotOn == false) // draw inactive slot (no data, so class level)
        
        {
            fill(sC);   
            rect(sX,sY,sW,sH);
            textSize(20);
            textAlign(CENTER);
            fill(#575757);
            text(slotNum, sX, (sY + 12), sW, sH);
        }

        


        if (mouseX > sX && mouseX < sX+40 && mouseY > sY && mouseY < sY+40 && slotOn == false) // slot rollovers
        
        { // draw slot button rollover (no data, so class level)
            fill(255);   
            rect(sX,sY,sW,sH);
            stroke(150,164,181);
            line(sX+1,sY+39,sX+39,sY+39);
            line(sX+39,sY+1,sX+39,sY+39);
            
            stroke(15);
            line(sX+1,sY+1,sX+1,sY+39);
            line(sX+1,sY+1,sX+39,sY+1);
            
            stroke(27,30,33);
            line(sX+2,sY+2,sX+2,sY+38);
            line(sX+2,sY+2,sX+38,sY+2);


            stroke(96);
            textSize(20);
            textAlign(CENTER);
            fill(#575757);
            text(slotNum, sX, (sY + 13), sW, sH);


        
            if (mousePressed == true && slotOn == false) // mousepressed and slot is off
        
            {

                textSize(20);
                textAlign(CENTER);
                fill(#f2f2f2);
                text(slotNum, sX, (sY + 13), sW, sH);
                stroke(150,164,181);
                line(sX+1,sY+39,sX+39,sY+39);
                line(sX+39,sY+1,sX+39,sY+39);
            
                stroke(15);
                line(sX+1,sY+1,sX+1,sY+39);
                line(sX+1,sY+1,sX+39,sY+1);
            
                stroke(27,30,33);
                line(sX+2,sY+2,sX+2,sY+38);
                line(sX+2,sY+2,sX+38,sY+2);

                stroke(96);

                if (layerSet == true)

                {
                    stroke(96);
                    textSize(20);
                    textAlign(CENTER);
                    fill(#ec1af0);
                    text(slotNum, sX, (sY + 13), sW, sH);
                }
            }
            
        }
 
        if (slotOn == false && layerSet == true)

        {
            stroke(96);
            textSize(20);
            textAlign(CENTER);
            fill(#ec1af0);
            text(slotNum, sX, (sY + 13), sW, sH);
        }

        slotLayerShowHideDraw(); // draw slot buttons and grid layers

    }
}

class ControlPanel // cPanel

{

    int cX,cY,cW,cH; // controlPanel button co-ordinates
    boolean cSaved; // layer save 
    boolean saveVisible; // save visibility

    ControlPanel(int controlX, int controlY,int controlW,int controlH, boolean controlSave, boolean controlSaveShownIcon) {
        cX = controlX;
        cY = controlY;
        cW = controlW;
        cH = controlH;
        cSaved = controlSave; // save is active, i.e. icon showing, layerSet = true etc. 
        saveVisible = controlSaveShownIcon; // save is visible
    }



    void display()  { // display controlPanel buttons


        clearButtonDraw();

        clearButtonHoverDraw();

        saveButtonDraw();
        
        saveShowHideButtonDraw();

        
        // hovers

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && layerSelect == selectState[2]) 
        
        { // save appears when selection is done
          
          hoverBeforeSaveDraw();

        }

        hoverSaveButtonDraw();
        
        // mousePress effects  

        if (mousePressed == true && layerSelect == selectState[2])
        
        { // save is currently off, but being switched on
            if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40) 

            { // save is being switched on - green icon appears
            
            fill(#646464);   
            rect(c1.cX,c1.cY,c1.cW,c1.cH);
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(120);
            line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
            line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

            image(saveShow,c1.cX+5,c1.cY+6,30,30);
            }        
        }

        if (mousePressed == true)
        
        { // save is currently on
        
        mousePressedShowHideButtonDraw();
        
        }
    }
}

class PlayControls // visualisation play

{
    int pX,pY,pW,pH;
    boolean pOn;

    PlayControls(int playX,int playY, int playW, int playH, boolean playOn) {
        pX = playX;
        pY = playY;
        pW = playW;
        pH = playH;
        pOn = playOn;
    }
}



void setupControls() 

{ // needs to be in Setup() - instantiates slots and cPanel controls
    s1 = new Slot("1",255,(offset+55),(offset+572),40,40,true,true,0,0,0,0,false);
    s2 = new Slot("2",255,(offset+95),(offset+572),40,40,false,false,0,0,0,0,false);
    s3 = new Slot("3",255,(offset+135),(offset+572),40,40,false,false,0,0,0,0,false);
    s4 = new Slot("4",255,(offset+175),(offset+572),40,40,false,false,0,0,0,0,false);
    s5 = new Slot("5",255,(offset+215),(offset+572),40,40,false,false,0,0,0,0,false);
    s6 = new Slot("6",255,(offset+255),(offset+572),40,40,false,false,0,0,0,0,false);
    s7 = new Slot("7",255,(offset+295),(offset+572),40,40,false,false,0,0,0,0,false);
    s8 = new Slot("8",255,(offset+335),(offset+572),40,40,false,false,0,0,0,0,false);
    s9 = new Slot("9",255,(offset+375),(offset+572),40,40,false,false,0,0,0,0,false);
    s10 = new Slot("10",255,(offset+415),(offset+572),40,40,false,false,0,0,0,0,false);
    c1 = new ControlPanel((offset+55),(offset+617),40,40,false,true); // save
    c2 = new ControlPanel((offset+55),(offset+662),40,40,false,false); // clear
    play = new PlayControls(true);
}

void drawSlots()

{ // needs to be in draw() - i.e. draw slots
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
    c1.display();
    c2.display();

    
}

void drawControls()

{
    play.display();
}
 
void layers() 

{ // draws layers for selection, start point, end point and final layer
 
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

{ // mouse click events + deselect

    
    if (mouseY < 64) { // CHANGE GRID SIZE
        if (mouseX < 64) {
            if (gridSize > 1) {
                gridSize = gridSize / 2;
                
            }
        } else if (mouseX > (width-64)) {
            if (gridSize < boxSize / 2) {
                gridSize = gridSize * 2;
               
            }
        }
    }
    
    if (mouseX < width/2+(offset/2) && mouseX > width/2-(offset/2) && mouseY < (offset/2)) { // CONSOLE LOG REPORTING
        println("Console log.");
        println("left/right offset: " + offset);
        println("slot1 layerSet: " + s1.layerSet);
        println("slot2 layerSet: " + s2.layerSet);
        println("slot3 layerSet: " + s3.layerSet);
        println("slot4 layerSet: " + s4.layerSet);
        println("slot5 layerSet: " + s5.layerSet);
        println("slot6 layerSet: " + s6.layerSet);
        println("slot7 layerSet: " + s7.layerSet);
        println("slot8 layerSet: " + s8.layerSet);
        println("slot9 layerSet: " + s9.layerSet);
        println("slot10 layerSet: " + s10.layerSet);
    }

    
    if (mouseX > offset && mouseX < (offset)+512 && mouseY > offset && mouseY < (offset)+512 ) { // SELECT LAYER 
        switch (layerSelect) {
            case selectState[0]: // ready to start, get start x,y
                startSelectX = mouseX;
                startSelectY = mouseY;
                layerSelect = selectState[1];
                println("Mouse click. First (x,y) values captured");
                println("Layers - selection is started; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
            case selectState[1]: // ready to complete, get end x,y
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
                readyToSave = true;
                break;
            case selectState[2]:
                layerSelect = selectState[0];
                startSelectX = 0;
                endSelectX = 0;
                startSelectY = 0;
                endSelectY = 0;
                readyToSave = false; 
                println("Mouse click. Layer select set to off");
                println("Layers - selection switched off; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
        }
    }
    if ((mouseY > 64 && mouseX < offset) || (mouseY > 64 && mouseX < offset) || (mouseX > 512+offset && mouseY > 64)) { // DESELECT LAYER
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false;
        s1.slotOn = false;
        s2.slotOn = false;
        s3.slotOn = false;
        s4.slotOn = false;
        s5.slotOn = false;
        s6.slotOn = false;
        s7.slotOn = false;
        s8.slotOn = false;
        s9.slotOn = false;
        s10.slotOn = false;
        
               
    }

    slotSelectClicks(); // SLOT SELECTION
    
    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40)
    
    { // cPanel save clicks for slots 1-10 

        saveButtonClicks();
        
    }
    
    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40) 
    
    { // cPanel clear clicks for slots 1-10
    
      clearButtonClicks();

    }

    
}

void boxOver() 

{ // rollover on main grid squares before selection
    
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

{ // draws the background, grid, and top buttons
    
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


// DRAW LAYERS

void slotLayerShowHideDraw()

{ // draw show & hide saved layers on grid
    
    if (s1.slotOn == true && s1.layerSet == true && s1.layerVisible == true) // draw saved layer
        // s1.draw saved layer
        {
               
            fill(0x1Aff99ff);
            rectMode(Processing.CORNER);
            rect(s1.layX,s1.layY,s1.layW,s1.layH);
            
        }

    if (s1.slotOn == true && s1.layerSet == true && s1.layerVisible == false) 
        // s1.hide saved layer
        {
             
            fill(#ff99ff,128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s2.slotOn == true && s2.layerSet == true && s2.layerVisible == true) 
        
        { // s2.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s2.layX,s2.layY,s2.layW,s2.layH);
            
        }

    if (s2.slotOn == true && s2.layerSet == true && s2.layerVisible == false) // hide saved layer
        
        { // s2.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s3.slotOn == true && s3.layerSet == true && s3.layerVisible == true) 
        
        { // s3.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s3.layX,s3.layY,s3.layW,s3.layH);
            
        }

    if (s3.slotOn == true && s3.layerSet == true && s3.layerVisible == false) // hide saved layer
        
        { // s3.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s4.slotOn == true && s4.layerSet == true && s4.layerVisible == true) 
        
        { // s4.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s4.layX,s4.layY,s4.layW,s4.layH);
            
        }

    if (s4.slotOn == true && s4.layerSet == true && s4.layerVisible == false) // hide saved layer
        
        { // s4.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }
        
    if (s5.slotOn == true && s5.layerSet == true && s5.layerVisible == true) 
        
        { // s5.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s5.layX,s5.layY,s5.layW,s5.layH);
            
        }

    if (s5.slotOn == true && s5.layerSet == true && s5.layerVisible == false) // hide saved layer
        
        { // s5.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s6.slotOn == true && s6.layerSet == true && s6.layerVisible == true) 
        
        { // s6.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s6.layX,s6.layY,s6.layW,s6.layH);
            
        }

    if (s6.slotOn == true && s6.layerSet == true && s6.layerVisible == false) // hide saved layer
        
        { // s6.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s7.slotOn == true && s7.layerSet == true && s7.layerVisible == true) 
        
        { // s7.raw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s7.layX,s7.layY,s7.layW,s7.layH);
            
        }

    if (s7.slotOn == true && s7.layerSet == true && s7.layerVisible == false) // hide saved layer
        
        { // s7.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s8.slotOn == true && s8.layerSet == true && s8.layerVisible == true) 
        
        { // s8.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s8.layX,s8.layY,s8.layW,s8.layH);
            
        }

    if (s8.slotOn == true && s8.layerSet == true && s8.layerVisible == false) // hide saved layer
        
        { // s8.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s9.slotOn == true && s9.layerSet == true && s9.layerVisible == true) 
        
        { // s9.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s9.layX,s9.layY,s9.layW,s9.layH);
            
        }

    if (s9.slotOn == true && s9.layerSet == true && s9.layerVisible == false) // hide saved layer
        
        { // s9.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s10.slotOn == true && s10.layerSet == true && s10.layerVisible == true) 
        
        { // s10.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s10.layX,s10.layY,s10.layW,s10.layH);
            
        }

    if (s10.slotOn == true && s10.layerSet == true && s10.layerVisible == false) // hide saved layer
        
        { // s10.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }
}


// DRAW cPANEL

void saveButtonDraw()

{

    if (s1.layerSet == false && layerSelect == selectState[2] && s1.slotOn == true)
    
    { // save button shows
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s2.layerSet == false && layerSelect == selectState[2] && s2.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s3.layerSet == false && layerSelect == selectState[2] && s3.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s4.layerSet == false && layerSelect == selectState[2] && s4.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s5.layerSet == false && layerSelect == selectState[2] && s5.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s6.layerSet == false && layerSelect == selectState[2] && s6.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s7.layerSet == false && layerSelect == selectState[2] && s7.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s8.layerSet == false && layerSelect == selectState[2] && s8.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s9.layerSet == false && layerSelect == selectState[2] && s9.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    if (s10.layerSet == false && layerSelect == selectState[2] && s10.slotOn == true)
    
    { // save is off
        fill(255);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        image(save,c1.cX+5,c1.cY+5,30,30); 
    }

    
}

void saveShowHideButtonDraw() 

{ // draw show & hide buttons in cPanel

    if (s1.layerVisible == true && s1.layerSet == true && s1.slotOn == true)  
    
    { // s1.save is on and visible (will need to do these for all slots)
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s1.layerVisible == false && s1.layerSet == true && s1.slotOn == true)

    { //  s1.save is on, but invisible (will need to do these for all slots)

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s2.layerVisible == true && s2.layerSet == true && s2.slotOn == true)  
    
    { // s2.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s2.layerVisible == false && s2.layerSet == true && s2.slotOn == true)

    { //  s2.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s3.layerVisible == true && s3.layerSet == true && s3.slotOn == true) 
    
    { // s3.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);
    }
    
    if (s3.layerVisible == false && s3.layerSet == true && s3.slotOn == true)  
    
    { //  s3.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s4.layerVisible == true && s4.layerSet == true && s4.slotOn == true)  
    
    { // s4.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s4.layerVisible == false && s4.layerSet == true && s4.slotOn == true)

    { //  s4.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s5.layerVisible == true && s5.layerSet == true && s5.slotOn == true)  
    
    { // s5.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s5.layerVisible == false && s5.layerSet == true && s5.slotOn == true)

    { //  s5.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s6.layerVisible == true && s6.layerSet == true && s6.slotOn == true)  
    
    { // s6.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s6.layerVisible == false && s6.layerSet == true && s6.slotOn == true)

    { //  s6.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s7.layerVisible == true && s7.layerSet == true && s7.slotOn == true)  
    
    { // s7.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s7.layerVisible == false && s7.layerSet == true && s7.slotOn == true)

    { //  s7.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s8.layerVisible == true && s8.layerSet == true && s8.slotOn == true)  
    
    { // s8.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s8.layerVisible == false && s8.layerSet == true && s8.slotOn == true)

    { //  s8.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }

    if (s9.layerVisible == true && s9.layerSet == true && s9.slotOn == true)  
    
    { // s9.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s9.layerVisible == false && s9.layerSet == true && s9.slotOn == true)

    { //  s9.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }    
    
    if (s10.layerVisible == true && s10.layerSet == true && s10.slotOn == true)  
    
    { // s10.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s10.layerVisible == false && s10.layerSet == true && s10.slotOn == true)

    { //  s10.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHide,c1.cX+5,c1.cY+6,30,30);

    }


}

void hoverSaveButtonDraw()

{ // draw hover on save button in cPanel (s1-s10)

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s1.layerSet == true && s1.layerVisible == true && s1.slotOn == true) 
        
        { // s1.draw save button hover when layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s2.layerSet == true && s2.layerVisible == true && s2.slotOn == true) 
        
        { // s2.draw save button hover when layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s3.layerSet == true && s3.layerVisible == true && s3.slotOn == true) 
        
        { // s3.draw save button hover when layer is visible            
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s4.layerSet == true && s4.layerVisible == true && s4.slotOn == true) 
        
        { // s4.draw save button hover when layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s5.layerSet == true && s5.layerVisible == true  && s5.slotOn == true) 
        
        { // s5.draw save button hover when layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s6.layerSet == true && s6.layerVisible == true && s6.slotOn == true) 
        
        { // s6.draw save button hover when layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s7.layerSet == true && s7.layerVisible == true  && s7.slotOn == true) 
        
        { // s7.draw save button hover when layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s8.layerSet == true && s8.layerVisible == true  && s8.slotOn == true) 
        
        { // s8.draw save button hover when layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s9.layerSet == true && s9.layerVisible == true && s9.slotOn == true) 
        
        { // s9.draw save button hover when layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s10.layerSet == true && s10.layerVisible == true  && s10.slotOn == true) 
        
        { // s10.draw save button hover when layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHide,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s1.layerSet == true && s1.layerVisible == false && s1.slotOn == true) 
        
        { // s1.draw save button hover wnen layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s2.layerSet == true && s2.layerVisible == false && s2.slotOn == true) 
        
        { // s2.draw save button hover wnen layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s3.layerSet == true && s3.layerVisible == false  && s3.slotOn == true) 
        
        { // s3.draw save button hover wnen layer is invisible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }
        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s4.layerSet == true && s4.layerVisible == false && s4.slotOn == true) 
        
        { // s4.draw save button hover wnen layer is invisible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }        
        
        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s5.layerSet == true && s5.layerVisible == false && s5.slotOn == true) 
        
        { // s5.draw save button hover wnen layer is invisible 
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s6.layerSet == true && s6.layerVisible == false  && s6.slotOn == true) 
        
        { // s6.draw save button hover wnen layer is invisible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s7.layerSet == true && s7.layerVisible == false && s7.slotOn == true) 
        
        { // s7.draw save button hover wnen layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s8.layerSet == true && s8.layerVisible == false && s8.slotOn == true) 
        
        { // s8.draw save button hover wnen layer is invisible 
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s9.layerSet == true && s9.layerVisible == false && s9.slotOn == true) 
        
        { // s9.draw save button hover wnen layer is invisible 
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s10.layerSet == true && s10.layerVisible == false && s10.slotOn == true) 
        
        { // s10.draw save button hover wnen layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

}

void hoverBeforeSaveDraw()

{

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s1.layerSet == false && layerSelect == selectState[2]  && s1.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s2.layerSet == false && layerSelect == selectState[2]  && s2.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s3.layerSet == false && layerSelect == selectState[2] && s3.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s4.layerSet == false && layerSelect == selectState[2] && s4.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s5.layerSet == false && layerSelect == selectState[2] && s5.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s6.layerSet == false && layerSelect == selectState[2] && s6.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s7.layerSet == false && layerSelect == selectState[2] && s7.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s8.layerSet == false && layerSelect == selectState[2] && s8.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s9.layerSet == false && layerSelect == selectState[2] && s9.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s10.layerSet == false && layerSelect == selectState[2] && s10.slotOn == true) 
    
    { // draw hover before save
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(255);
        fill(255);
        rect(c1.cX+5,c1.cY+5,30,30); 
        image(save,c1.cX+5,c1.cY+5,30,30); 
        stroke(96);

    }    

}

void mousePressedShowHideButtonDraw()

{  // draw mousepressed for show & hide buttons in cPanel

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s1.layerVisible == false) 

    { // s1.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s2.layerVisible == false) 

    { // s2.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }    

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s3.layerVisible == false) 

    { // s3.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s4.layerVisible == false) 

    { // s4.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s5.layerVisible == false) 

    { // s5.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s6.layerVisible == false) 

    { // s6.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s7.layerVisible == false) 

    { // s7.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s8.layerVisible == false) 

    { // s8.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s9.layerVisible == false) 

    { // s9.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s10.layerVisible == false) 

    { // s10.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }
   

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s1.layerVisible == true) 

    { // s1.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s2.layerVisible == true) 

    { // s2.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s3.layerVisible == true) 

    { // s3.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s4.layerVisible == true) 

    { // s4.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s5.layerVisible == true) 

    { // s5.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s6.layerVisible == true) 

    { // s6.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s7.layerVisible == true) 

    { // s7.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s8.layerVisible == true) 

    { // s8.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s9.layerVisible == true) 

    { // s9.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s10.layerVisible == true) 

    { // s10.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHide,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40)
            
    { // mousepressed and clearing slot drawn
            
        fill(#646464);   
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
            
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(120);
        line(c2.cX+2,c2.cY+38,c2.cX+38,c2.cY+38);
        line(c2.cX+38,c2.cY+2,c2.cX+38,c2.cY+38);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
            
        stroke(#646464);
        fill(#646464);
        rect(c2.cX+5,c2.cY+6,30,30); 
        image(clearOn,c2.cX+5,c2.cY+6,30,30);
        stroke(96);

    }

}

void clearButtonDraw()

{

    if (c2.cSaved == false && s1.layerSet == true && s1.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s2.layerSet == true && s2.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s3.layerSet == true && s3.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s4.layerSet == true && s4.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s5.layerSet == true && s5.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s6.layerSet == true && s6.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s7.layerSet == true && s7.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s8.layerSet == true && s8.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s9.layerSet == true && s9.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }

    if (c2.cSaved == false && s10.layerSet == true && s10.slotOn == true) 
    
    { // draw clear icon for visible save
        fill(255); 
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
        image(clear,c2.cX+5,c2.cY+5,30,30);
    }



}

void clearButtonHoverDraw()
{

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s1.layerSet == true && s1.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s2.layerSet == true && s2.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s3.layerSet == true && s3.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s4.layerSet == true && s4.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s5.layerSet == true && s5.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s6.layerSet == true && s6.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s7.layerSet == true && s7.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s8.layerSet == true && s8.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s9.layerSet == true && s9.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && s10.layerSet == true && s10.slotOn == true) 
    
    { // hover draw for clear button
    
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        stroke(27,30,33);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        
        stroke(255);
        fill(255);
        rect(c2.cX+5,c2.cY+5,30,30); 
        image(clear,c2.cX+5,c2.cY+5,30,30);
        stroke(96);

    }

}


// CLICKS

void slotSelectClicks() 

{ // click slot button to make active
    
    if (mouseX > s1.sX && mouseX < s1.sX+40 && mouseY > s1.sY && mouseY < s1.sY+40){ // slots

        if (s1.slotOn == false) {
                s1.slotOn = true;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;                
        }
    }
    if (mouseX > s2.sX && mouseX < s2.sX+40 && mouseY > s2.sY && mouseY < s2.sY+40){ // slots
        
        if (s2.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = true;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 40+c1.cX;
                c2.cX = 40+c2.cX;

        }
    }    
    if (mouseX > s3.sX && mouseX < s3.sX+40 && mouseY > s3.sY && mouseY < s3.sY+40){ // slots
        
        if (s3.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = true;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 80+c1.cX;
                c2.cX = 80+c2.cX;
        }
    }    
    if (mouseX > s4.sX && mouseX < s4.sX+40 && mouseY > s4.sY && mouseY < s4.sY+40){ // slots
        
        if (s4.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = true;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 120+c1.cX;
                c2.cX = 120+c2.cX;

        }
    }
    if (mouseX > s5.sX && mouseX < s5.sX+40 && mouseY > s5.sY && mouseY < s5.sY+40){ // slots
        
        if (s5.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = true;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 160+c1.cX;
                c2.cX = 160+c2.cX;

        }

    }
    if (mouseX > s6.sX && mouseX < s6.sX+40 && mouseY > s6.sY && mouseY < s6.sY+40){ // slots
        
        if (s6.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = true;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 200+c1.cX;
                c2.cX = 200+c2.cX;

        }

    }
    if (mouseX > s7.sX && mouseX < s7.sX+40 && mouseY > s7.sY && mouseY < s7.sY+40){ // slots
        

        if (s7.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = true;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 240+c1.cX;
                c2.cX = 240+c2.cX;

        }

    }
    if (mouseX > s8.sX && mouseX < s8.sX+40 && mouseY > s8.sY && mouseY < s8.sY+40){ // slots
        
        if (s8.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = true;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 280+c1.cX;
                c2.cX = 280+c2.cX;

        }
    }
    if (mouseX > s9.sX && mouseX < s9.sX+40 && mouseY > s9.sY && mouseY < s9.sY+40){ // slots
        
        if (s9.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = true;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 320+c1.cX;
                c2.cX = 320+c2.cX;

        }
    }
    if (mouseX > s10.sX && mouseX < s10.sX+40 && mouseY > s10.sY && mouseY < s10.sY+40){ // slots
        
        if (s10.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = true;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 360+c1.cX;
                c2.cX = 360+c2.cX;

        }
    }     
}

void saveButtonClicks()  
{  // MAGIC FIX + click save button in cPanel 

        
    if (s1.layerVisible == false && s1.slotOn == true && s1.layerSet == true) 
        
    { // s1.switch save visibility to on, from off
             
        
        s1.layerVisible = true; // this is for the layer draw

    }
        
    else if (s1.layerVisible == true && s1.slotOn == true && s1.layerSet == true) 
    
    { // s1.switch save visibility to off, from on
            
        
        s1.layerVisible = false; // controls the layer draw in the grid
    }

    if (s1.layerSet == false && s1.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // MAGIC FIX + s1.on click, get values for layer save 

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s1.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s1.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s1.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s1.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s1.layerSet = true; // now display layer if layerVisible is true
        s1.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s2.layerVisible == false && s2.slotOn == true && s2.layerSet == true) 
        
    { // s2.switch save visibility to on, from off
             
        s2.layerVisible = true;

    }
        
    else if (s2.layerVisible == true && s2.slotOn == true && s2.layerSet == true) 
    
    { // s2.switch save visibility to off, from on
            
        s2.layerVisible = false; // controls the layer draw in the grid
    }

    if (s2.layerSet == false && s2.slotOn == true && layerSelect == selectState[2] &&  readyToSave == true) 
    
    {  // s2.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s2.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s2.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s2.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s2.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s2.layerSet = true; // now display save layer: cPanel display()
        s2.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s3.layerVisible == false && s3.slotOn == true && s3.layerSet == true) 
        
    { // s3.switch save visibility to on, from off
             
        s3.layerVisible = true;

    }
        
    else if (s3.layerVisible == true && s3.slotOn == true && s3.layerSet == true) 
    
    { // s3.switch save visibility to off, from on
            
        s3.layerVisible = false; // controls the layer draw in the grid
    }

    if (s3.layerSet == false && s3.slotOn == true && layerSelect == selectState[2] &&  readyToSave == true) 
    
    {  // s3.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s3.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s3.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s3.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s3.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s3.layerSet = true; // now display save layer: cPanel display()
        s3.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s4.layerVisible == false && s4.slotOn == true && s4.layerSet == true) 
        
    { // s4.switch save visibility to on, from off
             
        s4.layerVisible = true;

    }
        
    else if (s4.layerVisible == true && s4.slotOn == true && s4.layerSet == true) 
    
    { // s4.switch save visibility to off, from on
            
        s4.layerVisible = false; // controls the layer draw in the grid
    }

    if (s4.layerSet == false && s4.slotOn == true && layerSelect == selectState[2] &&  readyToSave == true) 
    
    {  // s4.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s4.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s4.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s4.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s4.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s4.layerSet = true; // now display save layer: cPanel display()
        s4.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s5.layerVisible == false && s5.slotOn == true && s5.layerSet == true) 
        
    { // s5.switch save visibility to on, from off
             
        s5.layerVisible = true;

    }
        
    else if (s5.layerVisible == true && s5.slotOn == true && s5.layerSet == true) 
    
    { // s5.switch save visibility to off, from on
            
        s5.layerVisible = false; // controls the layer draw in the grid
    }

    if (s5.layerSet == false && s5.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s5.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
            swap = endSelectX;
            endSelectX = startSelectX;
            startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s5.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s5.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s5.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s5.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s5.layerSet = true; // now display save layer: cPanel display()
        s5.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }
    
    if (s6.layerVisible == false && s6.slotOn == true && s6.layerSet == true) 
        
    { // s6.switch save visibility to on, from off
             
        s6.layerVisible = true;

    }
        
    else if (s6.layerVisible == true && s6.slotOn == true && s6.layerSet == true) 
    
    { // s6.switch save visibility to off, from on
            
        s6.layerVisible = false; // controls the layer draw in the grid
    }

    if (s6.layerSet == false && s6.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s6.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
            swap = endSelectX;
            endSelectX = startSelectX;
            startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s6.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s6.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s6.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s6.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s6.layerSet = true; // now display save layer: cPanel display()
        s6.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }
    
    if (s7.layerVisible == false && s7.slotOn == true && s7.layerSet == true) 
        
    { // s7.switch save visibility to on, from off
             
        s7.layerVisible = true;

    }
        
    else if (s7.layerVisible == true && s7.slotOn == true && s7.layerSet == true) 
    
    { // s7.switch save visibility to off, from on
            
        s7.layerVisible = false; // controls the layer draw in the grid
    }

    if (s7.layerSet == false && s7.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s7.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s7.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s7.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s7.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s7.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s7.layerSet = true; // now display save layer: cPanel display()
        s7.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s8.layerVisible == false && s8.slotOn == true && s8.layerSet == true) 
        
    { // s8.switch save visibility to on, from off
             
        s8.layerVisible = true;

    }
        
    else if (s8.layerVisible == true && s8.slotOn == true && s8.layerSet == true) 
    
    { // s8.switch save visibility to off, from on
            
        s8.layerVisible = false; // controls the layer draw in the grid
    }

    if (s8.layerSet == false && s8.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s8.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s8.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s8.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s8.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s8.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s8.layerSet = true; // now display save layer: cPanel display()
        s8.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s9.layerVisible == false && s9.slotOn == true && s9.layerSet == true) 
        
    { // s9.switch save visibility to on, from off
             
        s9.layerVisible = true;

    }
        
    else if (s9.layerSet == true && s9.slotOn == true && s9.layerVisible == true) 
    
    { // s9.switch save visibility to off, from on
            
        s9.layerVisible = false; // controls the layer draw in the grid
    }

    if (s9.layerSet == false && s9.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s9.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s9.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s9.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s9.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s9.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s9.layerSet = true; // now display save layer: cPanel display()
        s9.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s10.layerVisible == false && s10.slotOn == true && s10.layerSet == true) 
        
    { // s10.switch save visibility to on, from off
             
        s10.layerVisible = true;

    }
        
    else if (s10.layerSet == true && s10.slotOn == true && s10.layerVisible == true) 
    
    { // s10.switch save visibility to off, from on
            
        s10.layerVisible = false; // controls the layer draw in the grid
    }

    if (s10.layerSet == false && s10.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s10.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s10.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s10.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s10.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s10.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s10.layerSet = true; // now display save layer: cPanel display()
        s10.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }
}

void clearButtonClicks()

{  // click clear button in cPanel clear 
    if (s1.layerSet == true && s1.slotOn == true){ // check which slot is active, change that slots values
        s1.layX = 0;
        s1.layY = 0;
        s1.layW = 0;
        s1.layH = 0;
        s1.layerSet = false; // s1 layer is no longer set
        s1.layerVisible = false;// no layer to draw
    }

    if (s2.layerSet == true && s2.slotOn == true){ // check which slot is active, change that slots values
        s2.layX = 0;
        s2.layY = 0;
        s2.layW = 0;
        s2.layH = 0;
        s2.layerSet = false; // s2 layer is no longer set
        s2.layerVisible = false;// no layer to draw
    } 

    if (s3.layerSet == true && s3.slotOn == true){ // check which slot is active, change that slots values
        s3.layX = 0;
        s3.layY = 0;
        s3.layW = 0;
        s3.layH = 0;
        s3.layerSet = false; // s3 layer is no longer set
        s3.layerVisible = false;// no layer to draw
    }            

    if (s4.layerSet == true && s4.slotOn == true){ // check which slot is active, change that slots values
        s4.layX = 0;
        s4.layY = 0;
        s4.layW = 0;
        s4.layH = 0;
        s4.layerSet = false; // s4 layer is no longer set
        s4.layerVisible = false;// no layer to draw
    } 

    if (s5.layerSet == true && s5.slotOn == true){ // check which slot is active, change that slots values
        s5.layX = 0;
        s5.layY = 0;
        s5.layW = 0;
        s5.layH = 0;
        s5.layerSet = false; // s5 layer is no longer set
        s5.layerVisible = false;// no layer to draw
    } 

    if (s6.layerSet == true && s6.slotOn == true){ // check which slot is active, change that slots values
        s6.layX = 0;
        s6.layY = 0;
        s6.layW = 0;
        s6.layH = 0;
        s6.layerSet = false; // s6 layer is no longer set
        s6.layerVisible = false;// no layer to draw
    } 

    if (s7.layerSet == true && s7.slotOn == true){ // check which slot is active, change that slots values
        s7.layX = 0;
        s7.layY = 0;
        s7.layW = 0;
        s7.layH = 0;
        s7.layerSet = false; // s7 layer is no longer set
        s7.layerVisible = false;// no layer to draw
    } 

    if (s8.layerSet == true && s8.slotOn == true){ // check which slot is active, change that slots values
        s8.layX = 0;
        s8.layY = 0;
        s8.layW = 0;
        s8.layH = 0;
        s8.layerSet = false; // s8 layer is no longer set
        s8.layerVisible = false;// no layer to draw
    } 

    if (s9.layerSet == true && s9.slotOn == true){ // check which slot is active, change that slots values
        s9.layX = 0;
        s9.layY = 0;
        s9.layW = 0;
        s9.layH = 0;
        s9.layerSet = false; // s9 layer is no longer set
        s9.layerVisible = false;// no layer to draw
    } 

    if (s10.layerSet == true && s10.slotOn == true){ // check which slot is active, change that slots values
        s10.layX = 0;
        s10.layY = 0;
        s10.layW = 0;
        s10.layH = 0;
        s10.layerSet = false; // s10 layer is no longer set
        s10.layerVisible = false;// no layer to draw
    } 

    else {
        c2.cSaved = false; // if save isn't active, clear slot isn't visible
    }    
}

//.......

// TO-DO: VISUALISATIONS ... in progress

class Particle {

  Vector3D loc;

  Vector3D vel;

  Vector3D acc;

  float r;

  float timer;



  // One constructor

  Particle(Vector3D a, Vector3D v, Vector3D l, float r_) {

    acc = a.copy();

    vel = v.copy();

    loc = l.copy();

    r = r_;

    timer = 100.0;

  }

  

  // Another constructor (the one we are using here)

  Particle(Vector3D l) {

    acc = new Vector3D(0,0.05,0);

    vel = new Vector3D(random(-1,1),random(-2,0),0);

    loc = l.copy();

    r = 10.0;

    timer = 100.0;

  }





  void run() {

    update();

    render();

  }



  // Method to update location

  void update() {

    vel.add(acc);

    loc.add(vel);

    timer -= 1.0;

  }



  // Method to display

  void render() {

    ellipseMode(CENTER);

    noStroke();

    fill(255,timer);

    ellipse(loc.x,loc.y,r,r);

  }

  

  // Is the particle still useful?

  boolean dead() {

    if (timer <= 0.0) {

      return true;

    } else {

      return false;

    }

  }

}

// A class to describe a group of Particles

// An ArrayList is used to manage the list of Particles 


class ParticleSystem {



  ArrayList particles;    // An arraylist for all the particles

  Vector3D origin;        // An origin point for where particles are birthed



  ParticleSystem(int num, Vector3D v) {

    particles = new ArrayList();              // Initialize the arraylist

    origin = v.copy();                        // Store the origin point

    for (int i = 0; i < num; i++) {

      particles.add(new Particle(origin));    // Add "num" amount of particles to the arraylist

    }

  }



  void run() {

    // Cycle through the ArrayList backwards b/c we are deleting

    for (int i = particles.size()-1; i >= 0; i--) {

      Particle p = (Particle) particles.get(i);

      p.run();

      if (p.dead()) {

        particles.remove(i);

      }

    }

  }



  void addParticle() {

    particles.add(new Particle(origin));

  }



  void addParticle(Particle p) {

    particles.add(p);

  }



  // A method to test if the particle system still has particles

  boolean dead() {

    if (particles.isEmpty()) {

      return true;

    } else {

      return false;

    }

  }



}


// Simple Vector3D Class 



public class Vector3D {

  public float x;

  public float y;

  public float z;



  Vector3D(float x_, float y_, float z_) {

    x = x_; y = y_; z = z_;

  }



  Vector3D(float x_, float y_) {

    x = x_; y = y_; z = 0f;

  }

  

  Vector3D() {

    x = 0f; y = 0f; z = 0f;

  }



  void setX(float x_) {

    x = x_;

  }



  void setY(float y_) {

    y = y_;

  }



  void setZ(float z_) {

    z = z_;

  }

  

  void setXY(float x_, float y_) {

    x = x_;

    y = y_;

  }

  

  void setXYZ(float x_, float y_, float z_) {

    x = x_;

    y = y_;

    z = z_;

  }



  void setXYZ(Vector3D v) {

    x = v.x;

    y = v.y;

    z = v.z;

  }

  public float magnitude() {

    return (float) Math.sqrt(x*x + y*y + z*z);

  }



  public Vector3D copy() {

    return new Vector3D(x,y,z);

  }



  public Vector3D copy(Vector3D v) {

    return new Vector3D(v.x, v.y,v.z);

  }

  

  public void add(Vector3D v) {

    x += v.x;

    y += v.y;

    z += v.z;

  }



  public void sub(Vector3D v) {

    x -= v.x;

    y -= v.y;

    z -= v.z;

  }



  public void mult(float n) {

    x *= n;

    y *= n;

    z *= n;

  }



  public void div(float n) {

    x /= n;

    y /= n;

    z /= n;

  }



  public void normalize() {

    float m = magnitude();

    if (m > 0) {

       div(m);

    }

  }



  public void limit(float max) {

    if (magnitude() > max) {

      normalize();

      mult(max);

    }

  }



  public float heading2D() {

    float angle = (float) Math.atan2(-y, x);

    return -1*angle;

  }



  public Vector3D add(Vector3D v1, Vector3D v2) {

    Vector3D v = new Vector3D(v1.x + v2.x,v1.y + v2.y, v1.z + v2.z);

    return v;

  }



  public Vector3D sub(Vector3D v1, Vector3D v2) {

    Vector3D v = new Vector3D(v1.x - v2.x,v1.y - v2.y,v1.z - v2.z);

    return v;

  }



  public Vector3D div(Vector3D v1, float n) {

    Vector3D v = new Vector3D(v1.x/n,v1.y/n,v1.z/n);

    return v;

  }



  public Vector3D mult(Vector3D v1, float n) {

    Vector3D v = new Vector3D(v1.x*n,v1.y*n,v1.z*n);

    return v;

  }



  public float distance (Vector3D v1, Vector3D v2) {

    float dx = v1.x - v2.x;

    float dy = v1.y - v2.y;

    float dz = v1.z - v2.z;

    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);

  }



}





