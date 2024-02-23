import  express from "express";
import verifyJWT from "../middlewares/auth.middleware.js";
import { addLike, getLike } from "../controller/like.controller.js";

const router=express.Router();

router.use(verifyJWT);

router.route("/add-like/:id").post(addLike);
router.route("/count/:id").get(getLike);

export default router