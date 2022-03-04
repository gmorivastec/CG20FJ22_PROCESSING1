// 2 methods that we will be using 
// part of the lifecycle 
float displacement;

// runs once at the beginning
// used PRECISELY for setup
void setup() {
  
  size(800, 600, P3D);
  displacement = 0;
  printMatrix();
}

// this one runs each time we have a loop
// in graphical applications the program is running constantly
void draw() {

  background(255);
  
  // how to express matrices in Processing
  
  // 1st - translation matrix
  float tx = width/2;
  float ty = height/2;
  float tz = 0;
  PMatrix3D translation = new PMatrix3D(1, 0, 0, tx,
                                        0, 1, 0, ty,
                                        0, 0, 1, tz,
                                        0, 0, 0, 1);

  // 2nd - scale matrix
  
  // millis() - the amount of time that has passed since the beginning of execution
  // in milliseconds
  float scaleValue = cos(millis());
  float sx = scaleValue;
  float sy = scaleValue;
  float sz = scaleValue;
  PMatrix3D scale = new PMatrix3D(sx, 0,  0,  0,
                                  0,  sy, 0,  0,
                                  0,  0,  sz, 0,
                                  0,  0,  0,  1);
                                   
  
  // rotation in z 
  float angle = displacement;
  float cosAngle = cos(radians(angle));
  float sinAngle = sin(radians(angle));
  
  PMatrix3D rotationZ = new PMatrix3D(cosAngle, -sinAngle, 0, 0,
                                      sinAngle, cosAngle,  0, 0,
                                      0,        0,         1, 0,
                                      0,        0,         0, 1);
  
  // 1. we can define whatever amount of matrices we wish
  // they will NOT be applied until we specifically do so
  
  // 2. there is a matrix that defines the current state of the world
  // whenever we invoke applyMatrix the matrix changes
  
  // 3. Transformations must be applied BEFORE drawing
  
  // 4. Transformation order is INVERSE to what we intend to do
  
  // 5. IMPORTANT TO REMEMBER: all transformations are done using the origin as a pivot
  
  
  
  
  //applyMatrix(scale);
  // you can apply everything directly to the state matrix
  /*
  applyMatrix(translation);
  applyMatrix(rotationZ);
  */
  
  // you can declare a matrix in which you accumulate transformations and then apply it
  // not needed for homework!
  PMatrix3D transformations = new PMatrix3D(1, 0, 0, 0,
                                            0, 1, 0, 0,
                                            0, 0, 1, 0,
                                            0, 0, 0, 1);

  transformations.apply(translation);
  //transformations.apply(rotationZ);
  transformations.apply(scale);
  
  applyMatrix(transformations);
  
  drawSquare();
  
  // remember: transformations accumulate in the state matrix
  applyMatrix(translation);
  
  //drawSquare();
  
  
  
  //drawSquare();
  
  // SUPER IMPORTANT: the state matrix is reset each draw() invokation (JUST FOR PROCESSING)
  displacement += 1;
}

void drawSquare() {
  beginShape();
  
  // your vertices go right here!
  
  // x axis - positive goes right
  // y axis - positive goes down
  vertex(-50, -50);
  vertex(50, -50);
  vertex(50, 50);
  vertex(-50, 50);
  
  endShape(CLOSE);
}
