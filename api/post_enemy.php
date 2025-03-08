<?php
require_once('db.php');

// Définir les en-têtes CORS
header('Access-Control-Allow-Origin: *'); // Autoriser toutes les origines
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // Autoriser les méthodes GET, POST et OPTIONS
header('Access-Control-Allow-Headers: Content-Type'); // Autoriser l'en-tête Content-Type
header('Content-Type: application/json'); // Définir le type de contenu de la réponse

// Gérer les requêtes OPTIONS (pré-vol)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    // Répondre uniquement avec les en-têtes CORS
    exit;
}

// Vérifier que la méthode de la requête est POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405); // Méthode non autorisée
    echo json_encode(["error" => "Méthode non autorisée"]);
    exit;
}

// Lire et décoder les données JSON envoyées
$data = json_decode(file_get_contents("php://input"), true);
if (!$data) {
    http_response_code(400); // Mauvaise requête
    echo json_encode(["error" => "Données JSON invalides"]);
    exit;
}

// Vérifier si l'action est définie
if (!isset($data['action'])) {
    http_response_code(400); // Mauvaise requête
    echo json_encode(["error" => "Aucune action spécifiée"]);
    exit;
}

$action = $data['action'];
$response = [];

try {
    switch ($action) {
        case "insert":
            if (!isset($data['name'], $data['total_life'], $data['current_life'])) {
                throw new Exception("Données insuffisantes pour l'insertion");
            }

            $query = "INSERT INTO enemy (name, total_life, current_life) VALUES (:name, :total_life, :current_life)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':name' => htmlspecialchars(strip_tags($data['name'])),
                ':total_life' => ($data['total_life']),
                ':current_life' => ($data['current_life'])

            ]);


            $response = ["success" => "ennemie ajouté", "level" => $db->lastInsertId()];
            break;

        case "update":
            if (!isset($data['level'])) {
                throw new Exception("ID manquant");
            }

            $fields = [];
            $params = [':level' => filter_var($data['level'], FILTER_VALIDATE_INT)];

            if (!empty($data['name'])) {
                $fields[] = "name = :name";
                $params[':name'] = htmlspecialchars(strip_tags($data['name']));
            }
            if (!empty($data['total_life'])) {
                $fields[] = "total_life = :total_life";
                $params[':total_life'] = htmlspecialchars(strip_tags($data['total_life']));
            }

            /*
            if (!empty($data['current_life'])) {
                $fields[] = "current_life = :current_life";
                $params[':current_life'] = htmlspecialchars(strip_tags($data['current_life']));
            }
            */


            if (isset($data['current_life'])) { // Vérifier si current_life est défini
                $fields[] = "current_life = :current_life";
                $params[':current_life'] = htmlspecialchars(strip_tags($data['current_life']));
            }

            if (empty($fields)) {
                throw new Exception("Aucune donnée à modifier.");
            }

            $query = "UPDATE enemy SET " . implode(", ", $fields) . " WHERE level = :level";
            $stmt = $db->prepare($query);
            $stmt->execute($params);

            $response = ["success" => "ennemie modifié !"];
            break;

        case "delete":
            if (!isset($data['level'])) {
                throw new Exception("L'identifiant utilisateur est manquant.");
            }

            $query = "DELETE FROM enemy WHERE level = :level";
            $stmt = $db->prepare($query);
            $stmt->execute([':level' => filter_var($data['level'], FILTER_VALIDATE_INT)]);

            $response = ["success" => "ennemie supprimé."];
            break;

        default:
            throw new Exception("Action non reconnue");
    }
} catch (Exception $e) {
    $response = ["error" => $e->getMessage()];
}

echo json_encode($response);
