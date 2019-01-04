/* Création "Detenir" */
/* Création de la table */
CREATE TABLE Detenir (
idUtilisateur number(2),
idAbonnement number(2)
);

ALTER TABLE Detenir ADD CONSTRAINT pk_detenir PRIMARY KEY (idUtilisateur, idAbonnement);
ALTER TABLE Detenir ADD CONSTRAINT fk_detenir_utilisateur FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur);
ALTER TABLE Detenir ADD CONSTRAINT fk_detenir_abonnement FOREIGN KEY (idAbonnement) REFERENCES Abonnement (idAbonnement);