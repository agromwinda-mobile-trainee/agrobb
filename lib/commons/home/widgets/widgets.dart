import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';

Decoration bottomSheetDecoration(context) {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 50,
        spreadRadius: 2,
      ),
    ],
    color: Colors.white,
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );
}

Widget waittingAnimationWidget(context) {
  return SizedBox(
    height: 100,
    width: 100,
    child: SpinKitSpinningLines(
      color: Colors.grey.shade200,
      duration: const Duration(seconds: 5),
      lineWidth: 3,
      size: 200.0,
      itemCount: 2,
      // controller: _controller,
    ),
  );
}

Widget destinationFormWidgetHead(context,
    {required String title, required Function onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 22),
    child: Row(
      children: [
        InkWell(
          onTap: () => onTap(),
          splashColor: Colors.grey.shade400,
          focusColor: Colors.grey.shade400,
          hoverColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade400,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              IconlyLight.arrow_left,
              color: Colors.black,
              size: 22,
              semanticLabel: "Retour",
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
        ),
      ],
    ),
  );
}
