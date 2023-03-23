const BigPromise = require("../middleware/bigPromise");


exports.getSchedule = BigPromise(async (req,res, next) => {
    const schedule = await scheduleModal.find();
    
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