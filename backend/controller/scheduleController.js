const BigPromise = require("../middleware/bigPromise");
const scheduleModal = require("../modals/schedule_modal")
const taskModal = require("../modals/task")
exports.getSchedule = BigPromise(async (req,res, next) => {
    const schedule = await taskModal.find();
    
    if(!schedule){
        return res.status(200).json({
            status: 200,
            message: "Schedule not found",
            task
        });
    }

    return res.status(200).json({
        status: 200,
        message: "Schedulr retrieved successfully",
        schedule
	});
})

exports.createSchedule = BigPromise((req, res) => {
    
})