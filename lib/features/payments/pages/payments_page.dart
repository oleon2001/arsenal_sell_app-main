import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/customers/customer.dart';
import '../bloc/payments_cubit.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<PaymentsCubit>().loadPayments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Gestión de Cobros'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Pendientes', icon: Icon(Icons.schedule)),
              Tab(text: 'Completados', icon: Icon(Icons.check_circle)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildPendingPayments(),
            _buildCompletedPayments(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showNewPaymentForm,
          icon: const Icon(Icons.add),
          label: const Text('Nuevo Cobro'),
        ),
      );

  Widget _buildPendingPayments() => BlocBuilder<PaymentsCubit, PaymentsState>(
        builder: (context, state) => state.when(
          initial: () => const Center(child: Text('Cargando...')),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (payments) {
            final pendingPayments =
                payments.where((p) => p.status == 'PENDING').toList();

            if (pendingPayments.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment_outlined,
                      size: 64,
                      color: AppPalette.textSecondary,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No hay cobros pendientes',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pendingPayments.length,
              itemBuilder: (context, index) {
                final payment = pendingPayments[index];
                return PaymentCard(
                  payment: payment,
                  onTap: () => _processPayment(payment),
                );
              },
            );
          },
          pendingLoaded: (pendingPayments) => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pendingPayments.length,
            itemBuilder: (context, index) {
              final payment = pendingPayments[index];
              return PaymentCard(
                payment: payment,
                onTap: () => _processPayment(payment),
              );
            },
          ),
          filtered: (payments, filter) => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return PaymentCard(
                payment: payment,
                onTap: () => _processPayment(payment),
              );
            },
          ),
          searched: (payments, query) => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return PaymentCard(
                payment: payment,
                onTap: () => _processPayment(payment),
              );
            },
          ),
          processing: () => const Center(child: CircularProgressIndicator()),
          paymentRegistered: (payment, message) =>
              const Center(child: Text('Pago registrado')),
          paymentProcessed: (payment, message) =>
              const Center(child: Text('Pago procesado')),
          generatingReport: () =>
              const Center(child: CircularProgressIndicator()),
          reportGenerated: (report) =>
              const Center(child: Text('Reporte generado')),
          error: (message) => Center(child: Text(message)),
        ),
      );

  Widget _buildCompletedPayments() => BlocBuilder<PaymentsCubit, PaymentsState>(
        builder: (context, state) => state.when(
          initial: () => const Center(child: Text('Cargando...')),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (payments) {
            final completedPayments =
                payments.where((p) => p.status == 'COMPLETED').toList();

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: completedPayments.length,
              itemBuilder: (context, index) {
                final payment = completedPayments[index];
                return PaymentCard(
                  payment: payment,
                  onTap: () => _showPaymentDetails(payment),
                );
              },
            );
          },
          pendingLoaded: (pendingPayments) =>
              const Center(child: Text('No hay pagos completados')),
          filtered: (payments, filter) => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return PaymentCard(
                payment: payment,
                onTap: () => _showPaymentDetails(payment),
              );
            },
          ),
          searched: (payments, query) => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return PaymentCard(
                payment: payment,
                onTap: () => _showPaymentDetails(payment),
              );
            },
          ),
          processing: () => const Center(child: CircularProgressIndicator()),
          paymentRegistered: (payment, message) =>
              const Center(child: Text('Pago registrado')),
          paymentProcessed: (payment, message) =>
              const Center(child: Text('Pago procesado')),
          generatingReport: () =>
              const Center(child: CircularProgressIndicator()),
          reportGenerated: (report) =>
              const Center(child: Text('Reporte generado')),
          error: (message) => Center(child: Text(message)),
        ),
      );

  void _showNewPaymentForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const NewPaymentForm(),
    );
  }

  void _processPayment(payment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PaymentProcessForm(payment: payment),
    );
  }

  void _showPaymentDetails(payment) {
    // TODO: Show payment details
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.payment,
    required this.onTap,
  });
  final dynamic payment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Cliente Ejemplo',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '\$2,500.00',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 16,
                      color: AppPalette.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Vence: 15/08/2025',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppPalette.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'PENDIENTE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppPalette.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class NewPaymentForm extends StatefulWidget {
  const NewPaymentForm({super.key});

  @override
  State<NewPaymentForm> createState() => _NewPaymentFormState();
}

class _NewPaymentFormState extends State<NewPaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  Customer? _selectedCustomer;
  String _selectedMethod = 'EFECTIVO';

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Registrar Nuevo Cobro',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),

              // Form fields
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Customer selection
                      DropdownButtonFormField<Customer>(
                        value: _selectedCustomer,
                        decoration: const InputDecoration(
                          labelText: 'Cliente *',
                          border: OutlineInputBorder(),
                        ),
                        items: [], // TODO: Load customers
                        onChanged: (customer) {
                          setState(() {
                            _selectedCustomer = customer;
                          });
                        },
                        validator: (value) {
                          if (value == null) return 'Cliente es requerido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Amount
                      TextFormField(
                        controller: _amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Monto *',
                          prefixText: '\$',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true)
                            return 'Monto es requerido';
                          if (double.tryParse(value!) == null)
                            return 'Monto inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Payment method
                      DropdownButtonFormField<String>(
                        value: _selectedMethod,
                        decoration: const InputDecoration(
                          labelText: 'Método de Pago',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'EFECTIVO', child: Text('Efectivo')),
                          DropdownMenuItem(
                              value: 'TARJETA', child: Text('Tarjeta')),
                          DropdownMenuItem(
                              value: 'TRANSFERENCIA',
                              child: Text('Transferencia')),
                          DropdownMenuItem(
                              value: 'CHEQUE', child: Text('Cheque')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedMethod = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Notes
                      TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Notas',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _savePayment,
                  child: const Text('Registrar Cobro'),
                ),
              ),
            ],
          ),
        ),
      );

  void _savePayment() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Save payment
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cobro registrado exitosamente'),
          backgroundColor: AppPalette.success,
        ),
      );
    }
  }
}

class PaymentProcessForm extends StatefulWidget {
  const PaymentProcessForm({
    super.key,
    required this.payment,
  });
  final dynamic payment;

  @override
  State<PaymentProcessForm> createState() => _PaymentProcessFormState();
}

class _PaymentProcessFormState extends State<PaymentProcessForm> {
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedMethod = 'EFECTIVO';

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Procesar Cobro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),

            // Payment amount
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppPalette.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Monto a cobrar:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$2,500.00',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form fields
            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Monto recibido *',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedMethod,
              decoration: const InputDecoration(
                labelText: 'Método de Pago',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'EFECTIVO', child: Text('Efectivo')),
                DropdownMenuItem(value: 'TARJETA', child: Text('Tarjeta')),
                DropdownMenuItem(
                    value: 'TRANSFERENCIA', child: Text('Transferencia')),
                DropdownMenuItem(value: 'CHEQUE', child: Text('Cheque')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedMethod = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Observaciones',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.success,
                    ),
                    child: const Text('Procesar Cobro'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  void _processPayment() {
    // TODO: Process payment
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cobro procesado exitosamente'),
        backgroundColor: AppPalette.success,
      ),
    );
  }
}
