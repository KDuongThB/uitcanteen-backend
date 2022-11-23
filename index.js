const express = require('express');
const mysql = require('mysql');
const app = express();
const cors = require("cors");

const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const { query } = require('express');

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
    session({
        key: "userId",
        secret: "abcxyz",
        resave: false,
        saveUninitialized: false,
        cookie: {
            expires: 1000 * 60 * 60 * 24
        },
    })
);

app.get('/', (req, res) => {
    session = req.session;
    if (session.userId) {
        res.send("Welcome User");
    }
    // else {
    //      res.sendFile('view/index.html', {root:__dirname})
    // }
});

app.post('/user', (req, res) => {
    var myusername;
    var mypassword;

    if (req.body.username == myusername && req.body.password == mypassword) {
        session = req.session;
        session.userid = req.body.username;
        console.log(req.session)
        res.send(`Hey there, welcome <a href=\'/logout'>click to logout</a>`);
    }
    else {
        res.send('Invalid username or password');
    }
})

app.post("/register", (req, res) => {
    const username = req.body.username;
    const password = req.body.password;
    db.query('SELECT FROM usr WHERE email = ?', username, (err, result) => {
        if (err) { console.log({ err }) };
        if (result.length > 0) {
            res.send({ message: "Email already registered" });
        }
        else
        {
            db.query(
                "INSERT INTO usr (email, password) VALUES (?,?)",
                [username, password],
                (err, result) => {
                    if (err) { console.log(err) };
                    if (result) {
                        console.log(result);
                    };
                })
        }
    });
   
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

    db.query('SELECT * FROM usr WHERE email = ?;', username, (err, result) => {
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

app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/');
});

app.listen(3001, () => {
    console.log('listening on port 3001')
})