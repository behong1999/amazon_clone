const mongoose = require('mongoose');
const { productSchema } = require('./product');

const userSchema = mongoose.Schema({
  name: {
    require: true,
    type: String,
    trim: true,
  },
  email: {
    require: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const regex =
          /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        return value.match(regex);
      },
      message: 'Please enter a valid e-mail address',
    },
  },
  password: {
    require: true,
    type: String,
    validate: {
      validator: (value) => {
        const regex =
          /^(?!\s+)(?!.*\s+$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$^*.[\]{}()?"!@#%&/\\,><':;|_~`=+\- ])[A-Za-z0-9$^*.[\]{}()?"!@#%&/\\,><':;|_~`=+\- ]{6,256}$/;
        return regex.test(value);
        // return value.match(regex);
      },
      message: (props) => {
        if (props.value.length < 6) {
          return 'Password should be at least 6 characters long';
        }

        if (!/[!@#%&/\\,><':;|_~`=+\-]/.test(props.value)) {
          return 'Password should contain at least one special character';
        }
        return 'Please enter a valid password';
      },
    },
  },
  address: {
    type: String,
    default: '',
  },
  type: {
    type: String,
    default: 'user',
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});
const User = mongoose.model('User', userSchema);
module.exports = User;
