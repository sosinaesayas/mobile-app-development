import 'package:flutter/material.dart';
import 'package:jobportal/presentation/views/post_body.dart';

class PostJobWidget extends StatefulWidget {
  const PostJobWidget({super.key});

  @override
  State<PostJobWidget> createState() => _PostJobWidgetState();
}

class _PostJobWidgetState extends State<PostJobWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.blueGrey,
      child: Center(
      
            child: SingleChildScrollView(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PostBody()
                  ],
                ),
              ),
            ),
          ),
    );
  }
}