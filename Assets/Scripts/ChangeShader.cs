using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeShader : MonoBehaviour
{
    public Material[] materials;
    Renderer render;
    // Start is called before the first frame update
    void Start()
    {
        render = GetComponent<Renderer>();
        render.enabled = true;
        render.sharedMaterial = materials[Dropdown.selectShader];
    }

    void Update()
    {
        render.sharedMaterial = materials[Dropdown.selectShader];
    }
}
