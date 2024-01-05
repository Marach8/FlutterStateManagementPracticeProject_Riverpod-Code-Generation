import 'package:instagram_clone_app/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'userid_provider.g.dart';

@riverpod
UserId? userId(UserIdRef ref) => ref.watch(authStateProvider).id;