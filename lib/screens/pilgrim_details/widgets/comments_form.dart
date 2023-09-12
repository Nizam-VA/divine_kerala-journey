import 'package:devine_kerala_journey/model/comments.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../services/auth_services.dart';

final AuthServices _auth = AuthServices();

class CommentsForm extends StatefulWidget {
  String pilgrimId;
  CommentsForm({super.key, required this.pilgrimId});

  @override
  State<CommentsForm> createState() => _CommentsFormState();
}

class _CommentsFormState extends State<CommentsForm> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Text your comment here:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _commentController,
              decoration: inputDecoration.copyWith(hintText: 'Comments here:'),
              validator: ((value) =>
                  value!.isEmpty ? 'Please enter a value' : null),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String commentId = DateTime.now().toString();
                  String pilgrimId = widget.pilgrimId;
                  String userId = _auth.firebaseAuth.currentUser!.uid;
                  String message = _commentController.text;
                  String userName =
                      _auth.firebaseAuth.currentUser!.displayName!;

                  final comment = CommentsModel(
                      commentId: commentId,
                      userId: userId,
                      userName: userName,
                      pilgrimId: pilgrimId,
                      message: message);

                  DatabaseComments().insertPilgrim(comment);

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: .5, color: AppColors.primary)),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
