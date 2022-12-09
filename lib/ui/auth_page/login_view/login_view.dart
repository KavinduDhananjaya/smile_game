import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_game/ui/auth_page/login_view/login_cubit.dart';
import 'package:smile_game/ui/auth_page/login_view/login_state.dart';
import 'package:smile_game/ui/auth_page/signup_view/signup_provider.dart';
import 'package:smile_game/ui/auth_page/signup_view/signup_view.dart';
import 'package:smile_game/ui/home_page/home_page_view.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';
import 'package:smile_game/ui/root_page/root_view.dart';
import 'package:smile_game/ui/widgets/common_snack_bar.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';
import 'package:smile_game/ui/widgets/social_icon.dart';

import '../../../theme/styled_colors.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/reusable_widgets.dart';


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

    final loginBloc = BlocProvider.of<LoginCubit>(context);
    final rootBloc = BlocProvider.of<RootCubit>(context);

    void _loginClicked() {
      ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.loadingSnackBar);

      final email = (_emailController.text).trim();
      final password = (_passwordController.text).trim();
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar.showErrorSnackBar("Email or Password is Empty!"));

        return;
      }

      loginBloc.userLogin(email, password);
    }

    final mediaData = MediaQuery.of(context);

    final scaffold= Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_viewFocus),
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1F1147), Color(0xff362679)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: mediaData.size.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height:64,
                ),
                Padding(
                  padding:
                  EdgeInsets.only(top: context.dynamicHeight(0.03)),
                  child: ReusableWidgets.getImageAsset("logo_shadow.png"),
                ),
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
                        controller: _emailController,
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: StyledColors.primaryColor,
                        onSaved: (email) {},
                        decoration: const InputDecoration(
                          hintText: "Your Email",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
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

                      SizedBox(
                        height: context.dynamicHeight(0.09),
                        width: context.dynamicWidth(0.8),
                        child: InkWell(
                          onTap : () {
                            _loginClicked();
                          },
                          child: Card(
                            color: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                                return SignUpProvider();
                              },
                            ),
                          );
                        },
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: mediaData.size.height * 0.02),
                        width: mediaData.size.width * 0.8,
                        child: Row(
                          children: const <Widget>[
                            Expanded(
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white,
                                height: 2,
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
                            press: () {
                              // loginBloc.googleLogin();
                            },
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

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.showErrorSnackBar(state.error));
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (pre, current) => pre.processing != current.processing,
          listener: (context, state) {
            if (state.processing) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (pre, current) =>
          pre.email != current.email && current.email.isNotEmpty,
          listener: (context, state) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();

            rootBloc.handleUserLogged(state.email);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RootView(
                  email: state.email,
                ),
              ),
            );
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => true,
        child: scaffold,
      ),
    );
  }
}
