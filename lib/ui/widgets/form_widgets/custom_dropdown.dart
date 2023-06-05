
part of 'form_widgets.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    this.options = const [],
    this.value,
    this.onChanged,
    this.isDense = false,
    this.filled = false,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.enabledBorder,
    this.focusedBorder,
    this.contentPadding,
    this.style,
    this.errorText,
    this.errorStyle,
    this.hintText,
    this.hintStyle,
    this.onTap,
  }) : super(key: key);

  final List<CustomDropDownOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool? isDense;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final String? errorText;
  final TextStyle? errorStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: false,
      dropdownColor: MyColors.white,
      borderRadius: BorderRadius.circular(16),
      icon: const Icon(
        Icons.expand_more,
        color: MyColors.lightGray,
      ),
      items: options.map((option) {
        return DropdownMenuItem(
            value: option.value,

            child: Text(
              option.displayOption,
              overflow: TextOverflow.ellipsis,
            ));
      }).toList(),
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: MyColors.lightGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: MyColors.lightGray,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: MyColors.primaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: MyColors.primaryColor),
        ),
        isDense: isDense,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 16),
        errorText: errorText,
        errorStyle: errorStyle,
        hintText: hintText,
        hintStyle: Styles.body14px,
      ),
      style: style ?? Styles.body14px,
      value: value,
      onChanged: onChanged,

    );
  }
}

class CustomDropDownOption<T> {
  final T value;
  final String displayOption;

  const CustomDropDownOption({
    required this.value,
    required this.displayOption,
  });
}
