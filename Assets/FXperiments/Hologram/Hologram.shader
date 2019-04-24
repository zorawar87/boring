Shader "Boring/Hologram"
{
	Properties
	{
		_Brightness("Brightness", Range(0.2, 1.0)) = 0.5

		_MainTex ("MainTexture", 2D) = "white" {}
		[HDR]_TintColour ("TintColour", Color) = (1,1,1,1)
        _Transparency ("Transparency", Range(0.25, 1)) = 0.25

		[HDR]_FresnelColour ("Fresnel Colour", Color) = (1,1,1,1)
		_FresnelPower ("Fresnel Power", Range(0.1, 10)) = 5.0
		
		_GlowTiling ("Glow Tiling", Range(0.01, 5.0)) = 1.0
		_GlowSpeed ("Glow Speed", Range(0.0, 20.0)) = 10.0

        _Distance   ("Distance", float) = 1 
        _Speed         ("Speed", float) = 1
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 200
		Blend SrcAlpha OneMinusSrcAlpha
		//Blend One OneMinusSrcAlpha
		ColorMask RGB
        Cull Back
        ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma shader_feature _GLOW_ON
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 worldVertex : TEXCOORD1;
				float3 viewDir : TEXCOORD2;
				float3 worldNormal : NORMAL;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _TintColour;
            float _Transparency;
			float4 _FresnelColour;
			float _FresnelPower;
			float _Brightness;
			float _GlowTiling;
			float _GlowSpeed;

            float _Distance ;
            float _Speed    ;
			
			v2f vert (appdata v)
			{
				v2f o;
				
                v.vertex.y += abs(sin(_Time.y * _Speed)+1)/2 * _Distance;

				o.vertex = UnityObjectToClipPos(v.vertex);
				
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.worldVertex = mul(unity_ObjectToWorld, v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				o.viewDir = normalize(UnityWorldSpaceViewDir(o.worldVertex.xyz));

				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 colour = tex2D(_MainTex, i.uv) + _TintColour;

				float glow = 0.0;
                glow = frac(i.worldVertex.y * _GlowTiling - _Time.x * _GlowSpeed);

				float fresnel = 1.0-saturate(dot(i.viewDir, i.worldNormal));
				fixed4 fresnelColour = _FresnelColour * pow (fresnel, _FresnelPower);

				fixed4 col = colour * _TintColour + (glow * 0.35 * _TintColour) + fresnelColour;
				colour.a = colour.a * _Transparency * (fresnel + glow);
				col.rgb *= _Brightness;

				return colour;
			}
			ENDCG
		}
	}
}
