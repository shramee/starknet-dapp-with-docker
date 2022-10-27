const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());

app.get("*", (req, res) => {
  res.send("JS is rolling!");
});

const listener = app.listen(process.env.PORT || 4000, () => {
  console.log("App listening on port " + listener.address().port);
});
