/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/reusable_fab.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/community/PostBlocs/post_bloc.dart';
import 'package:petsica/features/community/PostBlocs/post_event.dart';
import 'package:petsica/features/community/PostBlocs/post_state.dart';
import 'package:petsica/features/community/widgets/post_container.dart';
import 'package:petsica/features/community/widgets/publish_post_body.dart';
import 'package:petsica/features/profiles/where.dart';
import 'package:petsica/features/who/presentation/views/who.dart';

// Dummy profile page placeholder
class YourProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile')),
      body: const Center(child: Text('Profile Page')),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late final PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = PostBloc();
    _postBloc.add(FetchPosts()); // Fetch posts on first load
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _postBloc.close(); // Close bloc to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postBloc,
      child: Scaffold(
        appBar: 
      AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 90,
    title: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AssetData.splashImage,
              height: 80,
            ),
          ],
        ),
        const SizedBox(height: 10)
      ],
    ),
  ),


       
        body: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => WhereProf()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(AssetData.profileIcon),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PostPage()),
                        );
                        if (result == true) {
                          _postBloc.add(FetchPosts()); // Re-fetch after post
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          "What's on your mind?",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<PostBloc, PostState>(
                listener: (context, state) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                  if (state.deleteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✅ Post deleted!')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.posts.isEmpty) {
                    return const Center(child: Text('No posts available.'));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      _postBloc.add(FetchPosts());
                    },
                    child: ListView.builder(
                      key: const Key('postListView'),
                      controller: _scrollController,
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return PostCard(
                          key: ValueKey(post.postId),
                          post: post,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: const ReusableFAB(), // Use the reusable FAB
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/reusable_fab.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/community/PostBlocs/post_bloc.dart';
import 'package:petsica/features/community/PostBlocs/post_event.dart';
import 'package:petsica/features/community/PostBlocs/post_state.dart';
import 'package:petsica/features/community/widgets/post_container.dart';
import 'package:petsica/features/community/widgets/publish_post_body.dart';
import 'package:petsica/features/profiles/where.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late final PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = PostBloc();
    _postBloc.add(FetchPosts()); // Fetch posts on first load
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _postBloc.close(); // Close bloc to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postBloc,
      child: Scaffold(
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
            if (state.deleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Post deleted!')),
              );
            } 
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                _postBloc.add(FetchPosts());
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // ✅ SliverAppBar
                 SliverAppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  pinned: true,
  floating: true,
  centerTitle: true,
  title: Text(
    'P E T S I C A',
    style: Styles.textStyleCom32.copyWith(color: kBurgColor),
  ),
),
// كويس

                  // ✅ محتوى البوستات وغيره
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => WhereProf()),
                                  );
                                },
                                child: const CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      AssetImage(AssetData.profileIcon),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const PostPage()),
                                    );
                                    if (result == true) {
                                      _postBloc.add(FetchPosts());
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: const Text(
                                      "What's on your mind?",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // ✅ قائمة البوستات
                  if (state.isLoading)
                    SliverToBoxAdapter(
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else if (state.posts.isEmpty)
                    SliverToBoxAdapter(
                      child: const Center(child: Text('No posts available.')),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = state.posts[index];
                          return PostCard(
                            key: ValueKey(post.postId),
                            post: post,
                          );
                        },
                        childCount: state.posts.length,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: const ReusableFAB(),
      ),
    );
  }
}
