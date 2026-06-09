DROP DATABASE IF EXISTS autorijschool;
CREATE DATABASE autorijschool CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE autorijschool;

CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL DEFAULT 'instructeur',
    email_verified_at TIMESTAMP NULL,
    password VARCHAR(255) NOT NULL,
    remember_token VARCHAR(100) NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE password_reset_tokens (
    email VARCHAR(255) PRIMARY KEY,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL
);

CREATE TABLE sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload LONGTEXT NOT NULL,
    last_activity INT NOT NULL,
    INDEX sessions_user_id_index (user_id),
    INDEX sessions_last_activity_index (last_activity)
);

CREATE TABLE cache (
    `key` VARCHAR(255) PRIMARY KEY,
    value MEDIUMTEXT NOT NULL,
    expiration BIGINT NOT NULL,
    INDEX cache_expiration_index (expiration)
);

CREATE TABLE cache_locks (
    `key` VARCHAR(255) PRIMARY KEY,
    owner VARCHAR(255) NOT NULL,
    expiration BIGINT NOT NULL,
    INDEX cache_locks_expiration_index (expiration)
);

CREATE TABLE jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    queue VARCHAR(255) NOT NULL,
    payload LONGTEXT NOT NULL,
    attempts SMALLINT UNSIGNED NOT NULL,
    reserved_at INT UNSIGNED NULL,
    available_at INT UNSIGNED NOT NULL,
    created_at INT UNSIGNED NOT NULL,
    INDEX jobs_queue_index (queue)
);

CREATE TABLE job_batches (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    total_jobs INT NOT NULL,
    pending_jobs INT NOT NULL,
    failed_jobs INT NOT NULL,
    failed_job_ids LONGTEXT NOT NULL,
    options MEDIUMTEXT NULL,
    cancelled_at INT NULL,
    created_at INT NOT NULL,
    finished_at INT NULL
);

CREATE TABLE failed_jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(255) NOT NULL UNIQUE,
    connection VARCHAR(255) NOT NULL,
    queue VARCHAR(255) NOT NULL,
    payload LONGTEXT NOT NULL,
    exception LONGTEXT NOT NULL,
    failed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX failed_jobs_connection_queue_failed_at_index (connection, queue, failed_at)
);

