import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nasa_state.dart';
import 'cubit/nasa_cubit.dart';
import 'screens/addition_photo_screen.dart';

class MarsRoverPhotosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('марсоход-путешественник'),
      ),
      //Подписывается на изменения состояния NasaCubit и обновляет UI в зависимости от текущего состояния.
      body: BlocBuilder<NasaCubit, NasaState>(
        builder: (context, state) {
          if (state is NasaLoadingState) {
            context.read<NasaCubit>().loadData();
            // индикатор загрузки
            return Center(child: CircularProgressIndicator());
          } else if (state is NasaLoadedState) {
            return ListView.builder(
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final photo = state.photos[index];
               // title : Отображает название камеры (photo.camera.fullName).
              // subtitle : Отображает дату съемки на Земле (photo.earthDate).
              //leading : Отображает изображения с помощью Image.network.
                return ListTile(
                  title: Text(photo.camera.fullName),
                  subtitle: Text(photo.earthDate),
                  leading: Image.network(
                    photo.imgSrc,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                 // onTap : При нажатии на элемент открывается новый экран (AddPhotoScreen) с деталями выбранной фотографи
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPhotoScreen(photo: photo),
                      ),
                    );
                  },
                );
              },
            );
            //ловим ошибочки
          } else if (state is NasaErrorState) {
            return Center(child: Text('Ошибка загрузки данных'));
          }
          return Container();
        },
      ),
    );
  }
}