const express = require('express');
const adminController = require('../controllers/admin');
const admin = require('../middleware/admin');

const router = express.Router();

// Add product
router.post('/add-product', admin, adminController.addProduct);

// Get all your products
router.get('/get-products', admin, adminController.getProducts);

// Delete the product
router.post('/delete-product', admin, adminController.deleteProduct);

router.get('/get-orders', admin, adminController.getAllOrders);

router.post('/change-order-status', admin, adminController.changeOrderStatus);

router.get('/analytics', admin, adminController.analytics);



module.exports = router;
