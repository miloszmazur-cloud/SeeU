/*****************************************************************************************************
SeeU - część serwerowa

Pomysł i wykonanie: Miłosz Mazur

Wersja 0.1 (2024-03-13)
- zaprojektowanie głównych endpointów: createUser, loginUser, saveLocation, getOtherLocation, sendMessage, getMessage.
Wersja 0.2 (2024-03-15/19)
- wstępne uzupełnienie endpointów
Wersja 0.3 (2024-03-21)
- dogadanie z Marcinem reszty plany
Wersja 0.4 (2024-03-23)
- zaprojektowanie createUser
Wersja 0.5 (2024-03-24)
- dzialajacy endpoint createUser
- dzialajacy endpoint loginUser
- poczatek endpointa myPosition
Wersja 0.6 (2024-03-25/30)
- udoskonalanie endpointu myPosition
- finezyjne zapytanie sql
Wersja 0.7 (2024-04-1/5)
- dzialajacy endpoint sendMessage
- poczatek endpointu getMessage
Wersja 0.8 (2024-04-05)
- kontynuacja
Wersja 0.9 (2024-04-06)
- dzialajacy endpoint getMessage
Wersja 0.10 (2024-04-08)
- po konsultacjacg z Panem Marcinem
- statusy odpowiedzi serwera
Wersja 0.12 (2024-04-10)
- tokeny
Wersja 0.13 (2024-04-11)
DZIALAJACA APLIKACJA

*****************************************************************************************************/

const express = require("express");
var router = express.Router();
const serwer = express();
var bodyParser = require("body-parser");
const jwt = require('jsonwebtoken'); // instalacja z poziomu PowerShell: npm install jsonwebtoken
var mysql = require('mysql'); // instalacja: npm install mysql
const { send } = require("express/lib/response");
const lastPositionH = 1; // ile godzin temu uzytkownik byl w poblizu pytajacego?
const lastPositionM = 0;
const lastPositionS = 0;
const dystansOdReszty = 0.002;

serwer.use(bodyParser.json());

console.log("Hello world v0.13a");
serwer.get("/", (req, res) => {
    res.send("Hello World v0.13a");
});

var dbcon = mysql.createPool({
    host: "xx.xx.xx.xx",
    user: "xx",
    password: "xx",
    database: "xx"
});


// TO JUŻ DZIAŁA U FRANKA!!! 
serwer.post("/createUser",  (req, res) => { ///:login/:password/:mail
    // dostaje z aplikacji login, haslo i zapisuje je w bazie danych
    //console.log(req.body);
    const sql = `insert into Users ( login, password, mail) values ( '${req.body.login}', '${req.body.password}', '${req.body.mail}')`;
    //console.log(sql);
    // za kazdym razem jak dotykam bazy danych
    dbcon.query(sql, function (err, result, fields) {
        if (err) {
            result = "uzytkownik juz istnieje"; // DOGADAC z frankuem co tutaj; // sprawdzic czy juz user nie istnieje
            res.sendStatus(403);
        } else {
            result = `Dodano uzytkownika ${req.body.login}`; // DOGADAC z frankiem
            console.log(result);
            res.send(result); 
        }
        
    });
});

function generateAccessToken(user) {  // sprawdzic na tej stronce 
    const payload = {    
        login: user
    };  
    const secret = 'xx';  
    const options = {
        expiresIn: '1000h' 
    };  
    return jwt.sign(payload, secret, options);
}

serwer.post("/loginUser", (req, res) => { ///:login/password
    // dostaje z aplikacji login, haslo i loguje do serwera i porównuje z tymi w bazie danych + 
    // sprawdza login i haslo w bazie danych 
    // jesli sie zgadzaja to ten endpoint zwroci token do aplikacji mobilnej
    //-------------------------------------------------------------------------------
    const sql = `select * from Users u where u.login = '${req.body.login}' and u.password = '${req.body.password}'`;
    dbcon.query(sql, function (err, result, fields) {
       try {
        if(err){
            result = "problem z zalogowaniem"; // DOGADAC z frankuem co tutaj
        } else {
            if (result[0].login === req.body.login){
                result = `zalogowano do ${req.body.login}`;
                console.log(result);
                const currentToken = generateAccessToken(req.body.login);
                res.send(currentToken); 
            }
        }
       } catch (error) {
            res.sendStatus(401); // nie zalogowano
            console.log('[ERR] Bad user or password'); //res.status(403).json({ error: result.error })
       }
    });
});

//---------------- begin:

function verifyAccessToken(token) {
    const secret = 'xx';
    try {
        const decoded = jwt.verify(token, secret);    
        return { 
            success: true, 
            data: decoded};  
        } 
    catch (error) {    
        return {            
            success: false, error: error.message 
        };  
    }
}

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) {
      return res.sendStatus(401);
    }
    const result = verifyAccessToken(token);
    if (!result.success) {
      return res.status(403).json({ error: result.error });
    }
    req.user = result.data;
    next();
}


