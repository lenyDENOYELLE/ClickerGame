<?php
	require_once('db.php');

// Les 4 lignes suivantes devront être nécessaires dans chaque fichier d'API
	header('content-type: application/json');
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Headers: Content-Type");
	header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

	$query = 'SELECT * FROM buy WHERE 1=1';
	$params = [];
	if (!empty($_GET['id_player'])) {
	    $query .= ' AND id_player = :id_player';
	    $params[':id_player'] = $_GET['id_player'];
	}

	if (!empty($_GET['id_enhancement'])) {
	    $query .= ' AND id_enhancement = :id_enhancement';
	    $params[':id_enhancement'] = $_GET['id_enhancement'];
	}

	$statement = $db->prepare($query);
	$statement->execute($params);
	$rows = $statement->fetchAll(PDO::FETCH_ASSOC);

	echo json_encode($rows);

