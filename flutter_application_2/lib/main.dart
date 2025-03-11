import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageListScreen(),
    );
  }
}

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({Key? key}) : super(key: key);

  // Метод для создания одного контейнера
  Widget _buildImageContainer(String imagePath) {
    return Padding( //отступы
      padding: const EdgeInsets.all(8.0), //везде 8 пикселей
      child: Container(
        width: 250,//double.infinity - все пространство
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath), // Путь к изображению (в yaml еще потыкать)
            fit: BoxFit.cover,//обрезается если не влазит
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200], // фон если ничего нет
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: Text(
    'Пинчукова Гертруда ИВТ-22',
    style: TextStyle(color: Colors.white), 
  ),
  backgroundColor: const Color.fromARGB(255, 212, 155, 82), 
),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageContainer('assets/image1.png'),
            _buildImageContainer('assets/image2.png'),
            _buildImageContainer('assets/image1.png'),
            _buildImageContainer('assets/image2.png'),
            _buildImageContainer('assets/image1.png'),
            
          ],
        ),
      ),
    );
  }
}