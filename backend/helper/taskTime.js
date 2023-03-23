const task = require("../modals/task");
const { accedingSortAccordingToProps, findDuration } = require("./algorithms")

exports.convertIntoHMS = (time) => {
    if(time[1] === ':')
        time = "0" + time ;

    time = time.substring(0, 5) ;

    time += ":00" ;

    let now = new Date();
    let nowDateTime = now.toISOString();
    let nowDate = nowDateTime.split('T')[0];
    time = new Date(nowDate + 'T' + time);

    return time ;
}

exports.findVoidIntervals = (currentTime, staticTasks) => {
    staticTasks = accedingSortAccordingToProps(staticTasks, 'startTime') ;

    let unUsedIntervals = [] ; // [[startTime, duration]]
    let lastEndTime = currentTime ;

    for(let task of staticTasks){
        if(task.startTime > lastEndTime){
            unUsedIntervals.push([lastEndTime, findDuration(lastEndTime, task.startTime)]) ;
        }
        lastEndTime = task.endTime ;
    }

    return unUsedIntervals ;
}

exports.getCurrentTag = (currentTime) => {
    if(currentTime >= 600 && currentTime <= 1200){
        return "morning" ;
    }
    if(currentTime > 1200 && currentTime <= 1700){
        return "afternoon" ;
    }
    if(currentTime > 1700 && currentTime <= 2400){
        return "evening" ;
    }
    else{
        return "not in the tag/ night" ;
    }
}