const express = require('express');
const mysql = require('mysql');
const cors = require("cors");
require("dotenv").config();
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const session = require("express-session");

const app = express();

const mysqlStore = require('express-mysql-session')(session);

const db = mysql.createConnection({
    user: 'root',
    host: 'localhost',
    password: '',
    database: 'uitcanteen'
})

const sessionStore = new mysqlStore({
    connectionLimit: 10,
    password: "",
    user: "root",
    database: "uitcanteen",
    host: 'localhost',
    port: '3306',
    createDatabaseTable: true
});

app.use(session({
    name: "uit_sess",
    secret: "abcxyz",
    resave: false,
    saveUninitialized: false,
    store: sessionStore,
    cookie: {
        maxAge: 24 * 60 * 60 * 10,
        sameSite: true,
        secure: false
    }
})
);

app.use(
    cors({
        origin: ["http://127.0.0.1:5173"],
        methods: ["GET", "POST", "PUT"],
        credentials: true,
    })
);

app.use(cookieParser())

app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', async (req, res) => {
    res.send('todo')
});

app.get("/login", (req, res) => {
    res.send('todo')
});

app.post("/register", (req, res) => {
    const userData = {
        email: req.body.username,
        password: req.body.password,
    }
    db.query('SELECT * FROM usr WHERE email = ?', userData.email, (err, result) => {
        if (err) {
            throw (err);
        }

        if (result.length > 0) {
            console.log(result);
            res.send({ message: "Email already registered" });
        }
        else {
            db.query("INSERT INTO usr (email, password) VALUES (?,?)",
                [userData.email, userData.password],
                (err, result) => {
                    if (err) { console.log(err) };
                    if (result) {
                        console.log(result);
                        res.send({ message: "Registered successfully!" });
                    };
                })
        }
    });
});

app.post("/login", (req, res) => {
    const loginData = {
        email: req.body.username,
        password: req.body.password,
    };
    if(req.session.authenticated)
    {
        res.send('Authenticated')
    }
    else
    {
    db.query('SELECT * FROM `usr` WHERE `email` = ?', loginData.email, (err, result) => {
        if (err) {
            console.log(err); 
            res.send({ err: err });
        }
        if (result.length > 0) {
            const userData = result[0];
            if (loginData.password === userData.password) {
                console.log('login query works');
                res.send(userData)
            }
            else {
                res.status(401).send({ message: "Wrong password" });
            }
        }
        else {
            res.status(401).send({ message: "Email is not registered" });
        };
    });
}
    req.session.save(function (err) {
        if (err) return (err);
    })
});

app.get('/logout', (req, res) => {
    req.session.destroy();
    return res.redirect('/');
});

const PORT = process.env.APP_PORT;
app.listen(PORT, () => {
    console.log('listening on port 3001')
})
