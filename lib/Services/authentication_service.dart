import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();
  Future<String> signIn({String email, String password})async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Inicio de sesion exitoso";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  Future<String> signUp({String email, String password})async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      String userId=_firebaseAuth.currentUser.uid;
      users.document(_firebaseAuth.currentUser.uid).setData({
        'email': email,
        'password': password
      });
      return "Registrado";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await FirebaseAuth.instance.signOut();
    print("USUARIO: "+FirebaseAuth.instance.currentUser.toString());
  }
}