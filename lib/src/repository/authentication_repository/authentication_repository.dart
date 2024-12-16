import 'package:bustracking/first_page.dart';
import 'package:bustracking/login_page.dart';
import 'package:bustracking/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:bustracking/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:bustracking/src/repository/authentication_repository/exceptions/sign_up_email_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'exceptions/login_failure.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(()=>WelcomeScreen()):Get.offAll(()=>LoginPage());
  }

  Future<void> createUserWithEmailandPassword(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(()=>FirstPage()):Get.to(()=>WelcomeScreen());

    } on FirebaseAuthException catch(e){
      final ex = SignUpwithEmailAndPasswordFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
      throw ex;
    }catch(_){
      var ex = SignUpwithEmailAndPasswordFailure();
      print('Exception - ${ex.message}');
      throw ex;
    }
  }


  Future<void> loginUserWithEmailandPassword(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(()=>FirstPage()):Get.to(()=>WelcomeScreen());
    } on FirebaseAuthException catch(e){
      final ex = LogInWithEmailAndPasswordFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
    }catch(_) {
      var ex = LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> phoneAuthentication(String phoneNo) async {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
          verificationCompleted: (credential)async{
           await _auth.signInWithCredential(credential);
          },
          codeSent: (verificationId, resendToken){
           this.verificationId.value = verificationId;
          },
          codeAutoRetrievalTimeout: (verificationId)async{
            this.verificationId.value = verificationId;
          },
          verificationFailed: (e){
            if(e.code == "invalid-phone-number"){
              Get.snackbar('Error','Invalid Phone No');
            }else{
              Get.snackbar('Error', 'Something went wrong. Please Try again');
            }
          },
      );
  }

  Future<bool> verifyOTP(String otp) async{
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null ? true:false;
  }

  Future<void> logout() async => await _auth.signOut();

}
