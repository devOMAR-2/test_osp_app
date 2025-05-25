import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  /// ✅ تسجيل مستخدم جديد عبر الإيميل
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

  /// ✅ تسجيل الدخول عبر الإيميل
  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    return await _client.auth
        .signInWithPassword(email: email, password: password);
  }

  /// ✅ تسجيل الدخول عبر Google أو Facebook
  Future<void> signInWithOAuth(OAuthProvider provider) async {
    await _client.auth.signInWithOAuth(provider);
  }

  /// ✅ جلب بيانات الملف الشخصي
  Future<Map<String, dynamic>?> getProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final response =
        await _client.from('profiles').select().eq('id', userId).single();

    return response;
  }

  /// ✅ تحديث بيانات الملف الشخصي
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

  /// ✅ رفع صورة الملف الشخصي
  Future<String?> uploadProfilePicture(XFile imageFile) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final bytes = await imageFile.readAsBytes();
    final filePath = 'avatars/$userId.png';

    await _client.storage.from('avatars').uploadBinary(
          filePath,
          bytes,
          fileOptions: FileOptions(upsert: true),
        );

    return _client.storage.from('avatars').getPublicUrl(filePath);
  }

  /// ✅ تحديث رابط صورة الملف الشخصي
  Future<void> updateProfilePicture(String imageUrl) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client.from('profiles').update({
      'profile_photo': imageUrl,
    }).eq('id', userId);
  }

  /// ✅ تسجيل خروج المستخدم
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
