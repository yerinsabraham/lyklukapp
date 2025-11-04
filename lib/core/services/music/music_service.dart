import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:path_provider/path_provider.dart';

import 'music_track.dart';

abstract class MusicService {
  /// Get tracks based on query
  Future<List<MusicTrack>> getTracks({required Map<String, dynamic> query});

  /// download track
  Future<File> downloadTrack(String ur,  Function(int count, int total)? progress);
}

class MusicServiceImpl implements MusicService {
  final ApiService _apiService;

  const MusicServiceImpl(this._apiService);
  static final String baseUrl = "https://api.jamendo.com";
  static final Dio client = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  Future<File> downloadTrack(String url, Function(int count, int total)? progress) {
    try {
      final response = client.get(
        url,
        onReceiveProgress: progress,
        options: Options(responseType: ResponseType.bytes),
      );
      return response.then((value)async {

        // final file = File.fromBytes(value.data);
        // final path = '${Directory.current.path}/tracks/${url.split("/").last}'; 
        final dir =  await getTemporaryDirectory(); 
        final file = File('${dir.path}/tracks/${url.split("/").last}');
        file.writeAsBytesSync(value.data);
        return file;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MusicTrack>> getTracks({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        "/v3.0/tracks/?client_id=215b3fbb&format=json",
        customClient: client,
        queryParameters: query,
        hasHeader: false,
      );
      if (res.isSuccessful) {
        final data = res.data['results'] as List;
        final tracks = data.map((e) => MusicTrack.fromJson(e)).toList();
        return tracks;
      } else {
        throw AppException(res.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
