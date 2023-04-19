import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(), minimumSize: Size.fromHeight(50)),
        child: Text(
          text,
        ),
        onPressed: onTap,
      ),
    );
  }
}
