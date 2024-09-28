import 'package:flutter/material.dart';
import 'package:news/models/newsmodel.dart';

class ReadNews extends StatelessWidget {
  final NewsApiModel model;

  const ReadNews({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
        title: Text(
          'Read News',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: size.height / 3,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(model.imageurl),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(height: 20),
              Container(
                width: size.width,
                child: Text(
                  model.content,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
