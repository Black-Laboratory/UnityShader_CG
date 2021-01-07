
Shader "TA/MyShader020"
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
                float angle = v.vertex.z; //+ _Time.y; 
                // float4x4 m = 
                // {
                //     float4(sin(angle) / 2 + 0.5,0,0,0),
                //     float4(0,1,0,0),
                //     float4(0,0,1,0),
                //     float4(0,0,0,1)
                // };
                //优化旋转
                float x = (sin(angle) * 0.4 + 0.6) * v.vertex.x;
                v.vertex.x = x;
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = fixed4(x,0,0,1);
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