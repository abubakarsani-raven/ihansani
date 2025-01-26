import 'package:flutter/material.dart';
import 'package:project/utils/screen_util.dart';

class TaskTimeline extends StatelessWidget {
  const TaskTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);

    return Container(
      height: screenUtil.heightPercentage(49), // Half of the screen height
      width: screenUtil.widthPercentage(100), // Full width
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: screenUtil.scaleWidth(5))
        ],
      ),
      child: Stack(
        children: [
          // Scrollable Timeline
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 1,
                child: Divider(
                  color: Colors.purpleAccent,
                  endIndent: screenUtil.widthPercentage(90),
                  indent: 10,
                  height: 15,
                ),
              );
            },
            itemCount: 5,
          ),
          ListView.builder(

            padding: EdgeInsets.symmetric(
              vertical: screenUtil.scaleHeight(20),
              horizontal: screenUtil.scaleWidth(16),
            ),
            itemCount: 24, // Show only 6 hours (e.g., 12 AM - 5 AM)
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time Label
                  Text('${index % 12 == 0 ? 12 : index % 12} AM',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenUtil.scaleFontSize(14),
                          color: Colors.grey)),

                  SizedBox(height: screenUtil.scaleHeight(40)),
                  // Space between time slots
                  Divider(color: Colors.grey.shade300),
                  // Line between hours
                ],
              );
            },
          ),

          // Task Card at 12:30 AM
          // Positioned(
          //   top: screenUtil.scaleHeight(40), // Adjusted positioning
          //   left: screenUtil.scaleWidth(50),
          //   child: Container(
          //     padding: EdgeInsets.all(screenUtil.scaleWidth(10)),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(screenUtil.scaleWidth(10)),
          //       border: Border.all(color: Colors.blueAccent),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.grey, blurRadius: screenUtil.scaleWidth(5))
          //       ],
          //     ),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text('Push code to GitHub',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: screenUtil.scaleFontSize(12),
          //                 color: Colors.black)),
          //         SizedBox(width: screenUtil.scaleWidth(10)),
          //         Text('12:30 AM',
          //             style: TextStyle(
          //                 color: Colors.blue,
          //                 fontSize: screenUtil.scaleFontSize(12),
          //                 fontWeight: FontWeight.bold)),
          //       ],
          //     ),
          //   ),
          // ),

          // Red Floating Indicator at 2 AM
          // Positioned(
          //   top: screenUtil.scaleHeight(140), // Adjust based on time slot
          //   left: screenUtil.scaleWidth(20),
          //   child: CircleAvatar(
          //     backgroundColor: Colors.red,
          //     radius: screenUtil.scaleWidth(16),
          //     child: Text('A',
          //         style: TextStyle(
          //             fontSize: screenUtil.scaleFontSize(14),
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold)),
          //   ),
          // ),

          // Floating Add Button
          Positioned(
            bottom: screenUtil.scaleHeight(10),
            right: screenUtil.scaleWidth(10),
            child: FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () {
                // Add new task logic
              },
              child: Icon(Icons.add,
                  size: screenUtil.scaleFontSize(20), color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
