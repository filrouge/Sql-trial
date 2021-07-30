/*#############################
###### VIN - Partie 3 #######
#############################*/

CREATE DATABASE IF NOT EXISTS Vignoble CHARACTER SET 'utf8';
USE Vignoble;
CREATE TABLE IF NOT EXISTS Vin (numVin INT PRIMARY KEY, appellation VARCHAR(25) NOT NULL, couleur VARCHAR(25) NOT NULL, annee INT NOT NULL, degre INT);
CREATE TABLE IF NOT EXISTS Producteur (numProd INT PRIMARY KEY , nom VARCHAR(25) NOT NULL, domaine VARCHAR(25) NOT NULL, region VARCHAR(25) NOT NULL);
CREATE TABLE IF NOT EXISTS Recolte (nProd INT, nVin INT, quantite INT);

INSERT INTO Producteur(numProd, nom, domaine, region) VALUES ('1', 'Producteur1', 'Graves', 'Bordeaux'), ('2', 'Producteur2', 'Domaine Roblet-Monnot', 'Bourgogne'), ('3', 'Producteur3', 'Domaine des Rouges', 'Bourgogne'), ('4', 'Dupont', 'Domaine Marcel Richaud', 'Côte DU Rhone'), ('5', 'Producteur5', 'La Grange Oncle', 'Alsace'), ('6', 'Producteur6', 'Domaine Pierre Labet', 'Bourgogne'), ('7', 'Dupond', 'Domaine Mikulski', 'Bourgogne'), ('8', 'Producteur8', 'Domaine Tissot', 'Jura'), ('9', 'Producteur9', 'Domaine Peyre Rose', 'Languedoc Roussillon'), ('10', 'Producteur10', 'Domaine Chapelas', 'Côte DU Rhone'), ('11', 'Producteur11', 'Domaine Pierre Labet', 'Côte DU Rhone')

INSERT INTO Vin (numVin, appellation, couleur, annee, degre) VALUES ('1', 'Château Villa Bel-Air', 'Rouge', '2014', '13'), ('2', 'Domaine Roblet-Monnot', 'Rouge', '2017', '13'), ('3', 'La Fussière', 'Rouge', '2017', '13'), ('4', 'Mistral AOC', 'Rouge', '2004', '15'),('5', 'La Grange Oncle Charles', 'Blanc', '2018', '13'), ('6', 'Vieilles Vignes', 'Blanc', '2017', '13'), ('7', 'Genevrière', 'Blanc', '1999', '13'), ('8', 'Cremant du Jura Blanc', 'Blanc', '2015', '15'), ('9', 'Syrah Leone', 'Rosé', '1995', '15'), ('10', 'Domaine Chapelas Rosé', 'Rosé', '2004', '14'), ('20', 'Vieilles Vignes', 'Blanc', '2000', '15')

INSERT INTO Recolte (nProd, nVin, quantite) VALUES ('1', '1', '20'), ('2', '2', '40'), ('3', '3', '50'), ('4', '4', '100'), ('5', '5', '70'), ('6', '6', '90'), ('7', '7', '200'), ('8', '8', '5'), ('9', '9', '25'), ('10', '10', '100'), ('11', '20', '70')

/*##########################
###### Foreing Key #######
##########################*/
ALTER TABLE Recolte
ADD CONSTRAINT fk_Vin_Recolte FOREIGN KEY (nVin) REFERENCES Vin (numVin)
ADD CONSTRAINT fk_Vin_Producteur FOREIGN KEY (nProd) REFERENCES Producteur (numProd)


/*####################
###### Simple ######
####################*/
SELECT appellation FROM Vin WHERE annee=1995
SELECT appellation, couleur, annee, degre FROM Vin WHERE annee > 2000
SELECT appellation FROM Vin WHERE annee BETWEEN 2000 AND 2009
SELECT appellation FROM Vin WHERE couleur='blanc' AND degre > 14
SELECT appellation FROM Vin WHERE UPPER(appellation) LIKE '%AOC%'
SELECT domaine FROM Producteur WHERE UPPER(region) LIKE UPPER('Bordeaux')
SELECT nom, region FROM Producteur WHERE numProd IN (SELECT nProd FROM Recolte WHERE nProd=5)
SELECT nom FROM Producteur WHERE UPPER(region) LIKE UPPER('Beaujolais')
SELECT nom FROM Producteur WHERE UPPER(nom) LIKE UPPER('%Dupon%')
SELECT nom FROM Producteur ORDER BY nom

/*##########################
###### Niveau moyen ######
##########################*/
SELECT annee, couleur FROM Vin WHERE degre=(SELECT MAX(degre) FROM Vin) ORDER BY annee DESC
SELECT * FROM Vin WHERE degre > (SELECT AVG(degre) FROM Vin) ORDER BY couleur ASC, degre DESC
SELECT appellation, couleur, MIN(degre), Max(degre) FROM Vin GROUP BY appellation, couleur;

/*##########################################
###### Multi-tables, avec jointures ######
##########################################*/
SELECT nom FROM Producteur LEFT JOIN Recolte ON numProd=nProd WHERE nVin=20 AND quantite > 50
SELECT COUNT(quantite) FROM Vin LEFT JOIN Recolte ON numVin=nVin WHERE annee=2004 AND couleur='rouge'
SELECT annee, SUM(quantite) FROM Vin LEFT JOIN Recolte ON nVin=numVin WHERE couleur='blanc' AND quantite !=0 GROUP BY annee
SELECT annee, AVG(degre) FROM Vin LEFT JOIN Recolte ON nVin=numVin WHERE couleur='blanc' AND quantite !=0 GROUP BY annee
SELECT nom, domaine FROM Producteur LEFT JOIN Recolte ON numProd=nProd LEFT JOIN Vin ON nVin=numVin WHERE couleur='rouge'
SELECT appellation, nProd, quantite FROM Vin LEFT JOIN Recolte ON nVin=numVin WHERE annee=1999 AND quantite=200;

/*##############################################################
###### Multi-tables, avec sous-requêtes (sans jointure) ######
##############################################################*/
SELECT nom FROM Producteur WHERE numProd IN (SELECT nProd FROM Recolte WHERE nVin= 20 AND quantite > 50)
SELECT COUNT(quantite) FROM Recolte WHERE nVin IN (SELECT numVin FROM Vin WHERE annee=2004 AND couleur='rouge')
SELECT annee, AVG(degre) FROM Vin WHERE numVin IN (SELECT nVin FROM Recolte WHERE quantite !=0) AND couleur='blanc' GROUP BY annee
SELECT nom, domaine FROM Producteur WHERE numProd IN (SELECT nProd FROM Recolte WHERE nVin IN (SELECT numVin FROM Vin WHERE couleur='rouge'))