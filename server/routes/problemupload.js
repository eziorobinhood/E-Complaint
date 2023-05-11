const express = require("express");
const Problem = require("../models/problem");
const auth = require("../middlewares/auth");
const problemRoute = express.Router();


problemRoute.post("/api/problemupload", async (req, res) => {
  try {
    const { problem, problemtype, problemlocation, problemurl } = req.body;
    
    

    let userproblem = new Problem({
      problem, problemtype, problemlocation, problemurl
    });
    userproblem = await userproblem.save();
    res.json(userproblem);
  } catch (e) {
    res.status(404).json({ error: e.message });
  }
});

problemRoute.get('/problems/getallproblems',async(req,res)=>{
  try {
    const allproblems = await Problem.find({});
    res.json(allproblems);
  } catch (e) {
    res.status(500).json({error:e.message});
  }
})



module.exports = problemRoute;