<?php
require_once('db.php');

// Définir les en-têtes CORS
header('Access-Control-Allow-Origin: *'); // Autoriser toutes les origines
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // Autoriser les méthodes GET, POST et OPTIONS
header('Access-Control-Allow-Headers: Content-Type'); // Autoriser l'en-tête Content-Type
header('Content-Type: application/json'); // Définir le type de contenu de la réponse


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
            if (!isset($data['pseudo'], $data['total_experience'], $data['id_enemy'])) {
                throw new Exception("Données insuffisantes pour l'insertion");
            }

            $query = "INSERT INTO player (pseudo, total_experience, id_enemy) VALUES (:pseudo, :total_experience, :id_enemy)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':pseudo' => htmlspecialchars(strip_tags($data['pseudo'])),
                ':total_experience' => htmlspecialchars(strip_tags($data['total_experience'])),
                ':id_enemy' => htmlspecialchars(strip_tags($data['id_enemy']))
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
            if (isset($data['total_experience'])) {
                $fields[] = "total_experience = :total_experience";
                $params[':total_experience'] = htmlspecialchars(strip_tags($data['total_experience']));
            }
            if (!empty($data['id_enemy'])) {
                $fields[] = "id_enemy = :id_enemy";
                $params[':id_enemy'] = htmlspecialchars(strip_tags($data['id_enemy']));
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
