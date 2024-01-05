import 'package:instagram_clone_app/auth_results.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isloggedin_provider.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref){
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
}