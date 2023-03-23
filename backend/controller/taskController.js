const _ = require('lodash') ;
const Task = require('../modals/task');
const BigPromise = require('../middleware/bigPromise') ;

exports.createTask = BigPromise(async(req, res, next) => {

    console.log(req.body) ;
    
    const {title, description,taskType , taskTag} = req.body ;

    if(!title){
        return res.status(401).json({
			status: 401,
			message: "Please provide all the necessory information required"
		});
    }

    // const task = await Task.create({
    //     ..._.pick(req.body, [
    //         'title', 'description', 'taskType', 'taskTag', 'startTime','endTime', 'duration',
    //     ]) 
    // }); 
    
    const task = await Task.create({
        title,
        description,
        taskType,
        taskTag,
    }); 

    // console.log(task[title]);
    // console.log(task[description]);

    // await task.save() ;

    return res.status(200).json({
		status: 200,
		message: "Task saved successfully",
        task
	});
})