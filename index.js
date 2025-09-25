const express = require('express');
const mysql = require('mysql2/promise'); 
require('dotenv').config(); 


const app = express();
const port = process.env.PORT || 3000; 


const dbConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
};


app.get('/', (req, res) => {
    res.send('API de CI/CD está funcionando.');
});

app.get('/users', async (req, res) => {
    try {

        const connection = await mysql.createConnection(dbConfig);

        const [rows] = await connection.execute('SELECT * FROM users');

        await connection.end();

        res.json(rows);
    } catch (error) {
        console.error('Error al consultar la base de datos:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});


app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});