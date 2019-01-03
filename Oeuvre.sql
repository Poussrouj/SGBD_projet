/* Création "Oeuvre" */
/* Création du type */
CREATE OR REPLACE TYPE TypeOeuvre AS OBJECT (
  idOeuvre number(2),
  titreOeuvre varchar(255),
  prixOeuvre number(2),
  description clob, /* du texte */
  critique clob,
  idSupport number(2),
  CONSTRUCTOR FUNCTION TypeOeuvre(idOeuvre number, titreOeuvre varchar, prixOeuvre number, description clob, critique clob, idSupport number) RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutOeuvre,
  MEMBER PROCEDURE supprimerOeuvre,
  MEMBER FUNCTION getOeuvre(idO number) RETURN TypeOeuvre,
  MEMBER FUNCTION oeuvreDisponible RETURN boolean,
  STATIC FUNCTION topTenOeuvresParGenre RETURN TypeOeuvre
);

/* Création de la table */
CREATE TABLE Oeuvre of TypeOeuvre;
ALTER TABLE Oeuvre ADD CONSTRAINT pk_oeuvre PRIMARY KEY (idOeuvre);
ALTER TABLE Oeuvre ADD CONSTRAINT fk_oeuvre FOREIGN KEY (idSupport) REFERENCES Support(idSupport);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeOeuvre AS
  CONSTRUCTOR FUNCTION TypeOeuvre(idOeuvre number, titreOeuvre varchar, prixOeuvre number, description clob, critique clob, idSupport number)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.idOeuvre := idOeuvre;
      SELF.titreOeuvre := titreOeuvre;
      SELF.prixOeuvre := prixOeuvre;
      SELF.description := description;
      SELF.critique := critique;
      SELF.idSupport := idSupport;
    END;
    
  MEMBER PROCEDURE ajoutOeuvre IS 
    BEGIN
      INSERT INTO Oeuvre VALUES (SELF.idOeuvre, SELF.titreOeuvre, SELF.prixOeuvre, SELF.description, SELF.critique, SELF.idSupport);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerOeuvre IS
    BEGIN
      DELETE FROM Oeuvre WHERE idOeuvre = SELF.idOeuvre;
      COMMIT;
    END;
    
  MEMBER FUNCTION getOeuvre(idO number) RETURN TypeOeuvre IS
    oeuvre TypeOeuvre;
    BEGIN
      SELECT TypeOeuvre(Oeuvre.idOeuvre, Oeuvre.titreOeuvre, Oeuvre.prixOeuvre, Oeuvre.description, Oeuvre.critique, Oeuvre.idSupport) INTO oeuvre FROM Oeuvre WHERE idOeuvre = idO;
      COMMIT;
      RETURN oeuvre;
    END;
    
    MEMBER FUNCTION oeuvreDisponible RETURN boolean IS
      idO number;
      maxDateEmprunt date;
      retour date;
      estDisponible boolean := true;
      BEGIN
        SELECT idOeuvre INTO idO FROM Oeuvre WHERE EXISTS (SELECT idOeuvre FROM Emprunter);
        IF idO <> null then
          SELECT MAX(dateEmprunt) INTO maxDateEmprunt FROM Emprunter WHERE  idOeuvre = SELF.idOeuvre;
          SELECT dateRetour INTO retour FROM Emprunter WHERE dateEmprunt = maxDateEmprunt;
          IF retour <> null THEN
            estDisponible := false;
            ELSE
          estDisponible := true;
        END IF;
        COMMIT;
      END IF;
        RETURN estDisponible;
    END;
    
    STATIC FUNCTION topTenOeuvresParGenre RETURN TypeOeuvre IS
    oeuvres TypeOeuvre;
    BEGIN
      SELECT TypeOeuvre(o.idOeuvre, o.titreOeuvre, o.prixOeuvre, o.description, o.critique, o.idSupport) INTO oeuvres FROM Emprunter e, Oeuvre o, Posseder p, Genre g 
      WHERE o.idOeuvre=e.idOeuvre AND p.idGenre = g.idGenre AND ROWNUM <= 10
      GROUP BY o.titreOeuvre
      ORDER BY Count(e.idOeuvre) DESC;
      COMMIT;
      RETURN oeuvres;
    END;
END;

/* Insertion des valeurs */
INSERT INTO Oeuvre(idOeuvre, titreOeuvre, prixOeuvre, description, critique, idSupport) VALUES ('1', 'Les Misérables', '12', 'Le cauchemar des Bac L', 'La critique', '1');
INSERT INTO Oeuvre(idOeuvre, titreOeuvre, prixOeuvre, description, critique, idSupport) VALUES ('2', 'Harry Potter à l''école des sorciers', '12', 'Avada Kedavra', 'C bi1 Ari Poteur', '2');
INSERT INTO Oeuvre(idOeuvre, titreOeuvre, prixOeuvre, description, critique, idSupport) VALUES ('3', 'Beat It', '10', 'Un des joyaux du défunt et très regretté Michael Jackson. RIP', 'C''est de la balle lol', '3');
INSERT INTO Oeuvre(idOeuvre, titreOeuvre, prixOeuvre, description, critique, idSupport) VALUES ('4', 'Public', '2', 'Le magazine des intellectuels', 'Les photos sont belles', '4');
INSERT INTO Oeuvre(idOeuvre, titreOeuvre, prixOeuvre, description, critique, idSupport) VALUES ('5', 'Le Monde', '1', 'Le contraire de Public', 'J''aime bien la police d''écriture', '5');
