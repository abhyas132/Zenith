const express = require("express");
const router = express.Router();

const { createCommunityPost, updateLikes} = require("../controller/communityController");
const { isLoggedIn } = require("../middleware/userMiddleware");

router.route("/create/communityPost").post(isLoggedIn, createCommunityPost);
router.route("/:postId/likes").post(updateLikes);

module.exports = router;
