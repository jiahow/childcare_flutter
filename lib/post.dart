
class Post {
  String Body;
  String Author;
  int Likes = 0;
  Set UsersLiked = {};

  Post(this.Body, this.Author);

  Map<String, dynamic> ToJSON() {
    return {
      'author': this.Author,
      'body': this.Body,
      'likes': this.Likes,
      'users_liked': this.UsersLiked.toList()
    };
  }
}
