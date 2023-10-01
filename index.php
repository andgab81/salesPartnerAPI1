<?php
require "vendor/autoload.php";

$path = parse_url($_SERVER["REQUEST_URI"], PHP_URL_PATH);

$parts = explode('/', $path);

$resource = $parts[2];
$type = $parts[3] ?? "toate";
$startDate = $parts[4] ?? "toate";
$method = $_SERVER["REQUEST_METHOD"];

// echo $method, ' -> ', $resource, ' -> ', $type, ' -> ', $startDate, '\n';

$database = new Database();
$controller = new Controller($database);

$controller->processRequest($method, $resource, $type, $startDate);

// $outputData = $database->getAllClients();
// echo json_encode($outputData);
?>