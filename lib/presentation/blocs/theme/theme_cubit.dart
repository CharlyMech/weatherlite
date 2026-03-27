import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/core/theme/app_colors.dart';

class ThemeCubit extends Cubit<ThemeType> {
  ThemeCubit() : super(ThemeType.dark);

  void setTheme(ThemeType type) => emit(type);
}
