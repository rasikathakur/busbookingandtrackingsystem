
class LogInWithEmailAndPasswordFailure{
  final String message;

  LogInWithEmailAndPasswordFailure([this.message="An unknown error occured"]);

  factory LogInWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return LogInWithEmailAndPasswordFailure('Please enter a strong password');
      case 'invalid-email':
        return LogInWithEmailAndPasswordFailure('Email is not valid or badly formatted');
      case 'email-already-in-use':
        return LogInWithEmailAndPasswordFailure('An account already exists for that email');
      case 'operation-not-allowed':
        return LogInWithEmailAndPasswordFailure('Operation is not allowed. Please contact support for help');
      case 'user-disabled':
        return LogInWithEmailAndPasswordFailure('This user is disabled. Please contact support for help');
      default:
        return LogInWithEmailAndPasswordFailure();
    }
  }
}