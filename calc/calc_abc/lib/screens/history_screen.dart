import 'package:calc_abc/screens/cubit/data_cubit/history_data_cubit.dart';
import 'package:calc_abc/screens/cubit/data_cubit/history_data_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История расчетов'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Очистка истории'),
                  content: const Text('удалить все?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<HistoryCubit>().clearAllCalculations();
                        Navigator.pop(context);
                      },
                      child: const Text('Очистить'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryError) {
            return Center(child: Text(state.message));
          }

          if (state is HistoryLoaded) {
            final calculations = state.calculations;

            if (calculations.isEmpty) {
              return const Center(child: Text('История пуста'));
            }

            return ListView.builder(
              itemCount: calculations.length,
              itemBuilder: (context, index) {
                final calc = calculations[index];
                return ListTile(
                  title: Text('a=${calc['a']}, b=${calc['b']}, c=${calc['c']}'),
                  subtitle: Text('Корни: ${calc['roots']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<HistoryCubit>().deleteCalculation(calc['id']);
                    },
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Загрузите историю'));
        },
      ),
    );
  }
}