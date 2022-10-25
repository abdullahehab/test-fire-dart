import 'package:admin/features/add_new_user/domain/entities/user_entity.dart';
import 'package:admin/features/housing/presentation/controller/controller.dart';
import 'package:admin/features/owning/presentation/controller/controller.dart';
import 'package:admin/features/social_status/presentation/controller/controller.dart';
import 'package:admin/features/working/presentation/controller/controller.dart';
import 'package:admin/utils/page_route_name.dart';
import 'package:admin/widget/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:admin/extensions/extension.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/shared_components/drop_down_widget.dart';
import '../../../../core/shared_components/styled_content_widget.dart';
import '../../../../core/shared_page/app_empty.dart';
import '../../../../utils/text_field_validator.dart';
import '../../../../widget/custom_text_field.dart';
import '../../../../widget/data_cell_item.dart';
import '../../../../widget/data_column_Item.dart';
import '../../../../widget/data_controller.dart';
import '../../../../widget/data_table.dart';
import '../../../housing/domain/entities/housing.dart';
import '../../../owning/domain/entities/owning.dart';
import '../../../social_status/domain/entities/social_status.dart';
import '../../../working/domain/entities/work.dart';
import '../controller/user_controller.dart';
import 'add_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersList extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => buildBody(state, context),
        onLoading: Scaffold(
          body: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
        onEmpty: appEmpty(onPressed: () => Get.toNamed(PageRouteName.ADD_NEW)));
  }

  var socialStatusController = Get.find<SocialStatusController>();
  var workController = Get.find<WorkController>();
  var owningController = Get.find<OwningController>();
  var housingController = Get.find<HousingController>();
  Scaffold buildBody(List<UserEntity>? users, BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          validator: TextFieldValidators.isName,
                          prefixIcon:
                              Icon(FontAwesomeIcons.user, size: APP_ICON_SIZE),
                          contentPadding: EdgeInsets.only(right: 10),
                          // onChangedText: (String text) => userModel.name = text,
                          // initialValue: userModel.name,
                          hint: 'الاسم',
                          outLineText: 'الاسم',
                          iconPathWidth: 17,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: CustomTextField(
                          validator: TextFieldValidators.isPhone,
                          contentPadding: EdgeInsets.only(right: 10),
                          prefixIcon: Icon(FontAwesomeIcons.addressBook,
                              size: APP_ICON_SIZE),
                          // onChangedText: (String text) => userModel.phone = text,
                          // initialValue: userModel.phone,
                          hint: 'الرقم القومي',
                          outLineText: 'الرقم القومي',
                          iconPathWidth: 17,
                          maxLength: 11,
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: DropDownWidgetX<Work>(
                          requiredFiled: true,
                          labelText: 'الوظيفة',
                          // selectedItem: workController.getById(userModel.working!),
                          itemAsString: (Work? u) => u!.title!,
                          maxHeight: 100,
                          items: workController.workList,
                          onChanged: (value) {
                            var selected = value as Work;
                            // userModel.working = selected.id.toString();
                          },
                        ),
                      ),
                      SizedBox(width: 2.w),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: DropDownWidgetX<Owning>(
                          requiredFiled: true,
                          labelText: 'الحيازة',
                          // selectedItem: owningController.getById(userModel.owning!),
                          itemAsString: (Owning? u) => u!.title!,
                          maxHeight: 100,
                          items: owningController.owningList,
                          onChanged: (value) {
                            var selected = value as Owning;
                            // userModel.owning = selected.id.toString();
                          },
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                          child: DropDownWidgetX<Housing>(
                        requiredFiled: true,
                        labelText: 'السكن',
                        // selectedItem: housingController.getById(userModel.housing!),
                        itemAsString: (Housing? u) => u!.title!,
                        maxHeight: 100,
                        items: housingController.housingList,
                        onChanged: (value) {
                          var selected = value as Housing;
                          // userModel.housing = selected.id.toString();
                        },
                      )),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: DropDownWidgetX<SocialStatus>(
                          requiredFiled: true,
                          labelText: 'الحالة الاجتماعية',
                          // selectedItem:
                          // socialStatusController.getById(userModel.socialStatus!),
                          itemAsString: (SocialStatus? u) => u!.title!,
                          maxHeight: 100,
                          items: socialStatusController.socialStatusList,
                          onChanged: (value) {
                            var selected = value as SocialStatus;
                            // userModel.socialStatus = selected.id.toString();
                          },
                        ),
                      ),

                      SizedBox(width: 2.w),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 40.h),
            StyledContent(
              subTitle: 'الاشخاص',
              leadingWidget: CustomButton(
                  width: 200,
                  height: 50,
                  text: 'اضافة شخص جديد',
                  onPressed: () => Get.toNamed(PageRouteName.ADD_NEW)),
              children: [
                dataTable(
                  columns: [
                    dataColumnItem(title: '#'),
                    dataColumnItem(title: 'الاسم'),
                    dataColumnItem(title: 'الحالة الاجتماعية'),
                    dataColumnItem(title: 'الوظيفة'),
                    dataColumnItem(title: 'العنوان'),
                    dataColumnItem(title: 'رقم الهاتف'),
                    dataColumnItem(title: 'الحيازة'),
                    dataColumnItem(title: 'السكن'),
                    dataColumnItem(title: 'الحالة الصحية'),
                    dataColumnItem(title: 'التمييز'),
                    dataColumnItem(title: 'عدد الابناء'),
                    dataColumnItem(title: 'الاجرائات'),
                  ],
                  rows: List.generate(users!.length, (index) {
                    var item = users.elementAt(index);

                    List<UserEntity> children = [];

                    if (item.gender == 'ذكر') {
                      children = users
                          .where((user) => user.parentId == item.nationalId)
                          .toList();

                      item.childrenNumber = children.length;
                    }

                    return DataRow(
                      cells: [
                        dataCellItem(data: item.nationalId.toString()),
                        dataCellItem(data: item.name!),
                        dataCellItem(
                            data: socialStatusController
                                .getById(item.socialStatus!)!
                                .title!),
                        dataCellItem(
                            data:
                                workController.getById(item.working!)!.title!),
                        dataCellItem(data: item.address!),
                        dataCellItem(data: item.phone!),
                        dataCellItem(
                            data:
                                owningController.getById(item.owning!)!.title!),
                        dataCellItem(
                            data: housingController
                                .getById(item.housing!)!
                                .title!),
                        dataCellItem(data: item.healthStatus.toString()),
                        dataCellItem(data: item.type.toString()),
                        dataCellItem(data: item.childrenNumber.toString()),
                        dataController(
                            onEditPressed: () {
                              PeopleDetailsParas params =
                                  PeopleDetailsParas(userModel: item);
                              // Get.toNamed(PageRouteName.ADD_NEW,
                              //     arguments: params);
                              viewForm(params);
                            },
                            onRemovePressed: () =>
                                controller.deleteUser(item.nationalId!),
                            onViewPressed: () => Get.toNamed(
                                PageRouteName.PEOPLE_DETAILS,
                                arguments: item))
                      ],
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  viewForm(PeopleDetailsParas paras) async {
    showDialog(
      context: Get.context!,
      builder: (_) => AddPeople(
        paras: paras,
      ),
    );
  }
}
