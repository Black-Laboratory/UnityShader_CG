Shader "TA/MySpecular_Fragment"
{
    Properties
    {
        _MainTex("MainTex",Color) = (1,1,1,1)
        _SpecularColor ("SpecularColor", Color) = (1, 1, 1, 1)
        _Shininess ("Shininess", Range(1, 128)) = 8
    }
    SubShader 
    {
        // pass
        // {
        //     //如果仅仅是需要方向光(只有方向光),那么我们只需要编写一个Pass通道，然后添加LightMode的Tags就好。
        //     Tags {"LightMode" = "ShadowCaster"} 
        // }
        pass
        { 
            Tags { "LightMode" = "ForwardBase" } 
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"
            #include "lighting.cginc"
            fixed4 _MainTex;
            fixed4 _SpecularColor;
            float _Shininess;
            struct v2f
            {
                float4 pos:SV_POSITION;
                float4 vertex: POSITION1; 
                float3 normal:NORMAL;
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
                //Ambient
                fixed4 color = UNITY_LIGHTMODEL_AMBIENT;
                //Diffuse
                float3 n = UnityObjectToWorldNormal(i.normal);
                float3 l = normalize(WorldSpaceLightDir(i.vertex));
                float ndotl = saturate(dot(n,l));
                color += _LightColor0 * _MainTex * ndotl;
                //Specular
                float3 v = normalize(WorldSpaceViewDir(i.vertex));
                float3 h = normalize(l + v); 
                float ndoth = saturate(dot(n,h));
                float shininess = pow(ndoth, _Shininess);
                color.rgb += _SpecularColor * shininess; 
                //Point lighting 
                float3 wpos = mul(unity_ObjectToWorld, i.vertex).xyz;
                color.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
                                               unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
                                               unity_4LightAtten0,wpos,n);
                return color; 
            } 
            ENDCG
        }  
    }
    //如果希望对象接受多种光源(平行光&点光源)的投影，
    //最方便的做法就是回滚到系统内建的Diffuse Shader
    Fallback "Diffuse"
}