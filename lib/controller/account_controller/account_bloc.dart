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
    /// listen token
    on<AccountListenTokenEvent>(
      _listenToken,
      transformer: concurrent(),
    );

    /// get token
    on<AccountTokenInfoEvent>(
      _getTokenInfo,
      transformer: concurrent(),
    );

    /// delete token
    on<AccountDeleteToken>(
      _deleteToken,
      transformer: concurrent(),
    );

    /// get user info
    on<AccountGetUserInfoEvent>(
      _getUserInfo,
      transformer: concurrent(),
    );

    /// listen name
    on<AccountListenNameEvent>(
      _listenUserName,
      transformer: concurrent(),
    );

    /// listen name
    on<AccountListenSurnameEvent>(
      _listenSurname,
      transformer: concurrent(),
    );

    streamSubscription = accountRepository.listenToken().listen((variations) {
      add(AccountListenTokenEvent(
          token: variations.value.toString().isNotEmpty));
    });
    streamSubscription = accountRepository.listenName().listen((listenName) {
      add(AccountListenNameEvent(name: listenName.value));
    });
    streamSubscription =
        accountRepository.listenSurname().listen((listenSurname) {
      add(AccountListenSurnameEvent(surname: listenSurname.value));
    });
  }

  /// listen name
  FutureOr<void> _listenToken(
      AccountListenTokenEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(token: event.token));
  }

  /// get token
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

  /// delete token
  FutureOr<void> _deleteToken(
      AccountDeleteToken event, Emitter<AccountState> emit) async {
    final hasToken = await accountRepository.deleteToken(
        token: event.deleteToken.toString());
    final userName =
        await accountRepository.deleteName(userName: event.deleteName);
    final userSurname =
        await accountRepository.deleteSurname(userSurname: event.deleteSurname);
    emit(
      state.copyWith(
        token: hasToken,
        userName: userName,
        userSurname: userSurname,
      ),
    );
  }

  /// get user info
  FutureOr<void> _getUserInfo(
      AccountGetUserInfoEvent event, Emitter<AccountState> emit) async {
    final userName = await accountRepository.getUserName();
    final userSurname = await accountRepository.getUserSurname();
    emit(
      state.copyWith(
        userName: userName,
        userSurname: userSurname,
      ),
    );
  }

  /// listen userName
  FutureOr<void> _listenUserName(
      AccountListenNameEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(userName: event.name));
  }

  /// listen surname
  FutureOr<void> _listenSurname(
      AccountListenSurnameEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(userSurname: event.surname));
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
