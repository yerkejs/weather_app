import './exceptions_base.dart';

class NetworkErrorFailure extends Failure {
  NetworkErrorFailure() : super(
    message: "Please check your network connection"
  );
}

class RequestFailure extends Failure {
  RequestFailure() : super(
    message: "Couldn't get weather details"
  );
}

class FormatFailure extends Failure {
  FormatFailure() : super(
    message: "Couldn't contact with the server"
  );
}

class UndefinedFailure extends Failure { 
  UndefinedFailure () : super (
    message: "Please try later"
  );
}

class CacheFailure extends Failure {
  CacheFailure () : super (
    message: "Please try later"
  );
}