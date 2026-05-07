const http = require("http");

const options = {
  hostname: "localhost",
  port: 3000,
  path: "/api/products",
  method: "GET",
};

const req = http.request(options, (res) => {
  if (res.statusCode === 403 || res.statusCode === 401) {
    console.log("Test OK (la API protegió la ruta correctamente)");
    process.exit(0);
  } else {
    console.log("Test falló");
    process.exit(1);
  }
});

req.on("error", (e) => {
  console.error(`Error en la petición: ${e.message}`);
  process.exit(1);
});

req.end();