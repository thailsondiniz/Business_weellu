import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/autentication_user.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_main/business_home_page.dart';
import 'package:flutter_project_business/pages/business_product_widgets/profile_user.dart';
import 'package:flutter_project_business/profile/profile_user_store.dart';
import 'package:flutter_project_business/route/api_route.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final TextEditingController _user = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // bool isVisible = true;

  functionAutentication() {
    AutenticationUser().verificarUsuario(ApiRota.baseApi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Username',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: 420,
                    child: TextFormField(
                      controller: _user,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira um usuario valido*';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      // obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: ColorsAppGeneral
                                  .borderChannelNotificationColor,
                              width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        filled: true,
                        fillColor: ColorsAppGeneral.channelNotificationColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: ColorsAppGeneral
                                  .borderChannelNotificationColor,
                              width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Username',
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            color: ColorsAppGeneral.descriptionColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: ColorsAppGeneral
                                    .borderChannelNotificationColor,
                                width: 1)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsAppGeneral.mainColor,
                            padding: EdgeInsets.zero,
                            shape: const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            side: const BorderSide(
                              color: ColorsAppGeneral.mainColor,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final dadosUser = _user.text;
                              final resultado = await AutenticationUser()
                                  .verificarUsuario(dadosUser);

                              if (resultado['autenticado']) {
                                final String userId = resultado['userId'] ?? '';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileUserStore(
                                            dadosUser: dadosUser,
                                            userId: userId, //
                                          )),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Nome de usuário inválido')),
                                );
                              }
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// final TextEditingController _password = TextEditingController();
// const Text(
//   'Password',
//   style: TextStyle(color: Colors.white, fontSize: 16),
// ),
// const SizedBox(
//   height: 3,
// ),
// SizedBox(
//   width: 420,
//   child: TextFormField(
//     obscureText: isVisible,
//     controller: _password,
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Por Favor insira uma senha valida*';
//       }
//       return null;
//     },
//     style: const TextStyle(color: Colors.white),
//     // obscureText: true,
//     decoration: InputDecoration(
//       suffixIcon: IconButton(
//         onPressed: () {
//           setState(() {
//             isVisible = !isVisible;
//           });
//         },
//         icon: isVisible == true
//             ? const Icon(Icons.visibility_off_outlined)
//             : const Icon(Icons.visibility_outlined),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//             color: ColorsAppGeneral
//                 .borderChannelNotificationColor,
//             width: 1.0),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       filled: true,
//       fillColor: ColorsAppGeneral.channelNotificationColor,
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//             color: ColorsAppGeneral
//                 .borderChannelNotificationColor,
//             width: 1.0),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       hintText: 'Password',
//       contentPadding:
//           const EdgeInsets.only(left: 15, right: 15),
//       hintStyle: const TextStyle(
//           fontSize: 14,
//           color: ColorsAppGeneral.descriptionColor),
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: const BorderSide(
//               color: ColorsAppGeneral
//                   .borderChannelNotificationColor,
//               width: 1)),
//     ),
//   ),
// ),
