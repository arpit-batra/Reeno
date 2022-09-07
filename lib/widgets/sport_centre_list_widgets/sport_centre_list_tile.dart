import 'package:flutter/material.dart';
import 'package:reeno/widgets/loading_widget.dart';

class SportCentreListTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const SportCentreListTile(
      {required this.title, required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(12)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: ((context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: (loadingProgress != null)
                          ? (loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!)
                          : 0,
                    ),
                  );
                }),
                errorBuilder: ((context, error, stackTrace) {
                  return Center(child: Text("Unable to Load Image"));
                }),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 255, 255, 255),
                      Color.fromARGB(1023, 0, 0, 0),
                    ],
                    begin: Alignment(0.0, -0.25),
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  right: 15,
                  child: SizedBox(
                    width: constraints.constrainWidth() * (3 / 4),
                    child: Text(
                      title,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    }));
  }
}
