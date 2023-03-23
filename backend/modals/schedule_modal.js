const mongoose = require("mongoose");
const task = require("./task")

const scheduleSchema = mongoose.Schema({
    tasks: [task],
    hours: {
      type: Number,
      default: 24,
    },
});

const Schedule = mongoose.model("Schedule", scheduleSchema);
module.exports = Schedule;
