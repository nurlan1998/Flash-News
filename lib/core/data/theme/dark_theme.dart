part of 'themes.dart';

class DarkTheme {
  DarkTheme._();

  static ThemeData config() {
    final base = ThemeData.dark();
    final isCommissioner = Application.language == 'uz';
    return ThemeData(
      useMaterial3: true,
      fontFamily: isCommissioner ? 'Commissioner' : null,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkDrawerBackground,
        modalBackgroundColor: Colors.black.withOpacity(0.7),
      ),
      cardColor: AppColors.darkCardBackground,
      chipTheme: _buildChipTheme(
        AppColors.blue200,
        AppColors.darkChipBackground,
        Brightness.dark,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.blue200,
        secondary: AppColors.orange300,
        surface: AppColors.black800,
        error: AppColors.red200,
        onPrimary: AppColors.black900,
        onSecondary: AppColors.black900,
        onBackground: AppColors.white50,
        onSurface: AppColors.white50,
        onError: AppColors.black900,
        background: AppColors.black900,
      ),
      textTheme:
          !isCommissioner ? _buildReplyDarkTextTheme(base.textTheme) : null,
      scaffoldBackgroundColor: AppColors.black900,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.darkBottomAppBarBackground,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Color(0xff19191a),
        titleTextStyle: TextStyle(
          color: Colors.white70,
        ),
        contentTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

ChipThemeData _buildChipTheme(
  Color primaryColor,
  Color chipBackground,
  Brightness brightness,
) {
  return ChipThemeData(
    backgroundColor: primaryColor.withOpacity(0.12),
    disabledColor: primaryColor.withOpacity(0.87),
    selectedColor: primaryColor.withOpacity(0.05),
    secondarySelectedColor: chipBackground,
    padding: const EdgeInsets.all(4),
    shape: const StadiumBorder(),
    labelStyle: GoogleFonts.workSansTextTheme().bodyMedium!.copyWith(
          color: brightness == Brightness.dark
              ? AppColors.white50
              : AppColors.black900,
        ),
    secondaryLabelStyle: GoogleFonts.workSansTextTheme().bodyMedium!,
    brightness: brightness,
  );
}

TextTheme _buildReplyDarkTextTheme(TextTheme base) {
  return base.copyWith(
    headlineMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: 0.4,
      height: 0.9,
      color: AppColors.white50,
    ),
    headlineSmall: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 0.27,
      color: AppColors.white50,
    ),
    titleLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.18,
      color: AppColors.white50,
    ),
    titleSmall: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.04,
      color: AppColors.white50,
    ),
    bodyLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: AppColors.white50,
    ),
    bodyMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: -0.05,
      color: AppColors.white50,
    ),
    bodySmall: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: AppColors.white50,
    ),
  );
}
