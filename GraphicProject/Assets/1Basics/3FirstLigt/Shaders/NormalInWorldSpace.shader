Shader "Custom/FirstLight/NormalInWorldSpace"
{
    Properties{
        _MainTex("主纹理", 2D) = "white" {}
    }
    SubShader{
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct VertexData{
                float4 position : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators{
                float4 position : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;
            };

            Interpolators vert(VertexData v)
            {
                Interpolators i;
                i.position = UnityObjectToClipPos(v.position);
                i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                i.normal = mul(unity_ObjectToWorld, float4(v.normal, 0));
                i.normal = normalize(i.normal);
                return i;
            }

            float4 frag(Interpolators i) : SV_TARGET
            {
                return float4(i.normal * 0.5 + 0.5, 1);
            }
            ENDCG
        }
    }

}