Shader "TA/MyShader03"
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
                // A * sin(w*x + t);
                v.vertex.y += 0.2 * sin((v.vertex.x + v.vertex.z) + _Time.y);
                v.vertex.y += 0.3 * sin((v.vertex.x - v.vertex.z) + _Time.w);
                // v.vertex.y += sin(length(v.vertex.xz) + _Time.y);
                v2f o;
                // o.pos = mul(m,v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = fixed4(0,v.vertex.y,0,1);
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