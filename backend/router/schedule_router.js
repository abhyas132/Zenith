const express = require("express");
const jwt = require("jsonwebtoken");
const scheduleRouter = express.Router();
let scheduleModal = require("../modals/schedule_modal");
let taskModal = require("../modals/task");
scheduleRouter
    .route("/schedule")
    .get(getSchedule)
    .post(createSchedule);

    async function getSchedule(req, res){
        try {
          let schedule = await scheduleModal.find();
          res.json({
            message: "schedule retrieved successfully",
            schedule,
          });
        } catch (e) {
          res.json({
            error: e.message,
          });
        }
}
    
async function createSchedule(req, res) {
    // Algorithm...

    const tasks = await taskModal.find();
    console.log(tasks);
    res.json({
      message: "optimized schedule created successfully",
      tasks,
    });
}

module.exports = scheduleRouter;
