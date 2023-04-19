const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name:{
        require:true,
        type:String,
        trim:true,
    },
    phoneNumber:{
        require:true,
        type:String,
        trim:true,
    },
    password:{
        require:true,
        type:String,  
        validate:{
            validator: (value) => {
                return value.length>8;
            },
            message:"Please enter long password"
        }
    },
    confirmPassword:{
        require:true,
        type:String,
        
    },
    type:{type:String,default:'user'}
})

const User = mongoose.model("User", userSchema);
module.exports = User;