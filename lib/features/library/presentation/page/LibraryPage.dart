import 'package:Papyrus/core/di/Injection.dart';
import 'package:Papyrus/core/widgets/AppError.dart';
import 'package:Papyrus/core/widgets/AppLoader.dart';
import 'package:Papyrus/features/library/presentation/widget/BookCardComponent.dart';
import 'package:Papyrus/features/reader/presentation/bloc/ReaderBloc.dart';
import 'package:Papyrus/features/reader/presentation/page/ReaderPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/enums/SortOption.dart';
import '../bloc/LibraryBloc.dart';
import '../widget/AddBookDialog.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // General padding
      child: _buildLibraryContent(context)
    );
  }

  Future<void> _onAddPressed(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'epub'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      if (!context.mounted) return;

      final String? bookName = await showDialog<String>(
        context: context,
        builder: (dialogContext) => AddBookDialog(defaultName: result.files.single.name),
      );
      if (bookName != null && bookName.isNotEmpty && context.mounted) {
        context.read<LibraryBloc>().add(
            LibraryAddBook(filePath: filePath, title: bookName)
        );
      }
    }
  }

  Widget _buildActionBar(BuildContext context, LibraryState state) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final isSelectionMode = state is LibraryLoaded && state.isSelectionMode;
    final selectedCount = state is LibraryLoaded ? state.selectedIds.length : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        if (isSelectionMode)
          TextButton.icon(
            onPressed: () {
              context.read<LibraryBloc>().add(LibraryClearSelection());
            },
            style: TextButton.styleFrom(
              foregroundColor: colors.onSurface,
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.close, size: 20),
            label: Text(
              "Cancel ($selectedCount)",
              style: textStyle.bodyLarge,
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 1,
              ),
            ),
          )
        else
          TextButton.icon(
            onPressed: () => {
              if(state is LibraryLoaded || state is LibraryNoBooks) {
                _onAddPressed(context)
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: colors.onSurface,
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.add, size: 20),
            label: Text(
              "Add",
              style: textStyle.bodyLarge,
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 1,
              ),
            ),
          ),

        if (isSelectionMode)
          TextButton.icon(
            onPressed: () {
              context.read<LibraryBloc>().add(LibraryDeleteSelected());
            },
            style: TextButton.styleFrom(
              foregroundColor: colors.onSurface,
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.delete, size: 20),
            label: Text(
              "Delete",
              style: textStyle.bodyLarge,
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 1,
              ),
            ),
          )
        else
          TextButton.icon(
            onPressed: () => {
              if(state is LibraryLoaded || state is LibraryNoBooks) {
                _showFilterSheet(context)
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: colors.onSurface,
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.filter_list, size: 20),
            label: Text(
              "Filter",
              style: textStyle.bodyLarge,
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 1,
              ),
            ),
          )
      ],
    );
  }

  Widget _buildLibraryContent(BuildContext buildContext) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 16),
            _buildActionBar(context, state),
            const SizedBox(height: 16),
            Expanded(
                child: blocBody(context, state)
            )
          ],
        );
      },
    );
  }

  Widget blocBody(BuildContext context, LibraryState state) {
    if (state is LibraryLoading) {
      return const AppLoader();
    }

    else if (state is LibraryLoaded) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: state.listOfBooks.length,
        itemBuilder: (context, index) {
          final book = state.listOfBooks[index];
          final isSelected = state.selectedIds.contains(book.id);
          return BookCardComponent(
              bookId: book.id,
              bookPath: book.path,
              bookTitle: book.title,
              boomImagePath: book.coverPath,
              isSelected: isSelected,
              onLongPress: (int bookId) async {
                context.read<LibraryBloc>().add(LibraryToggleSelection(bookId));
              },
              onTap: (String bookPath, String bookTitle) async {
                await Future.delayed(Duration.zero);
                if (!context.mounted) return;

                if(state.isSelectionMode){
                  context.read<LibraryBloc>().add(LibraryToggleSelection(book.id));
                  return;
                }

                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => getIt<ReaderBloc>()..add(ReaderLoadBook(book)),
                      child: const ReaderPage(),
                    ),
                  ),
                );
                if (context.mounted) {
                  context.read<LibraryBloc>().add(LibraryLoadBooks());
                }
              });
        },
      );
    }

    else if (state is LibraryNoBooks) {
      return Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: Text(
            "No books yet.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    else if (state is LibraryError) {
      return AppError();
    }

    return AppError();
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  "Sort Library",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),

              // Sort Options
              _buildFilterOption(context, "Recently Opened", Icons.history, SortOption.recent),
              _buildFilterOption(context, "Title (A-Z)", Icons.sort_by_alpha, SortOption.title),
              _buildFilterOption(context, "Date Added (Newest)", Icons.calendar_today, SortOption.newest),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(BuildContext context, String title, IconData icon, SortOption option) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
          strutStyle: StrutStyle(
            forceStrutHeight: true,
            height: 1,
          )
      ),
      onTap: () {
        context.read<LibraryBloc>().add(LibrarySortBooks(option));
        Navigator.pop(context);
      },
    );
  }

}
