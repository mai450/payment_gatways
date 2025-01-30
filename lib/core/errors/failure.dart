class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class ServerError extends Failure {
  ServerError({required super.errMessage});
}
