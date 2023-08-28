
import 'package:blog_application/features/blog/domain/repositories/article_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

import 'package:blog_application/core/usecases/usecase.dart';
import 'package:blog_application/features/blog/domain/usecases/get_tags.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'create_task_formfields.dart';
part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit({required this.getTagsUsecase, required this.articleRepository}) : super(CreateTaskState(tags: const <String>[], selectedTags: const  <String>[]));
  GetTags getTagsUsecase;
  ArticleRepository articleRepository;
  void fetchTags() async{
    emit(state.copyWith(
      status: Status.tagsLoading,
    ));
    var res = await getTagsUsecase(NoParams());
    res.fold((l)=>null, (r)=> emit(state.copyWith(
      status: Status.stable,
      tags: r
    )));
  }
  void titleChanged(String value) {
    final title = TitleInput.dirty(value);
    emit(state.copyWith(
      title: title,
    ));
    print(state);
  }
  void onImageChanged(io.File? image) {
    print(image);
    print("jsdfhskjfs");
    emit(state.copyWith(
      image: image,
    ));
  }
  void subtitleChanged(String value) {
    final subtitle = SubtitleInput.dirty(value);
    emit(state.copyWith(
      subtitle: subtitle,
    ));
  }
  void addOrRemoveTag(String tag){
    final tags = [...state.selectedTags];
    if(state.selectedTags.contains(tag)){
      tags.remove(tag);
    } else {
      tags.add(tag);
    }
    emit(state.copyWith(
      selectedTags: tags
    ));
  }
  void contentChanged(String value) {
    final content = ContentInput.dirty(value);
    emit(state.copyWith(
      content: content,
    ));
  }

  void tagChanged(String value) {
    final tag = TagInput.dirty(value);
    emit(state.copyWith(
      tag: tag,
    ));
  }

  void removeTag(int index) {
    final tags = state.tags;
    tags.removeAt(index);
    emit(state.copyWith(
      tags: tags,
      changeIndicator: state.changeIndicator + 1,
    ));
  }

  void addTag() {
    final tag = TagInput.dirty(state.tag.value);
    final index = state.tags.indexOf(tag.value);
    if (tag.isValid && index == -1) {
      final tags = state.tags;
      tags.add(tag.value);
      emit(state.copyWith(
        tags: tags,
        tag: const TagInput.pure(),
      ));
    }
  }
    void publish() async {
      emit(state.copyWith(
        status: Status.submitting
      ));
      final title = TitleInput.dirty(state.title.value);
      final subtitle = SubtitleInput.dirty(state.subtitle.value);
      final content = ContentInput.dirty(state.content.value);
      final tags = state.tags;
      final tag = TagInput.dirty(state.tag.value);
      if(state.image == null) print("null value");
      if(title.isValid && subtitle.isValid && content.isValid  && state.image != null) {
        print("called");
        await articleRepository.createArticle(content: content.value, title: title.value, subTitle: subtitle.value, tags: state.selectedTags, image: state.image).then((value) => value.fold((l) => emit(state.copyWith(
          status: Status.submitFailed
        )), (r) => emit(state.copyWith(
          status: Status.submitSuccessFul
        ))));
        
      }

    }
  }
