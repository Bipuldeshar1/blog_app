import mongoose,{Schema} from "mongoose";

const blogSchema = new mongoose.Schema({
  title:{
    type:String,
    required:true,
  },
  description:{
    type:String,
    required:true,
  },
  images:[{
    type:String,
    required:true,
  }],
 
  owner:{
    type:Schema.Types.ObjectId,
    ref:"User",
    required:true,
  }
},{timestamps:true})

const Blog=new mongoose.model("Blog",blogSchema)
export default Blog;
