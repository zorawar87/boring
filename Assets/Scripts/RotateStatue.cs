using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateStatue : MonoBehaviour
{

    public Transform target;

    // Update is called once per frame
    void Update()
    {
        Vector3 fwd = target.forward; 
        transform.rotation = Quaternion.LookRotation(fwd);
    }
}
