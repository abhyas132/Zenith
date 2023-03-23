const express = require("express");
const jwt = require("jsonwebtoken");
const userRouter = express.Router();
let userModal = require("../modals/user_modal");

userRouter
    .route("/")
    .get(getUser)
    .post(postUser)
    .patch(updateUser)
    .delete(deleteUser);
    

async function getUser(req, res) {
  try {
    let users = await userModal.find();
    res.json({
      message: "retrieved successfully",
      users,
    });
  } catch (e) {
    res.json({
      error: e.message,
    });
  }
}

async function postUser(req, res) {
  try {
    let newUser = req.body;
    newUser = await userModal.create(newUser);
    const token = jwt.sign({ uid: newUser._id }, "uid");
    return res.json({
      message: "user created succesfully",
      user: newUser,
      token
    });
  } catch (e) {
    return res.json({
      error: e.message,
    });
  }
}

async function updateUser(req, res) {
  try {
    let updatedUser = req.body;
    let users = await userModal.findOneAndUpdate(
      { email: updatedUser.email },
      updateUser
    );
    users = await userModal.find({});
    res.json({
      message: "done",
      updatedUsers: users,
    });
  } catch (e) {
    res.json({
      error: e.message,
    });
  }
}

async function deleteUser(req, res) {
  try {
    let user = req.body;
    let users = await userModal.findOneAndDelete({
      email: user.email,
    });
    res.json({
      message: "deleted successfully",
    });
  } catch (e) {
    res.json({
      error: e.message,
    });
  }
}


module.exports = userRouter;
