import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/generated/json/base/json_convert_content.dart';
import 'package:flutter_application_pcr_tools/model/battle_team_entity.dart';
import 'package:flutter_application_pcr_tools/net/apis.dart';
import 'package:flutter_application_pcr_tools/page/webview_page.dart';
import 'package:flutter_application_pcr_tools/service/api_service.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../service/battle_team_param.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  String _currentLevel = "A 1-3";
  String _currentBoss = "1";
  List<int> _currentType = [0, 1, 2];

  late EasyRefreshController _refreshController;

  List<BattleTeamEntity> _displayData = [];

  List<String> _itemTitleList = [
    "阶 段：",
    "Boss：",
    "刀 型：",
  ];
  List<List<String>> _itemContentList = [
    ["A 1-3", "B 4-10", "C 11-34", "D 35+"],
    ["1", "2", "3", "4", "5"],
    ["手动", "Auto/半Auto", "尾刀"]
  ];

  late List _itemOnPressedList;

  _getBattleTeamData() async {
    var res = await ApiService.getBattleTeam(
        BattleTeamParam(_currentLevel.substring(0, 1), _currentBoss));
    var data = jsonConvert.convertListNotNull<BattleTeamEntity>(res?.data);
    if (data != null) {
      // 过滤
      _displayData = data.where((element) {
        bool result = false;
        if (_currentType.contains(0)) {
          if (element.auto == null && element.tail == null) {
            return true;
          }
        }
        if (_currentType.contains(1)) {
          if (element.auto != null && element.auto!) {
            return true;
          }
        }
        if (_currentType.contains(2)) {
          if (element.tail != null && element.tail!) {
            return true;
          }
        }
        return result;
      }).toList();
      // 筛选
      _displayData.sort((a, b) => b.damage!.compareTo(a.damage!));
      setState(() {});
    } else {
      EasyLoading.showError("数据为空");
    }
  }

  Widget _battleTeamListTile(BattleTeamEntity obj) {
    var width = (ScreenUtil().screenWidth - 16 * 4 - 8 * 4) / 5;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("battle_detail", arguments: obj);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 6.0), //阴影y轴偏移量
                blurRadius: 10, //阴影模糊程度
                spreadRadius: 2 //阴影扩散程度
                ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  obj.name.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 8),
                Text(
                  obj.damage.toString() + "w",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.redAccent),
                ),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: obj.unitIds!
                  .map(
                    (e) => CachedNetworkImage(
                      imageUrl: NetApis.getUnitIcon(e),
                      width: width,
                      height: width,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 8),
            Text(
              "note:" + obj.note.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            // Column(
            //   children: obj.links!.map((e) => _getLink(e)).toList(),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _itemOnPressedList = [
      levelTileOnPressed,
      bossTileOnPressed,
      typeTileOnPressed
    ];

    _refreshController = EasyRefreshController();
    _scrollController = ScrollController();
    _getBattleTeamData();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  levelTileOnPressed(String e) {
    if (!e.contains(_currentLevel)) {
      _currentLevel = e.substring(0, 1);
      _getBattleTeamData();
    }
  }

  bossTileOnPressed(String e) {
    if (!e.contains(_currentBoss)) {
      _currentBoss = e.substring(0, 1);
      _getBattleTeamData();
    }
  }

  typeTileOnPressed(String e) {
    var itemTypeList = _itemContentList[2];
    var index = itemTypeList.indexOf(e);
    if (_currentType.contains(index)) {
      _currentType.remove(index);
    } else {
      _currentType.add(index);
    }
    _getBattleTeamData();
  }

  bool itemIsSelected(List<String> list, String item) {
    var index = _itemContentList.indexOf(list);
    var result = false;
    if (index == 0) {
      if (item.contains(_currentLevel)) {
        result = true;
      }
    } else if (index == 1) {
      if (item.contains(_currentBoss)) {
        result = true;
      }
    } else if (index == 2) {
      var indexX = list.indexOf(item);
      if (_currentType.contains(indexX)) {
        return true;
      }
    }
    return result;
  }

  Widget sliverListTitle(String title, List<String> list) {
    var index = _itemTitleList.indexOf(title);
    return Row(
      children: [
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: list.map((e) {
                return Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                            width: 3,
                            color: itemIsSelected(list, e)
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                      ),
                      onPressed: () {
                        _itemOnPressedList[index](e);
                      },
                      child: Text(
                        e,
                        style: TextStyle(
                          color: itemIsSelected(list, e)
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSliverList([int count = 3]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) =>
            sliverListTitle(_itemTitleList[index], _itemContentList[index]),
        childCount: count,
      ),
      itemExtent: 44,
    );
  }

  late ScrollController _scrollController;

  Widget _refresh() {
    return EasyRefresh.builder(
      controller: _refreshController,
      header: MaterialHeader(
        position: IndicatorPosition.locator,
      ),
      onRefresh: _getBattleTeamData,
      childBuilder: (context, physics) {
        return NestedScrollView(
          physics: physics,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              HeaderLocator.sliver(),
              buildSliverList(),
            ];
          },
          body: _content(physics),
        );
      },
    );
  }

  Widget _content(physics) {
    return _displayData.isEmpty
        ? Center(child: Text("数据为空"))
        : Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              physics: physics,
              controller: _scrollController,
              padding: EdgeInsets.all(8),
              itemCount: _displayData.length,
              itemBuilder: (BuildContext context, int index) =>
                  _battleTeamListTile(_displayData[index]),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主页"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
        ],
      ),
      body: _refresh(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(0,
              duration: Duration(seconds: 1), curve: Curves.linearToEaseOut);
        },
        child: Icon(Icons.arrow_upward),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
