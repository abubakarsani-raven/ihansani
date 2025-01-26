import 'package:flutter/material.dart';
import 'package:project/components/timeline/timeline_comp.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 0.08 === 8%
    final sizeW = screenWidth * 0.95;
    final sizeH = screenHeight * 0.30;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: sizeH,
          width: sizeW,
          margin: EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(20),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [Text('data1')],
                ),
                Row(
                  children: [
                    Expanded(
                      child: StandardSearchAnchor(
                          searchBar: StandardSearchBar(
                            bgColor: Colors.white,
                            borderRadius: 5,
                          ),
                          suggestions: StandardSuggestions(
                            suggestions: [
                              StandardSuggestion(text: 'Suggestion 1'),
                              StandardSuggestion(text: 'Suggestion 2'),
                              StandardSuggestion(text: 'Suggestion 3'),
                            ],
                          )),
                    )
                  ],
                ),
                Row(
                  children: [Text('data1')],
                ),
                Row(
                  children: [Text('data1')],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
