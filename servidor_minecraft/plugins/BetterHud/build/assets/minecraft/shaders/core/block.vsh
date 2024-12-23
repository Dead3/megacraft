
#version 150
#moj_import <light.glsl>
#moj_import <fog.glsl>
in vec3 Position;in vec4 Color;in vec2 UV0;in ivec2 UV1;in ivec2 UV2;in vec3 Normal;uniform sampler2D Sampler1;uniform sampler2D Sampler2;uniform mat4 ModelViewMat;uniform mat4 ProjMat;uniform int FogShape;uniform vec3 Light0_Direction;uniform vec3 Light1_Direction;uniform vec2 ScreenSize;uniform vec3 ChunkOffset;out float vertexDistance;out vec4 vertexColor;out vec4 lightMapColor;out vec4 overlayColor;out vec2 texCoord0;out vec4 normal;
#define HEIGHT_BIT 13
#define MAX_BIT 10
#define ADD_OFFSET 4095
#define DEFAULT_OFFSET 10
float getDistance(mat4 modelViewMat, vec3 pos, int shape) {if (shape == 0) {return length((modelViewMat * vec4(pos, 1.0)).xyz);} else {float distXZ = length((modelViewMat * vec4(pos.x, 0.0, pos.z, 1.0)).xyz);float distY = length((modelViewMat * vec4(0.0, pos.y, 0.0, 1.0)).xyz);return max(distXZ, distY);}}void main() {vec3 pos = Position;gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);vertexDistance = getDistance(ModelViewMat, pos, FogShape);vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);overlayColor = texelFetch(Sampler1, UV1, 0);texCoord0 = UV0;normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);}