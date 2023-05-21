const cors = require("cors")
const express = require("express")



const app  = express()
app.use(express.json())
app.use(cors())

app.get("/" , (req , res)=>{
    return res.status(201).json({"status"  : "ok"});
})

module.exports = app 