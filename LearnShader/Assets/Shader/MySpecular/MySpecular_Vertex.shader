Shader "TA/MySpecular_Vertex"
{
    Properties
    {
        _SpecularColor ("SpecularColor", Color) = (1, 1, 1, 1)
        _Shininess ("Shininess", Range(1, 64)) = 8
    }
    SubShader 
    {
        pass
        { 
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"
            #include "lighting.cginc"
            fixed4 _SpecularColor;
            float _Shininess;
            struct v2f
            {
                float4 pos: POSITION;
                fixed4 color:COLOR;
                // float3 normal:NORMAL;
                // float4 light: POSITION2;
            };
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                //Ambient
                o.color = UNITY_LIGHTMODEL_AMBIENT;
                //Diffuse
                float3 n = UnityObjectToWorldNormal(v.normal);
                float3 l = normalize(UnityWorldSpaceLightDir(v.vertex));
                float ndotl = dot(n,l);
                float factor = saturate(ndotl);
                o.color += _LightColor0 * factor; 
                //Specular 
                //（WorldSpaceLightDir()得到的是光源到顶点的向量，前面加"-"号，即顶点到光源的向量）
                float3 i = normalize(-WorldSpaceLightDir(v.vertex));//得到顶点到光源的向量
                float3 r = normalize(reflect(i,n)); //计算反射光的单位向量
                float3 view = normalize(WorldSpaceViewDir(v.vertex));//顶点到视图的单位向量
                //pow(x,y)返回x的y次方。
                float specularScale = pow(saturate(dot(r,view)),_Shininess);
                o.color.rgb += _SpecularColor * specularScale;
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