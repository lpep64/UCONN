package com.example.robot24

import android.app.Activity
import android.app.Instrumentation.ActivityResult
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import android.widget.Button
import android.widget.TextView
import android.content.Context
import android.content.Intent
import android.widget.ImageView
import androidx.activity.viewModels

private const val EXTRA_NAME_COUNTER = "com.example.robot24.current_name_counter"

const val EXTRA_ROBOT_ENERGY = "com.example.robot24.current_robot_energy"
const val EXTRA_ROBOT_PURCHASE_MADE = "com.example.robot24.current_robot_purchase_made"
class RobotPurchase : AppCompatActivity() {

    private lateinit var reward_button_1 : Button
    private lateinit var reward_text_1 : TextView

    private lateinit var reward_button_2 : Button
    private lateinit var reward_text_2 : TextView

    private lateinit var reward_button_3 : Button
    private lateinit var reward_text_3 : TextView


    private lateinit var robot_energy_available : TextView
    private lateinit var robot_img : ImageView

    private var robot_energy = 0
    private var name_counter = 0

    private val robotPhoto = listOf(
        R.drawable.king_of_detroit_robot_red_large,
        R.drawable.king_of_detroit_robot_white_large,
        R.drawable.king_of_detroit_robot_yellow_large
    )

    private val purchaseButtons = listOf(
        Pair("Reward A", 1),
        Pair("Reward B", 2),
        Pair("Reward C", 3),
        Pair("Reward D", 3),
        Pair("Reward E", 4),
        Pair("Reward F", 4),
        Pair("Reward G", 7)
        )

    private var purchasedItems = mutableSetOf<String>()

    private val robotViewModel : RobotViewModel by viewModels()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_robot_purchase)

        robot_img = findViewById(R.id.photo_of_robot)
        name_counter = intent.getIntExtra(EXTRA_NAME_COUNTER, 0)
        robot_img.setImageResource(robotPhoto[(name_counter+2)%3])

        reward_button_1 = findViewById(R.id.Reward1)
        reward_button_2 = findViewById(R.id.Reward2)
        reward_button_3 = findViewById(R.id.Reward3)

        reward_text_1 = findViewById(R.id.textView1)
        reward_text_2 = findViewById(R.id.textView2)
        reward_text_3 = findViewById(R.id.textView3)

        if (robotViewModel.displayedRewards.isEmpty()) {
            val randomNumbers = mutableSetOf<Int>()

            while (randomNumbers.size < 3) {
                val randomNumber = (0..6).random()
                randomNumbers.add(randomNumber)
            }

            val sortedArray = randomNumbers.sorted().toTypedArray()

            reward_button_1.text = purchaseButtons[sortedArray[0]].first
            reward_button_2.text = purchaseButtons[sortedArray[1]].first
            reward_button_3.text = purchaseButtons[sortedArray[2]].first

            reward_text_1.text = purchaseButtons[sortedArray[0]].second.toString()
            reward_text_2.text = purchaseButtons[sortedArray[1]].second.toString()
            reward_text_3.text = purchaseButtons[sortedArray[2]].second.toString()

            robotViewModel.setDisplayedRewards(
                listOf(
                    purchaseButtons[sortedArray[0]].first,
                    purchaseButtons[sortedArray[1]].first,
                    purchaseButtons[sortedArray[2]].first,
                    purchaseButtons[sortedArray[0]].second.toString(),
                    purchaseButtons[sortedArray[1]].second.toString(),
                    purchaseButtons[sortedArray[2]].second.toString()
                )
            )

            robotViewModel.clear_purchases()

            robot_energy_available = findViewById(R.id.textView0)
            robot_energy = intent.getIntExtra(EXTRA_ROBOT_ENERGY, 6)
            robotViewModel.updateEnergy(robot_energy)

            val deleteIntent2 = Intent().apply {
                putExtra(EXTRA_ROBOT_PURCHASE_MADE, purchasedItems.toList().toTypedArray())
                putExtra(EXTRA_ROBOT_ENERGY, robot_energy)
            }
            setResult(Activity.RESULT_CANCELED, deleteIntent2)

        }else{
            reward_button_1.text = robotViewModel.displayedRewards[0]
            reward_button_2.text = robotViewModel.displayedRewards[1]
            reward_button_3.text = robotViewModel.displayedRewards[2]
            reward_text_1.text = robotViewModel.displayedRewards[3]
            reward_text_2.text = robotViewModel.displayedRewards[4]
            reward_text_3.text = robotViewModel.displayedRewards[5]

            //Keep My Energy
            robot_energy_available = findViewById(R.id.textView0)
            robot_energy = robotViewModel.getEnergy

            //Keep Record of Purchases
            purchasedItems = robotViewModel.displayPurchases

            val deleteIntent = Intent().apply {
                putExtra(EXTRA_ROBOT_PURCHASE_MADE, purchasedItems.toList().toTypedArray())
                putExtra(EXTRA_ROBOT_ENERGY, robot_energy)
            }
            setResult(Activity.RESULT_OK, deleteIntent)

            if(purchasedItems.isEmpty()){
                val deleteIntent2 = Intent().apply {
                    putExtra(EXTRA_ROBOT_PURCHASE_MADE, purchasedItems.toList().toTypedArray())
                    putExtra(EXTRA_ROBOT_ENERGY, robot_energy)
                }
                setResult(Activity.RESULT_CANCELED, deleteIntent2)
            }
        }
        robot_energy_available.text = robot_energy.toString()

        reward_button_1.setOnClickListener {
            makePurchase(robotViewModel.displayedRewards[0], robotViewModel.displayedRewards[3].toInt())
        }

        reward_button_2.setOnClickListener {
            makePurchase(robotViewModel.displayedRewards[1], robotViewModel.displayedRewards[4].toInt())
        }

        reward_button_3.setOnClickListener {
            makePurchase(robotViewModel.displayedRewards[2], robotViewModel.displayedRewards[5].toInt())
        }
    }// end of onCreate

    companion object {
        fun newIntent(packageContext: Context, robot_energy: Int, name_counter: Int): Intent {
            return Intent(packageContext, RobotPurchase::class.java).apply {
                putExtra(EXTRA_ROBOT_ENERGY, robot_energy)
                putExtra(EXTRA_NAME_COUNTER, name_counter)
            }
        }
    }

    private fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    private fun makePurchase(purchaseName: String, costOfPurchase: Int) {
        var toastMessage = purchaseName

        if (costOfPurchase > robot_energy) {
            toastMessage += " Insufficient funds"
            showToast(toastMessage)
        } else if (purchasedItems.contains(purchaseName)) {
            showToast("Item already purchased")
        } else {
            robot_energy -= costOfPurchase
            robotViewModel.updateEnergy(robot_energy)
            robot_energy_available.text = robot_energy.toString()

            purchasedItems.add(purchaseName)
            robotViewModel.new_purchase(purchaseName)

            val deleteIntent = Intent().apply {
                putExtra(EXTRA_ROBOT_PURCHASE_MADE, purchasedItems.toList().toTypedArray())
                putExtra(EXTRA_ROBOT_ENERGY, robot_energy)
            }

            setResult(Activity.RESULT_OK, deleteIntent)

            toastMessage += " Purchased"
            showToast(toastMessage)
        }
    }
}