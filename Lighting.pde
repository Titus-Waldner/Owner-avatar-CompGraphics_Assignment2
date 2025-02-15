// Lighting.pde




//     Praise the Sun!
//          \o/             ☼
//           |                     
//          / \                   
//

PVector lightPosition = new PVector(-30, 20, -10); //left of Scene light is
MyColor lightColor = new MyColor(255, 255, 255); //white

MyColor computeLighting(IntersectionResult result, Ray ray) {
    Material material = result.object.material;
    PVector P = result.point;
    PVector N = result.normal;

    // Light vector
    PVector L = PVector.sub(lightPosition, P).normalize();

    // View vector
    PVector V = PVector.sub(ray.origin, P).normalize();

    // Reflection vector
    float NdotL = N.dot(L);
    PVector R = PVector.sub(PVector.mult(N, 2 * NdotL), L).normalize();

    // Ambient component
    MyColor ambient = material.baseColor.mult(material.kAmbient);

    // **Shadow Check**
    boolean inShadow = isInShadow(P, lightPosition);

    // If in shadow, only apply ambient lighting i.e clamp and return it!
    if (inShadow) {
        return ambient;
    }

    // diffuse part
    float diff = max(NdotL, 0);
    MyColor diffuse = material.baseColor.mult(material.kDiffuse * diff);

    // Specular part
    float spec = 0;
    if (diff > 0) {
        float RdotV = max(R.dot(V), 0);
        spec = pow(RdotV, material.shininess);
    }
    MyColor specular = lightColor.mult(material.kSpecular * spec);

    // Sum components
    MyColor finalColor = ambient.add(diffuse).add(specular);


    return finalColor;
}

boolean isInShadow(PVector P, PVector lightPos) {
    // Direction from point to light
    PVector L = PVector.sub(lightPos, P);
    float lightDistance = L.mag();
    L.normalize();

    // Small offset to prevent self-intersection (epsilon)
    float epsilon = 1e-2;
    PVector shadowRayOrigin = PVector.add(P, PVector.mult(L, epsilon));

    Ray shadowRay = new Ray(shadowRayOrigin, L);

    // Check for intersections with all objects
    for (SceneObject obj : sceneObjects) {
        IntersectionResult result = obj.intersect(shadowRay);
        if (result != null && result.t < lightDistance) 
        {
            return true;
        }
    }

    // No obstruction found!!!
    return false;
}
