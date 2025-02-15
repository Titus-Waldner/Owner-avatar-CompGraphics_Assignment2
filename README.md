Assignment 2 - Ray Tracing
Overview

This project implements a basic ray tracer from scratch using Processing 4.3. The program renders 3D objects by casting rays from the eye through each pixel, determining intersections with objects in the scene, and applying the Phong lighting model. The implementation includes surface intersection calculations, normal vector computations, and additional visual effects.

![image](https://github.com/user-attachments/assets/a24e4a7f-bc6b-46ac-83e8-77dcc6be5288)


Features Implemented
Ray Generation and Intersection Calculations

    Constructed rays for each pixel originating from the eye.
    Calculated intersections between rays and scene objects.
    Identified the closest intersection point to determine the final pixel color.

Rendering Basic Surfaces

    Implemented sphere-ray intersection using the standard quadratic formula.
    Implemented plane-ray intersection based on normal vector calculations.
    Added two additional shapes for extended rendering capabilities.

Phong Lighting Model

    Applied ambient, diffuse, and specular lighting based on surface normals.
    Used a single light source positioned above and behind the eye.

Visual Effects

    Implemented at least two advanced ray tracing effects:
        Shadows: Determined whether a point is occluded from the light source.
        Reflections: Allowed certain surfaces to reflect rays for mirror-like rendering.

Code Structure and Optimization

    Used object-oriented design with shape classes inheriting from a base class.
    Implemented separate classes for rays, intersection results, and scene objects.
    Separated code into multiple files for maintainability.

Usage

To run the project, open the .pde files in Processing 4.3 and execute the main script. The program renders the scene only when changes occur, avoiding unnecessary redraws.
Submission

All required .pde files are included. The implementation follows structured and modular design principles. The written component contains derivations for ray-surface intersections and normal vector calculations.
