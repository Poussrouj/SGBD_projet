/* Création "FonctionUtilisateur" */
/* Création du type */
CREATE OR REPLACE TYPE TypeFonctionUtilisateur AS OBJECT (
  idFonction number(2),
  nomFonction varchar(255),
  CONSTRUCTOR FUNCTION TypeFonctionUtilisateur(idFonction number, nomFonction varchar) RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutFonctionUtilisateur,
  MEMBER PROCEDURE supprimerFonctionUtilisateur,
  MEMBER FUNCTION getFonctionUtilisateur(idFU number) RETURN TypeFonctionUtilisateur
);

/* Création de la table */
CREATE TABLE FonctionUtilisateur of TypeFonctionUtilisateur;
ALTER TABLE FonctionUtilisateur ADD CONSTRAINT pk_fonction_utilisateur PRIMARY KEY (idFonction);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeFonctionUtilisateur AS
  CONSTRUCTOR FUNCTION TypeFonctionUtilisateur(idFonction number, nomFonction varchar)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.idFonction := idFonction;
      SELF.nomFonction := nomFonction;
    END;
    
  MEMBER PROCEDURE ajoutFonctionUtilisateur IS 
    BEGIN
      INSERT INTO FonctionUtilisateur VALUES (SELF.idFonction, SELF.nomFonction);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerFonctionUtilisateur IS
    BEGIN
      DELETE FROM FonctionUtilisateur WHERE idFonction = SELF.idFonction;
      COMMIT;
    END;
  
  MEMBER FUNCTION getFonctionUtilisateur(idFU number) RETURN TypeFonctionUtilisateur IS
    fonction TypeFonctionUtilisateur;
    BEGIN
      SELECT TypeFonctionUtilisateur(FonctionUtilisateur.idFonction, FonctionUtilisateur.nomFonction) INTO fonction FROM FonctionUtilisateur WHERE idFonction = idFU;
      COMMIT;
      RETURN fonction;
    END;
END;

/* Insertion des valeurs */
INSERT INTO fonctionUtilisateur(idFonction, nomFonction) VALUES ('1', 'Particulier');
INSERT INTO fonctionUtilisateur(idFonction, nomFonction) VALUES ('2', 'Société Privée');
INSERT INTO fonctionUtilisateur(idFonction, nomFonction) VALUES ('3', 'Etablissement public');