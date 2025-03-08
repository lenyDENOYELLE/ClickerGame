<?php
require_once('db.php');

// Les 4 lignes suivantes devront être nécessaires dans chaque fichier d'API
header('content-type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

$query = 'SELECT * FROM enemy WHERE 1=1';
$params = [];

// Filtre par level (clé primaire)
if (!empty($_GET['level'])) {
    $query .= ' AND level = :level';
    $params[':level'] = $_GET['level'];
}

if (!empty($_GET['name'])) {
    $query .= ' AND name = :name';
    $params[':name'] = $_GET['name'];
}

if (!empty($_GET['total_life'])) {
    $query .= ' AND total_life = :total_life';
    $params[':total_life'] = $_GET['total_life'];
}

if (!empty($_GET['current_life'])) {
    $query .= ' AND current_life = :current_life';
    $params[':current_life'] = $_GET['current_life'];
}

$statement = $db->prepare($query);
$statement->execute($params);
$rows = $statement->fetchAll(PDO::FETCH_ASSOC);

// Si on filtre par level, on renvoie un seul ennemi (le premier de la liste)
if (!empty($_GET['level'])) {
    if (count($rows) > 0) {
        echo json_encode($rows[0]); // Renvoie le premier ennemi trouvé
    } else {
        echo json_encode(null); // Aucun ennemi trouvé
    }
} else {
    echo json_encode($rows); // Renvoie tous les ennemis
}