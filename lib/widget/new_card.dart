import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagem;

  const NewsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagem,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late String title = '';
  late String subtitle = '';
  late String imagem = '';

  @override
  void initState() {
    title = widget.title;
    subtitle = widget.subtitle;
    imagem = widget.imagem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        key: UniqueKey(),
        shadowColor: const Color.fromARGB(255, 218, 215, 215),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          // onTap: () => Navigator.of(context).pushNamed(
          //   ArticleDiscriptionScreen.routeName,
          //   arguments: widget.newsArticle,
          // ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                    left: 15.0,
                  ),
                  child: Text(title, style: const TextStyle(fontSize: 20, color: Colors.white,),),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 15.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 220, 228, 231)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: 'widget.newsArticle.articleId',
                    child: Image.asset(
                      imagem,
                      height: 200,
                      width: 400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
