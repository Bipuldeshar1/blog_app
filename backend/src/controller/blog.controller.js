import Blog from "../model/blog.model.js";
import ApiResponse from "../utils/ApiRespones.js";
import uploadOnCloudinary from "../utils/cloudinary.js";


const addblog=async(req,res) =>{
    const{title, description}=req.body;
    console.log(`${title}`);

    if(!title || !description ){
        return ApiResponse(500,{},'all fields required');
    }

    const imageLocalPath= req.files?.images.map((image)=>image.path);

    if(!imageLocalPath || imageLocalPath.length>3){
        return ApiResponse(500,{},"not more than 3 images or image field empty")
    }

    const images=await Promise.all(imageLocalPath.map(uploadOnCloudinary));

   if(!images){
    return new ApiResponse(400,{},"umage filed needed")
   }

   const blog=await Blog.create({title,description,images:images.map((img)=>img.url),owner:req.user._id});
   const addedblog= await Blog.findById(blog._id);

   if(!addedblog){
    return new ApiResponse('sth went wrong not added blog')
   }
   return res.status(200).json(
    new ApiResponse(200,{addedblog},'added successfully')
   )

}
const getAllblog= async(req,res) =>{
  const blogs= await Blog.find();

  return res.status(200).json(
    new ApiResponse(200,{blogs},'fetched successfully')
  )

}
const getsingle= async(req,res) =>{
const blog= await Blog.findById(req.params.id);
if(!blog){
    return new ApiResponse(200,{},'no blog found with relevent id')
}
return res.status(200).json(new ApiResponse(200,{blog},'success'))
}
const updateblog= async(req,res)=>{
    const{title, description}= req.body;
    
    if(!title || !description ){
        return new ApiResponse(500,{},'all fields required');
    }
    const imageLocalPath= req.files?.images.map((image)=>image.path);

    if(!imageLocalPath || imageLocalPath.length>3){
        return new ApiResponse(500,{},"not more than 3 images or image field empty")
    }

    const images=await Promise.all(imageLocalPath.map(uploadOnCloudinary));



   if(!images){
    return new ApiResponse(400,{},"umage filed needed")
   }

   const blog=await Blog.findById(req.params.id);
  
console.log(blog.owner._id);
   if(blog.owner._id.toString() !=req.user._id){
    return new ApiResponse(500,{},'unauthorized')
   }
 console.log('u')
   const updatedBlog = await Blog.findByIdAndUpdate(blog._id, {
    title,
    description,
    images: images.map((img) => img.url)
}, { new: true });

   return res.status(200).json(
    new ApiResponse(200,{updatedBlog},'updated successfully')
   )




}
const deleteblog= async(req,res) =>{

 const blog= await Blog.findById(req.params.id);
 if(!blog){
    return new ApiResponse(500,{},'blog not found');
 }
 console.log(blog);
 
 if(blog.owner._id.toString() != req.user._id){
    return new ApiResponse(500,{},'dont have op privelage')
 }
 
 const deletedblog= await Blog.findByIdAndDelete(blog._id)
 return res.status(200).json(
    new ApiResponse(200,{deletedblog},'succeesss')
 )
}

export {addblog,getAllblog,getsingle,updateblog,deleteblog}