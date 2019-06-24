Shader "Custom/RGBSplatting"
{
    Properties{
        _MainTex("Splat Map", 2D) = "white" {}
        [NoScaleOffset]_Texture1("纹理1", 2D) = "white" {}
        [NoScaleOffset]_Texture2("纹理2", 2D) = "white" {}
        [NoScaleOffset]_Texture3("纹理2", 2D) = "white" {}
        [NoScaleOffset]_Texture4("纹理2", 2D) = "white" {}
    }
    SubShader{
        Pass{
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"
                sampler2D _MainTex, _Texture1, _Texture2, _Texture3, _Texture4;
                float4 _MainTex_ST;

                struct VertexData{
                    float4 position : POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct Interpolators{
                    float4 position : SV_POSITION;
                    float2 uv : TEXCOORD0;
                    float2 uvSplat: TEXCOORD1;
                };


                Interpolators vert(VertexData v)
                {
                    Interpolators i;
                    i.position = UnityObjectToClipPos(v.position);
                    i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    i.uvSplat = v.uv;
                    return i;
                }

                float4 frag(Interpolators i) : SV_TARGET
                {
                    float4 splat = tex2D(_MainTex, i.uvSplat);
                    float4 color = tex2D(_Texture1, i.uv) * splat.r +
                                    tex2D(_Texture2, i.uv) * splat.g +
                                    tex2D(_Texture3, i.uv) * splat.b +
                                    tex2D(_Texture4, i.uv) * (1 - splat.r - splat.g - splat.b);
                    return color;
                }
            ENDCG
        }
    }
}