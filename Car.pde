class Car{
  boolean acc = false, left = false, right = false, decc = false;
  PVector pos;
  PVector vel;
  float drag = 0.98;
  float angle = 0;
  float angularVelocity = 0;
  float angularDrag = 0.9;
  float power = 0.05;
  float turnSpeed = 0.01;
  float braking = 0.95;
  float[] proximity;
  
  Car(int x, int y){
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    proximity = new float[3];
  }
  
  void update(){
    if(acc){
      PVector delta = PVector.fromAngle(angle);
      delta.mult(power);
      vel.add(delta);
    }else if(decc){
      vel.mult(braking);
    }
    if(left){
      angularVelocity += turnSpeed;
    }
    if(right){
      angularVelocity -= turnSpeed;
    }
    pos.add(vel);
    vel.mult(drag);
    angle += angularVelocity;
    angularVelocity *= angularDrag;
  }
  
  void drawSensors(){
    PVector heading = PVector.fromAngle(angle - PI / 6);
    heading.mult(100);
    stroke(200, 100, 60);
    line(pos.x, pos.y, pos.x + heading.x, pos.y + heading.y);
    heading.rotate(PI / 3);
    line(pos.x, pos.y, pos.x + heading.x, pos.y + heading.y);
    heading.rotate(-PI / 6);
    line(pos.x, pos.y, pos.x + heading.x, pos.y + heading.y);
  }
  
  void show(){
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    rect(0, 0, 20, 10);
    popMatrix();
    drawSensors();
  }
}
