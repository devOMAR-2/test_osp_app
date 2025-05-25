import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class UserRepository {
  final SupabaseClient _client = Supabase.instance.client;

  /// إنشاء مستخدم جديد
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    DateTime? birthdate,
    String? address,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final userId = response.user?.id;
    if (userId != null) {
      await _client.from('profiles').insert({
        'id': userId,
        'username': username,
        'birthdate': birthdate?.toIso8601String(),
        'address': address,
        'profile_photo': null,
      });
    }
    return response;
  }

  /// تسجيل الدخول
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth
        .signInWithPassword(email: email, password: password);
  }

  /// جلب بيانات الملف الشخصي
  Future<UserModel?> getProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final response =
        await _client.from('profiles').select().eq('id', userId).single();
    return response != null ? UserModel.fromMap(response) : null;
  }

  /// تحديث بيانات الملف الشخصي
  Future<void> updateProfile({
    required String username,
    DateTime? birthdate,
    String? address,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client.from('profiles').update({
      'username': username,
      'birthdate': birthdate?.toIso8601String(),
      'address': address,
    }).eq('id', userId);
  }

  /// رفع صورة الملف الشخصي
  Future<String?> uploadProfilePicture(XFile imageFile) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final bytes = await imageFile.readAsBytes();
    final filePath = 'avatars/$userId.png';

    await _client.storage.from('avatars').uploadBinary(filePath, bytes);
    return _client.storage.from('avatars').getPublicUrl(filePath);
  }

  Future<void> updateProfilePicture(String imageUrl) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client.from('profiles').update({
      'profile_photo': imageUrl,
    }).eq('id', userId);
  }
}
