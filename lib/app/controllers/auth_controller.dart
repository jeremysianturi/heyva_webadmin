import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  late bool _loggedIn;

  // Stream<User?> streamAuthStatus() { return auth.authStateChanges(); }
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  Future<String?> login(String email, String password) async {
    try {
      // final credential = await auth.signInWithEmailAndPassword(
      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // print('logged-in email :: ${auth.currentUser!.email}');
      setLoginStatus(true);
      Get.offAllNamed(Routes.SIGNUP);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Akun email tidak terdaftar !';
      } else if (e.code == 'wrong-password') {
        return 'Salah memasukan kata sandi !';
      }
    }
    return 'Email tidak terdaftar atau salah kata sandi !';
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    setLoginStatus(false);
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<String?> signup(String name, String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await auth.currentUser?.updateDisplayName(name);
      // await auth.currentUser?.updatePhotoURL(".jpg");

      setLoginStatus(true);
      Get.offAllNamed(Routes.SIGNUP);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Kata sandi mudah diterka !';
      } else if (e.code == 'email-already-in-use') {
        return 'Akun email sudah terdaftar !';
      }
    } catch (e) {
      print(e);
      return 'Lakukan ulang pendaftaran !';
    }
    return null;
  }

  void setLoginStatus(bool status) {
    _loggedIn = status;
  }

  bool getLoginStatus() {
    return _loggedIn;
  }

  UserCredential? getCredential() {
    return userCredential;
  }
}