const fs = require("fs");
const path = require("path");

const schemaDir = "schemas/";

let skills = require(path.join("../", "schemas", "skills.json"));

function titleCase(str) {
    var splitStr = str.toLowerCase().split(' ');
    for (var i = 0; i < splitStr.length; i++) {
        // You do not need to check if i is larger than splitStr length, as your for does that for you
        // Assign it back to the array
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);
    }
    // Directly return the joined string
    return splitStr.join(' ');
}

//console.log(Object.keys(skills));

/*INSERT IGNORE INTO cms_skills (skillId, name, description, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter,
    baseCostMage, baseCostTemplar, baseCostRogue, scaleCostFighter, scaleCostMage,
    scaleCostTemplar, scaleCostRogue)
VALUES ("00000000-0000-0000-0000-000000000005", "stabbity", "stabs things", TRUE, FALSE, FALSE, 1, 2, 3, 4, 1, 2, 3, 4);*/

let index = 1;

Object.keys(skills).forEach(function (key) {
   let skillName = titleCase(key.replace(/_/g, " "));
   let sqlQuery = "INSERT IGNORE INTO cms_skills (skillId, name, description, skillset, isSpSkill, IsTransformSkill, isRacialSkill, baseCostFighter, baseCostTemplar, baseCostRogue, baseCostMage, scaleCostFighter, scaleCostTemplar, scaleCostRogue, scaleCostMage)";

   let scaleCostString = "0, 0, 0, 0";
   if (skills[key].scaleCosts) {
       scaleCostString = skills[key].scaleCosts.join(", ");
   }

   sqlQuery = `${sqlQuery} VALUES ("00000001-0001-0001-0001-00000000000${index}", "${skillName}", "${skillName} skill", "${skills[key].skillset}", true, false, false, ${skills[key].baseCosts[0]}, ${skills[key].baseCosts[1]}, ${skills[key].baseCosts[2]}, ${skills[key].baseCosts[3]}`;
   //sqlQuery = {skills[key].scaleCosts[0]}, ${skills[key].scaleCosts[1]}, ${skills[key].scaleCosts[2]}, ${skills[key].scaleCosts[3]} )`;
    sqlQuery = `${sqlQuery}, ${scaleCostString} );`;
   console.log(sqlQuery);
   index++;
});

//console.log(JSON.stringify(skills, null, 4));
