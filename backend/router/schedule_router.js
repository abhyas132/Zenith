const express = require("express");
const router = express.Router();

const {getSchedule, createSchedule} = require('../controller/scheduleController') ;

router.route("/get/schedule").get(getSchedule)
router.route("/create/schedule").post(createSchedule);

module.exports = router;
