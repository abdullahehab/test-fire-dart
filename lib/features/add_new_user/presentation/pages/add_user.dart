import 'package:admin/extensions/extension.dart';
import 'package:admin/features/add_new_user/presentation/controller/user_controller.dart';
import 'package:admin/utils/colors.dart';
import 'package:admin/widget/custom_text_field.dart';
import 'package:admin/widget/gender_selector.dart';
import 'package:admin/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../core/shared_components/build_date_time_picker_field.dart';
import '../../../../core/shared_components/drop_down_widget.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/text_field_validator.dart';
import '../../../../widget/date_selector.dart';

class AddPeople extends GetView<UserController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isEdit = false;
    UserModel userModel;
    if (Get.arguments == null) {
      userModel = UserModel();
    } else {
      isEdit = true;
      userModel = Get.arguments as UserModel;
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            CustomButton(
                buttonColor: AppColor.kPrimaryDarkColor,
                borderRadius: 6,
                width: 70,
                buttonPadding: EdgeInsets.zero,
                text: "tes",
                withoutPadding: true,
                onPressed: () {
                  if (_formKey.currentState!.validate() == false) {
                    return;
                  }
                  _formKey.currentState!.save();

                  controller.addUser(userModel);
                }).addPaddingOnly(left: 10, top: 10, bottom: 10)
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                CustomTextField(
                  validator: TextFieldValidators.isName,
                  prefixIcon: Icon(FontAwesomeIcons.user, size: APP_ICON_SIZE),
                  contentPadding: EdgeInsets.only(right: 10),
                  onChangedText: (String text) => userModel.name = text,
                  hint: 'الاسم',
                  outLineText: 'الاسم',
                  iconPathWidth: 17,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: TextFieldValidators.isAddress,
                  contentPadding: EdgeInsets.only(right: 10),
                  prefixIcon:
                      Icon(FontAwesomeIcons.addressBook, size: APP_ICON_SIZE),
                  onChangedText: (String text) => userModel.address = text,
                  hint: 'العنوان',
                  outLineText: 'العنوان',
                  iconPathWidth: 17,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: TextFieldValidators.isPhone,
                  contentPadding: EdgeInsets.only(right: 10),
                  prefixIcon:
                      Icon(FontAwesomeIcons.addressBook, size: APP_ICON_SIZE),
                  onChangedText: (String text) => userModel.phone = text,
                  hint: 'رقم الهاتف',
                  outLineText: 'رقم الهاتف',
                  iconPathWidth: 17,
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: TextFieldValidators.isNationalId,
                  contentPadding: EdgeInsets.only(right: 10),
                  prefixIcon:
                      Icon(FontAwesomeIcons.idCard, size: APP_ICON_SIZE),
                  onChangedText: (String text) => userModel.nationalId = text,
                  hint: 'الرقم القومي',
                  outLineText: 'الرقم القومي',
                  iconPathWidth: 17,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  contentPadding: EdgeInsets.only(right: 10),
                  prefixIcon: Icon(FontAwesomeIcons.phone, size: APP_ICON_SIZE),
                  // borderColor: AppColor.BORDER_COLOR,
                  onChangedText: (String text) => userModel.owning = text,
                  hint: 'حيازه',
                  outLineText: 'حيازه',
                  iconPathWidth: 17,
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  contentPadding: EdgeInsets.only(right: 10),
                  prefixIcon: Icon(FontAwesomeIcons.phone, size: APP_ICON_SIZE),
                  // borderColor: AppColor.BORDER_COLOR,
                  onChangedText: (String text) => userModel.housing = text,
                  hint: 'السكن',
                  outLineText: 'السكن',
                  iconPathWidth: 17,
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                DropDownWidgetX(
                  labelText: 'الحاله الاجتماعيه',
                  maxHeight: 100,
                  items: statusKeys,
                  selectedItem: statusKeys.first,
                  onChanged: (value) {},
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: TextFieldValidators.isNotEmpty,
                  contentPadding: EdgeInsets.only(right: 10),
                  prefixIcon: Icon(FontAwesomeIcons.phone, size: APP_ICON_SIZE),
                  onChangedText: (String text) => userModel.working = text,
                  hint: 'الوظيفه',
                  outLineText: 'الوظيفه',
                  iconPathWidth: 17,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                buildDateTimePickerField(
                  labelText: 'تاريخ الميلاد',
                  // initialValue: customerModels.value.idExpireDate,
                  firstDate: DateTime.now().year,
                  onSaved: (value) => userModel.birthDate = value,
                ),
                SizedBox(height: 10),
                DropDownWidgetX(
                  maxHeight: 100,
                  labelText: 'الحالة الصحية',
                  items: healthKeys,
                  selectedItem: healthKeys.first,
                  onChanged: (value) => userModel.healthStatus = 1,
                ),
                SizedBox(
                  height: 10,
                ),
                GenderSelector(
                  outLineText: 'النوع',
                  onChanged: (newValue) => userModel.gender = newValue,
                ),
              ],
            ).addPaddingOnly(bottom: context.mediaQueryPadding.bottom),
          ),
        ).addPaddingHorizontalVertical(horizontal: 16));
  }
}

class HorizontalLabeledWidget extends StatelessWidget {
  const HorizontalLabeledWidget(
      {Key? key, required this.child, required this.label})
      : super(key: key);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 27.w,
          child: Text(
            '${label} : ',
            style: TextStyle(
              fontSize: 16,
              height: 1,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SizedBox(
            child: child,
          ),
        ),
      ],
    );
  }
}
