import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import 'package:flutter_application_1/DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import 'package:flutter_application_1/DesignSystem/Components/InputField/input_text.dart';
import 'package:flutter_application_1/DesignSystem/Components/InputField/input_text_view_model.dart';
import 'package:flutter_application_1/DesignSystem/shared/colors.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool acceptedTerms = false;
  bool isHovering = false; // Estado para gerenciar o hover no "Terms & Services"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: lightTertiaryBaseColorLight,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('images/anonimous.jpg'), // Imagem de perfil
            ),
            SizedBox(height: 20),
            StyledInputField.instantiate(
              viewModel: InputTextViewModel(
                controller: emailController,
                placeholder: 'E-mail',
                password: false,
              ),
            ),
            SizedBox(height: 16),
            StyledInputField.instantiate(
              viewModel: InputTextViewModel(
                controller: passwordController,
                placeholder: 'Password',
                password: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: acceptedTerms,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  checkColor: Colors.transparent,
                  onChanged: (value) {
                    setState(() {
                      acceptedTerms = value!;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'I have read and agree to ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Terms & Services',
                          style: TextStyle(
                            color: isHovering ? Colors.blueAccent : Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Ação ao clicar em "Terms & Services"
                              print('Terms & Services');
                              // Navegar para a página de termos e condições, se necessário
                            },
                          onEnter: (event) {
                            setState(() => isHovering = true);
                          },
                          onExit: (event) {
                            setState(() => isHovering = false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.large,
                  style: ActionButtonStyle.primary,
                  text: 'Sign Up',
                  onPressed: () {
                    if (acceptedTerms) {
                      // Ação de cadastro
                      print("Cadastro realizado");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Você deve aceitar os termos!')),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: Text(
                "Already Have An Account?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: darkTertiaryBaseColorDark,
                ),
              ),
            ),
            SizedBox(height: 10),
            ActionButton.instantiate(
              viewModel: ActionButtonViewModel(
                size: ActionButtonSize.medium,
                style: ActionButtonStyle.primary,
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
