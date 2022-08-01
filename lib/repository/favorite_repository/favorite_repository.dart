import 'package:cat_api_test_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteRepository {
  var collection = FirebaseFirestore.instance
      .collection('users/${FirebaseAuth.instance.currentUser!.uid}/items');

  Stream<List<Favorite>> fetchItems() {
    return collection
        .orderBy('created', descending: true)
        .snapshots()
        .map((event) {
      var items = <Favorite>[];
      event.docs.forEach((doc) {
        items.add(
          Favorite(
            id: doc.data()['id'],
            url: doc.data()['url'],
            created: DateTime.fromMillisecondsSinceEpoch(doc.data()['created'],
                isUtc: true),
          ),
        );
      });
      return items;
    });
  }

  Future addLike(Favorite favorite) async {
    favorite.created = DateTime.now();

    await collection.doc(favorite.id).set({
      'id': favorite.id,
      'url': favorite.url,
      'created': favorite.created.toUtc().millisecondsSinceEpoch,
    });
  }

  Future<bool> likeExist(String id) async {
    final favorite = await collection.doc(id).get();
    if (favorite.exists) {
      return true;
    }
    return false;
  }

  Future dislike(String id) async {
    await collection.doc(id).delete();
  }
}
