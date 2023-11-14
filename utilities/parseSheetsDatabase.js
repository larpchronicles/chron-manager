const fs = require("fs");
let filename = "sheets-database.csv";
let fileContents;

let fileLines;

fileContents = fs.readFileSync(filename, "utf-8");

fileLines = fileContents.split("\n");

let fields;
let dbObj = [];

fields = fileLines[0].split(",");

fileLines.shift();

//fileLines.forEach(function (line) {
for (let x = 0; x < fileLines.length; x++) {
    let lineArray = fileLines[x].split(",");
    let lineObj = {};
    for (let i = 0; i < lineArray.length; i++) {
        lineObj[fields[i]] = lineArray[i];
    }
    dbObj.push(lineObj);
}

console.log(JSON.stringify(dbObj, null, 4));

