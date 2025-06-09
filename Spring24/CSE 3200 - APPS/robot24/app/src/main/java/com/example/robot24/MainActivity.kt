package com.example.robot24

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels

private const val TAG = "MainActivity"
class MainActivity : AppCompatActivity() {

    private lateinit var yellow_img: ImageView
    private lateinit var red_img: ImageView
    private lateinit var white_img: ImageView
    private lateinit var purchase_button: Button
    private lateinit var robot_text : TextView

    private lateinit var robotImages : MutableList<ImageView>

    private val robots = listOf(
        Robot(false, R.drawable.king_of_detroit_robot_red_large, R.drawable.king_of_detroit_robot_red_small, 0),
        Robot(false, R.drawable.king_of_detroit_robot_white_large, R.drawable.king_of_detroit_robot_white_small, 0),
        Robot(false, R.drawable.king_of_detroit_robot_yellow_large, R.drawable.king_of_detroit_robot_yellow_small,0)
    )

    private val names = arrayOf("Red", "White", "Yellow")

    private var displayName = ""
    private var displayMessage = ""

    private val robotViewModel : RobotViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //Log.d(TAG, "OnCreate(savedInstanceState)")

        yellow_img = findViewById(R.id.yellow_robot)
        red_img = findViewById(R.id.red_robot)
        white_img = findViewById(R.id.white_robot)
        purchase_button = findViewById(R.id.purchase_button)

        robot_text = findViewById(R.id.robotText)
        robot_text.text = ""

        //Log.d(TAG, "got a RobotViewModel : $robotViewModel")

        robotImages = mutableListOf(red_img, white_img, yellow_img)

        if (robotViewModel.turnCount != 0){
            setRobotTurn()
            setImages()

            displayName = names[(robotViewModel.nameCounter+2)%3]
            displayMessage = "$displayName Robot's Turn"
            robot_text.text = displayMessage

        }

        yellow_img.setOnClickListener { _: View ->
            rotateRobot()
        }
        red_img.setOnClickListener { _: View ->
            rotateRobot()

        }
        white_img.setOnClickListener { _: View ->
            rotateRobot()
        }

        purchase_button.setOnClickListener { _: View ->
            if(robotViewModel.turnCount != 0) {
                val intent = RobotPurchase.newIntent(this, robotViewModel.getEnergy(robotViewModel.turnCount - 1), robotViewModel.nameCounter)
                //startActivity(intent)
                purchaseLauncher.launch(intent)
            }
        }
    }// end of onCreate

    private val purchaseLauncher =  registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == Activity.RESULT_CANCELED){

            Toast.makeText(this, "Data Cancelled ", Toast.LENGTH_SHORT).show()

        }else if(result.resultCode == Activity.RESULT_OK){
            val robotPurchasesMade = result.data?.getStringArrayExtra(EXTRA_ROBOT_PURCHASE_MADE) ?: emptyArray()
            robotViewModel.addRobotPurchasesMade(robotPurchasesMade.toList())
            Toast.makeText(this, "Data Ok, Purchases Made: ${robotPurchasesMade.joinToString()}", Toast.LENGTH_SHORT).show()
        }

        val robotEnergy = result.data?.getIntExtra(EXTRA_ROBOT_ENERGY, 0) ?: 0
        robotViewModel.setEnergy(robotViewModel.turnCount-1, robotEnergy)

        //setImages()
        //displayName = names[robotViewModel.nameCounter%3]
        //displayMessage = "$displayName Robot's Turn"
        //robot_text.text = displayMessage
    }

    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart() called")
    }

    override fun onStop() {
        super.onStop()
        Log.d(TAG, "onStop() called")
    }

    override fun onResume() {
        super.onResume()
        Log.d(TAG, "onResume() called")
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "onPause() called")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy() called")
    }

    private fun rotateRobot() {
        robotViewModel.advanceTurn()
        setRobotTurn()
        setImages()
        robotViewModel.incrementEnergy(robotViewModel.turnCount-1, )

        displayName = names[robotViewModel.nameCounter%3]
        displayMessage = "$displayName Robot's Turn"
        robot_text.text = displayMessage
        robotViewModel.nameCounterAdd()
    }

    private fun setRobotTurn() {
        for (robot in robots) {
            robot.myTurn = false
        }
        robots[(robotViewModel.turnCount+2)%3].myTurn = true
    }

    private fun setImages(){
        for(indy in robots.indices){
            if(robots[indy].myTurn){
                robotImages[indy].setImageResource(robots[indy].largeImgRes)
            }else{
                robotImages[indy].setImageResource(robots[indy].smallImgRes)
            }
        }
    }
}