using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SwitchSubShader : MonoBehaviour
{
    public enum ShaderIndex
    {
        None,
        Zero,
        One,
    }

    public ShaderIndex shaderName = ShaderIndex.None;
    private void OnGUI()
    {
        if(GUI.Button(new Rect(0,0,60,20),"Single"))
        {
            SwitchSubShaderByTag(ShaderIndex.Zero);
        }

        if(GUI.Button(new Rect(0,30,60,20), "All"))
        {
            SwitchSubShaderByTag(ShaderIndex.One);
        }
    }

    private void SwitchSubShaderByTag(ShaderIndex tags)
    {
        string shaderName = GetShaderNameByTags(tags);
        Camera.main.SetReplacementShader(Shader.Find($"{shaderName}"), "");
    }

    private string GetShaderNameByTags(ShaderIndex tags)
    {
        string shaderName = string.Empty;
        switch (tags)
        {
            case ShaderIndex.Zero:  shaderName = "TA/MyShader00"; break;
            case ShaderIndex.One: shaderName = "TA/MyShader01"; break;
        }
        return shaderName;
    }
}
