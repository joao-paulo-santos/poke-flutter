import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_flutter/core/services/pokemon_service.dart';

import 'package:poke_flutter/core/bloc/auth/auth_bloc.dart';
import 'package:poke_flutter/core/bloc/auth/auth_event.dart';
import 'package:poke_flutter/core/bloc/auth/auth_state.dart';
import 'package:poke_flutter/core/bloc/pokemon_list/pokemon_bloc.dart';
import 'package:poke_flutter/presentation/widgets/error_dialog.dart';
import 'package:poke_flutter/presentation/widgets/error_grid_placeholder.dart';
import 'package:poke_flutter/presentation/widgets/loading_indicator.dart';
import 'package:poke_flutter/presentation/widgets/logout_btn.dart';
import 'package:poke_flutter/presentation/widgets/pokemon_grid_item.dart';
import 'package:poke_flutter/presentation/widgets/refresh_fab_btn.dart';
import 'package:poke_flutter/presentation/widgets/username_display.dart';

/// The Pokemon screen
class PokemonTab extends StatefulWidget {
  const PokemonTab({super.key});

  @override
  State<PokemonTab> createState() => _PokemonTabState();
}

class _PokemonTabState extends State<PokemonTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PokemonBloc(PokemonService(Dio()))..add(FetchPokemonsEvent()),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              'Poke Flutter',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 3,
            centerTitle: true,
            leading: UsernameDisplay(
                username: (context.read<AuthBloc>().state as LoggedInAuthState)
                        .credentials
                        .username ??
                    "unknown"),
            leadingWidth: 150,
            actions: [
              LogoutBtn(
                  onTap: () => context.read<AuthBloc>().add(LogoutEvent())),
            ]),
        body: BlocConsumer<PokemonBloc, PokemonState>(
          listener: (context, state) {
            if (state is PokemonErrorState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ErrorDialog(errorMsg: state.error);
                  });
            }
          },
          builder: (context, state) {
            if (state is PokemonErrorState) {
              return const ErrorGridPlaceholder();
            }
            final pokemons = state.pokemons;

            if (state is PokemonLoadedState && pokemons.isEmpty) { //initial state, occurs after an error
              context.read<PokemonBloc>().add(FetchPokemonsEvent());
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: Stack(
                children: [
                  NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.extentAfter == 0) {
                          if (state is! PokemonLoadingState) {
                            context
                                .read<PokemonBloc>()
                                .add(FetchPokemonsEvent());
                          }
                        }
                        return false;
                      },
                      child: pokemons.isEmpty
                          ? const LoadingIndicator()
                          : GridView.builder(
                              padding: const EdgeInsets.all(1),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    (MediaQuery.of(context).size.width / 200)
                                        .round(),
                              ),
                              itemCount: pokemons.length,
                              itemBuilder: (_, index) {
                                return PokemonItem(pokemon: pokemons[index]);
                              },
                            )),
                  if (state is PokemonLoadingState) const LoadingIndicator()
                ],
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            return RefreshFab(
                onPressed: () =>
                    context.read<PokemonBloc>().add(ResetPokemonsEvent()),
                visible: state is PokemonErrorState);
          },
        ),
      ),
    );
  }
}
