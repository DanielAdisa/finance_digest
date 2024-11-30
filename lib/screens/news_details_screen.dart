import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsModel news;

  const NewsDetailsScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // News Image with a Hero animation
            Hero(
              tag: news.headline,
              child: news.image != null
                  ? Image.network(
                      news.image!,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/placeholder.png',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 16),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Headline
                  Text(
                    news.headline,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),

                  // Source and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        news.source,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${news.date.toLocal()}".split(' ')[0],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description Section (Optional Placeholder)
                  Text(
                    "Discover the full story behind this headline. Click the button below to dive deeper into this article.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey[800],
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Read Full Article Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse(news.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.blueAccent, // Replace 'primary' with 'backgroundColor'
                        padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        ),
                      elevation: 5,
                      ),

                      icon: const Icon(Icons.open_in_browser, color: Colors.white),
                      label: const Text(
                        "Read Full Article",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
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
