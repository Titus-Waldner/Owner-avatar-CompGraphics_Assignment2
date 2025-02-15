// Cylinder.pde

class Cylinder extends SceneObject {
    PVector center; // Center position along the y-axis
    float radius;

    Cylinder(PVector center, float radius, Material material) {
        super(material);
        this.center = center;
        this.radius = radius;
    }

    @Override
    IntersectionResult intersect(Ray ray) {
        // Cylinder aligned along y-axis
        float dx = ray.direction.x;
        float dz = ray.direction.z;
        float ox = ray.origin.x - center.x;
        float oz = ray.origin.z - center.z;

        float a = dx * dx + dz * dz;
        float b = 2 * (ox * dx + oz * dz);
        float c = ox * ox + oz * oz - radius * radius;

        float discriminant = b * b - 4 * a * c;

        if (discriminant < 0) {
            return null;
        } else {
            float sqrtDisc = sqrt(discriminant);
            float t1 = (-b - sqrtDisc) / (2 * a);
            float t2 = (-b + sqrtDisc) / (2 * a);
            float t = Float.MAX_VALUE;

            if (t1 > 0 && t1 < t) {
                t = t1;
            }
            if (t2 > 0 && t2 < t) {
                t = t2;
            }
            if (t == Float.MAX_VALUE) {
                return null;
            }

            // Intersection point
            PVector intersectionPoint = PVector.add(ray.origin, PVector.mult(ray.direction, t));

            // For an infinite cylinder, we don't check y-bounds because IT'S INNNNNNNFINTE
            // Normal vector at the intersection point
            PVector normal = new PVector(intersectionPoint.x - center.x, 0, intersectionPoint.z - center.z).normalize();

            return new IntersectionResult(t, intersectionPoint, normal, this);
        }
    }
}
