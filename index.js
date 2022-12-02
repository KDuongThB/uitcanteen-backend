const express = require('express');
const mysql = require('mysql');
const cors = require("cors");
require("dotenv").config();
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const session = require("express-session");

const app = express();

const mysqlStore = require('express-mysql-session')(session);

let db, sessionStore;
if (process.env.JAWSDB_URL) {
    db = mysql.createConnection(process.env.JAWSDB_URL);
    // sessionStore = new mysqlStore(process.env.JAWSDB_URL);
}

else {
    db = mysql.createConnection({
        user: 'root',
        host: 'localhost',
        port: '3306',
        password: '',
        database: 'uitcanteen'
    })
}

var whitelist = ['https://canteen-uit.netlify.app', 'http://127.0.0.1:5173', "http://localhost:5173"]
var corsOptions = {
    origin: "*",
    credentials: true
}

app.use(cors(corsOptions))

app.use(session({
    name: "uit_sess",
    secret: "abcxyz",
    resave: false,
    saveUninitialized: false,
    // store: sessionStore,
    cookie: {
        maxAge: 8 * 60 * 60 * 1000,
        sameSite: true,
        secure: true
    },
    // httpOnly: false
})
);

app.use(express.json());

app.use(bodyParser.urlencoded({ extended: true }));

app.use(cookieParser());

var sess = {};

app.get('/', (req, res) => {
    if (sess.authenticated)
        res.send({ loggedIn: true, user: sess.user })
    else
        res.send({ loggedIn: false })
});

app.get("/login", (req, res) => {
    // sess = req.session;
    if (sess.authenticated)
        res.send({ loggedIn: true, user: sess.user })
    else
        res.send({ loggedIn: false })
});

app.post("/register", (req, res) => {
    // sess = req.session;
    if (sess.authenticated)
        res.send({ loggedIn: true, user: sess.user })
    else {
        const email = req.body.username;
        const password = req.body.password;
        console.log("email: " + email)
        db.query("SELECT * FROM usr WHERE email = ?;", email, (err, result) => {
            if (err) {
                console.log(err);
            }

            if (result.length > 0) {
                console.log(result);
                res.send({ message: "Email already registered" });
            }
            else {
                db.query("INSERT INTO usr (email, password) VALUES (?,?)",
                    [email, password],
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
    sess = req.session;
    const loginData = {
        email: req.body.username,
        password: req.body.password,
    };
    if (sess.authenticated) {
        res.send({ loggedIn: true, user: sess.user })
    }
    else {
        db.query('SELECT * FROM usr WHERE email = ?', loginData.email, (err, result) => {
            if (err) {
                console.log(err);
                res.send({ err: err });
            }
            if (result.length > 0) {
                const userData = result[0];
                if (loginData.password === userData.password) {
                    console.log('login query works\n', userData);
                    sess.authenticated = true;
                    sess.user = userData;
                    res.send(req.session.user);
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
        if (err) {
            console.log(err); return (err);
        }
    })
});

app.get('/logout', (req, res) => {
    req.session.destroy();
    sess = {};
    res.send({ message: "you have logged out!" })
})

app.get('/user', (req, res) => {
    if (sess.authenticated && sess.user)
        res.send({ user: sess.user });
    else
        res.send({ message: "not logged in" })
})

app.get('/menu', (req, res) => {
    db.query('SELECT * from dish WHERE 1', (err, result) => {
        if (err)
            throw (err);
        if (result)
            res.send({ menu: result });
    })
})

app.get('/menu/main', (req, res) => {
    db.query('SELECT * from dish WHERE dishTypeId = 1', (err, result) => {
        if (err)
            throw (err);
        if (result)
            res.send({ menu: result });
    })
})

app.get('/menu/main/proposed', (req, res) => {
    db.query('SELECT * from dish WHERE dishTypeId = 1 ORDER BY RAND() LIMIT 5', (err, result) => {
        if (err)
            throw (err);
        if (result)
            res.send({ menu: result });
    })
})

app.get('/menu/side', (req, res) => {
    db.query('SELECT * from dish WHERE dishTypeId = 2', (err, result) => {
        if (err)
            throw (err);
        if (result)
            res.send({ menu: result });
    })
})

app.get('/menu/side/proposed', (req, res) => {
    db.query('SELECT * from dish WHERE dishTypeId = 2 ORDER BY RAND() LIMIT 3', (err, result) => {
        if (err)
            throw (err);
        if (result)
            res.send({ menu: result });
    })
})

app.get('/ingredient', (req, res) => {
    db.query('SELECT * from ingredient WHERE 1', (err, result) => {
        if (err)
            throw (err);
        if (result)
            res.send({ result });
    })
})

app.post('/sendorder', (req, res) => {
    if (sess.authenticated) {
        console.log(req.body)
        res.send({message: "order taken!"})
    }
    else
        res.status(401).send({message: "Not logged in"})

})

app.get('/getorder', (req, res) => {
    res.send('ưhat')
})

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => { console.log('listening on port ' + PORT) })
