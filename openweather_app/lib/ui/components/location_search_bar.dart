import 'package:flutter/material.dart';
import 'package:openweather_app/data/models/city.dart';

class SearchLocationBar extends StatefulWidget {
  final void Function(String query) onSearch;
  final void Function(String query) onSearchChanged;
  final List<Location> locations;

  final Function(Location) onLocationSelected;
  

  const SearchLocationBar({
    Key? key,
    required this.onSearch,
    required this.onSearchChanged,
    required this.onLocationSelected,
    required this.locations,
  }) : super(key: key);

  @override
  State<SearchLocationBar> createState() => _SearchEmployeeBarState();
}

class _SearchEmployeeBarState extends State<SearchLocationBar> {
  late ScrollController scrollController;
  late TextEditingController controller;

  String updateQuary = '';
  late BoxConstraints constraint;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );
    return Autocomplete<Location>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        updateQuary = textEditingValue.text;

        if (textEditingValue.text == "") {
          return const [];
        }

        widget.onSearchChanged(textEditingValue.text);

        return widget.locations;
      },
      optionsViewBuilder: (context, onResultTap, values) {
        return Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: SizedBox(
                  width: constraint.maxWidth,
                  child: Material(
                    shadowColor: Colors.transparent,
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: border.borderRadius.copyWith(
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1.2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: Theme.of(context).dividerTheme.thickness ?? 0.9,
                            ),
                            borderRadius: border.borderRadius.copyWith(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                            ),
                          ),
                          child: Scrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            child: ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(4),
                              itemCount: values.length,
                              itemBuilder: (BuildContext context, int index) {
                                final location = values.toList()[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10 * .5),
                                  child: ListTile(
                                    onTap: () {
                                      widget.onLocationSelected(location);
                                      controller.clear();
                                    },
                                    dense: true,
                                    title: Text("${location.name} ${location.state}, ${location.country}"),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onSelected: (Location location) {},
      fieldViewBuilder: (context, controller, focusNode, Function() _) {
        this.controller = controller;

        return LayoutBuilder(builder: (context, constraint) {
          this.constraint = constraint;

          return SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key("search_textfield"),
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: border,
                      focusedBorder: border,
                      hintText: "Search for a city",
                    ),
                  ),
                ),
                TextButton(
                  key: const Key("go_search"),
                  onPressed: () => widget.onSearch(controller.text),
                  child: const Text("Search"),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
