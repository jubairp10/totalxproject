// import 'package:flutter/material.dart';
// void main(){
//   runApp(MaterialApp(home: MyWidget(),));
// }
// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }
//
// class _MyWidgetState extends State<MyWidget> {
//   String _phoneNumber = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      body: Column(
//         children: [
//           SizedBox(height: 100,),
//           Image(image: AssetImage('assets/image/OBJECTS.png'),height: 102,
//             width: 130),
//           SizedBox(height: 50),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: EdgeInsets.only(left: 8),
//               child: Text(
//                 "Enter Phone Number",
//                 style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                 labelText: 'Enter Phone Number*',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _phoneNumber = value;
//                 });
//               },
//             ),
//           ),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     if (_phoneNumber.isNotEmpty) {
//           //       // Send OTP to the user's phone number
//           //       // and navigate to the next screen
//           //     }
//           //   },
//           //   child: Text('Get OTP'),
//           // ),
//           // // Text(
//           // //   'By Continuing, I agree to TotalX\'s Terms and condition & privacy policy',
//           // //   style: TextStyle(fontSize: 12),
//           // // ),
//           SizedBox(height: 14),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton(
//                   onPressed: () {
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => login()));
//                   },
//                   child: const Text(
//                     'By Continuing, I agree to TotalX’ Terms and condition \& \nprivacy policy'
//                     ,
//                   )),
//             ],
//           ),
//
//
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: MaterialButton(color: Colors.black,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//
//               onPressed: () {
//
//               }, child: Text('Get OTP',style: TextStyle(color: Colors.white),),
//             ),
//           ),
//           SizedBox(height: 5)
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'otp_verification.dart';


// void main()async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: FirebaseOptions(apiKey: "AIzaSyBzU7uwDBtHaqq95JQ8mXkOnlvV7QkOkyg",
//           appId: "1:450486996611:android:6bde8da9df4b63695a55b6",
//           messagingSenderId: '', projectId: "totalxproject-190b3",
//           storageBucket: "totalxproject-190b3.appspot.com")
//   );
//   runApp(MaterialApp(home: Login(),));
// }


class Login extends StatefulWidget {
  Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Image(
            image: AssetImage("assets/image/OBJECTS.png"),
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child: Text(
              "Enter Phone Number",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter phone number"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verificationid, int? resendtoken) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpscreen(verificationid: verificationid,)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      phoneNumber: phoneController.text.toString());
                },
                child: Text(
                  "Get OTP",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}