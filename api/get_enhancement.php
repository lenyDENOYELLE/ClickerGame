<?php
	require_once('db.php');

// Les 4 lignes suivantes devront être nécessaires dans chaque fichier d'API
	header('content-type: application/json');
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Headers: Content-Type");
	header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

	$query = 'SELECT * FROM enhancement WHERE 1=1';
	$params = [];
	if (!empty($_GET['id_enhancement'])) {
	    $query .= ' AND id_enhancement = :id_enhancement';
	    $params[':id_enhancement'] = $_GET['id_enhancement'];
	}

	if (!empty($_GET['experience_cost'])) {
	    $query .= ' AND experience_cost = :experience_cost';
	    $params[':experience_cost'] = $_GET['experience_cost'];
	}

	if (!empty($_GET['boost_value'])) {
	    $query .= ' AND boost_value = :boost_value';
	    $params[':boost_value'] = $_GET['boost_value'];
	}

	if (!empty($_GET['id_type'])) {
	    $query .= ' AND id_type > :id_type';
	    $params[':id_type'] = $_GET['id_type'];
	}


	$statement = $db->prepare($query);
	$statement->execute($params);
	$rows = $statement->fetchAll(PDO::FETCH_ASSOC);

	echo json_encode($rows);

