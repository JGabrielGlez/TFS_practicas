import { useState } from "react";

function App() {
  const [token, setToken] = useState("");
  const [logged, setLogged] = useState(false);

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const [products, setProducts] = useState([]);

  const [name, setName] = useState("");
  const [price, setPrice] = useState("");

  // Login
  const login = async () => {
    const res = await fetch("http://localhost:3000/api/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ username, password })
    });

    if (!res.ok) {
      alert("Credenciales incorrectas");
      return;
    }

    const data = await res.json();
    setToken(data.token);
    setLogged(true);
  };

  // Obtener productos
  const getProducts = async () => {
    const res = await fetch("http://localhost:3000/api/products", {
      headers: {
        Authorization: "Bearer " + token
      }
    });

    const data = await res.json();
    setProducts(data);
  };

  // Agregar producto
  const addProduct = async () => {
    await fetch("http://localhost:3000/api/products", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify({
        name,
        price: Number(price)
      })
    });

    alert("Producto agregado");
    await getProducts();

    setName("");
    setPrice("");
  };

  if (!logged) {
    return (
      <div style={{ padding: 20 }}>
        <h2>Login</h2>

        <input
          placeholder="Usuario"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <br /><br />

        <input
          type="password"
          placeholder="Contraseña"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <br /><br />

        <button onClick={login}>Ingresar</button>
      </div>
    );
  }

  return (
    <div style={{ padding: 20 }}>
      <h2>Panel</h2>

      <button onClick={getProducts}>Ver Productos</button>

      <h3>Agregar Producto</h3>

      <input
        placeholder="Nombre"
        value={name}
        onChange={(e) => setName(e.target.value)}
      />
      <br /><br />

      <input
        placeholder="Precio"
        value={price}
        onChange={(e) => setPrice(e.target.value)}
      />
      <br /><br />

      <button onClick={addProduct}>Guardar</button>

      <h3>Lista de productos</h3>
      <ul>
        {products.map(p => (
          <li key={p.id}>
            {p.name} - ${p.price}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;