const mongoose = require("mongoose");

//user schema...

const userSchema = mongoose.Schema({
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

const userModal = mongoose.model("userModel", userSchema);
module.exports = userModal;
