const mongoose = require('mongoose');

const problemSchema = mongoose.Schema({
    problem:{
        require:true,
        type:String,
    },
    
})

const Problem = mongoose.model("Problems", problemSchema);
module.exports = Problem;