const express = require('express');
const app = express();
const mysql = require('mysql');
const bcrypt = require('bcrypt');

const cors = require("cors");

const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cookieSession = require("cookie-session");

const db = mysql.createConnection({
    user: 'root',
    host: 'localhost',
    password: '',
    database: 'uitcanteen'
})

app.use(express.json());

app.use(
    cors({
        origin: ["http://127.0.0.1:5173"],
        methods: ["GET", "POST"],
        credentials: true
    })
);

app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(
    cookieSession({
        key: "userId",
        secret: "subscribe",
        reSave: false,
        saveUninitialized: false,
        cookie: {
            expires: 1000 * 60 * 60 * 24,
            sameSite: true
        },
    })
);

app.post("/register", (req, res) => {
    const username = req.body.username;
    const password = req.body.password;
    db.query(
        "INSERT INTO USR (email, password) VALUES (?,?)",
        [username, password],
        (err, result) => {
            if (err) { console.log(err) };
            if (result) { console.log(result) };
        })
});

app.get("/login", (req, res) => {
    if (req.session.user) {
        res.send({ loggedIn: true, user: req.session.user });
    } else {
        res.send({ loggedIn: false });
    }
});

app.post("/login", (req, res) => {
    const username = req.body.username;
    const password = req.body.password;

    db.query('SELECT * FROM USR WHERE email = ?;', username, (err, result) => {
        if (err) {
            res.send({ err: err });
        }

        if (result.length > 0) {
            if (password == result[0].password) {
                req.session.user = result;
                console.log(req.session.user);
                res.send(result);
            } else {
                res.send({ message: "Wrong login info" });
            }
        } else {
            res.send({ message: "Email is not registered" });
        };
    });
});

app.listen(3001, () => {
    console.log('por favor')
})