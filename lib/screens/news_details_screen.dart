import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsModel news;

  const NewsDetailsScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Details")),
      body: SingleChildScrollView(  // Wrap the body with a scrollable view
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Hero(
  tag: news.headline,
  child: news.image != null
      ? Image.network(
          news.image!,
          width: double.infinity,
          height: 250,  // Adjust the height to your liking
          fit: BoxFit.cover,
        )
      : Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
  news.headline,
  style: Theme.of(context).textTheme.displayLarge, // Replaces headline1
),

                  const SizedBox(height: 8),
                  Text(
                    news.source,
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final uri = Uri.parse(news.url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    child: const Text("Read Full Article"),
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
