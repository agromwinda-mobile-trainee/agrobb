<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/input_form_fields.dart
import 'package:agrobeba/customer-app/screens/widgets/destination/buildbottomsheet.dart';
=======
import 'package:agrobeba/widgets/destination/buildbottomsheet.dart';
>>>>>>> origin/Driver:lib/widgets/destination/input_form_fields.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/destination_cubit.dart';

class InputFormFields extends StatefulWidget {
  const InputFormFields(
      {super.key,
      required this.stateField,
      required this.initialValue,
      required this.label,
      this.hint,
      this.prefixIcon,
      required this.textController});

  final String stateField;
  final String initialValue;
  final String label;
  final String? hint;
  final Widget? prefixIcon;
  final TextEditingController textController;

  @override
  State<InputFormFields> createState() => _InputFormFieldsState();
}

class _InputFormFieldsState extends State<InputFormFields> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationCubit, DestinationState>(
        builder: (context, state) {
      return Ink(
        child: TextFormField(
          controller: widget.textController,
          onChanged: (String? value) {
            print("on change... ${widget.stateField}");
            BlocProvider.of<DestinationCubit>(context).onChangeField(
                field: "emplacementField", value: widget.stateField);
            if (value!.length > 2) {
              BlocProvider.of<DestinationCubit>(context)
                  .getPlaces(value: value);
            }
          },
          style: Theme.of(context).textTheme.bodyMedium,
          // initialValue: BlocProvider.of<DestinationCubit>(context, listen: true)
          //     .state
          //     .destination!["emplacementForm"][widget.initialValue],

          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.transparent,
            filled: false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 2),
            labelText: widget.label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 50, maxWidth: 30),
            prefixIcon: Row(
              children: [
                widget.prefixIcon ?? prefixIconStartPoint(context),
                const SizedBox(width: 4),
              ],
            ),
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black26,
                ),
          ),
        ),
      );
    });
  }
}
