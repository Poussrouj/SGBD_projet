/* Création "Support" */
/* Création du type */
CREATE OR REPLACE TYPE TypeSupport AS OBJECT (
  idSupport number(2),
  nomSupport varchar(255),
  CONSTRUCTOR FUNCTION TypeSupport(idSupport number, nomSupport varchar) RETURN SELF AS RESULT,
  MEMBER PROCEDURE ajoutSupport,
  MEMBER PROCEDURE supprimerSupport,
  MEMBER FUNCTION getSupport(idS number) RETURN TypeSupport
);

/* Création de la table */
CREATE TABLE Support of TypeSupport;
ALTER TABLE Support ADD CONSTRAINT pk_support PRIMARY KEY (idSupport);

/* Création du body */
CREATE OR REPLACE TYPE BODY TypeSupport AS
  CONSTRUCTOR FUNCTION TypeSupport(idSupport number, nomSupport varchar)
    RETURN SELF AS RESULT IS
    BEGIN
      SELF.idSupport := idSupport;
      SELF.nomSupport := nomSupport;
    END;
    
  MEMBER PROCEDURE ajoutSupport IS 
    BEGIN
      INSERT INTO Support VALUES (SELF.idSupport, SELF.nomSupport);
      COMMIT;
    END;
  
  MEMBER PROCEDURE supprimerSupport IS
    BEGIN
      DELETE FROM Support WHERE idSupport = SELF.idSupport;
      DELETE FROM Oeuvre WHERE idSupport = SELF.idSupport;
      COMMIT;
    END;
    
  MEMBER FUNCTION getSupport(idS number) RETURN TypeSupport IS
    support TypeSupport;
    BEGIN
      SELECT TypeSupport(Support.idSupport, Support.nomSupport) INTO support FROM Support WHERE idSupport = idS;
      COMMIT;
      RETURN support;
    END;
END;

/* Insertion des valeurs */
INSERT INTO Support(idSupport, nomSupport) VALUES ('1', 'Livre');
INSERT INTO Support(idSupport, nomSupport) VALUES ('2', 'DVD');
INSERT INTO Support(idSupport, nomSupport) VALUES ('3', 'CD');
INSERT INTO Support(idSupport, nomSupport) VALUES ('4', 'Magazine');
INSERT INTO Support(idSupport, nomSupport) VALUES ('5', 'Journal');