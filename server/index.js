require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const morgan = require('morgan');

const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const app = express();

// MIDDLEWARE
app.use(morgan('dev'));
app.use(express.json());
app.use('/admin', adminRouter);
app.use('/api', authRouter);
app.use(productRouter);
app.use(userRouter);

mongoose
  .connect(process.env.CONNECTION_STRING)
  .then(() => {
    console.log('Connection Successful');
  })
  .catch((error) => {
    console.log(error);
  });

const port = process.env.PORT;

app.listen(port, '0.0.0.0', () => {
  console.log(`Connect to Port ${port}`);
});
