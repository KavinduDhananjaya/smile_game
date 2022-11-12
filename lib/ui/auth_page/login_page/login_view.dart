import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smile_game/ui/auth_page/signup_view/signup_view.dart';
import 'package:smile_game/ui/home_page/home_page_view.dart';
import 'package:smile_game/ui/widgets/social_icon.dart';

import '../../../theme/styled_colors.dart';
import '../../widgets/already_have_an_account_acheck.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
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
    final emailField = TextFormField(
      textCapitalization: TextCapitalization.none,
      focusNode: _emailFocus,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: const InputDecoration(labelText: "Email or ID"),
      onFieldSubmitted: (value) {
        _emailFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
    );

    final passwordField = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: !passwordVisible,
      focusNode: _passwordFocus,
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
        FocusScope.of(context).requestFocus(_viewFocus);
      },
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          icon: !passwordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
    );

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
                  "Login",
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 32,
                ),
                SvgPicture.asset("assets/icons/login.svg",height: mediaData.size.height*0.25),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextFormField(
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
                      ),
                      const SizedBox(height: 16),
                      Hero(
                        tag: "login_btn",
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const HomePageView();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Login".toUpperCase(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpView();
                              },
                            ),
                          );
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
