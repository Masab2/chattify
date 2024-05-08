// ignore_for_file: use_build_context_synchronously

import 'package:chattify/Bloc/AuthBloc/LoginBloc/loginBloc.dart';
import 'package:chattify/Bloc/AuthBloc/LoginBloc/loginEvent.dart';
import 'package:chattify/Bloc/AuthBloc/LoginBloc/loginState.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/Utils/utils.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:chattify/res/components/AuthHeader/AuthHeader.dart';
import 'package:chattify/res/components/CustomizedFeilds/CustomizedFeilds.dart';
import 'package:chattify/res/components/ResueAbleBtn/ReuseAbleBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _obscurepass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
           physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
          ),
            child: Column(
              children: [
                const AuthHeader(title: 'Welcome back'),
                0.08.ph(context),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                  child: Form(
                    key: _formfield,
                    child: Column(
                      children: [
                        CustomizedFeild(
                          hint: 'abc@gmail.com',
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColor.greyColor.withOpacity(0.63),
                          ),
                          controller: emailController,
                          title: 'Email',
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Email Address';
                            } else if (!emailRegExp.hasMatch(value)) {
                              return 'Please Enter the Email in Proper Format';
                            }
                            return null;
                          },
                        ),
                        0.02.ph(context),
                        ValueListenableBuilder(
                          valueListenable: _obscurepass,
                          builder: (context, value, child) {
                            return CustomizedFeild(
                              title: 'Password',
                              hint: '6 character/digit',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColor.greyColor.withOpacity(0.63),
                              ),
                              obscuretext: _obscurepass.value,
                              sufixIcon: InkWell(
                                  onTap: () {
                                    _obscurepass.value = !_obscurepass.value;
                                  },
                                  child: _obscurepass.value
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: AppColor.searchColor,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: AppColor.searchColor,
                                        )),
                              controller: passwordController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the Password';
                                } else if (value.length < 6) {
                                  return 'Your Password Must be 6 digit';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                0.04.ph(context),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      CircularProgressIndicator.adaptive(
                        backgroundColor: AppColor.greyColor,
                      );
                    } else if (state is LoginSuccessState) {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesNames.bottomScreen,
                      );
                    } else if (state is LoginFailureState) {
                      Utils.showBlurDialog(
                        context,
                        'Error',
                        state.errorMsg,
                        'Cancel',
                        'OK',
                      );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return state is LoginLoadingState
                          ? CircularProgressIndicator.adaptive(
                              backgroundColor: AppColor.greyColor,
                            )
                          : Btn(
                              color: AppColor.darkgreyColor,
                              title: 'Login',
                              ontap: () async {
                                if (_formfield.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(LoginButtonEvent(
                                    email: emailController,
                                    password: passwordController,
                                  ));
                                }
                              },
                              width: context.mw * 0.80,
                              height: context.mh * 0.05,
                            );
                    },
                  ),
                ),
                0.02.ph(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Dont't have an account",
                      style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.015,
                          color: AppColor.greyColor,
                          fontWeight: FontWeight.w400),
                    ),
                    0.03.pw(context),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesNames.signUpScreen);
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.015,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
