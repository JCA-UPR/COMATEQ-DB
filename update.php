<?php

include "credentials.php";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$table = $_POST['table'];
$id = $_POST['id'];
$updates = "";

foreach ($_POST as $key => $value) {
    if ($key != 'table' && $key != 'id') {
        $updates .= $key . "='$value', ";
    }
}

$updates = rtrim($updates, ", ");

$sql = "UPDATE $table SET $updates WHERE id_" . strtolower($table) . "=$id";

if ($conn->query($sql) === TRUE) {
    echo "Registro actualizado exitosamente";
} else {
    echo "Error actualizando registro: " . $conn->error;
}

$conn->close();
?>
