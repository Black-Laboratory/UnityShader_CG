// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TA/MyDiffuse_Vertex"
{
    SubShader 
    {
        pass
        {
            Tags { "LightMode" = "ForwardBase" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"
            #include "lighting.cginc"
            struct v2f
            {
                float4 pos:SV_POSITION;
                fixed4 color:COLOR; 
            };
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                //Ambient
                o.color = UNITY_LIGHTMODEL_AMBIENT;
                //Diffuse
                float3 n = UnityObjectToWorldNormal(v.normal);
                float3 l = normalize(WorldSpaceLightDir(v.vertex));  
                float nDotl = saturate(dot(n,l)); 
                o.color += _LightColor0 * nDotl;
                return o;
            }
            fixed4 frag(v2f i):COLOR
            { 
                return i.color;
            } 
            ENDCG
        }    
    }
}