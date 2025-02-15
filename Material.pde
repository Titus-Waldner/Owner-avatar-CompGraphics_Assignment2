// Material.pde

class Material {
    MyColor baseColor;
    float kAmbient;
    float kDiffuse;
    float kSpecular;
    float shininess;

    // reflection properties
    boolean isReflective;
    float reflectivity; // Value between 0 and 1

    // Constructor for non_reflective materials i.e base stuff that seems to look nice
    Material(MyColor baseColor) {
        this.baseColor = baseColor;
        this.kAmbient = 0.1;
        this.kDiffuse = 0.7;
        this.kSpecular = 0.2;
        this.shininess = 10;
        this.isReflective = false;
        this.reflectivity = 0.0;
    }

    //constructor for reflective materials
    Material(MyColor baseColor, boolean isReflective, float reflectivity) {
        this(baseColor);
        this.isReflective = isReflective;
        this.reflectivity = reflectivity;
    }
}
