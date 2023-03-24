const User = require('../modals/user_modal');
const BigPromise = require("../middleware/bigPromise");

exports.getAllUser = BigPromise(async (req, res, next) => {

    let users = await User.find();

  return res.status(200).json({
    status: 200,
    message: "retrieved successfully",
    users,
  });
});

exports.getUser = BigPromise(async(req, res, next) => {
    let user = req.user ;

    if(!user){
        return res.status(404).json({
            status : 404,
            message: "user not found",
        })
    }

    return res.status(200).json({
        status : 200,
        message: "retrieved successfully",
        user,
    })
})

exports.updateUser = BigPromise(async(req, res, next) => {
    const {name, email, password ,zenCoins} = req.body;

    let user = req.user ;

    user = {...user, name, email, password, zenCoins} ;

    await user.save() ;

    return res.status(200).json({
        status : 200,
        message: "user details updated succesfully",
        user,
    });
})

exports.createUser = BigPromise(async(req, res, next) => {
    let {name, email, password ,zenCoins} = req.body;

    const user = await User.create({
        name, 
        email,
        password,
        zenCoins
    });

    if(!user){
        return res.status(500).json({
            status : 500,
            message: "Internal error, user not created",
        });
    }

    return res.status(200).json({
        status : 200,
        message: "User created succesfully",
        user,
    });
})
