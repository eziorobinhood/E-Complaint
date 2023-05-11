const express = require("express");
const mongoose = require("mongoose");
const Admin = require("../models/admin");
const auth = require("../middlewares/auth");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const adminRoute = express.Router();

adminRoute.post("/api/admin/signin", async (req, res) => {
    try {
      const { username, password } = req.body;
      const user = await Admin.findOne({ username });
      if (!user) {
        return res
          .status(400)
          .json({ msg: "Not exist!" });
      }
  
      const isPasswordMatch = await bcrypt.compare(password, user.password);
      if(!isPasswordMatch){
          return res.status(400).json({msg:"Incorrect Password"})
      }
  
      const token = jwt.sign({id:user._id},"passwordKey");
      res.json({token, ...user._doc});
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
  adminRoute.post("/ValidateToken", async (req, res) => {
    try {
      const token = req.header('x-auth-token');
      if(!token) return res.json(false);
      const verified = jwt.verify(token,"passwordKey");
      if(!verified) return res.json(false);
      const user = await User.findById(verified.id);
      if(!user) return res.json(false);
      res.json(true);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  adminRoute.get('/',auth, async(req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
  })
  module.exports = adminRoute;