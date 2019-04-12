using UnityEngine;
using System;

public class ClockTime : MonoBehaviour
{
    public Transform hoursPivot, minutesPivot, secondsPivot;
    public float skewHours = 3f;
    public float skewMinutes = 35f;

    const float degreesPerHour = 30f,
                degreesPerMinute = 6f,
                degreesPerSecond = 6f;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        DateTime skew = DateTime.Now.AddHours(skewHours).AddMinutes(skewMinutes);
        TimeSpan now = skew.TimeOfDay;
        hoursPivot.localRotation =
			Quaternion.Euler(0f, (float)now.TotalHours * degreesPerHour, 0f);
		minutesPivot.localRotation =
			Quaternion.Euler(0f, (float)now.TotalMinutes * degreesPerMinute, 0f);
		secondsPivot.localRotation =
			Quaternion.Euler(0f, (float)now.TotalSeconds * degreesPerSecond, 0f);
    }
}
