import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:reeno/models/sport_centre.dart';

class CentreImagesWidget extends StatefulWidget {
  final SportCentre sportCentre;

  const CentreImagesWidget(this.sportCentre, {Key? key}) : super(key: key);

  @override
  _CentreImagesWidgetState createState() => _CentreImagesWidgetState();
}

class _CentreImagesWidgetState extends State<CentreImagesWidget> {
  int currIndex = 0;
  GlobalKey<ScrollSnapListState> scrollSnapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final totalImages = widget.sportCentre.images?.length ?? 0;
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          ScrollSnapList(
            key: scrollSnapKey,
            itemBuilder: (context, index) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    widget.sportCentre.images![index],
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
                      return Center(
                        child: Text("Unable to Load Image"),
                      );
                    }),
                  ));
            },
            itemCount: totalImages,
            itemSize: MediaQuery.of(context).size.width,
            onItemFocus: (index) {
              setState(() {
                currIndex = index;
              });
            },
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.white.withOpacity(0.75)),
              child: Text("${currIndex + 1}/$totalImages"),
            ),
          ),
          if (currIndex != totalImages - 1)
            Positioned.fill(
              right: 5,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  onPressed: (() {
                    setState(() {
                      currIndex = currIndex + 1;
                      scrollSnapKey.currentState!.focusToItem(currIndex);
                    });
                  }),
                ),
              ),
            ),
          if (currIndex != 0)
            Positioned.fill(
              right: 5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  onPressed: (() {
                    setState(() {
                      currIndex = currIndex - 1;
                      scrollSnapKey.currentState!.focusToItem(currIndex);
                    });
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
