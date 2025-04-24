import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nasa_state.dart';
import 'modules/api_modules.dart';


class NasaCubit extends Cubit<NasaState> {
  final NasaApi api;

  NasaCubit({required this.api}) : super(NasaLoadingState());

  void loadData() async {
    emit(NasaLoadingState());
    try {
      //запрос к апи
      final photos = await api.fetchPhotos();
      emit(NasaLoadedState(photos));
    } catch (e) {
      emit(NasaErrorState());
    }
  }
}