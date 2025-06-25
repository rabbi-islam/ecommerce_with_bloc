import 'package:ecommerce_with_bloc/src/blocs/authentication/remember_switch_cubit.dart';
import 'package:ecommerce_with_bloc/src/blocs/blocs.dart';
import 'package:ecommerce_with_bloc/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
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
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                if(state is SignupInitial){
                  return Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: state.userNameController,
                            decoration: InputDecoration(
                              label: Text('Username'),
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
                                return 'Username is required.';
                              }
                              return null;
                            },
                          ),

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
                  "Remember Me",
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSurface,
                  ),
                ),
                BlocBuilder<RememberSwitchCubit, RememberSwitchState>(
                  builder: (context, state) {
                    return Switch(
                      value: state is SwitchChanged ? state.value : true,
                      onChanged: (value) {
                        context.read<RememberSwitchCubit>().toggleSwitch(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: FullWidthButton(
        onTap: (){
          if(formKey.currentState!.validate()){
            print('validate');
          }
        },
        buttonText: "Sign Up",
      ),
    );
  }
}
