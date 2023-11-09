const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
  try {
    const token = req.header('x-auth-token');
    if (!token) {
      return res.status(401).json({ msg: 'No Auth Token, Access Denied!' });
    }

    const verified = jwt.verify(token, 'privateKey');
    if (!verified)
      return res
        .status(401)
        .json({ msg: 'Token Verification Failed, Authorization Denied!' });

    // Add properties to the req object
    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = auth;
