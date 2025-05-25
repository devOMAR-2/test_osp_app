import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotrue/src/types/auth_state.dart' as gotrue_auth_state;
import 'package:image_picker/image_picker.dart';
import 'package:osp/features/auth/cubit/auth_state.dart';
import 'package:osp/features/auth/data/models/user_model.dart';
import 'package:osp/features/auth/data/repos/user_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit(this.userRepository) : super(AuthInitial());

  /// تسجيل مستخدم جديد
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    DateTime? birthdate,
    String? address,
  }) async {
    if (isClosed) return;
    emit(AuthLoading());

    try {
      final response = await userRepository.signUp(
        email: email,
        password: password,
        username: username,
        birthdate: birthdate,
        address: address,
      );

      final userModel = UserModel.fromUser(
        response.user!,
        password: password,
      );

      if (!isClosed) {
        emit(AuthSuccess(userModel));
      }
    } catch (e) {
      if (!isClosed) {
        emit(AuthFailure(e.toString()));
      }
    }
  }

  /// تسجيل دخول
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (isClosed) return;
    emit(AuthLoading());
    try {
      final response =
          await userRepository.signIn(email: email, password: password);

      final userModel = UserModel.fromUser(
        response.user!,
        password: password,
      );
      emit(AuthSuccess(userModel)); // إرسال UserModel بدلاً من User
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  /// جلب بيانات الملف الشخصي
  Future<void> getProfile() async {
    emit(AuthLoading());
    try {
      final user = await userRepository.getProfile();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("No user found"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String username,
    String? address,
    XFile? imageFile,
  }) async {
    if (isClosed) return;
    emit(AuthLoading());

    try {
      String? imageUrl;

      // إذا تم اختيار صورة، ارفعها
      if (imageFile != null) {
        imageUrl = await userRepository.uploadProfilePicture(imageFile);
        if (imageUrl != null) {
          // تأكد من رفع الصورة بنجاح
          await userRepository.updateProfilePicture(imageUrl);
        }
      }

      // تحديث بيانات المستخدم في قاعدة البيانات
      await userRepository.updateProfile(
        username: username,
        address: address,
      );

      // جلب بيانات المستخدم بعد التحديث
      final updatedUser = await userRepository.getProfile();
      if (updatedUser != null) {
        emit(AuthSuccess(updatedUser));
      } else {
        emit(AuthFailure("حدث خطأ أثناء تحديث البيانات"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
