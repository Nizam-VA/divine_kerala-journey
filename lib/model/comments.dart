class CommentsModel {
  String commentId;
  String userId;
  String userName;
  String pilgrimId;
  String message;
  String image;
  CommentsModel(
      {required this.commentId,
      required this.userId,
      required this.userName,
      required this.pilgrimId,
      required this.message,
      required this.image});
}