serwer.post("/myPosition", authenticateToken, (req, res) => {  ///:visibility/:coorX/:coorY
    // otrzymuje pozycje gps i zapisuje w bazie danych
    // token zamiania na login 
    // zapisanie pozycji w bazie danych z loginem i godzina
    //-------------------------------------------------------------------------------
    //const authHeader = req.headers['authorization'];
    //const tokenUser = authHeader && authHeader.split(' ')[1];
    //const properToken = verifyAccessToken(tokenUser);
    //console.log(tokenUser);
    //console.log(properToken);
    //console.log(properToken.data);
    const myLogin = req.user.login;
    if (req.body.visibility){
        // zapisywanie lokalizacji w bazie danych
        const sqlSave = `insert into Coordinates (login,coorX,coorY, datetimeL) values ('${myLogin}', ${req.body.coorX}, ${req.body.coorY}, now())`;
        dbcon.query(sqlSave, function (err, result, fields) {
            if (err) {
                result = "nie ma lokalizacji"; 
            } else {
                result = 'zapisano lokalizacje '; 
            }
            console.log(result + myLogin + ' w bazie danych');
        });
        // wysylanie lokalizacji z bazy danych
        const sqlSearch = `SELECT a.* FROM Coordinates a
            WHERE ID in (
               SELECT max(b.ID) FROM Coordinates b
               GROUP BY b.login
               HAVING max(b.datetimeL) >= (NOW() - MAKETIME(${lastPositionH}, ${lastPositionM}, ${lastPositionS}))
        )`;
        let usersNeer =  [];
        let currentLogin = '';
        let i = 0;
        let j = 0;
        dbcon.query(sqlSearch, function (err, result, fields) {
            if (err) {
                result = "wystapil blad"; /// DOGADAC z frankuem co tutaj
                console.log(result);
                res.send(result);
            } else {
                let noMore = false;
                while (!noMore){
                    currentLogin = result[i].login;
                    const lastValue = result.length - 1;
                    const dcorX = result[i].coorX - req.body.coorX;
                    const dcorY = result[i].coorY - req.body.coorY;
                    user = result[i].login;
                    let distance = (dcorX) ** 2 + (dcorY) ** 2;
                    distance = Math.sqrt(distance);
                    if (currentLogin !== myLogin){
                        if (distance < dystansOdReszty){
                            usersNeer[j] = result[i];    // DOGADAC z frankuem co tutaj
                            j = j + 1;
                        } 
                    }
                    if (i === lastValue){
                        noMore = true;
                    }
                    i = i + 1;
                }
            }
            //console.log(usersNeer);
            res.send(usersNeer);
        });
    } else {
        console.log('nie udostepniasz lokalizacji');
        res.sendStatus(204); // DOGADAC z frankuem co tutaj
    }
});

serwer.post("/sendMessage", authenticateToken, (req, res) => { ///:recipient/:visible/:text
    // wysylanie wiadomosci przez aplikacje do serwera
    // sprawdza token i odbiera wiadomosc z aplikacji
    // zapisuje aplikacji w bazie danych w celu wyslania do adresata
    //-------------------------------------------------------------------------------
    const myLogin = req.user.login;
    console.log(req.body);
    const sql = `insert into Messages (sender, recipient, visible, text, datetimeM , readM) values ( '${myLogin}', '${req.body.recipient}', ${req.body.visible}, '${req.body.text}', now() , false)`;
    dbcon.query(sql, function (err, result, fields) {
        if (err) {
            result = "wiadomosc nie zostala dostarczona"; // DOGADAC z frankuem co tutaj;
            res.sendStatus(205);
        } else {
            result = `${myLogin} wyslal wiadomosc do ${req.body.recipient}`; // DOGADAC z frankiem
            res.sendStatus(200);
        }
        console.log(result);
    });
});

serwer.get("/getMessage", authenticateToken, (req, res) => { 
    // wysylanie wiadomosci przez serwer do aplikacji
    // sprawdza token i sprawdza czy sa nowe wiadomosc
    // odsyla wiadomosci do aplikacji
    //------------------------------------------------------------------------------
    const myLogin = req.user.login;
    let sendM = false;
    let idMes = 0;
    let noMessages = true;
    const sqlg = ` SELECT * FROM Messages u WHERE u.recipient = '${myLogin}' AND u.readM = 0 ORDER BY u.datetimeM ASC LIMIT 1;`;
    dbcon.query(sqlg, function (err, result, fields) {
    if(err){
        result = "cos poszlo nie tak"; // DOGADAC z frankuem co tutaj
    } else {
        if (result[0] === undefined){
            noMessages = false;
            console.log('nie ma wiecej wiadomosci');
            res.send();
        }
        if (noMessages){
            console.log(result[0]);
            res.send(result[0]);
            idMes = result[0].ID;
            sendM = true;
        }
    }
    if (sendM && idMes){
        const sqlm = `UPDATE Messages u SET u.readM = 1 WHERE id = ${idMes};`;
            dbcon.query(sqlm, function (err, result, fields) {
                if (err) {
                    result = 'koniec';
                } else {
                    result = 'zmieniono';
                }
                console.log(result);
        });
    }
    });
});


// end ----------------

//===============================================================================


serwer.listen(3000);

