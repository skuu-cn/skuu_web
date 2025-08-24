import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../constant/api_constant.dart';
import '../../../data/models/skuu_blog_page_entity.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../me/me_detail_page.dart';
import '../../me/myku_page.dart';

class MeController extends GetxController with GetTickerProviderStateMixin {
  List<dynamic>? data;
  late bool hasSearch = true;
  late List<String> tabTitle = [];
  late List<Widget> tabBoby = [];
  late TabController tabController;
  final controller = TextEditingController();
  late List<SkuuBlogPageDataRecords> skuuBlogPageDataRecords = [];

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  @override
  void onInit() {
    initTabView();
    super.onInit();
  }

  @override
  void onReady() {
    // getDataFromApi();
    super.onReady();
  }

  // getDataLocal() async {
  //   final response = await rootBundle.loadString('mock/menus.json');
  //   List<dynamic> jsonList = jsonDecode(response);
  //   menus = jsonList.map((json) => MenusEntity.fromJson(json)).toList();
  // }

  // getting data from api
  getDataFromApi() async {
    // *) perform api call
    await ApiBaseClient.safeApiCall(
      ApiConstant.BLOG_PAGE, // url
      RequestType.get, // request type (get,post,delete,put)
      onLoading: () {
        // *) indicate loading state
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        SkuuBlogPageEntity skuuBlogPageEntity =
            SkuuBlogPageEntity.fromJson(response.data);
        skuuBlogPageDataRecords = skuuBlogPageEntity.data.list;
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        ApiBaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  void getTabviewMenu() {
    tabTitle = ['金库', '作品'];
    tabBoby = [
      MykuPage(userId: 12),
      MeDetailPage(12),
    ];
    update();
  }

  void initTabView() {
    getTabviewMenu();
    tabController = TabController(
      length: tabTitle.length,
      vsync: this,
    )..addListener(() {
        //搜索框
        if (tabController.index == 0) {
          hasSearch = true;
        } else {
          hasSearch = false;
        }
      });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
