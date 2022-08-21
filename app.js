const http = require("http");
const express = require("express");
const path = require("path");
const app = express();
const port = 8080;

app.use(express.json());
app.use(express.static("express"));

var createError = require("http-errors");


// ----- ROUTES ----- //
//var indexRouter = require("./public/routes/index");


// ----- DATABASE ----- //



// ----- VIEWS ----- //
/*let options = {
    index: "views/index.html"
    //rules: "views/rules.html"
};
app.use(express.static("public", options));
app.use("/", indexRouter);

 */

app.listen(port, () => {
    console.log(`App listening on port ${port}.  localhost:${port}`);
});

module.exports = app;