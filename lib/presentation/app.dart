import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_flutter/core/services/auth_service.dart';

import 'package:poke_flutter/core/bloc/auth/auth_bloc.dart';
import 'package:poke_flutter/core/bloc/auth/auth_event.dart';
import 'package:poke_flutter/core/bloc/auth/auth_state.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthService())..add(LogoutEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
          AppRouter.router.refresh();
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}