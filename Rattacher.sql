/* Création "Rattacher" */
/* Création de la table */
CREATE TABLE Rattacher (
idUtilisateur number(2),
idFonction number(2)
);

ALTER TABLE Rattacher ADD CONSTRAINT pk_rattacher PRIMARY KEY (idUtilisateur, idFonction);
ALTER TABLE Rattacher ADD CONSTRAINT fk_rattacher_utilisateur FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur);
ALTER TABLE Rattacher ADD CONSTRAINT fk_rattacher_fonction FOREIGN KEY (idFonction) REFERENCES FonctionUtilisateur (idFonction);