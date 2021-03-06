Shader "Custom/TilingAndOffset"
{
    Properties{
        _Tint("色调", Color) = (1, 1, 1, 1)
        _MainTex("主纹理", 2D) = "white" {}
    }
    SubShader{
        Pass{
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"
                float4 _Tint;
                sampler2D _MainTex;
                float4 _MainTex_ST;

                struct VertexData{
                    float4 position : POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct Interpolators{
                    float4 position : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                Interpolators vert(VertexData v)
                {
                    Interpolators i;
                    i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    i.position = UnityObjectToClipPos(v.position);
                    return i;
                }

                float4 frag(Interpolators i) : SV_TARGET
                {
                    return tex2D(_MainTex, i.uv) * _Tint;
                }
            ENDCG
        }
    }
}
