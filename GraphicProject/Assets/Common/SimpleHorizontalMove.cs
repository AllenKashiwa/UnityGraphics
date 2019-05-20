using UnityEngine;

public class SimpleHorizontalMove : MonoBehaviour
{
    public float speed;

    // Update is called once per frame
    void Update()
    {
        float h = Input.GetAxis("Horizontal");
        if (h != 0f)
        {
            transform.position += speed * transform.right * h * Time.deltaTime;
        }
    }
}
