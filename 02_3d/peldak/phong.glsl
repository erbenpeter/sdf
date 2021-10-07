vec3 phong(float d, vec3 ro, vec3 rd)
{
  vec3 lightColor = vec3(.8);
  vec3 lightPos = vec3(-5.0, 8.0, -4.0);
  vec3 ambLightColor = vec3(.7, .7, .1);
  
  vec3 col = 0.15 * ambLightColor; // ambient
  
  vec3 pos = ro + d * rd;
  vec3 lightDir = normalize(lightPos - pos);
  vec3 nv = calcNormal(pos); // surface normal
  
  col += lightColor * clamp(dot(lightDir, nv), 0., 1.); // diffuse
  
  vec3 eye = normalize(ro - pos);
  vec3 h = normalize(eye + lightDir);
  col += lightColor * pow(clamp(dot(h, nv), 0., 1.), 60.); // specular (with half-vector)
  
  return pow(col, vec3(1. / 2.2)); // gamma correction
}
