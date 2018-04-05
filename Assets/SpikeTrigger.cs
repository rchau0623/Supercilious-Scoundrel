using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpikeTrigger : MonoBehaviour {

    public PlayerController player;
	public MikeyController player2;

	// Use this for initialization
	void Start () {
        player = GameObject.FindGameObjectWithTag("Donny").GetComponent<PlayerController>();
		player2 = GameObject.FindGameObjectWithTag("Mikey").GetComponent<MikeyController>();
	}


    void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.CompareTag("Donny"))
        {
            player.Damage(1);

            StartCoroutine(player.Knockback(0.02f, 350, player.transform.position));

        } 

		if (collision.CompareTag("Mikey"))
		{
			player2.Damage(1);

			StartCoroutine(player2.Knockback(0.02f, 350, player2.transform.position));

		} 
    }
}
