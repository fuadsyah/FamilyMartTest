// To parse this JSON data, do
//
//     final movieReviewModel = movieReviewModelFromJson(jsonString);

// 🎯 Dart imports:
import 'dart:convert';

ReviewModel movieReviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String movieReviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  int id;
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  ReviewModel({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"],
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  String author;
  AuthorDetails authorDetails;
  String content;
  String createdAt;
  String id;
  String updatedAt;
  String url;

  Result({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    author: json["author"],
    authorDetails: AuthorDetails.fromJson(json["author_details"]),
    content: json["content"],
    createdAt: json["created_at"],
    id: json["id"],
    updatedAt: json["updated_at"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "author_details": authorDetails.toJson(),
    "content": content,
    "created_at": createdAt,
    "id": id,
    "updated_at": updatedAt,
    "url": url,
  };
}

class AuthorDetails {
  String name;
  String username;
  String? avatarPath;
  String? rating;

  AuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
    name: json["name"],
    username: json["username"],
    avatarPath: json["avatar_path"],
    rating: json["rating"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "avatar_path": avatarPath,
    "rating": rating,
  };
}
