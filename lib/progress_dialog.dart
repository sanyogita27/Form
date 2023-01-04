import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String? message;
  ProgressDialog({super.key, this.message});
  ValueNotifier<bool> isloading = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                message!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
