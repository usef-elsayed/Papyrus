import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/extensions/ColorExtension.dart';

class BookCardComponent extends StatelessWidget {
  final Function(String bookPath,String bookTitle) onTap;
  final Function(int id) onLongPress;
  final bool isSelected;
  final int bookId;
  final String bookPath;
  final String bookTitle;
  final String boomImagePath;
  const BookCardComponent({super.key, required this.isSelected, required this.bookId, required this.bookPath, required this.bookTitle, required this.boomImagePath, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () => {
                    onTap(bookPath,bookTitle)
                  },
                  onLongPress: () => onLongPress(bookId),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: HexColor.fromHex("#dbccbf"),
                                  width: 5
                              ),
                              top: BorderSide(
                                  color: HexColor.fromHex("#dbccbf"),
                                  width: 5
                              )
                          )
                      ),
                      child: Image(image: FileImage(File(boomImagePath))),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(bookTitle,style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1)
                  ),
              )
            ],
          ),
          if (isSelected)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 20, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}


