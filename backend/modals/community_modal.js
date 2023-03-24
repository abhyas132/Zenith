let mongoose = require('mongoose');

const communitySchema = Schema({
    likes: Number,
    title: String,
    uuid : String,
    image: String
});

module.exports = mongoose.model('Community', communitySchema);