<?php
session_start();

include "credentials.php";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$admin_id = $_POST['admin_id'];
$password = $_POST['password'];

$sql = "SELECT * FROM administradores WHERE id_administrador = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $admin_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $admin = $result->fetch_assoc();
    if (password_verify($password, $admin['password_hash'])) {
        $_SESSION['admin_id'] = $admin['id_admin'];
        header("Location: index.php");
    } else {
        echo "Contraseña incorrecta.";
    }
} else {
    echo "ID de administrador no encontrado.";
}

$stmt->close();
$conn->close();
?>
