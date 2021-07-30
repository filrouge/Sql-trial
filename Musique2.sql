CREATE DATABASE IF NOT EXISTS Musique CHARACTER SET 'utf8';
USE Musique;

CREATE TABLE IF NOT EXISTS Concert(nom VARCHAR(25) PRIMARY KEY, nomOrchestre VARCHAR(25) NOT NULL, date DATE NOT NULL, lieu VARCHAR(25) NOT NULL, prix INT, CONSTRAINT fk_orchestre_Concert FOREIGN KEY (nomOrchestre) REFERENCES Orchestre(nom));
CREATE TABLE IF NOT EXISTS Musicien (nom VARCHAR(25) PRIMARY KEY, instrument VARCHAR(25), anneeExperience INT, nomOrchestre VARCHAR(25) NOT NULL, CONSTRAINT fk_orchestre_Musicien FOREIGN KEY(nomOrchestre) REFERENCES Orchestre(nom));
CREATE TABLE IF NOT EXISTS Orchestre(nom VARCHAR(25) PRIMARY KEY, style VARCHAR(25), chef VARCHAR(25) NOT NULL);

INSERT INTO Concert (nom, nomOrchestre, date, lieu, prix) VALUES ('Ultrali', 'orchestre1', '2021-06-15', 'Stade de France', '500'), ('Die rich or trie dying', 'orchestre2', '2004-09-03', 'Zenith', '100'), ('Ultral', 'orchestre1', '2014-09-05', 'NY', '600'), ('Life', 'orchestre3', '2020-11-22', 'Dubai', '400'), ('Fiestea', 'orchestre3', 2010-07-12', 'Miami', '50'), ('Power', 'orchestre2', '1997-08-16'', 'Douala', '1000'), ('Mozart', 'orchestre5', '2019-04-20', 'Opéra Bastille', '10'), ('Zen', 'orchestre7', '2015-02-22', 'LA', '50'), ('Relax', 'orchestre6', '2016-01-01', 'PARIS', '200');
INSERT INTO Musicien (nom, instrument, anneeExperience, nomOrchestre) VALUES ('Yannick', 'guitare', '10', 'orchestre1'), ('Patrick', 'piano', '10', 'orchestre1'), ('Cedric', 'violon', '10', 'orchestre1'), ('Jordan', 'batterie', '2', 'orchestre2'), ('Gaelle', 'saxophone', '4', 'orchestre3'), ('Georges', 'harmonica', '20', 'orchestre6');
INSERT INTO Orchestre (nom, style, chef) VALUES ('orchestre1', 'jazz', 'leonardo'), ('orchestre2', 'pop', 'michaelgelo'), ('orchestre3', 'rnb', 'raphael'), ('orchestre4', 'house', 'donatello'), ('orchestre5', 'classic', 'Smith'), ('orchestre6', 'classic', 'Smith'), ('orchestre7', 'blues', 'Ray');

/*########################
##### Niveau Facile #####
#########################*/
/*mf01*/
SELECT nom, instrument FROM Musicien WHERE anneeExperience < 5
/*mf02*/
SELECT instrument FROM Musicien WHERE nomOrchestre = 'Jazz92'
/*mf03*/
SELECT * FROM Musicien WHERE instrument='violon';
/*mf04*/
SELECT instrument FROM Musicien WHERE anneeExperience > 20;
/*mf05*/
SELECT nom FROM Musicien WHERE anneeExperience BETWEEN 5 AND 10;
/*mf06*/
SELECT instrument FROM Musicien WHERE instrument LIKE 'vio%';
/*mf07*/
SELECT nom FROM Orchestre WHERE style LIKE '%jazz%';
/*mf08*/
SELECT nom FROM Orchestre WHERE chef = '%John Smith%';
/*mf09*/
SELECT nom FROM Concert ORDER BY nom ASC;
/*mf10*/
SELECT nom FROM Concert WHERE lieu='Versailles' AND date='2015-12-31';
/*mf11*/
SELECT lieu FROM Concert WHERE prix > 150;
/*mf12*/
SELECT nom FROM Concert WHERE lieu = 'Opéra Bastille' AND prix < 50;
/*mf13*/
SELECT nom FROM Concert WHERE date BETWEEN '2014-01-01' AND '2014-12-31';

/*########################
##### Niveau moyen   #####
#########################*/
/*mmtj01*/
SELECT Musicien.nom, instrument FROM Musicien LEFT JOIN Orchestre ON Orchestre.nom=Musicien.nomOrchestre WHERE Orchestre.style='jazz' AND anneeExperience > 3 ORDER BY Musicien.nom
/*mtj02*/
SELECT lieu FROM Concert LEFT JOIN Orchestre ON Concert.nomOrchestre=Orchestre.nom WHERE chef='Smith' AND prix > 20 ORDER BY lieu
/*mmtj03*/
SELECT COUNT(*) FROM Concert LEFT JOIN Orchestre ON Concert.nomOrchestre=Orchestre.nom WHERE (style='blues') OR (date BETWEEN '2015-01-01' AND '2015-12-31');
/*mmtj04*/
SELECT DISTINCT lieu, AVG(prix) FROM Concert LEFT JOIN Orchestre ON Concert.nomOrchestre=Orchestre.nom WHERE style='Jazz' GROUP BY lieu;
/*mmtj05*/
SELECT instrument FROM Musicien LEFT JOIN Orchestre ON Musicien.nomOrchestre=Orchestre.nom LEFT JOIN Concert ON Musicien.nomOrchestre=Concert.nomOrchestre WHERE (chef='Smith') AND (date='2016-01-01');
/*mmtj21*/
SELECT AVG(anneeExperience) FROM Musicien LEFT JOIN Orchestre ON Musicien.nomOrchestre=Orchestre.nom WHERE (instrument='saxophone') GROUP BY style;

