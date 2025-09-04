import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/customers/customer.dart';
import '../bloc/customers_cubit.dart';

class CustomersListPage extends StatefulWidget {
  const CustomersListPage({super.key});

  @override
  State<CustomersListPage> createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<CustomersListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CustomersCubit>().loadCustomers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Clientes'),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              tooltip: 'Sincronizar clientes',
              onPressed: () => context.read<CustomersCubit>().syncCustomers(),
            ),
          ],
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Buscar clientes...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  context.read<CustomersCubit>().searchCustomers(value);
                },
              ),
            ),

            // Customer list
            Expanded(
              child: BlocBuilder<CustomersCubit, CustomersState>(
                builder: (context, state) {
                  if (state.runtimeType.toString() == '_Initial') {
                    return const Center(child: Text('Cargando clientes...'));
                  } else if (state.runtimeType.toString() == '_Loading') {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CustomersLoaded) {
                    final customers = state.customers;
                    if (customers.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: AppPalette.textSecondary,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No hay clientes',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppPalette.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<CustomersCubit>().syncCustomers(),
                      child: ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          return CustomerListTile(
                            customer: customer,
                            onTap: () =>
                                context.push('/customers/${customer.id}'),
                          );
                        },
                      ),
                    );
                  } else if (state.runtimeType.toString() == '_Error') {
                    final message = (state as dynamic).message;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
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
                            onPressed: () =>
                                context.read<CustomersCubit>().loadCustomers(),
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/customers/new'),
          child: const Icon(Icons.add),
        ),
      );
}

class CustomerListTile extends StatelessWidget {
  const CustomerListTile({
    super.key,
    required this.customer,
    required this.onTap,
  });
  final Customer customer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppPalette.primary,
            child: Text(
              customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            customer.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (customer.code != null) ...[
                Text('Código: ${customer.code}'),
                const SizedBox(height: 2),
              ],
              if (customer.address != null) ...[
                Text(
                  customer.address!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                customer.latitude != null && customer.longitude != null
                    ? Icons.location_on
                    : Icons.location_off,
                color: customer.latitude != null && customer.longitude != null
                    ? AppPalette.success
                    : AppPalette.textDisabled,
              ),
              const SizedBox(height: 4),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: onTap,
        ),
      );
}
