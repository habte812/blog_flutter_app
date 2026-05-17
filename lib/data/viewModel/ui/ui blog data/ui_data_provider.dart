import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/model/ui/create_blog_data_model.dart';
import 'package:tech_node/data/services/image%20services/image_processing_service.dart';

part 'ui_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UiDataProvider extends _$UiDataProvider {
  late final TextEditingController blogtitleController;
  late final TextEditingController blogCategoryController;
  late final QuillController blogContentController;
  late final TextEditingController hastagsController;

  @override
  CreateBlogDataModel build() {
    blogtitleController = TextEditingController();
    blogCategoryController = TextEditingController();
    hastagsController = TextEditingController();
    blogContentController = QuillController.basic();

    ref.onDispose(() {
      blogCategoryController.dispose();
      blogContentController.dispose();
      blogtitleController.dispose();
      hastagsController.dispose();
    });
    return const CreateBlogDataModel();
  }

  String _getBlogContent() {
    return jsonEncode(blogContentController.document.toDelta().toJson());
  }

  void setInitialData(BlogsDetailModel blog) {
    // 1. Update Text Controllers
    blogtitleController.text = blog.previewDatas.title;
    blogCategoryController.text = blog.previewDatas.category.id.toString();
    try {
      final doc = Document.fromJson(jsonDecode(blog.content));
      blogContentController.document = doc;
    } catch (e) {
      blogContentController.document = Document()..insert(0, blog.content);
    }
    final List<String> tags = blog.seos.metaKeywords.split(',');

    state = state.copyWith(
      blogCategory: blog.previewDatas.category.id.toString(),
      listOfHashtags: tags,
      hashtags: blog.seos.metaKeywords,
      editBlogId: blog.previewDatas.id,
      editThumbnailUrl: blog.previewDatas.thumbnail,
    );
  }

  void updateBlogCategory(String value) =>
      state = state.copyWith(blogCategory: value);

  void addBlogHashtags(String tags) {
    if (state.listOfHashtags.length < 6 &&
        !state.listOfHashtags.contains(tags)) {
      final newLists = [...state.listOfHashtags, tags];
      state = state.copyWith(
        listOfHashtags: newLists,
        hashtags: newLists.join(','),
      );
    }
  }

  void removeBlogHashtags(String tags) {
    final newlist = state.listOfHashtags.where((ta) => ta != tags).toList();
    state = state.copyWith(
      listOfHashtags: newlist,
      hashtags: newlist.join(','),
    );
  }

  Future<void> pickAndProcessBlogThumbnail() async {
    await ref
        .read(imageProcessingServiceProvider.notifier)
        .pickimageAndCrop(
          quality: 80,
          ratioX: 16,
          ratioY: 9,
          aspectRatio: CropAspectRatioPreset.ratio16x9,
        );
    final resultState = ref.read(imageProcessingServiceProvider);
    resultState.whenData((path) {
      if (path != null) {
        state = state.copyWith(blogThumbnailPath: path);
      }
    });
  }

  CreateBlogDataModel prepareDataForUpload() {
    return CreateBlogDataModel(
      blogTitle: blogtitleController.text.trim(),
      blogCategory: state.blogCategory,
      blogContent: _getBlogContent(),
      hashtags: state.hashtags,
      blogThumbnailPath: state.blogThumbnailPath,
    );
  }

  void resetAll() {
    blogtitleController.clear();
    blogCategoryController.clear();
    hastagsController.clear();
    blogContentController.document = Document();
    state = const CreateBlogDataModel();
  }
}
