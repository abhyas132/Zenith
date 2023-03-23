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