<?php
	require_once('db.php');

// Les 4 lignes suivantes devront être nécessaires dans chaque fichier d'API
	header('content-type: application/json');
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Headers: Content-Type");
	header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

	$query = 'SELECT * FROM player WHERE 1=1';
	$params = [];
	if (!empty($_GET['id_player'])) {
	    $query .= ' AND id_player = :id_player';
	    $params[':id_player'] = $_GET['id_player'];
	}

	if (!empty($_GET['pseudo'])) {
	    $query .= ' AND pseudo = :pseudo';
	    $params[':pseudo'] = $_GET['pseudo'];
	}

	if (!empty($_GET['total_experience'])) {
	    $query .= ' AND total_experience = :total_experience';
	    $params[':total_experience'] = $_GET['total_experience'];
	}

	if (!empty($_GET['id_enemy'])) {
	    $query .= ' AND id_enemy > :id_enemy';
	    $params[':id_enemy'] = $_GET['id_enemy'];
	}


	$statement = $db->prepare($query);
	$statement->execute($params);
	$rows = $statement->fetchAll(PDO::FETCH_ASSOC);

	echo json_encode($rows);

