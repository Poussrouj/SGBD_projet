/* Création "Artiste" */
/* Création du type */
CREATE OR REPLACE TYPE TypeArtiste AS OBJECT (
  idArtiste number(2),
  nomArtiste varchar(255),
  CONSTRUCTOR FUNCTION TypeArtiste(idArtiste number, nomArtiste varchar) RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutArtiste,
  MEMBER PROCEDURE supprimerArtiste,
  MEMBER FUNCTION getArtiste(idA number) RETURN TypeArtiste,
  STATIC FUNCTION topTenArtistesParGenre RETURN TypeArtiste
);

/* Création de la table */
CREATE TABLE Artiste of TypeArtiste;
ALTER TABLE Artiste ADD CONSTRAINT pk_artiste PRIMARY KEY (idArtiste);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeArtiste AS
  CONSTRUCTOR FUNCTION TypeArtiste(idArtiste number, nomArtiste varchar)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.idArtiste := idArtiste;
      SELF.nomArtiste := nomArtiste;
    END;
    
  MEMBER PROCEDURE ajoutArtiste IS 
    BEGIN
      INSERT INTO Artiste VALUES (SELF.idArtiste, SELF.nomArtiste);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerArtiste IS
    BEGIN
      DELETE FROM Artiste WHERE idArtiste = SELF.idArtiste;
      COMMIT;
    END;
    
  MEMBER FUNCTION getArtiste(idA number) RETURN TypeArtiste IS
    artiste TypeArtiste;
    BEGIN
      SELECT TypeArtiste(Artiste.idArtiste, Artiste.nomArtiste) INTO artiste FROM Artiste WHERE idArtiste = idA;
      COMMIT;
      RETURN artiste;
    END;
    
    STATIC FUNCTION topTenArtistesParGenre RETURN TypeArtiste IS
      artistes TypeArtiste;
      BEGIN
        SELECT TypeArtiste(a.idArtiste, a.nomArtiste) INTO artistes FROM Emprunter e, Oeuvre o, Posseder p, Genre g, Artiste a, Appartenir ap
        WHERE o.idOeuvre = e.idOeuvre AND p.idGenre = g.idGenre AND ROWNUM <= 10
        GROUP BY a.nomArtiste
        ORDER BY Count(ap.idArtiste) DESC;
        COMMIT;
        RETURN artistes;
      END;
END;

/* Insertion des valeurs */
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('1', 'Johnny Halliday');
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('2', 'J.K Rowling');
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('3', 'Guillaume Musso');
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('4', 'Victor Hugo');
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('5', 'Michael Jackson');
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('6', 'Maître Gims');
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('7', 'James Cameron');
INSERT INTO Artiste(idArtiste, nomArtiste) VALUES ('8', 'Harlan Coben');
