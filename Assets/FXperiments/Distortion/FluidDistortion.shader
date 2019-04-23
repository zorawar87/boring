Shader "Boring/FluidDistortion"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

		_Brightness("Brightness", Range(0.2, 5.0)) = 3.5
        _TintEnable ("Should Tint - 0 or 1", Float) = 1
		_TintColour ("TintColour", Color) = (1,1,1,1)

        _Distance   ("Distance", Range(0.0,10.0)) = 1 
        _Amplitude ("Amplitude", Range(0.0,10.0)) = 1
        _Speed         ("Speed", Range(0.0,10.0)) = 1
        _Intensity ("Intensity", Range(0.0,10.0)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 150

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

            float _TintEnable;
            float4 _TintColour;
            float _Brightness;
            float _Distance ;
            float _Amplitude;
            float _Speed    ;
            float _Intensity;

            v2f vert (appdata v)
            {
                v2f o;

                v.vertex.x += sin(_Time.y * (v.vertex.x * v.vertex.y * v.vertex.z) * _Amplitude);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 colour = tex2D(_MainTex, i.uv) + (_TintEnable*_TintColour);
                colour.rgb *= _Brightness;
                return colour;
            }
            ENDCG
        }
    }
}
