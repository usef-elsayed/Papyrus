import 'package:Papyrus/core/di/Injection.dart';
import 'package:Papyrus/features/activity/presentation/cubit/ActivityCubit.dart';
import 'package:Papyrus/features/activity/presentation/page/ActivityPage.dart';
import 'package:Papyrus/features/homeLayout/presentation/cubit/HomeLayoutCubit.dart';
import 'package:Papyrus/features/library/presentation/bloc/LibraryBloc.dart';
import 'package:Papyrus/features/library/presentation/page/LibraryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutPage extends StatelessWidget {

  const HomeLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ActivityCubit>()..loadLastAccessedBooks(),
        ),
        BlocProvider(
          create: (_) => getIt<LibraryBloc>()..add(LibraryLoadBooks()),
        ),
      ],
      child: const _HomeLayoutView(),
    );
  }

}

class _HomeLayoutView extends StatelessWidget {

  const _HomeLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return homeLayout(context);
  }

  Widget homeLayout(BuildContext context) {
    final currentIndex = context.select((HomeLayoutCubit cubit) => cubit.state.index);
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          topSegmentedSwitch(
              context: context,
              currentIndex: currentIndex,
              onTabSelected: (index) {
                if (index == 0) {
                  context.read<HomeLayoutCubit>().switchToActivity();
                  context.read<ActivityCubit>().loadLastAccessedBooks();
                }else {
                  context.read<HomeLayoutCubit>().switchToLibrary();
                  context.read<LibraryBloc>().add(LibraryLoadBooks());
                }
              }
          ),
          Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: [
                  ActivityPage(),
                  LibraryPage(),
                ],
              )
          )
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Center(
        child: Text("Papyrus"),
      ),
    );
  }

  Widget topSegmentedSwitch({
    required BuildContext context,
    required int currentIndex,
    required Function(int index) onTabSelected,
  }) {
    const double height = 50.0;
    const double borderRadius = 25.0;

    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = colorScheme.surfaceContainerHighest;
    final indicatorColor = colorScheme.primary;
    final selectedTextColor = colorScheme.onPrimary;
    final unselectedTextColor = colorScheme.onSurfaceVariant;

    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 16, left: 24, bottom: 16, right: 24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: currentIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1.0,
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              _buildTabItem(
                title: "Activity",
                isSelected: currentIndex == 0,
                onTap: () => onTabSelected(0),
                selectedColor: selectedTextColor,
                unselectedColor: unselectedTextColor,
              ),
              _buildTabItem(
                title: "Library",
                isSelected: currentIndex == 1,
                onTap: () => onTabSelected(1),
                selectedColor: selectedTextColor,
                unselectedColor: unselectedTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 16,
              fontFamily: 'system',
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }

}
