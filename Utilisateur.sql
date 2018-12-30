/* Création "Utilisateur" */
/* Création du type */
CREATE OR REPLACE TYPE TypeUtilisateur AS OBJECT (
  idUtilisateur number(2),
  nomUtilisateur varchar(255),
  prenomUtilisateur varchar(255),
  adresseUtilisateur varchar(255),
  telephoneUtilisateur varchar(10),
  mailUtilisateur varchar(255),
  idFonction number(2),
  CONSTRUCTOR FUNCTION TypeUtilisateur(idUtilisateur number, nomUtilisateur varchar, prenomUtilisateur varchar, adresseUtilisateur varchar, telephoneUtilisateur varchar, mailUtilisateur varchar)
  RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutUtilisateur,
  MEMBER PROCEDURE supprimerUtilisateur,
  STATIC FUNCTION getUtilisateur(idU number) RETURN TypeUtilisateur
);

/* Création de la table */
CREATE TABLE Utilisateur of TypeUtilisateur;
ALTER TABLE Utilisateur ADD CONSTRAINT pk_utilisateur PRIMARY KEY (idUtilisateur);
ALTER TABLE Utilisateur ADD CONSTRAINT fk_utilisateur_fonction FOREIGN KEY (idFonction) REFERENCES FonctionUtilisateur(idFonction);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeUtilisateur AS
  CONSTRUCTOR FUNCTION TypeUtilisateur(idUtilisateur number, nomUtilisateur varchar, prenomUtilisateur varchar, adresseUtilisateur varchar, telephoneUtilisateur varchar, mailUtilisateur varchar)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.idUtilisateur := idUtilisateur;
      SELF.nomUtilisateur := nomUtilisateur;
      SELF.prenomUtilisateur := prenomUtilisateur;
      SELF.adresseUtilisateur := adresseUtilisateur;
      SELF.telephoneUtilisateur := telephoneUtilisateur;
      SELF.mailUtilisateur := mailUtilisateur;
      SELF.idFonction := idFonction;
    END;
    
  MEMBER PROCEDURE ajoutUtilisateur IS 
    BEGIN
      INSERT INTO Utilisateur VALUES (SELF.idUtilisateur, SELF.nomUtilisateur, SELF.prenomUtilisateur, SELF.adresseUtilisateur, SELF.telephoneUtilisateur, SELF.mailUtilisateur, SELF.idFonction);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerUtilisateur IS
    BEGIN
      DELETE FROM Utilisateur WHERE idUtilisateur = SELF.idUtilisateur;
      COMMIT;
    END;
  
  STATIC FUNCTION getUtilisateur(idU number) RETURN TypeUtilisateur IS
    utilisateur TypeUtilisateur;
    BEGIN
      SELECT TypeUtilisateur(Utilisateur.idUtilisateur, Utilisateur.nomUtilisateur, Utilisateur.prenomUtilisateur, Utilisateur.adresseUtilisateur, Utilisateur.telephoneUtilisateur, Utilisateur.mailUtilisateur, Utilisateur.idFonction) INTO utilisateur FROM Utilisateur WHERE idUtilisateur = idU;
      COMMIT;
      RETURN utilisateur;
    END;
END;

/* Insertion des valeurs */
INSERT INTO Utilisateur(idUtilisateur, nomUtilisateur, prenomUtilisateur, adresseUtilisateur, telephoneUtilisateur, mailUtilisateur, idFonction) VALUES ('1', 'MONGE', 'Maxime', '15 rue des coquelicot', '0666666666', 'maxime.monge@lablague.fr', '1');
INSERT INTO Utilisateur(idUtilisateur, nomUtilisateur, prenomUtilisateur, adresseUtilisateur, telephoneUtilisateur, mailUtilisateur, idFonction) VALUES ('2', 'BALAT', 'Audrey', '178 bis Pôle Emploi', '0625639865', 'pole_emploi@travail.fr', '3');
INSERT INTO Utilisateur(idUtilisateur, nomUtilisateur, prenomUtilisateur, adresseUtilisateur, telephoneUtilisateur, mailUtilisateur, idFonction) VALUES ('3', 'MAABOUT', 'Sofian', '251 cours de la Libération', '0736482913', 'sofian.maabout@labri.fr', '2');
INSERT INTO Utilisateur(idUtilisateur, nomUtilisateur, prenomUtilisateur, adresseUtilisateur, telephoneUtilisateur, mailUtilisateur, idFonction) VALUES ('4', 'CHRIST', 'Jésus', '10 rue de la Croix', '0777777777', 'jesus.net', '1');