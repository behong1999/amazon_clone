const express = require('express');
const auth = require('../middleware/auth');
const userController = require('../controllers/user');

const router = express.Router();

router.post('/api/add-to-cart', auth, userController.addToCart);

router.delete('/api/remove-from-cart/:id', auth, userController.removeFromCart);

router.post('/api/save-user-address', auth, userController.saveUserAddress);

router.post('/api/order', auth, userController.placeOrder);

router.get('/api/orders/me', auth, userController.fetchOrders);

module.exports = router;
