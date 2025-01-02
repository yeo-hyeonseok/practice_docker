const express = require("express");

const app = express();

app.get("/", (_, res) => {
  res.send("DOCKEREKCOD");
});

app.listen(3000, () => console.log("3000번 포트 연결 중"));
