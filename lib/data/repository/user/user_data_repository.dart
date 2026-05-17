import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/data/model/user/user_model.dart';
import 'package:tech_node/core/network/dio_provider.dart';

part 'user_data_repository.g.dart';

abstract class UserDataRepository {
  Future<UserModel> fetchUserProfile();
  Future<UserModel> updateMyProfile({
    required String name,
    String? bio,
    String? profileImage,
  });
}

@riverpod
UserDataRepository userDataRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return UserDataRepositoryImp(dio);
}

class UserDataRepositoryImp implements UserDataRepository {
  final Dio _dio;
  UserDataRepositoryImp(this._dio);

  @override
  Future<UserModel> fetchUserProfile() async {
    try {
      final response = await _dio.get('profile');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return UserModel.fromJson(response.data['data']);
      }
      throw BlogException('Unable to fetch profile');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<UserModel> updateMyProfile({
    required String name,
    String? bio,
    String? profileImage,
  }) async {
    final Map<String, dynamic> updatedData = {'name': name, 'bio': bio};
    final finalData = FormData.fromMap(updatedData);
    if (profileImage != null) {
      finalData.files.add(
        MapEntry(
          'profile_picture',
          await MultipartFile.fromFile(profileImage, filename: 'profile.webp'),
        ),
      );
    }
    try {
      final response = await _dio.post('profile/update', data: finalData);
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return UserModel.fromJson(response.data['data']);
      }
      throw BlogException('Unable to update profile');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
}
