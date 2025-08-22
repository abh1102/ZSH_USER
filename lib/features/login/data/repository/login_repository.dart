import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zanadu/core/api.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/login/data/model/login_model.dart';
import 'package:zanadu/features/login/data/model/signed_url.dart';
import 'package:zanadu/features/login/data/model/user_model.dart';

class LoginRepository {
  final _api = Api();

  //

  Future<LoginModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        "/login",
        data: jsonEncode({"email": email, "password": password}),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return LoginModel.fromJson(apiResponse.data as Map<String, dynamic>);
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> fetchUserInfo({required String token}) async {
    try {
      Response response = await _api.sendRequest.get(
        "/user/profile",
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data as Map<String, dynamic>);
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      Response response = await _api.sendRequest.patch(
        "/user/change-password",
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool> editProfile({
    String? fullName,
    String? dob,
    String? gender,
    List<String>? topHealthChallenges,
    String? state,
    String? image, // Add this parameter
  }) async {
    try {
      FormData formData = FormData();

      if (fullName != null) {
        formData.fields.add(MapEntry('fullName', fullName));
      }

      if (dob != null) {
        formData.fields.add(MapEntry('DOB', dob));
      }

      if (gender != null) {
        formData.fields.add(MapEntry('gender', gender));
      }

      if (topHealthChallenges != null) {
        formData.fields.add(
            MapEntry('topHealthChallenges', topHealthChallenges.join(',')));
      }

      if (state != null) {
        formData.fields.add(MapEntry('state', state));
      }

      if (image != null) {
        formData.files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(
            image,
            filename: 'profile_image.jpg', // Provide a filename for the image
          ),
        ));
      }

      Response response = await _api.sendRequest.patch(
        "/user/edit-profile",
        data: formData,
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.status;
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

   // remove image


  Future<String> removeProfilePhoto() async {
    try {
      Response response = await _api.sendRequest.patch(
        "/common/remove-profile-photo",
        
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }


  // Future<bool> editProfile({
  //   String? fullName,
  //   String? dob,
  //   String? gender,
  //   List<String>? topHealthChallenges,
  //   String? state,
  // }) async {
  //   try {
  //     Map<String, dynamic> requestBody = {};

  //     if (fullName != null) {
  //       requestBody["fullName"] = fullName;
  //     }

  //     if (dob != null) {
  //       requestBody["DOB"] = dob;
  //     }

  //     if (gender != null) {
  //       requestBody["gender"] = gender;
  //     }

  //     if (topHealthChallenges != null) {
  //       requestBody["topHealthChallenges"] = topHealthChallenges;
  //     }

  //     if (state != null) {
  //       requestBody["state"] = state;
  //     }

  //     Response response = await _api.sendRequest.patch(
  //       "/user/edit-profile",
  //       data: jsonEncode(requestBody),
  //       options: ApiUtils.getAuthOptions(),
  //     );

  //     ApiResponse apiResponse = ApiResponse.fromResponse(response);

  //     if (!apiResponse.status) {
  //       throw apiResponse.message.toString();
  //     }

  //     return apiResponse.status;
  //   } on DioException catch (ex) {
  //     if (ex.response != null) {
  //       ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
  //       throw apiResponse.message.toString();
  //     } else {
  //       throw "An error occurred while processing the request.";
  //     }
  //   } catch (ex) {
  //     rethrow;
  //   }
  // }

  Future<ApiResponse> logOut() async {
    try {
      Response response = await _api.sendRequest
          .post("/logout", options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse;
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<SignedUrlModel> getSignedUrl({required String fileName}) async {
    try {
      Response response = await _api.sendRequest.post(
        "/common/get-signed-url",
        data: {"fileName": fileName},
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return SignedUrlModel.fromJson(apiResponse.data as Map<String, dynamic>);
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  // forget pass

  Future<String> forgotPassword({required String email}) async {
    try {
      Response response = await _api.sendRequest.post(
        "/forgot-password",
        data: jsonEncode({"email": email}),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> verifyForgotPasswordOTP({
    required String email,
    required int otp,
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        "/forgot-password/verify-otp",
        data: jsonEncode({"email": email, "otp": otp}),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> changeForgottenPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        "/forgot-password/change-password",
        data: {
          "email": email,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> getChangePhoneOtp() async {
    try {
      // Call the API endpoint to get OTP for changing the phone number
      Response response = await _api.sendRequest.get(
        "/user/change-phone-otp",
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      // Return the OTP as a string
      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> verifyChangePhoneOtp({
    required int otp,
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        "/user/change-phone-otp-verify",
        data: jsonEncode({"otp": otp}),
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> changePhoneNumber({required String phone}) async {
    try {
      Response response = await _api.sendRequest.patch(
        "/user/change-phone",
        data: {"phone": phone},
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> deleteUser(String status) async {
    try {
      Response response = await _api.sendRequest.delete(
        '/enterprise/delete-user/${myUser?.userInfo?.userId}',
        data: jsonEncode({"status": status}),
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }
      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

// get device token

  Future<void> updateDeviceInfo({
    required String deviceId,
    required String firebaseToken,
    required String type,
  }) async {
    print("///working here");
    try {
      // Assuming that the endpoint is correct, adjust it if needed
      Response response = await _api.sendRequest.post(
        "/user/deviceinfo-update",
        data: jsonEncode({
          "deviceId": deviceId,
          "firebaseToken": firebaseToken,
          "type": type,
        }),
        options: ApiUtils
            .getAuthOptions(), // Add this line if authentication is required
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }
}