CREATE TABLE instructeurs (
    Id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Voornaam VARCHAR(80) NOT NULL,
    Tussenvoegsel VARCHAR(20) NULL,
    Achternaam VARCHAR(80) NOT NULL,
    Mobiel VARCHAR(15) NOT NULL,
    DatumInDienst DATE NOT NULL,
    AantalSterren VARCHAR(5) NOT NULL,
    IsActief TINYINT(1) NOT NULL DEFAULT 1,
    Opmerking VARCHAR(255) NULL,
    DatumAangemaakt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    DatumGewijzigd TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE type_voertuigen (
    Id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeVoertuig VARCHAR(80) NOT NULL,
    Rijbewijscategorie VARCHAR(5) NOT NULL,
    IsActief TINYINT(1) NOT NULL DEFAULT 1,
    Opmerking VARCHAR(255) NULL,
    DatumAangemaakt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    DatumGewijzigd TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE voertuigen (
    Id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Kenteken VARCHAR(10) NOT NULL UNIQUE,
    Type VARCHAR(80) NOT NULL,
    Bouwjaar DATE NOT NULL,
    Brandstof VARCHAR(20) NOT NULL,
    TypeVoertuigId BIGINT UNSIGNED NOT NULL,
    IsActief TINYINT(1) NOT NULL DEFAULT 1,
    Opmerking VARCHAR(255) NULL,
    DatumAangemaakt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    DatumGewijzigd TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_voertuigen_type_voertuigen
        FOREIGN KEY (TypeVoertuigId) REFERENCES type_voertuigen(Id)
);

CREATE TABLE voertuig_instructeur (
    Id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    VoertuigId BIGINT UNSIGNED NOT NULL UNIQUE,
    InstructeurId BIGINT UNSIGNED NOT NULL,
    DatumToekenning DATE NOT NULL,
    IsActief TINYINT(1) NOT NULL DEFAULT 1,
    Opmerking VARCHAR(255) NULL,
    DatumAangemaakt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    DatumGewijzigd TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_voertuig_instructeur_voertuigen
        FOREIGN KEY (VoertuigId) REFERENCES voertuigen(Id) ON DELETE CASCADE,
    CONSTRAINT fk_voertuig_instructeur_instructeurs
        FOREIGN KEY (InstructeurId) REFERENCES instructeurs(Id) ON DELETE CASCADE
);

INSERT INTO users (name, email, role, password) VALUES
('Owner Autorijschool', 'owner@autorijschool.test', 'owner', '$2y$10$NnVI/fhYpY65RhnNL5O18ustnbl7h.vHcd2GK8OOC64bNxSd7EJSq'),
('Admin Autorijschool', 'admin@autorijschool.test', 'admin', '$2y$10$NnVI/fhYpY65RhnNL5O18ustnbl7h.vHcd2GK8OOC64bNxSd7EJSq'),
('Instructeur Demo', 'instructeur@autorijschool.test', 'instructeur', '$2y$10$NnVI/fhYpY65RhnNL5O18ustnbl7h.vHcd2GK8OOC64bNxSd7EJSq');

INSERT INTO instructeurs (Id, Voornaam, Tussenvoegsel, Achternaam, Mobiel, DatumInDienst, AantalSterren) VALUES
(1, 'Li', NULL, 'Zhan', '06-28493827', '2015-04-17', '***'),
(2, 'Leroy', NULL, 'Boerhaven', '06-39398734', '2018-06-25', '*'),
(3, 'Yoeri', 'Van', 'Veen', '06-24383291', '2010-05-12', '***'),
(4, 'Bert', 'Van', 'Sali', '06-48293823', '2023-01-10', '****'),
(5, 'Mohammed', 'El', 'Yassidi', '06-34291234', '2010-06-14', '*****');

INSERT INTO type_voertuigen (Id, TypeVoertuig, Rijbewijscategorie) VALUES
(1, 'Personenauto', 'B'),
(2, 'Vrachtwagen', 'C'),
(3, 'Bus', 'D'),
(4, 'Bromfiets', 'AM');

INSERT INTO voertuigen (Id, Kenteken, Type, Bouwjaar, Brandstof, TypeVoertuigId) VALUES
(1, 'AU-67-IO', 'Golf', '2017-06-12', 'Diesel', 1),
(2, 'TR-24-OP', 'DAF', '2019-05-23', 'Diesel', 2),
(3, 'TH-78-KL', 'Mercedes', '2023-01-01', 'Benzine', 1),
(4, '90-KL-TR', 'Fiat 500', '2021-09-12', 'Benzine', 1),
(5, '34-TK-LP', 'Scania', '2015-03-13', 'Diesel', 2),
(6, 'YY-OP-78', 'BMW M5', '2022-05-13', 'Diesel', 1),
(7, 'UU-HH-JK', 'M.A.N', '2017-12-03', 'Diesel', 2),
(8, 'ST-FZ-28', 'Citroen', '2018-01-20', 'Elektrisch', 1),
(9, '123-FR-T', 'Piaggio ZIP', '2021-02-01', 'Benzine', 4),
(10, 'DRS-52-P', 'Vespa', '2022-03-21', 'Benzine', 4),
(11, 'STP-12-U', 'Kymco', '2022-07-02', 'Benzine', 4),
(12, '45-SD-23', 'Renault', '2023-01-01', 'Diesel', 3);

INSERT INTO voertuig_instructeur (Id, VoertuigId, InstructeurId, DatumToekenning) VALUES
(1, 1, 5, '2017-06-18'),
(2, 3, 1, '2021-09-26'),
(3, 9, 1, '2021-09-27'),
(4, 4, 4, '2022-08-01'),
(5, 5, 1, '2019-08-30'),
(6, 10, 5, '2020-02-02'),
(7, 2, 5, '2020-03-12');

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_get_instructeurs_in_dienst $$
CREATE PROCEDURE sp_get_instructeurs_in_dienst()
BEGIN
    SELECT
        Id,
        Voornaam,
        Tussenvoegsel,
        Achternaam,
        TRIM(CONCAT(Voornaam, ' ', IFNULL(CONCAT(Tussenvoegsel, ' '), ''), Achternaam)) AS VolledigeNaam,
        Mobiel,
        DatumInDienst,
        AantalSterren
    FROM instructeurs
    WHERE IsActief = 1
    ORDER BY CHAR_LENGTH(AantalSterren) DESC, Achternaam ASC, Voornaam ASC;
END $$

DROP PROCEDURE IF EXISTS sp_get_voertuigen_bij_instructeur $$
CREATE PROCEDURE sp_get_voertuigen_bij_instructeur(IN p_InstructeurId BIGINT UNSIGNED)
BEGIN
    SELECT
        v.Id,
        v.Kenteken,
        v.Type,
        v.Bouwjaar,
        v.Brandstof,
        tv.TypeVoertuig,
        tv.Rijbewijscategorie,
        vi.DatumToekenning
    FROM voertuigen v
    INNER JOIN voertuig_instructeur vi ON vi.VoertuigId = v.Id
    INNER JOIN type_voertuigen tv ON tv.Id = v.TypeVoertuigId
    WHERE vi.InstructeurId = p_InstructeurId
      AND v.IsActief = 1
      AND vi.IsActief = 1
    ORDER BY tv.Rijbewijscategorie DESC, v.Type ASC;
END $$

DROP PROCEDURE IF EXISTS sp_get_beschikbare_voertuigen $$
CREATE PROCEDURE sp_get_beschikbare_voertuigen()
BEGIN
    SELECT
        v.Id,
        v.Kenteken,
        v.Type,
        v.Bouwjaar,
        v.Brandstof,
        tv.TypeVoertuig,
        tv.Rijbewijscategorie
    FROM voertuigen v
    INNER JOIN type_voertuigen tv ON tv.Id = v.TypeVoertuigId
    LEFT JOIN voertuig_instructeur vi ON vi.VoertuigId = v.Id
    WHERE vi.Id IS NULL
      AND v.IsActief = 1
    ORDER BY tv.Rijbewijscategorie ASC, v.Type ASC;
END $$

DROP PROCEDURE IF EXISTS sp_get_alle_voertuigen $$
CREATE PROCEDURE sp_get_alle_voertuigen()
BEGIN
    SELECT
        v.Id,
        v.Kenteken,
        v.Type,
        v.Bouwjaar,
        v.Brandstof,
        tv.TypeVoertuig,
        tv.Rijbewijscategorie,
        TRIM(CONCAT(i.Voornaam, ' ', IFNULL(CONCAT(i.Tussenvoegsel, ' '), ''), i.Achternaam)) AS InstructeurNaam,
        i.Achternaam AS InstructeurAchternaam,
        vi.Id AS ToewijzingId
    FROM voertuigen v
    INNER JOIN type_voertuigen tv ON tv.Id = v.TypeVoertuigId
    LEFT JOIN voertuig_instructeur vi ON vi.VoertuigId = v.Id AND vi.IsActief = 1
    LEFT JOIN instructeurs i ON i.Id = vi.InstructeurId
    WHERE v.IsActief = 1
    ORDER BY v.Bouwjaar DESC, i.Achternaam DESC, v.Type ASC;
END $$

DROP PROCEDURE IF EXISTS sp_get_voertuig_edit $$
CREATE PROCEDURE sp_get_voertuig_edit(IN p_VoertuigId BIGINT UNSIGNED)
BEGIN
    SELECT
        v.Id,
        v.Kenteken,
        v.Type,
        v.Bouwjaar,
        v.Brandstof,
        v.TypeVoertuigId,
        vi.InstructeurId
    FROM voertuigen v
    LEFT JOIN voertuig_instructeur vi ON vi.VoertuigId = v.Id
    WHERE v.Id = p_VoertuigId;
END $$

DROP PROCEDURE IF EXISTS sp_update_voertuig $$
CREATE PROCEDURE sp_update_voertuig(
    IN p_OrigineleInstructeurId BIGINT UNSIGNED,
    IN p_VoertuigId BIGINT UNSIGNED,
    IN p_Kenteken VARCHAR(10),
    IN p_Type VARCHAR(80),
    IN p_Brandstof VARCHAR(20),
    IN p_TypeVoertuigId BIGINT UNSIGNED,
    IN p_InstructeurId BIGINT UNSIGNED
)
BEGIN
    UPDATE voertuigen
    SET Kenteken = p_Kenteken,
        Type = p_Type,
        Brandstof = p_Brandstof,
        TypeVoertuigId = p_TypeVoertuigId,
        DatumGewijzigd = CURRENT_TIMESTAMP
    WHERE Id = p_VoertuigId;

    IF EXISTS (SELECT 1 FROM voertuig_instructeur WHERE VoertuigId = p_VoertuigId) THEN
        UPDATE voertuig_instructeur
        SET InstructeurId = p_InstructeurId,
            IsActief = 1,
            DatumGewijzigd = CURRENT_TIMESTAMP
        WHERE VoertuigId = p_VoertuigId;
    ELSE
        INSERT INTO voertuig_instructeur (VoertuigId, InstructeurId, DatumToekenning, IsActief)
        VALUES (p_VoertuigId, p_InstructeurId, CURRENT_DATE, 1);
    END IF;
END $$

DROP PROCEDURE IF EXISTS sp_verwijder_voertuig_bij_instructeur $$
CREATE PROCEDURE sp_verwijder_voertuig_bij_instructeur(
    IN p_InstructeurId BIGINT UNSIGNED,
    IN p_VoertuigId BIGINT UNSIGNED
)
BEGIN
    DELETE FROM voertuig_instructeur
    WHERE InstructeurId = p_InstructeurId
      AND VoertuigId = p_VoertuigId;

    SELECT ROW_COUNT() AS Verwijderd;
END $$

DROP PROCEDURE IF EXISTS sp_verwijder_voertuig_uit_alle_voertuigen $$
CREATE PROCEDURE sp_verwijder_voertuig_uit_alle_voertuigen(IN p_VoertuigId BIGINT UNSIGNED)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM voertuig_instructeur
        WHERE VoertuigId = p_VoertuigId
          AND IsActief = 1
    ) THEN
        DELETE FROM voertuig_instructeur
        WHERE VoertuigId = p_VoertuigId;

        UPDATE voertuigen
        SET IsActief = 0,
            DatumGewijzigd = CURRENT_TIMESTAMP
        WHERE Id = p_VoertuigId;

        SELECT 1 AS IsVerwijderd, 'Het door u geselecteerde voertuig is verwijderd' AS Melding;
    ELSE
        SELECT 0 AS IsVerwijderd, 'Het door u geselecteerde voertuig staat op non actief en kan niet worden verwijderd' AS Melding;
    END IF;
END $$

DELIMITER ;
