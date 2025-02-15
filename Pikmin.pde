// Pikmin.pde

// This is a really just a whole bunch of spheres in one composite object to keep all the parts to make a pikmin!

CompositeObject createPikmin(PVector position, float scale, MyColor pikminColor) {
    CompositeObject pikmin = new CompositeObject(null); // Material is set per component

    //  materials
    Material headMaterial = new Material(pikminColor);
    Material bodyMaterial = new Material(pikminColor);
    Material limbMaterial = new Material(pikminColor);
    Material antennaMaterial = new Material(new MyColor(0, 255, 0));   // Green
    Material eyeWhiteMaterial = new Material(new MyColor(255, 255, 255)); // White
    Material eyePupilMaterial = new Material(new MyColor(0, 0, 0));       // Black

    // Head
    Sphere head = new Sphere(PVector.add(position, new PVector(0, scale * 2.5, 0)), scale * 1.0, headMaterial);
    pikmin.addComponent(head);
    
    // Eyes
    addEyes(pikmin, head.center, scale, eyeWhiteMaterial, eyePupilMaterial);
    // Body
    Sphere body = new Sphere(PVector.add(position, new PVector(0, scale * 1.0, 0)), scale * 0.8, bodyMaterial);
    pikmin.addComponent(body);

    // Limbs
    // Left Arm
    addLimb(pikmin,
        PVector.add(position, new PVector(-scale * 0.8, scale * 1.5, 0)),
        PVector.add(position, new PVector(-scale * 1.2, scale * 0.5, 0)),
        scale * 0.2,
        limbMaterial);

    // Right Arm
    addLimb(pikmin,
        PVector.add(position, new PVector(scale * 0.8, scale * 1.5, 0)),
        PVector.add(position, new PVector(scale * 1.2, scale * 0.5, 0)),
        scale * 0.2,
        limbMaterial);

    // Left Leg
    addLimb(pikmin,
        PVector.add(position, new PVector(-scale * 0.3, scale * 0.2, 0)),
        PVector.add(position, new PVector(-scale * 0.3, -scale * 0.8, 0)),
        scale * 0.2,
        limbMaterial);

    // Right Leg
    addLimb(pikmin,
        PVector.add(position, new PVector(scale * 0.3, scale * 0.2, 0)),
        PVector.add(position, new PVector(scale * 0.3, -scale * 0.8, 0)),
        scale * 0.2,
        limbMaterial);

    // Antenna
    addLimb(pikmin,
        PVector.add(position, new PVector(0, scale * 3.5, 0)),
        PVector.add(position, new PVector(0, scale * 5.0, 0)),
        scale * 0.1,
        antennaMaterial);

    // Leaf
    Sphere leaf = new Sphere(PVector.add(position, new PVector(0, scale * 5.3, 0)), scale * 0.3, antennaMaterial);
    pikmin.addComponent(leaf);

    return pikmin;
}

void addLimb(CompositeObject pikmin, PVector start, PVector end, float radius, Material material) {
    int segments = 5;
    PVector direction = PVector.sub(end, start);
    float segmentLength = direction.mag() / segments;
    direction.normalize();

    for (int i = 0; i <= segments; i++) {
        PVector position = PVector.add(start, PVector.mult(direction, i * segmentLength));
        Sphere limbSegment = new Sphere(position, radius, material);
        pikmin.addComponent(limbSegment);
    }
}

void addEyes(CompositeObject pikmin, PVector headCenter, float scale, Material scleraMaterial, Material pupilMaterial) {
    // Eye parameters
    float eyeOffsetY = scale * 0.2; // Vertical offset from head center
    float eyeOffsetX = scale * 0.5; // Horizontal offset from head center
    float eyeRadius = scale * 0.25; // Radius of the sclera
    float pupilRadius = eyeRadius * 0.5; // Radius of the pupil
    float eyeProtrusion = scale * 0.4; // How much the eye pops out of from the head

    // Left Eye Position
    PVector leftEyeCenter = new PVector(
        headCenter.x - eyeOffsetX,
        headCenter.y + eyeOffsetY,
        headCenter.z - scale * 0.9 
    );

    // Right Eye Position
    PVector rightEyeCenter = new PVector(
        headCenter.x + eyeOffsetX,
        headCenter.y + eyeOffsetY,
        headCenter.z - scale * 0.9
    );
    
    //Today I learnt that the white part is called the Sclera! You learn something everyday :)

    // Add Left Eye (Sclera)
    Sphere leftEyeSclera = new Sphere(leftEyeCenter, eyeRadius, scleraMaterial);
    pikmin.addComponent(leftEyeSclera);

    // Add Left Pupil
    PVector leftPupilCenter = PVector.sub(leftEyeCenter, new PVector(0, 0, eyeProtrusion));
    Sphere leftPupil = new Sphere(leftPupilCenter, pupilRadius, pupilMaterial);
    pikmin.addComponent(leftPupil);

    // Add Right Eye (Sclera)
    Sphere rightEyeSclera = new Sphere(rightEyeCenter, eyeRadius, scleraMaterial);
    pikmin.addComponent(rightEyeSclera);

    // Add Right Pupil
    PVector rightPupilCenter = PVector.sub(rightEyeCenter, new PVector(0, 0, eyeProtrusion));
    Sphere rightPupil = new Sphere(rightPupilCenter, pupilRadius, pupilMaterial);
    pikmin.addComponent(rightPupil);
}
