using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/* Code from
 * https://answers.unity.com/questions/22130/how-do-i-make-an-object-always-face-the-player.html
 */


public class RotateStatue : MonoBehaviour
{

    public Transform target;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 fwd = target.forward; 
        fwd.y = 0; 
        transform.rotation = Quaternion.LookRotation(fwd);
    }
}
