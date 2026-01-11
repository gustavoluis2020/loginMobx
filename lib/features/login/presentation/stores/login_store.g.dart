// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  Computed<bool>? _$isEmailValidComputed;

  @override
  bool get isEmailValid => (_$isEmailValidComputed ??= Computed<bool>(
    () => super.isEmailValid,
    name: 'LoginStoreBase.isEmailValid',
  )).value;
  Computed<bool>? _$isPasswordValidComputed;

  @override
  bool get isPasswordValid => (_$isPasswordValidComputed ??= Computed<bool>(
    () => super.isPasswordValid,
    name: 'LoginStoreBase.isPasswordValid',
  )).value;
  Computed<String?>? _$emailErrorComputed;

  @override
  String? get emailError => (_$emailErrorComputed ??= Computed<String?>(
    () => super.emailError,
    name: 'LoginStoreBase.emailError',
  )).value;
  Computed<String?>? _$passwordErrorComputed;

  @override
  String? get passwordError => (_$passwordErrorComputed ??= Computed<String?>(
    () => super.passwordError,
    name: 'LoginStoreBase.passwordError',
  )).value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid => (_$isFormValidComputed ??= Computed<bool>(
    () => super.isFormValid,
    name: 'LoginStoreBase.isFormValid',
  )).value;

  late final _$emailAtom = Atom(name: 'LoginStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom = Atom(
    name: 'LoginStoreBase.password',
    context: context,
  );

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'LoginStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'LoginStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$userAtom = Atom(name: 'LoginStoreBase.user', context: context);

  @override
  UserEntity? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$isPasswordVisibleAtom = Atom(
    name: 'LoginStoreBase.isPasswordVisible',
    context: context,
  );

  @override
  bool get isPasswordVisible {
    _$isPasswordVisibleAtom.reportRead();
    return super.isPasswordVisible;
  }

  @override
  set isPasswordVisible(bool value) {
    _$isPasswordVisibleAtom.reportWrite(value, super.isPasswordVisible, () {
      super.isPasswordVisible = value;
    });
  }

  late final _$loginAsyncAction = AsyncAction(
    'LoginStoreBase.login',
    context: context,
  );

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$LoginStoreBaseActionController = ActionController(
    name: 'LoginStoreBase',
    context: context,
  );

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
      name: 'LoginStoreBase.togglePasswordVisibility',
    );
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
      name: 'LoginStoreBase.setEmail',
    );
    try {
      return super.setEmail(value);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
      name: 'LoginStoreBase.setPassword',
    );
    try {
      return super.setPassword(value);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
user: ${user},
isPasswordVisible: ${isPasswordVisible},
isEmailValid: ${isEmailValid},
isPasswordValid: ${isPasswordValid},
emailError: ${emailError},
passwordError: ${passwordError},
isFormValid: ${isFormValid}
    ''';
  }
}
