mat3 camera(vec3 lookAt, vec3 ro)
{
  vec3 cz = normalize(lookAt - ro);
  vec3 cx = normalize(cross(cz, vec3(0., 1., 0.)));
  vec3 cy = normalize(cross(cx, cz));  
  return mat3(cx, cy, cz);
}
