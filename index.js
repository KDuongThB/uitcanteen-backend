const express = require('express');
const mysql = require('mysql2');
const cors = require("cors");
require("dotenv").config();
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const session = require("express-session");

const app = express();

const mysqlStore = require('express-mysql-session')(session);

let db, sessionStore;
if (process.env.JAWSDB_URL) {
    db = mysql.createPool(process.env.JAWSDB_URL);
    // sessionStore = new mysqlStore(process.env.JAWSDB_URL)
    db.multipleStatements = true;
    db.connectionLimit = 10;
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

// var corsOptions = {
//     origin: "*",
//     credentials: true
// }

// app.use(cors())

app.use(function (req, res, next) {

    var allowedDomains = ['http://127.0.0.1:5173', 'http://localhost:5173', 'https://canteen-uit.netlify.app', 'https://uit-canteen-admin.netlify.app', 'http:://localhost:3000'];
    var origin = req.headers.origin;
    if (allowedDomains.indexOf(origin) > -1) {
        res.setHeader('Access-Control-Allow-Origin', origin);
    }
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type, Accept');
    res.setHeader('Access-Control-Allow-Credentials', true);

    next();
})

app.use(session({
    name: "uit_sess",
    secret: "abcxyz",
    resave: false,
    saveUninitialized: false,
    // store: sessionStore,
    cookie: {
        maxAge: 8 * 60 * 60 * 1000,
        sameSite: true,
        secure: false,
        httpOnly: false
    },

})
);

app.use(express.json());

app.use(bodyParser.urlencoded({ extended: true }));

app.use(cookieParser());

var sess = {};

// LOGIN APIs

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
                userData.password = null;
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

// MENU APIs

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

// ORDER APIs

app.post('/sendorder',
    (req, res) => {
        if (sess.authenticated) {
            let orderDetails = req.body;
            let items = JSON.parse(orderDetails.items)

            console.log(orderDetails)
            // orderDetails.items = items;
            console.log(items);
            db.query("INSERT INTO ordr (userId,statusOrderId) VALUES (?, ?)",
                [orderDetails.userId, 2],
                (err, result) => {
                    if (err) {
                        console.log(err)
                        res.send({ message: "cannot take order", err: err })
                    }
                    if (result) {
                        var orderId = result.insertId;
                        let total = 25000;
                        if (orderDetails.cost == "30.000vnd")
                            total = 30000;
                        let invoiceDetails = {
                            userId: orderDetails.userId,
                            orderId: orderId,
                            total: total,
                            paymentId: parseInt(orderDetails.payMethod)
                        }
                        db.query("INSERT INTO invoice (userId, orderId, total, paymentId) VALUES (?, ? ,? ,?)",
                            [invoiceDetails.userId, invoiceDetails.orderId, invoiceDetails.total, invoiceDetails.paymentId], (err, result) => {
                                if (err) {
                                    console.log(err)
                                    res.send({ message: "cannot take order", err: err })
                                }
                            })
                        console.log("order ID: " + orderId)
                        for (let i = 0; i < items.length; i++) {
                            console.log(items[i]);
                            db.query("INSERT INTO order_detail (orderId, dishId, quantity) VALUES (?, ?, ?)", [orderId, items[i].id, items[i].quantity], (err, result) => {
                                if (err) {
                                    console.log(err);
                                    res.send({ message: "cannot take order", err: err })
                                }
                            })
                        }

                        res.send({ message: "order taken!", orderId: orderId })
                    }
                })
        } else {
            res.status(401).send({ message: "Not logged in" })
        }
    })

app.get('/allorders',
    (req, res) => {
        db.query('SELECT * FROM ordr LEFT JOIN order_detail ON ordr.orderId=order_detail.orderId',
            (err, rows, fields) => {
                if (err) {
                    console.log(err)
                    res.send({ err: err })
                }
                if (rows)
                    res.send({ orders: rows });
            })
        // db.query('SELECT * FROM order_detail', (err, result) => {
        //     if (err)
        //         console.log(err);
        //     if (result.length > 0)
        //         for (let i = 0; i < result.length; i++)
        //             orderDetails.push(result[i]);
        // })
        // console.log(orderDetails, "\n", orderList)
        // res.send({ orderList: orderList, orderDetails: orderDetails });
    });

app.get('/recentorder', (req, res) => {
    db.query('SELECT * FROM ordr ORDER BY orderId DESC LIMIT 1'), (err, result) => {
        if (err) {
            console.log(err)
            res.send({ err: err })
        }
        if (result)
            res.send({ lastOrder: result })
    }
})

// USER APIs

app.post('/updateuser', (req, res) => {
    if (sess.authenticated) {
        userInfo = req.body;
        // todo
        res.send({ message: "UPDATE, PEOPLE! UPDATE!" })
    }
    else {
        res.status(401).send({ message: "not logged in" });
    }

})

/* WOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO */
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => { console.log('listening on port ' + PORT) })
