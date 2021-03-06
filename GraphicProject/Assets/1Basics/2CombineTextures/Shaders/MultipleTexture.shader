Shader "Custom/MultipleTexture"
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
                    i.uv = v.uv;
                    i.position = UnityObjectToClipPos(v.position);
                    return i;
                }

                float4 frag(Interpolators i) : SV_TARGET
                {
                    float4 color = tex2D(_MainTex, i.uv) * _Tint;
                    color *= tex2D(_MainTex, i.uv * 10);
                    return color;
                }
            ENDCG
        }
    }
}