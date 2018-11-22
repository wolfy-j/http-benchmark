const rayo = require("rayo");

rayo({ port: 80 })
  .get("/", (req, res) => res.end(""))
  .get("/user/:id", (req, res) => res.end(req.params.id))
  .post("/user", (req, res) => res.end(""))
  .start();
