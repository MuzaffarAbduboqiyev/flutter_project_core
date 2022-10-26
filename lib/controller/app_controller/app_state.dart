class AppState {
  final bool isDarkMode;

  AppState({
    required this.isDarkMode,
  });

  AppState copyWith({
    bool? isDarkMode,
  }) =>
      AppState(isDarkMode: isDarkMode ?? this.isDarkMode);

  factory AppState.initial() => AppState(
        isDarkMode: true,
      );
}
