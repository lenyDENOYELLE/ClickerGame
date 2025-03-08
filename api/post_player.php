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
            if (!isset($data['pseudo'], $data['total_experience'], $data['id_ennemy'])) {
                throw new Exception("Données insuffisantes pour l'insertion");
            }

            $query = "INSERT INTO users (pseudo, total_experience, id_ennemy) VALUES (:pseudo, :total_experience, :id_ennemy)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':pseudo' => htmlspecialchars(strip_tags($data['pseudo'])),
                ':total_experience' => htmlspecialchars(strip_tags($data['total_experience'])),
                ':id_ennemy' => htmlspecialchars(strip_tags($data['id_ennemy']))
            ]);


            $response = ["success" => "Joueur ajouté", "id_player" => $db->lastInsertId()];
            break;

        case "update":
            if (!isset($data['id_player'])) {
                throw new Exception("ID manquant");
            }

            $fields = [];
            $params = [':id_player' => filter_var($data['id_player'], FILTER_VALIDATE_INT)];

            if (!empty($data['pseudo'])) {
                $fields[] = "pseudo = :pseudo";
                $params[':pseudo'] = htmlspecialchars(strip_tags($data['pseudo']));
            }
            if (!empty($data['total_experience'])) {
                $fields[] = "total_experience = :total_experience";
                $params[':total_experience'] = htmlspecialchars(strip_tags($data['total_experience']));
            }
            if (!empty($data['id_ennemy'])) {
                $fields[] = "id_ennemy = :id_ennemy";
                $params[':id_ennemy'] = htmlspecialchars(strip_tags($data['id_ennemy']));
            }

            if (empty($fields)) {
                throw new Exception("Aucune donnée à modifier.");
            }

            $query = "UPDATE player SET " . implode(", ", $fields) . " WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute($params);

            $response = ["success" => "Joueur modifié !"];
            break;

        case "delete":
            if (!isset($data['id_player'])) {
                throw new Exception("L'identifiant utilisateur est manquant.");
            }

            $query = "DELETE FROM player WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => filter_var($data['id_player'], FILTER_VALIDATE_INT)]);

            $response = ["success" => "Joueur supprimé."];
            break;

        default:
            throw new Exception("Action non reconnue");
    }
} catch (Exception $e) {
    $response = ["error" => $e->getMessage()];
}

echo json_encode($response);
