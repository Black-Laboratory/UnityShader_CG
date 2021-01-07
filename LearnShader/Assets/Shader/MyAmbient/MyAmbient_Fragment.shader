Shader "TA/MyAmbient_Fragment"
{
    SubShader 
    {
        pass
        {  
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"
            #include "lighting.cginc"
            struct v2f
            {
                float4 pos: POSITION;
                fixed4 color: COLOR;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex); 
                o.color = fixed4(0,0,0,0);
                return o;
            }
            fixed4 frag(v2f i):COLOR
            {
                return i.color + UNITY_LIGHTMODEL_AMBIENT;//Ambient
            }
            ENDCG
        }    
    }
}