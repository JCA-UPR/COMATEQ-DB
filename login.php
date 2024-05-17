<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMATEQ - Admin Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>Admin Login</h1>
    <form action="authenticate.php" method="post">
        <label for="admin_id">Admin ID:</label>
        <input type="text" id="admin_id" name="admin_id" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <input type="submit" value="Login">
    </form>
</body>
</html>
