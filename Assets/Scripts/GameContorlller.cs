using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameContorlller : MonoBehaviour
{
    public GameObject[] VehicleList;
    [SerializeField]
    public GameObject spawnpoint;
    // Start is called before the first frame update
    void Start()
    {
        GameObject playerCar = Instantiate(VehicleList[CarSelection.currentCar], spawnpoint.transform.position, Quaternion.identity);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
