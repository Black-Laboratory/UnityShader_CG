Shader "TA/MyColorBlendShader" 
{
    Properties
    {
        _MainColor ("MainColor", Color) = (1, 1, 1, 1)
        _SecondColor ("SecondColor", Color) = (1, 1, 1, 1)
        _Center ("Center", Range(-0.51, 0.51)) = 0
        _R ("R", Range(0, 0.5)) = 0.2
    }
    SubShader 
    {
        pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            fixed4 _MainColor;
            fixed4 _SecondColor;
            float _Center;
            float _R;
            struct v2f
            {
                float4 pos:SV_POSITION; 
                float y:TEXCOORD0;
            };
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.y = v.vertex.y;
                return o;
            }
            fixed4 frag(v2f i):COLOR
            {
                // if(i.y > _Center + _R)
                //     return _MainColor;
                // else if(i.y > _Center && i.y <= _Center + _R)
                // {
                //     float d =  i.y - _Center;
                //     d = (1 - d / _R) * 0.25 + 0.25;                    
                //     return lerp(_MainColor,_SecondColor,d); 
                // }

                // if(i.y < _Center && i.y >= _Center - _R)
                // {
                //     float d = i.y - _Center;
                //     d = (1 - abs(d / _R)) * 0.25 + 0.25;
                //     return lerp(_SecondColor,_MainColor,d);
                // }
                // else if(i.y < _Center - _R) 
                //     return _SecondColor;
                
                // return lerp(_MainColor,_SecondColor,0.5);
                float d = i.y - _Center;
                float s = abs(d);
                d = d / s;
                float f = s / _R;
                f = saturate(f);
                d *= f;
                d = d * 0.5 + 0.5;
                return lerp(_MainColor,_SecondColor,d);

                // float d = i.y - _Center;
                // d = d/abs(d);
                // d = d * 0.5 + 0.5;
                // return lerp(_MainColor,_SecondColor,d);
                // return (fixed4)lerp(_MainColor,_SecondColor,_Center);
                // if(i.y > _Center)
                //     return _MainColor;
                // else
                //     return _SecondColor;
            }
            ENDCG
        }
    }    
}