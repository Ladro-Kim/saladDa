import 'package:flutter/material.dart';
import 'package:salad_da/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCardWidget extends StatelessWidget {
  News news;

  NewsCardWidget(this.news);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: news.articles.length,
          itemBuilder: (context, index) {
            print("index: $index, totalResult : ${news.totalResults}");
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      news.articles[index].urlToImage != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                news.articles[index].urlToImage,
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(news.articles[index].title, style: TextStyle(fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10),
                            Text(news.articles[index].content == null ? "" : news.articles[index].content, style: TextStyle(fontFamily: "Roboto", fontSize: 14)),
                            SizedBox(height: 10),
                            Container(child: Text("${news.articles[index].publishedAt}", textAlign: TextAlign.right, style: TextStyle(fontFamily: "Roboto", fontSize: 12),), alignment: Alignment.centerRight),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  String url = news.articles[index].url;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print("canLaunch false");
                  }
                },
              ),
            );
          }),
    );
  }
}
