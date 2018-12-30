/* Création "Abonnement" */
/* Création du type */
CREATE OR REPLACE TYPE TypeAbonnement AS OBJECT (
  idAbonnement number(2),
  idUtilisateur number(2),
  prixAbonnement number(2),
  dateAbonnement date,
  dateRenouvellement date,
  estRegle number(1),
  CONSTRUCTOR FUNCTION TypeAbonnement(idAbonnement number, idUtilisateur number, prixAbonnement number, dateAbonnement date, dateRenouvellement date, estRegle number)
  RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutAbonnement,
  MEMBER PROCEDURE supprimerAbonnement,
  MEMBER FUNCTION getAbonnement(idA number) RETURN TypeAbonnement,
  MEMBER PROCEDURE aPaye,
  MEMBER PROCEDURE rappelRenouvellement
);

/* Création de la table */
CREATE TABLE Abonnement of TypeAbonnement;
ALTER TABLE Abonnement ADD CONSTRAINT pk_abonnement PRIMARY KEY (idAbonnement);
ALTER TABLE Abonnement ADD CONSTRAINT fk_abonnement_utilisateur FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeAbonnement AS
  CONSTRUCTOR FUNCTION TypeAbonnement(idAbonnement number, idUtilisateur number, prixAbonnement number, dateAbonnement date, dateRenouvellement date, estRegle number)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.idAbonnement := idAbonnement;
      SELF.idUtilisateur := idUtilisateur;
      SELF.prixAbonnement := prixAbonnement;
      SELF.dateAbonnement := dateAbonnement;
      SELF.dateRenouvellement := dateRenouvellement;
      SELF.estRegle := estRegle;
    END;
    
  MEMBER PROCEDURE ajoutAbonnement IS 
    BEGIN
      INSERT INTO Abonnement VALUES (SELF.idAbonnement, SELF.idUtilisateur, SELF.prixAbonnement, SELF.dateAbonnement, SELF.dateRenouvellement, SELF.estRegle);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerAbonnement IS
    BEGIN
      DELETE FROM Abonnement WHERE idAbonnement = SELF.idAbonnement;
      COMMIT;
    END;
  
  MEMBER FUNCTION getAbonnement(idA number) RETURN TypeAbonnement IS
    abonnement TypeAbonnement;
    BEGIN
      SELECT TypeAbonnement(Abonnement.idAbonnement, Abonnement.idUtilisateur, Abonnement.prixAbonnement, Abonnement.dateAbonnement, Abonnement.dateRenouvellement, Abonnement.estRegle) INTO abonnement FROM Abonnement WHERE idAbonnement = idA;
      COMMIT;
      RETURN abonnement;
    END;
    
    MEMBER PROCEDURE aPaye IS
      utilisateur TypeUtilisateur;
      BEGIN
        utilisateur := utilisateur.getUtilisateur(SELF.idUtilisateur);
        IF SELF.estRegle = '0' THEN
          DBMS_OUTPUT.put_line('L abonne ' || utilisateur.nomUtilisateur || ' ' || utilisateur.prenomUtilisateur || 'n a pas payé son abonnement'); 
        ELSE
          DBMS_OUTPUT.put_line('L abonne ' || utilisateur.nomUtilisateur || ' ' || utilisateur.prenomUtilisateur || 'a payé son abonnement'); 
        END IF;
      COMMIT;
      END;
    
    MEMBER PROCEDURE rappelRenouvellement IS
    dateAujourdhui date;
    utilisateur TypeUtilisateur;
      BEGIN
        SELECT SYSDATE into dateAujourdhui FROM DUAL;
        utilisateur := utilisateur.getUtilisateur(SELF.idUtilisateur);
        IF SELF.estRegle = '0' AND SELF.dateRenouvellement <= dateAujourdhui THEN
          DBMS_OUTPUT.put_line('La date de renouvellement est dépassé. Mail envoyé à l abonne : ' || utilisateur.nomUtilisateur || ' ' || utilisateur.prenomUtilisateur); 
        END IF;
      COMMIT;
    END;
END;

/* Insertion des valeurs */