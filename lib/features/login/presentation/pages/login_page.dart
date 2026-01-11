import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/widgets/privacy_policy_link.dart';
import '../../../../injection_container.dart';
import '../../../../features/text_notes/presentation/pages/text_notes_page.dart';
import '../stores/login_store.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore store = sl<LoginStore>();
  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = reaction((_) => store.errorMessage, (String? message) {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
      }
    });

    reaction((_) => store.user, (user) {
      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const TextNotesPage()));
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1D525E), Color(0xFF43767E)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),

                Observer(
                  builder: (_) {
                    return CustomTextField(
                      label: 'Usuário',
                      icon: Icons.person,
                      onChanged: store.setEmail,
                      keyboardType: TextInputType.emailAddress,
                      errorText: store.emailError,
                    );
                  },
                ),
                const SizedBox(height: 20),

                Observer(
                  builder: (_) {
                    return CustomTextField(
                      label: 'Senha',
                      icon: Icons.lock,
                      obscureText: !store.isPasswordVisible,
                      onChanged: store.setPassword,
                      errorText: store.passwordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          store.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey[700],
                        ),
                        onPressed: store.togglePasswordVisibility,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),

                Observer(
                  builder: (_) {
                    return SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: store.isFormValid ? () => store.login() : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: store.isFormValid ? Colors.white : const Color(0xFF386369),
                          disabledBackgroundColor: const Color(0xFF386369).withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          elevation: 0,
                        ),
                        child: store.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                'Entrar',
                                style: TextStyle(
                                  color: store.isFormValid ? Colors.black : Colors.white.withValues(alpha: 0.5),
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const Spacer(),

                const PrivacyPolicyLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
