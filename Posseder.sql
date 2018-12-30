/* Création "Posseder" */
/* Création de la table */
CREATE TABLE Posseder (
idOeuvre number(2),
idGenre number(2)
);

ALTER TABLE Posseder ADD CONSTRAINT pk_posseder PRIMARY KEY (idOeuvre, idGenre);
ALTER TABLE Posseder ADD CONSTRAINT fk_posseder_oeuvre FOREIGN KEY (idGenre) REFERENCES Genre (idGenre);
ALTER TABLE Posseder ADD CONSTRAINT fk_posseder_genre FOREIGN KEY (idOeuvre) REFERENCES Oeuvre (idOeuvre);

/* Insertion des valeurs */
INSERT INTO Posseder(idOeuvre, idGenre) VALUES ('1', '2');
INSERT INTO Posseder(idOeuvre, idGenre) VALUES ('2', '1');
INSERT INTO Posseder(idOeuvre, idGenre) VALUES ('3', '7');
INSERT INTO Posseder(idOeuvre, idGenre) VALUES ('4', '13');
INSERT INTO Posseder(idOeuvre, idGenre) VALUES ('5', '14');