using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Looping : MonoBehaviour
{
    public Transform target;
    Vector3 loopPosition;

    // Start is called before the first frame update
    void Start()
    {
        loopPosition = target.position;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("LoopPortal"))
        {
            transform.position = loopPosition;
        }
    }
}
