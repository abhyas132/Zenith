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

exports.getAllTasks = BigPromise(async(req, res, next) => {
    const tasks = await Task.find({userId : req.user.userId}) ;

    if(!tasks){
        return res.status(500).json({
            status: 500,
            message: "Internal error, task could not be retrieved",
        });
    }

    return res.status(200).json({
        status: 200,
        message: "All task retrived successfully",
        tasks,
    });
})

exports.deleteTask = BigPromise(async(req, res, next) => {
    const taskId = req.params.taskId ;
    console.log(taskId);
    const task = await Task.findOne({uid : taskId}) ;
    const user = req.user ;

    let pointsToAdd = 0 ;

    if(task.title.includes("play") || task.title.includes("sport") || task.title.includes("game")){
        user.sportActivity ++ ;
    }

    if(task.title.includes("play") || task.title.includes("sport") || task.title.includes("game") || task.taskType === 'static'){
        pointsToAdd += parseInt(task.duration*0.15*60) ;
    }

    else if(task.title.includes("study") || task.title.includes("contest") || task.title.includes("read")){
        user.studyActivity ++ ;
        pointsToAdd += parseInt(task.duration*0.50*60) ;
    }

    else{
        user.otherActivity ++ ;
        pointsToAdd += parseInt(task.duration*0.20*60) ;
    }

    user.zenCoins += pointsToAdd ;

    await user.save() ;

    // await Task.deleteOne({uid : taskId}) ;

    return res.status(200).json({
        status: 200,
        message: "Task deleted successfully",
    });
});
