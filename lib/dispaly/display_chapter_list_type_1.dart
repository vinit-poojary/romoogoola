import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:romoogoola/widget/network_image.dart';

class DisplayChapterListType1 extends StatefulWidget {
  final List page;

  const DisplayChapterListType1({Key key, this.page}) : super(key: key);

  @override
  _DisplayChapterListType1State createState() => _DisplayChapterListType1State();
}

class _DisplayChapterListType1State extends State<DisplayChapterListType1> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding:
                EdgeInsets.only(top: 10.0, bottom: 10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildItems("hhh");
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(String page) {
    double _scale = 1.0;
    double _previousScale = 1.0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: GestureDetector(
          onScaleStart: (ScaleStartDetails details) {
            print(details);
            _previousScale = _scale;
            setState(() {});
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            print(details);
            _scale = _previousScale * details.scale;
            setState(() {});
          },
          onScaleEnd: (ScaleEndDetails details) {
            print(details);

            _previousScale = 1.0;
            setState(() {});
          },
          child: RotatedBox(
            quarterTurns: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child: PNetworkImage(
                  "https://images.unsplash.com/photo-1578253809350-d493c964357f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapItem(BuildContext pContext, int index, AsyncSnapshot snapshot) {
    Navigator.of(pContext)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        body: Text(snapshot.data[index].data['chapterName'].toString()),
        //body:DisplayChapter(index: index,snapshot: snapshot)
      );
    }));
  }
}
