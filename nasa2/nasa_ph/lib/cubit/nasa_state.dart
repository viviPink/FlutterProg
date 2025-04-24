import 'models/photos_models.dart';

abstract class NasaState {}

class NasaLoadingState extends NasaState {}

class NasaLoadedState extends NasaState {
  final List<Photo> photos;

  NasaLoadedState(this.photos);
}

class NasaErrorState extends NasaState {}
