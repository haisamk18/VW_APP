import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vw_app/Pages/Bluetoothconnect.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final _formKey = GlobalKey<FormState>();
  final int otp = 4768;
  late String pin;
  bool isWrongotp=false;
  TextEditingController? pinLoginController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontWeight: FontWeight.w800,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        border: Border.all(color: Color.fromRGBO(52, 52, 52, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.black87,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/bikeatom.png',
                  width: 250,
                  height: 250,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please Enter your OTP",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Pinput(
                  controller: pinLoginController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  onChanged: (value) {
                    setState(() {
                      pin=value;
                       pinLoginController?.value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (pin == otp.toString()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BluetoothConnect(),
                            ),
                          );
                        } else {
                          setState(() {
                            pinLoginController?.clear();// Clearing PIN field
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pin is incorrect'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                              (route) => false,
                        );
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
