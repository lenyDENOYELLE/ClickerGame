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
            if (!isset($data['name_type'])) {
                throw new Exception("Données insuffisantes pour l'insertion");
            }

            $query = "INSERT INTO users (name_type) VALUES (:name_type)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':name_type' => htmlspecialchars(strip_tags($data['name_type'])),
            ]);


            $response = ["success" => "type d'enchantement ajouté", "id_type" => $db->lastInsertId()];
            break;

        case "update":
            if (!isset($data['id_type'])) {
                throw new Exception("ID manquant");
            }

            $fields = [];
            $params = [':id_type' => filter_var($data['id_type'], FILTER_VALIDATE_INT)];

            if (!empty($data['name_type'])) {
                $fields[] = "name_type = :name_type";
                $params[':name_type'] = htmlspecialchars(strip_tags($data['name_type']));
            }

            if (empty($fields)) {
                throw new Exception("Aucune donnée à modifier.");
            }

            $query = "UPDATE type_enhancement SET " . implode(", ", $fields) . " WHERE id_type = :id_type";
            $stmt = $db->prepare($query);
            $stmt->execute($params);

            $response = ["success" => "type d'enchantement modifié !"];
            break;

        case "delete":
            if (!isset($data['id_type'])) {
                throw new Exception("L'identifiant utilisateur est manquant.");
            }

            $query = "DELETE FROM type_enhancement WHERE id_type = :id_type";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_type' => filter_var($data['id_type'], FILTER_VALIDATE_INT)]);

            $response = ["success" => "type enchantement supprimé."];
            break;

        default:
            throw new Exception("Action non reconnue");
    }
} catch (Exception $e) {
    $response = ["error" => $e->getMessage()];
}

echo json_encode($response);
