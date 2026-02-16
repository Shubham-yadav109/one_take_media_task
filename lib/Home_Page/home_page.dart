import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_page();
}

class _home_page extends State<home_page> {

  List contentList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  Future<void> apiCall() async {
    try {
      final apiUrl = "https://goldflixsouth.com/api/home/content";

      final body = {
        "appId": "3"
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      debugPrint("Response: ${response.body}");

      final getData = jsonDecode(response.body);

      if (response.statusCode == 200 && getData["success"] == true) {

        setState(() {
          contentList = getData["data"]["contentList"];
          isLoading = false;
        });

      } else {
        debugPrint("API Failed");
      }

    } catch (e) {
      debugPrint("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("One Take Media"),
        centerTitle: true,
        elevation: 4,
        toolbarHeight: 60,
        backgroundColor: const Color(0xFF111111),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          final category = contentList[index];
          final List dataList = category["dataList"] ?? [];
          if (dataList.isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category["category_name"] ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "More",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataList.length,
                  itemBuilder: (context, i) {

                    final movie = dataList[i];

                    final imageUrl = movie["v_image"] ?? "";
                    final title = movie["name"] ?? "";

                    return Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,

                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },

                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.image, size: 40),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );

                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
