part of 'themes.dart';

class LightTheme {
  LightTheme._();

  static ThemeData config() {
    final base = ThemeData.light();
    final isCommissioner = Application.language == 'uz';
    return ThemeData(
      useMaterial3: true,
      fontFamily: isCommissioner ? 'Commissioner' : null,
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black.withOpacity(0.7),
        ),
        contentTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.blue700,
        modalBackgroundColor: Colors.white.withOpacity(0.7),
      ),
      cardColor: AppColors.white50,
      chipTheme: _buildChipTheme(
        AppColors.blue700,
        AppColors.lightChipBackground,
        Brightness.light,
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.blue700,
        secondary: AppColors.orange500,
        surface: AppColors.white50,
        error: AppColors.red400,
        onPrimary: AppColors.white50,
        onSecondary: AppColors.black900,
        onBackground: AppColors.black900,
        onSurface: AppColors.black900,
        onError: AppColors.black900,
        background: AppColors.blue50,
      ),
      textTheme:
          !isCommissioner ? _buildReplyLightTextTheme(base.textTheme) : null,
      scaffoldBackgroundColor: AppColors.blue50,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.blue700,
      ),
    );
  }
}

TextTheme _buildReplyLightTextTheme(TextTheme base) {
  return base.copyWith(
    headlineMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: 0.4,
      height: 0.9,
      color: AppColors.black900,
    ),
    headlineSmall: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 0.27,
      color: AppColors.black900,
    ),
    titleLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.18,
      color: AppColors.black900,
    ),
    titleSmall: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.04,
      color: AppColors.black900,
    ),
    bodyLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: AppColors.black900,
    ),
    bodyMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: -0.05,
      color: AppColors.black900,
    ),
    bodySmall: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: AppColors.black900,
    ),
  );
}
