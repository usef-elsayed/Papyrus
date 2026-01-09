import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../library/domain/entity/BookEntity.dart';

class ActivityBookItem extends StatelessWidget {

  final BookEntity book;
  final double progress;
  final VoidCallback onTap;

  const ActivityBookItem({super.key, required this.book, required this.progress, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildTiltedEffectShape(context),
                _buildBookCoverImage(),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Text(
            book.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: 200,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                    color: Theme.of(context).colorScheme.onSurface,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildBookCoverImage() {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 8),
              spreadRadius: 1,
            ),
          ],
          image: DecorationImage(
            image: FileImage(File(book.coverPath!)), // Change to FileImage if needed
            fit: BoxFit.cover,
          ),
        ),
        child: Material(
          color: Colors.transparent, // Must be transparent to see the image behind
          borderRadius: BorderRadius.circular(20), // Clip ripple to corners
          clipBehavior: Clip.antiAlias, // Ensures smooth edges
          child: InkWell(
            onTap: onTap, // Trigger the callback
            highlightColor: Colors.white.withOpacity(0.1), // Optional: Subtle effect
            splashColor: Colors.white.withOpacity(0.2),    // Optional: Subtle effect
          ),
        ),
      ),
    );
  }

  Widget _buildTiltedEffectShape(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Transform.rotate(
        angle: 0.25,
        child: Transform.scale(
          scale: 0.90,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
