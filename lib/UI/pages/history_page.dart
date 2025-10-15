// lib/UI/pages/history_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha
import '../../models/movimiento.dart';
import '../../repositorio/history_repository.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Creamos una instancia del repositorio
  final HistoryRepository _repo = HistoryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Movimiento>>(
        // El stream que escuchará los cambios en la colección 'historial'
        stream: _repo.getAllMovements(),
        builder: (context, snapshot) {
          // Estado de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Estado de error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Si no hay datos o la lista está vacía
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay movimientos en el historial.'),
            );
          }

          // Si todo va bien, mostramos la lista
          final movimientos = snapshot.data!;

          return ListView.builder(
            itemCount: movimientos.length,
            itemBuilder: (context, index) {
              final movimiento = movimientos[index];
              final isEntrada = movimiento.tipo == TipoMovimiento.entrada;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  leading: Icon(
                    isEntrada ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isEntrada ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    movimiento.productoNombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    // Formateamos la fecha para que sea más legible
                    DateFormat('dd/MM/yyyy, HH:mm').format(movimiento.fecha),
                  ),
                  trailing: Text(
                    '${isEntrada ? '+' : '-'} ${movimiento.cantidad}',
                    style: TextStyle(
                      color: isEntrada ? Colors.green : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
