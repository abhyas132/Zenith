const mongoose = require("mongoose");
const shortid = require('shortid') ;
const jwt = require('jsonwebtoken');
//user schema...

const userSchema = mongoose.Schema({
    userId : {
        type : String,
        required : true,
        unique : true,
        default : shortid.generate 
    },
    name: {
        type: String,
        require: true,
    },
    email: {
        type: String,
        require: true,
        unique: true,
    },
    password: {
        type: String,
        require: true,
        minLength: 3,
    },
    zenCoins: {
        type: Number,
        default: 0,
    },
});


userSchema.pre("save", function () {
    //I will add
});

userSchema.post("save", function (doc) {
    // I wil add
});

// model...
userSchema.methods.getJwtToken = function () {
	return jwt.sign(
		{ tokenId: this.userId },
		process.env.JWT_SECRET
	);
};

const userModal = mongoose.model("userModel", userSchema);
module.exports = userModal;
