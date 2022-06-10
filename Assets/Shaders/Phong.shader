Shader "Blinn-Phong"
{
	Properties{
		_MaterialColor("MaterialColor",Color) = (1,1,1,1)
		_SpecularStrength("Specular",Range(0.0,5.0)) = 1.0
		_Gloss("Gloss",Range(1.0,255)) = 20
		_MainTex("Main Texture",2D) = "white"{}
	}
	SubShader{
		Pass{
			Tags{ "LightingType" = "ForwardBase" }
			LOD 200

		CGPROGRAM

		#include "Lighting.cginc"

		#pragma vertex vertexShader
		#pragma fragment fragmentShader

		fixed4 _MaterialColor;
		float _SpecularStrength;
		float _Gloss;
		sampler2D _MainTex;

		float4 _MainTex_ST;

		struct vertexShaderInput {
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
		};

		struct vertexShaderOutput {
			float4 pos : SV_POSITION;
			float3 worldNormal : NORMAL;
			float3 viewDir : TEXCOORD0;
			float2 uv : TECOORD1;
		};

		vertexShaderOutput vertexShader(vertexShaderInput v) {
			vertexShaderOutput o;

			o.pos = UnityObjectToClipPos(v.vertex);

			o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);

			float worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

			o.viewDir = _WorldSpaceCameraPos - worldPos;

			o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

			return o;
		}

		fixed4 fragmentShader(vertexShaderOutput i) : SV_Target{

			fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

		fixed3 worldNormal = normalize(i.worldNormal);

		fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

		fixed3 lambert = 0.5 * dot(worldNormal, worldLightDir) + 0.5;

		fixed3 diffuse = lambert * _LightColor0.xyz;

		fixed3 viewDir = normalize(i.viewDir);
		fixed3 halfDir = normalize(worldLightDir + viewDir);

		fixed3 specular = _LightColor0.rgb * _SpecularStrength * pow(max(0.0, dot(halfDir, worldNormal)), _Gloss);

		fixed4 tex = tex2D(_MainTex, i.uv);

		fixed3 color = (ambient * _MaterialColor.rgb + diffuse * _MaterialColor.rgb + specular * _MaterialColor.rgb * tex.a) * tex.rgb;

		return fixed4(color, 1.0);

	}

	ENDCG
	}
	}
	FallBack "Diffuse"
}
