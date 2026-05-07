const express = require("express");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const verifyToken = require("./middleware/auth");

const app = express();
app.use(cors());
app.use(express.json());

const SECRET_KEY = "mi_clave_secreta";

const users = [
    { 
        username: "admin", 
        password: "1234" 
    }
];

let products = [
    { id: 1, name: "Laptop", price: 15000 },
    { id: 2, name: "Mouse", price: 300 }
];

// Login
app.post("/api/login", (req, res) => {
    const { username, password } = req.body;

    const user = users.find(
        u => u.username === username && u.password === password
    );

    if (!user) {
        return res.status(401).json({ message: "Credenciales incorrectas" });
    }

    const token = jwt.sign({ username }, SECRET_KEY, { expiresIn: "1h" });

    res.json({ token });
});

// Obtener productos
app.get("/api/products", verifyToken, (req, res) => {
    res.json(products);
});

// Agregar producto
app.post("/api/products", verifyToken, (req, res) => {
    const { name, price } = req.body;

    const newProduct = {
        id: products.length + 1,
        name,
        price
    };

    products.push(newProduct);

    res.json(newProduct);
});

app.listen(3000, () => {
    console.log("Servidor en http://localhost:3000");
});