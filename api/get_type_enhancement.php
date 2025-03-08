<?php
	require_once('db.php');

// Les 4 lignes suivantes devront être nécessaires dans chaque fichier d'API
	header('content-type: application/json');
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Headers: Content-Type");
	header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

	$query = 'SELECT * FROM type_enhancement WHERE 1=1';
	$params = [];
	if (!empty($_GET['id_type'])) {
	    $query .= ' AND id_type = :id_type';
	    $params[':id_type'] = $_GET['id_type'];
	}

	if (!empty($_GET['name_type'])) {
	    $query .= ' AND name_type = :name_type';
	    $params[':name_type'] = $_GET['name_type'];
	}



	$statement = $db->prepare($query);
	$statement->execute($params);
	$rows = $statement->fetchAll(PDO::FETCH_ASSOC);

	echo json_encode($rows);

