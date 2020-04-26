import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:romoogoola/dispaly/display_chapter.dart';
import 'package:romoogoola/widget/network_image.dart';

class DisplayCatalogue extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;

  const DisplayCatalogue({Key key, this.index, this.snapshot})
      : super(key: key);

  @override
  _DisplayCatalogueState createState() => _DisplayCatalogueState();
}

class _DisplayCatalogueState extends State<DisplayCatalogue> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                    expandedHeight: 200,
                    index: widget.index,
                    snapshot: widget.snapshot),
                pinned: false,
                floating: true,
              ),
              SliverFillRemaining(
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                      top: 150,
                      left: 10,
                      child: Container(
                        child: LikeButton(
                          size: 50,
                          circleColor: CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.play_arrow,
                              color: isLiked
                                  ? Colors.deepPurpleAccent
                                  : Colors.grey,
                              size: 50,
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: (MediaQuery.of(context).size.width / 2) - 25,
                      child: LikeButton(
                        size: 50,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.favorite,
                            color:
                                isLiked ? Colors.deepPurpleAccent : Colors.grey,
                            size: 50,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 150,
                      right: 10,
                      child: LikeButton(
                        size: 50,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        onTap: (bool) async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DisplayChapterList(
                                      index: widget.index,
                                      snapshot: widget.snapshot)));
                          return null;
                        },
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.play_arrow,
                            color:
                                isLiked ? Colors.deepPurpleAccent : Colors.grey,
                            size: 50,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 220,
                      left: 10,
                      child: IconButton(
                          iconSize: 50,
                          icon: Icon(Icons.list),
                          tooltip: 'list',
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DisplayChapterList(
                                        index: widget.index,
                                        snapshot: widget.snapshot)));
                          }),
                    ),
                    Positioned(
                      top: 220,
                      right: 10,
                      child: IconButton(
                          iconSize: 50,
                          icon: Icon(Icons.list),
                          tooltip: 'list',
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DisplayChapterList(
                                        index: widget.index,
                                        snapshot: widget.snapshot)));
                          }),
                    ),
                    Positioned(
                        top: 280,
                        left: 10,
                        child: Text(
                            widget.snapshot.data[widget.index].data['name'])),
                    Positioned(
                        top: 300,
                        left: 10,
                        child: Text(widget
                            .snapshot.data[widget.index].data['description'])),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: new BottomAppBar(
          shape: AutomaticNotchedShape(
              RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add new chapter'),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}

Future<bool> onChapterListButtonClick(bool isLiked) async {
  /// send your request here
  //final bool success= await sendRequest();

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;

  return !isLiked;
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final AsyncSnapshot snapshot;
  final int index;

  MySliverAppBar({@required this.expandedHeight, this.index, this.snapshot});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        PNetworkImage(snapshot.data[index].data['picture'], fit: BoxFit.cover),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              snapshot.data[index].data['name'],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 3,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: expandedHeight,
                  //width: (MediaQuery.of(context).size.width / 2)/100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: PNetworkImage(snapshot.data[index].data['picture'],
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
