const BigPromise = require("../middleware/bigPromise");
const Task = require("../modals/task")
const Schedule = require("../modals/schedule_modal") ;
const _ = require("lodash") ;

const {findVoidIntervals, getCurrentTag} = require("../helper/taskTime") ;
const {accedingSortAccordingToProps, findDuration} = require("../helper/algorithms")


function comp (a, b){
    return a[1] - b[1] ;
}

exports.getSchedule = BigPromise(async (req,res, next) => {
    const schedule = await Schedule.find();
    
    if(!schedule){
        return res.status(200).json({
            status: 200,
            message: "Schedule not found",
        });
    }

    return res.status(200).json({
        status: 200,
        message: "Schedulr retrieved successfully",
        schedule
	});
})

exports.createSchedule = BigPromise(async (req, res, next) => {
    // const userId = req.user.userId ;
    // const {userId} = req.body ;

    // const tasks = await Task.find({userId}) ;
    const tasks = await Task.find() ;

    const date = new Date() ;
    const currTime = date.getHours() * 100 + date.getMinutes() ;

    const futureTasks = tasks.filter((task) => {
        return (task.startTime >= currTime || task.taskType === 'dynamic') ;
    });

    let staticTasks = futureTasks.filter((task) => {
        return task.taskType === 'static' ;
    });

    let dynamicTasks = futureTasks.filter((task) => {
        return task.taskType === 'dynamic' ;
    })

    let unUsedIntervals = findVoidIntervals(currTime, staticTasks) ;
    const currSuitableTag = getCurrentTag(currTime) ;

    dynamicTasks = accedingSortAccordingToProps(dynamicTasks, 'duration') ;
    unUsedIntervals.sort(comp) ;
    
    // console.log(dynamicTasks);
    // console.log(unUsedIntervals);

    let i = 0, j = 0 ;

    let schedule = [] ;
    let copyTask ;
    let currTask = dynamicTasks[0] ;
    schedule.push(staticTasks) ;

    while(i < dynamicTasks.length && j < unUsedIntervals.length){
        if(currTask.duration <= unUsedIntervals[j][1]){
            currTask.startTime = unUsedIntervals[j][0] ;
            currTask.endTime = unUsedIntervals[j][0] + currTask.duration ;
            schedule.push(currTask) ;
            i ++ ;
            j ++ ;
            currTask = dynamicTasks[i] ;
        }
        else{
            // copyTask = currTask[i] ;

            currTask.startTime = unUsedIntervals[j][0] ;
            currTask.endTime = unUsedIntervals[j][0] + unUsedIntervals[j][1] ;
            schedule.push(currTask) ;

            j ++ ;
            currTask.startTime = unUsedIntervals[j][0] ;
        }
    }

    accedingSortAccordingToProps(schedule, 'startTime') ;

    console.log(schedule) ;

    return res.status(200).json({
        status: 200,
        message: "Schedule created successfully",
        schedule
    })

})
