/* Création "Appartenir" */
/* Création de la table */
CREATE TABLE Appartenir (
idOeuvre number(2),
idArtiste number(2)
);
ALTER TABLE Appartenir ADD CONSTRAINT pk_appartenir PRIMARY KEY (idOeuvre, idArtiste);
ALTER TABLE Appartenir ADD CONSTRAINT fk_appartenir_ FOREIGN KEY (idOeuvre) REFERENCES Oeuvre (idOeuvre);
ALTER TABLE Appartenir ADD CONSTRAINT fk_appartenir_artiste FOREIGN KEY (idArtiste) REFERENCES Artiste (idArtiste);

/* Insertion des valeurs */
INSERT INTO Appartenir(idOeuvre, idArtiste) VALUES ('1', '4');
INSERT INTO Appartenir(idOeuvre, idArtiste) VALUES ('2', '2');
INSERT INTO Appartenir(idOeuvre, idArtistes) VALUES ('3', '5');
