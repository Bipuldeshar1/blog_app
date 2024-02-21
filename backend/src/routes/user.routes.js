import express from 'express';
import { currentUser, loginUser, logoutUser, registeruser } from '../controller/user.controller.js';
import verifyJWt from "../middlewares/auth.middleware.js"
const router=express.Router();

router.route("/register").post(registeruser);
router.route("/login").post(loginUser);
router.route("/logout").post(verifyJWt,logoutUser);
router.route("/currentUser").get(verifyJWt,currentUser);

export default router