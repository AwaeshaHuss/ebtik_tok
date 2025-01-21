import 'dart:convert';

import 'package:ebtik_tok/features/home_feed/data/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String? key}) {
    return sharedPreferences!.get(key!);
  }

  static Future<bool> saveData({
    required String? key,
    required dynamic value,
  }) async {
    // ? the default case is StringList
    if (value is String) {return await sharedPreferences!.setString(key!,value,);}
    if (value is int) {return await sharedPreferences!.setInt(key!, value,);}
    if (value is bool) {return await sharedPreferences!.setBool(key!,value,);}
    if (value is double) {return await sharedPreferences!.setDouble(key!,value,);}
    return await sharedPreferences!.setStringList(key!, value);
  }


  /// Saves a single VideoModel to SharedPreferences without duplicates
static Future<bool> saveVideo({
  required String key,
  required VideoModel video,
}) async {
  try {
    // Retrieve the existing video set
    Set<VideoModel> existingVideos = getVideoSet(key: key);

    // Add the new video to the set (Set will automatically avoid duplicates)
    existingVideos.add(video);

    // Convert the set to a JSON string
    String jsonString = jsonEncode(existingVideos.map((e) => e.toJson()).toList());

    // Save back to SharedPreferences
    return await sharedPreferences!.setString(key, jsonString);
  } catch (e) {
    debugPrint("Error saving single video: $e");
    return false;
  }
}

/// Retrieves a set of VideoModel from SharedPreferences
static Set<VideoModel> getVideoSet({required String key}) {
  try {
    // Get the JSON string from SharedPreferences
    String? jsonString = sharedPreferences!.getString(key);

    // If null, return an empty set
    if (jsonString == null) return <VideoModel>{};

    // Decode the JSON string and map it to a Set of VideoModel
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => VideoModel.fromJson(e)).toSet();
  } catch (e) {
    debugPrint("Error retrieving video set: $e");
    return <VideoModel>{};
  }
}



  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}