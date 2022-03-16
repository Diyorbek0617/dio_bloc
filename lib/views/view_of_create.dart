import 'dart:math';

import 'package:dio_bloc/blocs/create_post_cubit.dart';
import 'package:dio_bloc/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
_finish(BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    Navigator.pop(context, 'result');
  });
}
Widget viewOfCreate(BuildContext context, TextEditingController _titleTextEditingController, TextEditingController _bodyTextEditingController, bool isLoading) {
  return Stack(
    children: [
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Title
              Container(
                height: 100,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: Center(
                  child: TextField(
                    controller: _titleTextEditingController,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              // Body
              Container(
                height: 300,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: _bodyTextEditingController,
                  style: TextStyle(fontSize: 18),
                  maxLines: 30,
                  decoration: InputDecoration(
                    labelText: 'Body',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Post post = Post(title: _titleTextEditingController.text, body: _bodyTextEditingController.text, userId: Random().nextInt(pow(2, 30) - 1));
                  CreatePostCubit().apiPostCreate(context, post.title, post.body);
                  _finish(context);
                },
                child: Text("create"),
              ),
            ],
          ),
        ),
      ),
      isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
    ],
  );
}