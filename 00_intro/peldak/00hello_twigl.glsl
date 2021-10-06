precision highp float;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;

void main()
{
  vec2 uv = (2.0 * gl_FragCoord.xy - resolution) / resolution.y;
  vec3 rgb = abs(uv.x) + abs(uv.y) < 0.2 ? vec3(0.0) : vec3(0.9);
  gl_FragColor = vec4(rgb, 1.0);
}
