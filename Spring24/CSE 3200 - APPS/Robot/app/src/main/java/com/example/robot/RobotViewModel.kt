package com.example.robot

import android.util.Log
import androidx.lifecycle.ViewModel

//private const val TAG = "RobotViewModel"
class RobotViewModel : ViewModel(){

//    init{
//        Log.d(TAG, "RobotViewModel about to be created")
//    }
//    override fun onCleared() {
//        super.onCleared()
//        Log.d(TAG, "RobotViewModel about to be cleared")
//    }
    private var _turnCount = 0
    var turnCount : Int
        get() = _turnCount
        set(value) {_turnCount = value}
}