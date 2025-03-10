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
        case "update":
            if (!isset($data['id_player'])) {
                throw new Exception("ID manquant");
            }

            $fields = [];
            $params = [':player' => filter_var($data['player'], FILTER_VALIDATE_INT)];

            if (!empty($data['id_enhancement'])) {
                $fields[] = "id_enhancement = :id_enhancement";
                $params[':id_enhancement'] = htmlspecialchars(strip_tags($data['id_enhancement']));
            }

            if (empty($fields)) {
                throw new Exception("Aucune donnée à modifier.");
            }

            $query = "UPDATE buy SET " . implode(", ", $fields) . " WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute($params);

            $response = ["success" => "achat modifié !"];
            break;

        case "buy_enhancement":
            if (!isset($data['id_player'])) {
                throw new Exception("Données insuffisantes pour l'achat");
            }

            // Récupérer les améliorations déjà achetées par le joueur
            $query = "SELECT id_enhancement FROM buy WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => $data['id_player']]);
            $purchasedEnhancements = $stmt->fetchAll(PDO::FETCH_COLUMN);

            // Récupérer la prochaine amélioration disponible
            $query = "SELECT * FROM enhancement WHERE id_type = 1 AND id_enhancement NOT IN (" . implode(',', $purchasedEnhancements) . ") ORDER BY id_enhancement LIMIT 1";
            $stmt = $db->prepare($query);
            $stmt->execute();
            $nextEnhancement = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$nextEnhancement) {
                throw new Exception("Aucune amélioration disponible");
            }

            // Récupérer le joueur
            $query = "SELECT * FROM player WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => $data['id_player']]);
            $player = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$player) {
                throw new Exception("Joueur non trouvé");
            }

            // Vérifier si le joueur a assez d'expérience
            if ($player['total_experience'] < $nextEnhancement['experience_cost']) {
                throw new Exception("Expérience insuffisante");
            }

            // Mettre à jour les dégâts du joueur
            $newDamage = $player['damage'] + $nextEnhancement['boost_value'];
            $newExperience = $player['total_experience'] - $nextEnhancement['experience_cost'];

            $query = "UPDATE player SET damage = :damage, total_experience = :total_experience WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':damage' => $newDamage,
                ':total_experience' => $newExperience,
                ':id_player' => $data['id_player'],
            ]);

            // Enregistrer l'achat
            $query = "INSERT INTO buy (id_player, id_enhancement) VALUES (:id_player, :id_enhancement)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':id_player' => $data['id_player'],
                ':id_enhancement' => $nextEnhancement['id_enhancement'],
            ]);

            // Récupérer le joueur mis à jour
            $query = "SELECT * FROM player WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => $data['id_player']]);
            $updatedPlayer = $stmt->fetch(PDO::FETCH_ASSOC);

            // Renvoyer la réponse
            $response = [
                "success" => "Amélioration achetée !",
                "player" => $updatedPlayer,
                "next_enhancement" => $nextEnhancement, // Optionnel : renvoyer la prochaine amélioration
            ];
            break;


        case "buy_xp_enhancement":
            if (!isset($data['id_player'])) {
                throw new Exception("Données insuffisantes pour l'achat");
            }

            // Récupérer les améliorations déjà achetées par le joueur
            $query = "SELECT id_enhancement FROM buy WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => $data['id_player']]);
            $purchasedEnhancements = $stmt->fetchAll(PDO::FETCH_COLUMN);

            // Récupérer la prochaine amélioration disponible pour le gain d'XP
            $query = "SELECT * FROM enhancement WHERE id_type = 2 AND id_enhancement NOT IN (" . implode(',', $purchasedEnhancements) . ") ORDER BY id_enhancement LIMIT 1";
            $stmt = $db->prepare($query);
            $stmt->execute();
            $nextEnhancement = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$nextEnhancement) {
                throw new Exception("Aucune amélioration disponible");
            }

            // Récupérer le joueur
            $query = "SELECT * FROM player WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => $data['id_player']]);
            $player = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$player) {
                throw new Exception("Joueur non trouvé");
            }

            // Vérifier si le joueur a assez d'expérience
            if ($player['total_experience'] < $nextEnhancement['experience_cost']) {
                throw new Exception("Expérience insuffisante");
            }

            // Mettre à jour le gain_xp du joueur
            $newGainXp = $player['gain_xp'] + $nextEnhancement['boost_value'];
            $newExperience = $player['total_experience'] - $nextEnhancement['experience_cost'];

            $query = "UPDATE player SET gain_xp = :gain_xp, total_experience = :total_experience WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':gain_xp' => $newGainXp,
                ':total_experience' => $newExperience,
                ':id_player' => $data['id_player'],
            ]);

            // Enregistrer l'achat
            $query = "INSERT INTO buy (id_player, id_enhancement) VALUES (:id_player, :id_enhancement)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':id_player' => $data['id_player'],
                ':id_enhancement' => $nextEnhancement['id_enhancement'],
            ]);

            // Récupérer le joueur mis à jour
            $query = "SELECT * FROM player WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => $data['id_player']]);
            $updatedPlayer = $stmt->fetch(PDO::FETCH_ASSOC);

            // Renvoyer la réponse
            $response = [
                "success" => "Amélioration de gain d'XP achetée !",
                "player" => $updatedPlayer,
            ];
            break;
        default:
            throw new Exception("Action non reconnue");
    }
} catch (Exception $e) {
    $response = ["error" => $e->getMessage()];
}

echo json_encode($response);
