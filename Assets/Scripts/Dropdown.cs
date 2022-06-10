using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dropdown : MonoBehaviour
{
    public static int selectShader = 0;
    // Start is called before the first frame update
    public void HandleInput(int val)
    {
        selectShader = val;
        print(selectShader);
    }


}
