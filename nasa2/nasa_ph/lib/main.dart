import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nasa_cubit.dart';
import 'modules/api_modules.dart';
import 'screens/mars_rover_photos_screen.dart';



// если фото не грузятся из-за корс, то нужно:
//1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
//2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
//3- Find '--disable-extensions'
//4- Add '--disable-web-security'
// если ничего не работет, то 
//ударить ноутбук 4 раза, сказать ему что он плохой, закрыть вс код и снова включить 
//поздравляю! все работает <3 


//CORS (Cross-Origin Resource Sharing, или "общий доступ к ресурсам между разными источниками") — 
//это механизм безопасности браузера, который ограничивает, как веб-страницы могут делать запросы
// к другим доменам (или "источникам"). Этот механизм предотвращает выполнение небезопасных запросов 
//из одного источника к другому.


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //BlocProvider создает экземпляр NasaCubit и передает ему объект NasaApi
      //Этот экземпляр становится доступным для всех дочерних виджетов через контекст (context).
      home: BlocProvider(
        create: (context) => NasaCubit(api: NasaApi()),
        child: MarsRoverPhotosScreen(),
      ),
    );
  }
}
