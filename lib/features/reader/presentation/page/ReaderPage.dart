import 'dart:async';

import 'package:Papyrus/core/widgets/AppError.dart';
import 'package:Papyrus/core/widgets/AppLoader.dart';
import 'package:Papyrus/core/widgets/LifecycleWatcher.dart';
import 'package:Papyrus/features/reader/presentation/bloc/ReaderBloc.dart';
import 'package:Papyrus/features/reader/presentation/widget/PdfView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/EpubViewWidget.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderBloc, ReaderState>(
      builder: (context, state) {
        if (state is ReaderLoading) {
          return AppLoader();
        }
        else if (state is ReaderPdfReady) {
          return pdfReader(context, state);
        }
        else if (state is ReaderEpubReady) {
          return epubReader(context, state);
        }
        else if (state is ReaderError) {
          return AppError();
        }
        return AppError();
      },
    );
  }

  Widget pdfReader(BuildContext context, ReaderPdfReady state) {
    return LifecycleWatcher(
      onPause: () async {
        final completer = Completer<void>();
        context.read<ReaderBloc>().add(ReaderClosingEvent(completer));
        await completer.future;
      },
      child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            final completer = Completer<void>();
            context.read<ReaderBloc>().add(ReaderClosingEvent(completer));
            await completer.future;
            if (context.mounted) Navigator.of(context).pop(true);
          },
          child: PdfViewWidget(
              path: state.path,
              initialPage: state.initialPage,
              onUpdateProgress: (currentPage) {
                context.read<ReaderBloc>().add(ReaderUpdateBookProgress(state.bookId, currentPage, null));
              }
          )
      ),
    );
  }
  Widget epubReader(BuildContext context, ReaderEpubReady state) {
    return LifecycleWatcher(
      onPause: () async {
        final completer = Completer<void>();
        context.read<ReaderBloc>().add(ReaderClosingEvent(completer));
        await completer.future;
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final completer = Completer<void>();
          context.read<ReaderBloc>().add(ReaderClosingEvent(completer));
          await completer.future;
          if (context.mounted) Navigator.of(context).pop(true);
        },
        child: EpubViewWidget(
          path: state.path,
          initialCfi: state.lastCfi,
          totalPages: state.totalPages,
          onUpdateProgress: (int currentPage, String cfi) {
            context.read<ReaderBloc>().add(
                ReaderUpdateBookProgress(state.bookId, currentPage, cfi)
            );
          },
        ),
      ),
    );
  }

}
