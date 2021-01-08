Shader "TA/MyRimShader_Plus" 
{
    Properties
    {
        _Scale ("Scale", Range(1, 8)) = 2
        _Color ("Color", Color) = (1, 1, 1, 1)
        _TimeScale ("TimeScale", Range(1, 10)) = 1
        [Toggle] _CustomOutLine("CustomOutLine",Range(0,1)) = 0 
        _OutLine ("OutLine", Range(0, 1)) = 0.2
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
            float _OutLine;
            bool _CustomOutLine;
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
                float outLine;
                if(_CustomOutLine)
                    outLine = _OutLine;
                else
                    outLine = sin(_Time.w * _TimeScale) * 0.25 + 0.25;
                v.vertex.xyz += v.normal * outLine;
                o.pos = UnityObjectToClipPos(v.vertex);
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
                float bright = ndotv;
                bright = pow(bright,_Scale);
                fixed4 color = i.color * bright;
                return color;
            }
            ENDCG
        }
        //===============================================================
        pass
        {
            BlendOp revsub
            Blend dstalpha One
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"
            fixed4 _Color; 
            struct v2f
            {   
                float4 pos:SV_POSITION; 
            };
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex); 
                return o;
            }
            fixed4 frag(v2f i):COLOR
            { 
                return fixed4(1,1,1,1);
            }
            ENDCG
        }
        //===============================================================
        pass
        {
            // Blend Zero One
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
                o.pos = UnityObjectToClipPos(v.vertex);
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