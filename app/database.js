const mysql = require("mysql2");
const { database } = require("./keys");
const { promisify } = require("util");

const pool = mysql.createPool(database);
pool.getConnection((err, connection) => {
  if (err) {
    if (err.code === "PROTOCOL_CONNECTION_LOST")
      console.log("DATABASE CONNECTION WAS CLOSED");
    if (err.code === "ER_CON_COUNT_ERROR")
      console.log("DATABASE HAS TO MANY CONNECTIONS");
    if (err.code === "ECONNREFUSED") console.log("DATABASE CANNOT CONNECT");
  }
  if (connection) connection.release();
  console.log("DB CONNECTED");
  return;
});

// CONVERT POOL.QUERY TO PROMISES
pool.query = promisify(pool.query);
module.exports = pool;
