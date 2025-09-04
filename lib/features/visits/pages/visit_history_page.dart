import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/visits/visit.dart';
import '../bloc/visits_cubit.dart';

class VisitHistoryPage extends StatefulWidget {
  const VisitHistoryPage({
    super.key,
    required this.customerId,
  });
  final String customerId;

  @override
  State<VisitHistoryPage> createState() => _VisitHistoryPageState();
}

class _VisitHistoryPageState extends State<VisitHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<VisitsCubit>().loadVisitHistory(widget.customerId);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Historial de Visitas'),
          actions: [
            IconButton(
              onPressed: () => _startNewVisit(context),
              icon: const Icon(Icons.add),
              tooltip: 'Nueva Visita',
            ),
          ],
        ),
        body: BlocBuilder<VisitsCubit, VisitsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              activeVisit: (visit) => _buildActiveVisitCard(visit),
              completed: (visit) => _buildCompletedVisitCard(visit),
              history: (visits) => _buildVisitsList(visits),
              error: (message) => _buildErrorState(message),
            );
          },
        ),
      );

  Widget _buildActiveVisitCard(Visit visit) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            color: AppPalette.success.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppPalette.success,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Visita Activa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Propósito: ${_getVisitPurposeLabel(visit.purpose)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (visit.startedAt != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Iniciada: ${_formatDateTime(visit.startedAt!)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/visit/forms/${visit.id}'),
                      child: const Text('Continuar Visita'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildVisitsList([]),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedVisitCard(Visit visit) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            color: AppPalette.primary.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppPalette.primary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Última Visita Completada',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Propósito: ${_getVisitPurposeLabel(visit.purpose)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (visit.startedAt != null && visit.finishedAt != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Duración: ${_calculateDuration(visit.startedAt!, visit.finishedAt!)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _startNewVisit(context),
                      child: const Text('Nueva Visita'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildVisitsList([]),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitsList(List<Visit> visits) {
    if (visits.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No hay visitas registradas',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Las visitas aparecerán aquí una vez completadas',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: visits.length,
      itemBuilder: (context, index) {
        final visit = visits[index];
        return VisitCard(
          visit: visit,
          onTap: () => _showVisitDetails(visit),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppPalette.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error al cargar visitas',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                context.read<VisitsCubit>().loadVisitHistory(widget.customerId),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  void _startNewVisit(BuildContext context) {
    context.go('/visit/checkin/${widget.customerId}');
  }

  void _showVisitDetails(Visit visit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalles de la Visita',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                        'Propósito', _getVisitPurposeLabel(visit.purpose)),
                    if (visit.startedAt != null)
                      _buildDetailRow(
                          'Iniciada', _formatDateTime(visit.startedAt!)),
                    if (visit.finishedAt != null)
                      _buildDetailRow(
                          'Finalizada', _formatDateTime(visit.finishedAt!)),
                    if (visit.startedAt != null && visit.finishedAt != null)
                      _buildDetailRow(
                          'Duración',
                          _calculateDuration(
                              visit.startedAt!, visit.finishedAt!)),
                    if (visit.notes != null && visit.notes!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Notas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(visit.notes!),
                    ],
                    if (visit.photos.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Fotos',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('${visit.photos.length} fotos capturadas'),
                    ],
                    if (visit.signature != null) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Firma',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Firma capturada'),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppPalette.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _getVisitPurposeLabel(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return 'Venta';
      case VisitPurpose.cobro:
        return 'Cobro';
      case VisitPurpose.entrega:
        return 'Entrega';
      case VisitPurpose.visita:
        return 'Visita General';
      case VisitPurpose.auditoria:
        return 'Auditoría';
      case VisitPurpose.devolucion:
        return 'Devolución';
      case VisitPurpose.otro:
        return 'Otro';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _calculateDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class VisitCard extends StatelessWidget {
  const VisitCard({
    super.key,
    required this.visit,
    required this.onTap,
  });
  final Visit visit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getPurposeColor(visit.purpose),
            child: Icon(
              _getPurposeIcon(visit.purpose),
              color: Colors.white,
            ),
          ),
          title: Text(
            _getVisitPurposeLabel(visit.purpose),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (visit.startedAt != null)
                Text('Iniciada: ${_formatDateTime(visit.startedAt!)}'),
              if (visit.finishedAt != null)
                Text('Finalizada: ${_formatDateTime(visit.finishedAt!)}'),
              if (visit.notes != null && visit.notes!.isNotEmpty)
                Text(
                  visit.notes!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      );

  Color _getPurposeColor(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return AppPalette.success;
      case VisitPurpose.cobro:
        return AppPalette.warning;
      case VisitPurpose.entrega:
        return AppPalette.info;
      case VisitPurpose.visita:
        return AppPalette.primary;
      case VisitPurpose.auditoria:
        return AppPalette.secondary;
      case VisitPurpose.devolucion:
        return AppPalette.error;
      case VisitPurpose.otro:
        return Colors.grey;
    }
  }

  IconData _getPurposeIcon(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return Icons.shopping_cart;
      case VisitPurpose.cobro:
        return Icons.payment;
      case VisitPurpose.entrega:
        return Icons.local_shipping;
      case VisitPurpose.visita:
        return Icons.person;
      case VisitPurpose.auditoria:
        return Icons.assessment;
      case VisitPurpose.devolucion:
        return Icons.undo;
      case VisitPurpose.otro:
        return Icons.help;
    }
  }

  String _getVisitPurposeLabel(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return 'Venta';
      case VisitPurpose.cobro:
        return 'Cobro';
      case VisitPurpose.entrega:
        return 'Entrega';
      case VisitPurpose.visita:
        return 'Visita General';
      case VisitPurpose.auditoria:
        return 'Auditoría';
      case VisitPurpose.devolucion:
        return 'Devolución';
      case VisitPurpose.otro:
        return 'Otro';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
