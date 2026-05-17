import 'package:share_plus/share_plus.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';

class SharePostTo {
  static void shareBlogPost(BlogsDetailModel post) {
    final shareUri = Uri(
      scheme: 'http',
      host: '192.168.0.184',
      port: 8080,
      path: '/detail-posts/${post.previewDatas.id}',
      queryParameters: {
        'published_at':
            "${post.slug}/${post.previewDatas.publishedAt.split('T').first}",
        'author': post.previewDatas.author.name,
      },
    );
    SharePlus.instance.share(
      ShareParams(
        text:
            '${shareUri.toString()}\n\n"${post.previewDatas.title}"\n${post.previewDatas.excerpt}',

        previewThumbnail: post.previewDatas.thumbnail != null
            ? XFile(post.previewDatas.thumbnail!)
            : null,
      ),
    );
  }

  static void shareOfflineBlog(OfflineBlogsModel post) {
    final shareUri = Uri(
      scheme: 'http',
      host: '192.168.0.184',
      port: 8080,
      path: '/detail-posts/${post.id}',
      queryParameters: {
        'published_at': "${post.slug}/${post.publishedAt.split('T').first}",
        'author': post.authorName,
      },
    );
    SharePlus.instance.share(
      ShareParams(
        text: '${shareUri.toString()}\n\n"${post.title}"\n${post.excerpt}',

        previewThumbnail: post.thumbnail != null
            ? XFile(post.thumbnail!)
            : null,
      ),
    );
  }
}
