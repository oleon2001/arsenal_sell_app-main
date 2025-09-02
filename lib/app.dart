import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/customers_repository.dart';
import 'data/repositories/deliveries_repository.dart';
import 'data/repositories/orders_repository.dart';
import 'data/repositories/payments_repository.dart';
import 'data/repositories/tracking_repository.dart';
import 'data/repositories/visits_repository.dart';
import 'features/auth/bloc/auth_cubit.dart';
import 'features/customers/bloc/customers_cubit.dart';
import 'features/deliveries/bloc/deliveries_cubit.dart';
import 'features/map/bloc/map_cubit.dart';
import 'features/orders/bloc/order_cubit.dart';
import 'features/payments/bloc/payments_cubit.dart';
import 'features/supervisor/bloc/supervisor_cubit.dart';
import 'features/visits/bloc/visits_cubit.dart';
import 'routing/app_router.dart';
import 'services/location/location_service.dart';
import 'services/sync/sync_queue.dart';

class ArsenalSellApp extends StatelessWidget {
  const ArsenalSellApp({super.key});

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => AuthRepository()),
          RepositoryProvider(create: (_) => CustomersRepository()),
          RepositoryProvider(create: (_) => VisitsRepository()),
          RepositoryProvider(create: (_) => OrdersRepository()),
          RepositoryProvider(create: (_) => DeliveriesRepository()),
          RepositoryProvider(create: (_) => PaymentsRepository()),
          RepositoryProvider(create: (_) => TrackingRepository()),
          RepositoryProvider(create: (_) => LocationService()),
          RepositoryProvider(create: (_) => SyncQueue()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(
                context.read<AuthRepository>(),
              )..checkAuthStatus(),
            ),
            BlocProvider(
              create: (context) => MapCubit(
                context.read<LocationService>(),
                context.read<TrackingRepository>(),
                context.read<CustomersRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => CustomersCubit(
                context.read<CustomersRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => VisitsCubit(
                context.read<VisitsRepository>(),
                context.read<LocationService>(),
              ),
            ),
            BlocProvider(
              create: (context) => OrderCubit(
                context.read<OrdersRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => DeliveriesCubit(
                context.read<DeliveriesRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => PaymentsCubit(
                context.read<PaymentsRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => SupervisorCubit(
                context.read<TrackingRepository>(),
                context.read<CustomersRepository>(),
                context.read<VisitsRepository>(),
                context.read<OrdersRepository>(),
              ),
            ),
          ],
          child: MaterialApp.router(
            title: 'Arsenal Sell App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
}
