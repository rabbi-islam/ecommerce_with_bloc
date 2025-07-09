import 'package:ecommerce_with_bloc/src/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../routes/route_pages.dart';
import '../../utils/values.dart';
import '../widgets/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              "Sign Up",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                if (state is SignupLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SignupInitial) {
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: state.userNameController,
                          decoration: InputDecoration(
                            label: Text('Username'),
                            labelStyle: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                                ),
                          ),
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Username is required.';
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: state.emailController,
                          decoration: InputDecoration(
                            label: Text('Email'),
                            labelStyle: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                                ),
                          ),
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Email is required.';
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: state.passwordController,
                          decoration: InputDecoration(
                            label: Text('Password'),
                            labelStyle: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                                ),
                          ),
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Password is required.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: state.confirmPasswordController,
                          decoration: InputDecoration(
                            label: Text('Confirm Password'),
                            labelStyle: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                                ),
                          ),
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Confirm password is required.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),

            const Gap(20),
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
                'Already have an account?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed(Routes.LOGIN_ROUTE),
                child: Text(
                  Values.SIGN_IN_BUTTON_TEXT,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          BlocConsumer<SignupBloc, SignupState>(
            listener: (context,state){
              if(state is SignupSuccess){
                debugPrint("Signup Success - Navigating to HOME");
                context.goNamed(Routes.HOME_ROUTE);
              }
              if(state is SignupFailed){
                debugPrint("Signup Failed - Staying on Register Route");
                Fluttertoast.showToast(msg: state.message);
              }
            },
            builder: (context, state) {
              return FullWidthButton(
                buttonText: Values.SIGN_UP_BUTTON_TEXT,
                buttonChild: state is SignupLoading
                    ? LoadingAnimationWidget.discreteCircle(
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 35.w,
                      )
                    : null,
                onTap: () {
                  if (state is SignupInitial) {
                    if (formKey.currentState!.validate()) {
                      debugPrint("Signup Button Clicked - navigating if signup success");
                      context.read<SignupBloc>().add(
                        RequestEmailSignup(
                          username: state.userNameController.text,
                          email: state.emailController.text,
                          password: state.passwordController.text,
                          confirmsPassword: state.confirmPasswordController.text
                              .toString(),
                        ),
                      );
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
