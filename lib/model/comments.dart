class CommentsModel {
  String commentId;
  String userId;
  String userName;
  String pilgrimId;
  String message;
  CommentsModel(
      {required this.commentId,
      required this.userId,
      required this.userName,
      required this.pilgrimId,
      required this.message});
}
