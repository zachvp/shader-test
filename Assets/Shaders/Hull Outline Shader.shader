Shader "Outlines/HullOutline"
{
    Properties
    {
        _Thickness ("Thickness", Float) = 1 // multiplier to extrude the outline mesh
        _Color ("Color", Color) = (1, 1, 1, 1) // outline color
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline" } // todo: need to specify pipeline?

        Pass
        {
            Name "Outlines"
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            struct vertexProperties
            {
                float4 positionOS : POSITION;
                float3 normalOS   : NORMAL;
            };

            struct vertexOutput
            {
                float4 positionCS : SV_POSITION;
            };

            // input Properties
            float _Thickness;
            float4 _Color;

            vertexOutput vert (vertexProperties input)
            {
                vertexOutput output = (vertexOutput) 0;
                
                float3 positionOS = input.positionOS.xyz + input.normalOS * _Thickness;
                output.positionCS = UnityObjectToClipPos(positionOS);

                return output;
            }

            fixed4 frag (vertexOutput input) : SV_Target
            {
                return _Color;
            }
            ENDCG
        }
    }
}
