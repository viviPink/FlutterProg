import 'package:flutter/material.dart';


class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О разработчике')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🌸Этот супер классный проект разработала простая девочка, живущая самой обычной жизнью🌸',
              style: TextStyle(
                fontSize: 20,
                backgroundColor: Color.fromARGB(255, 235, 154, 181),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Пинчукова Гертруда Павловна', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Группа: ИВТ-22', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Контакты:', style: TextStyle(fontSize: 18)),
            const Text('Email: pinchukova.gera@mail.ru'),
            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}