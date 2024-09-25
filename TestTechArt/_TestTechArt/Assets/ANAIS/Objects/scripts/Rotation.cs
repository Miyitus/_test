using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotation : MonoBehaviour
{
  
    public float levitationHeight = 0.5f;   
    public float levitationSpeed = 2f;      


    public float rotationSpeed = 50f;      


    private float originalY;

    void Start()
    {
       
        originalY = transform.position.y;
    }

    void Update()
    {
        
        float newY = originalY + Mathf.Sin(Time.time * levitationSpeed) * levitationHeight;
        transform.position = new Vector3(transform.position.x, newY, transform.position.z);

        
        transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
    }
}