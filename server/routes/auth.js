const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const authRoute = express.Router();

// ---------------
//| Signup router |
// ---------------

authRoute.post("/api/signup", async (req, res) => {
  try {
    const { name, phoneNumber, password, confirmPassword } = req.body;
    const existingUser = await User.findOne({ phoneNumber });
    if (existingUser) {
      res.status(400).json({ msg: "Already Registered" });
    }
    const hashedpassword = await bcrypt.hash(password, 8);
    const hashedcurrentpassword = await bcrypt.hash(confirmPassword, 8);

    let user = new User({
      name,
      phoneNumber,
      password: hashedpassword,
      confirmPassword: hashedcurrentpassword,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//  ---------------
// | Signin router |
//  ---------------

authRoute.post("/api/signin", async (req, res) => {
  try {
    const { phoneNumber, password } = req.body;
    const user = await User.findOne({ phoneNumber });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this number does not exist!" });
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

authRoute.post("/ValidateToken", async (req, res) => {
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
authRoute.get('/',auth, async(req, res) => {
  const user = await User.findById(req.user);
  res.json({...user._doc, token: req.token});
})
module.exports = authRoute;
