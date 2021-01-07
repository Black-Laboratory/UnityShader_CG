// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "TA/MyShader02"
{ 
    SubShader 
    { 
        pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"
            float _Radius;
            struct v2f
            {
                float4 pos: SV_POSITION;
                fixed4 color: COLOR;
            };
            v2f vert(appdata_base v)
            {  
                float angle = length(v.vertex) + _SinTime.w;
                // float4x4 mvp = UNITY_MATRIX_MVP;
                // float4x4 m = 
                // {
                //     float4(cos(angle),0,sin(angle),0),
                //     float4(0,1,0,0),
                //     float4(-sin(angle),0,cos(angle),0),
                //     float4(0,0,0,1)
                // };
                // m = mul(mvp,m);
                //优化旋转方法
                float x = cos(angle) * v.vertex.x + sin(angle) * v.vertex.z;
                float z = -sin(angle) * v.vertex.x + cos(angle) * v.vertex.z;
                v.vertex.x = x;
                v.vertex.z = z;
                v2f o;
                // o.pos = mul(m,v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = fixed4(0,1,0,1);
                return o;
            }
            fixed4 frag(v2f i): COLOR
            {
                return i.color;
            } 
            ENDCG
        }
    }
}