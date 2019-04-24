using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Looping : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("LoopPortal"))
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().name);
        }
    }
}
