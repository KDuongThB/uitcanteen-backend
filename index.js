const express = require('express');
const mysql = require('mysql2');
const cors = require("cors");
require("dotenv").config();
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const e = require('express');

const app = express();

const mysqlStore = require('express-mysql-session')(session);

let db;
if (process.env.JAWSDB_URL) {
    const options = {
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWD,
        database: process.env.DB_MAIN
    }
    db = mysql.createPool(process.env.JAWSDB_URL);
    db.multipleStatements = true;
    db.connectionLimit = 10;
    sessionStore = new mysqlStore(options);
}

app.use(function (req, res, next) {

    var allowedDomains = [
        'http://127.0.0.1:5173',
        'http://localhost:5173',
        'https://canteen-uit.netlify.app',
        'https://uit-canteen-admin.netlify.app',
        'http://localhost:3000'
    ];
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
    secret: "this is not a secret",
    resave: false,
    saveUninitialized: false,
    store: sessionStore,
    cookie: {
        maxAge: 8 * 60 * 60 * 1000,
        sameSite: 'none',
        secure: false,
        httpOnly: false
    },
})
);

app.use(express.json());

app.use(bodyParser.urlencoded({ extended: true }));

// app.use(cookieParser());

var sess = {};

// *LOGIN APIs

app.get('/', (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user)
        res.send({ loggedIn: true, user: sess.user })
    else {
        sess.user = 'none';
        res.send({ loggedIn: false, user: sess.user })
    }

});

app.get("/login", (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user)
        res.send({ loggedIn: true, user: sess.user })
    else {
        sess.user = 'none';
        res.send({ loggedIn: false, user: sess.user })
    }
});

app.post("/register", (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user)
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
                res.send({ message: "Email already registered", code: 0 });
            }
            else {
                db.query("INSERT INTO usr (email, password) VALUES (?,?)",
                    [email, password],
                    (err, result) => {
                        if (err) { console.log(err) };
                        if (result) {
                            console.log(result);
                            res.send({ message: "Registered successfully!", code: 1 });
                        };
                    })
            }
        });
    }
});

app.post("/login", (req, res) => {
    // req.session.reload(function (err) {
    //     if (err)
    //         throw (err)
    //     // session updated
    // })
    // var sess = req.session;
    sess = req.session;
    const loginData = {
        email: req.body.username,
        password: req.body.password,
    };
    if (sess.authenticated && sess.user) {
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
                    userData.password = null;
                    sess.user = userData;
                    req.session.save(function (err) {
                        if (err) {
                            console.log(err); return (err);
                        }
                        res.send({ user: sess.user });
                    })
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
});

app.get('/logout', (req, res) => {
    req.session.destroy();
    sess = {};
    res.send({ message: "you have logged out!" })
})

// *MENU APIs

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

// *ORDER APIs

app.post('/sendorder', (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user) {
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
        db.query('SELECT * FROM ordr \
        LEFT JOIN order_detail ON ordr.orderId=order_detail.orderId \
        LEFT JOIN invoice ON invoice.orderId=ordr.orderId',
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
    db.query('SELECT * FROM ordr ORDER BY orderId DESC LIMIT 1',
        (err, result) => {
            if (err) {
                console.log(err)
                res.send({ err: err })
            }
            if (result) {
                console.log(result)
                var orderId = result[0].orderId;
                res.send({ orderId })
            }
        })
})

app.get('/completed', (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user.userId) {
        db.query('SELECT * FROM ordr \
        LEFT JOIN invoice ON invoice.orderId=ordr.orderId \
        WHERE ((ordr.statusOrderId = 1 OR ordr.statusOrderId = 2) AND ordr.userId = ?)',
            sess.user.userId,
            (err, rows, fields) => {
                if (err) {
                    console.log(err)
                    res.send({ err: err })
                }
                if (rows)
                    res.send({ completedOrders: rows });
            })
    } else {
        res.status(401).send({ message: "not logged in" })
    }
})

app.get('/cancelled', (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user.userId) {
        db.query('SELECT * FROM ordr \
        LEFT JOIN invoice ON invoice.orderId=ordr.orderId \
        WHERE statusOrderId = 3 AND ordr.userId = ?',
            sess.user.userId,
            (err, rows, fields) => {
                if (err) {
                    console.log(err)
                    res.send({ err: err })
                }
                if (rows)
                    res.send({ cancelledOrders: rows });
            })
    } else {
        res.status(401).send({ message: "not logged in" })
    }
})

// *USER APIs
app.get('/user', (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user)
        res.send({ user: sess.user });
    else
        res.send({ message: "not logged in" })
})

app.post('/updateuser', (req, res) => {
    // var sess = req.session;
    if (sess.authenticated && sess.user) {
        var data = Object.keys(req.body)[0];
        var userInfo = JSON.parse(data);
        console.log(userInfo)
        var userId = userInfo.userId;
        var names = userInfo.fullName.split(' ');
        var lastName = names[0];
        var firstName = names[1] + " " + names[2];
        var mobile = userInfo.phoneNumber;
        var studentId = parseInt(userInfo.studentId);
        console.log(lastName, "\n", firstName, "\n", mobile, "\n", studentId);
        db.query('UPDATE usr \
        SET lastName = ?, firstName = ?, mobile = ?, studentId = ? \
        WHERE userId = ?',
            [lastName, firstName, mobile, studentId, userId],
            (err, result) => {
                if (err) {
                    console.log(err)
                    res.send({ message: "cannot update", err: err })
                }
                if (result) {
                    db.query('SELECT * FROM usr WHERE userId = ?', userId,
                        (err, result) => {
                            if (err) {
                                console.log(err)
                                res.send({ message: "cannot update", err: err })
                            }
                            if (result.length > 0) {
                                res.send({ message: "UPDATE, PEOPLE! UPDATE!", user: result[0] })
                            }

                        })
                }
            })
    }
    else {
        res.status(401).send({ message: "not logged in" });
    }

})

/* WOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO */
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => { console.log('listening on port ' + PORT) })
