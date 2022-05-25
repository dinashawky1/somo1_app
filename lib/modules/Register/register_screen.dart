import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somo1_app/Network/cacheHelper.dart';
import 'package:somo1_app/modules/HomeLayout/home_layout.dart';
import 'package:somo1_app/modules/Register/register_state.dart';
import 'register_cubit.dart';
import '../../constants.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var state;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is CreateUserSuccessState) {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            navigateAndFinish(context, HomeLayout());
          });
        }
      }, builder: (context, State) {
        return Scaffold(
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
                        'Register',
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Register now to communicate with friends',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person)),
                          validator: (String? value) {
                            if (value!.isEmpty) return 'please enter your name';
                          }),
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
                          obscureText: RegisterCubit.get(context).obscureText,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  RegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                child: Icon(RegisterCubit.get(context).suffix),
                              )),
                          onFieldSubmitted: (String value) {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'your password is too short';
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone)),
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'please enter your phone number';
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => Center(
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
