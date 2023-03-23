const express = require('express');
const router = express.Router() ;

const {createTask} = require('../controller/taskController') ;

router.route('/create/task').post(createTask) ;