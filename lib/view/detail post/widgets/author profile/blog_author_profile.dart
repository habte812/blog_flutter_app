import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/widgets/follow_unfollow_author_profile.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';

class BlogAuthorProfile extends StatelessWidget {
  final BlogsDetailModel blogDetail;
  const BlogAuthorProfile({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: .center,
            children: [
              GestureDetector(
                onTap: () => context.push(
                  '/author-profile/${blogDetail.previewDatas.author.id}',
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: card,
                  backgroundImage:
                      blogDetail.previewDatas.author.profilePicture != null
                      ? CachedNetworkImageProvider(
                          blogDetail.previewDatas.author.profilePicture!,
                        )
                      : null,
                  child: blogDetail.previewDatas.author.profilePicture == null
                      ? const Icon(
                          LucideIcons.user,
                          color: Colors.white54,
                          size: 20,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(
                    '/author-profile/${blogDetail.previewDatas.author.id}',
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: CustomTextStyle(
                              text: blogDetail.previewDatas.author.name,
                              fontSize: 16,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (blogDetail.previewDatas.author.userRole ==
                                  'admin' ||
                              blogDetail.previewDatas.author.userRole ==
                                  'author') ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified_sharp,
                              color: Color(0xff137fec),
                              size: 14,
                            ),
                          ],
                          Consumer(
                            builder: (context, ref, child) {
                              final theAuthor = ref.watch(
                                seeAuthorProfileProvider(
                                  blogDetail.previewDatas.author.id.toString(),
                                ),
                              );
                              return theAuthor.when(
                                data: (data) {
                                  if (!data.isOwner) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: FollowUnfollowAuthorProfile(
                                        fromDetail: true,
                                        authorName: data.userName,
                                        authorId: data.id.toString(),
                                        initialState: data.isFollowing,
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                                error: (_, s) => const SizedBox.shrink(),
                                loading: () => CustomTextStyle(
                                  text: '       Loading...',
                                  fontSize: 14,
                                  textColor: context.primary,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisSize: .min,
                        children: [
                          CustomTextStyle(
                            text: blogDetail.previewDatas.publishedAt,
                            fontSize: 13,
                            textColor: Colors.white70,
                          ),
                          const Spacer(),
                          const Icon(
                            LucideIcons.eye,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          CustomTextStyle(
                            text: blogDetail.previewDatas.viewCount.toString(),
                            fontSize: 13,
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          CustomTextStyle(
                            text: blogDetail.shareCount.toString(),
                            fontSize: 13,
                          ),
                        ],
                      ),
                      if (blogDetail.previewDatas.updatedAt != null)
                        CustomTextStyle(
                          text:
                              "Updated at: ${blogDetail.previewDatas.updatedAt}",
                          fontSize: 13,
                          textColor: Colors.white70,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.1, endIndent: 20, indent: 20),
      ],
    );
  }
}
