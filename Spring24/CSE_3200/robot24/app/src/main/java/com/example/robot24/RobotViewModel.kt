package com.example.robot24

import android.util.Log
import androidx.lifecycle.ViewModel

//private const val TAG = "RobotViewModel"
class RobotViewModel : ViewModel() {
    /*init{
        Log.d(TAG, "RobotViewModel about to be created")
    }
    override fun onCleared() {
        super.onCleared()
        Log.d(TAG, "RobotViewModel about to be cleared")
    }*/

    private var _turnCount = 0
    var turnCount: Int
        get() = _turnCount
        set(value) {
            _turnCount = value
        }

    fun advanceTurn() {
        _turnCount += 1
        if (_turnCount > 3) {
            _turnCount = 1
        }
    }

    private val _robotPurchasesMade = mutableListOf<String>()
    val robotPurchasesMade: List<String>
        get() = _robotPurchasesMade

    fun addRobotPurchasesMade(purchases: List<String>) {
        _robotPurchasesMade.addAll(purchases)
    }

    private val _displayedRewards = mutableListOf<String>()
    val displayedRewards: List<String>
        get() = _displayedRewards

    fun setDisplayedRewards(rewards: List<String>) {
        _displayedRewards.clear()
        _displayedRewards.addAll(rewards)
    }

    private val _purchasedRewards = mutableSetOf<String>()

    val displayPurchases: MutableSet<String>
        get() = _purchasedRewards

    fun new_purchase(reward: String) {
        _purchasedRewards.add(reward)
    }

    fun clear_purchases() {
        _purchasedRewards.clear()
    }

    private var _robotEnergy = 0

    val getEnergy: Int
        get() = _robotEnergy

    fun updateEnergy(new: Int) {
        _robotEnergy = new
    }

    private var _nameCounter: Int = 0

    val nameCounter: Int
        get() = _nameCounter

    fun nameCounterAdd() {
        _nameCounter += 1
    }

    private var _redEnergy: Int = 0
    private var _whiteEnergy: Int = 0
    private var _yellowEnergy: Int = 0

    fun incrementEnergy(color: Int) {
        when (color) {
            0 -> _redEnergy += 1
            1 -> _whiteEnergy += 1
            else -> _yellowEnergy += 1
        }
    }

    fun setEnergy(color: Int, value: Int) {
        when (color) {
            0 -> _redEnergy = value
            1 -> _whiteEnergy = value
            else -> _yellowEnergy = value
        }
    }

    fun getEnergy(color: Int): Int {
        return when (color) {
            0 -> _redEnergy
            1 -> _whiteEnergy
            else -> _yellowEnergy
        }
    }

}