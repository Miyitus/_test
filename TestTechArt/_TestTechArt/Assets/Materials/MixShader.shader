Shader "MixShader"
{
    Properties
    {
        _Texture1("Texture1", 2D) = "white" {}
        _Color1("Color1", Color) = (1,1,1,1)

        _Texture2("Texture2", 2D) = "white" {}
        _Color2("Color2", Color) = (1,1,1,1)
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
            // make fog work
            #pragma multi_compile_fog

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

            sampler2D _Texture1;
            float4 _Texture1_ST;
            float4 _Color1;
            float4 _Color2;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _Texture1);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture1
                fixed4 col = tex2D(_Texture1, i.uv);
                
                col *= _Color1;

                // sample the texture1
                fixed3 col2 = tex2D(_Texture2, i.uv);

                col2 *= _Color2;

                // mix both colors
                col.rgb = lerp(col.rgb, col2.rgb, col2.a);
                //col.rgb += col2.rgb;

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
