import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/account_controller/account_event.dart';
import 'package:delivery_service/controller/account_controller/account_repository.dart';
import 'package:delivery_service/controller/account_controller/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  late StreamSubscription streamSubscription;

  AccountBloc(
    super.initialState, {
    required this.accountRepository,
  }) {
    on<AccountListenEvent>(
      _listenToken,
      transformer: concurrent(),
    );
    on<AccountTokenInfoEvent>(
      _getTokenInfo,
      transformer: concurrent(),
    );
    on<AccountDeleteToken>(
      _deleteToken,
      transformer: concurrent(),
    );

    streamSubscription = accountRepository.listenToken().listen((variations) {
      add(
        AccountListenEvent(
          token: variations.value.toString().isNotEmpty,
        ),
      );
    });
  }

  FutureOr<void> _listenToken(
      AccountListenEvent event, Emitter<AccountState> emit) async {
    emit(
      state.copyWith(
        token: event.token,
      ),
    );
  }

  FutureOr<void> _getTokenInfo(
      AccountTokenInfoEvent event, Emitter<AccountState> emit) async {
    final response = await accountRepository.getTokenInfo();
    emit(
      state.copyWith(
        accountStatus: AccountStatus.loaded,
        token: response,
      ),
    );
  }

  FutureOr<void> _deleteToken(
      AccountDeleteToken event, Emitter<AccountState> emit) async {
    final response = await accountRepository.deleteToken(
        token: event.deleteToken.toString());
    emit(
      state.copyWith(
        token: response,
      ),
    );
  }
}
