import mongoose from "mongoose";

const connectDB = async() =>{
    const DBName="blogApp"

    try {
        const conn = await mongoose.connect(`${process.env.MONGODB_URL}/${DBName}`);

        console.log(`mongodb connected to ${conn.connection.host}`);
    } catch (error) {
        console.log(`connection failed ${error}`);
        process.exit(1);
    }

}
export default connectDB