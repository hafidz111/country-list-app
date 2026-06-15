import 'package:country_list_app/views/home/widgets/country_search_bar.dart';
import 'package:country_list_app/views/home/widgets/country_tile.dart';
import 'package:country_list_app/models/country_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.find();

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries"),
        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          CountrySearchBar(
            controller: controller.searchController,
            onChanged: (value) {
              controller.searchKeyword.value = value;
            },
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.countries.isEmpty) {
                return Skeletonizer(
                  enabled: true,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => CountryTile(
                      country: CountryModel(
                        name: 'Loading Country Name',
                        capital: 'Loading Capital',
                        flag: '',
                      ),
                    ),
                  ),
                );
              }

              if (controller.countries.isEmpty) {
                return const Center(child: Text("No Countries Found"));
              }

              return RefreshIndicator(
                onRefresh: controller.refreshData,
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.countries.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.countries.length) {
                      return Obx(() {
                        if (!controller.isLoadMore.value) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Skeletonizer(
                            enabled: true,
                            child: CountryTile(
                              country: CountryModel(
                                name: 'Loading Country Name',
                                capital: 'Loading Capital',
                                flag: '',
                              ),
                            ),
                          ),
                        );
                      });
                    }

                    final country = controller.countries[index];

                    return CountryTile(country: country);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
