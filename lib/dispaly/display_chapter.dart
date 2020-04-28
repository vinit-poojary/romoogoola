import 'package:flutter/material.dart';
import 'package:romoogoola/database/data.dart';

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

  @override
  void initState() {
    super.initState();
    // if(widget.snapshot.data[widget.index].da)
    _data =
        getChapter(widget.snapshot.data[widget.index].data['id'].toString());
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
                SliverAppBar(
                  expandedHeight: 150.0,
                  pinned: false,
                  floating: true,
                  snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(''),
                    // background:  PNetworkImage(assets.images[1], fit: BoxFit.cover),
                  ),
                ),
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
        onTap: () => _onTapItem(context, index, snapshot),
        child: Column(
          children: <Widget>[
            Text(
              snapshot.data[index].data['chapterName'],
              softWrap: true,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  _onTapItem(BuildContext pcontext, int index, AsyncSnapshot snapshot) {
    Navigator.of(pcontext)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        body: Text(snapshot.data[index].data['chapterName']),
        //body:DisplayChapter(index: index,snapshot: snapshot)
      );
    }));
  }
}
