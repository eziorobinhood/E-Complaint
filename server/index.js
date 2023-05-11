const express = require("express")
const authRoute = require("./routes/auth");
const adminRoute = require("./routes/admin_route");
const problemRoute = require("./routes/problemupload");
const mongoose = require('mongoose');
const PORT = 3000;
const DB = "mongodb+srv://rahuram_krishna:rrkrish123@democluster.sippoyj.mongodb.net/?retryWrites=true&w=majority"

const app = express();
mongoose.connect(DB).then(()=>{console.log("Connection Successful")}).catch(e=>{console.log(e)}); 

app.use(express.json())
app.use(authRoute);
app.use(problemRoute);
app.use(adminRoute);


app.listen(PORT,"0.0.0.0",()=>console.log(`listening to port ${PORT}`))