// UI
int score = 0;
String txt1 = "Game Over";
String txt2 = "press R to try again";
int[][] blocks = {
  {0, -179, 800, 20, 1}, 
  {0, 800, 800, 20, 1}, 
  {-21, 200, 20, 600, 1}, 
  {800, 200, 20, 600, 1}, 
  {200, 675, 350, 20},
  {0, 200, 20, 600},
  {780, 200, 20, 600},
  {20, 600, 30, 600},
  {760, 525, 20, 600},
  {50, 775, 100, 600},
  {720, 745, 40, 600},
  {20, 475, 20, 60},
  {650, 400, 500, 30},
  {550, 385, 500, 30},
  {635, 500, 20, 250},
  {635, 675, 40, 20},
  {495, 580, 150, 30},
  {735, 600, 150, 30},
  {135, 535, 245, 15},
  {520, 750, 60, 10},
  {50, 640, 30, 20},
  {360, 450, 145, 15},
  {130, 400, 80, 30},
};

// Controls
boolean[] keys = new boolean[256];

// Animation
PImage[] img = new PImage[0];
int Frame = 0;
int Timer = 0;
int TimerMax = 4;

// Player
float size = 35;
float px = 400;
float py = 750;
float rx = px;
float ry = py;
float pxv = 0;
float pyv = 0;
float pspeed = 6;
float gravity = 0;
boolean falling = true;
boolean move = true;

// Coin
float[] x = {400};
float[] y = {650};

// bees
int beecount = 0;
int beesize = 10;
float chaseSpeed = 1;
PVector[] bee= new PVector[1000];
boolean stung = false;
int stungcount = 0;

// bullet
int bulletSpeed = 10;
int bulletSize = 10;
int ammo = 5;
boolean shoot = false;
PVector bullet = new PVector(px, py);
int fireworkSize = 25;
int beesKilled = 0;


void setup() {
  size(800, 800);
  noStroke();
  smooth();
  for (int i = 0; i < bee.length; i++) { bee[i] = new PVector(random(0,width), random(0, 100), 0.);}
  for (int i = 1; i <= 9; i++) { img = (PImage[])append(img, loadImage("Walk" + i + ".png")); }
}

void draw() {
  if (move) {
    Timer++;
    if (Timer >= TimerMax) {
      Timer = 0;
      Frame++;
      if (Frame >= img.length) { Frame = 0; }
    }
  } else { Frame = 0; }
  background(250);
  keyReader();
  block();
  player();
  summonTheBees();
  shootyshooty();
  fill(255, 191, 0);
  coin();
  fill(0);
  textSize(24);
  text("Score: " + score + "\nAmmo: " + ammo,20,30);
 
  if (stung && stungcount > 10 * beecount * beecount * beecount) {
    fill(255, 0, 0); 
    background(0);
    textAlign(CENTER);
    textSize(60);
    text(txt1, width/2, height/2);
    textSize(24);
    text(txt2, width/2, height/2 + 50);
  }
}

void block() {
  for (int i = 0; i < blocks.length; i++) {
    fill(100);
    if (px + pxv + size > blocks[i][0] && px + pxv < blocks[i][0] + blocks[i][2] && py + size > blocks[i][1] && py < blocks[i][1] + blocks[i][3]) { pxv = 0; }
    if (px +size > blocks[i][0] && px < blocks[i][0] + blocks[i][2] && py + pyv + size > blocks[i][1] && py < blocks[i][1] + blocks[i][3]) {
      pyv = 0;
      gravity = 0;
      falling = false;
    }
    if (px + size > blocks[i][0] && px < blocks[i][0] + blocks[i][2] && py + size > blocks[i][1] && py + pyv < blocks[i][1] + blocks[i][3]) {
      pyv = 0;
      gravity = 0;
      falling = false;
    }
    rect(blocks[i][0], blocks[i][1], blocks[i][2], blocks[i][3]);
  }
}

void mousePressed() { 
  if (!stung && ammo > 0) { shoot = true; }
}
void mouseReleased() { 
  shoot = false;
  if (!stung && ammo > 0) {
    ellipse(bullet.x, bullet.y, fireworkSize, fireworkSize);
    for (int i = 0; i < bee.length; i++) {
      if(fireworkSize > beesize && dist(bullet.x, bullet.y, bee[i].x, bee[i].y) < fireworkSize/2 + beesize/2) {
        bee[i].x = -10000;
        bee[i].y = -10000;
        beesKilled++;
        fireworkSize += 1;
      }
    }
    ammo--;
  }
  bullet = new PVector(px+10,py+10);
}

void shootyshooty() {
  if (shoot) {
    fill(0);
    rect(bullet.x, bullet.y, bulletSize, bulletSize);
    float angle = atan2(mouseY-bullet.y-5, mouseX-bullet.x-5);
    float newX = cos(angle) * bulletSpeed + bullet.x;
    float newY = sin(angle) * bulletSpeed + bullet.y;
    bullet.set(newX, newY, 0);
  }
}

void keyPressed() { keys[keyCode] = true; }
void keyReleased() { keys[keyCode] = false; }

void keyReader() {
  pxv=0;
  pyv=0;
  if (stung == false) {
    if (keys[UP] && falling == false) { gravity -= 10; }
    if (keys[LEFT]) { pxv =- pspeed; }
    if (keys[RIGHT]) { pxv = pspeed; }
    if (keys[RIGHT] || keys[LEFT]) { move = true; }
    else { move = false; }
  }
  if(keys[82]){
    ammo = 0;
    beesKilled = 0;
    stung = false;
    for (int i = 0; i < bee.length; i++) { bee[i] = new PVector(random(0,width), random(0, 100), 0.);}
    score = 0;
    px = rx;
    py = ry;
    chaseSpeed = 1;
    beesize = 10;
    beecount = 0;
    stungcount = 0;
  }
  pyv += gravity;
  gravity += 0.5;
  falling = true;
}

void player() {
  px += pxv;
  py += pyv;
  image(img[Frame], px, py, size, size);
}

void coin() {
  for (int i = 0; i < x.length; i++) {
    if(dist(px+20,py+20,x[i],y[i]) < 25) {
        x[i] = -9999;
        score++;
        beecount++;
        if (score % 10 == 0) {
          beesize += 10;
          for (int j = 0; j < bee.length; j++) { bee[j] = new PVector(random(0, width), random(0, 100), 0.);}
          beecount = 1;
        }
        if (score % 5 == 0) { 
          chaseSpeed += .2; 
          ammo++;
        }
        x = append(x, random(50, width - 50));
        y = append(y, random(250, 775));
    }
    x[i] += random(-2, 2);
    y[i] += random(-2, 2);
    ellipse(x[i], y[i], 25, 25);
    ellipseMode(CENTER);
  }
}

void summonTheBees() {
  for (int i = 0; i < beecount * beecount; i++) {
    fill(0);
    if (stung) { fill(255,150,150); }
    ellipse(bee[i].x, bee[i].y, beesize, beesize);
    ellipseMode(CENTER);
    float angle = atan2(py+20-bee[i].y, px+20-bee[i].x);
    float newX = cos(angle) * chaseSpeed + bee[i].x;
    float newY = sin(angle) * chaseSpeed + bee[i].y;
    bee[i].set(newX, newY, 0);
    if(dist(px+20, py+20, newX, newY) < 8 + beesize - 10) { 
      stung = true;
      stungcount++;
    }
  }
}