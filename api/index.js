const express = require('express')
const orderController = require('./controllers/orderController')

const PORT = 3333;
const app = express();
app.use(express.json());

app.post('/api/orders', orderController.create);
app.get('/api/orders', orderController.index);

app.listen(PORT, () => {
  console.log(`Now listening on port ${PORT}`);
}); 