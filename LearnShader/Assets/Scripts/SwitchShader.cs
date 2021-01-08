using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SwitchShader : MonoBehaviour
{
    public enum ShaderName
    {
        None,
        Zero,
        One,
        Two,
    }

    public ShaderName curShaderName = ShaderName.None;
    private ShaderName markShaderName = ShaderName.None;

    private void Update()
    {
        if(markShaderName != curShaderName)
        {
            SwitchShaderByName(curShaderName);
        }
    }

    private void SwitchShaderByName(ShaderName tags)
    {
        markShaderName = tags;
        string shaderName = GetShaderNameByTags(tags);
        if(!string.IsNullOrEmpty(shaderName))
            Camera.main.SetReplacementShader(Shader.Find($"{shaderName}"), "");
    }

    private string GetShaderNameByTags(ShaderName tags)
    {
        string shaderName = string.Empty;
        switch (tags)
        {
            case ShaderName.Zero: shaderName = "TA/MyShader00"; break;
            case ShaderName.One: shaderName = "TA/MyShader01"; break;
            case ShaderName.Two: shaderName = "TA/MyShader02"; break;
        }
        return shaderName;
    }


}
