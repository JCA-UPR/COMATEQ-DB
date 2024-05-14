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

$tables = ["Estudiante", "Equipo", "Participacion", "Coordinador", "Universidad", "Escuela", "Problema"];

foreach ($tables as $table) {
    $sql = "SELECT * FROM $table";
    $result = $conn->query($sql);

    echo "<h2 id='".strtolower($table)."'>".$table." Registrados</h2>";
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

    // Insert form
    echo "<form action='insert.php' method='post'>
            <h3>Insertar Nuevo ".$table."</h3>
            <input type='hidden' name='table' value='$table'>";
    $result = $conn->query("DESCRIBE $table");
    while ($row = $result->fetch_assoc()) {
        if ($row['Field'] != 'id_' . strtolower($table) && $row['Field'] != 'permiso') {
            echo $row['Field'] . ": <input type='text' name='" . $row['Field'] . "'><br>";
        }
    }
    echo "<input type='submit' value='Insertar'></form>";

    // Update form
    echo "<form action='update.php' method='post'>
            <h3>Actualizar ".$table."</h3>
            <input type='hidden' name='table' value='$table'>
            ID a actualizar: <input type='number' name='id'><br>";
    $result = $conn->query("DESCRIBE $table");
    while ($row = $result->fetch_assoc()) {
        if ($row['Field'] != 'id_' . strtolower($table) && $row['Field'] != 'permiso') {
            echo $row['Field'] . ": <input type='text' name='" . $row['Field'] . "'><br>";
        }
    }
    echo "<input type='submit' value='Actualizar'></form>";

    // Delete form
    echo "<form action='delete.php' method='post'>
            <h3>Eliminar ".$table."</h3>
            <input type='hidden' name='table' value='$table'>
            ID a eliminar: <input type='number' name='id'><br>
            <input type='submit' value='Eliminar'></form>";
}
$conn->close();
?>
