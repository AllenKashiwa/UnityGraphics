Shader "Custom/SimpleColor"
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

                float4 vert(float4 position : POSITION) : SV_POSITION
                {
                    return UnityObjectToClipPos(position);
                }

                float4 frag(float4 pos : SV_POSITION) : SV_TARGET
                {
                    return _Tint;
                }
            ENDCG
        }
    }
}