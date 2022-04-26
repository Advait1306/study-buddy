import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:study_buddy/widgets/app.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //User hasn't logged in
          if (!snapshot.hasData) {
            return SignInScreen(
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to StudyBuddy! Please sign in to continue.'
                        : 'Welcome to StudyBuddy! Please create an account to continue',
                  ),
                );
              },
              providerConfigs: const [EmailProviderConfiguration()],
            );
          }

          return App();
        });
  }
}
