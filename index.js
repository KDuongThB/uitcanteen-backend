const express = require('express');
const mysql = require('mysql');
const app = express();
const cors = require("cors");

const bodyParser = require("body-parser");  
const cookieParser = require("cookie-parser");
const session = require("express-session");

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
        credentials: true,
    })
);

app.use(cookieParser())

app.use(bodyParser.urlencoded({ extended: true }));

app.use(
    session({
        key: "connect.sid",
        secret: "abcxyz",
        resave: false,
        saveUninitialized: false,
        cookie: {
            maxAge: 1000 * 60 * 60 * 24,
            sameSite: true,
        },
        secure: false,
    })
);

app.get('/', (req, res) => {
    if (req.session.user) {
        console.log("req.session.user:" + req.session.user)
        res.send({
            loggedIn: true,
            message: "Welcome " + req.session.user
        });
    }
    else {
        console.log("req.session.user:" + req.session.user)
        res.send({ loggedIn: false });
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

app.post("/login", (req, res) => {
    const loginData = {
        email: req.body.username,
        password: req.body.password,
    }
    
    db.query('SELECT * FROM usr WHERE email = ?;', loginData.email, (err, result) => {
        if (err) {
            console.log(err);
            res.send({ err: err });
        }
        if (result.length > 0) {
            if (loginData.password == result[0].password) {
                req.session.user = result[0];
                console.log(req.session.user);
                req.session.save();
                res.send(req.session.user);
            } else {
                res.send({ message: "Wrong login info" });
            }
        } else {
            res.send({ message: "Email is not registered" });
        };
    });
});

app.get('/logout', (req, res) => {
    req.session.destroy();
    return res.redirect('/');
});

app.listen(3001, () => {
    console.log('listening on port 3001')
})