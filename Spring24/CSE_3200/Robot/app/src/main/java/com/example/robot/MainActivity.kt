package com.example.robot
import android.media.Image
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import android.view.View
import android.widget.ImageButton
import androidx.activity.viewModels
import android.util.Log
import android.widget.Toast

private const val TAG = "MainActivity"

class MainActivity : AppCompatActivity() {

    private lateinit var yellow_img: ImageView
    private lateinit var red_img: ImageView
    private lateinit var white_img: ImageView

    private lateinit var robotImages : MutableList<ImageView>

    private val robots = listOf(
        Robot(false, R.drawable.king_of_detroit_robot_red_large, R.drawable.king_of_detroit_robot_red_small),
        Robot(false, R.drawable.king_of_detroit_robot_white_large, R.drawable.king_of_detroit_robot_white_small),
        Robot(false, R.drawable.king_of_detroit_robot_yellow_large, R.drawable.king_of_detroit_robot_yellow_small)
    )

    private val robotViewModel : RobotViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //Log.d(TAG, "OnCreate(savedInstanceState)")

        yellow_img = findViewById(R.id.yellow_robot)
        red_img = findViewById(R.id.red_robot)
        white_img = findViewById(R.id.white_robot)

        //Log.d(TAG, "got a RobotViewModel : $robotViewModel")

        robotImages = mutableListOf(red_img, white_img, yellow_img)

        yellow_img.setOnClickListener { _: View ->
            Toast.makeText(this, "TurnCount : ${robotViewModel.turnCount}", Toast.LENGTH_SHORT).show()
            advanceTurn()
        }
        red_img.setOnClickListener { _: View ->
            advanceTurn()
        }
        white_img.setOnClickListener { _: View ->
            advanceTurn()
        }
    }// end of onCreate

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

    private fun advanceTurn(){
        robotViewModel.turnCount += 1
        if(robotViewModel.turnCount > 3){
            robotViewModel.turnCount = 1
        }
        setRobotTurn()
        setImages()
    }

    /*private fun setImages(){
      if(turnCount == 1){
          red_img.setImageResource(R.drawable.king_of_detroit_robot_red_large)
          white_img.setImageResource(R.drawable.king_of_detroit_robot_white_small)
          yellow_img.setImageResource(R.drawable.king_of_detroit_robot_yellow_small)
      }else if(turnCount == 2){
          red_img.setImageResource(R.drawable.king_of_detroit_robot_red_small)
          white_img.setImageResource(R.drawable.king_of_detroit_robot_white_small)
          yellow_img.setImageResource(R.drawable.king_of_detroit_robot_yellow_large)
      }else{
          red_img.setImageResource(R.drawable.king_of_detroit_robot_red_small)
          white_img.setImageResource(R.drawable.king_of_detroit_robot_white_large)
          yellow_img.setImageResource(R.drawable.king_of_detroit_robot_yellow_small)
      }
    }*/

    private fun setRobotTurn() {
        for (robot in robots) {
            robot.myTurn = false
        }
        robots[robotViewModel.turnCount - 1].myTurn = true;
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