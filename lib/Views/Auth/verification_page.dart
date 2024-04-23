import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  PinCodeVerificationScreen(this.phoneNumber);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  // var onTapRecognizer;

  // TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // onTapRecognizer = TapGestureRecognizer()
    //   ..onTap = () {
    //     Navigator.pop(context);
    //   };
    // errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    // errorController?.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
      backgroundColor: AppColors.WHITE,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColors.BLACK,),onPressed: (){
          Navigator.pop(context);
        },),
        centerTitle: true,
        title: Text("Verification", style: TextStyle(color: AppColors.BLACK, fontSize: 16),),
      ),
      body:  Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.loadPage ? Center(child: CircularProgressIndicator()): GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                    ),
                    AppSpaces.height40,
          
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Verify your email address',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    AppSpaces.height16,
                    RichText(
                      text: TextSpan(
                          text: "Enter the 6-digit code sent to ",
                          children: [
                            TextSpan(
                                text: widget.phoneNumber,
                                style: GoogleFonts.raleway(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                          style: GoogleFonts.raleway(
                              color: Colors.black54, fontSize: 14)),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: false,
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 3) {
                                return "I'm from validator";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 50,
                                selectedColor: AppColors.PRIMARYCOLOR,
                                selectedFillColor: AppColors.WHITE,
                                activeFillColor: AppColors.WHITE,
                                disabledColor: AppColors.PRIMARYCOLOR,
                                // : AppColors.WHITE,
                                borderWidth: 0.5,
                                activeBorderWidth: 0.5,
                                selectedBorderWidth: 0.5,
                                activeColor: AppColors.PRIMARYCOLOR,
                                inactiveColor: AppColors.PRIMARYCOLOR,
                                inactiveFillColor: AppColors.WHITE,
                                inactiveBorderWidth: 0.5),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            textStyle:
                                const TextStyle(fontSize: 20, height: 1.6),
                            backgroundColor: Colors.white,
                            enableActiveFill: true,
                            // errorAnimationController: errorController,
                            // controller: textEditingController,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    //   child: Text(
                    //     hasError ? "*Please fill up all the cells properly" : "",
                    //     style: TextStyle(
                    //         color: Colors.red,
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                    Center(
                        child: Text(
                      "I didn’t get the code (00:45)",
                      style: GoogleFonts.raleway(
                          decoration: TextDecoration.underline),
                    )),
          
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        onTap: () {
                          if (formKey.currentState?.validate() == true) {
                           auth.verifyPin(context, currentText);
                          }
                        },
                        color: AppColors.SECONDARYCOLOR,
                        title: ("Verify"),
                      ),
                    ),
                    AppSpaces.height40
                  ],
                ),
              ),
            ),
          );
        }
      )
      
    );
  }
}
