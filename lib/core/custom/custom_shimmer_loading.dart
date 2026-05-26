import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:tech_node/core/constants/themes.dart';

class CustomShimmerLoading extends StatelessWidget {
  const CustomShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(
          height: 330,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const TodayFeaturedBlogShimmer();
            },
          ),
        ),
        ListView.builder(
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const FeedsListCardShimmer();
          },
        ),
      ],
    );
  }
}

class TodayFeaturedBlogShimmer extends StatelessWidget {
  const TodayFeaturedBlogShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Shimmer.fromColors(
        baseColor: card,
        highlightColor: card.withValues(alpha: 0.1),
        child: Padding(
          padding: const .only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: .circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: .circular(4),
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: .circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: .circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: .circular(4),
                ),
              ),
              const SizedBox(height: 9),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 100,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedsListCardShimmer extends StatelessWidget {
  const FeedsListCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: card,
      highlightColor: card.withValues(alpha: 0.1),
      child: Container(
        height: 138,
        margin: const .only(left: 16, right: 16, bottom: 10),
        padding: const .all(12),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),

                  Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 80,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingCategoryShimmer extends StatelessWidget {
  const TrendingCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const .all(16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Shimmer.fromColors(
            baseColor: card,
            highlightColor: card.withValues(alpha: 0.1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: .circular(6),
              ),
            ),
          );
        }, childCount: 6),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
      ),
    );
  }
}

class DetailPostShimmer extends StatelessWidget {
  const DetailPostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: card,
      highlightColor: card.withValues(alpha: 0.1),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(color: Colors.black),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 110,
                        height: 39,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: .circular(6),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: .circular(6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                  Container(
                    margin: const .only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomUserProfileShimmer extends StatelessWidget {
  const CustomUserProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Shimmer.fromColors(
        baseColor: card,
        highlightColor: card.withValues(alpha: 0.3),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(radius: 45, backgroundColor: Colors.black),
            const SizedBox(height: 10),
            Container(
              height: 25,
              width: 200,
              decoration: const BoxDecoration(color: Colors.black),
            ),
            const SizedBox(height: 10),
            Container(
              height: 15,
              width: MediaQuery.of(context).size.width * 0.7,

              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: .circular(6),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 15,
              width: MediaQuery.of(context).size.width * 0.5,

              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: .circular(6),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: .spaceAround,

              children: [
                Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: .circular(6),
                  ),
                ),
                Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: .circular(6),
                  ),
                ),
                Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: .circular(6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCommentShimmerLoading extends StatelessWidget {
  const CustomCommentShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: card,
          highlightColor: card.withValues(alpha: 0.3),
          child: Column(
            children: [
              Padding(
                padding: const .symmetric(vertical: 8.0, horizontal: 8),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: .circular(6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: .circular(6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FollowingsListShimmer extends StatelessWidget {
  const FollowingsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: card,
            highlightColor: card.withValues(alpha: 0.1),
            child: Padding(
              padding: const .symmetric(horizontal: 8),
              child: Column(
                children: [
                  const CircleAvatar(radius: 30, backgroundColor: Colors.black),
                  const SizedBox(height: 8),
                  Container(
                    height: 15,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: .circular(5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
