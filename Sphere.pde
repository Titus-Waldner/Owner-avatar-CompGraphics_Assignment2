// Sphere.pde

class Sphere extends SceneObject {
    PVector center;
    float radius;

    Sphere(PVector center, float radius, Material material) {
        super(material);
        this.center = center;
        this.radius = radius;
    }

    @Override
    IntersectionResult intersect(Ray ray) {
        // Ray-sphere intersection logic
        PVector oc = PVector.sub(ray.origin, center);
        float a = ray.direction.dot(ray.direction);
        float b = 2 * oc.dot(ray.direction);
        float c = oc.dot(oc) - radius * radius;
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

            PVector point = PVector.add(ray.origin, PVector.mult(ray.direction, t));
            PVector normal = PVector.sub(point, center).normalize();
            return new IntersectionResult(t, point, normal, this);
        }
    }
}
