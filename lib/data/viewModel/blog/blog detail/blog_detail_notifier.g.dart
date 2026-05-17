// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BlogDetailNotifier)
const blogDetailProvider = BlogDetailNotifierFamily._();

final class BlogDetailNotifierProvider
    extends $AsyncNotifierProvider<BlogDetailNotifier, BlogsDetailModel?> {
  const BlogDetailNotifierProvider._({
    required BlogDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'blogDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$blogDetailNotifierHash();

  @override
  String toString() {
    return r'blogDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BlogDetailNotifier create() => BlogDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is BlogDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$blogDetailNotifierHash() =>
    r'92a18abfd0c7c2d749bb33d1f81d4eb1a1f085e8';

final class BlogDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          BlogDetailNotifier,
          AsyncValue<BlogsDetailModel?>,
          BlogsDetailModel?,
          FutureOr<BlogsDetailModel?>,
          String
        > {
  const BlogDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'blogDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BlogDetailNotifierProvider call(String id) =>
      BlogDetailNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'blogDetailProvider';
}

abstract class _$BlogDetailNotifier extends $AsyncNotifier<BlogsDetailModel?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<BlogsDetailModel?> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<BlogsDetailModel?>, BlogsDetailModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BlogsDetailModel?>, BlogsDetailModel?>,
              AsyncValue<BlogsDetailModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(addBlogView)
const addBlogViewProvider = AddBlogViewFamily._();

final class AddBlogViewProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const AddBlogViewProvider._({
    required AddBlogViewFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'addBlogViewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$addBlogViewHash();

  @override
  String toString() {
    return r'addBlogViewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as String;
    return addBlogView(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AddBlogViewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addBlogViewHash() => r'87bd57239d9323a43c65a6764030d8307abdb99e';

final class AddBlogViewFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, String> {
  const AddBlogViewFamily._()
    : super(
        retry: null,
        name: r'addBlogViewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AddBlogViewProvider call({required String id}) =>
      AddBlogViewProvider._(argument: id, from: this);

  @override
  String toString() => r'addBlogViewProvider';
}

@ProviderFor(CreateBlogNotifier)
const createBlogProvider = CreateBlogNotifierProvider._();

final class CreateBlogNotifierProvider
    extends $AsyncNotifierProvider<CreateBlogNotifier, void> {
  const CreateBlogNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createBlogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createBlogNotifierHash();

  @$internal
  @override
  CreateBlogNotifier create() => CreateBlogNotifier();
}

String _$createBlogNotifierHash() =>
    r'5227c98460f4938a68084d98a78ff71e50b04950';

abstract class _$CreateBlogNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

@ProviderFor(SeeAuthorProfile)
const seeAuthorProfileProvider = SeeAuthorProfileFamily._();

final class SeeAuthorProfileProvider
    extends $AsyncNotifierProvider<SeeAuthorProfile, AuthorProfileModel> {
  const SeeAuthorProfileProvider._({
    required SeeAuthorProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'seeAuthorProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$seeAuthorProfileHash();

  @override
  String toString() {
    return r'seeAuthorProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SeeAuthorProfile create() => SeeAuthorProfile();

  @override
  bool operator ==(Object other) {
    return other is SeeAuthorProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$seeAuthorProfileHash() => r'b41d01e58385e544c02f0b58e6f9d4db840f4fc1';

final class SeeAuthorProfileFamily extends $Family
    with
        $ClassFamilyOverride<
          SeeAuthorProfile,
          AsyncValue<AuthorProfileModel>,
          AuthorProfileModel,
          FutureOr<AuthorProfileModel>,
          String
        > {
  const SeeAuthorProfileFamily._()
    : super(
        retry: null,
        name: r'seeAuthorProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SeeAuthorProfileProvider call(String authorID) =>
      SeeAuthorProfileProvider._(argument: authorID, from: this);

  @override
  String toString() => r'seeAuthorProfileProvider';
}

abstract class _$SeeAuthorProfile extends $AsyncNotifier<AuthorProfileModel> {
  late final _$args = ref.$arg as String;
  String get authorID => _$args;

  FutureOr<AuthorProfileModel> build(String authorID);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<AuthorProfileModel>, AuthorProfileModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthorProfileModel>, AuthorProfileModel>,
              AsyncValue<AuthorProfileModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UpdateMyPublishedBlog)
const updateMyPublishedBlogProvider = UpdateMyPublishedBlogProvider._();

final class UpdateMyPublishedBlogProvider
    extends $AsyncNotifierProvider<UpdateMyPublishedBlog, void> {
  const UpdateMyPublishedBlogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateMyPublishedBlogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateMyPublishedBlogHash();

  @$internal
  @override
  UpdateMyPublishedBlog create() => UpdateMyPublishedBlog();
}

String _$updateMyPublishedBlogHash() =>
    r'3d0331ab1ea02d4df370abaea4954858da9bf32e';

abstract class _$UpdateMyPublishedBlog extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

@ProviderFor(DeleteMyPublishedBlog)
const deleteMyPublishedBlogProvider = DeleteMyPublishedBlogProvider._();

final class DeleteMyPublishedBlogProvider
    extends $AsyncNotifierProvider<DeleteMyPublishedBlog, String?> {
  const DeleteMyPublishedBlogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteMyPublishedBlogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteMyPublishedBlogHash();

  @$internal
  @override
  DeleteMyPublishedBlog create() => DeleteMyPublishedBlog();
}

String _$deleteMyPublishedBlogHash() =>
    r'51d94892e9724e2044fbe2923c89c0d616495216';

abstract class _$DeleteMyPublishedBlog extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
