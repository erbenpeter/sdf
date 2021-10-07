void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  vec3 rgb = abs(uv.x) + abs(uv.y) < 0.2 ? vec3(0.0) : vec3(0.9);
  fragColor = vec4(rgb, 1.0);
}
