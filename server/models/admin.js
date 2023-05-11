const mongoose = require('mongoose');

const adminSchema = mongoose.Schema({
    username:{
        require:true,
        type:String,
        trim:true,
    },
    password:{
        require:true,
        type:String,  
    },
    type:{type:String,default:'admin'}
})

const Admin = mongoose.model("Admin", adminSchema);
module.exports = Admin;