import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:unsplash_image/base/base_repository.dart';
import 'package:unsplash_image/data/repositories/db_helper.dart';
import 'package:unsplash_image/data/source/remote/api_service.dart';
import 'package:unsplash_image/models/image_model/image_model.dart';
import 'package:unsplash_image/utils/logger.dart';

class ImageRepository extends BaseRepository {
  final Logger _logger = Logger.getLogger((ImageRepository).toString());

  Future<List<ImageModel>> fetchImages() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        final List<ImageModel> imagesMapList =
            await DBHelper.instance.getImages();

        return imagesMapList;
      } else {
        return ApiService().fetchPhotos().then((response) async {
          if (response.statusCode == 200) {
            var jsonResponse = jsonDecode(response.body);

            //   _logger.debug(jsonResponse[1]['urls']['raw']);

            List<ImageModel> imageList = (jsonResponse as List).map(
              (e) {
                //    _logger.debug("Entered into Map");

                return ImageModel.fromJson(e);
              },
            ).toList();

            // _logger.debug("Exited the Map");
            for (final image in imageList) {
              await DBHelper.instance.insertImage(image);
            }

            return imageList;
          } else {
            _logger.error('Request failed with status: ${response.body}.');
            _logger.warn('Request failed with status: ${response.statusCode}.');
            return Future.error(parseHttpError(response.statusCode));
          }
        });
      }
    } catch (exception) {
      _logger.error('Request failed with error: $exception');
      return Future.error(exception);
    }
  }

  Future<List<ImageModel>> searchImages(
    String query,
  ) {
    try {
      return ApiService().searchPhotos(query: query).then((response) async {
        _logger.success('now handling searchPhotos');
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var jsonResult = jsonResponse['results'];

          //  _logger.debug(jsonResult[1]['urls']['raw']);

          List<ImageModel> imageList = (jsonResult as List).map(
            (e) {
              return ImageModel.fromJson(e);
            },
          ).toList();
          return imageList;
        } else {
          _logger.error('Request failed with status: ${response.body}.');
          _logger.warn('Request failed with status: ${response.statusCode}.');
          return Future.error(parseHttpError(response.statusCode));
        }
      });
    } catch (exception) {
      _logger.error('Request failed with error: $exception');
      return Future.error(exception);
    }
  }
}
