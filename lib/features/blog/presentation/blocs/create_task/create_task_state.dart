part of 'create_task_bloc.dart';

enum Status {tagsLoading, stable, submitting, submitSuccessFul, submitListener, submitFailed}
class CreateTaskState extends Equatable {
  final Status status;
  final TitleInput title;
  final SubtitleInput subtitle;
  final List<String> tags;
  final List<String> selectedTags;
  final TagInput tag;
  final ContentInput content;
  io.File? image;
 final int changeIndicator ;
  CreateTaskState({
    this.title = const TitleInput.pure(),
    this.subtitle = const SubtitleInput.pure(),
    required this.tags,
    this.content = const ContentInput.pure(),
    this.tag = const TagInput.pure(),
    this.status = Status.stable,
    this.changeIndicator = 1,
    this.image,
    required this.selectedTags,
  });

  CreateTaskState copyWith({
    TitleInput? title,
    SubtitleInput? subtitle,
    List<String>? tags,
    List<String>? selectedTags,
    ContentInput? content,
    Status? status,
    TagInput? tag,
    int? changeIndicator,
    io.File? image,
  }) {
    return CreateTaskState(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      tags: tags ?? this.tags,
      content: content ?? this.content,
      tag: tag ?? this.tag,
      changeIndicator: changeIndicator ?? this.changeIndicator,
      status: status ?? this.status,
      selectedTags: selectedTags ?? this.selectedTags,
      image: image ?? this.image,
    );
  }
  @override
  List<Object?> get props => [title, subtitle, tags.length,tag, content, changeIndicator, status, image, selectedTags];
}