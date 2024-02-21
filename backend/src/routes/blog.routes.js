import express from 'express';
import {upload} from "../middlewares/multer.middleware.js"
import verifyJWt from "../middlewares/auth.middleware.js"
import { addblog, deleteblog, getAllblog, getsingle, updateblog } from '../controller/blog.controller.js';
const router=express.Router();

router.use(verifyJWt);
router.route("/addBlog").post(
    upload.fields([
        {
            name:"images",
            maxCount:3,
        }
    ])
    ,addblog);
router.route("/getAll").get(getAllblog);
router.route("/getSingle/:id").get(getsingle);
router.route("/update/:id").patch(upload.fields([
    {
        name:"images",
        maxCount:3
    }

]),updateblog);

router.route("/delete/:id").delete(deleteblog);

export default router;