<?php
require_once('db.php');

header('content-type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");


// Autoriser seulement les requêtes POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["error" => "Méthode non autorisée"]);
    exit;
}

// Lire et décoder les données JSON envoyées
$data = json_decode(file_get_contents("php://input"), true);
if (!$data) {
    echo json_encode(["error" => "Données JSON invalides"]);
    exit;
}

// Vérifier si l'action est définie
if (!isset($data['action'])) {
    echo json_encode(["error" => "Aucune action spécifiée"]);
    exit;
}

$action = $data['action'];
$response = [];

try {
    switch ($action) {
        case "insert":
            if (!isset($data['experience_cost'], $data['boost_value'], $data['id_type'])) {
                throw new Exception("Données insuffisantes pour l'insertion");
            }

            $query = "INSERT INTO enhancement (experience_cost, boost_value, id_type) VALUES (:experience_cost, :boost_value, :id_type)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':experience_cost' => htmlspecialchars(strip_tags($data['experience_cost'])),
                ':boost_value' => htmlspecialchars(strip_tags($data['boost_value'])),
                ':id_type' => htmlspecialchars(strip_tags($data['id_type']))
            ]);


            $response = ["success" => "enchantement ajouté", "id" => $db->lastInsertId()];
            break;

        case "update":
            if (!isset($data['id_enhancement'])) {
                throw new Exception("ID manquant");
            }

            $fields = [];
            $params = [':id_enhancement' => filter_var($data['id_enhancement'], FILTER_VALIDATE_INT)];

            if (!empty($data['experience_cost'])) {
                $fields[] = "experience_cost = :experience_cost";
                $params[':experience_cost'] = htmlspecialchars(strip_tags($data['experience_cost']));
            }
            if (!empty($data['boost_value'])) {
                $fields[] = "boost_value = :boost_value";
                $params[':boost_value'] = htmlspecialchars(strip_tags($data['boost_value']));
            }
            if (!empty($data['id_type'])) {
                $fields[] = "id_type = :id_type";
                $params[':id_type'] = htmlspecialchars(strip_tags($data['id_type']));
            }

            if (empty($fields)) {
                throw new Exception("Aucune donnée à modifier.");
            }

            $query = "UPDATE enhancement SET " . implode(", ", $fields) . " WHERE id_enhancement = :id_enhancement";
            $stmt = $db->prepare($query);
            $stmt->execute($params);

            $response = ["success" => "enchantement modifié !"];
            break;

        case "delete":
            if (!isset($data['id_enhancement'])) {
                throw new Exception("L'identifiant utilisateur est manquant.");
            }

            $query = "DELETE FROM users WHERE id_user = :id_user";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_enhancement' => filter_var($data['id_enhancement'], FILTER_VALIDATE_INT)]);

            $response = ["success" => "enchantement supprimé."];
            break;

        default:
            throw new Exception("Action non reconnue");
    }
} catch (Exception $e) {
    $response = ["error" => $e->getMessage()];
}

echo json_encode($response);
