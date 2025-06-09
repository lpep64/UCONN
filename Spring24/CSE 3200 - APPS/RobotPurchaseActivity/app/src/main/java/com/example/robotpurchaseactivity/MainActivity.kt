package com.example.robotpurchaseactivity

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView0)
        var energyCounter = 0
        textView.text = energyCounter.toString()

        // Find the buttons by their IDs
        val rewardAButton = findViewById<Button>(R.id.RewardA)
        val rewardBButton = findViewById<Button>(R.id.RewardB)
        val rewardCButton = findViewById<Button>(R.id.RewardC)

        // Set click listeners for each button
        rewardAButton.setOnClickListener {
            // Replace this with the functionality you want for RewardA button
            showToast("Reward A clicked")
            energyCounter -= 1;
            textView.text = energyCounter.toString()
        }

        rewardBButton.setOnClickListener {
            // Replace this with the functionality you want for RewardB button
            showToast("Reward B clicked")
            energyCounter -= 2;
            textView.text = energyCounter.toString()

        }

        rewardCButton.setOnClickListener {
            // Replace this with the functionality you want for RewardC button
            showToast("Reward C clicked")
            energyCounter -= 3;
            textView.text = energyCounter.toString()
        }
    }

    private fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }
}