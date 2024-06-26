<?php
// session_start();
// if (!isset($_SESSION['admin_id'])) {
//     header("Location: login.php");
//     exit();
// }

include "credentials.php";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$entity = ucfirst($_GET['entity']);
$table = $entity;

$sql = "SELECT * FROM $entity";
$result = $conn->query($sql);

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMATEQ - <?php echo $entity; ?></title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <!-- Show current table -->
    <h1><?php echo $entity; ?> Registrados</h1>
    <a href="index.php">Volver a la página principal</a>
    <a href="logout.php">Logout</a>
    <?php
    if ($result->num_rows > 0) {
        echo "<table><tr>";
        while ($fieldinfo = $result->fetch_field()) {
            echo "<th>{$fieldinfo->name}</th>";
        }
        echo "</tr>";

        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            foreach ($row as $value) {
                echo "<td>$value</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "0 resultados";
    }
    ?>

    <!-- Insert form -->
    <form action="insert.php" method="post">
        <h3>Insertar Nuevo <?php echo $entity; ?></h3>
        <input type='hidden' name='table' value='<?php echo $table; ?>'>
        <?php
        $result = $conn->query("DESCRIBE $entity");
        while ($row = $result->fetch_assoc()) {
            if ($row['Field'] != 'id_' . strtolower($entity) && $row['Field'] != 'permiso' && $row['Field'] != 'password_hash') {
                echo $row['Field'] . ": <input type='text' name='" . $row['Field'] . "'><br>";
            }
        }
        ?>
        <input type='submit' value='Insertar'>
    </form>

    <!-- Update form -->
    <form action="update.php" method="post">
        <h3>Actualizar <?php echo $entity; ?></h3>
        <input type='hidden' name='table' value='<?php echo $table; ?>'>
        ID a actualizar: <input type='number' name='id'><br>
        <?php
        $result = $conn->query("DESCRIBE $entity");
        while ($row = $result->fetch_assoc()) {
            if ($row['Field'] != 'id_' . strtolower($entity) && $row['Field'] != 'permiso' && $row['Field'] != 'password_hash') {
                echo $row['Field'] . ": <input type='text' name='" . $row['Field'] . "'><br>";
            }
        }
        ?>
        <input type='submit' value='Actualizar'>
    </form>

    <!-- Delete form -->
    <form action="delete.php" method="post">
        <h3>Eliminar <?php echo $entity; ?></h3>
        <input type='hidden' name='table' value='<?php echo $table; ?>'>
        ID a eliminar: <input type='number' name='id'><br>
        <input type='submit' value='Eliminar'>
    </form>

</body>
</html>

<?php
$conn->close();
?>
