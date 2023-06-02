const cors = require("cors")
const express = require("express")
const freelancer = require("./freelancer/freelancer.mongoose")
const {jobRouter} = require("./job/job.router")
const companyRouter = require("./company/company.router")
const checkLoggedIn  = require("./checkLoggedin")
const {freelancerRouter}= require("./freelancer/freelancer.router")
const {checkCompany} = require("./components/checkCompany")

require("dotenv").config()
    
const app  = express()
const config = {
    COOKIE_KEY : process.env.COOKIE_KEY
}

app.use(express.json())

app.use(cors())      
  
app.get("/logout" , (req, res)=>{
    req.logOut;
    res.status(200).json({
        ok : true
    })
} ) 



app.use("/freelancer" , freelancerRouter)

app.use("/company" , companyRouter)


app.use("/job" , jobRouter)

app.get("/user" , checkLoggedIn , async (req , res)=>{
  
   return res.status(200).json({"user" : true})
})

app.get("/cloggedin" , checkCompany , async(req, res)=>{
    res.status(200).json({"company": true})
}) 

module.exports =  {app  , config}