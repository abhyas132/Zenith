let mongoose = require('mongoose');
let shortid = require('shortId');

const communitySchema = Schema({
    likes: {
        type : Number,
        default : 0
    },
    title: String,
    uuid : {
        type : String,
        default : shortid.generate
    },
    image: String
});

module.exports = mongoose.model('Community', communitySchema);