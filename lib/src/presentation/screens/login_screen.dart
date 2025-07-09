import 'package:ecommerce_with_bloc/src/blocs/authentication/remember_switch_cubit.dart';
import 'package:ecommerce_with_bloc/src/blocs/blocs.dart';
import 'package:ecommerce_with_bloc/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/values.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSurface,
              ),
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state){
                if(state is LoginSuccess){
                  context.goNamed(Routes.HOME_ROUTE);
                }

                if(state is LoginFailed){
                  Fluttertoast.showToast(msg: state.errorMessage);
                }
              },
              builder: (context, state) {
                if(state is LoginInitial){
                  return Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          TextFormField(
                            controller: state.emailController,
                            decoration: InputDecoration(
                              label: Text('Email'),
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            validator: (value){
                              if(value=='' || value == null){
                                return 'Email is required.';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            controller: state.passwordController,
                            decoration: InputDecoration(
                              label: Text('Password'),
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            validator: (value){
                              if(value=='' || value == null){
                                return 'Password is required.';
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                  );
                }else{
                  return Container();
                }

              },
            ),


            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remember Me',
                  style: theme.textTheme.labelMedium,
                ),
                BlocBuilder<RememberSwitchCubit, RememberSwitchState>(
                  builder: (context, state) {
                    return Switch(
                      value: state is SwitchChanged ? state.value : true,
                      onChanged: (value) => context
                          .read<RememberSwitchCubit>().switchToggle(value)
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: theme
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ),
              TextButton(
                onPressed: () => context.pushNamed(Routes.REGISTER_ROUTE),
                child: Text(
                  Values.SIGN_UP_BUTTON_TEXT,
                  style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer),
                ),
              )
            ],
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return FullWidthButton(
                buttonText: state is LoginInitial ? Values.SIGN_IN_BUTTON_TEXT : '',
                buttonChild: state is LoginLoading ? LoadingAnimationWidget.discreteCircle(color: theme.colorScheme.onPrimaryContainer, size: 35.w) : null,
                onTap: () {
                  if(state is LoginInitial){
                    if (formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(RequestEmailLogin(state.emailController.text, state.passwordController.text, RememberSwitchCubit.isRemember));
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}