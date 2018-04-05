using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlatformFall : MonoBehaviour {

    private Rigidbody2D rb;

    public float delay;

	// Use this for initialization
	void Start () {
        rb = GetComponent<Rigidbody2D>();
	}

	void OnCollisionEnter2D(Collision2D coll){
		//		Debug.Log ("HIT THING: " + coll.gameObject.name);
		Vector3 vel = rb.velocity;
		if (coll.gameObject.name == "Ground") {
			vel.y *= -2;
		} 

		if (coll.gameObject.name == "Wall") {
			vel.x *= -2;
		} 

		if (coll.gameObject.name == "Platform") {
			vel *= -2;
		}
		rb.velocity = vel;
	}
}
