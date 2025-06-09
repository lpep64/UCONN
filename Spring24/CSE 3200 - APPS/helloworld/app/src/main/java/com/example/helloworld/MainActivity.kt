package com.example.helloworld

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    lateinit var displayButton: Button
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        displayButton = findViewById(R.id.submit_button)
        displayButton.setOnClickListener { view: View ->
            val editText: EditText = findViewById(R.id.editTextName)
            val textView: TextView = findViewById(R.id.greetingsText)
            val textToEdit: editText.text.toString()
            if (textToEdit != "") {
                textView.text = "Hello " + textToEdit
            } else {
                textView.setText(R.string.app_name)
            }
        }
        val editText: EditText = findViewById(R.id.name_box)
        val greeting: TextView = findViewById(R.id.hello_mssg)
    }
}