Shader "Custom/色阶"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100
        
        Pass
        {
            
            CGPROGRAM
            
            // Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members worldPos)
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            
            struct a2v
            {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
                float3 normal: NORMAL;
            };
            struct v2f
            {
                float4 pos: SV_POSITION;
                float2 uv: TEXCOORD0;
                float3 worldNormal: NORMAL;
                float3 worldPos: TEXCOORD1;
            };
            
            float4 _Color;
            v2f vert(a2v v)
            {
                v2f o;
                
                o.pos = UnityObjectToClipPos(v.vertex) ;//+ float4(normal.x, normal.y, normal.z, 0) * _test ;
                o.uv = v.uv;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                
                return o;
            }
            float4 frag(v2f i, float face: VFACE): SV_TARGET
            {
                
                float4 col;
                col = _Color;
                
                float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb * _Color;
                fixed3 worldNormal = normalize(i.worldNormal);
                //把光照方向归一化
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 lambert = dot(worldNormal, worldLightDir) ;
                fixed3 diffuse = lambert * _Color * _LightColor0.xyz + ambient;
                col.rgb = col.rgb * diffuse ;
                
                return col;
            }
            
            
            
            ENDCG
            
        }
    }
    Fallback "DIFFUSE"
}
