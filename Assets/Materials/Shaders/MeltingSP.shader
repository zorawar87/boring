Shader "Unlit/MeltingSP"
{
/*
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

        _MeltY("Melt Y", Float) = 0.0
        _MeltDistance("Melt Distance", Float) = 1.0
        _MeltCurve("Melt Curve", Range(1.0,10.0)) = 2.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert addshadow
        //#pragma vertex vert
        //#pragma fragment frag
        #pragma multi_compile_fog

        #include "UnityCG.cginc"

        struct appdata
        {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
        };

        struct Input
        {
            float2 uv_MainTex;
            float pixelMelt;
            float3 objectSpacePosition;
        };

        struct v2f
        {
            float2 uv : TEXCOORD0;
            UNITY_FOG_COORDS(1)
            float4 vertex : SV_POSITION;
        };

        sampler2D _MainTex;

        half _MeltY;
        half _MeltDistance;
        half _MeltCurve;

        float4 getNewVertPosition( float4 objectSpacePosition, float3 objectSpaceNormal, out float pixelMelt )
        {
            float4 worldSpacePosition =
                    mul( unity_ObjectToWorld, objectSpacePosition );
            float4 worldSpaceNormal =
                    mul( unity_ObjectToWorld, float4(objectSpaceNormal,0) );

            float melt = ( worldSpacePosition.y - _MeltY ) / _MeltDistance;
            melt = 1 - saturate( melt );
            melt = pow( melt, _MeltCurve );

            pixelMelt = melt;

            worldSpacePosition.xz += worldSpaceNormal.xz * melt;

            return mul( unity_WorldToObject, worldSpacePosition );
        }

        v2f vert (inout appdata_full v, out Input o)
        {
            // once you add custom data to Input and have it as a parameter for your custom vert function
            // it is important that you initialiaze all values correctly.
            // fortunately Unity has a function that will do that for us until we want full control
            UNITY_INITIALIZE_OUTPUT(Input, o);

            // create the variable to store the melt value
            float pixelMelt = 0.0;
            float4 vertPosition = getNewVertPosition( v.vertex, v.normal, pixelMelt );

            // set here to pass the variable to the surface shader
            o.pixelMelt = pixelMelt;
            o.objectSpacePosition = vertPosition;

            float4 bitangent = float4( cross( v.normal, v.tangent ), 0 );

            float vertOffset = 0.01;

            // re-use the pixelMelt value, we have already set the value passed to the surface shader so it's ok
            float4 v1 = getNewVertPosition( v.vertex + v.tangent * vertOffset, v.normal, pixelMelt );
            float4 v2 = getNewVertPosition( v.vertex + bitangent * vertOffset, v.normal, pixelMelt );

            float4 newTangent = v1 - vertPosition;
            float4 newBitangent = v2 - vertPosition;
            v.normal = cross( newTangent, newBitangent );

            v.vertex = vertPosition;

        }

        void surf (Input IN, inout SurfaceOutputStandard o) {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // this is the same as our hard line calculation except we will modify the IN value by a sine wave.
            // use the object's vert positions to give it a non uniform offset
            // you can use the vert in world space too but this will cause the wave to 'stay locked' if the object moves

            float wave = sin( IN.objectSpacePosition.x * 4 + IN.objectSpacePosition.z * 5 ) * 0.15;
            float hardMelt = step( 0.5, IN.pixelMelt + wave );
            o.Alpha = c.a;
        }

        ENDCG
    }
    */
}
