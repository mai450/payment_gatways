import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payment/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap1,
    required this.text,
    this.isLoading = false,
    this.selectedButton,
    this.onTap2,
  });

  final Function(int)? onTap2;
  final void Function()? onTap1;
  final String text;
  final bool isLoading;
  final int? selectedButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap2 != null && selectedButton != null) {
          // Call onTap2 with the selectedButton value if provided
          onTap2!(selectedButton!);
        } else if (onTap1 != null) {
          // Call onTap1 if onTap2 is not provided
          onTap1!();
        } else {
          // Optional: Handle the case where no onTap is provided
          print("No action defined for this button.");
        }
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: ShapeDecoration(
          color: const Color(0xFF34A853),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Styles.style22,
                ),
        ),
      ),
    );
  }
}
