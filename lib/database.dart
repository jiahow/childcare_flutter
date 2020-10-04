import 'package:firebase_database/firebase_database.dart';
import 'post.dart';

final DatabaseRef = FirebaseDatabase.instance.reference();

DatabaseReference SavePost(Post post) {
  var id = DatabaseRef.child('posts/').push();
  id.set(post.ToJSON());
  return id;
}

void UpdatePost (Post post, DatabaseReference id) {
  id.update(post.ToJSON());
}