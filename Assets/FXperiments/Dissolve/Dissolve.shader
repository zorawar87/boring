Shader "Boring/Dissolve"
{
    Properties {
        _TintColour ("Tint", Color) = (0, 0, 0, 1)
        _MainTex ("Albedo Texture", 2D) = "white" {}
        _Smoothness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallicity", Range(0, 1)) = 0

        _DissolveThreshold ("Dissolve Threshold", Range(0,1)) = 0.2
        _DissolveTex ("Dissolve Texture", 2D) = "black" {}
        _DissolveAmount ("Dissolve Amount", Range(0, 0.6)) = 0

        [HDR] _GlowColor("Glow Color", Color) = (1, 1, 1, 1)
        _GlowRange("Glow Width/Range", Range(0, .3)) = 0.1
    }
    SubShader {
        Tags{ "RenderType"="Opaque" "Queue"="Geometry"}
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard noshadow
        #pragma target 3.0

        sampler2D _MainTex;
        fixed4 _TintColour;

        half _Smoothness;
        half _Metallic;

        float _DissolveThreshold;
        sampler2D _DissolveTex;
        float _DissolveAmount;

        float3 _GlowColor;
        float _GlowRange;

        struct Input {
            float2 uv_MainTex;
            float2 uv_DissolveTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o) {
            fixed4 colour = tex2D(_MainTex, IN.uv_MainTex) + _TintColour;

            float dissolve = tex2D(_DissolveTex, IN.uv_DissolveTex).r * _DissolveThreshold;
            float isVisible = dissolve - _DissolveAmount;
            float glowIntensity = smoothstep(_GlowRange, 0, isVisible);

            clip(isVisible);
            o.Albedo = colour.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
            o.Emission = _GlowColor * glowIntensity;
            o.Alpha = colour.a;
        }
        ENDCG
    }
}
