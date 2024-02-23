import Like from "../model/like.model.js";
import Blog from "../model/blog.model.js";
import ApiResponse from "../utils/ApiRespones.js";

const addLike = async (req, res) => {
  console.log('add');
  const id = req.params.id;
  const blog = await Blog.findById(id);
  
  if (!blog) {
    return res.status(401).json(new ApiResponse(401, { blog }, "Blog with the given ID not found"));
  }

  const alreadyLiked = await Like.findOne({ 'likedBy': req.user._id, 'likedBlog': blog._id });

  if (alreadyLiked) {
    const remove = await Like.deleteOne({ 'likedBy': req.user._id, 'likedBlog': blog._id });

    return res.status(200).json(new ApiResponse(200, { remove }, 'Like removed'));
  } else {
    const liked = await Like.create({ likedBlog: id, likedBy: req.user._id });
    return res.status(200).json(new ApiResponse(200, { liked }, 'Like added successfully'));
  }
};



const getLike= async(req,res)=>{
  console.log('getting');
  const Blogid= req.params.id;

  const likeCount = await Like.countDocuments({'likedBlog': Blogid});
  
  return res.status(200).json(
    new ApiResponse(200,{likeCount},'suceess')
  );

}

export {addLike,getLike}