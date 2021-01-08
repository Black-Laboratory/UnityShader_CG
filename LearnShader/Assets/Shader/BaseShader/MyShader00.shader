// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "TA/MyShader00"
{
    Properties
    {
        _Radius("Radius",Range(0.1,1)) = 0.5
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
                float2 xy = v.vertex.xz;//每个对象的自身定点位置(本地坐标)
                float height = sin( 1 - _Radius * length(xy) + _Time.w);
                v2f o;
                float4 wave = float4(xy.x, height, xy.y, v.vertex.w);
                o.pos = UnityObjectToClipPos(wave);

                o.color = fixed4(0, 0, wave.y * 0.5 + 0.5, 1);
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