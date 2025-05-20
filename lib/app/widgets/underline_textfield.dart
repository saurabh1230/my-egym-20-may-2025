// import 'package:flutter/material.dart';

// class UnderlineTextfield extends StatelessWidget {
//   final String label;
//   final String hint;
//   final TextEditingController controller;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final int? maxLines;
//   final int? maxLength; // <- Added maxLength
//   final bool showSuffixIcon;
//   final IconData? suffixIcon;
//   final VoidCallback? onTap;
//   final bool readOnly;
//   final TextCapitalization capitalization;
//   final FormFieldValidator<String>? validation;
//   final Function? onChanged;
//   final Function? onSubmit;

//   const UnderlineTextfield({
//     super.key,
//     required this.label,
//     required this.hint,
//     required this.controller,
//     this.keyboardType,
//     this.obscureText = false,
//     this.maxLines = 1,
//     this.maxLength, // <- Added maxLength to constructor
//     this.showSuffixIcon = false,
//     this.suffixIcon,
//     this.onTap,
//     this.readOnly = false,
//     this.validation,
//     this.onSubmit,
//     this.onChanged,
//     this.capitalization = TextCapitalization.none,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12.0,
//             color: Colors.grey[600],
//           ),
//         ),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           obscureText: obscureText,
//           validator: validation,
//           maxLines: maxLines,
//           maxLength: maxLength, // <- Conditionally set
//           readOnly: readOnly,
//           onTap: onTap,
//           onChanged: onChanged as void Function(String)?,
//           textCapitalization: capitalization,
//           decoration: InputDecoration(
//             hintText: hint,
//             border: UnderlineInputBorder(),
//             suffixIcon: showSuffixIcon
//                 ? (onTap != null
//                     ? InkWell(
//                         onTap: onTap,
//                         child: Icon(suffixIcon, color: Colors.black),
//                       )
//                     : Icon(suffixIcon, color: Colors.black))
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class UnderlineTextfield extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final bool showSuffixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextCapitalization capitalization;
  final FormFieldValidator<String>? validation;
  final Function? onChanged;
  final Function? onSubmit;

  const UnderlineTextfield({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.showSuffixIcon = false,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.validation,
    this.onSubmit,
    this.onChanged,
    this.capitalization = TextCapitalization.none,
  });

  @override
  _UnderlineTextfieldState createState() => _UnderlineTextfieldState();
}

class _UnderlineTextfieldState extends State<UnderlineTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText; // Set initial state for obscure text
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey[600],
          ),
        ),
        TextFormField(

          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          validator: widget.validation,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged as void Function(String)?,
          textCapitalization: widget.capitalization,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: UnderlineInputBorder(),
            suffixIcon: widget.showSuffixIcon
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
