-- Création de la base
CREATE DATABASE tifosi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tifosi;

-- Création de l'utilisateur
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'motdepasse123';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- TABLE ingredients
CREATE TABLE ingredients (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(40) NOT NULL UNIQUE
);

-- TABLE client
CREATE TABLE client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(40) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    code_postal INT NOT NULL
);

-- TABLE marque
CREATE TABLE marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(40) NOT NULL UNIQUE
);

-- TABLE focaccia
CREATE TABLE focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(40) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL CHECK (prix >= 0)
);

-- TABLE menu
CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(40) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL CHECK (prix >= 0)
);

-- TABLE boisson
CREATE TABLE boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(40) NOT NULL UNIQUE,
    id_marque INT NOT NULL,
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque) ON DELETE CASCADE
);

-- RELATION comprend : focaccia <-> ingredient
CREATE TABLE comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_focaccia, id_ingredient),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia) ON DELETE CASCADE,
    FOREIGN KEY (id_ingredient) REFERENCES ingredients(id_ingredient) ON DELETE CASCADE
);

-- RELATION est_constitue : menu <-> focaccia
CREATE TABLE est_constitue (
    id_menu INT NOT NULL,
    id_focaccia INT NOT NULL,
    PRIMARY KEY (id_menu, id_focaccia),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu) ON DELETE CASCADE,
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia) ON DELETE CASCADE
);

-- RELATION contient : menu <-> boisson
CREATE TABLE contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu) ON DELETE CASCADE,
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson) ON DELETE CASCADE
);

-- RELATION achete : client <-> menu
CREATE TABLE achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    date_achat DATE NOT NULL,
    PRIMARY KEY (id_client, id_menu, date_achat),
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu) ON DELETE CASCADE
);
