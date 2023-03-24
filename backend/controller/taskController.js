const _ = require("lodash");
const Task = require("../modals/task");
const BigPromise = require("../middleware/bigPromise");
const { convertIntoHMS } = require("../helper/taskTime");

exports.createTask = BigPromise(async (req, res, next) => {
    let { title, description, taskType, taskTag, startTime, endTime, duration } = req.body;
    
    const userId = req.user.userId ;

    if(!userId){
        return res.status(401).json({
            status: 401,
            message: "User does not exist",
        });
    }

    if (!title) {
        return res.status(401).json({
            status: 401,
            message: "Please provide all the necessory information required",
        });
    }

    if (taskType === "static" && (!startTime || !endTime)) {
        return res.status(401).json({
            status: 401,
            message: "Please provide startTime and endTime for the static tasks",
        });
    }

    if (taskType === "dynamic" && !duration) {
        return res.status(401).json({
            status: 401,
            message: "Please provide duration for the dynamic tasks",
        });
    }

    if(startTime && endTime){
        startTime = parseInt(startTime);
        endTime = parseInt(endTime) ;

        if(startTime >= endTime){
            endTime = 2400 ;
        }
    }

    const task = await Task.create({
        title,
        description,
        taskType,
        taskTag,
        startTime,
        endTime,
        duration,
        taskTag,
        userId
    })  

    return res.status(200).json({
        status: 200,
        message: "Task saved successfully",
        task,
    });
});
