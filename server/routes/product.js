const express = require('express');
const auth = require('../middleware/auth');
const productController = require('../controllers/product');
const router = express.Router();

router.get('/api/products/', auth, productController.getCategoryProducts);

router.get(
  '/api/products/search/:name',
  auth,
  productController.getSearchedProduct
);

router.post('/api/rate-product', auth, productController.rateProduct);

router.get('/api/deal-of-day', auth, productController.dealOfTheDay);

module.exports = router;
