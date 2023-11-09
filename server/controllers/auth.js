const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

const signUp = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(409).json({ msg: 'E-mail address already in use' });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const signIn = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res
        .status(400)
        .json({ msg: 'We cannot find an account with that email address' });
    }

    const isMatched = await bcryptjs.compare(password, user.password);

    if (!isMatched) {
      return res.status(400).json({ msg: 'Your password is incorrect' });
    }
    // Create a JSON Web Token representing a user's identity
    const token = jwt.sign({ id: user._id }, 'privateKey');

    // _doc property only includes raw data to be more concise
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const tokenIsValid = async (req, res) => {
  try {
    const token = req.header('x-auth-token');
    if (!token) return res.json(false);
    const verified = jwt.verify(token, 'privateKey');
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const findUserById = async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
}

module.exports = {
  signUp,
  signIn,
  tokenIsValid,
  findUserById
};
