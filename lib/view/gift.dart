import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mindrop/viewcontroller/giftcontroller.dart';




class GifSearchScreen extends StatelessWidget {
  final GifController controller = Get.put(GifController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('GIF Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for GIFs',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                controller.searchGifs(query);
              },
            ),
          ),
          Expanded(
            child: Obx(() => controller.gifs.isEmpty
                ? Center(child: CircularProgressIndicator())
                : NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  controller.fetchGifs();
                }
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.gifs.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      controller.gifs[index]['images']['fixed_height']['url'],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
