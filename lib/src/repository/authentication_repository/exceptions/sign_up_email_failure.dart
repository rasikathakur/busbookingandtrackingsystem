
class SignUpwithEmailAndPasswordFailure{
  final String message;

  SignUpwithEmailAndPasswordFailure([this.message="An unknown error occured"]);

  factory SignUpwithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return SignUpwithEmailAndPasswordFailure('Please enter a strong password');
      case 'invalid-email':
        return SignUpwithEmailAndPasswordFailure('Email is not valid or badly formatted');
      case 'email-already-in-use':
        return SignUpwithEmailAndPasswordFailure('An account already exists for that email');
      case 'operation-not-allowed':
        return SignUpwithEmailAndPasswordFailure('Operation is not allowed. Please contact support for help');
      case 'user-disabled':
        return SignUpwithEmailAndPasswordFailure('This user is disabled. Please contact support for help');
      default:
        return SignUpwithEmailAndPasswordFailure();
    }
  }
}