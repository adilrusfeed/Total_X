import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/user_controller.dart';
import 'package:totalx/widgets/pop_up_menu_items.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                Provider.of<DataController>(context, listen: false)
                    .searchUsers(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_sharp,
                  color: Colors.grey,
                ),
                hintText: 'Search by name or number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Consumer<DataController>(
            builder: (context, homeController, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  homeController.setFilter(value);
                },
                itemBuilder: (context) => [
                  sortItem('all', 'All', context),
                  sortItem('elder', 'Elder', context),
                  sortItem('younger', 'Younger', context),
                ],
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
