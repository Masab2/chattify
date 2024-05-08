// ignore_for_file: use_build_context_synchronously

import 'package:chattify/Bloc/AuthBloc/SignUpBloc/signUpBloc.dart';
import 'package:chattify/Bloc/AuthBloc/SignUpBloc/signupEvent.dart';
import 'package:chattify/Bloc/AuthBloc/SignUpBloc/signupState.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/Utils/utils.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:chattify/res/components/CustomizedFeilds/CustomizedFeilds.dart';
import 'package:chattify/res/components/ResueAbleBtn/ReuseAbleBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  @override
  void dispose() {
    //implement dispose
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phonenoController.dispose();
    _obscurepass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
          ),
          child: Column(
            children: [
              0.03.ph(context),
              Column(
                children: [
                  Text(
                    'Create New Account',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.023,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Fill Your Details here',
                    style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.017,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyColor.withOpacity(0.65)),
                  )
                ],
              ),
              0.08.ph(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                child: Form(
                  key: _formfield,
                  child: Column(
                    children: [
                      CustomizedFeild(
                        hint: 'Masab',
                        prefixIcon: Icon(Icons.person,
                            color: AppColor.greyColor.withOpacity(0.63)),
                        controller: usernameController,
                        title: 'Username',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter the username';
                          }
                          return null;
                        },
                      ),
                      0.02.ph(context),
                      CustomizedFeild(
                        hint: 'abc@gmail.com',
                        prefixIcon: Icon(Icons.email,
                            color: AppColor.greyColor.withOpacity(0.63)),
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
                            prefixIcon: Icon(Icons.lock,
                                color: AppColor.greyColor.withOpacity(0.63)),
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
                      0.02.ph(context),
                      CustomizedFeild(
                        hint: 'Must be off 11 digit',
                        prefixIcon: Icon(Icons.phone,
                            color: AppColor.greyColor.withOpacity(0.63)),
                        controller: phonenoController,
                        title: 'Phone No',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Password';
                          } else if (value.length < 11 && value.length > 11) {
                            return 'Phone No contains thee 11 digit';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              0.04.ph(context),
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSucessState) {
                    Navigator.pushReplacementNamed(
                        context, RoutesNames.loginScreen);
                  } else if (state is SignUpFailureState) {
                    Utils.showBlurDialog(
                      context,
                      'Error',
                      state.errmsg,
                      'Cancel',
                      'OK',
                    );
                  }
                },
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return state is SignUpLoadingState
                        ? CircularProgressIndicator.adaptive(
                            backgroundColor: AppColor.greyColor,
                          )
                        : Btn(
                            color: AppColor.darkgreyColor,
                            title: 'Create Account',
                            ontap: () async {
                              if (_formfield.currentState!.validate()) {
                                BlocProvider.of<SignUpBloc>(context)
                                    .add(SignUpButtonEvent(
                                  username: usernameController,
                                  email: emailController,
                                  password: passwordController,
                                  phone: phonenoController,
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
                    "Already have an account",
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.015,
                      color: AppColor.greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  0.03.pw(context),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesNames.loginScreen);
                    },
                    child: Text(
                      "Sign In",
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
    );
  }
}
