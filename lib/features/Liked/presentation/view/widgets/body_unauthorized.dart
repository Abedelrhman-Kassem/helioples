import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';

Widget bodyUnAuthorized(BuildContext context) {
  return Center(
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, signInScreen);
      },
      child: const Text('You must Login First'),
    ),
  );
}
