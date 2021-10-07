mat3 camera(vec3 lookAt, vec3 ro)
{
  vec3 up = vec3(0., 1., 0.);
  vec3 cd = normalize(ro - lookAt);   // kamera iránya
  vec3 cr = normalize(cross(up, cd)); // kamera jobb
  vec3 cu = normalize(cross(cd, cr)); // kamera fel 
  return mat3(cr, cu, cd);            // mátrix térbeli forgatáshoz
}
