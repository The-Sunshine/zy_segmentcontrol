
import 'package:flutter/material.dart';
import 'package:zy_segmentcontrol/tab_indicator_line.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  var list = ['豆芽豆品','豆芽时间'];
  int selectedIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = new TabController(length: list.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            initSegmentControl(),
          ],
        ),
      ),
    );
  }

  initSegmentControl() {
    return Row(
      children: <Widget>[
        Expanded(child: Container(),
          flex: 1,
        ),
        Expanded(child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: TabBar(indicator:TabIndicatorline(
            borderSide: BorderSide(width: 2,color: Colors.green),
            IndicatorWidth: 18,
          ),
              tabs: list.map((e) => Text(e)).toList(),
              isScrollable: true,
              controller: tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              labelStyle: TextStyle(fontSize: 18),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(fontSize: 18),
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (index) {
                this.selectedIndex = index;
                print('tap is $index');
              }
          ),
        ),
          flex: 3,
        ),
        Expanded(child: Container(),
          flex: 1,
        ),
      ],
    );
  }
}
