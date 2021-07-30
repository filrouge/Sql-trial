/*##########################
##### Partie 1 - BTP #####
##########################*/

CREATE DATABASE IF NOT EXISTS s6_mvc_btp CHARACTER SET 'utf8';
USE s6_mvc_btp;

CREATE TABLE Client(id INT(4) PRIMARY KEY, nom CHAR(25) NOT NULL, anneeNaiss INT(9), ville VARCHAR(25));
CREATE TABLE Fournisseur(id INT(4) PRIMARY KEY, nom CHAR(25) NOT NULL, age INT(9), ville VARCHAR(25));
CREATE TABLE Produit(label CHAR(25) , iDF INT(4), prix INT(9) NOT NULL, PRIMARY KEY (label, iDF));
CREATE TABLE Commande(num INT(4), idC INT(4), labelP CHAR(25), qte INT(4) NOT NULL, PRIMARY KEY (num, idC, labelP));

INSERT INTO Fournisseur (id, nom, age, ville) VALUES ('1', 'Abounayan', '52', '92190 Meudon'), ('2', 'Cima', '37', '44150 Nantes'), ('3', 'Preblocs', '48', '92230 Gennevilliers'), ('4', 'Samaco', '61', '75018 Paris'), ('5', 'Damasco', '29', '49100 Angers');
INSERT INTO Client (id, nom, anneeNaiss, ville) VALUES ('1', 'Jean', '1965', '75006 Paris'), ('2', 'Paul', '1958', '75003 Paris'), ('3', 'Vincent', '1954', '94200 Evry'), ('4', 'Pierre', '1950', '92400 Courbevoie'), ('5', 'Daniel', '1963', '44000 Nantes');
INSERT INTO Produit (label, iDF, prix) VALUES ('sable', '1', '300'), ('briques', '1', '1500'), ('parpaing', '1', '1150'), ('sable', '2', '350'), ('tulles', '3', '1200'), ('parpaing', '3', '1300'), ('briques', '4', '1500'), ('ciment', '4','1300'), ('parpaing', '4', '1450'), ('briques', '5', '1450'), ('tulles', '5', '1100');
INSERT INTO Commande (num, idC, labelP, qte) VALUES ('1', '1', 'briques', '5'), ('1', '1', 'ciment', '10'), ('2', '2', 'briques', '12'), ('2', '2', 'sable', '9'), ('2','2', 'parpaing', '15'), ('3', '3', 'sable', '17'), ('4', '4', 'briques', '8'), ('4', '4', 'Wiles', '17'), ('5', '5', 'parpaing', '10'), ('5', '5', 'ciment', '14'), ('6', '5', 'briques', '21'), ('7', '2', 'ciment', '12'), ('8', '4', 'parpaing', '8'), ('9', '1', 'tuiles', '15');


/*#Q1*/
SELECT * FROM Client
/*#Q2*/
SELECT nom, ville, anneeNaiss FROM client
/*#Q3*/
SELECT nom FROM Client WHERE anneeNaiss < 1971
/*#Q4*/
SELECT label FROM Produit GROUP BY label
/*#Q5*/
SELECT label FROM Produit GROUP BY label DESC
/*#Q6*/
SELECT * FROM Commande WHERE qte > 7 AND qte <= 18
SELECT * FROM Commande WHERE qte BETWEEN 8 AND 18
/*#Q7*/
SELECT nom, ville FROM Client WHERE nom LIKE 'P%'
/*#Q8*/
SELECT nom FROM Fournisseur WHERE ville LIKE '%Paris%'
/*#Q9*/
SELECT iDF, prix FROM Produit WHERE label='briques' OR label='parpaing'
SELECT iDF, prix FROM Produit WHERE label IN ('briques', 'parpaing')
/*#Q10*/
SELECT nom, labelP, qte FROM Client LEFT JOIN Commande ON Client.id = Commande.idC
/*#Q11*/
SELECT nom, label FROM Client CROSS JOIN Produit
/*#Q12*/
SELECT nom, labelP FROM Client LEFT JOIN Commande ON Client.id=Commande.idC WHERE labelP='briques' ORDER BY nom ASC
/*#Q13*/
SELECT nom FROM Fournisseur LEFT JOIN Produit ON Fournisseur.id=Produit.iDF WHERE label='briques' OR label='parpaing'
SELECT nom FROM Fournisseur WHERE Fournisseur.id IN (SELECT iDF FROM Produit WHERE label='briques' OR label='parpaing')
/*#Q1xx*/
SELECT label FROM Produit LEFT JOIN Fournisseur ON Produit.idF=Fournisseur.id WHERE ville LIKE '%Paris%'
SELECT label FROM Produit WHERE Produit.idF IN (SELECT id FROM Fournisseur WHERE ville LIKE '%Paris%')
SELECT * FROM Produit CROSS JOIN Fournisseur WHERE idF=id and ville LIKE '%Paris%'
/*#Q14*/
SELECT nom, ville FROM Client LEFT JOIN Commande ON Client.id=Commande.idC WHERE labelP='briques' AND qte BETWEEN 10 AND 15
/*#Q15*/
SELECT nom, label, prix FROM Fournisseur LEFT JOIN Produit ON fournisseur.id=produit.idF WHERE label in(SELECT labelP FROM Client LEFT JOIN Commande ON Client.id=Commande.idC where nom='Jean' )
/*#Q16*/
SELECT nom, label, prix FROM Fournisseur LEFT JOIN Produit ON fournisseur.id=produit.idF WHERE label in(SELECT labelP FROM Client LEFT JOIN Commande ON Client.id=Commande.idC where nom='Jean' ) ORDER BY nom DESC, label ASC
/*#Q17*/
SELECT label, AVG(prix) FROM Produit GROUP BY label
/*#Q18*/
SELECT label, AVG(prix) FROM Produit GROUP BY label HAVING AVG(prix) > 1200
/*#Q20*/
SELECT label FROM Produit GROUP BY label HAVING AVG(prix) < (SELECT AVG(prix) FROM Produit)
/*#Q21*/
SELECT label, AVG(prix) FROM Produit GROUP BY label HAVING COUNT(iDF)>2
SELECT label, AVG(prix) FROM Produit GROUP BY label HAVING COUNT(iDF) >= 3
