const fs = require("fs");
const path = require("path");

const schemaDir = "schemas/";

fs.readdir(schemaDir, function (err, files) {
    let outputContent = {};

    if (err) { return console.log('Unable to scan directory: ' + err); }
    for (let i = 0; i < files.length; i++) {
        let filename = files[i];
        // Only match files that fit the format "entitySchema-something.json"
        if (filename.search(/^entitySchema-.*\.json$/) > -1) {
            let schema = require(path.join("..", schemaDir, filename));
            let propName = filename.replace("entitySchema-", "").replace(".json", "");
            Object.keys(schema).forEach(function (propName) {
                outputContent[propName] = schema[propName];
            });
        }
    }

    fs.writeFileSync("schemas/entitySchemas.json", JSON.stringify(outputContent, null, 4), "utf-8");

});