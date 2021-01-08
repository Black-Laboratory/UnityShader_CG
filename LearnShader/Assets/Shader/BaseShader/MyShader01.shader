// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "TA/MyShader01"
{
    Properties
    {
        _Radius("Radius",Range(1,10)) = 1
    } 
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
                float4 tempPos = UnityObjectToClipPos(v.vertex);
                float2 xyWorld = float2(tempPos.x / tempPos.w, tempPos.y / tempPos.w);
                float height =  sin(1 - _Radius * 10 * length(xyWorld) + _Time.w);
                v2f o;
                float4 wave = float4(v.vertex.x, height, v.vertex.z, v.vertex.w);
                o.pos = UnityObjectToClipPos(wave);
                o.color = fixed4(0, wave.y * 0.5 + 0.5, 0 , 1);
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