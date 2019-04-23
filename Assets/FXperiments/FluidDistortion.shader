﻿Shader "Boring/FluidDistortion"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

		_Brightness("Brightness", Range(0.2, 1.0)) = 0.5
		_TintColour ("TintColour", Color) = (1,1,1,1)

        _Distance   ("Distance", float) = 1 
        _Amplitude ("Amplitude", float) = 1
        _Speed         ("Speed", float) = 1
        _Intensity ("Intensity", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float _Distance ;
            float _Amplitude;
            float _Speed    ;
            float _Intensity;

            v2f vert (appdata v)
            {
                v2f o;

                v.vertex.x += sin(_Time.y * _Speed * v.vertex.y * _Amplitude) * _Distance * _Intensity;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
