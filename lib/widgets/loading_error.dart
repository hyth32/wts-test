import 'package:flutter/material.dart';

class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Something went wrong',
          ),
          const Text(
            'Please try again',
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Try again',
            ),
          )
        ],
      ),
    );
  }

  final VoidCallback onPressed;
}
