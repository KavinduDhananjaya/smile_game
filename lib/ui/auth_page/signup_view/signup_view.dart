import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/styled_colors.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/social_icon.dart';

class SignUpView extends StatefulWidget {

  const SignUpView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {

  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  late FocusNode _viewFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _viewFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _viewFocus.dispose();
    _emailFocus.dispose();
    _emailController.dispose();
    _passwordFocus.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final mediaData = MediaQuery.of(context);


    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_viewFocus),
        child: SingleChildScrollView(
          child: Container(
            height: mediaData.size.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "SignUp",
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 22,
                ),
                SvgPicture.asset("assets/icons/signup.svg",height: mediaData.size.height*0.25),
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: StyledColors.primaryColor,
                        onSaved: (email) {},
                        decoration: const InputDecoration(
                          hintText: "Your email",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        cursorColor: StyledColors.primaryColor,
                        decoration: const InputDecoration(
                          hintText: "Your password",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        cursorColor: StyledColors.primaryColor,
                        decoration: const InputDecoration(
                          hintText: "Confirm password",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Hero(
                        tag: "signup_btn",
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Sign Up".toUpperCase(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: mediaData.size.height * 0.02),
                        width: mediaData.size.width * 0.8,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: Color(0xFFD9D9D9),
                                height: 1.5,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: StyledColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xFFD9D9D9),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocalIcon(
                            iconSrc: "assets/icons/facebook.svg",
                            press: () {},
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/twitter.svg",
                            press: () {},
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/google-plus.svg",
                            press: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
