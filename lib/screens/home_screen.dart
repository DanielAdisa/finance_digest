import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/news_card.dart';
import '../widgets/error_widget.dart';
import '../models/news_model.dart';
import 'news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NewsModel>> newsFuture;

  @override
  void initState() {
    super.initState();
    newsFuture = ApiService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finance Digest"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for news...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<NewsModel>>(
              future: newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Show loading indicator
                } else if (snapshot.hasError) {
                  return ErrorMessageWidget(message: snapshot.error.toString()); // Error message widget
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const ErrorMessageWidget(message: "No news available."); // No data state
                } else {
                  final newsList = snapshot.data!;
                  return ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final news = newsList[index];
                      return NewsCard(
                        news: news,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailsScreen(news: news),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
