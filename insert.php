<?php

include "credentials.php";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$table = $_POST['table'];
// echo $table;
$fields = "";
$values = "";

foreach ($_POST as $key => $value) {
    if ($key != 'table') {
        $fields .= $key . ", ";
        $values .= "'$value', ";
    }
}

$fields = rtrim($fields, ", ");
$values = rtrim($values, ", ");

$sql = "INSERT INTO $table ($fields) VALUES ($values)";

if ($conn->query($sql) === TRUE) {
    echo "Nuevo registro creado exitosamente";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>


