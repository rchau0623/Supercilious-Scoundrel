using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HUDScript : MonoBehaviour {

    public Sprite[] HeartSprites;

    public Image HeartUI;
	public Image MikeyHeartUI;

    private PlayerController player;
	private MikeyController player2;

	// Use this for initialization
	void Start () {
        player = GameObject.FindGameObjectWithTag("Donny").GetComponent<PlayerController>();
		player2 = GameObject.FindGameObjectWithTag("Mikey").GetComponent<MikeyController>();
    }

    // Update is called once per frame
    void Update () {
        HeartUI.sprite = HeartSprites[player.currentHealth];
		MikeyHeartUI.sprite = HeartSprites[player2.currentHealth];
	}
}
