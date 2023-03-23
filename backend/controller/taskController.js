const _ = require('lodash') ;
const Task = require('../modals/task');
const BigPromise = require('../middleware/bigPromise') ;
const {convertIntoHMS} = require('../helper/taskTime') ;

exports.createTask = BigPromise(async(req, res, next) => {
<<<<<<< HEAD
    // const {title, description,taskType , taskTag} = req.body() ;

    // if(!title || !description){
    //     return res.status(401).json({
	// 		status: 401,
	// 		message: "Please provide all the necessory information required"
	// 	});
    // }

    const task = new Task({
        ..._.pick(req.body, [
            'title', 'description', 'taskType', 'taskTag', 'startTime','endTime', 'duration',
        ])
    }); 

    await task.save() ;

=======
    let {title, description, taskType, taskTag, startTime, 
        endTime, duration} = req.body ;

    if(!title){
        return res.status(401).json({
            status: 401,
            message: "Please provide all the necessory information required"
        });
    }

    if(taskType === 'static' && (!startTime || !endTime)){
        return res.status(401).json({
            status: 401,
            message: "Please provide startTime and endTime for the static tasks"
        });
    }

    if(taskType === 'dynamic' && (!duration)){
        return res.status(401).json({
            status: 401,
            message: "Please provide duration for the dynamic tasks"
        });
    }
    
    if(startTime && endTime){
        startTime = convertIntoHMS(startTime) ;
        endTime = convertIntoHMS(endTime) ;
    }

    const task = await Task.create({
        title,
        description,
        taskType,
        taskTag,
        startTime,
        endTime,
        duration,
        taskTag
    }); 

>>>>>>> 7a310da87e4ce1ef29f3c1e2ede57c3c25f6a495
    return res.status(200).json({
        status: 200,
        message: "Task saved successfully",
        task
	});
})
