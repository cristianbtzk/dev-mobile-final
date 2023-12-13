const fs = require('fs/promises')

async function exists (path) {  
  try {
    await fs.access(path)
    return true
  } catch {
    return false
  }
}

exports.create = async (req, res) => {
  let orders = [];

  if (await exists('./orders.json'))
    orders = JSON.parse(await fs.readFile('./orders.json'));
  console.log(orders)
  orders.push(req.body)
  
  await fs.writeFile('./orders.json', JSON.stringify(orders))
  
  res.json({ message: 'ok' })
}

exports.index = async (req, res) => {
  let orders = [];

  if (await exists('./orders.json'))
    orders = JSON.parse(await fs.readFile('./orders.json'));

  res.json(orders)
}