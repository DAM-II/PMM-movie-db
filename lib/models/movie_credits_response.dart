import 'models.dart';

class MovieCreditsResponse {
  final int id;
  final List<Cast> cast;

  MovieCreditsResponse({
    required this.id,
    required this.cast,
  });

  factory MovieCreditsResponse.fromJson(String str) =>
      MovieCreditsResponse.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory MovieCreditsResponse.fromMap(Map<String, dynamic> json) =>
      MovieCreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
      );

  // Map<String, dynamic> toMap() => {
  //       "id": id,
  //       "cast": List<dynamic>.from(cast.map((x) => x.toMap())),
  //       "crew": List<dynamic>.from(crew.map((x) => x.toMap())),
  //     };
}
