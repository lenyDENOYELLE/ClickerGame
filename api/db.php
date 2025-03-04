<?php

    $dns = 'mysql:host=localhost;dbname=flutterproject'; // A modifier
    $user = 'root'; // Modifier le nom d'utilisateur
    $password = ''; // Modifier le mot de passe

    try {
        $db = new PDO($dns, $user, $password);
    } catch (PDOException $e) {
        $error = $e->getMessage();
        echo $error;
    }
