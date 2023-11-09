const express = require('express');
const authController = require('../controllers/auth');
const auth = require('../middleware/auth');

const router = express.Router();

router.post('/signup', authController.signUp);
router.post('/signIn', authController.signIn);
router.post('/tokenIsValid', authController.tokenIsValid);
router.get('/', auth, authController.findUserById);

module.exports = router;
