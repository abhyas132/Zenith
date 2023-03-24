var mongoose = require('mongoose');


var communitySchema = Schema({
    likes: Number,
    title: String,
    email: String,
    college : String,
    interests: [interestsSchema],
    image: String,
    comments: [{
      comment: String,
      user : String
    }]
    
});

var community = mongoose.model('community', communitySchema);