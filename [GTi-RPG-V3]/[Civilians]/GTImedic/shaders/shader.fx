    //-- Declare the texture. These are set using dxSetShaderValue( shader, "Tex0", texture )
    texture Tex0;
     
    technique simple
    {
        pass P0
        {
            //-- Set up texture stage 0
            Texture[0] = Tex0;
     
            //-- Leave the rest of the states to the default settings
        }
    }
