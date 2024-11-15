import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:poke_flutter/core/bloc/auth/auth_bloc.dart';
import 'package:poke_flutter/core/bloc/auth/auth_state.dart';

import 'package:poke_flutter/presentation/screens/pokemon_screen.dart';
import 'package:poke_flutter/presentation/screens/login_screen.dart';

/// The route configuration.
abstract class AppRouter{
  static GoRouter router = GoRouter(
    redirect: _guard,
    initialLocation: "/login",
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const PokemonTab();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
    ],
  );

  static String? _guard(BuildContext context, GoRouterState state){
    final bool loggingIn = state.matchedLocation == '/login';

    if (context.read<AuthBloc>().state is !LoggedInAuthState){
      return '/login';
    }

    //if already logged and still in login page
    if(loggingIn){
      return "/";
    }
    return null;
  }
}
