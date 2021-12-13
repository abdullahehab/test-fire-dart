import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/side_menu_items.dart';
import 'package:admin/utils/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:admin/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
GestureDetector buildSingleCard(BuildContext context) {
  return GestureDetector(
    onTap: () => context.read<MenuController>().setSelectedMenuIndex =
        menuItems.indexOf(menuItems.last),
    child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundColor: Colors.transparent,
                  child: SvgPicture.asset(
                    Resources.maleIcon,
                    width: 40,
                    height: 40,
                  ),
                ),
                Text("عبد الله ايهاب سعد"),
                Text("28756475866423"),
              ],
            ).addPaddingHorizontalVertical(vertical: 20),
            Positioned(
                top: 0,
                right: 0,
                child: PopupMenuButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(FontAwesomeIcons.ellipsisV),
                    iconSize: 13,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("تعديل"),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text("خذف"),
                            value: 2,
                          )
                        ]))
          ],
        )),
  );
}
