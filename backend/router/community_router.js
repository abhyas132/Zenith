const express = require("express");
const router = express.Router();

const { getSchedule } = require("../controller/scheduleController");
const { createSchedule } = require("../controller/scheduleController");
const { createTask } = require("../controller/taskController");

router.route("/get/schedule").get(getSchedule);
router.route("/create/schedule").post(createSchedule);

router.route("/create/task").post(createTask);

module.exports = router;
