const mongoose = require("mongoose");
const Task = require("./task")
const shortid = require("shortid");
const scheduleSchema = mongoose.Schema({
<<<<<<< HEAD
  tasks: [
    {
      uid: {
        type: String,
        required: true,
        unique: true,
        default: shortid.generate,
      },
      title: {
        type: String,
        require: ["true", "Provide the task title"],
      },
      description: {
        type: String,
      },
      taskType: {
        type: String,
        default: "static",
        enum: {
          values: ["static", "dynamic"],
          message: "Please select the taskType as static or dynamic only",
        },
      },
      startTime: {
        type: Date,
      },
      endTime: {
        type: Date,
      },
      duration: {
        type: mongoose.Schema.Types.Number,
      },
      taskTag: {
        type: String,
        default: "flexible",
        enum: {
          values: ["morning", "afternoon", "evening", "flexible"],
          message:
            "Please select the taskType as morning, afternoon, evening or dynamic only",
        },
      },
    },
  ],
  hours: {
    type: Number,
    default: 24,
  },
=======
    tasks: [task],
    hours: {
      type: Number,
      default: 24,
    },
>>>>>>> 7a310da87e4ce1ef29f3c1e2ede57c3c25f6a495
});

const Schedule = mongoose.model("Schedule", scheduleSchema);
module.exports = Schedule;
