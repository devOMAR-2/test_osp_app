import 'dart:io';

class Profile {
  String title;
  String name;
  String position;
  String phoneNumber;
  String email;
  String yourPortfolioSite;
  String profileSummary;

  /// مسار صورة البروفايل (ممكن يكون رابط أو path محلي أو base64 مثلاً)
  File? profileImage;

  Profile({
    this.email = "",
    this.title = "",
    this.name = "",
    this.phoneNumber = "",
    this.position = "",
    this.profileSummary = "",
    this.yourPortfolioSite = "",
    this.profileImage, // الصورة ممكن تكون null
  });
}

class WorkExperience {
  String designation;
  String companyName;
  String startDate;
  String endDate;
  List<String> jobResponsibilities;
  bool isCurrentlyWorking;

  WorkExperience({
    this.designation = '',
    this.companyName = '',
    this.startDate = '',
    this.endDate = '',
    this.isCurrentlyWorking = false,
    required this.jobResponsibilities,
  });
}

class Education {
  String university;
  String startDate;
  String endDate;
  String studyCourse;
  bool isCurrentlyStudying;

  Education({
    this.university = "",
    this.startDate = '',
    this.endDate = '',
    this.studyCourse = '',
    this.isCurrentlyStudying = false,
  });
}

class Projects {
  String projectName;
  String startDate;
  String endDate;
  String description;

  Projects({
    this.projectName = "",
    this.startDate = '',
    this.endDate = '',
    this.description = '',
  });
}

class ResumeModel {
  int id;
  Profile profile;
  List<WorkExperience> workExperience;
  List<Education> education;
  List<Projects> project;
  List<String> skills;
  List<String> abilities;
  List<String> languages;

  /// ✨ cover letter
  String? coverLetter;

  ResumeModel({
    required this.id,
    required this.profile,
    required this.workExperience,
    required this.education,
    required this.project,
    required this.abilities,
    required this.skills,
    required this.languages,
    this.coverLetter,
  });
}
