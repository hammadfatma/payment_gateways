abstract class Failures {
  final String errMessage;

  Failures({required this.errMessage});
}

class ServceFailure extends Failures {
  ServceFailure({required super.errMessage});
}
