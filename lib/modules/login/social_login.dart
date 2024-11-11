import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/social_login_cubit/cubit.dart';
import 'package:social_app/modules/login/social_login_cubit/states.dart';
import '../../layout/app_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/social_register.dart';

// ignore: must_be_immutable
class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
            if (state is SocialLoginErrorState) {
              showToast(msg: state.erro, state: ToastStates.ERROR);
            }
            if (state is SocialLoginSuccessState) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                navigateAndKill(context, SocialAppLayoutScreen());
              });
            }

            // if (state is SocialLoginSuccessState) {
            //   if (state.loginModel.status) {
            //     print(state.loginModel.data!.token);
            //
            //     CacheHelper.saveData(
            //       key: 'token',
            //       value: state.loginModel.data!.token!,
            //     ).then((value) {
            //       token = state.loginModel.data!.token!;
            //       navigateAndKill(context, SocialLayoutScreen());
            //     });
            //   } else {
            //     //print(state.loginModel.message);
            //
            //     showToast(
            //         msg: '${state.loginModel.message}',
            //         state: ToastStates.ERROR);
            //   }
            // }
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
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Login Now To Enjoy With Friends :)',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          defFormField(
                              controller: emailController,
                              label: 'e-mail',
                              prefix: Icons.email_outlined,
                              validate: (value) {
                                if (value!.isEmpty)
                                  return 'Email Address Must Be Filled';
                                else
                                  return null;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          defFormField(
                              controller: passwordController,
                              label: 'password',
                              onSubmit: (vlaue) {
                                if (formkey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              prefix: Icons.lock_outline,
                              validate: (value) {
                                if (value!.isEmpty)
                                  return 'Password is Too Short :(';
                                else
                                  return null;
                              },
                              suffix: SocialLoginCubit.get(context).suffix,
                              isPassword:
                                  SocialLoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                SocialLoginCubit.get(context)
                                    .chandPasswordVisibility();
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defButton(
                                text: 'login',
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                }),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t Have an Account ?'),
                              SizedBox(
                                width: 5.0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateAndKill(
                                        context, SocialRegisterScreen());
                                  },
                                  child: Text('register'.toUpperCase()))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
