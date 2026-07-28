const express = require('express');

const healthRoute = require('./routes/health');

const app = express();

const PORT = process.env.PORT || 3000;

app.use(express.json());

app.use('/', express.static('public'));

app.use('/health', healthRoute);

app.get('/api', (req, res) => {

    res.json({
        application: "Terraform ECS Demo",
        environment: process.env.NODE_ENV || "development",
        status: "Running",
        version: "1.0.0"
    });

});

app.listen(PORT, () => {

    console.log(`Server started on port ${PORT}`);

});
