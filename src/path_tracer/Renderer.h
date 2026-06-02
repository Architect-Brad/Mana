#pragma once
#include "camera.h"
#include "scene.h"
#include <stdint.h>

class Renderer {
public:
  Renderer() = default;

  void Init(uint32_t width, uint32_t height);
  void render(const Camera &camera, const Scene &scene, uint32_t *framebuffer);

private:
  struct HitPayload {
    float HitDistance;
    Vector3 WorldPosition;
    Vector3 WorldNormal;
    int objectIndex;
  };

  Vector4 perPixel(uint32_t x, uint32_t y);
  HitPayload TraceRay(const Ray &ray);
  HitPayload ClosestHit(const Ray &ray, float hitDistance, int objectIndex);
  HitPayload Miss(const Ray &ray);
  float GetRandomFloat();

private:
  uint32_t m_Width = 0;
  uint32_t m_Height = 0;

  const Scene *m_ActiveScene = nullptr;
  const Camera *m_ActiveCamera = nullptr;

  uint32_t m_RngState = 0x1337C0DE;
};
