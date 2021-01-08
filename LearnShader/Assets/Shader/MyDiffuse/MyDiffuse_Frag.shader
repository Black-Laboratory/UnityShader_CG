// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TA/MyDiffuse_Fragment"
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
                float4 vertex:POSITION1;
                float3 normal: NORMAL;
            }; 
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.vertex = v.vertex;
                o.normal = v.normal; 
                return o;
            } 
            fixed4 frag(v2f i):COLOR
            {   
                float3 n = UnityObjectToWorldNormal(i.normal);
                float3 l = normalize(WorldSpaceLightDir(i.vertex));
                float ndotl = saturate(dot(n,l));
                return  _LightColor0 * ndotl + UNITY_LIGHTMODEL_AMBIENT;
            }
            ENDCG
        }    
    }
}