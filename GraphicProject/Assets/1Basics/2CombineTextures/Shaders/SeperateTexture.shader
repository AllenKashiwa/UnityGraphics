Shader "Custom/SeperateTexture"
{
    Properties{
        _Tint("色调", Color) = (1, 1, 1, 1)
        _MainTex("主纹理", 2D) = "white" {}
        _DetailTex("细节纹理", 2D) = "gray" {}
    }
    SubShader{
        Pass{
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"
                float4 _Tint;
                sampler2D _MainTex;
                sampler2D _DetailTex;
                float4 _MainTex_ST;
                float4 _DetailTex_ST;

                struct VertexData{
                    float4 position : POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct Interpolators{
                    float4 position : SV_POSITION;
                    float2 uv : TEXCOORD0;
                    float2 uvDetail : TEXCOORD1;
                };

                Interpolators vert(VertexData v)
                {
                    Interpolators i;
                    i.position = UnityObjectToClipPos(v.position);
                    i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    i.uvDetail = TRANSFORM_TEX(v.uv, _DetailTex);
                    return i;
                }

                float4 frag(Interpolators i) : SV_TARGET
                {
                    float4 color = tex2D(_MainTex, i.uv) * _Tint;
                    color *= tex2D(_DetailTex, i.uvDetail) * 2;
                    return color;
                }
            ENDCG
        }
    }
}