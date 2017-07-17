Shader "Unlit/RippleShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Motion ("Motion", Float) = 0
		_Angle ("Angle", Float) = 0
    }
	SubShader
    {
		Tags {
			"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
		 }
		Blend SrcAlpha OneMinusSrcAlpha 

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			
            struct v2f {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert (
                float4 vertex : POSITION, // vertex position input
                float2 uv : TEXCOORD0 // first texture coordinate input
                )
            {
                v2f o;
                o.pos = mul(UNITY_MATRIX_MVP, vertex);
                o.uv = uv;
                return o;
            }
            
			// texture we will sample
            sampler2D _MainTex;
			float _Motion;
			float _Angle;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 tmp = i.uv;
				tmp.x = tmp.x + 0.05 * sin(_Motion + tmp.y * _Angle);
				fixed4 col = tex2D(_MainTex, tmp);
				return col;
            }
            ENDCG
        }
    }
}
