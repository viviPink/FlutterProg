import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab7/cubits/weather_state.dart';
import 'package:lab7/screens/calculator_screen.dart';
import '../cubits/weather_cubit.dart';
import '../screens/developer_screen.dart';


class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода на сегодня'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeveloperScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              final cubit = context.read<WeatherCubit>();
              final state = cubit.state;

              if (state is WeatherLoaded && state.currentWeather != null) {
                // Передаем текущую погоду в CalculationsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculationsScreen(
                      initialWeather: state.currentWeather!,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('введите город и начнем расчеты :))')),
                );
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        // получаем погоду 
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'введите город',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        final city = _controller.text;
                        if (city.isNotEmpty) {
                          context.read<WeatherCubit>().getWeather(city);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (state is WeatherLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is WeatherLoaded && state.currentWeather != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Местоположение: ${state.currentWeather!.city}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text('Температура: ${state.currentWeather!.temperature}°F'),
                      Text('Влажность: ${state.currentWeather!.humidity}%'),
                      Text('Описание: ${state.currentWeather!.description}'),
                    ],
                  ),
                

                const SizedBox(height: 16),
                 const Divider(color: Color.fromARGB(255, 100, 16, 44)),
                const Text('История запросов', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: state is WeatherLoaded && state.history.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.history.length,
                          itemBuilder: (context, index) {
                            final data = state.history[index];
                            return ListTile(
                              title: Text('${data.city} :  ${data.description}'),
                              subtitle: Text('${data.temperature}°F  ${data.humidity}%'),
                            );
                          },
                        )
                      : const Text(' '),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}