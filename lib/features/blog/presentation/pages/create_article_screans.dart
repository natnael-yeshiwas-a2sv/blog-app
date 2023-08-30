import 'dart:io';

import 'package:blog_application/features/blog/presentation/blocs/create_task/create_task_bloc.dart';
import 'package:blog_application/features/blog/presentation/widgets/search_drop.dart';
import 'package:blog_application/features/blog/presentation/widgets/select_image.dart';
import 'package:blog_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen({super.key});
  final ScrollController? _scrollController = ScrollController();
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return BlocProvider(
      create: (context) => sl<CreateTaskCubit>()..fetchTags(),
      child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              centerTitle: true,
              leading: Container(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(6.0)),
                        minimumSize:
                            MaterialStateProperty.all(const Size(0, 0)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ))),
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.of(context).pop()),
              ),
              title: const Text('New Article')),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocConsumer<CreateTaskCubit, CreateTaskState>(
                  listener: (context, state) {
                if (state.status == Status.submitFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('failed to submit article')));
                } else if (state.status == Status.submitSuccessFul) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('article submitted successfully')));
                  Navigator.of(context).pop();
                }
              }, builder: (context, state) {
                inputDecoration(String val, [String? error]) => InputDecoration(
                      errorText: error,
                      hintText: val,
                      hintStyle: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w300,
                      ),
                    );
                var contentFieldDecoration = InputDecoration(
                    errorText: state.content.displayError == null
                        ? null
                        : state.content.displayError!.message,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    hintText: 'Add Content',
                    hintStyle: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ));
                return Form(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          key: const Key("add_title"),
                          onChanged: (val) {
                            context.read<CreateTaskCubit>().titleChanged(val);
                          },
                          controller: titleController,
                          decoration: inputDecoration(
                              "Add Title",
                              state.title.displayError == null
                                  ? null
                                  : state.title.displayError!.message),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          key: const Key('add_subtitle'),
                          controller: subtitleController,
                          onChanged: (val) {
                            context
                                .read<CreateTaskCubit>()
                                .subtitleChanged(val);
                          },
                          decoration: inputDecoration(
                              "Add Subtitle",
                              state.subtitle.displayError == null
                                  ? null
                                  : state.subtitle.displayError!.message),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'add as many tags as you want',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xFF969DA4),
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Column(children: [
                          Wrap(
                            spacing: 4,
                            children: [
                              ...state.tags.map((tag) {
                                return ChoiceChip(
                                    label: Text(tag),
                                    onSelected: (val) {
                                      context
                                          .read<CreateTaskCubit>()
                                          .addOrRemoveTag(tag);
                                    },
                                    side: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    selected: state.selectedTags.contains(tag),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(75),
                                    ));
                              })
                            ],
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        SelectImage(
                          onSelected: (File? file) {
                            context
                                .read<CreateTaskCubit>()
                                .onImageChanged(file);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            onChanged: (val) {
                              context
                                  .read<CreateTaskCubit>()
                                  .contentChanged(val);
                            },
                            textAlignVertical: TextAlignVertical.top,
                            expands: true,
                            minLines: null,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: contentFieldDecoration,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
            child: FilledButton(
                onPressed: state.status == Status.submitting
                    ? null
                    : () {
                        context.read<CreateTaskCubit>().publish();
                      },
                child: state.status == Status.submitting
                    ? CircularProgressIndicator()
                    : Text('publish',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  String title;
  // define a function variable onDelete
  final void Function()? onDelete;
  TagChip({
    super.key,
    required this.title,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      side: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary),
      label: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(75),
      ),
      deleteIcon: Icon(
        Icons.close,
        color: Theme.of(context).colorScheme.primary,
      ),
      onDeleted: onDelete,
    );
  }
}
