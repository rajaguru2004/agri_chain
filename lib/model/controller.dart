import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_store_app/model/items_model.dart';
import 'package:http/http.dart' as http;

import '../screen/homescreen/home_page.dart';

class Controller {}

Future<void> loginUser(
    BuildContext context, String email, String password) async {
  const String url = "http://192.168.95.170:3000/api/auth/login";

  final Map<String, String> requestBody = {
    "email": email,
    "password": password,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final Map<String, dynamic> map = await fetchItemDetails();
      fetchItems(map);

      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          // Animation duration
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide from right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
      print("Login Successful: $data");
    } else {
      print("Login Failed: ${response.body}");
    }
  } catch (error) {
    print("Error: $error");
  }
}

Future<Map<String, dynamic>> fetchItemDetails() async {
  final url = Uri.parse('http://192.168.95.170:3000/api/products/getProducts');

  try {
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        dynamic result = jsonDecode(response.body);

        if (result is Map<String, dynamic>) {
          return result;
        } else if (result is List) {
          return {"products": result}; // Wrap the list inside a Map
        } else {
          throw Exception("Unexpected JSON format");
        }
      } else {
        throw Exception("Empty response body");
      }
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching items: $e");
    return {};
  }
}
