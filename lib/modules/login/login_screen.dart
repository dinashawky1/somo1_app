import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:somo1_app/Network/cacheHelper.dart';
import 'package:somo1_app/modules/HomeLayout/home_layout.dart';
import '../../constants.dart';
import '../Register/register_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // if (state is LoginErrorState) {
          //   showToast(
          //     text: state.error,
          //     state: ToastStates.ERROR,
          //   );
          // }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, HomeLayout());
            });
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Login now to communicate with friends',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_outlined)),
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'please enter your email address';
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: LoginCubit.get(context).obscureText,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                                child: Icon(LoginCubit.get(context).suffix),
                                onTap: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                }),
                          ),
                          onFieldSubmitted: (String? value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'your password is too short';
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => Center(
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              navigateAndFinish(context, RegisterScreen());
                            },
                            child: Text('REGISTER'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
