const express = require("express");
const app = express();
const mongoose = require("mongoose");
const userRouter = require("./router/user_router");
const authRouter = require("./router/auth_router");
const task_router = require('./router/task_router') ;

app.use(express.json());

const db =
  "mongodb+srv://abhyas132:abhyas132@cluster0.rg0qolo.mongodb.net/?retryWrites=true&w=majority";
app.listen(3000, () => {
  console.log("server is listening on port 3000");
});

// connection to DB...
mongoose
  .connect(db)
  .then(function (db) {
    console.log("db connected");
  })
  .catch(function (err) {
    console.log(err);
  });

app.use("/user", userRouter);
app.use("/auth", authRouter);
app.use("/task", task_router);





 