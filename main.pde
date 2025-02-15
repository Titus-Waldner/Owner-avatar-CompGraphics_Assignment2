// Main.pde
import java.util.Random;



ArrayList<SceneObject> sceneObjects = new ArrayList<SceneObject>();
MyColor backgroundColor = new MyColor(0, 0, 0); // Black background

void setup() {
  size(800, 800);
  loadPixels();

  // initialize Scene Objects
  initializeScene();

  // Perform Ray Tracing
  rayTraceScene();

  updatePixels();
}

// Initialize Scene Objects

void initializeScene() {
  // Clear the sceneObjects list if necessary
  sceneObjects = new ArrayList<SceneObject>();
  
  // Add Infinite Cone 1
    Material coneMaterial = new Material(new MyColor(200, 100, 50));
    float k = 0.4; //  cone's opening angle 
    PVector coneApex = new PVector(120, 20, 250);
    Cone infiniteCone = new Cone(coneApex, k, coneMaterial);
    sceneObjects.add(infiniteCone);

   // Add Infinite Cone 2
    coneMaterial = new Material(new MyColor(200, 200, 150));
    k = 1.2; //  cone's opening angle 
    coneApex = new PVector(120, -10, -250); 

    infiniteCone = new Cone(coneApex, k, coneMaterial);
    sceneObjects.add(infiniteCone);



  // Ground Plane
  Material groundMaterial = new Material(new MyColor(150, 150, 150)); // Gray color
  Plane groundPlane = new Plane(new PVector(0, -10, 0), new PVector(0, 1, 0), groundMaterial);
  sceneObjects.add(groundPlane);

  // **Add Spheres**
  
  // Reflective Sphere
  Material mirrorMaterial = new Material(new MyColor(200, 200, 200), true, 0.8); // High reflectivity
  Sphere mirrorSphere = new Sphere(new PVector(-30, 25, 60), 20, mirrorMaterial);
  sceneObjects.add(mirrorSphere);
  
  // Sphere 1
  Material sphereMaterial1 = new Material(new MyColor(255, 0, 0)); // Red
  Sphere sphere1 = new Sphere(new PVector(-25, 30, 460), 140, sphereMaterial1);
  sceneObjects.add(sphere1);

  // Sphere 2
  Material sphereMaterial2 = new Material(new MyColor(0, 255, 0)); // Green
  Sphere sphere2 = new Sphere(new PVector(20, 40, 80), 7, sphereMaterial2);
  sceneObjects.add(sphere2);

  // Sphere 3
  Material sphereMaterial3 = new Material(new MyColor(0, 0, 255)); // Blue
  Sphere sphere3 = new Sphere(new PVector(2, -4, 12), 1, sphereMaterial3);
  sceneObjects.add(sphere3);

  // **Add Cylinders (infinite)**
  
  // Cylinder 1
  Material cylinderMaterial1 = new Material(new MyColor(255, 255, 0)); // Yellow
  Cylinder cylinder1 = new Cylinder(new PVector(-15, 0, 70), 2, cylinderMaterial1);
  sceneObjects.add(cylinder1);



  // **Add 9 Pikmin**
  float pikminScale = 3.0; // Adjust the scale as needed
  PVector[] pikminPositions = new PVector[9];

  pikminPositions[0] = new PVector(15, -10, 40);
  pikminPositions[1] = new PVector(-20, -10, 45);
  pikminPositions[2] = new PVector(-3, -10, 25);
  pikminPositions[3] = new PVector(-10, -10, 55);
  pikminPositions[4] = new PVector(-5, -10, 60);
  pikminPositions[5] = new PVector(0, -10, 65);
  pikminPositions[6] = new PVector(5, -10, 70);
  pikminPositions[7] = new PVector(10, -10, 75);
  pikminPositions[8] = new PVector(15, -10, 80);
  
  Random rand = new Random(); // random for fun :) why not
  MyColor[] pikminColors = {
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)),
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)),
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)),
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)),
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)), 
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)), 
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)), 
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)), 
    new MyColor(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)) 
  };
  for (int i = 0; i < 9; i++) { //make all 9
    CompositeObject pikmin = createPikmin(pikminPositions[i], pikminScale, pikminColors[i]);
    sceneObjects.add(pikmin);
  }
}


// Ray Tracing Function
void rayTraceScene() {
    
    float L = -10, R = 10, B = -10, T = 10, N = 16;

    float dx = (R - L) / (float)width;
    float dy = (T - B) / (float)height;


    for (int j = 0; j < height; j++) {
        for (int i = 0; i < width; i++) {
            // Compute ray direction
            float x_p = L + (i + 0.5) * dx;
            float y_p = T - (j + 0.5) * dy;
            PVector direction = new PVector(x_p, y_p, N).normalize();

            // Create the ray
            Ray ray = new Ray(new PVector(0, 0, 0), direction);

            // Trace the ray
            MyColor pixelColor = traceRay(ray, 0);

            // Set the pixel color
            pixels[j * width + i] = pixelColor.toInt();
        }
    }
}


// Find Closest Intersection
IntersectionResult findClosestIntersection(Ray ray) {
  float closestT = Float.MAX_VALUE;
  IntersectionResult closestResult = null;

  for (SceneObject obj : sceneObjects) {
    IntersectionResult result = obj.intersect(ray);
    if (result != null && result.t < closestT) {
      closestT = result.t;
      closestResult = result;
    }
  }

  return closestResult;
}

PVector computeReflection(PVector I, PVector N) {
    return PVector.sub(I, PVector.mult(N, 2 * I.dot(N))).normalize();
}

MyColor traceRay(Ray ray, int depth) {
    int maxDepth = 3; //of rays
    if (depth > maxDepth) {
        return backgroundColor;
    }

    IntersectionResult closestResult = findClosestIntersection(ray);

    if (closestResult == null) {
        return backgroundColor;
    }

    MyColor localColor = computeLighting(closestResult, ray);

    Material material = closestResult.object.material;

    // Check if the material is reflective
    if (material.isReflective) {
        // Compute reflection direction
        PVector R = computeReflection(ray.direction, closestResult.normal);

        // Small offset to prevent to fix issues with having self-intersection
        float epsilon = 1e-4;
        PVector reflectionOrigin = PVector.add(closestResult.point, PVector.mult(R, epsilon));

        Ray reflectionRay = new Ray(reflectionOrigin, R);

        // recursively trace the reflection ray
        MyColor reflectionColor = traceRay(reflectionRay, depth + 1);

        // Combine local color with reflection color, this kinda works, not exactly what I expected
        localColor = localColor.mult(1 - material.reflectivity).add(reflectionColor.mult(material.reflectivity));
    }

    return localColor;
}
