using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Teleporter : MonoBehaviour
{
    public Transform player;
	public Transform receiver;

	void OnTriggerEnter (Collider other)
	{
		if (other.tag == "Player")
		{
            print("--------------");
            print("player is colliding");
            player.position = receiver.position + new Vector3(10,0,0);
            print(receiver.position + new Vector3(10,0,0));
            print(player.position);
            print(player.position);
            print(player.position);
            print(player.position);
            print(player.position);
            print(player.position);
		}
	}
}
