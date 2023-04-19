const express = require("express");
const Problem = require("../models/problem");
const problemRoute = express.Router();


problemRoute.post("/api/problemupload", async (req, res) => {
  try {
    const { problem } = req.body;
    
    

    let userproblem = new Problem({
      problem
    });
    userproblem = await userproblem.save();
    res.json(userproblem);
  } catch (e) {
    res.status(404).json({ error: e.message });
  }
});

module.exports = problemRoute;