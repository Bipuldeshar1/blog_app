import mongoose,{Schema} from "mongoose";

const likeSchema= new mongoose.Schema({
    likedBlog:{
         type:Schema.Types.ObjectId,
         ref:"BLog",
    },
    likedBy:{
        type:Schema.Types.ObjectId,
        ref:"User",
    },
},{timestamps:true},)

const Like=new mongoose.model("Like",likeSchema);

export default Like;