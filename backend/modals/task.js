const mongoose = require('mongoose');
const validator = require('validator');
const shortid = require('shortid');

const taskSchema = new mongoose.Schema({
    uid : {
        type : String,
        required : true,
        unique : true,
        default : shortid.generate
    },
    title : {
        type : String,
        require : ['true', 'Provide the task title']
    },
    description : {
        type : String,
    },
    taskType : {
        type : String,
        default : 'static',
        enum : {
            values : ['static', 'dynamic'],
			message: "Please select the taskType as static or dynamic only"
        }
    },
    startTime :{
        type : Date
    },
    endTime : {
        type : Date,
    },
    duration:{
        type : mongoose.Schema.Types.Number
    },
    taskTag : {
        type : String,
        default : 'flexible',
        enum : {
            values : ['morning', 'afternoon', 'evening', 'flexible'],
			message: "Please select the taskType as morning, afternoon, evening or dynamic only"
        }
    }
});

module.exports = mongoose.model('Task', taskSchema) ;