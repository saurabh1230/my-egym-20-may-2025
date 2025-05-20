import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/underline_textfield.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class AddNewMemberBottomSheet extends StatelessWidget {
  final TextEditingController memberNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxString experience = '01'.obs;
  final TextEditingController amountController =
      TextEditingController(text: '₹ 20000');
  final TextEditingController joiningDateController =
      TextEditingController(text: '10-01-2025');
  final TextEditingController addressController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController(text: '');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  AddNewMemberBottomSheet({super.key});

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      joiningDateController.text =
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius10),
                topRight: Radius.circular(Dimensions.radius10))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New Member',
                  style: notoSansSemiBold.copyWith(
                      color: Theme.of(context).primaryColor)),
              sizedBox10(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: UnderlineTextfield(
                              label: 'Member Name',
                              hint: 'Member Full Name',
                              controller: memberNameController,
                              showSuffixIcon: false,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: UnderlineTextfield(
                              label: 'Date of Birth',
                              hint: 'D.O.B',
                              controller: dobController,
                              showSuffixIcon: false,
                            ),
                          ),
                        ],
                      ),
                      sizedBoxDefault(),
                      Row(
                        children: [
                          Expanded(
                            child: UnderlineTextfield(
                              label: 'Phone Number',
                              hint: 'Write address here...',
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              showSuffixIcon: false,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: UnderlineTextfield(
                              label: 'Email Address',
                              hint: 'Email Address',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              showSuffixIcon: false,
                            ),
                          ),
                        ],
                      ),
                      sizedBoxDefault(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Years of Experience',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Obx(
                                  () => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                    ),
                                    value: experience.value,
                                    items: <String>[
                                      '01',
                                      '02',
                                      '03',
                                      '04',
                                      '05'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        experience.value = newValue;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: UnderlineTextfield(
                              label: 'Amount Paid',
                              hint: '₹ 20000',
                              controller: amountController,
                              showSuffixIcon: false,
                            ),
                          ),
                        ],
                      ),
                      sizedBoxDefault(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          Obx(
                            () => DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                              value: experience.value,
                              items: <String>[
                                '01',
                                '02',
                                '03',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  experience.value = newValue;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      sizedBoxDefault(),
                      UnderlineTextfield(
                        label: 'Joining Date',
                        hint: '10-01-2025',
                        controller: joiningDateController,
                        showSuffixIcon: true,
                        suffixIcon: Icons.calendar_today,
                        onTap: () => _selectDate(context),
                        readOnly: true,
                      ),
                      sizedBoxDefault(),
                      UnderlineTextfield(
                        label: 'Address',
                        hint: 'Write address here...',
                        controller: addressController,
                        maxLines: 2,
                        showSuffixIcon: false,
                      ),
                      sizedBoxDefault(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assign Trainer',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          Obx(
                            () => DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                              value: experience.value,
                              items: <String>[
                                '01',
                                '02',
                                '03',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  experience.value = newValue;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      sizedBoxDefault(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Addon Plans',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          Obx(
                            () => DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                              value: experience.value,
                              items: <String>[
                                '01',
                                '02',
                                '03',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  experience.value = newValue;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      sizedBoxDefault(),
                      UnderlineTextfield(
                        label: 'Password',
                        hint: '',
                        controller: createPasswordController,
                        obscureText: true, // Initially obscure
                        showSuffixIcon: true, // Show eye icon
                      ),
                      sizedBoxDefault(),
                      UnderlineTextfield(
                        label: 'Confirm Password',
                        hint: '',
                        controller: confirmPasswordController,
                        obscureText: true, // Initially obscure
                        showSuffixIcon: true, // Show eye icon
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Cancel',
                              style: notoSansRegular.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle add Member logic
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              'Add Member',
                              style:
                                  notoSansRegular.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      sizedBoxDefault(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
