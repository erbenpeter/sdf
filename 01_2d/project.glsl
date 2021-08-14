const float PI = 3.14159265359;


float sdCircle(in vec2 position, in vec2 center, in float radius)
{
  return length(position - center) - radius;
}

vec2 rotate(in vec2 position, in float angle)
{
  mat2 rotM = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
  return position * rotM;
}

float sdBox(in vec2 position, in vec2 size, in float angle)
{
  vec2 rotPos = rotate(position, angle);
  vec2 d = abs(rotPos) - size;
  return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

vec2 transform(in vec2 position)
{
  float scaling = 3.0;
  float repeatWindow = 0.56;
  return mod(position * scaling, repeatWindow)- repeatWindow / 2.0;
}


float sdScene(in vec2 position, in float time)
{
  position = transform(position);
   
  float doc = sdCircle(position, vec2(0.0, 0.0), 0.21);
  float dic = sdCircle(position, vec2(0.0, 0.0), 0.1);
  
  float animAngle = time;
  float db1 = sdBox(position, vec2(0.05, 0.26), animAngle + 0.0);
  float db2 = sdBox(position, vec2(0.05, 0.26), animAngle + PI / 4.0);
  float db3 = sdBox(position, vec2(0.05, 0.26), animAngle + 2.0 * PI / 4.0);
  float db4 = sdBox(position, vec2(0.05, 0.26), animAngle + 3.0 * PI / 4.0);
  
  float db = min(db1, min(db2, min(db3, db4)));
  float comp = min(doc, db);    
  float d = max(-dic, comp);
    
  return d;
}

vec4 color(in float dist)
{
  float c = dist > 0.0 ? 1.0 : 0.0;
  return vec4(vec3(c),1.0);
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - iResolution.xy*0.5) / iResolution.y;
    float d = sdScene(uv, iTime);
    fragColor = color(d);
}
