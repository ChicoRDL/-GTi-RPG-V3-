
float4 ClearMe() : COLOR0
{	
    return 0;	
}

technique Null
{
    pass p0
    {
		AlphaBlendEnable = TRUE;
        PixelShader = compile ps_2_0 ClearMe();
    }
}
