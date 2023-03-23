const express = require("express");
const app = express();

var bodyParser = require('body-parser') ;

app.use(bodyParser.urlencoded({
    extended : true
}))

app.use(express.json()) ;

const auth = require('./router/auth_router') ;
const user = require('./router/user_router') ;
const task = require('./router/task_router') ;

app.use("/api/v1", user);
app.use("/api/v1", auth);
app.use("/api/v1", task);

module.exports = app ;
