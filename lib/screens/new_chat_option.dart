import 'dart:ui';
import 'package:flutter/material.dart';

void openFloatingPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Stack(
        children: [
       
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 1.5, sigmaY: 1.5), 
              child: Container(
                color: Colors.white.withOpacity(0.3), 
              ),
            ),
          ),
          FractionallySizedBox(
            heightFactor: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Container(
                      height: 214,
                      width: 370,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildBottomSheetItem(
                            icon: Icons.chat_outlined,
                            title: 'New Chat',
                            subtitle: 'Sent a message to your contacts',
                            onTap: () => Navigator.pop(context),
                          ),
                          buildBottomSheetItem(
                            icon: Icons.contact_page_outlined,
                            title: 'New Contact',
                            subtitle:
                                'Add a contact to be able to send messages',
                            onTap: () => Navigator.pop(context),
                          ),
                          buildBottomSheetItem(
                            icon: Icons.group_outlined,
                            title: 'New Community',
                            subtitle: 'Join the community around you',
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(180, 44),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget buildBottomSheetItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 0.8),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, size: 25),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.fromLTRB(5, 2, 1, 1),
        horizontalTitleGap: 15,
      ),
    ),
  );
}
