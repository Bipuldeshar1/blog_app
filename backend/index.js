import express from "express";
import connectDB from "./src/db/connect.js";
import userRoute from "./src/routes/user.routes.js"
import cors from "cors"
import dotenv from "dotenv"
import blogRoute from "./src/routes/blog.routes.js";
import LikeRoute from "./src/routes/like.routes.js";

const app= express();

dotenv.config({
    path: './.env'
});

app.use(express.json());
app.use(cors());

const PORT= process.env.PORT || 8000;

connectDB().then(app.listen(PORT, () =>{
    console.log(`server runnning in port ${PORT}`);
})).catch((err) =>{
    console.log(`mongo db conn fail`,err);
});

app.use("/api/v1/blog",blogRoute)
app.use("/api/v1/user",userRoute)
app.use("/api/v1/Like",LikeRoute)
