import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "signin";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<String> signUp({String email, String password})async{
    try{
      _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "signup";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
}