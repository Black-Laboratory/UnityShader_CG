using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CustomTools : Editor
{ 
    [MenuItem("TK/CustomTools/EnableOrDisableSelectObject %_q", false)]
    public static void EnableOrDisableGameObject()
    {
        GameObject[] go = Selection.gameObjects;
        if (go == null || go.Length == 0)
            return;
        for (int i = 0; i < go.Length; i++)
        {
            go[i].SetActive(!go[i].activeSelf);
        }
    }

    [MenuItem("TK/CustomTools/ResetGameObject %_w",false)]
    public static void ResetGameObject()
    {
        GameObject[] go = Selection.gameObjects;
        if (go == null || go.Length == 0)
            return;
        for (int i = 0; i < go.Length; i++)
        {
            go[i].transform.localScale = Vector3.one;
            go[i].transform.localPosition = Vector3.zero;
            go[i].transform.localEulerAngles = Vector3.zero;
        }
    }
}
