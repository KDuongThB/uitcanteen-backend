const express = require('express');
const mysql = require('mysql');
const cors = require("cors");
require("dotenv").config();
const bodyParser = require("body-parser");
// const cookieParser = require("cookie-parser");
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
        key: "userId",
        secret: "abcxyz",
        resave: false,
        saveUninitialized: false,
        store: sessionStore,
    })
);

app.use(express.json());

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
    try {
        if (req.session.user) {
            console.log("req.session.user:" + req.session.user)
            res.send({
                loggedIn: true,
                message: "Welcome " + req.session.user,
                user: req.session.user
            });
        }

        else {
            console.log("req.session.user:" + req.session.user)
            res.send({ loggedIn: false });
        }
    } catch (e) {
        console.log(e);
        res.sendStatus(500);
    }
});

app.get("/login", (req, res) => {
    if (req.session.user) {
        console.log("req.session.user:" + req.session.user);
        res.send({
            loggedIn: true,
            message: "already logged in",
            user: req.session.user
        });
    } else {
        console.log("req.session.user:" + req.session.user);
        res.send({
            loggedIn: false,
            message: "not logged in",
        });
    }
});

app.post("/register", (req, res) => {
    const userData = {
        email: req.body.username,
        password: req.body.password,
        confirmPassword: req.body.confirmPassword,
    }
    if (userData.password != userData.confirmPassword) {
        res.send({ message: "password not matched" })
    } else {
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
    }
});

app.post("/login", express.urlencoded({ extended: false }), (req, res) => {
    const loginData = {
        email: req.body.username,
        password: req.body.password,
    };
    var authUser = {};

    db.query('SELECT * FROM usr WHERE email = ?;', loginData.email, (err, result) => {
        if (err) {
            console.log(err); 
            res.send({ err: err });
        }
        if (result.length > 0) {
            if (loginData.password == result[0].password) {
                authUser = result[0];
                console.log(authUser);
            } else {
                res.send({ message: "Wrong login info" });
            }
        } else {
            res.send({ message: "Email is not registered" });
        };
    });
    req.session.user = authUser;

    req.session.save(function (err) {
        if (err) return (err);
        res.send(req.session.user)
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
