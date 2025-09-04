import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/visits/visit.dart';
import '../bloc/visits_cubit.dart';

class VisitFormsPage extends StatefulWidget {
  const VisitFormsPage({
    super.key,
    required this.visitId,
  });
  final String visitId;

  @override
  State<VisitFormsPage> createState() => _VisitFormsPageState();
}

class _VisitFormsPageState extends State<VisitFormsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _notesController = TextEditingController();
  final _observationsController = TextEditingController();
  final List<String> _photos = [];
  String? _signature;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Agregar listeners para actualizar la UI cuando cambien los campos
    _notesController.addListener(_updateUI);
    _observationsController.addListener(_updateUI);
  }

  void _updateUI() {
    setState(() {
      // Actualizar la UI para reflejar cambios en los campos
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notesController.removeListener(_updateUI);
    _observationsController.removeListener(_updateUI);
    _notesController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Formularios de Visita'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.note,
                  color: _notesController.text.isNotEmpty ||
                          _observationsController.text.isNotEmpty
                      ? Colors.green
                      : null,
                ),
                text: 'Notas',
              ),
              Tab(
                icon: Icon(
                  Icons.photo_camera,
                  color: _photos.isNotEmpty ? Colors.green : Colors.red,
                ),
                text: 'Fotos',
              ),
              Tab(
                icon: Icon(
                  Icons.draw,
                  color: _signature != null ? Colors.green : Colors.red,
                ),
                text: 'Firma',
              ),
            ],
          ),
        ),
        body: BlocBuilder<VisitsCubit, VisitsState>(
          builder: (context, state) {
            if (state is! VisitsActiveVisit) {
              return const Center(
                child: Text('No hay visita activa'),
              );
            }

            final visit = state.visit;

            return TabBarView(
              controller: _tabController,
              children: [
                _buildNotesTab(visit),
                _buildPhotosTab(visit),
                _buildSignatureTab(visit),
              ],
            );
          },
        ),
        floatingActionButton: BlocBuilder<VisitsCubit, VisitsState>(
          builder: (context, state) {
            if (state is! VisitsActiveVisit) {
              return const SizedBox.shrink();
            }

            return FloatingActionButton.extended(
              onPressed: () => _finishVisit(context),
              label: const Text('Finalizar Visita'),
              icon: const Icon(Icons.check),
              backgroundColor: AppPalette.success,
            );
          },
        ),
      );

  Widget _buildNotesTab(Visit visit) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    visit.customer?.name ?? 'Cliente',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Propósito: ${_getVisitPurposeLabel(visit.purpose)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppPalette.textSecondary,
                    ),
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Notes section
          const Text(
            'Notas de la Visita',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _notesController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Agregar notas sobre la visita...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Observations section
          const Text(
            'Observaciones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _observationsController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Observaciones adicionales...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosTab(Visit visit) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fotos de la Visita',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: visit.photos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_camera_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay fotos tomadas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Toca el botón + para agregar fotos',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: visit.photos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            // TODO: Implement photo display
                            Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: IconButton(
                                onPressed: () => _removePhoto(index),
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(Icons.add_a_photo),
              label: const Text('Tomar Foto'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureTab(Visit visit) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Firma del Cliente',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: visit.signature == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.draw_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay firma capturada',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Toca el botón para capturar la firma',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : Card(
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[100],
                      child: const Center(
                        child: Icon(
                          Icons.draw,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _captureSignature,
              icon: const Icon(Icons.draw),
              label: const Text('Capturar Firma'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.secondary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _finishVisit(BuildContext context) {
    // Validar que haya al menos una foto
    if (_photos.isEmpty) {
      _showValidationError(
        context,
        'Foto Requerida',
        'Debe capturar al menos una foto antes de finalizar la visita.',
        () => _tabController.animateTo(1), // Ir a pestaña de fotos
      );
      return;
    }

    // Validar que haya una firma
    if (_signature == null) {
      _showValidationError(
        context,
        'Firma Requerida',
        'Debe capturar la firma del cliente antes de finalizar la visita.',
        () => _tabController.animateTo(2), // Ir a pestaña de firma
      );
      return;
    }

    final notes = _notesController.text.isNotEmpty
        ? _notesController.text
        : _observationsController.text.isNotEmpty
            ? _observationsController.text
            : null;

    context.read<VisitsCubit>().finishVisit(
          visitId: widget.visitId,
          notes: notes,
        );

    // Navigate back to customer details or dashboard
    context.go('/dashboard');
  }

  void _showValidationError(
    BuildContext context,
    String title,
    String message,
    VoidCallback onGoToTab,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning, color: Colors.orange),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onGoToTab();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ir a la Pestaña'),
          ),
        ],
      ),
    );
  }

  void _takePhoto() {
    // TODO: Implement photo capture
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de fotos próximamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _removePhoto(int index) {
    // TODO: Implement photo removal
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de eliminación próximamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _captureSignature() {
    // TODO: Implement signature capture
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de firma próximamente'),
        duration: Duration(seconds: 2),
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
}
