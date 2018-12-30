/* Création "Genre" */
/* Création du type */
CREATE OR REPLACE TYPE TypeGenre AS OBJECT (
  idGenre number(2),
  nomGenre varchar(255),
  CONSTRUCTOR FUNCTION TypeGenre(idGenre number, nomGenre varchar) RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutGenre,
  MEMBER PROCEDURE supprimerGenre,
  MEMBER FUNCTION getGenre(idG number) RETURN TypeGenre
);

/* Création de la table */
CREATE TABLE Genre of TypeGenre;
ALTER TABLE Genre ADD CONSTRAINT pk_genre PRIMARY KEY (idGenre);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeGenre AS
  CONSTRUCTOR FUNCTION TypeGenre(idGenre number, nomGenre varchar)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.idGenre := idGenre;
      SELF.nomGenre := nomGenre;
    END;
    
  MEMBER PROCEDURE ajoutGenre IS 
    BEGIN
      INSERT INTO Genre VALUES (SELF.idGenre, SELF.nomGenre);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerGenre IS
    BEGIN
      DELETE FROM Genre WHERE idGenre = SELF.idGenre;
      COMMIT;
    END;
  
  MEMBER FUNCTION getGenre(idG number) RETURN TypeGenre IS
    genre TypeGenre;
    BEGIN
      SELECT TypeGenre(Genre.idGenre, Genre.nomGenre) INTO genre FROM Genre WHERE idGenre = idG;
      COMMIT;
      RETURN genre;
    END;
END;

/* Insertion des valeurs */
INSERT INTO Genre(idGenre, nomGenre) VALUES ('1', 'Fantastique');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('2', 'Dramatique');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('3', 'Policier');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('4', 'Romance');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('5', 'Science-Fiction');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('6', 'Rock');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('7', 'Pop');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('8', 'Rap');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('9', 'Electro');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('10', 'Classique');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('11', 'Tectonique');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('12', 'Comique');
INSERT INTO Genre(idGenre, nomGenre) VALUES ('13', 'Horreur');