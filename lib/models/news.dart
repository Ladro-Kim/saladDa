class News {
  String status;
  int totalResults;
  List<Articles> articles;

  News({this.status, this.totalResults, this.articles});

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles(
      {this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

// {
// "status": "ok",
// "totalResults": 38,
// -"articles": [
// -{
// -"source": {
// "id": "cnn",
// "name": "CNN"
// },
// "author": "Ray Sanchez, Blake Ellis and Amir Vera, CNN",
// "title": "Here's what we know about the Boulder, Colorado, mass shooting suspect - CNN",
// "description": "Ahmad Al Aliwi Alissa was identified by authorities Tuesday as the gunman who opened fire at a King Soopers grocery store in Colorado, killing 10 people, including a Boulder police officer.",
// "url": "https://www.cnn.com/2021/03/23/us/boulder-colorado-shooting-suspect/index.html",
// "urlToImage": "https://cdn.cnn.com/cnnnext/dam/assets/210323154126-ahmad-al-aliwi-alissa-booking-photo-super-tease.jpg",
// "publishedAt": "2021-03-23T22:35:14Z",
// "content": "(CNN)Ahmad Al Aliwi Alissa was identified by authorities Tuesday as the gunman who opened fire at a King Soopers grocery store in Colorado, killing 10 people, including a Boulder police officer. \r\nTh… [+6334 chars]"
// }\