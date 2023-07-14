module.exports = function (chronManager) {
    "use strict";
    let LibPlayers = {};

    LibPlayers.getPlayerById = function(params = {}, callback = function () {}) {
        let playerId = params.playerId;
        let query = "SELECT * FROM cms_players WHERE playerId = ?",
            queryParams = [playerId];

        chronManager.db.query(query, queryParams, (err, queryResult) => {
            let player = {};
            if (err) {return callback(err);}

            if (queryResult.length === 1) {
                player = queryResult[0];
                delete player.password;
            }
            callback(undefined, player);
        });
    };

    L

    chronManager.lib.players = LibPlayers;
};