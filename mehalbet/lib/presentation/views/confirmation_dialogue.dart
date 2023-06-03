import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/profile_bloc/bloc/profile_bloc.dart';
import '../../application/profile_bloc/bloc/profile_state.dart';


class ConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state.deleteAccont == ProfileStatus.requestInProgress) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showDialog(context);
          });
        }
        return Container(); // Return an empty container as a placeholder
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final passwordController = TextEditingController();
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final password = passwordController.text;
                // Dispatch an event or perform an action based on the password
                // For example: BlocProvider.of<ProfileBloc>(context).add(PasswordEnteredEvent(password));
                Navigator.of(dialogContext).pop();
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
