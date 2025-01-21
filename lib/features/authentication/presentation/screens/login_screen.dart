import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/utils.dart';
import 'package:ebtik_tok/core/widgets/layout_builder.dart';
import 'package:ebtik_tok/core/widgets/responsive_layout.dart';
import 'package:ebtik_tok/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ebtik_tok/core/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      small: _buildBody(scaleX: .94, scaleY: .93),
      medium: _buildBody(scaleX: .95, scaleY: .94),
      );
  }

  Scaffold _buildBody({required double scaleX, required scaleY}) {
    double height = getScreenHeight(context);
    return Scaffold(
    backgroundColor: Colors.black,
    body: BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return BottomNavBar();
          }));
        }
      },
      child: LayoutBuilderWidget(
        child: Transform.scale(
          scaleX: scaleX,
          scaleY: scaleY,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Transform.scale(
                  scaleX: .95,
                  scaleY: .9,
                  child: SvgPicture.asset(logoIconSvgPath)),
                (height * .055).height,
                const Center(
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                (height * .045).height,
                
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: phoneController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                (height * .025).height,
                
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: state.passwordVisiable,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: state.passwordVisiable
                              ? const Icon(Icons.visibility, color: Colors.grey)
                              : const Icon(Icons.visibility_off,
                                  color: Colors.grey),
                          onPressed: () {
                            AuthenticationBloc.get(context)
                                .add(ToggelPasswordVisibilityEvent());
                          },
                        ),
                      ),
                    );
                  },
                ),
                (height * .0325).height,
                
                // Login Button
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return state.status.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 1))
                        : ElevatedButton(
                            onPressed: () {
                              AuthenticationBloc.get(context).add(LoginEvent(
                                  phone: phoneController.text.trim(),
                                  password: passwordController.text.trim()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                  },
                ),
                (height * .025).height,
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }
}
