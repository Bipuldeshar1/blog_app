import ApiResponse from '../utils/ApiRespones.js'
import User from "../model/user.model.js";
import bcrypt from "bcrypt";

const generateAccessAndRefreshToken= async(userId) =>{
    try {
        const user= await User.findById(userId)
        if (!user) {
            throw new Error('User not found');
        }
        const accessToken=user.generateAccessToken()
        const refreshToken=user.generateRefreshToken()

        user.refreshToken=refreshToken;
        await user.save({validateBeforeSave:false})

        return {accessToken,refreshToken}
    } catch (error) {
        console.error(error);
        throw new Error('Something went wrong while generating access and refresh tokens');
    }
}

const registeruser = async (req, res) => {
    try {
        const { userName, email, password } = req.body;

        if (!userName || !email || !password) {
            return res.status(400).json(new ApiResponse(400, {}, 'Fields cannot be empty'));
        }

        const userAlreadyExist = await User.findOne({ email });

        if (userAlreadyExist) {
            return res.status(400).json(new ApiResponse(400, {}, 'Email already exists'));
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const user = await User.create({ userName, email, password: hashedPassword });

        const createdUser = await User.findById(user._id).select("-password -refreshToken");

        if (!createdUser) {
            return res.status(500).json(new ApiResponse(500, {}, 'Something went wrong, user not created'));
        }

        return res.status(200).json(new ApiResponse(200, createdUser, 'User created successfully'));
    } catch (error) {
        console.log(error);
            }
};

const loginUser =async(req,res) =>{
   try {
    const{email,password} =req.body;

  
    if (!email || !password) {
        return res.status(400).json(new ApiResponse(400, {}, 'Email or password empty'));
    }

   const user =await User.findOne({email});
   if (!user) {
    return res.status(400).json(new ApiResponse(400, { user }, 'User not found'));
}

   const isPasswordValid=await bcrypt.compare(password,user.password);

   if (!isPasswordValid) {
    return res.status(400).json(new ApiResponse(400, {}, 'Invalid password'));
}

const{accessToken, refreshToken}=await generateAccessAndRefreshToken(user._id)

const loggedInUser=await User.findById(user._id).select("-password -refreshToken");



return res.status(200).json(new ApiResponse(200,{
    user:loggedInUser.toObject(),accessToken,refreshToken
 },
 "user logged in success"
 ))
   } catch (error) {
    console.log(error);
   }

}

const logoutUser= async(req,res) =>{
    const user= await User.findByIdAndUpdate(req.user._id,
        {
            $unset:{
                refreshToken:1,
            
            },
        },
        {
            new:true,
        }
        ).select("-password")
        return res.status(200).json(new ApiResponse(200,{user},"user loggout success"))
}

const currentUser= async(req, res) =>{
    const user= await User.findById(req.user._id).select("-password")
    if(!user){
        throw new ApiError(400,"unable to fetch user")
    }
    return res.status(200).json(
        new ApiResponse(200,{user},"fetchec user success")
    )
}
export {registeruser, loginUser,logoutUser, currentUser}