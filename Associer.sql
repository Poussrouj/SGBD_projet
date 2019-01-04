/* Création "Associer" */
/* Création de la table */
CREATE TABLE Associer (
idOeuvre number(2),
idSupport number(2)
);

ALTER TABLE Associer ADD CONSTRAINT pk_associer PRIMARY KEY (idOeuvre, idSupport);
ALTER TABLE Associer ADD CONSTRAINT fk_associer_oeuvre FOREIGN KEY (idOeuvre) REFERENCES Oeuvre (idOeuvre);
ALTER TABLE Associer ADD CONSTRAINT fk_associer_support FOREIGN KEY (idSupport) REFERENCES Genre (idSupport);