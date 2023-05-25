const app = require("./app/index");

app.listen(app.get("port"), () => {
  console.log("Server on port ", app.get("port"));
});
