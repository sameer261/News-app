import 'package:flutter/material.dart';
import 'package:news/models/newsmodel.dart';
import 'package:news/newsapi.dart';
import 'package:news/screens/readnews.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isLoading = true;
  List<NewsApiModel>? newsList;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      newsList = await getNews();
      print('Fetched news: $newsList');
    } catch (error) {
      print('Error fetching news: $error');
      newsList = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Breaking News',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            )),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : newsList != null && newsList!.isNotEmpty
              ? ListView.builder(
                  itemCount: newsList!.length,
                  itemBuilder: (context, index) {
                    return listItem(size, newsList![index]);
                  },
                )
              : Center(
                  child: Text('No news available')), // Handle empty news list
    );
  }

  Widget listItem(Size size, NewsApiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReadNews(model: model),
          ),
        ),
        child: Container(
          height: size.height / 3.2,
          width: size.width / 1.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Column(
            children: [
              Container(
                height: size.height / 5,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  image: DecorationImage(
                    image: model.imageurl.isNotEmpty
                        ? NetworkImage(model.imageurl)
                        : const AssetImage('assets/images/Placeholder.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: model.imageurl.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : null,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  model.desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
