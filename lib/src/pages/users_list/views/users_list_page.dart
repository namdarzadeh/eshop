import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/models/person_view_model.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../../shared/views/custom_switch_widget.dart';
import '../controllers/controller_users_list.dart';

class UsersListPage extends GetView<ControllerUsersList> {
  const UsersListPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.eshop_shared_users_list.tr),
          actions: [
            IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_forward_outlined))
          ],
        ),
        drawer: const CustomDrawerWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Obx(() => Column(children: [
                    Card(
                      elevation: 3,
                      shadowColor: Colors.blue[700],
                      child: Padding(
                        padding: EdgeInsets.all(EShopUtils.largePadding()),
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: EShopUtils.largePadding()),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(
                                        LocaleKeys.eshop_shared_username.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(LocaleKeys.eshop_shared_name.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(
                                        LocaleKeys.eshop_shared_mobile.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(
                                        LocaleKeys.eshop_shared_admin.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                ]),
                          ),
                          ...usersList(context),
                        ]),
                      ),
                    ),
                  ]))),
        ),
      );

  List<Widget> usersList(final BuildContext context) {
    final List<Widget> users = [];
    for (var i in controller.persons.value) {
      users.add(buildRow(i, context));
    }
    return users;
  }

  Padding buildRow(final PersonViewModel person, final BuildContext context) {
    final bool thisAdmin =
        person.id == EShopParameters.localPersonViewModel.id ? true : false;
    return Padding(
      padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: EdgeInsets.all(EShopUtils.smallPadding()),
          child: Text(person.username,
              style: TextStyle(fontSize: EShopUtils.smallTextSize())),
        ),
        Padding(
          padding: EdgeInsets.all(EShopUtils.smallPadding()),
          child: Text('${person.name} ${person.family}',
              style: TextStyle(fontSize: EShopUtils.smallTextSize())),
        ),
        Padding(
          padding: EdgeInsets.all(EShopUtils.smallPadding()),
          child: Text(person.mobile.toString(),
              style: TextStyle(fontSize: EShopUtils.smallTextSize())),
        ),
        Visibility(
          visible: thisAdmin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(LocaleKeys.eshop_shared_deactive.tr,
                  style: TextStyle(fontSize: EShopUtils.smallTextSize())),
              CustomSwitchWidget(
                  sendCheckboxState: (final i) => '', isSwitched: true),
              Text(LocaleKeys.eshop_shared_active.tr,
                  style: TextStyle(fontSize: EShopUtils.smallTextSize()))
            ],
          ),
        ),
        Visibility(
          visible: !thisAdmin,
          child: Row(
            children: [
              Text(LocaleKeys.eshop_shared_deactive.tr,
                  style: TextStyle(fontSize: EShopUtils.smallTextSize())),
              CustomSwitchWidget(
                  sendCheckboxState: (final i) =>
                      controller.editPerson(i, person),
                  isSwitched: person.isadmin == 1 ? true : false),
              Text(LocaleKeys.eshop_shared_active.tr,
                  style: TextStyle(fontSize: EShopUtils.smallTextSize()))
            ],
          ),
        ),
      ]),
    );
  }
}
