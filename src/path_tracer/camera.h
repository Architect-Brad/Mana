#pragma once
#include "scene.h"

extern "C" float tanf(float x);

class Camera {
public:
  Vector3 m_Position;
  Vector3 m_ForwardDirection;
  float m_VerticalFOV;
  uint32_t m_ViewportWidth = 0;
  uint32_t m_ViewportHeight = 0;
  Vector3 lowerLeftCorner;
  Vector3 horizontal;
  Vector3 vertical;

  Camera(float verticalFOV)
      : m_VerticalFOV(verticalFOV), m_Position(Vector3(0, 0, 6)),
        m_ForwardDirection(Vector3(0, 0, -1)) {}

  void OnResize(uint32_t width, uint32_t height) {
    if (width == m_ViewportWidth && height == m_ViewportHeight)
      return;
    m_ViewportWidth = width;
    m_ViewportHeight = height;

    float aspect = (float)m_ViewportWidth / (float)m_ViewportHeight;
    float theta = m_VerticalFOV * 3.14159265f / 180.0f;
    float h = tanf(theta / 2.0f);

    float viewportHeight = 2.0f * h;
    float viewportWidth = aspect * viewportHeight;

    Vector3 upWorld(0.0f, 1.0f, 0.0f);
    Vector3 right = m_ForwardDirection.cross(upWorld).normalize();
    Vector3 trueUp = right.cross(m_ForwardDirection).normalize();

    horizontal = right * viewportWidth;
    vertical = trueUp * viewportHeight;
    lowerLeftCorner =
        m_Position - horizontal * 0.5f - vertical * 0.5f + m_ForwardDirection;
  }

  Ray GetRay(float screenX, float screenY) const {
    float u = screenX / (float)m_ViewportWidth;
    float v = 1.0 - (screenY / (float)m_ViewportHeight);
    Vector3 rayDir =
        (lowerLeftCorner + horizontal * u + vertical * v - m_Position)
            .normalize();
    return Ray{m_Position, rayDir};
  }
};
