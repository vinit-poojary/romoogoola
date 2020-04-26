import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Firestore _firestore = Firestore.instance;
String ref = 'comicCatalogue';
var chapter = 'chapter';

class Manga {
  void uploadCatalogue(Map<String, dynamic> data) {
    var id = Uuid();
    String comicId = id.v1();
    data["id"] = comicId;
    _firestore.collection(ref).document(comicId).setData(data);
  }

  void uploadChapter(Map<String, dynamic> data) {
    _firestore
        .collection(ref)
        .document(chapter)
        .collection(chapter)
        .document()
        .setData(data);
  }
}

Future getCatalogue() async {
  QuerySnapshot catalogueDetails =
      await _firestore.collection(ref).getDocuments();
  return catalogueDetails.documents;
}

Future getChapter(String refId) async {
  QuerySnapshot chapterDetails = await _firestore
      .collection(ref)
      .document(refId)
      .collection(chapter)
      .getDocuments();
  print(chapterDetails.documents);
  return chapterDetails.documents;
}
