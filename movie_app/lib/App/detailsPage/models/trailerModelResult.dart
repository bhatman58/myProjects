class TrailerModelResult {
  String? name;
  String? key;
  String? publishedAt;
  String? site;
  String? type;
  bool? official;

  TrailerModelResult({
    this.name,
    this.key,
    this.publishedAt,
    this.site,
    this.type,
    this.official,
  });

  factory TrailerModelResult.fromJson(Map<String, dynamic> json) =>
      TrailerModelResult(
        name: json["name"],
        key: json["key"],
        publishedAt: json["published_at"],
        site: json["site"],
        type: json["type"],
        official: json["official"],
      );
}
