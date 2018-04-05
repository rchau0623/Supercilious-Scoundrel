using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerController : MonoBehaviour
{
    public float maxSpeed = 500;

    public Rigidbody2D RB;
    public Animator animate;
    public bool OnGround = false;
    public bool Moving = false;
    public bool Sprint = false;
    public bool doubleJump = false;
    public float previous;

    public int currentHealth;
    public int maxHealth = 5;


    void Start()
    {
        RB = GetComponent<Rigidbody2D>();
        animate = GetComponent<Animator>();

        currentHealth = maxHealth;
    }

    void Update()
    {
        animate.SetBool("Grounded", OnGround);
        animate.SetFloat("Speed", Mathf.Abs(Input.GetAxis("Horizontal")));
        animate.SetBool("Sprint", Sprint);

        if (Input.GetAxis("Horizontal") < -0.1f)
        {
            transform.localScale = new Vector3(-1, 1, 1);
        }

        if (Input.GetAxis("Horizontal") > 0.1f)
        {
            transform.localScale = new Vector3(1, 1, 1);
        }

        if (currentHealth > maxHealth) { currentHealth = maxHealth; }

        if (currentHealth <= 0) { Die(); }

        Vector3 vel = RB.velocity;
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            vel.x = -5;
            /*if (!Moving)
            {
                vel.x = -5;
                Moving = true;
            }
            else
            {
                if (Mathf.Abs(vel.x) < maxSpeed)
                {
                    vel.x *= 3;
                }
                else
                {
                    vel.x = -maxSpeed;
                }
            }*/
            
        }
        else if (Input.GetKey(KeyCode.RightArrow))
        {
            vel.x = 5;
            /*if (!Moving)
            {
                vel.x = 5;
                Moving = true;
            }
            else
            {
                if (Mathf.Abs(vel.x) < maxSpeed)
                {
                    vel.x *= 3;
                }
                else
                {
                    vel.x = maxSpeed;
                }
            }*/
        }
        else
        {
            vel.x = 0;
            // Moving = false;
        }

        if (Input.GetKey(KeyCode.RightShift))
        {
            vel.x *= 2;
            Sprint = true;
        }
        else
        {
            Sprint = false;
        }


        if (Input.GetKeyDown(KeyCode.UpArrow))
        {
            if (OnGround) {
                vel.y = 10;
                OnGround = false;
                doubleJump = true;
            }
            else
            {
                if (doubleJump  )
                {
                    doubleJump = false;
                    vel.y = 10;
                }
            }
            
        }

        RB.velocity = vel;
    }

    void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.name == "Ground" || collision.gameObject.name == "Platform") {
            OnGround = true;
        }
		Vector3 vel = RB.velocity;
		if (collision.gameObject.name == "Mikey") {
			vel.x *= -2;
			vel.y *= -2;
		}
		RB.velocity = vel;
    }

    void Die()
    {
		UnityEngine.SceneManagement.SceneManager.LoadScene ("MikeyWin");
    }

    public void Damage(int damage)
    {
        currentHealth -= damage;
    }

    public IEnumerator Knockback (float knockDur, float knockbackPwr, Vector3 knockbackDir)
    {
        float timer = 0;
        OnGround = false;
        while (knockDur > timer)
        {
            timer += Time.deltaTime;
            RB.AddForce(new Vector3(knockbackDir.x * -200, knockbackDir.y*knockbackPwr, transform.position.z));
        }

        yield return 0;
    }
}


