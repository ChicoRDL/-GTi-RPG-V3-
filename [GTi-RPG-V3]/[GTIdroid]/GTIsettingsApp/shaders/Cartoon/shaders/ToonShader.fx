texture ScreenSource;
float ScreenWidth = 1366;
float ScreenHeight = 768;

// between 1 and 64
float BitDepth = 16;

// between 0 and 1
float OutlineStrength = 0.5;


sampler TextureSampler = sampler_state
{
    Texture = <ScreenSource>;
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Wrap;
    AddressV = Wrap;
};

float4 PixelShaderFunction(float2 TextureCoordinate : TEXCOORD0) : COLOR0
{	
	
// BLUR

	float4 s1 = tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, -1.0f / ScreenHeight));
	float4 s2 = tex2D(TextureSampler, TextureCoordinate + float2(0, -1.0f / ScreenHeight));
	float4 s3 = tex2D(TextureSampler, TextureCoordinate + float2(1.0f / ScreenWidth, -1.0f / ScreenHeight));
 
	float4 s4 = tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, 0));
	float4 Blur = tex2D(TextureSampler, TextureCoordinate);
	float4 s5 = tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, 0));
	 
	float4 s6 = tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, 1.0f / ScreenHeight));
	float4 s7 = tex2D(TextureSampler, TextureCoordinate + float2(0, 1.0f / ScreenHeight));
	float4 s8 = tex2D(TextureSampler, TextureCoordinate + float2(1.0f / ScreenWidth, 1.0f / ScreenHeight));
	  
	Blur = (Blur + s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8) / 9;

// BITDEPTH
  
	float4 Color = Blur;
	Color.rgb /= Color.a;

	Color.rgb *= BitDepth;
	Color.rgb = floor(Color.rgb);
	Color.rgb /= BitDepth;
	Color.rgb *= Color.a * 1.2;

// OUTLINE

	float4 lum = float4(0.30, 0.6, 0.1, 1);
 
	float s11 = dot(tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, -1.0f / ScreenHeight)), lum);
	float s12 = dot(tex2D(TextureSampler, TextureCoordinate + float2(0, -1.0f / ScreenHeight)), lum);
	float s13 = dot(tex2D(TextureSampler, TextureCoordinate + float2(1.0f / ScreenWidth, -1.0f / ScreenHeight)), lum);
 
	float s21 = dot(tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, 0)), lum);
	float s23 = dot(tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, 0)), lum);
 
	float s31 = dot(tex2D(TextureSampler, TextureCoordinate + float2(-1.0f / ScreenWidth, 1.0f / ScreenHeight)), lum);
	float s32 = dot(tex2D(TextureSampler, TextureCoordinate + float2(0, 1.0f / ScreenHeight)), lum);
	float s33 = dot(tex2D(TextureSampler, TextureCoordinate + float2(1.0f / ScreenWidth, 1.0f / ScreenHeight)), lum);

	float t1 = s13 + s33 + (2 * s23) - s11 - (2 * s21) - s31;
	float t2 = s31 + (2 * s32) + s33 - s11 - (2 * s12) - s13;
 
	float4 OutLine;
 
	if (((t1 * t1) + (t2 * t2)) > OutlineStrength/10) {
		OutLine = float4(0.1,0.1,0.1,1);
	} else {
		OutLine = float4(1,1,1,1);
	}
 
//FINAL

	float4 FinalColor = abs(((Color + Blur)/2) * OutLine);
	
	return FinalColor;
}
 
technique ToonShader
{
    pass Pass1
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}