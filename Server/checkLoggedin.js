require('dotenv').config()
const jwt = require('jsonwebtoken')

   
function  checkLoggedIn(req, res , next){
    const token = req.headers['x-access-token']
    console.log("request came=============");

    

    try {
        const decoded = jwt.verify(token , process.env.COOKIE_KEY)
       
        res.locals.email = decoded.email
        res.locals.department = decoded.department
        res.locals.id = decoded.id
        console.log("authenticated!")
        next()
    } catch (error) {
        console.log("not authenticated! =============")
        console.log(error)
        res.status(401).json({user  : false })
    }
}


module.exports = checkLoggedIn