import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/models/visits/visit.dart';
import '../../../data/models/geo/location_sample.dart';
import '../bloc/map_cubit.dart';
import '../../customers/bloc/customers_cubit.dart';

class LiveMapPage extends StatefulWidget {
  const LiveMapPage({super.key});

  @override
  State<LiveMapPage> createState() => _LiveMapPageState();
}

class _LiveMapPageState extends State<LiveMapPage> {
  GoogleMapController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapCubit>().initializeMap();
      context.read<CustomersCubit>().loadCustomers();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<MapCubit, MapState>(
              listener: (context, state) {
                if (state.runtimeType.toString() == '_Error') {
                  final message = (state as dynamic).message;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: AppPalette.error,
                    ),
                  );
                }
              },
            ),
            BlocListener<CustomersCubit, CustomersState>(
              listener: (context, state) {
                if (state is CustomersLoaded) {
                  // Update map with new customers
                  context.read<MapCubit>().updateCustomers(state.customers);
                }
              },
            ),
          ],
          child: BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              if (state.runtimeType.toString() == '_Initial') {
                return const Center(child: Text('Inicializando...'));
              } else if (state.runtimeType.toString() == '_Loading') {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MapReady) {
                final markers = _buildMarkers(state.currentPosition,
                    state.customers, state.teamLocations);

                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                        context.read<MapCubit>().setMapController(controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: state.currentPosition,
                        zoom: 15.0,
                      ),
                      markers: markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                    ),
                    // Botón flotante para centrar en ubicación actual
                    Positioned(
                      bottom: 100,
                      right: 16,
                      child: FloatingActionButton(
                        heroTag: "centerLocation",
                        onPressed: _centerOnCurrentLocation,
                        backgroundColor: AppPalette.primary,
                        child:
                            const Icon(Icons.my_location, color: Colors.white),
                      ),
                    ),
                    // Botón flotante para refrescar datos
                    Positioned(
                      bottom: 180,
                      right: 16,
                      child: FloatingActionButton(
                        heroTag: "refreshData",
                        onPressed: () {
                          context.read<MapCubit>().initializeMap();
                          context.read<CustomersCubit>().loadCustomers();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Datos actualizados'),
                              backgroundColor: AppPalette.success,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        backgroundColor: AppPalette.secondary,
                        child: const Icon(Icons.refresh, color: Colors.white),
                      ),
                    ),
                  ],
                );
              } else if (state.runtimeType.toString() == '_Error') {
                final message = (state as dynamic).message;
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
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MapCubit>().initializeMap();
                        },
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Estado desconocido'));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "addLocation",
          onPressed: () {
            // TODO: Implementar funcionalidad para agregar ubicación
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Agregar ubicación próximamente'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          backgroundColor: AppPalette.primary,
          child: const Icon(Icons.add_location, color: Colors.white),
        ),
      );

  Set<Marker> _buildMarkers(
    LatLng currentPosition,
    List<Customer> customers,
    List<LocationSample> teamLocations,
  ) {
    final markers = <Marker>{};

    // Marcador de ubicación actual
    markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: currentPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'Mi Ubicación',
          snippet: 'Ubicación actual',
        ),
      ),
    );

    // Marcadores de clientes
    for (final customer in customers) {
      if (customer.latitude != null && customer.longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId('customer_${customer.id}'),
            position: LatLng(customer.latitude!, customer.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
              title: customer.name,
              snippet: customer.address ?? 'Sin dirección',
              onTap: () {
                _showCustomerDetails(customer);
              },
            ),
          ),
        );
      }
    }

    // Marcadores del equipo (para supervisores)
    for (final location in teamLocations) {
      markers.add(
        Marker(
          markerId: MarkerId('team_${location.userId}'),
          position: LatLng(location.latitude, location.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(
            title: 'Miembro del Equipo',
            snippet: 'Última ubicación: ${_formatTime(location.at)}',
          ),
        ),
      );
    }

    return markers;
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Ahora';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours} h';
    } else {
      return 'Hace ${difference.inDays} días';
    }
  }

  void _centerOnCurrentLocation() {
    final state = context.read<MapCubit>().state;
    if (state is MapReady && _controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLng(state.currentPosition),
      );
    }
  }

  void _showCustomerDetails(Customer customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
                      customer.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (customer.code != null) ...[
                      Text(
                        'Código: ${customer.code}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppPalette.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (customer.address != null) ...[
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: AppPalette.primary),
                          SizedBox(width: 8),
                          Text(
                            'Dirección',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer.address!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (customer.phone != null) ...[
                      const Row(
                        children: [
                          Icon(Icons.phone, color: AppPalette.primary),
                          SizedBox(width: 8),
                          Text(
                            'Teléfono',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer.phone!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (customer.email != null) ...[
                      const Row(
                        children: [
                          Icon(Icons.email, color: AppPalette.primary),
                          SizedBox(width: 8),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer.email!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                    ],
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              context.go('/customers/${customer.id}');
                            },
                            icon: const Icon(Icons.visibility),
                            label: const Text('Ver Detalles'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPalette.primary,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              context.go('/visit/checkin/${customer.id}');
                            },
                            icon: const Icon(Icons.location_on),
                            label: const Text('Visitar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPalette.success,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
