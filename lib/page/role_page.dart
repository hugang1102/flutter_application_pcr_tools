import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/model/unit_data.dart';
import 'package:flutter_application_pcr_tools/service/api_service.dart';
import 'package:flutter_application_pcr_tools/net/apis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RolePage extends StatefulWidget {
  const RolePage({Key? key}) : super(key: key);

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage>
    with AutomaticKeepAliveClientMixin {
  List<UnitData> _normalData = [];
  List<UnitData> _displayData = [];

  late EasyRefreshController _easyRefreshController;
  late ScrollController _scrollController;

  _getData() async {
    _normalData = await ApiService.getUnitDatas();
    if (_normalData.isNotEmpty) {
      _displayData.clear();
      _displayData.addAll(_normalData);
      setState(() {});
    }
  }

  // Widget _

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _scrollController = ScrollController();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    var width = (ScreenUtil().screenWidth - 8 * 2 - 16 * 4) / 5;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("角色"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              backgroundColor: Colors.white,
              onChanged: (value) {
                _displayData = _normalData
                    .where((element) => element.unitName!.contains(value))
                    .toList();
                setState(() {});
              },
            ),
          ),
        ),
      ),
      body: EasyRefresh(
        onRefresh: () async => _getData(),
        header: BezierCircleHeader(),
        controller: _easyRefreshController,
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _displayData
                    .map(
                      (e) => CachedNetworkImage(
                        imageUrl: '${NetApis.getUnitIcon(e.unitId!)}',
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: width,
                        height: width,
                        fit: BoxFit.fill,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
