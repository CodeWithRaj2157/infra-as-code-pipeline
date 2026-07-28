exports.health = (req, res) => {

    res.status(200).json({

        status: "healthy",

        service: "ecs-demo-app",

        uptime: process.uptime(),

        timestamp: new Date()

    });

};
