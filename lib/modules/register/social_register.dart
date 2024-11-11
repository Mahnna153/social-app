import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/app_layout.dart';
import 'package:social_app/modules/register/social_register_cubit/cubit.dart';
import 'package:social_app/modules/register/social_register_cubit/states.dart';

import '../../shared/components/components.dart';
import '../login/social_login.dart';

class SocialRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterSuccessState) {
            navigateAndKill(context, SocialAppLayoutScreen());
          }

          //   if (state is SocialRegisterSuccessState) {
          //     if (state.loginModel.status) {
          //       print(state.loginModel.data!.token);
          //
          //       CacheHelper.saveData(
          //         key: 'token',
          //         value: state.loginModel.data!.token!,
          //       ).then((value) {
          //         token = state.loginModel.data!.token!;
          //         navigateAndKill(context, SocialLoginScreen());
          //       });
          //     } else {
          //       //print(state.loginModel.message);
          //
          //       showToast(
          //           msg: '${state.loginModel.message}', state: ToastStates.ERROR);
          //     }
          //   }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Register Now To Enjoy With Friends :)',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defFormField(
                            controller: nameController,
                            label: 'Your name :)',
                            prefix: Icons.person,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'User Name Must Be Filled :(';
                              else
                                return null;
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defFormField(
                            controller: emailController,
                            label: 'E-mail Address :)',
                            prefix: Icons.email,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'Email Address Must Be Filled :(';
                              else
                                return null;
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defFormField(
                            controller: passwordController,
                            label: 'Password',
                            /*onSubmit: (vlaue) {
                                if (formkey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },*/
                            prefix: Icons.lock_outline,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'Password is Too Short :(';
                              else
                                return null;
                            },
                            suffix: SocialRegisterCubit.get(context).suffix,
                            isPassword:
                                SocialRegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
                                  .chandPasswordVisibility();
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defFormField(
                            controller: phoneController,
                            label: 'Phone Number :)',
                            prefix: Icons.phone_android,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'Phone Number Must Be Filled :(';
                              else
                                return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defButton(
                              text: 'register',
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
