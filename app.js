const http = require("http");
const express = require("express");
const path = require("path");
const app = express();
const port = 8080;

app.use(express.json());
app.use(express.static("express"));

let createError = require("http-errors");

let mysql      = require('mysql2');
global.connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'jdoyle',
    password : 'varos',
    database : 'chron_manager'
});


// ----- ROUTES ----- //
//var indexRouter = require("./public/routes/index");
const playersRouter = require('./routes/players.js');
app.use("/players", playersRouter);

const charactersRouter = require('./routes/characters');
app.use("/characters", charactersRouter);

// ----- DATABASE ----- //
global.connection.connect();


// ----- VIEWS ----- //
/*let options = {
    index: "views/index.html"
    //rules: "views/rules.html"
};
app.use(express.static("public", options));
app.use("/", indexRouter);

 */

/*
 * Log all incoming requests
 */
app.use(function (req, res, next) {
    console.log(`[${new Date().toLocaleDateString()} ${new Date().toLocaleTimeString()}] ${req.ip} ${req.method} ${req.path}`);
    return next();
});



app.listen(port, () => {
    console.log(`App listening on port ${port}.  localhost:${port}`);

    global.connection.query('SELECT * FROM cms_players', function (error, results, fields) {
        if (error) throw error;
        console.log(results);
    });
});




module.exports = app;