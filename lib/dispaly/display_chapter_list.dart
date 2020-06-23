import 'package:flutter/material.dart';
import 'package:romoogoola/database/data.dart';
import 'package:romoogoola/dispaly/display_chapter_list_type_1.dart';

class DisplayChapterList extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;

  const DisplayChapterList({Key key, this.index, this.snapshot})
      : super(key: key);

  @override
  _DisplayChapterListState createState() => _DisplayChapterListState();
}

class _DisplayChapterListState extends State<DisplayChapterList> {
  Future _data;
  List<String> page;

  @override
  void initState() {
    super.initState();
    // if(widget.snapshot.data[widget.index].da)
    _data = getChapterList(widget.snapshot.data[widget.index].data['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _data,
        builder: (context, snapshot) {
          Widget newsListSliver;
          if (snapshot.hasError) {
            CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            newsListSliver = SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            newsListSliver = SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildItems(index, context, snapshot);
                },
                childCount: snapshot.data.length,
              ),
            );
          }
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
                  sliver: newsListSliver,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildItems(int index, BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () => _onTapItem(context,index,snapshot),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                snapshot.data[index].data['chapterName'].toString(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTapItem(BuildContext pContext, int index, AsyncSnapshot snapshot) {
    Navigator.of(pContext)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        body: DisplayChapterListType1(page: getImageList(index,snapshot)),
      );
    }));
  }

 List getImageList(int index, AsyncSnapshot snapshot) {
    for (int i = 0;;i++) {
      if (page[i]==null)
        break;
      page[i] = snapshot.data[index].data['page' + i.toString()];
    }
    return page;
  }
}
