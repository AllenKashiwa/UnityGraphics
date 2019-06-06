Shader "Custom/LocalPosColor"
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

                float4 vert(float4 position : POSITION, out float3 localPosition : TEXCOORD0) : SV_POSITION
                {
                    localPosition.xyz = position.xyz;
                    return UnityObjectToClipPos(position);
                }

                float4 frag(float4 pos : SV_POSITION, float3 localPosition : TEXCOORD0) : SV_TARGET
                {
                    return float4(localPosition, 1);
                }
            ENDCG
        }
    }
}
