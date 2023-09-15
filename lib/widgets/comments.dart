import 'package:devine_kerala_journey/model/comments.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  PilgrimagesData pilgrim;

  Comments({super.key, required this.pilgrim});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<CommentsModel>? comments;

  getComments() async {
    comments =
        await DatabaseComments().getCommentsForPilgrim(widget.pilgrim.id);
    setState(() {});
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 8),
      color: Colors.white,
      child: Expanded(
          child: comments == null
              ? const SizedBox(
                  width: double.infinity,
                  child: Text('No comments yet', textAlign: TextAlign.center),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: CircleAvatar(
                          radius: 21,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/icons/user.png',
                                height: 24),
                          ),
                        ),
                        title: Text(
                          comments![index].userName.trim(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          comments![index].message,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: const SizedBox(
                          width: 48,
                          // child: PopupMenuButton(
                          //   onSelected: (value) {

                          //   },
                          //   itemBuilder: (context) => [
                          //     const PopupMenuItem(
                          //         value: 'edit', child: Text('Edit')),
                          //     const PopupMenuItem(
                          //         value: 'delete', child: Text('Delete'))
                          //   ],
                          // ),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: comments!.length,
                )),
    );
  }
}
