const mongoose = require('mongoose');

const problemSchema = mongoose.Schema({
    problem:{
        require:true,
        type:String,
    },
    problemtype:{
        require:true,
        type:String,
    },
    problemlocation:{
        require:true,
        type:String,
    },
    problemurl:{
        require:true,
        type:String,
    },
    
})

const Problem = mongoose.model("Problems", problemSchema);
module.exports = Problem;