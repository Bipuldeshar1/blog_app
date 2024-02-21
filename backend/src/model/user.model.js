import mongoose from "mongoose";
import JWT from "jsonwebtoken";

const userSchema= new mongoose.Schema({
    userName:{
        type: String,
        required: true,
    },
    email:{
        type: String,
        required: true,
    },
    password:{
        type: String,
        required: true,
    },
    refreshToken:{
        type:String
    },
   
     
}, {timestamps:true})

  userSchema.methods.generateAccessToken = function() {
    return JWT.sign({
        _id:this._id,
    },
    process.env.ACCESS_TOKEN_SECRET,
    {
        expiresIn: process.env.ACCESS_TOKEN_EXPIRY
    }
    )
  }

  userSchema.methods.generateRefreshToken = function(){
    return JWT.sign({
        _id:this._id,
    },
    process.env.REFRESH_TOKEN_SECRET,
    {
        expiresIn: process.env.REFRESH_TOKEN_EXPIRY
    }
    )
  }




const User=mongoose.model("User",userSchema);
export default User