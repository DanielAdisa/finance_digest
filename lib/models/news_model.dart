class NewsModel {
  final String? image;
  final String source;
  final DateTime date;
  final String headline;
  final String url;

  NewsModel({
    required this.image,
    required this.source,
    required this.date,
    required this.headline,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      image: json['image'],
      source: json['source'],
      // Convert Unix timestamp (seconds) to DateTime
      date: DateTime.fromMillisecondsSinceEpoch(json['datetime'] * 1000),
      headline: json['headline'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'source': source,
        'datetime': date.millisecondsSinceEpoch ~/ 1000, // Convert DateTime back to seconds
        'headline': headline,
        'url': url,
      };
}