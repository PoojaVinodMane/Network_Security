<?php
if (!function_exists('getDatabaseConnection')) {
    function getDatabaseConnection(){
        $servername = "db"; // This should match the service name in docker-compose
        $port = "5432"; // PostgreSQL default port
        $username = "root";
        $password = "surbhi@postgres";
        $dbname = "money_transfer";

        try {
            $pdo = new PDO("pgsql:host=$servername;port=$port;dbname=$dbname", $username, $password, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]);
            return $pdo;
        } catch (PDOException $e) {
            die("Database connection failed: " . htmlspecialchars($e->getMessage()));
        }
    }
}
?>
