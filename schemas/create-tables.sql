CREATE DATABASE IF NOT EXISTS chron_manager;

USE chron_manager;

CREATE TABLE IF NOT EXISTS cms_players
(
    playerId         VARCHAR(40) DEFAULT (uuid()) PRIMARY KEY,
    email            VARCHAR(50),
    password         VARCHAR(50),
    staffPermissions INT,
    plotPermissions  INT,
    firstName        VARCHAR(20),
    lastName         VARCHAR(20),
    waiverDocumentId VARCHAR(40),
    cocDocumentId    VARCHAR(40),

    UNIQUE(email)
);

INSERT IGNORE INTO cms_players (playerId, email, password, staffPermissions, plotPermissions, firstName, lastName)
VALUES ("00000000-0000-0000-0000-000000000001", "justin@jmdoyle.com", "changeMe2!", 3, 3, "Justin", "Doyle");


/**
  cms_documents is for storing things like signed Code of Conduct and Liability Waiver forms
 */
CREATE TABLE IF NOT EXISTS cms_documents
(
    documentId   VARCHAR(40) DEFAULT (uuid()) PRIMARY KEY,
    playerId     VARCHAR(40),
    documentType VARCHAR(20),
    document     TEXT,

    FOREIGN KEY (playerId)
        REFERENCES cms_players (playerId)
        ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS cms_races
(
    raceId       VARCHAR(40) DEFAULT (uuid()) PRIMARY KEY,
    name         varchar(40),
    parentRaceId VARCHAR(40), /* Races such as Elves can have sub-races, ie Wild Elves, Sun Elves, etc.. */
    FOREIGN KEY (parentRaceId) REFERENCES cms_races (raceId)
);

INSERT IGNORE INTO cms_races (raceId, name)
VALUES ("00000000-0000-0000-0000-000000000003", "Kindred");


CREATE TABLE IF NOT EXISTS cms_skills
(
    skillId          VARCHAR(40) DEFAULT (uuid()) PRIMARY KEY,
    name             VARCHAR(40),
    description      TEXT,
    isSpSkill        BOOL,
    IsTransformSkill BOOL,
    isRacialSkill    BOOL,
    baseCostFighter  INT,
    baseCostMage     INT,
    baseCostTemplar  INT,
    baseCostRogue    INT,
    scaleCostFighter INT,
    scaleCostMage    INT,
    scaleCostTemplar INT,
    scaleCostRogue   INT
);

INSERT IGNORE INTO cms_skills (skillId, name, description, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter,
                               baseCostMage, baseCostTemplar, baseCostRogue, scaleCostFighter, scaleCostMage,
                               scaleCostTemplar, scaleCostRogue)
VALUES ("00000000-0000-0000-0000-000000000005", "stabbity", "stabs things", TRUE, FALSE, FALSE, 1, 2, 3, 4, 1, 2, 3, 4);


CREATE TABLE IF NOT EXISTS cms_skillprereqs
(
    skillId          VARCHAR(40),
    prereqSkillId    VARCHAR(40),
    quantityRequired INT,
    FOREIGN KEY (skillId) REFERENCES cms_skills (skillId),
    FOREIGN KEY (prereqSkillId) REFERENCES cms_skills (skillId)
);


CREATE TABLE IF NOT EXISTS cms_mx_races_skills
(
    raceId  VARCHAR(40),
    skillId VARCHAR(40),
    FOREIGN KEY (raceId) REFERENCES cms_races (raceId),
    FOREIGN KEY (skillId) REFERENCES cms_skills (skillId)
);


CREATE TABLE IF NOT EXISTS cms_transforms
(
    transformId VARCHAR(40) DEFAULT (uuid()) PRIMARY KEY,
    name        VARCHAR(40)
);

INSERT IGNORE INTO cms_transforms (transformId, name)
VALUES ("00000000-0000-0000-0000-000000000004", "Master Vampire");


CREATE TABLE IF NOT EXISTS cms_characters
(
    characterId      VARCHAR(40) DEFAULT (uuid()) PRIMARY KEY,
    playerId         VARCHAR(40),
    dateCreated      DATETIME DEFAULT(NOW()),
    name             VARCHAR(40),
    title            VARCHAR(40),
    activeStatus     VARCHAR(10) DEFAULT("active"),
    raceId           VARCHAR(40),
    subRaceId        VARCHAR(40),
    skillPointsTotal INT DEFAULT(100),
    skillPointsSpent INT DEFAULT(0),
    class            VARCHAR(10),
    strain           INT DEFAULT(0),
    bodyMax          INT DEFAULT(5),
    armorMax         INT,
    transformId      VARCHAR(40),

    FOREIGN KEY (playerId) REFERENCES cms_players (playerId),
    FOREIGN KEY (raceId) REFERENCES cms_races (raceId),
    FOREIGN KEY (transformId) REFERENCES cms_transforms (transformId)
);

INSERT IGNORE INTO cms_characters (characterId, playerId, dateCreated, name, title, activeStatus, raceId, subRaceId,
                                   skillPointsTotal, skillPointsSpent, class, strain, bodyMax, armorMax, transformId)
VALUES ("00000000-0000-0000-0000-00000000000Z", "00000000-0000-0000-0000-000000000001", NOW(), "Z", "Ambassador",
        "active", "00000000-0000-0000-0000-000000000003", "Spider", 700, 0, "Mage", 0, 10, 0,
        "00000000-0000-0000-0000-000000000004");


CREATE TABLE IF NOT EXISTS cms_mx_characters_skills
(
    characterId         VARCHAR(40),
    skillId             VARCHAR(40),
    datePurchased       DATETIME,
    quantity            INT,
    totalSkillPointCost INT,
    FOREIGN KEY (characterId) REFERENCES cms_characters (characterId),
    FOREIGN KEY (skillId) REFERENCES cms_skills (skillId)
);

INSERT IGNORE INTO cms_mx_characters_skills (characterId, skillId, datePurchased, quantity, totalSkillPointCost)
VALUES ("00000000-0000-0000-0000-00000000000Z", "00000000-0000-0000-0000-000000000005", NOW(), 3, 30);


CREATE TABLE IF NOT EXISTS cms_characters_manapoints
(
    characterId VARCHAR(40),
    school      VARCHAR(20),
    manaPoints  INT,

    FOREIGN KEY (characterId) REFERENCES cms_characters (characterId)
);

INSERT IGNORE INTO cms_characters_manapoints (characterId, school, manaPoints)
VALUES ("00000000-0000-0000-0000-00000000000Z", "Spirit", 100);


CREATE TABLE IF NOT EXISTS cms_characters_notes
(
    characterId VARCHAR(40),
    dateCreated DATETIME,
    note        TEXT,
    FOREIGN KEY (characterId) REFERENCES cms_characters (characterId)
);


CREATE TABLE IF NOT EXISTS cms_characters_plotEffects
(
    characterId VARCHAR(40),
    dateCreated DATETIME,
    effect      TEXT,
    FOREIGN KEY (characterId) REFERENCES cms_characters (characterId)
);

INSERT INTO cms_characters_plotEffects (characterId, dateCreated, effect)
VALUES ("00000000-0000-0000-0000-00000000000Z", NOW(), "All transform skills unlocked");



