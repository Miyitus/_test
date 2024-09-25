llusing System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionForce : MonoBehaviour
{
    public float impulseForce = 10f;


    private Rigidbody cubeRigidbody;

    void Start()
    {
     
        cubeRigidbody = GetComponent<Rigidbody>();
    }

    // Detect collision
    private void OnCollisionEnter(Collision collision)
    {

        if (collision.gameObject.CompareTag("Sphere"))
        {
        
            Vector3 forceDirection = (cubeRigidbody.position - collision.contacts[0].point).normalized;

            
            cubeRigidbody.AddForce(forceDirection * impulseForce, ForceMode.Impulse);
        }
    }
}

