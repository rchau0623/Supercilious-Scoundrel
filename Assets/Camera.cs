using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Camera : MonoBehaviour {

    public Vector2 vel;

    private float timey;
    private float timex;

    public GameObject donny;

	// Use this for initialization
	void Start () {
        donny = GameObject.FindGameObjectWithTag("Player");
	}
	
	// Update is called once per frame
	void LateUpdate () {
        float x = Mathf.SmoothDamp(transform.position.x, donny.transform.position.x, ref vel.x, timex);
        float y = Mathf.SmoothDamp(transform.position.y, donny.transform.position.y, ref vel.y, timey);

        transform.position = new Vector3(x, y, transform.position.z);
    }
}
