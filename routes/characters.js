(function () {
    "use strict";
    const express = require('express'),
        router = express.Router(),
        uuid = require("uuid");

    
    /**
     * GET /characters
     * Get all characters
     */
    router.get("/", (req, res) => {
        global.connection.query("SELECT * FROM cms_characters", (err, results) => {
            if (err) {throw(err)}
            res.send(results);
        })
    });


    /**
     * GET /:characterId
     * Returns the data for a single character, characterId
     */
    router.get('/:characterId', (req, res) => {
        let query = "SELECT * FROM cms_characters WHERE characterId = ?",
            queryParams = [req.params.characterId];
        global.connection.query(query, queryParams, (err, queryResults) => {
            if (err) {throw(err)}
            res.send(queryResults);
        });
    });


    /**
     * POST /
     * Creates a new character
     * Requires some fields or will fail!
     */
    //curl -X POST http://localhost:8080/characters -H "Content-Type: application/json" --data '{"email":"foo@bar.com","firstName":"Alice","lastName":"Jones","password":"asfasdf"}'
    router.post("/", (req, res) => {
        let requiredParams = ["playerId"];
        let query = "INSERT INTO cms_characters (characterId, playerId, name, class ) VALUES (?, ?, ?, ?)",
            queryParams = [],
            characterId;

        // Ensure that all the required fields are present in the request body
        for (let i = 0; i < requiredParams.length; i++) {
            if (!req.body.hasOwnProperty(requiredParams[i])) {
                res.send({err: 2, desc: "Missing param"});
                return;
            }
        }

        characterId = uuid.v4();

        queryParams = [characterId, req.body.playerId, req.body.name, req.body.class];
        global.connection.query(query, queryParams, (err, queryResults) => {
            if (err) {
                if (err.code === "ER_DUP_ENTRY") {
                    res.send({err: "alreadyExists"});
                    return;
                }
                res.send(queryResults);
                throw(err);
            }
            res.send({characterId: characterId});
        });
    });


    /**
     * PUT /:characterId
     * Updates a specific character with new field values
     */
    router.put("/:characterId", (req, res) => {
       let query,
           updateFields = [];

       // Build the X='Y' part of the update statement from the params in the request body
       for (let prop in req.body) {
           if (req.body.hasOwnProperty(prop) && prop !== "characterId") {
               updateFields.push(`${global.connection.escapeId(prop)}=${global.connection.escape(req.body[prop])}`);
           }
       }

       query = `UPDATE cms_characters SET ${updateFields.join(",")} WHERE characterId=${global.connection.escape(req.params.characterId)}`;

       global.connection.query(query, (err, queryResults) => {
          if (err) {
              res.send(err);
              throw(err);
          }
          res.send(queryResults);
       });
    });

    module.exports = router;
})();