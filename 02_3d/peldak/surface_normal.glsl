vec3 calcNormal(vec3 pos) {
  vec2 eps = vec2(0.0005, 0.0);
  return normalize(vec3(
    map(pos+eps.xyy) - map(pos-eps.xyy),
    map(pos+eps.yxy) - map(pos-eps.yxy),
    map(pos+eps.yyx) - map(pos-eps.yyx)
  ));
}
