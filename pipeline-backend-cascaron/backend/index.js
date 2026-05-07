const express = require("express");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const verifyToken = require("./middleware/auth");

const app = express();
app.use(cors());
app.use(express.json());

const SECRET_KEY = "clave_super_secreta";

// Usuario de prueba
const users = [{ username: "admin", password: "1234" }];

// Datos en memoria
let products = [
  { id: 1, name: "Tacos", price: 50 },
  { id: 2, name: "Quesadilla", price: 30 },
];

app.get("/", (req, res) => {
  res.send("API Funcionando - Taller de Pipeline");
});

app.post("/api/login", (req, res) => {
  const { username, password } = req.body;

  const user = users.find(
    (u) => u.username === username && u.password === password,
  );

  if (!user) {
    return res.status(401).json({ message: "Credenciales incorrectas" });
  }

  const token = jwt.sign({ username }, SECRET_KEY, { expiresIn: "1h" });

  res.json({ token });
});

app.get("/api/products", verifyToken, (req, res) => {
  res.json(products);
});

app.post("/api/products", verifyToken, (req, res) => {
  const { name, price } = req.body;

  const newProduct = {
    id: products.length + 1,
    name,
    price,
  };

  products.push(newProduct);

  res.json(newProduct);
});

app.listen(3000, () => {
  console.log("Servidor corriendo en http://localhost:3000");
});
