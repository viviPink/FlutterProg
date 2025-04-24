import 'package:flutter/material.dart';
import '../models/photos_models.dart';

//виджет для отображения фото с доп информацией
class AddPhotoScreen extends StatelessWidget {
  final Photo photo;

  const AddPhotoScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('фото больше'),
      ),
      // прокрутки содержимого, которое не помещается на экране
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              photo.imgSrc,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Camera: ${photo.camera.fullName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Earth Date: ${photo.earthDate}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rover: ${photo.rover.name}',
                    style: TextStyle(fontSize: 16),
                  ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}