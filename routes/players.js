(function () {
    "use strict";
    const express = require('express'),
        router = express.Router(),
        uuid = require("uuid");


    /**
     * GET /players
     * Get all players
     */
    router.get("/", (req, res) => {
        global.connection.query("SELECT playerId, email, firstName, lastName FROM cms_players", (err, results) => {
            if (err) {throw(err)}
            res.send(results);
        });
    });


    /**
     * GET /:playerId
     * Returns the data for a single player, playerId
     */
    router.get('/:playerId', (req, res) => {
        let query = "SELECT * FROM cms_players WHERE playerId = ?",
            queryParams = [req.params.playerId];
        global.connection.query(query, queryParams, (err, queryResults) => {
            if (err) {throw(err)}
            res.send(queryResults);
        });
    });


    /**
     * POST /
     * Creates a new player
     * Requires some fields or will fail!
     */
    //curl -X POST http://localhost:8080/players -H "Content-Type: application/json" --data '{"email":"foo@bar.com","firstName":"Alice","lastName":"Jones","password":"asfasdf"}'
    router.post("/", (req, res) => {
        let requiredParams = ["firstName", "lastName", "email", "password"];
        let query = "INSERT INTO cms_players (playerId, email, firstName, lastName, password) VALUES (?, ?, ?, ?, ?)",
            queryParams = [],
            playerId;

        // Ensure that all the required fields are present in the request body
        for (let i = 0; i < requiredParams.length; i++) {
            if (!req.body.hasOwnProperty(requiredParams[i])) {
                res.send({err: 2, desc: "Missing param"});
                return;
            }
        }

        playerId = uuid.v4();

        queryParams = [playerId, req.body.email, req.body.firstName, req.body.lastName, req.body.password];
        global.connection.query(query, queryParams, (err, queryResults) => {
            if (err) {
                if (err.code === "ER_DUP_ENTRY") {
                    res.send({err: "alreadyExists"});
                    return;
                }
                res.send("db error");
                throw(err);
                return;
            }
            res.send({playerId: playerId});
        });
    });


    /**
     * PUT /:playerId
     * Updates a specific player with new field values
     */
    router.put("/:playerId", (req, res) => {
       let query,
           updateFields = [];

       // Build the X='Y' part of the update statement from the params in the request body
       for (let prop in req.body) {
           if (req.body.hasOwnProperty(prop) && prop !== "playerId") {
               updateFields.push(`${global.connection.escapeId(prop)}=${global.connection.escape(req.body[prop])}`);
           }
       }

       query = `UPDATE cms_players SET ${updateFields.join(",")} WHERE playerId=${global.connection.escape(req.params.playerId)}`;

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