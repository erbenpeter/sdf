// Képpont és egér pozíció normalizálása
vec2 uv = (2.0 * fragCoord - iResolution.xy)/iResolution.y;
float mouseX = (2.0 * iMouse.x - iResolution.x)/iResolution.y;
float ang = -1.2 * mouseX; // forgásszög skálázása, kép szerint irányítva

// (0., 1.3, 0.) körül forog a kamera vízszintesen
vec3 ro = vec3(0.0 + 2. * sin(ang), 1.3, 2. * cos(ang));
  
vec3 lookAt = vec3(0.); // origó felé nézünk
float focD = 0.9; // "fókusz távolság"

// elforgatott sugár a sétához
vec3 rd = camera(lookAt, ro) * normalize(vec3(uv, -focD));
