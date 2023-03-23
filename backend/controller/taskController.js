const _ = require('lodash') ;
const Task = require('../modals/task');
const BigPromise = require('../middleware/bigPromise') ;

exports.createTask = BigPromise(async(req, res, next) => {
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

    return res.status(200).json({
		status: 200,
		message: "Task saved successfully",
        task
	});
})