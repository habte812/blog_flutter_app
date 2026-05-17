
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/report%20blog/report_blog_model.dart';
import 'package:tech_node/data/repository/report%20blog/report_blog_repository.dart';

part 'report_blog_notifier.g.dart';


@riverpod
class  ReportBlogNotifier  extends _$ReportBlogNotifier {
    @override
  FutureOr<String?> build() {return null;}

  Future<String> reportBlog({required ReportBlogModel data}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
     final  res = await  ref
          .read(reportBlogRepositoryProvider)
          .reportblog(reportData: data);
          return res;
    });
     
      return "Something went wrong";
  }
}