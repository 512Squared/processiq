

Slot s1,s2,s3;

void setup() 
{
    size(768, 768);
    s1 = new Slot(255,150,250,56,56);
    s2 = new Slot(190,206,250,56,56);
    s3 = new Slot(255,262,250,56,56);
 
}

void draw()
{
    background(102);
    s1.display();
    s2.display();
    s3.display();
}



class Slot 
{
    int c;
    int sX, sY, sW, sH;
    Slot(int slotcol,int slotx,int sloty,int slotw, int sloth) {
        c = slotcol;
        sX = slotx;
        sY = sloty;
        sW = slotw;
        sH = sloth
    }

    void display() {
        //pushMatrix();
        translate(0,0);
        fill(c);   
        rect(sX,sY,sW,sH);
        //popMatrix();
    }
}

