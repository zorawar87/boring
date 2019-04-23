using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PortalCamera : MonoBehaviour
{
    public Transform playerCamera;
    public Transform thisPortal;
    public Transform thatPortal;

    void Update()
    {
        transform.position = thisPortal.position +
            (playerCamera.position - thatPortal.position);
    }
}
