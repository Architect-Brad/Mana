#include "Renderer.h"
#include "uart.h"

extern "C" void clean_cache_provider(void *address, uint32_t size);
extern "C" {
void uart_printf(const char *string, ...);
}

void Renderer::Init(uint32_t width, uint32_t height) {
  m_Width = width;
  m_Height = height;
}

float Renderer::GetRandomFloat() {
  m_RngState ^= m_RngState << 13;
  m_RngState ^= m_RngState >> 17;
  m_RngState ^= m_RngState << 5;
  return (float)(m_RngState & 0xFFFF) / 65536.0f;
}

void Renderer::render(const Camera &camera, const Scene &scene,
                      uint32_t *framebuffer) {
  m_ActiveCamera = &camera;
  m_ActiveScene = &scene;

  const int samplesPerPixel = 128;

  for (uint32_t y = 0; y < m_Height; y++) {
    uart_printf("Rendering Row %d / %d...\n", y + 1, m_Height);

    for (uint32_t x = 0; x < m_Width; x++) {
      Vector4 totalColor(0.0f, 0.0f, 0.0f, 0.0f);

      for (int s = 0; s < samplesPerPixel; s++) {
        totalColor += perPixel(x, y);
      }

      Vector4 finalColor = totalColor * (1.0f / (float)samplesPerPixel);

      // Clamp bounds
      if (finalColor.x > 1.0f)
        finalColor.x = 1.0f;
      if (finalColor.y > 1.0f)
        finalColor.y = 1.0f;
      if (finalColor.z > 1.0f)
        finalColor.z = 1.0f;
      if (finalColor.x < 0.0f)
        finalColor.x = 0.0f;
      if (finalColor.y < 0.0f)
        finalColor.y = 0.0f;
      if (finalColor.z < 0.0f)
        finalColor.z = 0.0f;

      uint8_t r = (uint8_t)(finalColor.x * 255.0f);
      uint8_t g = (uint8_t)(finalColor.y * 255.0f);
      uint8_t b = (uint8_t)(finalColor.z * 255.0f);

      framebuffer[x + y * m_Width] = (255 << 24) | (b << 16) | (g << 8) | r;
    }

    clean_cache_provider(&framebuffer[y * m_Width], m_Width * sizeof(uint32_t));
  }
}

Vector4 Renderer::perPixel(uint32_t x, uint32_t y) {
  float u = (float)x + GetRandomFloat();
  float v =
      (float)(m_Height - 1 - y) + GetRandomFloat(); // Fixed Inversion here

  Ray ray = m_ActiveCamera->GetRay(u, v);
  Vector3 color(0.0f, 0.0f, 0.0f);
  Vector3 throughput(1.0f, 1.0f, 1.0f);

  const int maxBounces = 4;
  for (int i = 0; i < maxBounces; i++) {
    HitPayload payload = TraceRay(ray);

    if (payload.HitDistance < 0.0f) {
      Vector3 skyColor = Miss(ray).WorldPosition;
      color = color + skyColor * throughput;
      break;
    }

    const Sphere &sphere = m_ActiveScene->Spheres[payload.objectIndex];
    const Material &material = m_ActiveScene->Materials[sphere.materialIndex];

    if (material.Type == MaterialType::Emissive) {
      color = color +
              (material.EmissionColor * material.EmissionPower * throughput);
      break;
    }

    Vector3 lightDir = Vector3(-1.0f, -1.0f, -1.0f).normalize();
    float lightIntensity = payload.WorldNormal.dot(lightDir * -1.0f);
    if (lightIntensity < 0.0f)
      lightIntensity = 0.0f;

    Vector3 illumination = material.Albedo * lightIntensity;
    color = color + illumination * throughput;
    throughput = throughput * material.Albedo * 0.7f;

    if (throughput.dot(throughput) < 0.001f)
      break;

    ray.Origin = payload.WorldPosition + payload.WorldNormal * 0.0001f;

    Vector3 randomFuzz(GetRandomFloat() - 0.5f, GetRandomFloat() - 0.5f,
                       GetRandomFloat() - 0.5f);

    // Specular vs Diffuse Bounce
    if (material.Type == MaterialType::Specular) {
      Vector3 reflectDir =
          ray.Direction -
          payload.WorldNormal * 2.0f * ray.Direction.dot(payload.WorldNormal);
      ray.Direction =
          (reflectDir + randomFuzz * material.Roughness).normalize();
    } else {
      ray.Direction =
          (payload.WorldNormal + randomFuzz.normalize()).normalize();
    }
  }

  return Vector4(color.x, color.y, color.z, 1.0f);
}

Renderer::HitPayload Renderer::TraceRay(const Ray &ray) {
  int closestObjectIndex = -1;
  float hitDistance = 999999.0f;

  for (uint32_t i = 0; i < m_ActiveScene->SphereCount; i++) {
    const Sphere &sphere = m_ActiveScene->Spheres[i];
    Vector3 origin = ray.Origin - sphere.Position;

    float a = ray.Direction.dot(ray.Direction);
    float b = 2.0f * origin.dot(ray.Direction);
    float c = origin.dot(origin) - sphere.Radius * sphere.Radius;

    float discriminant = b * b - 4.0f * a * c;
    if (discriminant < 0.0f)
      continue;

    float t = (-b - __builtin_sqrtf(discriminant)) / (2.0f * a);
    if (t > 0.001f && t < hitDistance) {
      hitDistance = t;
      closestObjectIndex = (int)i;
    }
  }

  if (closestObjectIndex < 0)
    return Miss(ray);
  return ClosestHit(ray, hitDistance, closestObjectIndex);
}

Renderer::HitPayload Renderer::ClosestHit(const Ray &ray, float hitDistance,
                                          int objectIndex) {
  Renderer::HitPayload payload;
  payload.HitDistance = hitDistance;
  payload.objectIndex = objectIndex;

  const Sphere &sphere = m_ActiveScene->Spheres[objectIndex];
  payload.WorldPosition = ray.Origin + ray.Direction * hitDistance;
  payload.WorldNormal = (payload.WorldPosition - sphere.Position).normalize();
  return payload;
}

Renderer::HitPayload Renderer::Miss(const Ray &ray) {
  Renderer::HitPayload payload;
  payload.HitDistance = -1.0f;
  float t = 0.5f * (ray.Direction.normalize().y + 1.0f);
  payload.WorldPosition =
      Vector3(1.0f, 1.0f, 1.0f) * (1.0f - t) + Vector3(0.5f, 0.7f, 1.0f) * t;
  return payload;
}
