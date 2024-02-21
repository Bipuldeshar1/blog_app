import User from "../model/user.model.js";
import ApiResponse from "../utils/ApiRespones.js";
import  JWT from "jsonwebtoken";

const verifyJWT= async(req,res,next) =>{
    try {

        const accesstoken= req.header("Authorization")?.replace("Bearer","").trim();
    
        if(!accesstoken){
            throw new ApiResponse(401, {},"unauthorized requests")
        }

        const decodedToken= JWT.verify(accesstoken,process.env.ACCESS_TOKEN_SECRET);

        const user=await User.findById(decodedToken?._id).select("-password -refreshToken")

        if(!user){
            throw new ApiResponse(401, {},"Invalid acceess token user")
        }
        req.user=user;
        next()
    } catch (error) {
        if(error.name === "TokenExpiredError"){
        try {
            console.log('access token expired refreshing....');
            const refreshToken = req.user.refreshToken;
            if (!refreshToken) {
                throw new ApiError(401, "No refresh token provided");
              }
              const decodedRefreshToken = JWT.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
              if (!decodedRefreshToken) {
                throw new ApiError(401, "Invalid refresh token");
              }
               const user = await User.findById(decodedRefreshToken?._id).select("-password -refreshToken");
               
              if (!user) {
                throw new ApiError(401, "Invalid refresh token user");
              }
                   // Generate a new access token
        const newAccessToken = JWT.sign({ _id: user._id }, process.env.ACCESS_TOKEN_SECRET, );
  // Set the new access token in the response header or cookie
  res.status(200).json({ accessToken: newAccessToken });
   // Update req.user with the refreshed user
   req.user = user;

   // Continue to the next middleware
   next();
        } catch (error) {
            console.log(`Error refreshing token: ${error}`);
            throw new ApiError(401, "Error refreshing token");
        }
        
        }
    }
}
export default verifyJWT