import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';

Widget buildTextFormField({
  required TextEditingController controller,
  required String labelText,
  required FormFieldValidator<String> validator,
  required IconData prefixIcon,
}) {
  return Material(
    elevation: 4,
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        style: TextStyles.font16BlueRegular,
        controller: controller,
        cursorColor: ColorsManager.mainBlue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Cario',
            color: ColorsManager.mainBlue,
          ),
          prefixIcon: Icon(prefixIcon, color: ColorsManager.mainBlue),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        validator: validator,
      ),
    ),
  );
}

Widget buildTextFormField3Lines({
  required TextEditingController controller,
  required String labelText,
  required FormFieldValidator<String> validator,
  required IconData prefixIcon,
}) {
  return Material(
    elevation: 4,
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        style: TextStyles.font16BlueRegular,
        controller: controller,
        cursorColor: ColorsManager.mainBlue,
        maxLines: 3,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Cario',
            color: ColorsManager.mainBlue,
          ),
          prefixIcon: Icon(prefixIcon, color: ColorsManager.mainBlue),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        validator: validator,
      ),
    ),
  );
}

const List<String> citys = <String>[
  'Select City',
  'Riyadh',
  'Mecca',
  'Medina',
  'Jeddah',
  'Dammam',
  'Khobar',
  'Tabuk',
  'Abha',
  'Taif',
  'Buraidah',
  'Najran',
  'Al Khafji',
  'Jubail',
  'Hail',
  'Yanbu',
  'Al Bahah',
  'Arar',
  'Sakakah',
  'Jizan',
  'Qatif',
  'Al Qunfudhah',
  'Al Kharj',
  'Al Majmaah',
  'Al Zulfi',
  'Al Ula',
  'Al Ahsa',
  'Al Baha',
  'Al Jouf',
  'Al Lith',
  'Al Mubarraz',
  'Al Namas',
  'Al Qunfudhah',
  'Al Wajh',
  'Dawadmi',
  'Duba',
  'Hafar Al Batin',
  'Khafji',
  'Rabigh',
  'Ras Tanura',
  'Safwa',
  'Shaqra',
  'Thadiq',
  'Thuwal',
  'Turaif',
  'Umluj',
  'Wadi ad-Dawasir',
  'Zulfi',
];

class DropdownMenuForm extends StatefulWidget {
  final String selectedValue; // Add this parameter
  final ValueChanged<String> onSelected;

  const DropdownMenuForm({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  State<DropdownMenuForm> createState() => _DropdownMenuFormState();
}

class _DropdownMenuFormState extends State<DropdownMenuForm> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant DropdownMenuForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      setState(() {
        dropdownValue = widget.selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 2.5.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(
          Icons.location_on,
          size: 0,
          color: ColorsManager.mainBlue,
        ),
        iconSize: 24,
        elevation: 16,
        style: TextStyles.font16BlueRegular,
        underline: Container(
          color: Colors.transparent,
        ),
        onChanged: (String? newValue) {
          if (newValue != null && newValue != dropdownValue) {
            setState(() {
              dropdownValue = newValue;
              widget.onSelected(newValue);
            });
          }
        },
        items: citys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            enabled: value != citys.first,
            child: Row(
              children: [
                if (value == dropdownValue)
                  const Icon(
                    Icons.location_on,
                    size: 20,
                    color: ColorsManager.mainBlue,
                  ),
                const SizedBox(width: 8),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cario',
                    fontSize: 16,
                    fontWeight: value == citys.first
                        ? FontWeight.normal
                        : FontWeight.bold,
                    color: value == citys.first
                        ? ColorsManager.blueGray
                        : ColorsManager.mainBlue,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        dropdownColor: Colors.white,
      ),
    );
  }
}
