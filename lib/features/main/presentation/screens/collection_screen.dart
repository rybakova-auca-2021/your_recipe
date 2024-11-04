import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/features/main/presentation/widgets/collection_card.dart';
import 'package:your_recipe/router/app_router.dart';

import '../../../../../../core/colors.dart';
import '../../domain/usecase/view_collections_use_case.dart';
import '../bloc/collection_bloc/collection_bloc.dart';

@RoutePage()
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final _blocAllCollections = CollectionsBloc(
    GetIt.I<ViewCollectionsUseCase>(),
  );

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  Future<void> _loadCollections() async {
    _blocAllCollections.add(FetchCollectionsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () { Navigator.pop(context); },
            );
          },
        ),
        title: Text(
          "Curated Collections",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder<CollectionsBloc, CollectionsState>(
          bloc: _blocAllCollections,
          builder: (context, state) {
            if (state is CollectionsLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.orange));
            } else if (state is CollectionsLoaded) {
              return SizedBox(
                height: 220.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.collections.map((collection) {
                    return GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).push(DetailCollectionRoute(id: collection.id, title: collection.title));
                      },
                      child: CollectionCard(
                        title: collection.title,
                        imageUrl: collection.imageUrl,
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return const Center(child: Text('Failed to load collections'));
            }
          },
        ),
      ),
    );
  }
}
