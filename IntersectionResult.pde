// IntersectionResult.pde

class IntersectionResult {
    float t;
    PVector point;
    PVector normal;
    SceneObject object;

    IntersectionResult(float t, PVector point, PVector normal, SceneObject object) {
        this.t = t;
        this.point = point;
        this.normal = normal;
        this.object = object;
    }
}
