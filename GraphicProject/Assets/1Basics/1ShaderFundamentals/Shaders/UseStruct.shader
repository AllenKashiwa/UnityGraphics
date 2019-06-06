Shader "Custom/UseStruct"
{
    Properties{
        _Tint("色调", Color) = (1, 1, 1, 1)
    }
    SubShader{
        Pass{
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"
                float4 _Tint;
                struct Interpolators{
                    float4 position : SV_POSITION;
                    float3 localPosition : TEXCOORD0;
                };

                Interpolators vert(float4 position : POSITION)
                {
                    Interpolators i;
                    i.localPosition = position.xyz;
                    i.position = UnityObjectToClipPos(position);
                    return i;
                }

                float4 frag(Interpolators i) : SV_TARGET
                {
                    return float4(i.localPosition, 1);
                }
            ENDCG
        }
    }
}