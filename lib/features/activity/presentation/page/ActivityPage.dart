import 'package:Papyrus/core/widgets/AppError.dart';
import 'package:Papyrus/core/widgets/AppLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/Injection.dart';
import '../widget/ActivityBookItem.dart';
import '../../../library/domain/entity/BookEntity.dart';
import '../../../reader/presentation/bloc/ReaderBloc.dart';
import '../../../reader/presentation/page/ReaderPage.dart';
import '../cubit/ActivityCubit.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (blocContext, state) {
        if(state is ActivityLoading) {
          return AppLoader();
        }
        if(state is ActivityNoBooks) {
          return Center(
            child: Text("Start reading to track your journey.", style: Theme.of(context).textTheme.bodyLarge),
          );
        }
        if(state is ActivityLoaded) {
          return _buildBookCarousel(
            context,
            state.listOfBooks
          );
        }
        if(state is ActivityError) {
          return AppError();
        }
        return AppError();
      },
    );
  }

  Widget _buildBookCarousel(BuildContext context, List<BookEntity> books) {
    final PageController controller = PageController(viewportFraction: 0.70);

    return PageView.builder(
      controller: controller,
      itemCount: books.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final book = books[index];
        double progress = book.currentPage / book.totalPages;
        return ActivityBookItem(
          book: book,
          progress: progress,
          onTap: () async {
            await Future.delayed(Duration.zero);
            if (!context.mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => getIt<ReaderBloc>()..add(ReaderLoadBook(book)),
                  child: const ReaderPage(),
                ),
              ),
            );
            if (context.mounted) {
              context.read<ActivityCubit>().loadLastAccessedBooks();
            }
          },
        );
      },
    );
  }

}
