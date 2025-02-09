import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Bem-vindo ao Corre Aqui! Por favor, faça seu login':
              'Welcome to Corre Aqui! Please sign in',
          'Bem-vindo ao Corre Aqui! Por favor, faça seu registro':
              'Welcome to Corre Aqui! Please register',
          'Ao se inscrever, você concorda com os nossos termos e condições.':
              'By signing up, you agree to our terms and conditions.',
        },
        'pt_BR': {
          'Bem-vindo ao Corre Aqui! Por favor, faça seu login':
              'Bem-vindo ao Corre Aqui! Por favor, faça seu login',
          'Bem-vindo ao Corre Aqui! Por favor, faça seu registro':
              'Bem-vindo ao Corre Aqui! Por favor, faça seu registro',
          'Ao se inscrever, você concorda com os nossos termos e condições.':
              'Ao se inscrever, você concorda com os nossos termos e condições.',
        },
      };
}
