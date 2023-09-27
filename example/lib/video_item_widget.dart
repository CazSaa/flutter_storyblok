import 'package:example/bloks.generated.dart' as bloks;
import 'package:example/components/colors.dart';
import 'package:example/components/text.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storyblok/link_type.dart';

class VideoItemWidget extends StatelessWidget {
  final Uri thumbnailUrl;
  final String title;
  final String? description;
  final WidgetBuilder videoPageBuilder;
  final bool small;
  final bool portrait;

  const VideoItemWidget(
      {super.key,
      required this.thumbnailUrl,
      required this.title,
      required this.description,
      required this.small,
      required this.portrait,
      required this.videoPageBuilder});

  factory VideoItemWidget.fromVideoItem(bloks.VideoItem videoItem, [bool small = false, bool portrait = false]) {
    final linkedVideoPage =
        (bloks.Blok.fromJson((videoItem.videoLink as LinkTypeStory).resolvedStory!.content) as bloks.VideoPage);
    return VideoItemWidget(
      thumbnailUrl: (linkedVideoPage.videoThumbnail as LinkTypeURL).url,
      title: (videoItem.title != null && videoItem.title!.isNotEmpty) ? videoItem.title! : linkedVideoPage.videoTitle,
      description: small
          ? null
          : videoItem.description != null && videoItem.description!.isNotEmpty
              ? videoItem.description!
              : linkedVideoPage.videoDescription,
      videoPageBuilder: (context) => linkedVideoPage.buildWidget(context),
      small: small,
      portrait: portrait,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: videoPageBuilder),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.shade800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: portrait ? 9 / 16 : 16 / 9,
                child: Image.network(thumbnailUrl.toString(), fit: portrait ? BoxFit.cover : BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextATV.subtitle(
                    title,
                  ),
                  if (description != null)
                    Column(
                      children: [
                        const Divider(),
                        TextATV.body(
                          description!,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
