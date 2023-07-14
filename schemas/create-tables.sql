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
    skillset         VARCHAR(40),
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

INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000001", "School Initiation", "School Initiation skill", "magic", true, false, false, 5, 3, 5, 3, 5, 4, 5, 1 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000002", "School Specialization", "School Specialization skill", "magic", true, false, false, 20, 15, 20, 10, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000003", "Mana Attunement", "Mana Attunement skill", "magic", true, false, false, 10, 3, 10, 3, 10, 4, 8, 1 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000004", "Ritual Magic", "Ritual Magic skill", "magic", true, false, false, 20, 20, 20, 20, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000005", "One-handed Weapon", "One-handed Weapon skill", "stamina", true, false, false, 3, 3, 5, 8, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000006", "Two-handed Weapon", "Two-handed Weapon skill", "stamina", true, false, false, 3, 3, 5, 8, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000007", "Ranged Weapon", "Ranged Weapon skill", "stamina", true, false, false, 3, 3, 5, 8, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000008", "Shield", "Shield skill", "stamina", true, false, false, 3, 3, 5, 8, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000009", "Dual Wield", "Dual Wield skill", "stamina", true, false, false, 3, 3, 5, 8, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000010", "Parrying Dagger", "Parrying Dagger skill", "stamina", true, false, false, 2, 2, 2, 2, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000011", "Additional Defense Slot", "Additional Defense Slot skill", "defense", true, false, false, 10, 10, 10, 10, 30, 30, 30, 30 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000012", "Agility", "Agility skill", "agility", true, false, false, 10, 20, 5, 20, 10, 10, 5, 10 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000012", "Armor Training", "Armor Training skill", "defense", true, false, false, 3, 3, 3, 3, 1, 3, 3, 3 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000013", "Dexterity Armor", "Dexterity Armor skill", "defense", true, false, false, 5, 5, 5, 5, 5, 5, 5, 5 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000014", "Mimicry", "Mimicry skill", "agility", true, false, false, 5, 20, 3, 20, 10, 10, 5, 10 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000015", "Stamina", "Stamina skill", "stamina", true, false, false, 5, 5, 5, 20, 3, 5, 5, 10 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000016", "Toughness", "Toughness skill", "defense", true, false, false, 3, 3, 3, 3, 3, 5, 5, 5 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000017", "Cutpurse", "Cutpurse skill", "other", true, false, false, 10, 10, 3, 10, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000018", "Escape Artist", "Escape Artist skill", "other", true, false, false, 5, 5, 3, 3, 2, 2, 1, 1 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000019", "First Aid", "First Aid skill", "other", true, false, false, 4, 4, 4, 4, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000020", "Lockpicking", "Lockpicking skill", "other", true, false, false, 5, 5, 3, 3, 5, 5, 1, 3 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000021", "Performing", "Performing skill", "other", true, false, false, 1, 1, 1, 1, 1, 1, 1, 1 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000022", "Tracking", "Tracking skill", "other", true, false, false, 20, 20, 20, 20, 0, 0, 0, 0 );
INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage) VALUES ("00000001-0001-0001-0001-000000000023", "Trapping", "Trapping skill", "other", true, false, false, 10, 10, 3, 6, 0, 0, 0, 0 );

CREATE TABLE IF NOT EXISTS cms_skillprereqs
(
    skillId          VARCHAR(40),
    prereqSkillId    VARCHAR(40),
    quantityRequired INT,
    FOREIGN KEY (skillId) REFERENCES cms_skills (skillId),
    FOREIGN KEY (prereqSkillId) REFERENCES cms_skills (skillId)
);


CREATE TABLE IF NOT EXISTS cms_skillReplaces
(
    skillId          VARCHAR(40),
    replaceSkillId    VARCHAR(40),
    FOREIGN KEY (skillId) REFERENCES cms_skills (skillId),
    FOREIGN KEY (replaceSkillId) REFERENCES cms_skills (skillId)
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



