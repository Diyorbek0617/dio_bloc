import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio_bloc/blocs/update_post_cubit.dart';
import 'package:dio_bloc/blocs/update_post_state.dart';
import 'package:dio_bloc/model/post_model.dart';
import 'package:dio_bloc/views/view_of_update.dart';

class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  String title, body;
  UpdatePage({this.title, this.body, Key key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isLoading = false;
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _bodyTextEditingController = TextEditingController();

  _finish(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, 'result');
    });
  }

  @override
  void initState() {
    super.initState();

    _titleTextEditingController.text = widget.title;
    _bodyTextEditingController.text = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update post'),
          centerTitle: true,
        ),
        body: BlocBuilder<UpdatePostCubit, UpdatePostState> (
          builder: (BuildContext context, UpdatePostState state) {
            if (state is UpdatePostLoading) {
              return viewOfUpdate(context,_titleTextEditingController, _bodyTextEditingController, isLoading);
            }
            if (state is UpdatePostLoaded) {
              _finish(context);
            }
            if (state is UpdatePostError) {

            }
            return viewOfUpdate(context,_titleTextEditingController, _bodyTextEditingController, isLoading);
          },
        ),
      ),
    );
  }
}