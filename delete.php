<?php
$servername = "localhost";
$username = "jimmyca";
$password = "zW2v8b5L";
$dbname = "S224DB_jimmyca";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$table = $_POST['table'];
$id = $_POST['id'];

$sql = "DELETE FROM $table WHERE id_" . strtolower($table) . "=$id";

if ($conn->query($sql) === TRUE) {
    echo "Registro eliminado exitosamente";
} else {
    echo "Error eliminando registro: " . $conn->error;
}

$conn->close();
?>
