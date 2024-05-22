<?php
// session_start();

include "credentials.php";

// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Generate the query
$sql = "SELECT MAX(ano_de_participacion) AS fecha FROM Equipo";

// Save the query results
$result = $conn->query($sql);
if (!$result) {
    die("Query failed: " . $conn->error);
}

// Fetch the rows
$row = $result->fetch_assoc();

// Latest date is the row called fechas
$latest_date = $row['fecha'];

// Find the top 3 teams from the latest competition, ordered in descending order
$sql = "SELECT Equipo.id_equipo, Equipo.nombre, Equipo.puntuacion
        FROM Equipo
        WHERE Equipo.ano_de_participacion = $latest_date AND Equipo.medalla_pais != 0
        ORDER BY Equipo.puntuacion DESC
        LIMIT 3";
$stmt = $conn->prepare($sql);
if (!$stmt) {
    die("Preparation failed: " . $conn->error);
}
// $stmt->bind_param("s", $latest_date);
if (!$stmt->execute()) {
    die("Execution failed: " . $stmt->error);
}
$teams_result = $stmt->get_result();
if (!$teams_result) {
    die("Getting result failed: " . $stmt->error);
}
$teams = $teams_result->fetch_all(MYSQLI_ASSOC);

// Get participants for each team
$team_participants = [];
foreach ($teams as $team) {
    $team_id = $team['id_equipo'];
    $sql = "SELECT Estudiante.primer_nombre, Estudiante.primer_apellido, Estudiante.grado, Estudiante.escuela, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(),Estudiante.fecha_de_nacimiento)), '%Y') + 0 AS edad 
    FROM Estudiante 
    JOIN Participacion ON Estudiante.id_estudiante = Participacion.id_estudiante 
    WHERE Participacion.id_equipo = $team_id";
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        die("Preparation failed: " . $conn->error);
    }
    // $stmt->bind_param("i", $team_id);
    if (!$stmt->execute()) {
        die("Execution failed: " . $stmt->error);
    }
    $participants_result = $stmt->get_result();
    if (!$participants_result) {
        die("Getting result failed: " . $stmt->error);
    }
    $team_participants[$team_id] = $participants_result->fetch_all(MYSQLI_ASSOC);
}

$stmt->close();
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMATEQ - Top 3 Teams</title>
    <link rel="stylesheet" type="text/css" href="results.css">
</head>
<body>
    <h1>Ganadores de últimas competencias</h1>
    <?php foreach ($teams as $team): ?>
        <div class="team-container">
            <div class="team-info">
                <!-- Cambiar imagen a basada en lugar de equipo!!! -->
                <img class="team-img" src="./p1.png" alt="Team Image">
                <h2><?php echo htmlspecialchars($team['nombre']); ?> (Puntuaje: <?php echo htmlspecialchars($team['puntuacion']); ?>)</h2>
                <h3>Participantes:</h3>
                <ul>
                    <?php foreach ($team_participants[$team['id_equipo']] as $participant): ?>
                        <li display="block">
                            Nombre: <?php echo htmlspecialchars($participant['primer_nombre']); ?>,
                            Edad: <?php echo htmlspecialchars($participant['edad']); ?>,
                            Grado: <?php echo htmlspecialchars($participant['grado']); ?>,
                            Escuela: <?php echo htmlspecialchars($participant['escuela']); ?>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        </div>
    <?php endforeach; ?>
</body>
</html>