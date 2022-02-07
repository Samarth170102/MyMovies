class UserDataModel {
  int? index;
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  List<dynamic>? watchlist;
  UserDataModel({
    this.uid,
    this.name,
    this.email,
    this.index,
    this.photoUrl,
    this.watchlist,
  });
}
