// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:osp/core/api/converter.dart';
// import 'package:osp/core/networking/di/dependency_injection.dart';
// import 'package:osp/core/theme/app_color.dart';
// import 'package:osp/features/auth/cubit/auth_cubit.dart';
// import 'package:osp/features/auth/data/models/user_model.dart';
// import 'package:osp/features/auth/login_screen.dart';
// import 'package:osp/features/home/widgets/open_file.dart';
// import 'package:osp/features/ocr/arabic_doc.dart';
// import 'package:osp/features/ocr/english_doc.dart';
// import 'package:osp/features/profile/profile_dialog.dart';
// import 'package:osp/features/tools/tools/standard.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../bottom_nav_bar/custom_buttom_navbar.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   int _selectedIndex = 2;
//   Set<String> _favoriteImages = {};
//   final TextEditingController _searchController = TextEditingController();
//   bool _isSearchVisible = false;
//   List<File> _userImages = [];
//   bool _isLoggedIn = false;
//   late SharedPreferences _prefs;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     _prefs = await SharedPreferences.getInstance();
//     _loadFavoriteImages();
//     await _checkPermissionsAndLoadImages();
//   }

//   Future<void> _loadFavoriteImages() async {
//     final List<String>? favorites = _prefs.getStringList('favoriteImages');
//     if (favorites != null) {
//       _favoriteImages = favorites.toSet();
//     }
//   }

//   Future<void> _saveFavoriteImages() async {
//     await _prefs.setStringList('favoriteImages', _favoriteImages.toList());
//   }

//   Future<void> _checkPermissionsAndLoadImages() async {
//     final PermissionState ps = await PhotoManager.requestPermissionExtend();
//     if (ps.isAuth) {
//       await _loadAllImages();
//       setState(() {
//         _isLoggedIn = true;
//       });
//     } else {
//       await PhotoManager.openSetting();
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   // processing files
//   Future<List<File>> getSelectedFiles() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String>? filePaths = prefs.getStringList('selectedFiles');

//     if (filePaths != null) {
//       return filePaths.map((path) => File(path)).toList();
//     } else {
//       return [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Opacity(
//               opacity: 0.15,
//               child: Image.asset('assets/images/BG.png', fit: BoxFit.cover),
//             ),
//           ),
//           SafeArea(
//             bottom: false,
//             child: Column(
//               children: [
//                 _buildTopBar(context),
//                 if (_isSearchVisible) _buildSearchBar(context),
//                 _buildSegmentControl(context),
//                 const SizedBox(height: 16),
//                 if (_isLoggedIn)
//                   Expanded(
//                     child: _buildImageList(),
//                   ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: BottomNavBar(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   Widget _buildImageList() {
//     List<File> imagesToShow;

//     if (_selectedIndex == 0) {
//       // Favorites
//       imagesToShow = _userImages
//           .where((file) => _favoriteImages.contains(file.path))
//           .toList();
//     }
//     // if (_selectedIndex == 1) {
//     //   // processing
//     //   imagesToShow = _userImages
//     //       .where((file) => _favoriteImages.contains(file.path))
//     //       .toList();
//     // }
//     else {
//       // All or Process
//       imagesToShow = _userImages;
//     }

//     if (imagesToShow.isEmpty) {
//       return Center(
//         child: Text(
//           AppLocalizations.of(context)!.emptyPart,
//           style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//         ),
//       );
//     }

//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: imagesToShow.length,
//       itemBuilder: (context, index) {
//         final image = imagesToShow[index];
//         return _buildImageCard(
//           image.path,
//           image.uri.pathSegments.last,
//         );
//       },
//     );
//   }

//   Widget _buildTopBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Directionality(
//           textDirection: TextDirection.ltr,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   _buildProfileButton(),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: InkWell(
//                       child: Image.asset(
//                         'assets/images/searchbutton.png',
//                         width: 105,
//                         height: 105,
//                         fit: BoxFit.fill,
//                       ),
//                       onTap: () {
//                         setState(() {
//                           _isSearchVisible = !_isSearchVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 6.0),
//                 child: SizedBox(
//                   width: 70,
//                   height: 40,
//                   child: Image.asset(
//                     'assets/images/Osp logo.png',
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileButton() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0),
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: const Color(0xFFEEDBED), width: 3),
//         ),
//         child: GestureDetector(
//           onTap: _handleProfileTap,
//           child: isLoading
//               ? CircularProgressIndicator(
//                   color: Color(0xFF8852AB).withOpacity(0.5),
//                 )
//               : const Icon(
//                   Icons.person,
//                   size: 25,
//                   color: Color(0xFF8852A8),
//                 ),
//         ),
//       ),
//     );
//   }

