import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/country_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();
  final countries = <CountryModel>[].obs;
  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final searchKeyword = ''.obs;
  late Worker searchWorker;
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;

  final searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
    setupSearch();
    setupPagination();
  }

  void setupSearch() {
    searchWorker = debounce(searchKeyword, (keyword) async {
      if (keyword.isEmpty) {
        await fetchCountries();
      } else {
        await searchCountries(keyword);
      }
    }, time: const Duration(milliseconds: 500));
  }

  void setupPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });
  }

  Future<void> fetchCountries() async {
    try {
      isLoading.value = true;
      offset = 0;

      final result = await apiService.getCountries(
        limit: limit,
        offset: offset,
      );

      countries.assignAll(result);

      hasMore = result.length >= limit;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!hasMore) return;

    if (isLoadMore.value) return;

    try {
      isLoadMore.value = true;

      offset += limit;

      final result = await apiService.getCountries(
        limit: limit,
        offset: offset,
      );

      countries.addAll(result);

      hasMore = result.length >= limit;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadMore.value = false;
    }
  }

  Future<void> searchCountries(String query) async {
    try {
      isLoading.value = true;

      final result = await apiService.searchCountries(query);

      countries.assignAll(result);
    } catch (e) {
      Get.snackbar("Search Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchCountries();
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    searchWorker.dispose();
    super.onClose();
  }
}
