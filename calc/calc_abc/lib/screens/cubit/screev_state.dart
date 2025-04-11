abstract class RootsState {}

class InitialRootsState extends RootsState {}

class RootsCalculatedState extends RootsState {
  final double a;
  final double b;
  final double c;
  final List<String> roots;

  RootsCalculatedState({
    required this.a,
    required this.b,
    required this.c,
    required this.roots,
  });
}

class RootsErrorState extends RootsState {
  final String errorMessage;

  RootsErrorState({required this.errorMessage});
}