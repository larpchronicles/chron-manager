const fs = require("fs");
const path = require("path");

const schemaDir = "schemas/";

let schema = require(path.join("../", "schemas", "entitySchemas.json"));

console.log(Object.keys(schema));

let tableName = "player";
let sql = `CREATE TABLE IF NOT EXISTS cm_${tableName}s (`;
