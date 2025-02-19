import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class GifController extends GetxController {
  var gifs = [].obs;
  var isLoading = false.obs;
  var searchTerm = ''.obs;
  var offset = 0.obs;

  final String apiKey = 'AAKYOiiTyXlLytZzyl7OpmCQscfOcm7Y';
  final int limit = 20;

  void fetchGifs({bool isSearch = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    String url = searchTerm.value.isEmpty
        ? 'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=$limit&offset=${offset.value}'
        : 'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=${searchTerm.value}&limit=$limit&offset=${offset.value}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      if (isSearch) {
        gifs.assignAll(data);
      } else {
        gifs.addAll(data);
      }
      offset.value += limit;
    }
    isLoading.value = false;
  }

  void searchGifs(String query) {
    searchTerm.value = query;
    offset.value = 0;
    fetchGifs(isSearch: true);
  }
}