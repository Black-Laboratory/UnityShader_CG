Shader "TA/MyRimShader" 
{
    Properties
    {
        _Scale ("Scale", Range(1, 8)) = 2
        _Color ("Color", Color) = (1, 1, 1, 1)
        _TimeScale ("TimeScale", Range(1, 10)) = 1
    }
    SubShader 
    {
        Tags { "Queue" = "Transparent" }
        pass
        {
            Blend One OneMinusSrcAlpha
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"
            float _Scale;
            fixed4 _Color;
            float _TimeScale;
            struct v2f
            {   
                float4 pos:SV_POSITION;
                float3 normal:NORMAL;
                float4 vertex:POSITION1;
                fixed4 color:COLOR;
            };
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityWorldToClipPos(v.vertex);
                o.normal = v.normal;
                o.vertex = v.vertex; 
                o.color = _Color;
                o.color.r = sin(_Time.w * _TimeScale) * 0.5 + 0.5;
                return o;
            }
            fixed4 frag(v2f i):COLOR
            {
                // float3 n = mul(i.normal,(float3x3)unity_WorldToObject);
                float3 n = UnityObjectToWorldNormal(i.normal);
                float3 v = normalize(WorldSpaceViewDir(i.vertex));
                float ndotv = saturate(dot(n,v));
                float bright = 1 - ndotv;
                bright = pow(bright,_Scale);
                fixed4 color = i.color * bright;
                return color;
            }
            ENDCG
        }    
    }    
}