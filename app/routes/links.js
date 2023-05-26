const express = require("express");
const db = require("../database");
const router = express.Router();

router.get("/add", (req, res) => {
  res.render("links/add");
});

router.post("/add", async (req, res) => {
  const { title, url, description } = req.body;
  const newLink = {
    title,
    url,
    description,
  };
  await db.query("INSERT INTO links set ?", [newLink]);
  res.redirect("/links");
});

router.get("/", async (req, res) => {
  const links = await db.query("SELECT * FROM links");
  res.render("links/list", { links });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await db.query("DELETE FROM links WHERE id_link = ?", [id]);
  res.redirect("/links");
});

router.get("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const links = await db.query("SELECT * FROM links WHERE id_link = ?", [id]);
  res.render("links/edit", { link: links[0] });
});

router.post("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const { title, url, description } = req.body;
  const newLink = {
    title,
    description,
    url,
  };
  await db.query("UPDATE links SET ? WHERE id_link = ?", [newLink, id]);
  res.redirect("/links");
});

module.exports = router;
