import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'khongtontai231@gmail.com',			//email ID
        pass: 'bowprpfhvoxswtzp'				//Password 
    }
});

export default {
    sendMail(email , otp){
        const details = {
            from: 'khongtontai231@gmail.com', // sender address same as above
            to: email, 					// Receiver's email id
            subject: 'Your demo OTP is ', // Subject of the mail.
            html: otp					// Sending OTP 
        };
        transporter.sendMail(details, function (error, data) {
            if(error)
                console.log(error)
            // else
                // console.log(data);
        });
    }  
}