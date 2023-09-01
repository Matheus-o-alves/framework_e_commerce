import 'package:get/get.dart';

import '../../ui/pages/login/login.presenter.dart';

import 'package:firebase_auth/firebase_auth.dart';

class GetXLoginPresenter extends GetxController implements LoginPagePresenter {
  @override
  var error = RxnString();
  final _navigateTo = Rx<String?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<String?> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> navigationHomePage() async {
    _navigateTo.value = '/product-list-page';
  }

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      navigationHomePage();
    } catch (e) {
      error.value = 'E-mail ou senha invalidos';
    }
  }

  @override
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      navigationHomePage();
    } catch (e) {
      error.value = 'Erro ao registrar a conta';
    }
  }
}
