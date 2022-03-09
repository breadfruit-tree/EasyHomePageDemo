import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'SliverHeaderDelegate.dart';

class HomePageDemo extends StatefulWidget {
   const HomePageDemo({Key? key}) : super(key: key);

  @override
  _HomePageDemoState createState() => _HomePageDemoState();
}

class _HomePageDemoState extends State<HomePageDemo>
    with SingleTickerProviderStateMixin {
  //定义
  late TabController _tabController;
  List<Map> imgList = [
    {"url": "images/cheese_dip.png"},
    {"url": "images/cheese_dip.png"},
    {"url": "images/cheese_dip.png"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //实例化
    _tabController = TabController(length: 2, vsync: this);
    //tab切换的监听事件
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            ///轮播图
            SliverToBoxAdapter(
              child: AspectRatio(
                //设置图片的展示比例之后，可以不设置外层的宽度，或者设置成infinity
                aspectRatio: 16 / 9,
                child: Swiper(
                  itemCount: imgList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      imgList[index]["url"],
                      fit: BoxFit.cover,
                    );
                  },
                  //分页指示器
                  pagination: const SwiperPagination(),
                  //页面上的左右箭头
                  control: null,
                  //自动轮播
                  autoplay: true,
                  loop: true,
                ),
              ),
            ),

            ///导航栏
            SliverGrid.count(
              crossAxisCount: 4,
              children: List.generate(8, (index) {
                return Container(
                  color: Colors.primaries[index % Colors.primaries.length],
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              }).toList(),
            ),

            ///广告位
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 120,
                  child: Image.asset(
                    "images/cheese_dip.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),

            ///TabBar
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                  //有最大和最小高度
                  maxHeight: 80,
                  minHeight: 50,
                  // child: buildHeader(1),
                  child: SizedBox(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: TabBar(
                        indicatorColor: Colors.black,
                        //指示器颜色
                        indicatorSize: TabBarIndicatorSize.label,
                        //表示指示器与文字等宽
                        // indicatorSize: TabBarIndicatorSize.tab,
                        //表示指示器与文字等宽
                        // indicatorWeight: 40,          //指示器高度
                        labelColor: Colors.black,
                        //字体颜色
                        unselectedLabelColor: Colors.black.withOpacity(0.6),
                        controller: _tabController,
                        //注意
                        tabs: const [
                          Tab(
                            text: "热销",
                          ),
                          Tab(
                            text: "推荐",
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController, //注意
          children: [
            buildListView(),
            buildListView(),
          ],
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 8.5, right: 8.5, bottom: 10),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('$index'));
      },
    );
  }
}
