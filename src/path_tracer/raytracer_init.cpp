#include "Renderer.h"
#include "camera.h"
#include "scene.h"

extern "C" {
void enable_fpu(void);
void uart_puts(const char *s);
uint32_t *ramfb_get_buffer(void);
void start_raytracer(void);
}

void start_raytracer(void) {
  enable_fpu();
  uart_puts("\nEngine Online. Booting Tracer...\n");

  uint32_t *framebuffer = ramfb_get_buffer();
  static Scene worldScene;
  static Camera mainCamera(-45.0f);
  static Renderer tracer;
  static bool initialized = false;
  if (!initialized) {
    worldScene.init(6, 6);

    mainCamera.OnResize(1080, 720);
    tracer.Init(1080, 720);

    worldScene.Materials[0].Albedo = Vector3(0.15f, 0.25f, 0.85f);
    worldScene.Materials[0].Type = MaterialType::Diffuse;

    worldScene.Materials[1].Albedo = Vector3(1.0f, 0.15f, 0.65f);
    worldScene.Materials[1].Type = MaterialType::Diffuse;

    worldScene.Materials[2].Albedo = Vector3(0.9f, 0.9f, 0.9f);
    worldScene.Materials[2].Roughness = 0.01f;
    worldScene.Materials[2].Type = MaterialType::Specular;

    worldScene.Materials[3].Albedo = Vector3(1.0f, 0.7f, 0.3f);
    worldScene.Materials[3].Roughness = 0.2f;
    worldScene.Materials[3].Type = MaterialType::Specular;

    worldScene.Materials[4].EmissionColor = Vector3(1.0f, 1.0f, 1.0f);
    worldScene.Materials[4].EmissionPower = 5.0f;
    worldScene.Materials[4].Type = MaterialType::Emissive;

    worldScene.Materials[5].EmissionColor = Vector3(1.0f, 0.4f, 0.0f);
    worldScene.Materials[5].EmissionPower = 10.0f;
    worldScene.Materials[5].Type = MaterialType::Emissive;

    worldScene.Spheres[0].Position = Vector3(0.0f, -100.75f, -3.0f);
    worldScene.Spheres[0].Radius = 100.0f;
    worldScene.Spheres[0].materialIndex = 0;

    worldScene.Spheres[1].Position = Vector3(0.0f, 0.0f, -3.0f);
    worldScene.Spheres[1].Radius = 0.75f;
    worldScene.Spheres[1].materialIndex = 1;

    worldScene.Spheres[2].Position = Vector3(1.6f, 0.0f, -3.0f);
    worldScene.Spheres[2].Radius = 0.75f;
    worldScene.Spheres[2].materialIndex = 2;

    worldScene.Spheres[3].Position = Vector3(-1.6f, 0.0f, -3.0f);
    worldScene.Spheres[3].Radius = 0.75f;
    worldScene.Spheres[3].materialIndex = 3;

    worldScene.Spheres[4].Position = Vector3(0.0f, 10.0f, -3.0f);
    worldScene.Spheres[4].Radius = 3.0f;
    worldScene.Spheres[4].materialIndex = 4;

    worldScene.Spheres[5].Position = Vector3(0.0f, 1.2f, -1.5f);
    worldScene.Spheres[5].Radius = 0.2f;
    worldScene.Spheres[5].materialIndex = 5;

    initialized = true;
  }

  uart_puts("Executing Progressive 1080x720 Pass...\n");
  tracer.render(mainCamera, worldScene, framebuffer);
  uart_puts("Render Pass Complete!\n");
}
