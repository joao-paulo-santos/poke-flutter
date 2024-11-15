// This is an example Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
//
// Visit https://flutter.dev/to/widget-testing for
// more information about Widget testing.


import 'package:mocktail/mocktail.dart';
import 'package:poke_flutter/core/bloc/auth/auth_bloc.dart';
import 'package:poke_flutter/core/bloc/pokemon_list/pokemon_bloc.dart';

class MockAuthBloc extends Mock implements AuthBloc {}
class MockPokemonBloc extends Mock implements PokemonBloc {}

 void main() {
//   testWidgets('PokemonScreen displays loading indicator when loading', (tester) async {
//     final mockBloc = MockPokemonBloc();
//     final mockAuthBloc = MockAuthBloc();
//     when(() => mockAuthBloc.stream).thenAnswer((_) {
//       return Stream.fromIterable([LoggedInAuthState(UserCredentials(token: "token", username: "Luis"))]);
//     });
//     when(() => mockBloc.stream).thenAnswer((_) {
//       return Stream.fromIterable([PokemonLoadingState(List<PokemonModel>.empty())]);
//     });

//     await tester.pumpWidget(
//       MaterialApp(
//         home: MultiBlocProvider(
//           providers: [
//             BlocProvider<MockAuthBloc>(
//               create: (context) => mockAuthBloc,
//             ),
//             BlocProvider<MockPokemonBloc>(
//               create: (context) => mockBloc,
//             ),
//           ],
//           child: const PokemonTab(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     expect(find.byType(LoadingIndicator), findsOneWidget);
//   });

}