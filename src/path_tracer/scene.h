#pragma once
#include <stdint.h>

struct Vector3 {
  float x, y, z;
  Vector3() : x(0.0f), y(0.0f), z(0.0f) {}
  Vector3(float x, float y, float z) : x(x), y(y), z(z) {}
  Vector3 operator+(const Vector3 &v) const {
    return Vector3(x + v.x, y + v.y, z + v.z);
  }
  Vector3 operator-(const Vector3 &v) const {
    return Vector3(x - v.x, y - v.y, z - v.z);
  }
  Vector3 operator*(float s) const { return Vector3(x * s, y * s, z * s); }
  Vector3 operator*(const Vector3 &v) const {
    return Vector3(x * v.x, y * v.y, z * v.z);
  }
  float dot(const Vector3 &v) const { return x * v.x + y * v.y + z * v.z; }
  Vector3 cross(const Vector3 &v) const {
    return Vector3(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x);
  }
  Vector3 normalize() const {
    float len = __builtin_sqrtf(dot(*this));
    return len > 0.0f ? *this * (1.0f / len) : Vector3(0, 0, 0);
  }
};

struct Vector4 {
  float x, y, z, w;
  Vector4() : x(0), y(0), z(0), w(0) {}
  Vector4(float x, float y, float z, float w) : x(x), y(y), z(z), w(w) {}
  Vector4 &operator+=(const Vector4 &v) {
    x += v.x;
    y += v.y;
    z += v.z;
    w += v.w;
    return *this;
  }
  Vector4 operator*(float s) const {
    return Vector4(x * s, y * s, z * s, w * s);
  }
};

struct Ray {
  Vector3 Origin;
  Vector3 Direction;
};

enum class MaterialType : uint32_t { Diffuse = 0, Specular = 1, Emissive = 2 };

struct Material {
  Vector3 Albedo{0.7f, 0.7f, 0.7f};
  float Roughness = 1.0f;
  Vector3 EmissionColor{0.0f, 0.0f, 0.0f};
  float EmissionPower = 0.0f;
  MaterialType Type = MaterialType::Diffuse;
};

struct Sphere {
  Vector3 Position{0.0f, 0.0f, 0.0f};
  float Radius = 0.5f;
  int materialIndex = 0;
};

struct Scene {
  static const uint32_t MAX_OBJECTS = 32;

  Material Materials[MAX_OBJECTS];
  Sphere Spheres[MAX_OBJECTS];
  uint32_t SphereCount = 0;
  uint32_t MaterialCount = 0;

  void init(uint32_t matCount, uint32_t sphCount) {
    MaterialCount = (matCount > MAX_OBJECTS) ? MAX_OBJECTS : matCount;
    SphereCount = (sphCount > MAX_OBJECTS) ? MAX_OBJECTS : sphCount;
  }
};
