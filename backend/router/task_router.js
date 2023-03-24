const express = require('express');
const router = express.Router() ;

const {createTask} = require('../controller/taskController') ;
const {isLoggedIn} = require('../middleware/userMiddleware') ;

router.route('/create/task').post(isLoggedIn, createTask) ;

module.exports = router ;