//   Future<void> _handleProfileTap() async {
//     setState(() => isLoading = true);

//     final SupabaseClient client = Supabase.instance.client;
//     final session = client.auth.currentSession;

//     if (session == null) {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (BuildContext context) => BlocProvider(
//           create: (_) => getIt<AuthCubit>(),
//           child: LoginScreen(),
//         ),
//       ));
//       setState(() => isLoading = false);
//       return;
//     }

//     final response = await client.auth.getUser();
//     final user = response.user;

//     if (user != null) {
//       final profileResponse =
//           await client.from('profiles').select().eq('id', user.id).single();

//       final userModel = UserModel.fromMap(profileResponse);

//       showDialog(
//         context: context,
//         builder: (_) => ProfileScreen(
//           user: userModel,
//           email: user.email.toString(),
//         ),
//       );
//     }

//     setState(() => isLoading = false);
//   }

//   Widget _buildSearchBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           color: const Color(0x66EEDBED),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: AppLocalizations.of(context)!.search,
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.symmetric(horizontal: 16),
//           ),
//           onChanged: (_) => setState(() {}),
//         ),
//       ),
//     );
//   }

//   Widget _buildSegmentControl(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
//       child: Container(
//         width: 344,
//         height: 47,
//         decoration: BoxDecoration(
//           color: const Color(0x66EEDBED),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.white, width: 1),
//         ),
//         child: Row(
//           children: [
//             _buildSegmentButton(AppLocalizations.of(context)!.favorites, 0),
//             _buildSegmentButton(AppLocalizations.of(context)!.process, 1),
//             _buildSegmentButton(AppLocalizations.of(context)!.all, 2),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSegmentButton(String text, int index) {
//     final isSelected = _selectedIndex == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? const Color(0xFF8852AB).withOpacity(0.5)
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             text,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: isSelected ? Colors.white : const Color(0xFF8852AB),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _loadAllImages() async {
//     List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
//       type: RequestType.image,
//     );

//     if (albums.isEmpty) return;

//     List<AssetEntity> media =
//         await albums.first.getAssetListPaged(page: 0, size: 100);

//     _userImages = [];

//     for (var asset in media) {
//       File? file = await asset.file;
//       if (file != null) {
//         _userImages.add(file);
//       }
//     }

//     setState(() {});
//   }

//   void _showFullImage(String imagePath) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.all(10),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: FileImage(File(imagePath)),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 16,
//                     right: 16,
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: AppColor.primary,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.folder_open,
//                                 color: Colors.white, size: 28),
//                             onPressed: () async {
//                               // _openFolder(imagePath);
//                               final status = await Permission
//                                   .manageExternalStorage
//                                   .request();
//                               print('هل الإذن متاح؟ ${status.isGranted}');

//                               print(imagePath);
//                               Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => OpenFileScreen(
//                                   folderPath: imagePath,
//                                 ),
//                               ));
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.build_rounded,
//                                 color: Colors.white, size: 28),
//                             onPressed: () {
//                               // showModalBottomSheet(
//                               //   context: context,
//                               //   builder: (context) {
//                               //     return ToolsScreen();
//                               //   },
//                               // );
//                               showModalBottomSheet(
//                                 context: context,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(20)),
//                                 ),
//                                 builder: (context) {
//                                   return SingleChildScrollView(
//                                     child: Padding(
//                                       padding: EdgeInsets.all(16),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           ListTile(
//                                             leading: Image.asset(
//                                                 'assets/images/ocr.png'),
//                                             title: Text(
//                                                 AppLocalizations.of(context)!
//                                                     .txtExtraction),
//                                             // subtitle:
//                                             //     Text('وصف مختصر للعنصر الأول'),
//                                             onTap: () {
//                                               final currentLocale =
//                                                   AppLocalizations.of(context)!
//                                                       .localeName;
//                                               if (currentLocale == 'ar') {
//                                                 Navigator.pushReplacement(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           ArabicOcrScreen(
//                                                             imageFile:
//                                                                 File(imagePath),
//                                                           )),
//                                                 );
//                                               } else {
//                                                 Navigator.pushReplacement(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           EnglishOcrScreen(
//                                                             imageFile:
//                                                                 File(imagePath),
//                                                           )),
//                                                 );
//                                               }
//                                             },
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 20.0),
//                                             child: ListTile(
//                                               leading: Image.asset(
//                                                   'assets/images/pdf_2jpg.png'),
//                                               title: Text(
//                                                   AppLocalizations.of(context)!
//                                                       .topdf),
//                                               // subtitle:
//                                               //     Text('وصف مختصر للعنصر الثاني'),
//                                               onTap: () {
//                                                 // convert to pdf
//                                                 Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (_) =>
//                                                             Standard(
//                                                               name:
//                                                                   "PNG to PDF",
//                                                               selectedFiles: [
//                                                                 File(imagePath)
//                                                               ],
//                                                               func: () {
//                                                                 CloudmersiveConverter
//                                                                     .convertPngToPdf(
//                                                                   context,
//                                                                   File(imagePath)
//                                                                       .path,
//                                                                 );
//                                                               },
//                                                             )));
//                                               },
//                                             ),
//                                           ),
//                                           // ListTile(
//                                           //   leading: Icon(Icons.star,
//                                           //       color: Colors.amber),
//                                           //   title: Text('العنصر الثالث'),
//                                           //   subtitle: Text(
//                                           //       'هذا عنصر مع أيقونة بدلاً من صورة'),
//                                           //   onTap: () {},
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                           PopupMenuButton<String>(
//                             icon: Icon(Icons.more_vert,
//                                 color: Colors.white, size: 28),
//                             onSelected: (value) async {
//                               if (value ==
//                                   AppLocalizations.of(context)!.share) {
//                                 _shareImage(imagePath);
//                               } else if (value ==
//                                   AppLocalizations.of(context)!
//                                       .addToFavorites) {
//                                 _toggleFavorite(imagePath);
//                               } else if (value ==
//                                   AppLocalizations.of(context)!.openFolder) {
//                                 // _openFolder(imagePath);
//                                 final status = await Permission
//                                     .manageExternalStorage
//                                     .request();
//                                 print('هل الإذن متاح؟ ${status.isGranted}');

//                                 print(imagePath);
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => OpenFileScreen(
//                                     folderPath: imagePath,
//                                   ),
//                                 ));
//                               }
//                             },
//                             itemBuilder: (context) => [
//                               PopupMenuItem<String>(
//                                 value: AppLocalizations.of(context)!.share,
//                                 child: Text(
//                                   AppLocalizations.of(context)!.share,
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                               PopupMenuItem<String>(
//                                 value: AppLocalizations.of(context)!
//                                     .addToFavorites,
//                                 child: Text(
//                                   _favoriteImages.contains(imagePath)
//                                       ? AppLocalizations.of(context)!
//                                           .removeFromFavorites
//                                       : AppLocalizations.of(context)!
//                                           .addToFavorites,
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                               PopupMenuItem<String>(
//                                 value: AppLocalizations.of(context)!.openFolder,
//                                 child: Text(
//                                   AppLocalizations.of(context)!.openFolder,
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                             ],
//                             color: Colors.white,
//                             elevation: 8.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _shareImage(String imagePath) {
//     XFile imageFile = XFile(imagePath);

//     Share.shareXFiles([imageFile], text: 'مشاركة صورة رائعة!');
//   }

//   void _toggleFavorite(String imagePath) async {
//     setState(() {
//       if (_favoriteImages.contains(imagePath)) {
//         _favoriteImages.remove(imagePath);
//       } else {
//         _favoriteImages.add(imagePath);
//       }
//     });
//     await _saveFavoriteImages();
//   }

//   // void _openFolder(String imagePath) async {
//   //   final directory = File(imagePath).parent;
//   //   final path = directory.path;
//   //   print('فتح المجلد $path');
//   // }

//   Widget _buildImageCard(String imagePath, String title) {
//     final isFavorite = _favoriteImages.contains(imagePath);
//     return Container(
//       width: 75,
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       child: Column(
//         children: [
//           Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   _showFullImage(imagePath);
//                 },
//                 child: Container(
//                   width: 70,
//                   height: 75,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: FileImage(File(imagePath)),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               Transform.translate(
//                 offset: const Offset(0, 15),
//                 child: GestureDetector(
//                   onTap: () async {
//                     setState(() {
//                       if (isFavorite) {
//                         _favoriteImages.remove(imagePath);
//                       } else {
//                         _favoriteImages.add(imagePath);
//                       }
//                     });
//                     await _saveFavoriteImages();
//                   },
//                   child: Container(
//                     width: 30,
//                     height: 30,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF8852A8),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       isFavorite ? Icons.favorite : Icons.favorite_border,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osp/core/api/converter.dart';
import 'package:osp/core/networking/di/dependency_injection.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/features/auth/cubit/auth_cubit.dart';
import 'package:osp/features/auth/data/models/user_model.dart';
import 'package:osp/features/auth/login_screen.dart';
import 'package:osp/features/home/widgets/open_file.dart';
import 'package:osp/features/ocr/arabic_doc.dart';
import 'package:osp/features/ocr/english_doc.dart';
import 'package:osp/features/profile/profile_dialog.dart';
import 'package:osp/features/tools/tools/standard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../bottom_nav_bar/custom_buttom_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 2;
  Set<String> _favoriteImages = {};
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;
  List<File> _userImages = [];
  bool _isLoggedIn = false;
  late SharedPreferences _prefs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavoriteImages();
    await _checkPermissionsAndLoadImages();
  }

  Future<void> _loadFavoriteImages() async {
    final List<String>? favorites = _prefs.getStringList('favoriteImages');
    if (favorites != null) {
      _favoriteImages = favorites.toSet();
    }
  }

  Future<void> _saveFavoriteImages() async {
    await _prefs.setStringList('favoriteImages', _favoriteImages.toList());
  }

  Future<void> _checkPermissionsAndLoadImages() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await _loadAllImages();

      if (mounted) {
        setState(() {
          _isLoggedIn = true;
        });
      }
    } else {
      await PhotoManager.openSetting();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // processing files
  Future<List<File>> getSelectedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? filePaths = prefs.getStringList('selectedFiles');

    if (filePaths != null) {
      return filePaths.map((path) => File(path)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset('assets/images/BG.png', fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildTopBar(context),
                if (_isSearchVisible) _buildSearchBar(context),
                _buildSegmentControl(context),
                const SizedBox(height: 16),
                if (_isLoggedIn)
                  Expanded(
                    child: _buildImageList(),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildImagesAndFilesGrid(List<File> files) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        return _buildFileCard(file); // <-- هنا نستخدم نفس كارت الملف الذكي
      },
    );
  }

  Widget _buildFileCard(File file) {
    final extension = p.extension(file.path).toLowerCase();

    if (['.jpg', '.jpeg', '.png', '.gif', '.bmp'].contains(extension)) {
      // ملف صورة
      return FutureBuilder<bool>(
        future: FileSystemEntity.isDirectory(file.path),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == false) {
            return Container(
              margin: const EdgeInsets.only(right: 16),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(file),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return const SizedBox(); // لو مجلد، لا تعرض شيء
          }
        },
      );
    } else {
      // ملفات PDF أو Word أو غيرها
      IconData iconData;
      Color iconColor = Colors.grey[700]!;

      if (extension == '.pdf') {
        iconData = Icons.picture_as_pdf;
        iconColor = Colors.red;
      } else if (['.doc', '.docx'].contains(extension)) {
        iconData = Icons.description;
        iconColor = Colors.blue;
      } else {
        iconData = Icons.insert_drive_file;
      }

      return FutureBuilder<bool>(
        future: FileSystemEntity.isDirectory(file.path),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == false) {
            return Container(
              margin: const EdgeInsets.only(right: 16),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconData, size: 50, color: iconColor),
                  const SizedBox(height: 8),
                  Text(
                    p.basename(file.path), // اسم الملف فقط
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(); // لو مجلد، لا تعرض شيء
          }
        },
      );
    }
  }

  //   Widget _buildImageList() {
  //   List<File> imagesToShow;

  //   if (_selectedIndex == 0) {
  //     // Favorites
  //     imagesToShow = _userImages
  //         .where((file) => _favoriteImages.contains(file.path))
  //         .toList();
  //   }
  //   // if (_selectedIndex == 1) {
  //   //   // processing
  //   //   imagesToShow = _userImages
  //   //       .where((file) => _favoriteImages.contains(file.path))
  //   //       .toList();
  //   // }
  //   else {
  //     // All or Process
  //     imagesToShow = _userImages;
  //   }

  //   if (imagesToShow.isEmpty) {
  //     return Center(
  //       child: Text(
  //         AppLocalizations.of(context)!.emptyPart,
  //         style: TextStyle(fontSize: 16, color: Colors.grey[600]),
  //       ),
  //     );
  //   }

  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     itemCount: imagesToShow.length,
  //     itemBuilder: (context, index) {
  //       final image = imagesToShow[index];
  //       return _buildImageCard(
  //         image.path,
  //         image.uri.pathSegments.last,
  //       );
  //     },
  //   );
  // }

  Widget _buildImageList() {
    List<File> imagesToShow;

    if (_selectedIndex == 0) {
      // Favorites
      imagesToShow = _userImages
          .where((file) => _favoriteImages.contains(file.path))
          .toList();
    } else if (_selectedIndex == 1) {
      return FutureBuilder<List<File>>(
        future: getSelectedFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.emptyPart,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            );
          } else {
            imagesToShow = snapshot.data!;
            return _buildImagesAndFilesGrid(imagesToShow);
          }
        },
      );
    } else {
      // All or Process
      imagesToShow = _userImages;
    }

    if (imagesToShow.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.emptyPart,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: imagesToShow.length,
      itemBuilder: (context, index) {
        final image = imagesToShow[index];
        return _buildImageCard(
          image.path,
          image.uri.pathSegments.last,
        );
        // return _buildFileCard(image);
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildProfileButton(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      child: Image.asset(
                        'assets/images/searchbutton.png',
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.25,
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        setState(() {
                          _isSearchVisible = !_isSearchVisible;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SizedBox(
                  width: 70,
                  height: 40,
                  child: Image.asset(
                    'assets/images/Osp logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEEDBED), width: 3),
        ),
        child: GestureDetector(
          onTap: _handleProfileTap,
          child: isLoading
              ? CircularProgressIndicator(
                  color: Color(0xFF8852AB).withOpacity(0.5),
                )
              : const Icon(
                  Icons.person,
                  size: 25,
                  color: Color(0xFF8852A8),
                ),
        ),
      ),
    );
  }

  Future<void> _handleProfileTap() async {
    setState(() => isLoading = true);

    final SupabaseClient client = Supabase.instance.client;
    final session = client.auth.currentSession;

    if (session == null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: LoginScreen(),
        ),
      ));
      setState(() => isLoading = false);
      return;
    }

    final response = await client.auth.getUser();
    final user = response.user;

    if (user != null) {
      final profileResponse =
          await client.from('profiles').select().eq('id', user.id).single();

      final userModel = UserModel.fromMap(profileResponse);

      showDialog(
        context: context,
        builder: (_) => ProfileScreen(
          user: userModel,
          email: user.email.toString(),
        ),
      );
    }

    setState(() => isLoading = false);
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0x66EEDBED),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ),
    );
  }

  Widget _buildSegmentControl(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Container(
        width: 344,
        height: 47,
        decoration: BoxDecoration(
          color: const Color(0x66EEDBED),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Row(
          children: [
            _buildSegmentButton(AppLocalizations.of(context)!.favorites, 0),
            _buildSegmentButton(AppLocalizations.of(context)!.process, 1),
            _buildSegmentButton(AppLocalizations.of(context)!.all, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton(String text, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF8852AB).withOpacity(0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF8852AB),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadAllImages() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    if (albums.isEmpty) return;

    List<AssetEntity> media =
        await albums.first.getAssetListPaged(page: 0, size: 100);

    _userImages = [];

    for (var asset in media) {
      File? file = await asset.file;
      if (file != null) {
        _userImages.add(file);
      }
    }

    // setState(() {});
    if (mounted) {
      setState(() {});
    }
  }

  void _showFullImage(String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(imagePath)),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.folder_open,
                                color: Colors.white, size: 28),
                            onPressed: () async {
                              // _openFolder(imagePath);
                              final status = await Permission
                                  .manageExternalStorage
                                  .request();
                              print('هل الإذن متاح؟ ${status.isGranted}');

                              print(imagePath);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OpenFileScreen(
                                  folderPath: imagePath,
                                ),
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.build_rounded,
                                color: Colors.white, size: 28),
                            onPressed: () {
                              // showModalBottomSheet(
                              //   context: context,
                              //   builder: (context) {
                              //     return ToolsScreen();
                              //   },
                              // );
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: Image.asset(
                                                'assets/images/ocr.png'),
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .txtExtraction),
                                            // subtitle:
                                            //     Text('وصف مختصر للعنصر الأول'),
                                            onTap: () {
                                              final currentLocale =
                                                  AppLocalizations.of(context)!
                                                      .localeName;
                                              if (currentLocale == 'ar') {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ArabicOcrScreen(
                                                            imageFile:
                                                                File(imagePath),
                                                          )),
                                                );
                                              } else {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EnglishOcrScreen(
                                                            imageFile:
                                                                File(imagePath),
                                                          )),
                                                );
                                              }
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: ListTile(
                                              leading: Image.asset(
                                                  'assets/images/pdf_2jpg.png'),
                                              title: Text(
                                                  AppLocalizations.of(context)!
                                                      .topdf),
                                              // subtitle:
                                              //     Text('وصف مختصر للعنصر الثاني'),
                                              onTap: () {
                                                // convert to pdf
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            Standard(
                                                              name:
                                                                  "PNG to PDF",
                                                              selectedFiles: [
                                                                File(imagePath)
                                                              ],
                                                              func: () {
                                                                CloudmersiveConverter
                                                                    .convertPngToPdf(
                                                                  context,
                                                                  File(imagePath)
                                                                      .path,
                                                                );
                                                              },
                                                            )));
                                              },
                                            ),
                                          ),
                                          // ListTile(
                                          //   leading: Icon(Icons.star,
                                          //       color: Colors.amber),
                                          //   title: Text('العنصر الثالث'),
                                          //   subtitle: Text(
                                          //       'هذا عنصر مع أيقونة بدلاً من صورة'),
                                          //   onTap: () {},
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert,
                                color: Colors.white, size: 28),
                            onSelected: (value) async {
                              if (value ==
                                  AppLocalizations.of(context)!.share) {
                                _shareImage(imagePath);
                              } else if (value ==
                                  AppLocalizations.of(context)!
                                      .addToFavorites) {
                                _toggleFavorite(imagePath);
                              } else if (value ==
                                  AppLocalizations.of(context)!.openFolder) {
                                // _openFolder(imagePath);
                                final status = await Permission
                                    .manageExternalStorage
                                    .request();
                                print('هل الإذن متاح؟ ${status.isGranted}');

                                print(imagePath);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OpenFileScreen(
                                    folderPath: imagePath,
                                  ),
                                ));
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem<String>(
                                value: AppLocalizations.of(context)!.share,
                                child: Text(
                                  AppLocalizations.of(context)!.share,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: AppLocalizations.of(context)!
                                    .addToFavorites,
                                child: Text(
                                  _favoriteImages.contains(imagePath)
                                      ? AppLocalizations.of(context)!
                                          .removeFromFavorites
                                      : AppLocalizations.of(context)!
                                          .addToFavorites,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: AppLocalizations.of(context)!.openFolder,
                                child: Text(
                                  AppLocalizations.of(context)!.openFolder,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                            color: Colors.white,
                            elevation: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _shareImage(String imagePath) {
    XFile imageFile = XFile(imagePath);

    Share.shareXFiles([imageFile], text: 'مشاركة صورة رائعة!');
  }

  void _toggleFavorite(String imagePath) async {
    setState(() {
      if (_favoriteImages.contains(imagePath)) {
        _favoriteImages.remove(imagePath);
      } else {
        _favoriteImages.add(imagePath);
      }
    });
    await _saveFavoriteImages();
  }

  // void _openFolder(String imagePath) async {
  //   final directory = File(imagePath).parent;
  //   final path = directory.path;
  //   print('فتح المجلد $path');
  // }

  Widget _buildImageCard(String imagePath, String title) {
    final isFavorite = _favoriteImages.contains(imagePath);
    return Container(
      width: 75,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {
                  _showFullImage(imagePath);
                },
                child: Container(
                  width: 70,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 15),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      if (isFavorite) {
                        _favoriteImages.remove(imagePath);
                      } else {
                        _favoriteImages.add(imagePath);
                      }
                    });
                    await _saveFavoriteImages();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8852A8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
