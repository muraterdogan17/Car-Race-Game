using UnityEngine;

public class CarAnimation : MonoBehaviour
{
    [SerializeField] private Vector3 finalPosition;
    private Vector3 initialPosition;
    private Quaternion initialRotation;
    Vector3 prevMousePos = Vector3.zero;
    Vector3 posMousePos = Vector3.zero;

    private void Awake()
    {
        initialPosition = transform.position;
        initialRotation = transform.rotation;
    }

    private void Update()
    {
        transform.position = Vector3.Lerp(transform.position, finalPosition, 0.1f);
        if (Input.GetMouseButton(0))
        {
            posMousePos = Input.mousePosition - prevMousePos;
            if (Vector3.Dot(transform.up, Vector3.up) >= 0)
            {
                transform.Rotate(transform.up, -Vector3.Dot(posMousePos, Camera.main.transform.right), Space.World);
            }
            else
            {
                transform.Rotate(Camera.main.transform.right, Vector3.Dot(posMousePos, Camera.main.transform.right), Space.World);
            }
            transform.Rotate(Camera.main.transform.right, Vector3.Dot(posMousePos, Camera.main.transform.up), Space.World);
        }
        prevMousePos = Input.mousePosition;
    }

    private void OnDisable()
    {
        transform.position = initialPosition;
        transform.rotation = initialRotation;
    }
}
