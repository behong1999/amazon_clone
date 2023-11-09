const { Product } = require("../models/product");

const getCategoryProducts = async (req, res) => {
  try {
    //  req.query.category = ?category=
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const getSearchedProduct = async (req, res) => {
  try {
    const products = await Product.find({
      //  req.params.name = :name
      name: { $regex: req.params.name, $options: 'i' },
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const rateProduct = async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.ratings.length; i++) {
      // AUTH MIDDLEWARE -- req.user = verified.id;
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const dealOfTheDay = async (req, res) => {
  try {
    let products = await Product.find({});

    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating;
      }
      // positive => ascending and vice versa
      return aSum < bSum ? 1 : -1;
      // return aSum - bSum;
    });

    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = {
  getCategoryProducts,
  getSearchedProduct,
  rateProduct,
  dealOfTheDay,
};
