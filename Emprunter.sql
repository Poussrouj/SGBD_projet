/* Création "Emprunter" */
/* Création du type */
CREATE OR REPLACE TYPE TypeEmprunter AS OBJECT (
  dateEmprunt date,
  dateRetour date,
  idUtilisateur number(2),
  idOeuvre number(2),
  CONSTRUCTOR FUNCTION TypeEmprunter(dateEmprunt date, dateRetour date, idUtilisateur number, idOeuvre number)
  RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutEmprunt,
  MEMBER PROCEDURE supprimerEmprunt,
  MEMBER FUNCTION getEmpruntUtilisateur (idU number) RETURN TypeEmprunter,
  MEMBER FUNCTION getEmpruntOeuvre (idO number) RETURN TypeEmprunter,
  MEMBER FUNCTION getEmprunt(idU number, idO number) RETURN TypeEmprunter
);

/* Création de la table */
CREATE TABLE Emprunter of TypeEmprunter;
ALTER TABLE Emprunter ADD CONSTRAINT pk_emprunter PRIMARY KEY (idUtilisateur, idOeuvre);
ALTER TABLE Emprunter ADD CONSTRAINT fk_emprunter_utilisateur FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur);
ALTER TABLE Emprunter ADD CONSTRAINT fk_emprunter_oeuvre FOREIGN KEY (idOeuvre) REFERENCES Oeuvre(idOeuvre);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeEmprunter AS
  CONSTRUCTOR FUNCTION TypeEmprunter(dateEmprunt date, dateRetour date, idUtilisateur number, idOeuvre number)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.dateEmprunt := dateEmprunt;
      SELF.dateRetour := dateRetour;
      SELF.idUtilisateur := idUtilisateur;
      SELF.idOeuvre := idOeuvre;
    END;
    
  MEMBER PROCEDURE ajoutEmprunt IS 
    BEGIN
      INSERT INTO Emprunter VALUES (SELF.dateEmprunt, SELF.dateRetour, SELF.idUtilisateur, SELF.idOeuvre);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerEmprunt IS
    BEGIN
      DELETE FROM Emprunter WHERE idUtilisateur = SELF.idUtilisateur AND idOeuvre = SELF.idOeuvre;
      COMMIT;
    END;
  
  MEMBER FUNCTION getEmpruntUtilisateur (idU number) RETURN TypeEmprunter IS
    emprunt TypeEmprunter;
    BEGIN
      SELECT TypeEmprunter(Emprunter.dateEmprunt, Emprunter.dateRetour, Emprunter.idUtilisateur, Emprunter.idOeuvre) INTO emprunt FROM Emprunter WHERE idUtilisateur = idU;
      COMMIT;
      RETURN emprunt;
    END;
    
  MEMBER FUNCTION getEmpruntOeuvre (idO number) RETURN TypeEmprunter IS
    emprunt TypeEmprunter;
    BEGIN
      SELECT TypeEmprunter(Emprunter.dateEmprunt, Emprunter.dateRetour, Emprunter.idUtilisateur, Emprunter.idOeuvre) INTO emprunt FROM Emprunter WHERE idOeuvre = idO;
      COMMIT;
      RETURN emprunt;
    END;
    
  MEMBER FUNCTION getEmprunt(idU number, idO number) RETURN TypeEmprunter IS
    emprunt TypeEmprunter;
    BEGIN
      SELECT TypeEmprunter(Emprunter.dateEmprunt, Emprunter.dateRetour, Emprunter.idUtilisateur, Emprunter.idOeuvre) INTO emprunt FROM Emprunter WHERE idUtilisateur = idU AND idOeuvre = idO;
      COMMIT;
      RETURN emprunt;
    END;
END;

/* Insertion des valeurs */
INSERT INTO Emprunter(dateEmprunt, dateRetour, idAbonne, idOeuvre) VALUES (TO_DATE('2018-11-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-12-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '4');
INSERT INTO Emprunter(dateEmprunt, idAbonne, idOeuvre) VALUES (TO_DATE('2018-08-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '3');
INSERT INTO Emprunter(dateEmprunt, dateRetour, idAbonne, idOeuvre) VALUES (TO_DATE('2018-12-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-12-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '3', '2');
INSERT INTO Emprunter(dateEmprunt, dateRetour, idAbonne, idOeuvre) VALUES (TO_DATE('2018-12-11 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-12-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '3', '4');
INSERT INTO Emprunter(dateEmprunt, idAbonne, idOeuvre) VALUES (TO_DATE('2018-12-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '4', '5');