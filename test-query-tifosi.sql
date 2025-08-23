USE tifosi;

-- 1. Liste des noms de focaccias par ordre alphabétique
SELECT nom FROM focaccia ORDER BY nom ASC;

-- 2. Nombre total d'ingrédients
SELECT COUNT(*) AS nb_ingredients FROM ingredients;

-- 3. Prix moyen des focaccias
SELECT AVG(prix) AS prix_moyen FROM focaccia;

-- 4. Liste des boissons avec leur marque
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom;

-- 5. Ingrédients pour une Raclaccia
SELECT i.nom
FROM ingredients i
JOIN comprend c ON i.id_ingredient = c.id_ingredient
JOIN focaccia f ON f.id_focaccia = c.id_focaccia
WHERE f.nom = 'Raclaccia';

-- 6. Nom + nombre d'ingrédients par focaccia
SELECT f.nom, COUNT(c.id_ingredient) AS nb_ingredients
FROM focaccia f
LEFT JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.nom;

-- 7. Focaccia avec le plus d'ingrédients
SELECT f.nom
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.nom
ORDER BY COUNT(c.id_ingredient) DESC
LIMIT 1;

-- 8. Focaccia contenant de l'ail
SELECT DISTINCT f.nom
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
JOIN ingredients i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail';

-- 9. Ingrédients inutilisés
SELECT i.nom
FROM ingredients i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_focaccia IS NULL;

-- 10. Focaccia sans champignons
SELECT DISTINCT f.nom
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT c.id_focaccia
    FROM comprend c
    JOIN ingredients i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = "Champignons"
);
