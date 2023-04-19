const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  const token = req.header("x-auth-token");
  try {
    if (!token)
      return res.status(401).json({ msg: "No token found. Access denied" });
    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, Authorization denied" });

    req.user = verified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: error.msg });
  }
};

module.exports = auth;