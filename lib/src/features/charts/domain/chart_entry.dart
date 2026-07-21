class ChartEntry {
  const ChartEntry({
    required this.id,
    required this.name,
    required this.artistName,
    required this.artworkUrl,
    required this.url,
    required this.releaseDate,
    required this.genres,
  });

  factory ChartEntry.fromJson(Map<String, dynamic> json) {
    return ChartEntry(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown title',
      artistName: json['artistName'] as String? ?? 'Unknown artist',
      artworkUrl: json['artworkUrl100'] as String? ?? '',
      url: json['url'] as String? ?? '',
      releaseDate: DateTime.tryParse(json['releaseDate'] as String? ?? ''),
      genres: (json['genres'] as List<dynamic>? ?? const [])
          .map((genre) => genre['name'] as String? ?? '')
          .where((genre) => genre.isNotEmpty)
          .toList(growable: false),
    );
  }

  final String id;
  final String name;
  final String artistName;
  final String artworkUrl;
  final String url;
  final DateTime? releaseDate;
  final List<String> genres;
}
